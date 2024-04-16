Return-Path: <linux-kernel+bounces-147260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF72B8A71A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024ADB21A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24AA86255;
	Tue, 16 Apr 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="bCqBIEiW"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE6D10A22
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285999; cv=none; b=fju6L95ld5PzaFOsDi63st+Gi+HrlML/3oP0BuAXFUhHKO5Vm9TnWqEgVd9e1Fp0PGy6sUj9nDOMQFuM/9XmU1wS0kqEQGKfEm9uv6qUDF+JS4TazUoE3U6Uc7WY2eNYkpGbWLgs5QLQ0ONZefuN3AtDGkTzS1CF6qCXNrA9Zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285999; c=relaxed/simple;
	bh=h8S9oZA3R+k/BhQXUsiAH7CsUgEVUTzsO1q1Dl8zqxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGwMRzP5CnhkWHxNVj/ip2nAb79kf1nOq9tUBwc4jpgaEi6fIBNAPjmONVFTHXGeV1cMuJeYOGx31m28kEnaRe5nEbFdXgX/N/lQa1nlic0eee8uqO5+intuJJ4JI4B23vbW90vkdz38adypdvnVTQ5UwEestL218seNK2Ny4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=bCqBIEiW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d4d80d00so5711813e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1713285995; x=1713890795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks/cgVvlyPWcVmCv33McaZ4PEE3m8xDKlusrhicxlfk=;
        b=bCqBIEiWvB5Uef5nl2afmBIIdOhgSYEevDLwt0kFfarff+CIK/evRb8Sa5MZA6zOtD
         DBM9o2XkSKq3gio3En5cvXcJ7Ol1Aoq6VDEWVj2O3qj4unptvqACuWkOkHZLNaYK/t3Q
         7mOHYk4Bfksen0D2S3wC45xcg4lpIxHm3o7sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713285995; x=1713890795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks/cgVvlyPWcVmCv33McaZ4PEE3m8xDKlusrhicxlfk=;
        b=fjT9Vyd5WLrZOhArBUplmEdMVrpyZTEcBBzZMYRCeaslj2Y51wOZWZbvF8I6X/JJsf
         97GxLMdLHIprFNCXhYMRiRi8iuMyiTLHZjOxOdoj4EzdvorT2XOA2CI+eZYZae2k5z7s
         I5xiv7mgNHW83O7Po95wYwhFO2c56Dv29RnIDnR8+T8j9O0/6RdNsBcGH0IA30SkLA+9
         iW5sipAOVf9C0ohfJ7LT46zrta3fL2wnK1c69tnPW53X79waMtpcivzPkGWIAVE8JNFB
         0T3EO2uP5nkt5/GqG3eLX+t56OjBWwqDeLP1SIZfBPjAC/Kgbnt4fD0m5joWvhJ/zTAR
         0Xxw==
X-Gm-Message-State: AOJu0Yzm99WrdY1yv6ViiaJGAWG7Drjr02FfWsR9766pGoiJtJXeCrGW
	TZsBAXR1l6ibDYkfap98j+7pAj7MLV7ZVCgSGOPn5aRuoAVYxp/ds2W1i/G2RF+pGYT/gSb6fj+
	ZiS13O+nEe7ygXfulAk2Jn2AbqJegNrMJoMbceTHHZyrsHhFD6w==
X-Google-Smtp-Source: AGHT+IHi+7hQSJnkbJT0iHA/IJZdZCutmegnA9qZDFglgRtzQ/1z0ccuMfYc0zwPPoWtnfVJq0mpcSRYvQ3I94K6eYs=
X-Received: by 2002:a2e:83ce:0:b0:2d6:fd9c:6af6 with SMTP id
 s14-20020a2e83ce000000b002d6fd9c6af6mr8624014ljh.28.1713285995456; Tue, 16
 Apr 2024 09:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74jmWiSWaGoMU9AZnJJd1Ck2qNBdkBZG1=J3PC8gsqqWxg@mail.gmail.com>
 <20240416162319.GG30852@noisy.programming.kicks-ass.net>
In-Reply-To: <20240416162319.GG30852@noisy.programming.kicks-ass.net>
From: Igor Raits <igor@gooddata.com>
Date: Tue, 16 Apr 2024 18:46:23 +0200
Message-ID: <CA+9S74ih+45M_2TPUY_mPPVDhNvyYfy1J1ftSix+KjiTVxg8nw@mail.gmail.com>
Subject: Re: 6.8 to 6.9.0-rc3: kernel NULL pointer dereference in pick_next_task_fair+0x89
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, slyich@gmail.com, 
	wuyun.abel@bytedance.com, yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 6:23=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Apr 16, 2024 at 08:18:28AM +0200, Igor Raits wrote:
