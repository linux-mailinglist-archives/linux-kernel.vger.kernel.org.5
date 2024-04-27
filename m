Return-Path: <linux-kernel+bounces-160919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1321E8B4488
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF52AB22429
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290640867;
	Sat, 27 Apr 2024 06:30:00 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE163BBF8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714199399; cv=none; b=k9kGsFTkaIilAgFBxK7LxVEUPzg1k6kSUzWwcVwZtOo9hNOGkRWJaAPxmbsjSWLtsSM2Gbpyw5it6+lwF4u1HHfO+w/EfdNJ7qf2T/wHJKRZRU9KTi4d6O9LreH2evR1jZnMhT5Kc3c5+mmuBYw/Be5B0/oIPUlEDKy7/0+7E40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714199399; c=relaxed/simple;
	bh=i4HN5zq4f1V4J13/jsElv8KRel0oE49ZwJBAuLiUVu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdGpDimqJFzBeVYMtApoSk7NU8fW4FwsUhglmaoxjFs1+voaTI/HXmymIW1jMNP8ZE4uxqyFLYuXN4jrW3fy2OoZ2n9B9IWeZtnpGHRcvlNluzHhbgqGFpRzcezXl8zLA9SnOWBsOTvgOfJvK8eCb27UJOgwMJkSGsY11NDO3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.155])
	by sina.com (172.16.235.25) with ESMTP
	id 662C9B5300007B25; Sat, 27 Apr 2024 14:29:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 77753834209983
X-SMAIL-UIID: 321C4BAB486745F28D299C10446BE23B-20240427-142942-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sat, 27 Apr 2024 14:29:43 +0800
Message-Id: <20240427062943.3685-1-hdanton@sina.com>
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Apr 2024 05:00:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12499380980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  e33c4963bf53

--- x/fs/open.c
+++ y/fs/open.c
@@ -952,7 +952,9 @@ static int do_dentry_open(struct file *f
 	if (!open)
 		open = f->f_op->open;
 	if (open) {
+		ihold(inode);
 		error = open(inode, f);
+		iput(inode);
 		if (error)
 			goto cleanup_all;
 	}
--

