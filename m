Return-Path: <linux-kernel+bounces-147853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8A8A7A85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D41F24410
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1625680;
	Wed, 17 Apr 2024 02:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+QXN9wE"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071C4C8C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320715; cv=none; b=Rn3YI2SZqAV0IyFHo0VaIH1P41uc5OepfFBGEXnmMcAfdL4y5k59Qosx1bv2AWNtJT0ZhFk9crGYXhbOM4q+REZj2ex8xsr55kEErQU+Vq6Zw+HsVi0bzXm1/KyrOXUc8K14rPMLkZPNMajgSmRMVlI2FmKFGhs9+8wjO9Oj7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320715; c=relaxed/simple;
	bh=WpUs73PrK6kG5kdcD3gQnbyE8ZFKFcS4nVqG/SdXKXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upeKVaqP0WqP+i1/jYnXSN+2OgvPsnis49IgT+srVSvBW8zJ4QSJEvQ16V+R4emJt5XvSoH/dPfAI7CTKuHuKoaN6RMRakciYS0kE9UZYwILFMVithhpnNstNq9AmfwaQNUs917eB2m0ERsZKAtxOgz1K20WqEZa0Dnb9e5hECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+QXN9wE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so2337447a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713320714; x=1713925514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7qxYrzKA9WPX/nORg3HpANjD7ganwGwbm86JyvX/bI=;
        b=k+QXN9wErqsoPJYIfNqZPqAMo69O/x3u82XvTzc/p13iK8RdzsmEalvx2ca8W8JJig
         eVxkcA5fcqvmoiXoDBJ5HIdZaaqYDFY4qdWoMu2+/DTlq/tz+fZ6md6dW9aiigpuwdmj
         36pbmRDf/6dYkK1GNNbkS24IaX005hKCSUS/Phz8Vab9w+bSKN29sBPAyr3L/7/EPQCz
         k4uDhaUXtA8JRLR/gU9LTAom9gPHuZ+CJlNcmbqMOv0eSNsAJRT7OkIP9r4LDRXKCWRz
         lyDpVbX6r/U83Y06ZMC0FmOy9xVsRb7OtnMdk3UkIe0Z7yoKoert7ONuPx73p8ZZqiyY
         vfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713320714; x=1713925514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7qxYrzKA9WPX/nORg3HpANjD7ganwGwbm86JyvX/bI=;
        b=oncPgnqM1qWuE66tTJvFD+lq4KX/BEUEdRn5gswA+0DRwRHifnR4308Wkh2+z0wnwa
         aeY1f2RaEHyHYVV0hdMBxf++pMz02PbmX4+rj02RyanA/u75+pnHt0F5lRgaj+5l3C2q
         HKxVY5cMh90k6yLO4uxDJyvz7Rmoc50udh2DW/Omj0C+lGHM6Ve5+ip0yffhrJ8mcDu5
         UTf0Y+IQ1iOe2gIgx4HLi69tYG7D1jdOzrOa47pW32zZAwsG4zFH6pe/GAnS/h/bWnRu
         z9TLFq1AKQzgh6qDrK6k32tvXvY4GXZXMUgNZncdxav/9Quf2hwFraoL246jBmtDPcOi
         MX8A==
X-Forwarded-Encrypted: i=1; AJvYcCXtGFdjWHAqWC/DoyExvtvVspvbwTzFaxafi4vb26DN6L9bExPLpJYnLp+H6QqcwqxEC8xst8kBWUG+dS3lrp6zxYC4ohTAROcxlQEv
X-Gm-Message-State: AOJu0Yzujgh2w6RQuBePEjP4BNeADY0GGgubArCSF/xS36iQQdUCKjzg
	5zCySdBlqSePaKpwnHzs/2j5LpdX8i3DzlVhxmg3RHciA4q9CTaXmSvCgRKll+FTolWtKsdLgYV
	rMNWJoMuDc+BGGOyPmZst8bz45+A=
