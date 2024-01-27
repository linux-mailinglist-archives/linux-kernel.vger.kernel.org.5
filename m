Return-Path: <linux-kernel+bounces-41179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C190183ECF7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D681F22517
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEB8200D6;
	Sat, 27 Jan 2024 11:46:35 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EF11CA9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706355995; cv=none; b=c/0IFvsJU00okJWPBjepBzPW7pJUxXsjvXVmxh0V4kl3cdsalBBJLPfqmD6x7iOERCl4BJEpwF7ZRPUJMLi0Nbt4CAKJ6+l6o3w/YOQzGJo7L4RClYo30Tzf0b7g/P1Og3KE3GKwfaQmkJtIP/v6qwMhAoSb3KYMwBMl6CnB7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706355995; c=relaxed/simple;
	bh=p6/PrU8i4vruaCpaw3PnfBcpBDW/+70iWo9XrOwAEyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lb05vcwPfW+dweBZKjdd+Ipr9zJHpqnscKdoAO93M0YJeHgwnAsgZn4seh26nDo/+BJqw9xqklyzG5JpUX/0/kg79PK6e/lumjU8wgYr0xHJJnKdb1oFOJFZPoooMFuURmaRsYaOIwlk+NurskWUoR1o2PWS6C1FBi75Y0ctJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.6])
	by sina.com (10.75.12.45) with ESMTP
	id 65B4ED0800009934; Sat, 27 Jan 2024 19:46:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 15807531457944
X-SMAIL-UIID: 8822F8609A034D77A37EB2C906C40B34-20240127-194619-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
Date: Sat, 27 Jan 2024 19:46:10 +0800
Message-Id: <20240127114610.961-1-hdanton@sina.com>
In-Reply-To: <0000000000008efd70060ce21487@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 11:43:27 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154aa8d6e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  2cf4f94d8e86

--- x/fs/namei.c
+++ y/fs/namei.c
@@ -3533,6 +3533,8 @@ static const char *open_last_lookups(str
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
+		if (!got_write && (open_flag & O_CREAT))
+			return ERR_PTR(-EISDIR);
 		/*
 		 * do _not_ fail yet - we might not need that or fail with
 		 * a different error; let lookup_open() decide; we'll be
--

