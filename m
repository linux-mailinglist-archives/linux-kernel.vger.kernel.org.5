Return-Path: <linux-kernel+bounces-101485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A415287A7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A50F1F2440C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6C21E890;
	Wed, 13 Mar 2024 12:42:24 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F222085
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333744; cv=none; b=m6C8i0dUGFiqqYcJAftPAGWJfrORI3zs1xaPyKyQbsWSB00pikYlGTbY8+i2VZz5oW9hPrFTGqzaGh5xDIQXIXAnlXPwoSJSJqMYT9HqT03FUOgRehftN0+KNWTttHW+u+yYHyC2ML16A7Va7Dpsx1AoAOoO/Zzo+4ERZVUKrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333744; c=relaxed/simple;
	bh=1868kfZcf8kpNGfyqVDZLMrLqLKLx3EyoaZF5iF0y2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjW+zbpZ3tKyRMY+KN2VS+l9Niy0uEHn2iaecwIlgXtUq8BaoNj72oT0OqU3cqGWJIcf7KK+NRmtdquQpuwo8bqpzktYXBaHmX5dhw/gHolDbqUQmdTRrC+OV9UDudlZDvW8ieivIJVwF49WTtmYw0Dof/fsUQqRO9kcFLL/B9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.180])
	by sina.com (172.16.235.25) with ESMTP
	id 65F19F240000188F; Wed, 13 Mar 2024 20:42:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46991534210354
X-SMAIL-UIID: 0A3F0EC70548414DB66DA166A952840F-20240313-204216-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9b5ec5ccf7234cc6cb86@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
Date: Wed, 13 Mar 2024 20:42:04 +0800
Message-Id: <20240313124204.2356-1-hdanton@sina.com>
In-Reply-To: <0000000000003ea6ba0613882a96@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Mar 2024 03:23:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    0f1a876682f0 Merge tag 'vfs-6.9.uuid' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116b38d1180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/libfs.c
+++ y/fs/libfs.c
@@ -2012,6 +2012,8 @@ static struct dentry *prepare_anon_dentr
 	dentry = d_alloc_anon(sb);
 	if (!dentry)
 		return ERR_PTR(-ENOMEM);
+	/* Store address of location where dentry's supposed to be stashed. */
+	dentry->d_fsdata = stashed;
 
 	inode = new_inode_pseudo(sb);
 	if (!inode) {
@@ -2029,9 +2031,6 @@ static struct dentry *prepare_anon_dentr
 	WARN_ON_ONCE(!S_ISREG(inode->i_mode));
 	WARN_ON_ONCE(!IS_IMMUTABLE(inode));
 
-	/* Store address of location where dentry's supposed to be stashed. */
-	dentry->d_fsdata = stashed;
-
 	/* @data is now owned by the fs */
 	d_instantiate(dentry, inode);
 	return dentry;
--

