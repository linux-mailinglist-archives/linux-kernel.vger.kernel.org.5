Return-Path: <linux-kernel+bounces-74588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A9E85D670
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8780A1F244B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD73F8CD;
	Wed, 21 Feb 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrERzZLO"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D113A8DD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513540; cv=none; b=lCz/fxtfljJc4O0EtolClnZYTiAJnQPYevuk8wvMUyLuZvYrAw88eMbohjHpnVCbpORZ5dClQ9QnlOvdYW6+FFUJ0v7iJj35BGxPNmVvZZAPpm2eoFhsH9u/ZYaGpCUsz+kQQ61ppFuB/+LIRoGp8hF6w80nQOVP5IiKpOk2F0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513540; c=relaxed/simple;
	bh=RruUcEIpK2/Ax5dXxnTzHAJ9C77VNBsQ6MERgkvOSco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIioXuws6baF0aK+TtryV5A2wy/YJoORHC4H9CpTQqMJonA4/G2rTTjFn+91Z5mSbLk+UHuj5ot0FQe3K68fsZZ/irULBKIz1G6YPChuV3ATV1cUkK79nB6//sgTSUkcb2mS+wF2/PoQxNio2mQz45Q7R430a+B4BF+B39p2SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrERzZLO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso6793a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513535; x=1709118335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/6GefODGvwQySIO68Fu5TfRdRDs+C2ZSKgPvEBAnzY=;
        b=GrERzZLOs3AJ8GDb7uVbFPH4owzqP5/NXIorihIyhWHS9ZJqxk2KHwAhHUlkpBKNv7
         UZvPAZbVLAy+y+rbOM4dwrc8oMvQMIeDH1EYLsrCAtIyhvpXs2+ziUTUfW/L9Hh4fk5d
         yaqFW2V9d6ydkOOtIb4GdDy4FvnwUpUDKGyIQ0ZIMfpFKkCFbF92LBeDgr8sC6VMfGJQ
         lPZKkCTh7ryMpoN17IoTPwhcEfwjO93J05L2CStPLqoGu69Hm86nH8DH4d3ZWuOkxIk8
         gFNg0LyhqYcrzu8hFRh3QcEqnIRVFnX1vrQOjUXa+bEX3a2vaAtq8GS3gcjt7NhQA8bu
         u+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513535; x=1709118335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/6GefODGvwQySIO68Fu5TfRdRDs+C2ZSKgPvEBAnzY=;
        b=EAyFdmBSpUCoscKxcPgyDFj1QY6NE9sm+NK5AFjDQfxqQ/bzyhL/bd36QPnRykjJTR
         OMJit6t48SVonnAXOUvYGCnVswSS0Cb7meg+/vmKoAWUzLfHJjgDfzF3FuI4r2N/H8ze
         /i8dw9vO1mUqpo8BeNO2W6+0kuvh/jI01T9v+0ZLUDLACQYiZl1zJVtVm5j6UH5rfqN5
         irvj8YpbM6sUHiX9XQ53dEgvK1Yu3lSuabtY/udKyORvPlxnjifjkY+W7KGNvPnIBOHB
         79a7XW5NhbvKcVaJbh0ifoL8ckI0UpGu40h2wr6T7bmAKwcFt5lcuEjIXo3P0BaSQv7F
         mEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwnGxyPcCFDfAlbAm9ln/53gpJx6upbb1fw/Tf4MkndijtRQXr9uQEVwounMuDap13R1V1G1fOKcmN8TxlUQ6iqmFfJKe+M6IQl4dW
X-Gm-Message-State: AOJu0YxxUcEgkXqQtpuWsXzB+p3rqYQQAZ2S6Y3KlwHYa+YsWxNsRFSy
	q3SA8Cg5qSvAvb83CqcEAae/GKph/Xiq90R2fPo/1iKYEW+es19ztErREdfa7PQ11ikQc1qTjSA
	Jpb+/QgNXaipikopELE216agpvrAl3EOjwDsE
X-Google-Smtp-Source: AGHT+IEy1Y8+W5ES5vlgIxbupn8pQCtJwydqzUVY8p+lFghU37g4IvSY58XllN6dkUIBlEFY6qKLvdRoHK2DtL25IhY=
X-Received: by 2002:a50:a408:0:b0:565:123a:ccec with SMTP id
 u8-20020a50a408000000b00565123accecmr28332edb.3.1708513535078; Wed, 21 Feb
 2024 03:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000a4a7550611e234f5@google.com>