> > Hello all,
> >
> > We also see this issue quite frequently these days, however it gets
> > slightly hidden behind printk issue so that full stacktrace can't be
> > printed due to the deadlock.
>
> Who is we and how do you make it go bang?

Our company is running our production :) We simply run our lot of
parallel instances of Java application inside a container that
consumes a lot of CPU and after finishing the new container is run
with the same app processing a different load. I don't have anything
specific apart from "lot java runs in parallel spawning, consuming lot
of CPU" somehow triggers this. Sadly stacktrace can't be printed as
printk deadlock is happening but this is how the VM looks like

PID: 34302    TASK: ffff9db7a020b400  CPU: 0    COMMAND: "C2 CompilerThre"
    [exception RIP: native_queued_spin_lock_slowpath+496]
    RIP: ffffffff994d81a0  RSP: ffffadef43a67d48  RFLAGS: 00000002
    RAX: 0000000000180101  RBX: ffff9dc443c34080  RCX: 0000000000040000
    RDX: 0000000000000000  RSI: 0000000000000100  RDI: ffff9dc443c73280
    RBP: ffff9dc443c73280   R8: 0000000000000006   R9: fffffffffffffffc
    R10: 0000000000000006  R11: 0000000000000000  R12: 0000000000000000
    R13: 0000000000000000  R14: 0000000000007aaf  R15: ffff9db600a5e800
    CS: 0010  SS: 0000
 #0 [ffffadef43a67d68] _raw_spin_lock at ffffffff994d7de5
 #1 [ffffadef43a67d70] raw_spin_rq_lock_nested at ffffffff9894be19
 #2 [ffffadef43a67d88] load_balance at ffffffff98966c5d
 #3 [ffffadef43a67e68] rebalance_domains at ffffffff98967d5a
 #4 [ffffadef43a67ed8] __do_softirq at ffffffff994d8a08
 #5 [ffffadef43a67f28] irq_exit_rcu at ffffffff9890f0e6
 #6 [ffffadef43a67f38] sysvec_apic_timer_interrupt at ffffffff994c2aec
 #7 [ffffadef43a67f50] asm_sysvec_apic_timer_interrupt at ffffffff99600e06
    RIP: 00007f8d3168e9da  RSP: 00007f8d27ffdb90  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: 00007f8c80992cc0  RCX: 0000000000000000
    RDX: 0000000000000001  RSI: 0000000000000000  RDI: 00007f8d31518820
    RBP: 00007f8d27ffdbb0   R8: 00007f8cc80b7200   R9: 0000000000000000
    R10: 00007f8d284195a0  R11: 0b99c62094d7ff00  R12: 00007f8d27ffdbd7
    R13: 00007f8d27ffdd60  R14: 00007f8d314b2998  R15: 00007f8d2801c910
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

PID: 37       TASK: ffff9db600a6ce00  CPU: 1    COMMAND: "ksoftirqd/1"
    [exception RIP: native_queued_spin_lock_slowpath+114]
    RIP: ffffffff994d8022  RSP: ffffadef4016f840  RFLAGS: 00000002
    RAX: 0000000000000001  RBX: ffff9db9ccab0000  RCX: ffff9db9ccab0428
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff9dc443c73280
    RBP: ffff9dc443c73280   R8: ffff9dc443c72c28   R9: ffff9dc443c72c28
    R10: 0000000000000000  R11: 0000000000000000  R12: ffff9dc443c73280
    R13: ffff9db9ccab0cd4  R14: 0000000000000006  R15: 0000000000000001
    CS: 0010  SS: 0018
 #0 [ffffadef4016f860] _raw_spin_lock at ffffffff994d7de5
 #1 [ffffadef4016f868] raw_spin_rq_lock_nested at ffffffff9894be19
 #2 [ffffadef4016f880] try_to_wake_up at ffffffff98956aff
 #3 [ffffadef4016f8d8] kick_pool at ffffffff989281a9
 #4 [ffffadef4016f8f0] __queue_work at ffffffff9892b8c7
 #5 [ffffadef4016f938] queue_work_on at ffffffff9892bb04
 #6 [ffffadef4016f948] soft_cursor at ffffffff98f00540
 #7 [ffffadef4016f9a0] bit_cursor at ffffffff98f000b5
 #8 [ffffadef4016fa68] hide_cursor at ffffffff98fca13b
 #9 [ffffadef4016fa78] vt_console_print at ffffffff98fcc761
