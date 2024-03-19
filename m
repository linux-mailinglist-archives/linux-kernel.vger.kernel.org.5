Return-Path: <linux-kernel+bounces-107905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD0880356
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2338F284908
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867F22092;
	Tue, 19 Mar 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtVTzqzX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA423772
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869077; cv=none; b=GXHFbPx2VoAho5Twe8QiaREb76FQoxizYcc89RddgAE2qqLL7ARUze8B4PXE0Tpy4RUo09COFGqnaayN2ZsjNayw4NHDD1A/ygr1IZ+v1GMytNcxOUDLI021bdeJgpihYtNLv3q2y5xbR3HPcCYsP9GY15/Zu4S72ZubbSgA8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869077; c=relaxed/simple;
	bh=Vq/wZ2e2Jr9W6zrqpfGukA584D5ffnkoGcNtquwdxoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd4h5hnOKKMyywIyNqqWLFJucA4mqRrIX8ISNjshZ0nDh4F5mSzg9sOFXOqc0+Z7E65vixDXAKSmR5oA4OznbABtozRa0w02nHPCkGU874e+Lgj8v4GpQS7tC2DpY3c2K8qFlJfQ5+iwCuvhbXk7Q0JiN4/x/XO++WsXlwQR4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtVTzqzX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512f3e75391so4617879e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710869073; x=1711473873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=931usQMANtA8mc+CkGsMWLRLBHVdxufBewOW8kpntOQ=;
        b=RtVTzqzXdHX8itqkSH1wFgjYtlVGcaUbAho9WboZPZFUCfL+2w3T6bB/pIftKoIqyS
         T6MY4Qr2p9xtl/cFcVdZtHoWhOBba3XFWr6OvO1Nwcx6WmfF0Jwdfd6ft2Dny0B8/KWJ
         ZzezILSUYMffDJdinJn0TQaCYz4wp4TptEk47fQqvtvJEEjIOZItDK6AByAx8Z/603v7
         +AqtrMPmLRr6EQ/Y+2Y8SqUrVGAUMp4BhKusrtTS1xSp0pDyDpdgl27DUGUQNfSzKrCD
         CjF9CCdiCVw1TXWEkLtAO7G8GQUAmw3lF8EuLetO0RHINa1WdPWopnCKyxI2EPDl/0bv
         S6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869073; x=1711473873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=931usQMANtA8mc+CkGsMWLRLBHVdxufBewOW8kpntOQ=;
        b=NqyKZvxHsbdO+pSR9z50y3/KsGw8x1n0Wt196z68f0sLBj9vCfWtvyFwvAR6vNWooo
         Nn9FjDbf8MwFeA1L69sM8YTCWkgPjaUhLPyVPcHYilJ8x0WR+EUW0pjtTfWokity1X7v
         a6a7WozueXsQxhBEUtKWDy26mXqQRXnsRstPtMayFkXqqd9vIvmfzfTl4Uy+Eq8r2fzJ
         2T7z1lOP3Jkh1Atp2FP+i5YKxMT5vuGL+WZW1WThGTEcMPYVplWO6lfLrsE1AEc20Z7Z
         qKiyhANpP8K7O4rmjYlj+VQjPNZrprnQUc7VHMaSnYjx6P0HR2fqdO5EH2qLW8s2jUub
         vr9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJeRBWo82mYvZ4e2fT6Ccm3ub7ls9fz+jrSQAJzOoXqv9Ft1AH3C3UNXM1n4tAZC9nezouUZpbHCyD7ki4sOGpP1XN09WpnT59EbBq
X-Gm-Message-State: AOJu0YwoWCvnn2nBrawxkhDWn24ubsm8BgJKrakYhJ9ZXfKPfaSdazGP
	9O3PIYbsNZTo+v48u0KW/77/Zyq5K3BgKjT9Dd0pLBJcPtg0lXPQA8/TXZ1mV6G3JLOJHC6dng3
	bLeYiy6F6EFWU/czoxdNJNR48bo8MlsK7ZmFI
X-Google-Smtp-Source: AGHT+IFo2TtSZPZuLnkj1tMjvn6g7EnzYXBWTOsR07hm4EyRVhgBVnitCvPmxvFvhbbg8S2ZupVM/Q6pqVNqiyIzEHw=
X-Received: by 2002:ac2:4903:0:b0:513:cf12:2db3 with SMTP id
 n3-20020ac24903000000b00513cf122db3mr2103895lfi.61.1710869073113; Tue, 19 Mar
 2024 10:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e97f090614006d76@google.com> <b2a158a7-e0f1-42dc-9620-1d1d511d566f@redhat.com>