X-Google-Smtp-Source: AGHT+IEqURlJI3DLN3SsIDtp8PoLM1Vl2WtqOrIeGQD6jWedpkYo/gC4lZInUZd2sQ8XX0Us7k3bBEL7Vuq7X/+gz2Y=
X-Received: by 2002:a17:90a:fa03:b0:29d:e75b:e73a with SMTP id
 cm3-20020a17090afa0300b0029de75be73amr11204529pjb.49.1713320713431; Tue, 16
 Apr 2024 19:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b24903061520f3e9@google.com> <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com> <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop>
In-Reply-To: <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 17 Apr 2024 10:25:01 +0800
Message-ID: <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
To: paulmck@kernel.org
Cc: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Tue, Apr 16, 2024 at 04:44:54PM +0800, Z qiang wrote:
> > On Tue, Apr 16, 2024 at 4:10=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.=
com> wrote:
> > >
> > > Cc: Paul
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    c0b832517f62 Add linux-next specific files for 2024=
0402
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15f6477=
6180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dafcaf46=
d374cec8c
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddce04ed6d=
1438ad69656
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10f00=
471180000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76ed=
c7/disk-c0b83251.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/=
vmlinux-c0b83251.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/2349287b=
14b7/bzImage-c0b83251.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > WARNING: suspicious RCU usage
> > > > 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
> > > > -----------------------------
> > > > kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side cri=
tical section!
> > > >
> > > > other info that might help us debug this:
> > > >
> > > >
> > > > rcu_scheduler_active =3D 2, debug_locks =3D 1
> > > > 1 lock held by ksoftirqd/0/16:
> > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lo=
ck_acquire include/linux/rcupdate.h:329 [inline]
> > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_re=
ad_lock_sched include/linux/rcupdate.h:933 [inline]
> > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: pfn_va=
lid include/linux/mmzone.h:2019 [inline]
> > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: __virt=
_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65
> > > >
> > > > stack backtrace:
> > > > CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc2-next-2024040=
2-syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 03/27/2024
> > > > Call Trace:
> > > >  <IRQ>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > > >  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
> > > >  rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
> > > >  __do_softirq+0x5fd/0x980 kernel/softirq.c:568
>
> Huh.  This statement is supposed to prevent this call to __do_softirq()
> from interrupt exit::
>
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
>             __this_cpu_read(ksoftirqd) =3D=3D current)
>
> So was the ksoftirqd kthread interrupted at a point where it happens to
> have softirq enabled?

It should look like this:
schedule()
switch_to ksoftirqd/0
finish_task_switch
->put_task_struct_rcu_user
   ->call_rcu(&task->rcu, delayed_put_task_struct)
      ->__kasan_record_aux_stack
         ->pfn_valid
            ->rcu_read_lock_sched
                <interrupt>
                 __irq_exit_rcu
                 ->__do_softirq
                    -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
                             __this_cpu_read(ksoftirqd) =3D=3D current)
                              rcu_softirq_qs
                               ->
RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))

Thanks
Zqiang


>
>                                                         Thanx, Paul
>
> > > >  invoke_softirq kernel/softirq.c:428 [inline]
> > > >  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
> > > >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
> > > >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043=
 [inline]
> > > >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:=
1043
> > > >  </IRQ>
> > > >  <TASK>
> > > >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idt=
entry.h:702
> > > > RIP: 0010:debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu/update.c:32=
0
> > > > Code: f5 90 0f 0b 90 90 90 eb c6 0f 1f 40 00 90 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d c7 0f 28 04 00 <74> 1e 83=
 3d 26 42 28 04 00 74 15 65 48 8b 0c 25 c0 d3 03 00 31 c0
