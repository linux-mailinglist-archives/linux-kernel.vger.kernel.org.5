Return-Path: <linux-kernel+bounces-98704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57883877E24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1521C20FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E136AEF;
	Mon, 11 Mar 2024 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W69IMYCd"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112A199AD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153268; cv=none; b=TkyeoQ1t0l97ovZte0fKn8XoMu2BUICEjXXYiq4ON8MYIpPkdachHPKhZbjOYqIaZmfRYUsdPxAeGZ4el/2BVPfcDDs8Klzjfpm9ojUq3fVUu1OV/Z/xWYdLTpcoCIrkwJNxzs7fpX1bqDWE2ylvH2LwNPD0jk9JsmUCZIz2DHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153268; c=relaxed/simple;
	bh=RsD9mGqyMPkbQr1MtLvBY+KedqEBoAc0JxIkrSll2VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiJLANJiskBV6oWmnXssw0gGt4L6zyWcIXkcM4JH7BP/no4/uoJIIC5++9HkNdBLc1ogQaIMGLP6bmKXKCYJBm/qwgWW5ralmZnpCi+XJMhWfe/LCWoreOxnIo1CZVQalvEHFaldmUKBnWSMzaQO226JQpjf4HXhCGdG2FEjz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W69IMYCd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4132a4360b6so3266425e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710153264; x=1710758064; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRLVssMiMBm2lg/REg1nvG9aYTg9hv9LjzPCPgivj2Y=;
        b=W69IMYCdMqJ6GzOG69dUfmwwzSTIPBcrFTBfSl81CBVA61IvZfjKRkWX9QZvw55rKl
         2/Ekpsri6MspqWA2GYeCX/20rCNKGXt/lfjUwN/i8R92rfpFknwBiAKhvl5NexatosHP
         f7MLP6MBmYBHYX/UwlxWtsJpDW7+xQZJYqiDR6M7uYIBkMz6w0LIZ1CGRA4dOQTrtn49
         AmSv/EHAVW6KuEFJQrTYQyKWmIak+ojTeGqaTiGy43LYtmERpFjdX8KoBCyqqBil9K9i
         8b18jGjhunDRATMXYvR8qlG/JDBkUMNzFAncqt/ykoIqj60MFHUGi7NJ63HNpvtX9nVf
         Tmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710153264; x=1710758064;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRLVssMiMBm2lg/REg1nvG9aYTg9hv9LjzPCPgivj2Y=;
        b=wodjCFhALuoSkIZ+YqbZbhJrjA0eWafPy9oKLCAZNEJFxPE2Cv8Sx+/KfiSFG+UWPW
         yjCWnHDX8TOAYUyu3c3SDjy3qGLMqQ4CbRCAUyqn2/PkHDISUWuP1eCKCi7KfUQA9UtQ
         MR7Spppn8/p1aQD8M3SIN0R5J5Q8udURArmwoJ6em1GuNeHIxa3TwKCRJg4EnJtZvbP1
         gPDCoMJZV3ntHww8CKaNtm/UHIFp87Mv442UDnjXmsx0WjktE2Dj2+eaOTPKeOpGqD5f
         kRCpzzd5pKQjc/YimYlNsKak4RBpTpu8nWq1vI8PJmqJ2oDhzniq+uJLDlVBLohHtNoZ
         6thw==
X-Forwarded-Encrypted: i=1; AJvYcCV1n3KwGR0HWY2pa4hj1HXeN6reinTt0B7njZQ5mYSurZU0wmlbrKF0B+8h0duH/HNa6cmn+2STm4qeS0u1rBDns/L/4Y6WiDZFDNE1
X-Gm-Message-State: AOJu0YzGzoxYamXSAAfjmkwoR5t1VtzoYHV7fGLQ1Kzo66LD/8dZQv38
	69y2hwkQ5Hl3uzpPavcI18C3dyJVV+LIo9MSmXH8zwxutWCJmvkFxdDLpSOGKw==
