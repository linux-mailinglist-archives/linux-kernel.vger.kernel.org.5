Return-Path: <linux-kernel+bounces-42177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F983FD76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FDFB22F68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7149441C93;
	Mon, 29 Jan 2024 05:08:06 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADD335CC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706504886; cv=none; b=D2hdqikOcL3Z40QoSL4xlVPGoq9ai1s95C3evMnMtqd54E14i+2E3OkRB0hzwulXF6EABMTuzFuSQ8pdC5WIiD/3W7thcTu+EaBmndHGb6zI+JrGUNBt9gODfMdpakKA/BphM30MmozGSGgIJn6VLYofCejSXBkDlzlUEa6SFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706504886; c=relaxed/simple;
	bh=i0IQCh6o0xdt0om92jW6gIk0NFwCoQpjaGyNJqppFyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OLihTCwPtwgEuybi9tk6FtIyrHtwd7JQOhJLOABwMljcRINAWTsz4knHXG/aSjg/gUPvmW2ECgGs0zuhfaMW+iVMqcOX68qe5XgF49pKS0ciNIiFtzqMA7xbaiEeuyl2Eot1EOptmOALJj1iIeYsfPlgLh5dyMBXYo85u0m2GO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.153])
	by sina.com (172.16.235.25) with ESMTP
	id 65B732A6000007B4; Mon, 29 Jan 2024 13:07:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 77711334210205
X-SMAIL-UIID: 5876B911FDAA459388955DD1AD8FC127-20240129-130752-1
From: Hillf Danton <hdanton@sina.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
Date: Mon, 29 Jan 2024 13:07:45 +0800
Message-Id: <20240129050745.1271-1-hdanton@sina.com>
In-Reply-To: <20240128214335.GE2087318@ZenIV>
References: <0000000000008efd70060ce21487@google.com> <20240127114610.961-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jan 2024 21:43:35 +0000 Al Viro <viro@zeniv.linux.org.uk>
> On Sat, Jan 27, 2024 at 07:46:10PM +0800, Hillf Danton wrote:
> > On Tue, 19 Dec 2023 11:43:27 -0800
> > > syzbot has found a reproducer for the following issue on:
> > > 
> > > HEAD commit:    2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
> > > git tree:       upstream
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154aa8d6e80000
> > 
> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  2cf4f94d8e86
> > 
> > --- x/fs/namei.c
> > +++ y/fs/namei.c
> > @@ -3533,6 +3533,8 @@ static const char *open_last_lookups(str
> >  
> >  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> >  		got_write = !mnt_want_write(nd->path.mnt);
> > +		if (!got_write && (open_flag & O_CREAT))
> > +			return ERR_PTR(-EISDIR);
> 
> NAK.

Thanks for looking at it, the AV legend.
> 
> Please, RTFComment just below your addition.

That is a simple debug patch to test why mnt_want_write() is needed in
ovl_create_object() as per the syzbot report [1], given the locking
order in open_last_lookups() in case of O_CREAT.

	mnt_want_write();
	inode_lock();

> Besides, EISDIR is
> obviously bogus in a lot of cases, starting with attempting to
> create a new file on a read-only filesystem.

EISDIR should have been replaced with EDEADLOCK.

	-> #3
	 (sb_writers#4){.+.+}-{0:0}:
	       lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
	       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
	       __sb_start_write include/linux/fs.h:1635 [inline]
	       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1710
	       mnt_want_write+0x3f/0x90 fs/namespace.c:404
	       ovl_create_object+0x13b/0x360 fs/overlayfs/dir.c:629
	       lookup_open fs/namei.c:3477 [inline]
	       open_last_lookups fs/namei.c:3546 [inline]
	       path_openat+0x13fa/0x3290 fs/namei.c:3776
	       do_filp_open+0x234/0x490 fs/namei.c:3809
	       do_sys_openat2+0x13e/0x1d0 fs/open.c:1437
	       do_sys_open fs/open.c:1452 [inline]
	       __do_sys_open fs/open.c:1460 [inline]
	       __se_sys_open fs/open.c:1456 [inline]
	       __x64_sys_open+0x225/0x270 fs/open.c:1456
	       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
	       do_syscall_64+0x45/0x110 arch/x86/entry/common.c:83
	       entry_SYSCALL_64_after_hwframe+0x63/0x6b

[1] https://lore.kernel.org/lkml/0000000000008efd70060ce21487@google.com/