> > > > RSP: 0018:ffffc90000157a50 EFLAGS: 00000202
> > > > RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 0000000000000001
> > > > RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffffff8c1f7ec0
> > > > RBP: dffffc0000000000 R08: ffffffff92f3a527 R09: 1ffffffff25e74a4
> > > > R10: dffffc0000000000 R11: fffffbfff25e74a5 R12: 0000000029373578
> > > > R13: 1ffff9200002af64 R14: ffffffff814220f3 R15: ffff88813fff90a0
> > > >  rcu_read_lock_sched include/linux/rcupdate.h:934 [inline]
> > > >  pfn_valid include/linux/mmzone.h:2019 [inline]
> > > >  __virt_addr_valid+0x1a9/0x520 arch/x86/mm/physaddr.c:65
> > > >  kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
> > > >  __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
> > >
> > >
> > > This should be caused by the following commit:
> > > d818cc76e2b4 ("kasan: Record work creation stack trace with interrupt=
s enabled")
> > >
> > > Is it possible to make the rcu_softirq_qs() run only in ksoftirqd tas=
k?
> >
> > use rcu_softirq_qs_periodic() in run_ksoftirqd().
> >
> > >
> > > Thanks
> > > Zqiang
> > >
> > > >  __call_rcu_common kernel/rcu/tree.c:3096 [inline]
> > > >  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
> > > >  context_switch kernel/sched/core.c:5412 [inline]
> > > >  __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
> > > >  __schedule_loop kernel/sched/core.c:6823 [inline]
> > > >  schedule+0x14b/0x320 kernel/sched/core.c:6838
> > > >  smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
> > > >  kthread+0x2f0/0x390 kernel/kthread.c:388
> > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > > >  </TASK>
> > > > ----------------
> > > > Code disassembly (best guess):
> > > >    0:   f5                      cmc
> > > >    1:   90                      nop
> > > >    2:   0f 0b                   ud2
> > > >    4:   90                      nop
> > > >    5:   90                      nop
> > > >    6:   90                      nop
> > > >    7:   eb c6                   jmp    0xffffffcf
> > > >    9:   0f 1f 40 00             nopl   0x0(%rax)
> > > >    d:   90                      nop
> > > >    e:   90                      nop
> > > >    f:   90                      nop
> > > >   10:   90                      nop
> > > >   11:   90                      nop
> > > >   12:   90                      nop
> > > >   13:   90                      nop
> > > >   14:   90                      nop
> > > >   15:   90                      nop
> > > >   16:   90                      nop
> > > >   17:   90                      nop
> > > >   18:   90                      nop
> > > >   19:   90                      nop
> > > >   1a:   90                      nop
> > > >   1b:   90                      nop
> > > >   1c:   90                      nop
> > > >   1d:   f3 0f 1e fa             endbr64
> > > >   21:   31 c0                   xor    %eax,%eax
> > > >   23:   83 3d c7 0f 28 04 00    cmpl   $0x0,0x4280fc7(%rip)        =
# 0x4280ff1
> > > > * 2a:   74 1e                   je     0x4a <-- trapping instructio=
n
> > > >   2c:   83 3d 26 42 28 04 00    cmpl   $0x0,0x4284226(%rip)        =
# 0x4284259
> > > >   33:   74 15                   je     0x4a
> > > >   35:   65 48 8b 0c 25 c0 d3    mov    %gs:0x3d3c0,%rcx
> > > >   3c:   03 00
> > > >   3e:   31 c0                   xor    %eax,%eax
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >
> > > > If the report is already addressed, let syzbot know by replying wit=
h:
> > > > #syz fix: exact-commit-title
> > > >
> > > > If you want syzbot to run the reproducer, reply with:
> > > > #syz test: git://repo/address.git branch-or-commit-hash
> > > > If you attach or paste a git patch, syzbot will apply it before tes=
ting.
> > > >
> > > > If you want to overwrite report's subsystems, reply with:
> > > > #syz set subsystems: new-subsystem
> > > > (See the list of subsystem names on the web dashboard)
> > > >
> > > > If the report is a duplicate of another one, reply with:
> > > > #syz dup: exact-subject-of-another-report
> > > >
> > > > If you want to undo deduplication, reply with:
> > > > #syz undup
> > > >