X-Google-Smtp-Source: AGHT+IGOOOeQ4Kbcbep2uEx4M2X/786xBY5PDjjsALCjv5hLHIy/1YfdCvHIpBqM7yi6/AdedtjPgg==
X-Received: by 2002:a05:600c:5008:b0:413:2fc0:df2 with SMTP id n8-20020a05600c500800b004132fc00df2mr125645wmr.15.1710153264390;
        Mon, 11 Mar 2024 03:34:24 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:691a:3c27:9e39:8252])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b00412e5f32591sm8676170wmo.28.2024.03.11.03.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:34:23 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:34:18 +0100
From: Marco Elver <elver@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on
 RT.
Message-ID: <Ze7eKgdajyEgQcpL@elver.google.com>
References: <20240308175810.2894694-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308175810.2894694-1-bigeasy@linutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Mar 08, 2024 at 06:51PM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> the signal gets delayed until event_sched_out() which then uses
> task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> signal is delivered with disabled preemption.
> 
> While looking at this, I also stumbled upon __perf_pending_irq() which
> requires disabled interrupts but this is not the case on PREEMPT_RT.
> 
> This series aim to address both issues while not introducing a new issue
> at the same time ;)
> Any testing is appreciated.

Unfortunately there's a bug in it somewhere. It can be reproduced with
tools/testing/selftests/perf_events/remove_on_exec.

(FWIW, the kselftests in that directory are more aggressive test cases
that I never figured out how to properly port to the 'perf test'
framework: sigtrap_threads is a more aggressive version of the 'sigtrap'
perf test, and remove_on_exec has no perf test counterpart.)

$ make headers_install
$ cd tools/testing/selftests/perf_events && make
$ ./remove_on_exec

The test appears to pass, but the kernel log shows a few warnings:

[   40.304858] ------------[ cut here ]------------
[   40.307147] unexpected event refcount: 2; ptr=ffffa026c7d94100
[   40.325434] WARNING: CPU: 1 PID: 404 at kernel/events/core.c:5242 perf_event_exit_event+0x1aa/0x1e0
[   40.329603] Modules linked in:
[   40.331401] CPU: 1 PID: 404 Comm: remove_on_exec Not tainted 6.8.0-00004-g852781317836 #1
[   40.336013] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   40.340997] RIP: 0010:perf_event_exit_event+0x1aa/0x1e0
[   40.343374] Code: 5c 41 5d 41 5e 41 5f 5d e9 c3 b6 fe ff e8 3e d5 f7 ff 90 49 8b b6 38 02 00 00 48 c7 c7 6c eb d3 b4 4c 89 f2 e8 f7 66 e0 ff 90 <0f> 0b 90 90 f0 48 ff 8b 38 02 00 00 74 a7 e8 13 d5 f7 ff 5b 41 5c
[   40.352207] RSP: 0000:ffffa4c4c2173c60 EFLAGS: 00010246
[   40.354952] RAX: 35f6eccd09146400 RBX: ffffa026c7d92f48 RCX: ffffa026c3eba200
[   40.358539] RDX: 0000000000000000 RSI: ffffffffb4d389e9 RDI: 00000000ffffffff
[   40.362858] RBP: 00000000ffffffff R08: 0000000000000001 R09: 0000000000000003
[   40.366295] R10: ffffa026c3eba200 R11: ffffffffb3d5caa0 R12: ffffa026c3a31538
[   40.369540] R13: 0000000000000000 R14: ffffa026c7d94100 R15: ffffa026c3a31400
[   40.373569] FS:  0000000000000000(0000) GS:ffffa029efc40000(0000) knlGS:0000000000000000
[   40.377495] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.380214] CR2: 000055bd7562b73f CR3: 000000010970e001 CR4: 0000000000770ef0
[   40.383313] DR0: 000055a5212ab828 DR1: 0000000000000000 DR2: 0000000000000000
[   40.386447] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   40.389492] PKRU: 55555554
[   40.390588] Call Trace:
[   40.391568]  <TASK>
[   40.392432]  ? __warn+0xf6/0x290
[   40.393736]  ? perf_event_exit_event+0x1aa/0x1e0
[   40.395544]  ? report_bug+0x13f/0x1e0
[   40.397039]  ? handle_bug+0x3e/0x70
[   40.398432]  ? exc_invalid_op+0x1a/0x50
[   40.399960]  ? asm_exc_invalid_op+0x1a/0x20
[   40.401561]  ? __pfx_write_msg+0x10/0x10
[   40.403016]  ? perf_event_exit_event+0x1aa/0x1e0
[   40.404707]  perf_event_exec+0x3f5/0x700
[   40.406172]  begin_new_exec+0x720/0x850
[   40.407589]  ? load_elf_phdrs+0x84/0x100
[   40.409030]  load_elf_binary+0x3ba/0xf40
[   40.410457]  ? lock_release+0x23b/0x320
[   40.411795]  ? bprm_execve+0x4f7/0x960
[   40.413101]  bprm_execve+0x502/0x960
[   40.414341]  do_execveat_common+0x23d/0x2a0
[   40.415699]  __x64_sys_execve+0x3a/0x50
[   40.416948]  do_syscall_64+0xf2/0x1d0
[   40.418281]  ? lockdep_hardirqs_on+0x9c/0x150
[   40.419699]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[   40.421267] RIP: 0033:0x7f9ccc6749fb
[   40.422400] Code: Unable to access opcode bytes at 0x7f9ccc6749d1.
[   40.424252] RSP: 002b:00007ffd2371f358 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[   40.426519] RAX: ffffffffffffffda RBX: 00007ffd2371f798 RCX: 00007f9ccc6749fb
[   40.428643] RDX: 00007ffd2371f7a8 RSI: 00007ffd2371f360 RDI: 00005653e364e74a
[   40.430783] RBP: 00007ffd2371f3c0 R08: 00007ffd2371f370 R09: 00007ffd2371f390
[   40.432924] R10: 00005653e364e73f R11: 0000000000000246 R12: 0000000000000000
[   40.434964] R13: 00007ffd2371f7a8 R14: 00007f9ccc7ba000 R15: 00005653e3650dd8
[   40.437052]  </TASK>
[   40.437686] irq event stamp: 2323
[   40.438787] hardirqs last  enabled at (2345): [<ffffffffb2f6725c>] console_unlock+0xec/0x1a0
[   40.441125] hardirqs last disabled at (2356): [<ffffffffb2f67241>] console_unlock+0xd1/0x1a0
[   40.443386] softirqs last  enabled at (2340): [<ffffffffb2ec680f>] __irq_exit_rcu+0x6f/0x100
[   40.445669] softirqs last disabled at (2333): [<ffffffffb2ec680f>] __irq_exit_rcu+0x6f/0x100
[   40.447976] ---[ end trace 0000000000000000 ]---
[   40.474464] ------------[ cut here ]------------
[   40.474467] WARNING: CPU: 6 PID: 390 at kernel/events/core.c:9595 __perf_event_overflow+0x252/0x270
[   40.474483] Modules linked in:
[   40.474486] CPU: 6 PID: 390 Comm: remove_on_exec Tainted: G        W          6.8.0-00004-g852781317836 #1
[   40.474492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   40.474496] RIP: 0010:__perf_event_overflow+0x252/0x270
[   40.474504] Code: 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 c6 b4 f8 ff 31 ed eb e5 e8 bd b4 f8 ff 90 0f 0b 90 e9 24 ff ff ff e8 af b4 f8 ff 90 <0f> 0b 90 e9 2f ff ff ff e8 a1 b4 f8 ff eb e2 66 66 66 66 66 66 2e
[   40.474510] RSP: 0000:ffffa4c4c20dbc88 EFLAGS: 00010046
[   40.474514] RAX: ffffffffb30a65b1 RBX: ffffa026c7d90008 RCX: ffffa026c7948040
[   40.474517] RDX: 0000000080110000 RSI: ffffffffb4e127f5 RDI: ffffffffb4d7dc9a
[   40.474521] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   40.474524] R10: ffffa4c4c20dbd00 R11: ffffffffb2e071c0 R12: 0000003000000063
[   40.474528] R13: 0000002000000001 R14: ffffa4c4c20dbf58 R15: ffffa4c4c20dbd00
[   40.474531] FS:  00007f9ccc77d680(0000) GS:ffffa029efd80000(0000) knlGS:0000000000000000
[   40.474536] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.474540] CR2: 00007f9ccc77dfa8 CR3: 0000000104fd8004 CR4: 0000000000770ef0
[   40.474546] DR0: 000055a5212ab828 DR1: 0000000000000000 DR2: 0000000000000000
[   40.474549] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   40.474552] PKRU: 55555554
[   40.474554] Call Trace:
[   40.474556]  <TASK>
[   40.474558]  ? __warn+0xf6/0x290
[   40.474570]  ? __perf_event_overflow+0x252/0x270
[   40.474578]  ? report_bug+0x13f/0x1e0
[   40.474588]  ? handle_bug+0x3e/0x70
[   40.474598]  ? exc_invalid_op+0x1a/0x50
[   40.474608]  ? asm_exc_invalid_op+0x1a/0x20
[   40.474622]  ? __pfx_perf_event_nmi_handler+0x10/0x10
[   40.474633]  ? __perf_event_overflow+0x251/0x270
[   40.474641]  ? __perf_event_overflow+0x252/0x270
[   40.474648]  ? __perf_event_overflow+0x251/0x270
[   40.474656]  intel_pmu_handle_irq+0x3ab/0xb20
[   40.474680]  ? verify_lock_unused+0xb/0x70
[   40.474691]  ? lock_acquire+0x1ab/0x250
[   40.474700]  ? nmi_handle+0x30/0x310
[   40.474709]  perf_event_nmi_handler+0x2d/0x60
[   40.474719]  ? nmi_handle+0x30/0x310
[   40.474724]  nmi_handle+0xf9/0x310
[   40.474730]  ? trace_rcu_dyntick+0x41/0xe0
[   40.474738]  ? nmi_handle+0x30/0x310
[   40.474746]  default_do_nmi+0x63/0x160
[   40.474757]  exc_nmi+0xbc/0x110
[   40.474768]  asm_exc_nmi+0xb6/0xff
[   40.474773] RIP: 0033:0x5653e364d7c5
[   40.474777] Code: d4 83 45 c4 01 8b 45 c4 83 f8 1d 0f 86 28 fe ff ff 8b 05 2e 3f 00 00 89 85 2c ff ff ff 90 8b 15 21 3f 00 00 8b 85 2c ff ff ff <39> c2 74 f0 90 90 c9 c3 55 48 89 e5 48 81 ec b0 00 00 00 48 8d 95
[   40.474782] RSP: 002b:00007ffd2371f3d0 EFLAGS: 00000246
[   40.474786] RAX: 0000000000000005 RBX: 00007ffd2371f798 RCX: 00007f9ccc5d894b
[   40.474789] RDX: 0000000000000005 RSI: 0000000000000009 RDI: 00000000000001a4
[   40.474793] RBP: 00007ffd2371f4d0 R08: 0000000000000000 R09: 0000000000000000
[   40.474796] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   40.474799] R13: 00007ffd2371f7a8 R14: 00007f9ccc7ba000 R15: 00005653e3650dd8
[   40.474809]  </TASK>
[   40.474811] irq event stamp: 27946
[   40.474812] hardirqs last  enabled at (27945): [<ffffffffb458ed78>] exc_nmi+0xc8/0x110
[   40.474824] hardirqs last disabled at (27946): [<ffffffffb458ed52>] exc_nmi+0xa2/0x110
[   40.474834] softirqs last  enabled at (27854): [<ffffffffb2e59aa9>] fpu__restore_sig+0x229/0x870
[   40.474844] softirqs last disabled at (27852): [<ffffffffb2e59aa9>] fpu__restore_sig+0x229/0x870
[   40.474853] ---[ end trace 0000000000000000 ]---

Thanks,
-- Marco

