Return-Path: <linux-kernel+bounces-25951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE8182D8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B901C219E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3A72C698;
	Mon, 15 Jan 2024 12:06:34 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C21E867
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.116.10])
	by sina.com (172.16.235.25) with ESMTP
	id 65A51F9900001FD2; Mon, 15 Jan 2024 20:05:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 34782034210327
X-SMAIL-UIID: 754D622253F1446BB3F950B09A81D287-20240115-200548-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in f2fs_filemap_fault
Date: Mon, 15 Jan 2024 20:05:35 +0800
Message-Id: <20240115120535.850-1-hdanton@sina.com>
In-Reply-To: <0000000000000b4e27060ef8694c@google.com>
References: <0000000000000b4e27060ef8694c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 01:12:17 -0800
> HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1422d5ebe80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/f2fs/file.c
+++ y/fs/f2fs/file.c
@@ -39,6 +39,7 @@
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	vm_flags_t flags = vmf->vma->vm_flags;
 	vm_fault_t ret;
 
 	ret = filemap_fault(vmf);
@@ -46,7 +47,7 @@ static vm_fault_t f2fs_filemap_fault(str
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
 					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
 
-	trace_f2fs_filemap_fault(inode, vmf->pgoff, vmf->vma->vm_flags, ret);
+	trace_f2fs_filemap_fault(inode, vmf->pgoff, flags, ret);
 
 	return ret;
 }
--