#10 [ffffadef4016fae0] console_flush_all at ffffffff98990d7b
#11 [ffffadef4016fb58] console_unlock at ffffffff98990fe6
#12 [ffffadef4016fb90] vprintk_emit at ffffffff98991f94
#13 [ffffadef4016fbd8] _printk at ffffffff9898e248
#14 [ffffadef4016fc38] show_fault_oops at ffffffff988930ce
#15 [ffffadef4016fc90] page_fault_oops at ffffffff988931ce
#16 [ffffadef4016fce8] exc_page_fault at ffffffff994c3495
#17 [ffffadef4016fd10] asm_exc_page_fault at ffffffff99600bb2
    [exception RIP: pick_next_task_fair+251]
    RIP: ffffffff9896769b  RSP: ffffadef4016fdc8  RFLAGS: 00010086
    RAX: 0000000000000000  RBX: ffff9dc443c73280  RCX: 0000000000000806
    RDX: 1272dd0281c36788  RSI: 0000000000000806  RDI: 009b28f004606f7f
    RBP: ffff9db67ca46800   R8: 0000000000000000   R9: 0000000000000000
    R10: 000000000000014b  R11: 0000000000000000  R12: ffffadef4016fe60
    R13: ffff9db600a6ce00  R14: ffff9dc443c73300  R15: ffff9db67ca46c00
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#18 [ffffadef4016fdf8] pick_next_task at ffffffff9894f06a
#19 [ffffadef4016fe58] __schedule at ffffffff994d08ed
#20 [ffffadef4016fec0] schedule at ffffffff994d0f7e
#21 [ffffadef4016fed8] smpboot_thread_fn at ffffffff98940d57
#22 [ffffadef4016fef8] kthread at ffffffff989354cf
#23 [ffffadef4016ff30] ret_from_fork at ffffffff9884077d
#24 [ffffadef4016ff50] ret_from_fork_asm at ffffffff988041bb

PID: 33793    TASK: ffff9db792449a00  CPU: 2    COMMAND: "java"
    [exception RIP: native_queued_spin_lock_slowpath+639]
    RIP: ffffffff994d822f  RSP: ffffadef44027928  RFLAGS: 00000046
    RAX: 0000000000000000  RBX: ffff9dc443cb4080  RCX: 00000000000c0000
    RDX: 0000000000000004  RSI: 0000000000140100  RDI: ffff9dc443c73280
    RBP: ffff9dc443c73280   R8: 0000000000000006   R9: fffffffffffffffc
    R10: 0000000000000006  R11: 0000000000000001  R12: 0000000000000000
    R13: 0000000000000002  R14: ffff9dc443cb3280  R15: 0000000000000000
    CS: 0010  SS: 0018
 #0 [ffffadef44027948] _raw_spin_lock at ffffffff994d7de5
 #1 [ffffadef44027950] raw_spin_rq_lock_nested at ffffffff9894be19
 #2 [ffffadef44027968] load_balance at ffffffff98966c5d
 #3 [ffffadef44027a48] newidle_balance at ffffffff98967323
 #4 [ffffadef44027aa8] pick_next_task_fair at ffffffff989675e1
 #5 [ffffadef44027ae0] pick_next_task at ffffffff9894f06a
 #6 [ffffadef44027b40] __schedule at ffffffff994d08ed
 #7 [ffffadef44027ba8] schedule at ffffffff994d0f7e
 #8 [ffffadef44027bc0] schedule_timeout at ffffffff994d6c58
 #9 [ffffadef44027c10] wait_woken at ffffffff98977750