In-Reply-To: <b2a158a7-e0f1-42dc-9620-1d1d511d566f@redhat.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 19 Mar 2024 10:24:20 -0700
Message-ID: <CA+EESO7zV9+yh-M23L_-e5SFUMptSoucBqOWvhoD_yVY4kXK5w@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in move_pages
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:37=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 19.03.24 10:52, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-3=
6' ..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D160dc26e180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4ffb854606e=
658d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D49056626fe41e=
01f2ba7
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10f467b91=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D173b7ac9180=
000
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7bc7510fe41f/non_bootable_disk-e5eb28f6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/a5c7ad05d6b2/vmli=
nux-e5eb28f6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/531cb1917612=
/bzImage-e5eb28f6.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 6.8.0-syzkaller-09791-ge5eb28f6d1af #0 Not tainted
> > --------------------------------------------
> > syz-executor258/5169 is trying to acquire lock:
> > ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock =
mm/userfaultfd.c:1447 [inline]
> > ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xba=
b/0x4970 mm/userfaultfd.c:1583
> >
> > but task is already holding lock:
> > ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock =
mm/userfaultfd.c:1445 [inline]
> > ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xb6=
f/0x4970 mm/userfaultfd.c:1583
> >
> > other info that might help us debug this:
> >   Possible unsafe locking scenario:
> >
> >         CPU0
> >         ----
> >    lock(&vma->vm_lock->lock);
> >    lock(&vma->vm_lock->lock);
> >
> >   *** DEADLOCK ***
> >
> >   May be due to missing lock nesting notation
> >
> > 2 locks held by syz-executor258/5169:
> >   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock=
 include/linux/mmap_lock.h:146 [inline]
> >   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: uffd_move_lock=
 mm/userfaultfd.c:1438 [inline]
> >   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: move_pages+0x8=
df/0x4970 mm/userfaultfd.c:1583
> >   #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move=
_lock mm/userfaultfd.c:1445 [inline]
> >   #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_page=
s+0xb6f/0x4970 mm/userfaultfd.c:1583
> >
> > stack backtrace:
> > CPU: 2 PID: 5169 Comm: syz-executor258 Not tainted 6.8.0-syzkaller-0979=
1-ge5eb28f6d1af #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-=
1.16.2-1 04/01/2014
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> >   check_deadlock kernel/locking/lockdep.c:3062 [inline]
> >   validate_chain kernel/locking/lockdep.c:3856 [inline]
> >   __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
> >   lock_acquire kernel/locking/lockdep.c:5754 [inline]
> >   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
> >   down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
> >   uffd_move_lock mm/userfaultfd.c:1447 [inline]
> >   move_pages+0xbab/0x4970 mm/userfaultfd.c:1583
> >   userfaultfd_move fs/userfaultfd.c:2008 [inline]
> >   userfaultfd_ioctl+0x5e1/0x60e0 fs/userfaultfd.c:2126
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:904 [inline]
> >   __se_sys_ioctl fs/ioctl.c:890 [inline]
> >   __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7fd48da20329
> > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffd1244f8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007ffd1244fab8 RCX: 00007fd48da20329
> > RDX: 00000000200000c0 RSI: 00000000c028aa05 RDI: 0000000000000003
> > RBP: 00007fd48da93610 R08: 00007ffd1244fab8 R09: 00007ffd1244fab8
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffd1244faa8 R14: 0000000000000001 R15: 0000000000000001
> >   </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
>
> Possibly
>
> commit 867a43a34ff8a38772212045262b2c9b77807ea3
> Author: Lokesh Gidra <lokeshgidra@google.com>
> Date:   Thu Feb 15 10:27:56 2024 -0800
>
>      userfaultfd: use per-vma locks in userfaultfd operations
>
>      All userfaultfd operations, except write-protect, opportunistically =
use
>      per-vma locks to lock vmas.  On failure, attempt again inside mmap_l=
ock
>      critical section.
>
>      Write-protect operation requires mmap_lock as it iterates over multi=
ple
>      vmas.
>
> and
>
> commit 5e4c24a57b0c126686534b5b159a406c5dd02400
> Author: Lokesh Gidra <lokeshgidra@google.com>
> Date:   Thu Feb 15 10:27:54 2024 -0800
>
>      userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
>
>      Increments and loads to mmap_changing are always in mmap_lock critic=
al
>      section.  This ensures that if userspace requests event notification=
 for
>      non-cooperative operations (e.g.  mremap), userfaultfd operations do=
n't
>      occur concurrently.
>
>      This can be achieved by using a separate read-write semaphore in
>      userfaultfd_ctx such that increments are done in write-mode and load=
s in
>      read-mode, thereby eliminating the dependency on mmap_lock for this
>      purpose.
>
>      This is a preparatory step before we replace mmap_lock usage with pe=
r-vma
>      locks in fill/move ioctls.
>
> might responsible.
>
> CCin Lokesh

Thanks for looping me in. Taking a look.
>
> --
> Cheers,
>
> David / dhildenb
>

