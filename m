Return-Path: <linux-kernel+bounces-160867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C330A8B43BD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E641C21C44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9E38DEC;
	Sat, 27 Apr 2024 02:06:25 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B7381AA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714183585; cv=none; b=OeK65V5yimXrO/nis2S/ParDRE+ZsnLPx9qKWPSTk0D+QOnnzBfI5au87RubsSGG4IQLpi2FOvHTQUIi1Q1rk8g6Ob4gKWMF/YM4YVKltB/ZCuctEPNGyPIFfzMzvr0mEmHIBmcrCz30SjKr3Ip0s73N7onLLmsQUaNy+oBa4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714183585; c=relaxed/simple;
	bh=BDX0DMYayhbQWYlWwLYIqDlKTvcAwxEAQZfFRxP9Tu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVaYu3KbVH0MBctIaGQcifrElcGBRtgvR6H7SdaQFTh6Zc7H5EvdO8ahu4MTaHHY87zHEzp3/f3dXl9MNIdb0ZZwiSlTCDxQoXJdLXc+ubeWai98e73F143mAA3irn4LNFJLsS3rPyCKWz3mgH8d7sigYhu5EVjsEoxaH+g+XLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.155])
	by sina.com (172.16.235.24) with ESMTP
	id 662C5D9400007B69; Sat, 27 Apr 2024 10:06:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 25800245089264
X-SMAIL-UIID: C03A436B7BDF41AA9F4264E2D8B43439-20240427-100614-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
Date: Sat, 27 Apr 2024 10:06:15 +0800
Message-Id: <20240427020615.3615-1-hdanton@sina.com>
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

--- x/fs/namei.c
+++ y/fs/namei.c
@@ -3795,8 +3795,11 @@ static struct file *path_openat(struct n
 		while (!(error = link_path_walk(s, nd)) &&
 		       (s = open_last_lookups(nd, file, op)) != NULL)
 			;
-		if (!error)
+		if (!error) {
+			path_get(&nd->path);
 			error = do_open(nd, file, op);
+			path_put(&nd->path);
+		}
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
--