#10 [ffffadef44027c28] sk_wait_data at ffffffff99240f26
#11 [ffffadef44027c88] tcp_recvmsg_locked at ffffffff99332b5f
#12 [ffffadef44027d18] tcp_recvmsg at ffffffff99333d61
#13 [ffffadef44027d88] inet_recvmsg at ffffffff99371aa2
#14 [ffffadef44027dc8] sock_recvmsg at ffffffff99237fc5
#15 [ffffadef44027df0] __sys_recvfrom at ffffffff9923a5d0
#16 [ffffadef44027f20] __x64_sys_recvfrom at ffffffff9923a670
#17 [ffffadef44027f28] do_syscall_64 at ffffffff994bd52e
#18 [ffffadef44027f50] entry_SYSCALL_64_after_hwframe at ffffffff99600130
    RIP: 00007f93ea30f66e  RSP: 00007f93ea5e54b0  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007f93e804c1b0  RCX: 00007f93ea30f66e
    RDX: 0000000000000005  RSI: 00007f93ea5e5590  RDI: 000000000000005e
    RBP: 00007f93ea5e5560   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000246  R12: 0000000000000000
    R13: 00007f93ea5e5510  R14: 00007f93ea5e5590  R15: 00007f93ea5ff5c0
    ORIG_RAX: 000000000000002d  CS: 0033  SS: 002b

PID: 33821    TASK: ffff9db6c49d0000  CPU: 3    COMMAND: "C2 CompilerThre"
    [exception RIP: native_queued_spin_lock_slowpath+639]
    RIP: ffffffff994d822f  RSP: ffffadef44baba98  RFLAGS: 00000046
    RAX: 0000000000000000  RBX: ffff9dc443cf4080  RCX: 0000000000100000
    RDX: 0000000000000002  RSI: 00000000000c0100  RDI: ffff9dc443c73280
    RBP: ffff9dc443c73280   R8: 0000000000000006   R9: fffffffffffffffc
    R10: 0000000000000006  R11: 0000000000000000  R12: 0000000000000000
    R13: 0000000000000003  R14: ffff9dc443cf3280  R15: 0000000000000000
    CS: 0010  SS: 0018
 #0 [ffffadef44babab8] _raw_spin_lock at ffffffff994d7de5
 #1 [ffffadef44babac0] raw_spin_rq_lock_nested at ffffffff9894be19
 #2 [ffffadef44babad8] load_balance at ffffffff98966c5d
 #3 [ffffadef44babbb8] newidle_balance at ffffffff98967323
 #4 [ffffadef44babc18] pick_next_task_fair at ffffffff989675e1
 #5 [ffffadef44babc50] pick_next_task at ffffffff9894f06a
 #6 [ffffadef44babcb0] __schedule at ffffffff994d08ed
 #7 [ffffadef44babd18] schedule at ffffffff994d0f7e
 #8 [ffffadef44babd30] futex_wait_queue at ffffffff989eca00
 #9 [ffffadef44babd50] __futex_wait at ffffffff989ed0b9
#10 [ffffadef44babe10] futex_wait at ffffffff989ed1a7
#11 [ffffadef44babea0] do_futex at ffffffff989e9388
#12 [ffffadef44babeb0] __x64_sys_futex at ffffffff989e9a43
#13 [ffffadef44babf28] do_syscall_64 at ffffffff994bd52e
#14 [ffffadef44babf50] entry_SYSCALL_64_after_hwframe at ffffffff99600130
    RIP: 00007f93ea28679a  RSP: 00007f93bd0fe990  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007f93bd0feaa0  RCX: 00007f93ea28679a
    RDX: 0000000000000000  RSI: 0000000000000089  RDI: 00007f93e4419b7c
    RBP: 0000000000000000   R8: 0000000000000000   R9: 00000000ffffffff
    R10: 00007f93bd0feaa0  R11: 0000000000000246  R12: 0000000000000000
    R13: 00007f93e4419b7c  R14: 0000000000000000  R15: 00007f93e4419b28
    ORIG_RAX: 00000000000000ca  CS: 0033  SS: 002b

