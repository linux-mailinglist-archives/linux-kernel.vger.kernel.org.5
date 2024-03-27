Return-Path: <linux-kernel+bounces-122192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD3188F34C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00FDB218F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF0B15359C;
	Wed, 27 Mar 2024 23:41:48 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77B364AB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582908; cv=none; b=CzzF2J3d4IopRrBn4f9qRvg+6n3DYXdyX+Bboc5iQVk5qZkxZGCcVT85iV97/eDNl93YRDZHBobsgvs9TK7gFYho+nok8R7rrACravibSeDeiT903h5jVxQ9r7stZh/6XrwjHW+jenNKCz1+R9gW92UF+T8wrQvTaPlQYcb5EtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582908; c=relaxed/simple;
	bh=N3E69GqreEebKgQlafzWS5Tn68yX4Mn+rGL9z2zzJ1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WUunDOUtXYHcUD84Ocb0uBuXFAENLDx3iCyNhhJjrY58IU6JV5ShDYv3KbjS89OADJsYhTPhUnvmM9gJcTFOZJp29mGtR9uNCbkgtQqc46elcxV3HOipdsRObSy5XeEyjtFRA5EM0ZtsR6uj7MsU1ye0zZmalN5l1HSIC4fUvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso37421239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711582906; x=1712187706;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlXQwa0ZFnWqKY2f0ssbm6okzE7Tk0I5SucBQUxGMZ4=;
        b=TUomp8FC/d1lq+/gCdh6ifvjr/vKOV1gIRRTzpqX+jPHeo7F8zIE3p/7VIfM7PON/y
         DnrLiIKrfMj34plBbT00+Sk1KpRe/LrWNkEd2Y9brKLy5gxWlswWhUMnmI8vcrkgqWMy
         +yStAHkLmngP4dq+O5WwLf5CMmmPBwRIfJYzPtwEs/eXvTuiEGfU6khewSwOWRkRuFBB
         vekN0a32phNWdqhtd2nGyYzRvhjiUnZsEFjsEhSWJPJZvK68KfbkNXJwrU0LndI6N4a1
         zEX6b23OPrmLoOxXVWYZnnRHVLC/zyJERtD16c9zHASwOotDaqNWSr5AWt8IXCXBLb8V
         0ezA==
X-Gm-Message-State: AOJu0Yyf3xKldq9FIBvlJnpjuvzxc+V2eaQZoSJnYSxybKEBFPxv3wPi
	nfy4A2aKhwf4GZ9SuJUyyqkO4wHadz4nK/CL8BXEsUwUsiIJMctx5fwfQDWVKGwN/6+HT5hfAgl
	HZTdF8jH3ZPAk6uygvtSvdwLfm8WJ2UpW+I5AggCfPe4GP9AKG4/dZUhvMQ==
X-Google-Smtp-Source: AGHT+IHgB5yJZmL3xmxiyeP7FxnTcsa2QOloS/WOiLgSQ0qaS/KcaA8iqQ8y08imEB5Nv8Xk2WiGZUfecyb/1sXl2yx3VpDIj1wx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8904:b0:47e:c0cf:f272 with SMTP id
 jc4-20020a056638890400b0047ec0cff272mr41985jab.4.1711582906267; Wed, 27 Mar
 2024 16:41:46 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:41:46 -0700
In-Reply-To: <0000000000006f876b061478e878@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021caba0614acf349@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
From: syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
Author: martin.lau@linux.dev

On 3/25/24 2:36 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5e74df2f8f15 Merge tag 'x86-urgent-2024-03-24' of git://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=148872a5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15921a6e180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e081f1180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1a82880723a7/disk-5e74df2f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fd3046ac43b9/vmlinux-5e74df2f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2097be59cbc1/bzImage-5e74df2f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
> BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
>   __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
>   dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
>   ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
>   bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
>   ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>   __bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run5+0x16f/0x350 kernel/trace/bpf_trace.c:2423
>   __bpf_trace_ext4_remove_blocks+0x45/0x60 include/trace/events/ext4.h:1984
>   __traceiter_ext4_remove_blocks+0xb5/0x170 include/trace/events/ext4.h:1984
>   trace_ext4_remove_blocks include/trace/events/ext4.h:1984 [inline]
>   ext4_remove_blocks fs/ext4/extents.c:2463 [inline]
>   ext4_ext_rm_leaf fs/ext4/extents.c:2686 [inline]
>   ext4_ext_remove_space+0x4e30/0x7e00 fs/ext4/extents.c:2934
>   ext4_ext_truncate+0x1e3/0x390 fs/ext4/extents.c:4440
>   ext4_truncate+0x14c6/0x1e10 fs/ext4/inode.c:4146
>   ext4_evict_inode+0x1886/0x24d0 fs/ext4/inode.c:258
>   evict+0x3ae/0xa60 fs/inode.c:667
>   iput_final fs/inode.c:1741 [inline]
>   iput+0x9ca/0xe10 fs/inode.c:1767
>   d_delete_notify include/linux/fsnotify.h:307 [inline]
>   vfs_rmdir+0x53c/0x790 fs/namei.c:4222
>   do_rmdir+0x630/0x8b0 fs/namei.c:4268
>   __do_sys_rmdir fs/namei.c:4287 [inline]
>   __se_sys_rmdir fs/namei.c:4285 [inline]
>   __x64_sys_rmdir+0x78/0xb0 fs/namei.c:4285
>   do_syscall_64+0xd5/0x1f0
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Local variable stack created at:
>   __bpf_prog_run256+0x45/0xe0 kernel/bpf/core.c:2237
>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>   __bpf_prog_run include/linux/filter.h:657 [inline]
>   bpf_prog_run include/linux/filter.h:664 [inline]
>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>   bpf_trace_run5+0x16f/0x350 kernel/trace/bpf_trace.c:2423
> 
> CPU: 0 PID: 5017 Comm: syz-executor365 Not tainted 6.8.0-syzkaller-13236-g5e74df2f8f15 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> =====================================================
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/martin.lau/bpf-next.git d8889e866be3


