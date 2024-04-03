Return-Path: <linux-kernel+bounces-129869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6EB897171
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB66B1C263A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB11487C4;
	Wed,  3 Apr 2024 13:45:23 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5D14882F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151923; cv=none; b=E33b/uEaI4LcJhLQbCzbXZiP3vLufWZcZZaqN7v2IN4+XOf3z8GVpQlCsX0XHA0g1ACr0DHs2QL07bgbJtncV5pFPbARHVZZOA3Sr9IXuBFyAQOnVk6/pQiNF0RUyOSbyXbuZaggxS7BG6viaolA3uzN1El4YWPydNRqQ4RWKq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151923; c=relaxed/simple;
	bh=O07xnjRsa7k7EJrY+kYBTnDqh8XuCQVYPFppMb3MoMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUbGk9butQEHLhwAOOKylbuVFRX8Z9Dpux4ebw2XkdAb3RhVejqCGAyl7arsSjFdF7JYDi22li/169g+5vWmuuIsIxxnEcKrsIu50y4DFFUoOo6xAbtJPscgFy2NqhEG2B6U5QBAGbXAFPpdx7lKyEs0qKTMaLfJKbNXZYAZ7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.100])
	by sina.com (10.75.12.45) with ESMTP
	id 660D5D5F000015E2; Wed, 3 Apr 2024 21:45:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 89214631458053
X-SMAIL-UIID: 77D3CE8F15604429B8820C1A6E712938-20240403-214509-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
Date: Wed,  3 Apr 2024 21:44:54 +0800
Message-Id: <20240403134454.3792-1-hdanton@sina.com>
In-Reply-To: <000000000000163e1406152c6877@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 03 Apr 2024 00:45:29 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140d9db1180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/fs/ext4/inode.c
+++ y/fs/ext4/inode.c
@@ -5414,6 +5414,7 @@ int ext4_setattr(struct mnt_idmap *idmap
 					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
 					inode->i_sb->s_blocksize_bits);
 
+			down_read(&EXT4_I(inode)->xattr_sem);
 			down_write(&EXT4_I(inode)->i_data_sem);
 			old_disksize = EXT4_I(inode)->i_disksize;
 			EXT4_I(inode)->i_disksize = attr->ia_size;
@@ -5430,6 +5431,7 @@ int ext4_setattr(struct mnt_idmap *idmap
 			else
 				EXT4_I(inode)->i_disksize = old_disksize;
 			up_write(&EXT4_I(inode)->i_data_sem);
+			up_read(&EXT4_I(inode)->xattr_sem);
 			ext4_journal_stop(handle);
 			if (error)
 				goto out_mmap_sem;
--