PID: 34261    TASK: ffff9db62162b400  CPU: 4    COMMAND: "java"
    [exception RIP: native_queued_spin_lock_slowpath+639]
    RIP: ffffffff994d822f  RSP: ffffadef445efd48  RFLAGS: 00000046
    RAX: 0000000000000000  RBX: ffff9dc443d34080  RCX: 0000000000140000
    RDX: 0000000000000000  RSI: 0000000000040100  RDI: ffff9dc443c73280
    RBP: ffff9dc443c73280   R8: 0000000000000006   R9: fffffffffffffffc
    R10: 0000000000000006  R11: 000000000000002c  R12: 0000000000000000
    R13: 0000000000000004  R14: 000000000001a23e  R15: ffff9db600a70e00
    CS: 0010  SS: 0000
 #0 [ffffadef445efd68] _raw_spin_lock at ffffffff994d7de5
 #1 [ffffadef445efd70] raw_spin_rq_lock_nested at ffffffff9894be19
 #2 [ffffadef445efd88] load_balance at ffffffff98966c5d
 #3 [ffffadef445efe68] rebalance_domains at ffffffff98967d5a
 #4 [ffffadef445efed8] __do_softirq at ffffffff994d8a08
 #5 [ffffadef445eff28] irq_exit_rcu at ffffffff9890f0e6
 #6 [ffffadef445eff38] sysvec_apic_timer_interrupt at ffffffff994c2aec
 #7 [ffffadef445eff50] asm_sysvec_apic_timer_interrupt at ffffffff99600e06
    RIP: 00007f8d1224ed4b  RSP: 00007f8d3191c9c0  RFLAGS: 00000293
    RAX: 00000007593ce380  RBX: 0000000000000022  RCX: 0000000000000188
    RDX: 0000000000000022  RSI: 00000007414076a8  RDI: 00000000000002e4
    RBP: 00000007595fad38   R8: 00000007593ce090   R9: 00000000000020fe
    R10: 00007f8d31cb4000  R11: 00000000e81a149f  R12: 0000000000000000
    R13: 00000007593ce210  R14: 00000007593d5028  R15: 00007f8d28027800
    ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b

PID: 35079    TASK: ffff9db70682ce00  CPU: 5    COMMAND: "C2 CompilerThre"
    [exception RIP: native_queued_spin_lock_slowpath+639]
    RIP: ffffffff994d822f  RSP: ffffadef4478fa98  RFLAGS: 00000046
    RAX: 0000000000000000  RBX: ffff9dc443d74080  RCX: 0000000000180000
    RDX: 0000000000000003  RSI: 0000000000100100  RDI: ffff9dc443c73280
    RBP: ffff9dc443c73280   R8: 0000000000000006   R9: fffffffffffffffc
    R10: 0000000000000006  R11: 0000000000000001  R12: 0000000000000000
    R13: 0000000000000005  R14: ffff9dc443d73280  R15: 0000000000000000
    CS: 0010  SS: 0018
 #0 [ffffadef4478fab8] _raw_spin_lock at ffffffff994d7de5
 #1 [ffffadef4478fac0] raw_spin_rq_lock_nested at ffffffff9894be19
 #2 [ffffadef4478fad8] load_balance at ffffffff98966c5d
 #3 [ffffadef4478fbb8] newidle_balance at ffffffff98967323
 #4 [ffffadef4478fc18] pick_next_task_fair at ffffffff989675e1
 #5 [ffffadef4478fc50] pick_next_task at ffffffff9894f06a
 #6 [ffffadef4478fcb0] __schedule at ffffffff994d08ed
 #7 [ffffadef4478fd18] schedule at ffffffff994d0f7e
 #8 [ffffadef4478fd30] futex_wait_queue at ffffffff989eca00
 #9 [ffffadef4478fd50] __futex_wait at ffffffff989ed0b9
#10 [ffffadef4478fe10] futex_wait at ffffffff989ed1a7
#11 [ffffadef4478fea0] do_futex at ffffffff989e9388
#12 [ffffadef4478feb0] __x64_sys_futex at ffffffff989e9a43
#13 [ffffadef4478ff28] do_syscall_64 at ffffffff994bd52e
#14 [ffffadef4478ff50] entry_SYSCALL_64_after_hwframe at ffffffff99600130
    RIP: 00007f1a7188679a  RSP: 00007f1a505fe990  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007f1a505feaa0  RCX: 00007f1a7188679a
    RDX: 0000000000000000  RSI: 0000000000000089  RDI: 00007f1a6c419b7c
    RBP: 0000000000000000   R8: 0000000000000000   R9: 00000000ffffffff
    R10: 00007f1a505feaa0  R11: 0000000000000246  R12: 0000000000000000
    R13: 00007f1a6c419b7c  R14: 0000000000000000  R15: 00007f1a6c419b28
    ORIG_RAX: 00000000000000ca  CS: 0033  SS: 002b


> Having a semi reliable reproducer in hand would be a tremendous help.

We don't have a specific reproducer but it happens on a specific type
of VM workloads and does not crash anywhere else.
Java+Ruby+Containers+Load+Parallel+NFS is the description of this
specific type of VM workload we have.

>
> Anywya, I've had:
>
> schedtool -D -e bash -c "while :; make O=3Ddefconfig-build clean; make O=
=3Ddefconfig-build -j64; done"
>
> running for an hour or so now, but no luck :/

