Return-Path: <linux-kernel+bounces-140354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837F38A1339
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E0FB23D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D847149C7E;
	Thu, 11 Apr 2024 11:40:02 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84E14A0A5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835601; cv=none; b=oE5UbK3YPlYmTMLgtLzlhnGFtDaMzxiX2I5anC8Kw8PaEkLAxQXRfajNNwMplaxx3ri9nGobWO/G9kKS2vYUUL1EAQX4ag/0ZFbAGR4jQ3UmQJBVmtzUScOT5sfmNRmb5Lak71PkjI8o3qEXLE7ZFYRTOAISnOC3C+pzSymPVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835601; c=relaxed/simple;
	bh=UHPLsaptqz43LERO+7imPmRq1/ARo3gKwp4GeKn3oc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWRuujmtFS/1HYuRtgTJP8sUym2RAZ5ACUiEBPg8J8DCDbV/CUCCSkszyx6ouGris0dVduduWHWDdEiqB02e0ATaorqnglfAvJClMRf1ufQtkwUBipO0TL8/ROsL0+sBhWI8XGOwuJdyIqC+mJRlyeO90UGDnNPRetL8+PM2wYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.59])
	by sina.com (172.16.235.24) with ESMTP
	id 6617CBFF000069A3; Thu, 11 Apr 2024 19:39:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 62641945089148
X-SMAIL-UIID: 558294FA17304C8BBD1A93ABE916873F-20240411-193946-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3ca210b2c10e57015b3c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_update_ref (3)
Date: Thu, 11 Apr 2024 19:39:39 +0800
Message-Id: <20240411113939.749-1-hdanton@sina.com>
In-Reply-To: <0000000000009adc640615cf0ef7@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 02:48:27 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    f2f80ac80987 Merge tag 'nfsd-6.9-2' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1614c105180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  f2f80ac80987

--- x/fs/ext4/xattr.c
+++ y/fs/ext4/xattr.c
@@ -119,11 +119,12 @@ ext4_expand_inode_array(struct ext4_xatt
 			struct inode *inode);
 
 #ifdef CONFIG_LOCKDEP
+static struct lock_class_key ea_i_rwsem_key;
 void ext4_xattr_inode_set_class(struct inode *ea_inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(ea_inode);
 
-	lockdep_set_subclass(&ea_inode->i_rwsem, 1);
+	lockdep_set_class(&ea_inode->i_rwsem, &ea_i_rwsem_key);
 	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */
 	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
 }
--