In-Reply-To: <000000000000a4a7550611e234f5@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 12:05:21 +0100
Message-ID: <CANn89iJqC776G8sNMq6ZWtqpz8LhoryLn03UhbBLy750533Umg@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in handle_tx (2)
To: syzbot <syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:58=E2=80=AFAM syzbot
<syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c1ca10ceffbb Merge tag 'scsi-fixes' of git://git.kernel.o=
r..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D106d709c18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2b39994d6ba6d=
dc6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D827272712bd6d12=
c79a4
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
bc7510fe41f/non_bootable_disk-c1ca10ce.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e748a043cf14/vmlinu=
x-c1ca10ce.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/60a25923a46c/b=
zImage-c1ca10ce.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in handle_tx+0x5a5/0x630 drivers/net/caif=
/caif_serial.c:236
> Read of size 8 at addr ffff88802fe23020 by task aoe_tx0/1350
>
> CPU: 0 PID: 1350 Comm: aoe_tx0 Not tainted 6.8.0-rc4-syzkaller-00331-gc1c=
a10ceffbb #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:488
>  kasan_report+0xda/0x110 mm/kasan/report.c:601
>  handle_tx+0x5a5/0x630 drivers/net/caif/caif_serial.c:236
>  __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5003 [inline]
>  xmit_one net/core/dev.c:3547 [inline]
>  dev_hard_start_xmit+0x13a/0x6d0 net/core/dev.c:3563
>  __dev_queue_xmit+0x7b6/0x3ee0 net/core/dev.c:4351
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  tx+0x76/0x100 drivers/block/aoe/aoenet.c:62
>  kthread+0x1e9/0x3c0 drivers/block/aoe/aoecmd.c:1229
>  kthread+0x2c6/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
>
> Allocated by task 4932:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:389
>  kmalloc include/linux/slab.h:590 [inline]
>  kzalloc include/linux/slab.h:711 [inline]
>  alloc_tty_struct+0x98/0x8d0 drivers/tty/tty_io.c:3116
>  tty_init_dev.part.0+0x1e/0x660 drivers/tty/tty_io.c:1415
>  tty_init_dev include/linux/err.h:61 [inline]
>  tty_open_by_driver drivers/tty/tty_io.c:2088 [inline]
>  tty_open+0xb2d/0x1020 drivers/tty/tty_io.c:2135
>  chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
>  do_dentry_open+0x8da/0x18c0 fs/open.c:953
>  do_open fs/namei.c:3641 [inline]
>  path_openat+0x1e00/0x29a0 fs/namei.c:3798
>  do_filp_open+0x1de/0x440 fs/namei.c:3825
>  do_sys_openat2+0x17a/0x1e0 fs/open.c:1404
>  do_sys_open fs/open.c:1419 [inline]
>  __do_sys_openat fs/open.c:1435 [inline]
>  __se_sys_openat fs/open.c:1430 [inline]
>  __x64_sys_openat+0x175/0x210 fs/open.c:1430
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
>
> Freed by task 23:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
>  poison_slab_object mm/kasan/common.c:241 [inline]
>  __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2121 [inline]
>  slab_free mm/slub.c:4299 [inline]
>  kfree+0x124/0x370 mm/slub.c:4409
>  process_one_work+0x889/0x15e0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x12a0 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>
> Last potentially related work creation:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xba/0x110 mm/kasan/generic.c:586
>  insert_work+0x38/0x230 kernel/workqueue.c:1653
>  __queue_work+0x62e/0x11d0 kernel/workqueue.c:1802
>  queue_work_on+0xf4/0x120 kernel/workqueue.c:1837
>  kref_put include/linux/kref.h:65 [inline]
>  tty_kref_put drivers/tty/tty_io.c:1572 [inline]
>  tty_kref_put drivers/tty/tty_io.c:1569 [inline]
>  release_tty+0x4e1/0x600 drivers/tty/tty_io.c:1608
>  tty_release_struct+0xb7/0xe0 drivers/tty/tty_io.c:1707
>  tty_release+0xe33/0x1420 drivers/tty/tty_io.c:1867
>  __fput+0x270/0xb80 fs/file_table.c:376
>  task_work_run+0x14f/0x250 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa8a/0x2ad0 kernel/exit.c:871
>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
>  get_signal+0x23b9/0x2790 kernel/signal.c:2893
>  arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
>  syscall_exit_to_user_mode+0x156/0x2b0 kernel/entry/common.c:212
>  do_syscall_64+0xe5/0x270 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
>
> The buggy address belongs to the object at ffff88802fe23000
>  which belongs to the cache kmalloc-cg-2k of size 2048
> The buggy address is located 32 bytes inside of
>  freed 2048-byte region [ffff88802fe23000, ffff88802fe23800)
>
> The buggy address belongs to the physical page:
> page:ffffea0000bf8800 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0xffff88802fe24000 pfn:0x2fe20
> head:ffffea0000bf8800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
> memcg:ffff888036434cc1
> flags: 0xfff00000000a40(workingset|slab|head|node=3D0|zone=3D1|lastcpupid=
=3D0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000a40 ffff888014c50140 ffffea0000985610 ffffea0000976210
> raw: ffff88802fe24000 0000000000080005 00000001ffffffff ffff888036434cc1
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0=
(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|_=
_GFP_HARDWALL), pid 5214, tgid 5214 (syz-executor.0), ts 874094238940, free=
_ts 873944713923
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
>  prep_new_page mm/page_alloc.c:1540 [inline]
>  get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
>  __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
>  __alloc_pages_node include/linux/gfp.h:238 [inline]
>  alloc_pages_node include/linux/gfp.h:261 [inline]
>  alloc_slab_page mm/slub.c:2190 [inline]
>  allocate_slab mm/slub.c:2354 [inline]
>  new_slab+0xcc/0x3a0 mm/slub.c:2407
>  ___slab_alloc+0x4af/0x19a0 mm/slub.c:3540
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3625
>  __slab_alloc_node mm/slub.c:3678 [inline]
>  slab_alloc_node mm/slub.c:3850 [inline]
>  __do_kmalloc_node mm/slub.c:3980 [inline]
>  __kmalloc_node+0x361/0x470 mm/slub.c:3988
>  kmalloc_node include/linux/slab.h:610 [inline]
>  kvmalloc_node+0x9d/0x1a0 mm/util.c:617
>  kvmalloc include/linux/slab.h:728 [inline]
>  kvmalloc_array include/linux/slab.h:746 [inline]
>  alloc_fdtable+0xef/0x290 fs/file.c:136
>  dup_fd+0x77d/0xc70 fs/file.c:354
>  copy_files kernel/fork.c:1789 [inline]
>  copy_process+0x2851/0x97b0 kernel/fork.c:2485
>  kernel_clone+0xfd/0x930 kernel/fork.c:2902
>  __do_sys_clone+0xba/0x100 kernel/fork.c:3045
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> page last free pid 4901 tgid 4900 stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1140 [inline]
>  free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
>  free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
>  __put_partials+0x14c/0x170 mm/slub.c:2922
>  qlink_free mm/kasan/quarantine.c:160 [inline]
>  qlist_free_all+0x58/0x150 mm/kasan/quarantine.c:176
>  kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:283
>  __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:324
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3813 [inline]
>  slab_alloc_node mm/slub.c:3860 [inline]
>  kmem_cache_alloc_lru+0x142/0x700 mm/slub.c:3879
>  alloc_inode_sb include/linux/fs.h:3016 [inline]
>  alloc_inode+0xba/0x230 fs/inode.c:262
>  new_inode_pseudo+0x16/0x80 fs/inode.c:1005
>  get_pipe_inode fs/pipe.c:891 [inline]
>  create_pipe_files+0x4c/0x7f0 fs/pipe.c:931
>  __do_pipe_flags fs/pipe.c:980 [inline]
>  do_pipe2+0xb0/0x1d0 fs/pipe.c:1031
>  __do_sys_pipe2 fs/pipe.c:1049 [inline]
>  __se_sys_pipe2 fs/pipe.c:1047 [inline]
>  __x64_sys_pipe2+0x54/0x80 fs/pipe.c:1047
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
>
> Memory state around the buggy address:
>  ffff88802fe22f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88802fe22f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88802fe23000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                ^
>  ffff88802fe23080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88802fe23100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

drivers/block/aoe/aoenet.c does not hold references to skb->dev,
this means the device can disappear.

This code seems obsolete/unmained, but a quick fix would be

diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index c51ea95bc2ce41f6260302f5efe914d3e12e1d98..13fe344b5fb908b5f0bb0deff05=
4d409464bbe7e
100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -59,6 +59,7 @@ tx(int id) __must_hold(&txlock)
        while ((skb =3D skb_dequeue(&skbtxq))) {
                spin_unlock_irq(&txlock);
                ifp =3D skb->dev;
+               dev_put(ifp);
                if (dev_queue_xmit(skb) =3D=3D NET_XMIT_DROP && net_ratelim=
it())
                        pr_warn("aoe: packet could not be sent on %s.  %s\n=
",
                                ifp ? ifp->name : "netif",
@@ -117,6 +118,7 @@ aoenet_xmit(struct sk_buff_head *queue)
        skb_queue_walk_safe(queue, skb, tmp) {
                __skb_unlink(skb, queue);
                spin_lock_irqsave(&txlock, flags);
+               dev_hold(skb->dev);
                skb_queue_tail(&skbtxq, skb);
                spin_unlock_irqrestore(&txlock, flags);
                wake_up(&txwq);

