Return-Path: <linux-kernel+bounces-73991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5ED85CE92
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A61F1C22B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099D37160;
	Wed, 21 Feb 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAzwHWOq"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420612837E;
	Wed, 21 Feb 2024 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484905; cv=none; b=d/8g8G1z21j5bxZg7UzbqtWhNMNRqRm7Ok1SzzOzH/uCoZZOorlV/3CYFm2rI21nmVTBIAjdnZUc/S+U+Za+F4g7mMDSKXNKRPIOvcXsAKnOVZtCgHz0lBT1mdM0H4r/Gmm5lK4FbFyNqOCPsC/XQz166hB/A9W9PYZ0pJXK26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484905; c=relaxed/simple;
	bh=8lqJfcyvyjZieFF6DBZsOMf4b5DXXe651nYq3W8rqcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7ib+QbHzHKq2uXauYgRhitLjdLT2OZISD1JwRN82lFj91rTK8PEVfs/QFTKCoYEao/n3lA3pK3OqIAbHFhqk+4aXwaXsZlVJTiORzQRblITWxjbpuFlbeP5Sp0KyEFEdkp+U/u3yYPIDS91sjXjqnh1YvEk9C96aPGZGBxaE84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAzwHWOq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d1094b549cso89657821fa.3;
        Tue, 20 Feb 2024 19:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484901; x=1709089701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGUN520xlcUh9uCFJJBmFsnsOTyBRFjezJMbMofVdcY=;
        b=FAzwHWOqhO1jCdIItUpvb54GBgQ32zT37wVY/hsl/Z+UGZ3yqjc8Sfnwd6RZOCJCtF
         xOvK3ChkyMpuH72D1+eQM+Aw/IAH7+FVjBnFlLzHzwcjnFravs3nBp/oMXyaQks/IeBR
         G6nHTZMckVkgdCm1+e7VCgBJbTKyMMxXfomR63I9zcI5QHL+aHkIH/+vLt6tijEh+KHl
         CvSNBSeua61/+PeTXVr8aoPJwYbTJHdjDozz4JSGhAffpi6VrFWvFbO+Jcz6A754c8y5
         dsDN2uY7W8gibuDQzd+kVlgXUBmPSqgFHYuRqgnMlEwGkhPcwp9whDs4ZmRR9MLQcfYm
         mayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484901; x=1709089701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGUN520xlcUh9uCFJJBmFsnsOTyBRFjezJMbMofVdcY=;
        b=Ig1ddPm6X21iGb1amW1jF2JzaBgylWV8OaxvUio/tQRGY3oS+Tlt8DDuSHrfBZ7EAV
         z4TTuR3QaeZwS6pFCAigByE0Qd64iNvaYUVl8mXHMjmDV4GyksXtLw9VYE3r23LL5K8L
         7d9Ti19B9jD8bxJl3O/LUig5P+7MczxCZxZmMyzYvV0xdbUsqM2CTzoPiso1S8P46gDv
         hcVFXts6KsZ9Utx7r0V3eJDKFawf7KUX1miyF0btRlr6nn8DWIpiorAAYKi5WHUAaORf
         cFWBRxWrzp2DoaLv26lE/UjvkG3qZNiNDEKm/sU5ffsmnbOlrskqBMWoowethwkTj8ab
         mjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWJtw7Yf8XdbHaOtC28O05P8VV0GxDqCva7fzR5u1L6huLaE6Py8kqtwiByN/d2HPzFE+l3jtnn/hbVS5gbd5zjORhKveHasYjY8PTpIXk5NPY0bA6ImRwwILwuRN9NmpcU4UX
X-Gm-Message-State: AOJu0YzDGWsMdDIfykG9+8uvcEH2dWPh9yCWQWAIOVZYkuKsV5EIDgu/
	Prs4uEFDO0Y+ofanbO6S0ULG3HdkQyCQYfLvQg1AI1lF5ZdDw4xqmE1NyLmqK1P9Om4E7maMend
	5cs67MojqnuutflqSNi7QGacIseo=
X-Google-Smtp-Source: AGHT+IEAlyiWvnV4yyV2t2lBDCZmGBokZGDeKd3W0024yiIivwOFyTymK2CxBuCR/t4IxjbwE9LuYd6ETC49PPINoJI=
X-Received: by 2002:a2e:8950:0:b0:2d1:26f0:8167 with SMTP id
 b16-20020a2e8950000000b002d126f08167mr11558186ljk.35.1708484901033; Tue, 20
 Feb 2024 19:08:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdVgLbuAYGKoDzpS@xpf.sh.intel.com>
In-Reply-To: <ZdVgLbuAYGKoDzpS@xpf.sh.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 21 Feb 2024 11:07:44 +0800
Message-ID: <CAL+tcoB_NeHpgrg7_HngiResOPhNCBTpDTJsjYsccXZMFA7VGw@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is BUG: soft lockup after sendmsg
 syscall in v6.8-rc4
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: kuniyu@amazon.com, davem@davemloft.net, dumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:35=E2=80=AFAM Pengfei Xu <pengfei.xu@intel.com> =
wrote:
>
> Hi Kuniyuki Iwashima and kernel experts,
>
> Greeting!
> There is BUG: soft lockup after sendmsg syscall in v6.8-rc4 in guest.
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/2=
40220_161242_softlockup
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blo=
b/main/240220_161242_softlockup/repro.c
> Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller=
_logs/blob/main/240220_161242_softlockup/repro.prog
> Kconfig(need make olddefconfig): https://github.com/xupengfe/syzkaller_lo=
gs/blob/main/240220_161242_softlockup/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240220_=
161242_softlockup/bisect_info.log
> v6.8-rc4 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/mai=
n/240220_161242_softlockup/841c35169323cd833294798e58b9bf63fa4fa1de_dmesg.l=
og
> bzImage_v6.8-rc4: https://github.com/xupengfe/syzkaller_logs/raw/main/240=
220_161242_softlockup/bzImage_v6.8-rc4.tar.gz
>
> Bisected and found first bad commit:
> "
> 1279f9d9dec2 af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
> "
>
> After reverted above commit on top of v6.8-rc4 kernel, this issue was gon=
e.
>
> Syzkaller repro.report: https://github.com/xupengfe/syzkaller_logs/blob/m=
ain/240220_161242_softlockup/repro.report
> "
> watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [gdbus:349]
> Modules linked in:
> irq event stamp: 25162
> hardirqs last  enabled at (25161): [<ffffffff855dff2e>] irqentry_exit+0x3=
e/0xa0 kernel/entry/common.c:351
> hardirqs last disabled at (25162): [<ffffffff855dded4>] sysvec_apic_timer=
_interrupt+0x14/0xc0 arch/x86/kernel/apic/apic.c:1076
> softirqs last  enabled at (25140): [<ffffffff8127fcc8>] invoke_softirq ke=
rnel/softirq.c:427 [inline]
> softirqs last  enabled at (25140): [<ffffffff8127fcc8>] __irq_exit_rcu+0x=
a8/0x110 kernel/softirq.c:632
> softirqs last disabled at (25135): [<ffffffff8127fcc8>] invoke_softirq ke=
rnel/softirq.c:427 [inline]
> softirqs last disabled at (25135): [<ffffffff8127fcc8>] __irq_exit_rcu+0x=
a8/0x110 kernel/softirq.c:632
> CPU: 0 PID: 349 Comm: gdbus Not tainted 6.8.0-rc4-2024-02-12-intel-next-e=
92619743fcb+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-=
gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__sanitizer_cov_trace_pc+0x38/0x70 kernel/kcov.c:207
> Code: 65 8b 05 73 89 a0 7e 48 89 e5 48 8b 75 08 a9 00 01 ff 00 74 0f f6 c=
4 01 74 35 8b 82 e4 1d 00 00 85 c0 74 2b 8b 82 c0 1d 00 00 <83> f8 02 75 20=
 48 8b 8a c8 1d 00 00 8b 92 c4 1d 00 00 48 8b 01 48
> RSP: 0018:ffff88800b48f7b0 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: ffff888013018000 RCX: 1ffffffff12150bb
> RDX: ffff888011ab8000 RSI: ffffffff8515e235 RDI: ffff888013018770
> RBP: ffff88800b48f7b0 R08: 0000000000000001 R09: fffffbfff120f86e
> R10: ffffffff8907c377 R11: 0000000000000001 R12: ffff888013018000
> R13: dffffc0000000000 R14: ffff888013018630 R15: ffff88800b48f840
> FS:  0000000000000000(0000) GS:ffff88806ca00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fffcc5fd648 CR3: 0000000006c82000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  </IRQ>
>  <TASK>
>  unix_gc+0x465/0xfd0 net/unix/garbage.c:319
>  unix_release_sock+0xb8c/0xe80 net/unix/af_unix.c:683
>  unix_release+0x9c/0x100 net/unix/af_unix.c:1064
>  __sock_release+0xb6/0x280 net/socket.c:659
>  sock_close+0x27/0x40 net/socket.c:1421
>  __fput+0x284/0xb70 fs/file_table.c:376
>  ____fput+0x1f/0x30 fs/file_table.c:404
>  task_work_run+0x19d/0x2b0 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xb51/0x28c0 kernel/exit.c:871
>  do_group_exit+0xe5/0x2c0 kernel/exit.c:1020
>  get_signal+0x2715/0x27d0 kernel/signal.c:2893
>  arch_do_signal_or_restart+0x8e/0x7e0 arch/x86/kernel/signal.c:311
>  exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
>  syscall_exit_to_user_mode+0x129/0x190 kernel/entry/common.c:212
>  do_syscall_64+0x82/0x150 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> RIP: 0033:0x7fe8f8b4296f
> Code: Unable to access opcode bytes at 0x7fe8f8b42945.
> RSP: 002b:00007fe8d7dff9c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
> RAX: fffffffffffffdfc RBX: 00007fe8f8f73071 RCX: 00007fe8f8b4296f
> RDX: 00000000ffffffff RSI: 0000000000000002 RDI: 00007fe8a801f3f0
> RBP: 00007fe8a801f3f0 R08: 0000000000000000 R09: 00007fe8d7dff850
> R10: 00007ffec9196080 R11: 0000000000000293 R12: 0000000000000002
> R13: 0000000000000002 R14: 00007fe8d7dffa30 R15: 00007fe8a801c4c0
>  </TASK>
> "

Hello, did you try this one:

commit 25236c91b5ab4a26a56ba2e79b8060cf4e047839
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Fri Feb 9 14:04:53 2024 -0800

    af_unix: Fix task hung while purging oob_skb in GC.

    syzbot reported a task hung; at the same time, GC was looping infinitel=
y
    in list_for_each_entry_safe() for OOB skb.  [0]

    syzbot demonstrated that the list_for_each_entry_safe() was not actuall=
y
    safe in this case.

    A single skb could have references for multiple sockets.  If we free su=
ch
    a skb in the list_for_each_entry_safe(), the current and next sockets c=
ould
    be unlinked in a single iteration.

It should work, I think :)

Thanks,
Jason

>
> Thanks!
>
> ---
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
> Best Regards,
> Thanks!
>

