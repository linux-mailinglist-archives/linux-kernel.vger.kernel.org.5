Return-Path: <linux-kernel+bounces-75934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A4385F0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44959B23C09
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93462D516;
	Thu, 22 Feb 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjudrUhL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5DF79D0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579296; cv=none; b=R7gs6wNui/UMuehxaD6RY5au9zEPXeNIDXdHj+vZ+BC/OFFnQuS+4b06xf+nMdqmQO75HelRrAZ1gLGq3QrbOLU3l88u5ruaTxjRnvx3XCUXejp/uNmy0QJlgmi+PfbkNHf1w6u95+15Ntu3GFYhVqm3OBd9wNXmIovtzBal7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579296; c=relaxed/simple;
	bh=clNU+CHfY5pTfG1nn7CRpwDXvrsR8UQLN0NnxFWBUIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4oclCzhS3oj7l3eT832GzjV95VEkfUz0iBYGwiXv4JCBRb2cP7S29E+XQYAUAOjsrV20aA6WjYOlkFgrgb68fFrIUdGVwBxVGUllv22TGOGpVGFAHvnQur7buCrzW0ba4k6WGSfyE+YO36pXnuSkmVj7dKnr1x8SdgP8IoVGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjudrUhL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708579288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CQpgDbtPBz4TnGFb/kH0YBHqC72JwhJ5NdpaB6sOs6o=;
	b=PjudrUhL9gu0QTJKohBlQ9mfbs+rAIwuBUc4/KWw8fLxQ7ACRAld9VCtXxQIz9LQWfzXzs
	HGX8B3idj2HbSbXO0WcbIogpExKh7Nmyh1b/Z4bmK00NvKyP94/3RB6OYOE7m9VSuJ0H90
	jbtPrTlaJLOEeYMSO8mHvlus0GsPbVM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-qpa2dXbeNnyV_zrgrbzZGA-1; Thu, 22 Feb 2024 00:21:26 -0500
X-MC-Unique: qpa2dXbeNnyV_zrgrbzZGA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f992b7fc3so10025856d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708579285; x=1709184085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQpgDbtPBz4TnGFb/kH0YBHqC72JwhJ5NdpaB6sOs6o=;
        b=DCTGqSQnq1UnbdQsvZMLo+K/E7vsha+X+Qm7cF0MRWhW5NMGc3WAk2Ll0eS6quRFcQ
         u7ep7PDF7RHL4sIgDNNYTKILok6IQJNWRcvSe3etHtSqWGgYhirI5JLRSBwXa+mp0qCm
         0bCkdRHmNmGnqcPL9hAGnbPnJ+6b6LiWmAlod/OXIHzd/ovoNO9PJYGv8dJVGQFWCzAC
         zSMXpt+mqq5hV21g/taAwgAgvOKxjRg+9F+vsPLJAVMJ5js9AHnr1MSYgShcwvT/UkKL
         cZsQwPjO8gL/1eWAfr/oeEPbU83jMsxC93rAeiEuiDUvKQMvhYESUr2eQ496EL/sRl2x
         p9+w==
X-Forwarded-Encrypted: i=1; AJvYcCXbrjAKT1o/OAt+1hT40z4XRgDQ7xc98RPc7i056sYSh9UQkOHjd6Hm5VWbq5c/sQsbWvP+HsvXoUbGTUtDZkWeOFaP6n09ekZODGrC
X-Gm-Message-State: AOJu0YzQdX6AiDZ2yhmUK+Oiaah1DoKpomiOSymDh8RkiuzBEk9eYus+
	5QdZtCwdyaiy6/kDCz+uu136Oi88X/yaUo8x9W1eqbYgJa8B75Fxogtc0Hu4dpKKnhoVM6VtIyx
	btrBCrDdsbuk6S85d7BpqGOyJ2E4WelFapSoFjhhAWc9RdiGwqWyIc9v8C7B635xtxELws6U9
X-Received: by 2002:a0c:f34d:0:b0:68f:b941:3463 with SMTP id e13-20020a0cf34d000000b0068fb9413463mr1473697qvm.3.1708579283517;
        Wed, 21 Feb 2024 21:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElLT3ch4OgyomIxi/vdEQYzq+3XGxmBiN4+gFj831h/J0/H42kaeck9Y0LFOS294hqiULyUQ==
X-Received: by 2002:a0c:f34d:0:b0:68f:b941:3463 with SMTP id e13-20020a0cf34d000000b0068fb9413463mr1473657qvm.3.1708579282261;
        Wed, 21 Feb 2024 21:21:22 -0800 (PST)
Received: from thinkpad2021 ([71.217.42.17])
        by smtp.gmail.com with ESMTPSA id na3-20020a0562142d4300b0068d1cb18b9bsm6320267qvb.26.2024.02.21.21.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:21:21 -0800 (PST)
Date: Thu, 22 Feb 2024 00:21:19 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	jlelli@redhat.com, Derek Barbosa <debarbos@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: NMI Reported with console_blast.sh
Message-ID: <ZdbZz-v_lug9_t6C@thinkpad2021>
References: <ZcQjxa4UA6hzXHnU@thinkpad2021>
 <87v86yc88b.fsf@jogness.linutronix.de>
 <ZcaQI8l1dcBx2feC@thinkpad2021>
 <87a5o8j9gp.fsf@jogness.linutronix.de>
 <ZcqMOKtHsZ9qnxNg@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcqMOKtHsZ9qnxNg@thinkpad2021>

On Mon, Feb 12, 2024 at 04:23:04PM -0500, John B. Wyatt IV wrote:
> 
> Red Hat's conservers are having an issue with the machine I was testing
> on. It may take me a while to get back to you with more test results.
> 

Found a work-around with conserver. I was able to follow up on the printk-caller
info you requested.

I found 2 additional NMIs for a total of 3. Number 2 is very
large-please feel free to let me know what specific information you
wanted if it was unnecessary.

This first one (the original) is with the real-time profile (no preemption).
The next two are with the performance-througput (no preemption).

This is what real-time NMI reports with the caller information enabled. It
looks like it is lacking some information compared to the other two further below.

[ T2481] Call Trace:
[ T2477] Kernel panic - not syncing: sysrq triggered crash
[    C0] NMI backtrace for cpu 0
[    C0] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.9409.D04.2212261349 12/26/2022
[ C0] RIP: 0010:io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] Code: cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 0f b6 8f c1 00 00 00 0f b7 57 08 d3 e6 01 f2 ec <0f> b6 c0 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	cc                   	int3
   1:	0f 1f 40 00          	nopl   0x0(%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	0f b6 8f c1 00 00 00 	movzbl 0xc1(%rdi),%ecx
  21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
  25:	d3 e6                	shl    %cl,%esi
  27:	01 f2                	add    %esi,%edx
  29:	ec                   	in     (%dx),%al
  2a:*	0f b6 c0             	movzbl %al,%eax		<-- trapping instruction
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	0f 1f 00             	nopl   (%rax)
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f b6 c0             	movzbl %al,%eax
   3:	c3                   	ret
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	0f 1f 00             	nopl   (%rax)
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[    C0] RSP: 0018:ff4507d95ec1fac0 EFLAGS: 00000002
[    C0] RAX: ffffffffa13d6f00 RBX: 0000000000000000 RCX: 0000000000000000
[    C0] RDX: 00000000000003fd RSI: 0000000000000005 RDI: ffffffffa3ad49c0
[    C0] RBP: 000000000000270f R08: ffffffffa39c73b3 R09: ff4507d95ec1fa1f
[    C0] R10: 0000000031383432 R11: 0000000038343254 R12: 0000000000000020
[    C0] R13: ffffffffa3ad49c0 R14: 0000000000000000 R15: 0000000000000000
[    C0] FS:  00007fd6cce81740(0000) GS:ff1ef00bbf800000(0000) knlGS:0000000000000000
[    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    C0] CR2: 00007fd6cd05d650 CR3: 000000208e5bc004 CR4: 0000000000771ef0
[    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    C0] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[    C0] PKRU: 55555554
[    C0] Call Trace:
[    C0]  <NMI>
[ C0] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
[ C0] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47 (discriminator 1)) 
[ C0] ? nmi_handle (arch/x86/kernel/nmi.c:150) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] ? default_do_nmi (arch/x86/kernel/nmi.c:351) 
[ C0] ? exc_nmi (arch/x86/kernel/nmi.c:545) 
[ C0] ? end_repeat_nmi (arch/x86/entry/entry_64.S:1394) 
[ C0] ? mem_serial_out (drivers/tty/serial/8250/8250_port.c:368) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[ C0] ? io_serial_in (arch/x86/kernel/early_printk.c:100) 
[    C0]  </NMI>
[    C0]  <TASK>

------------------------------------

Compared to the two NMIs with throughput-performance (no preemption)

  <NMI>
  cpus=0
   .runnable_avg                  : 3072
 kthread (kernel/kthread.c:388) 
   .util_est_enqueued             : 0
  stack:0     pid:1733  tgid:1733  ppid:2      flags:0x00004000
   .min_vruntime                  : 2084315.290254
   .removed.load_avg              : 0
   .avg_vruntime                  : 2084315.290254
 console_blast.s  3497     34770.405603 N     34773.405603         3.000000     34764.898340         4   120 
   .util_avg                      : 1024
   .util_avg                      : 1024
   .util_est_enqueued             : 0
   .left_vruntime                 : 0.000001
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .removed.util_avg              : 0
 worker_thread (kernel/workqueue.c:2734) 
         0.000000     34764.898340         0.000000         0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
   .min_vruntime                  : 3166003.080642
   .se->vruntime                  : 4421649.079833
 Call Trace:
   .spread                        : 0.000000
 RDX: 00007fffb4d634a0 RSI: 0000000000000000 RDI: 0000000000000000
   .removed.load_avg              : 0
  <TASK>
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .right_vruntime                : 0.000001
   .removed.runnable_avg          : 0
   .avg_vruntime                  : 3166003.080642
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .util_est_enqueued             : 1576
  </TASK>
   .se->sum_exec_runtime          : 34772.922820
   .right_vruntime                : 0.000001
   .curr->pid                     : 0
   .removed.load_avg              : 0
   .removed.util_avg              : 0
   .removed.load_avg              : 0
   .tg_load_avg_contrib           : 2042
  /user.slice/user-0.slice/session-1.scope
   .spread                        : 0.000000
   .removed.runnable_avg          : 0
   .removed.util_avg              : 0
   .se->load.weight               : 8798
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .se->avg.load_avg              : 7
 task:kworker/162:1   state:I
 
  I
   .removed.runnable_avg          : 0
   .tg_load_avg_contrib           : 8
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .spread                        : 0.000000
   .tg_load_avg_contrib           : 4
 ? __pfx_kthread (kernel/kthread.c:341) 
   .removed.util_avg              : 0
 kworker/u453:14  1537      8085.292524 E      8088.278508         3.000000        48.419745       146   120 
  <TASK>
   .tg_load_avg                   : 178559
   .nr_spread_over                : 0
  S
   .tg_load_avg                   : 1488
   .tg_load_avg                   : 1488
 console_blast.s  3717         6.183406 E         8.771080         3.000000         3.211160         4   120 
   .nr_spread_over                : 0
   .throttled                     : 0
   .removed.runnable_avg          : 0
   .nr_running                    : 1
   .throttled                     : 0
   .nr_running                    : 1
   .throttled                     : 0
   .se->avg.util_avg              : 1024
   .throttle_count                : 0
   .throttle_count                : 0
   .h_nr_running                  : 3
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
         0.000000         3.211160         0.000000         0.000000
   .tg_load_avg_contrib           : 0
   .idle_nr_running               : 0
 RBP: 00007fffb4d63450 R08: 0000000000000000 R09: 0000000000000000
 worker_thread (kernel/workqueue.c:2734) 
   .throttle_count                : 0
  /user.slice/user-0.slice/session-1.scope
   .se->avg.runnable_avg          : 3072
   .se->exec_start                : 208059.574049
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
   .h_nr_running                  : 2
   .se->exec_start                : 208050.612936
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .tg_load_avg                   : 0
   .se->exec_start                : 208020.052027
   .idle_h_nr_running             : 0
   .throttled                     : 0
   .idle_nr_running               : 0
   .se->vruntime                  : 11608324.604177
   .throttle_count                : 0
   .load                          : 18045
   .se->vruntime                  : 7056777.768657
 ? __pfx_kthread (kernel/kthread.c:341) 
 
 
   .idle_h_nr_running             : 0
   .se->sum_exec_runtime          : 34774.514688
  S
 cfs_rq[25]:/user.slice
 ? __pfx_kthread (kernel/kthread.c:341) 
         0.000000        48.419745         0.000000         0.000000
   .se->sum_exec_runtime          : 34430.603888
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .se->vruntime                  : 3166003.080642
 ? __pfx_kthread (kernel/kthread.c:341) 
   .load                          : 12026
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .exec_clock                    : 0.000000
   .se->load.weight               : 5637
   .se->load.weight               : 3523
 console_blast.s  3909         7.636665 E        10.235762         3.000000         3.107414         4   120 
   .load_avg                      : 11
 
 kthread (kernel/kthread.c:388) 
   .load_avg                      : 17
  (mm_percpu_wq)
   .left_vruntime                 : 0.000001
   .se->sum_exec_runtime          : 34424.300264
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 rt_rq[27]:
         0.000000         0.005913         0.000000         0.000000
   .runnable_avg                  : 3073
   .min_vruntime                  : 4421649.079833
   .rt_nr_running                 : 0
   .se->avg.load_avg              : 2
   .clock                         : 208093.933560
  node=0
         0.000000         3.107414         0.000000         0.000000
   .runnable_avg                  : 2047
   .se->avg.load_avg              : 4
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .se->avg.util_avg              : 1023
   .util_avg                      : 1023
   .rt_throttled                  : 0
   .avg_vruntime                  : 4421649.079833
   .nr_spread_over                : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .util_avg                      : 1024
   .se->load.weight               : 12026
   .se->avg.runnable_avg          : 2047
 ? _raw_spin_unlock (./arch/x86/include/asm/preempt.h:104 ./include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186) 
  /user.slice/user-0.slice/session-1.scope
   .rt_time                       : 0.000000
 ret_from_fork (arch/x86/kernel/process.c:147) 
 
   .util_est_enqueued             : 0
   .right_vruntime                : 0.000001
 ? __pfx_kthread (kernel/kthread.c:341) 
  S
   .util_est_enqueued             : 0
   .rt_runtime                    : 950.000000
   .se->avg.load_avg              : 10
   .clock_task                    : 208036.282491
 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .se->avg.util_avg              : 1024
 console_blast.s  4010         4.594964 E         7.189746         3.000000         2.839766         4   120 
 
   .removed.load_avg              : 0
   .spread                        : 0.000000
   .se->avg.util_avg              : 1023
   .removed.load_avg              : 0
   .removed.util_avg              : 0
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 ? __pfx_kthread (kernel/kthread.c:341) 
   .removed.runnable_avg          : 0
   .nr_spread_over                : 0
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .tg_load_avg_contrib           : 17
 Workqueue:  0x0
   .se->avg.runnable_avg          : 3072
 cfs_rq[50]:/
 task:kworker/u453:19 state:I
 dl_rq[27]:
   .tg_load_avg                   : 2026
   .removed.util_avg              : 0
  flags=0x0 nice=0
  /
 
   .dl_nr_running                 : 0
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
         0.000000         2.839766         0.000000         0.000000
   .dl_bw->bw                     : 996147
  </TASK>
 
   .throttled                     : 0
   .removed.runnable_avg          : 0
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .exec_clock                    : 0.000000
   .se->avg.runnable_avg          : 2047
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .nr_running                    : 1
 cfs_rq[16]:/
 
  /user.slice/user-0.slice/session-1.scope
 R10: 00007fffb4d63490 R11: 0000000000000202 R12: 00007f4a03e696c8
   .tg_load_avg_contrib           : 11
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .h_nr_running                  : 3
   .exec_clock                    : 0.000000
 
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .throttle_count                : 0
   .left_vruntime                 : 268170.491452
 RSP: 002b:00007ffd3c9630d8 EFLAGS: 00000202
  stack:0     pid:1563  tgid:1563  ppid:2      flags:0x00004000
   .left_vruntime                 : 64498.686713
   .tg_load_avg                   : 2026
   .se->exec_start                : 208007.448274
 Call Trace:
 kthread (kernel/kthread.c:388) 
   .min_vruntime                  : 268170.906344
   .se->vruntime                  : 4438283.868821
   .nr_running                    : 1
   .throttled                     : 0
   .idle_nr_running               : 0
   .dl_bw->total_bw               : 0
 
  active=1/256 refcnt=2
   .min_vruntime                  : 64498.686713
   .throttle_count                : 0
 kthread (kernel/kthread.c:388) 
 RIP: 0033:0x7fcfe00a4d07
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .avg_vruntime                  : 289098.917351
   .avg_idle                      : 4953240
  S
   .se->sum_exec_runtime          : 34382.705140
 
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  I
 runnable tasks:
 cfs_rq[53]:/user.slice/user-0.slice
   .se->exec_start                : 208059.574049
   .se->load.weight               : 8798
 console_blast.s  4084         5.771080 E         8.366011         3.000000         2.424395         3   120 
 RSP: 002b:00007ffec60d77c8 EFLAGS: 00000202
     pending:
   .se->avg.load_avg              : 7
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 RSP: 002b:00007ffe0b913168 EFLAGS: 00000202
   .avg_vruntime                  : 82619.613072
   .exec_clock                    : 0.000000
  vmstat_update
         0.000000         2.424395         0.000000         0.000000
  ORIG_RAX: 00000000000000e6
   .idle_h_nr_running             : 0
   .left_vruntime                 : 0.000001
 kthread (kernel/kthread.c:388) 
  /user.slice/user-0.slice/session-1.scope
 ? __pfx_kthread (kernel/kthread.c:341) 
   .right_vruntime                : 66687.032812
   .se->vruntime                  : 6969082.950841
   .se->avg.util_avg              : 1024
   .right_vruntime                : 276865.549246
  </TASK>
   .spread                        : 2188.346099
 task:kcompactd2      state:S
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 Workqueue:  0x0
   .nr_spread_over                : 0
 R13: 00007fffb4d63490 R14: 0000000000000002 R15: 00007fffb4d63490
   .se->sum_exec_runtime          : 34424.300264
  <TASK>
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .spread                        : 8695.057794
   .min_vruntime                  : 3166003.080642
 
  kworker/169:0H  1036       184.779405 E       184.813648         3.000000         0.051581         4   100 
   .load                          : 8798
   .se->load.weight               : 5693
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .avg_vruntime                  : 3166003.080642
   .load_avg                      : 8
 ? __pfx_kthread (kernel/kthread.c:341) 
  (events_unbound)
   .nr_running                    : 3
   .h_nr_running                  : 3
  R
 task:kworker/27:1    state:R
  </TASK>
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .right_vruntime                : 0.000001
   .max_idle_balance_cost         : 2418910
  </TASK>
 ? __pfx_kthread (kernel/kthread.c:341) 
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .se->avg.runnable_avg          : 3073
   .h_nr_running                  : 5
           sleep  4214       767.966687 E       770.966687         3.000000         1.092834         1   120 
 
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  ORIG_RAX: 000000000000003d
   .se->avg.load_avg              : 4
   .nr_spread_over                : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .se->avg.util_avg              : 1023
   .runnable_avg                  : 3072
   .spread                        : 0.000000
 -------------------------------------------------------------------------------------------------------------
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 task:idle_inject/127 state:S
   .util_avg                      : 1024
         0.000000         1.092834         0.000000         0.000000
   .idle_nr_running               : 0
   .nr_spread_over                : 0
 cfs_rq[52]:/user.slice
 task:ksoftirqd/10    state:S
   .se->avg.runnable_avg          : 2047
   .idle_nr_running               : 0
  /user.slice/user-0.slice/session-1.scope
   .util_est_enqueued             : 0
   .nr_running                    : 3
 
 
   .exec_clock                    : 0.000000
   .removed.load_avg              : 0
   .h_nr_running                  : 4
   .idle_h_nr_running             : 0
  S
   .idle_nr_running               : 0
 cfs_rq[53]:/user.slice
  R
   .exec_clock                    : 0.000000
        cpuhp/27   179       492.490190 E       495.485947         3.000000         1.582983        35   120 
   .nr_running                    : 1
   .load                          : 2102789
   .removed.util_avg              : 0
   .idle_h_nr_running             : 0
           sleep  4276      1145.889782 E      1148.889782         3.000000         0.995931         2   120 
   .removed.runnable_avg          : 0
   .left_vruntime                 : 0.000001
   .load_avg                      : 2053
   .left_vruntime                 : 0.000001
   .runnable_avg                  : 5120
   .util_avg                      : 1024
         0.000000         1.582983         0.000000         0.000000
   .h_nr_running                  : 2
  </TASK>
 ? handle_mm_fault (mm/memory.c:5222 mm/memory.c:5361) 
 RAX: ffffffffffffffda RBX: 00007ffec60d7820 RCX: 00007f008c94c167
         0.000000         0.995931         0.000000         0.000000
   .min_vruntime                  : 6969082.950841
   .idle_nr_running               : 0
   .min_vruntime                  : 4438565.660308
   .util_est_enqueued             : 1342
   .idle_h_nr_running             : 0
   .tg_load_avg_contrib           : 8
  /user.slice/user-0.slice/session-1.scope
   .avg_vruntime                  : 4438565.660308
  /
   .load                          : 2100675
   .removed.load_avg              : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .right_vruntime                : 0.000001
   running task    
 
   .removed.util_avg              : 0
   .avg_vruntime                  : 6969082.950841
 worker_thread (kernel/workqueue.c:2734) 
 
  stack:0     pid:80    tgid:80    ppid:2      flags:0x00004000
  S
   .right_vruntime                : 0.000001
   .removed.runnable_avg          : 0
   .tg_load_avg                   : 1488
  idle_inject/27   180        -1.045772 E         1.951454         3.000000         0.007012         3    49 
   .load_avg                      : 2050
 RDX: 00007ffec60d7820 RSI: 0000000000000000 RDI: 0000000000000000
 ? __pfx_kthread (kernel/kthread.c:341) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 task:kworker/38:0H   state:I
   .spread                        : 0.000000
   .spread                        : 0.000000
   .tg_load_avg_contrib           : 0
 ? __pfx_rescuer_thread (kernel/workqueue.c:2822) 
         0.000000         0.007012         0.000000         0.000000
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  (mm_percpu_wq)
 
   .idle_h_nr_running             : 0
   .load                          : 12026
 ? __pfx_kthread (kernel/kthread.c:341) 
 Workqueue:  0x0
  /
  stack:0     pid:780   tgid:780   ppid:2      flags:0x00004000
 ? __pfx_kthread (kernel/kthread.c:341) 
   .throttled                     : 0
 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .tg_load_avg                   : 0
   .load_avg                      : 11
   .nr_spread_over                : 0
   .throttle_count                : 0
 cpu#20, 1900.000 MHz
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
  </TASK>
   .throttled                     : 0
 
   .throttle_count                : 0
   .runnable_avg                  : 4095
 ? __pfx_kthread (kernel/kthread.c:341) 
 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5839 (discriminator 1) kernel/sched/core.c:5836 (discriminator 1) kernel/sched/core.c:5864 (discriminator 1)) 
   .nr_running                    : 1
   .util_avg                      : 1023
   .runnable_avg                  : 2047
  stack:0     pid:1774  tgid:1774  ppid:2      flags:0x00004000
   .se->exec_start                : 208020.176498
 
   .nr_running                    : 6
  R
   .h_nr_running                  : 3
 RAX: ffffffffffffffda RBX: 00000000000010bb RCX: 00007fcfe00a4d07
   .util_avg                      : 1023
    migration/27   181        42.523932 E        43.273173         0.750000     10240.439543        46     0 
   .nr_switches                   : 502
   .nr_spread_over                : 0
 rt_rq[16]:
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
         0.000000     10240.439543         0.000000         0.000000
 Call Trace:
   .se->vruntime                  : 7029113.257567
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .idle_nr_running               : 0
   .se->sum_exec_runtime          : 34775.606149
   .util_est_enqueued             : 0
   .idle_h_nr_running             : 0
   .removed.load_avg              : 0
   .rt_nr_running                 : 0
   .util_est_enqueued             : 755
   .removed.util_avg              : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
  /
 Call Trace:
  /
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  stack:0     pid:1641  tgid:1641  ppid:2      flags:0x00004000
 
   .se->load.weight               : 5637
   .removed.runnable_avg          : 0
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .se->avg.load_avg              : 4
 ? __pfx_kthread (kernel/kthread.c:341) 
  stack:0     pid:250   tgid:250   ppid:2      flags:0x00004000
 Call Trace:
  R
   .nr_uninterruptible            : 20
   .rt_throttled                  : 0
   .nr_running                    : 1
  <TASK>
   .load                          : 8798
   .tg_load_avg_contrib           : 11
   .removed.load_avg              : 0
 rt_rq[162]:
   .rt_time                       : 0.000000
  </TASK>
   .load_avg                      : 8
  </TASK>
         0.000000         0.051581         0.000000         0.000000
   .tg_load_avg                   : 2026
 
   .rt_runtime                    : 950.000000
   .throttled                     : 0
   .load                          : 18039
  stack:0     pid:1603  tgid:1603  ppid:2      flags:0x00004000
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
    ksoftirqd/27   182     31046.484334 E     31049.484334         3.000000         0.009125         9   120 
 
   .removed.util_avg              : 0
 task:kworker/18:0    state:I
   .h_nr_running                  : 2
  ORIG_RAX: 00000000000000e6
   .removed.runnable_avg          : 0
         0.000000         0.009125         0.000000         0.000000
   .next_balance                  : 4294.870336
 dl_rq[16]:
   .throttle_count                : 0
  </TASK>
   .se->avg.util_avg              : 1024
   .runnable_avg                  : 3073
   .dl_nr_running                 : 0
   .curr->pid                     : 3500
   .util_avg                      : 1024
   .se->avg.runnable_avg          : 3072
  /
 Workqueue:  0x0
   .rt_nr_running                 : 0
 
   .load_avg                      : 17
   .util_est_enqueued             : 0
   .clock                         : 208129.798673
  stack:0     pid:129   tgid:129   ppid:2      flags:0x00004000
   .tg_load_avg_contrib           : 0
   .clock_task                    : 208003.714540
   .tg_load_avg                   : 0
   .removed.load_avg              : 0
   .dl_bw->bw                     : 996147
 worker_thread (kernel/workqueue.c:2734) 
   .removed.util_avg              : 0
 Call Trace:
 
   .throttled                     : 0
   .se->exec_start                : 208059.574049
 kthread (kernel/kthread.c:388) 
   .dl_bw->total_bw               : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 cfs_rq[25]:/
 
   .avg_idle                      : 1000000
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 RAX: ffffffffffffffda RBX: 00007ffd3c963130 RCX: 00007f1e54fc1167
  (events_highpri)
   .max_idle_balance_cost         : 500000
 Workqueue:  0x0
  /
   .idle_nr_running               : 0
 
  <TASK>
  I
  I
   .rt_throttled                  : 0
   .exec_clock                    : 0.000000
 
    kworker/27:0   183        48.316899 E        51.309998         3.000000         0.035706        13   120 
 
 Call Trace:
 workqueue pm: flags=0x4
 runnable tasks:
 kthread (kernel/kthread.c:388) 
 task:ksoftirqd/11    state:R
 ? __pfx_kthread (kernel/kthread.c:341) 
 kworker/u453:18  1557        31.410494 E        33.875313         3.000000        32.452367         3   120 
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .se->vruntime                  : 6969082.950841
 Call Trace:
 RDX: 0000000000000000 RSI: 00007ffe0b9131a0 RDI: 00000000ffffffff
 task:sleep           state:R
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  </TASK>
 cfs_rq[20]:/user.slice/user-0.slice/session-1.scope
   .removed.runnable_avg          : 0
   .idle_h_nr_running             : 0
  </TASK>
 task:kworker/u452:22 state:I
 task:cpuhp/97        state:S
 -------------------------------------------------------------------------------------------------------------
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .load                          : 5693
 RDX: 00007ffd3c963130 RSI: 0000000000000000 RDI: 0000000000000000
         0.000000         0.035706         0.000000         0.000000
   .se->sum_exec_runtime          : 34424.300264
   .throttle_count                : 0
   .exec_clock                    : 0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
   .left_vruntime                 : 235690.131483
  <TASK>
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 smpboot_thread_fn (kernel/smpboot.c:160) 
 task:migration/106   state:S
   .tg_load_avg_contrib           : 8
   .se->load.weight               : 5693
   .left_vruntime                 : 786.779707
 
  /
   .min_vruntime                  : 786.779707
 
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .load_avg                      : 4
   .min_vruntime                  : 235691.830156
  </TASK>
   .rt_time                       : 0.000000
 kthread (kernel/kthread.c:388) 
   .se->avg.load_avg              : 4
  S
   pwq 8:
   .runnable_avg                  : 2047
  <TASK>
   .avg_vruntime                  : 255911.103082
 
   .right_vruntime                : 243059.798538
   .util_avg                      : 1023
 task:kworker/u454:24 state:I
 task:kworker/u451:12 state:I
  cpus=4
 rt_rq[50]:
        cpuhp/16   113      7939.980674 E      7942.976661         3.000000         1.507300        35   120 
   .util_est_enqueued             : 0
  <TASK>
  stack:0     pid:599   tgid:599   ppid:2      flags:0x00004000
 Workqueue:  0x0
   .spread                        : 7369.667055
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->avg.util_avg              : 1023
   .rt_nr_running                 : 0
  (events_unbound)
   running task    
  I
   .avg_vruntime                  : 12248.530216
   .rt_throttled                  : 0
   .tg_load_avg                   : 1488
 Workqueue:  0x0
   kworker/27:0H   184        53.122947 E        53.157084         3.000000         0.048039         4   100 
  </TASK>
  stack:0     pid:86    tgid:86    ppid:2      flags:0x00004000
         0.000000         1.507300         0.000000         0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
         0.000000         0.048039         0.000000         0.000000
  <TASK>
   .se->avg.runnable_avg          : 2047
   .throttled                     : 0
  /
   .nr_spread_over                : 0
   .rt_time                       : 0.000000
  /
 
 RBP: 00007ffd3c9630e0 R08: 0000000000000000 R09: 0000000000000000
 
  (mm_percpu_wq)
  node=0
   .right_vruntime                : 1164.357159
   .nr_running                    : 3
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .h_nr_running                  : 5
 ret_from_fork (arch/x86/kernel/process.c:147) 
  S
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .throttle_count                : 0
 RBP: 00007ffec60d77d0 R08: 0000000000000000 R09: 0000000000000000
   running task    
  flags=0x0 nice=0
 
 cfs_rq[53]:/user.slice
  stack:0     pid:1467  tgid:1467  ppid:2      flags:0x00004000
 ret_from_fork (arch/x86/kernel/process.c:147) 
  <TASK>
   .removed.load_avg              : 0
   .idle_nr_running               : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .exec_clock                    : 0.000000
 rescuer_thread (kernel/workqueue.c:2932) 
  stack:0     pid:4247  tgid:4247  ppid:3813   flags:0x00000002
   .rt_runtime                    : 950.000000
   .removed.util_avg              : 0
   .left_vruntime                 : 0.000001
  stack:0     pid:655   tgid:655   ppid:2      flags:0x00004000
   .se->exec_start                : 208012.340322
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  stack:0     pid:1509  tgid:1509  ppid:2      flags:0x00004000
   .removed.runnable_avg          : 0
  idle_inject/16   114        -1.031481 E         1.966572         3.000000         0.006806         3    49 
   .min_vruntime                  : 6969082.950841
   .spread                        : 377.577452
   .se->vruntime                  : 7059421.129015
 
   .nr_spread_over                : 0
         0.000000         0.006806         0.000000         0.000000
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_kthread (kernel/kthread.c:341) 
  active=1/256 refcnt=2
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 Call Trace:
   .avg_vruntime                  : 6969082.950841
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .nr_running                    : 3
 task:kworker/u455:21 state:I
  /
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
         0.000000        32.452367         0.000000         0.000000
 dl_rq[50]:
   .se->sum_exec_runtime          : 34387.597188
 Stopper: 0x0 <- 0x0
   .right_vruntime                : 0.000001
 task:taskset         state:S
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 RBP: 00007ffe0b9131e0 R08: 0000555adf8191d0 R09: 0000000000000001
   .spread                        : 0.000000
  (mm_percpu_wq)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .idle_h_nr_running             : 0
   .dl_nr_running                 : 0
   .nr_spread_over                : 0
  I
 ? up_read (./arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1622) 
 R10: 00007ffd3c963120 R11: 0000000000000202 R12: 00007f1e54ee56c8
   .tg_load_avg_contrib           : 4
   .dl_bw->bw                     : 996147
 R10: 00007ffec60d7810 R11: 0000000000000202 R12: 00007f008c8706c8
   .rt_runtime                    : 950.000000
   .tg_load_avg                   : 1488
  kworker/u453:4  1401        48.633974 E        49.637603         3.000000        49.674597         3   120 
   .nr_running                    : 1
  I
   .throttled                     : 0
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .load                          : 2102789
   .se->load.weight               : 5637
   .dl_bw->total_bw               : 0
 
   .h_nr_running                  : 3
   .h_nr_running                  : 2
   .se->avg.load_avg              : 4
 
 do_nanosleep (kernel/time/hrtimer.c:1446 kernel/time/hrtimer.c:2049) 
   .throttle_count                : 0
  R
 R13: 00007ffec60d7810 R14: 0000000000000002 R15: 00007ffec60d7810
 kworker/u450:14  1447        40.793566 E        41.382099         3.000000        41.838568         3   120 
   .idle_nr_running               : 0
 runnable tasks:
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
 Call Trace:
    migration/16   115        39.390982 E        40.140140         0.750000     10230.050371        46     0 
 ? do_user_addr_fault (arch/x86/mm/fault.c:1445 (discriminator 1)) 
         0.000000        41.838568         0.000000         0.000000
   .load_avg                      : 2053
  <TASK>
         0.000000        49.674597         0.000000         0.000000
   .se->exec_start                : 208059.574049
   .idle_nr_running               : 0
 
 task:kworker/119:1   state:I
   .idle_h_nr_running             : 0
   .runnable_avg                  : 5120
 
         0.000000     10230.050371         0.000000         0.000000
   .idle_h_nr_running             : 0
   .se->vruntime                  : 11601569.351706
   .load                          : 5693
   .runnable_avg                  : 3072
  /
   .se->avg.util_avg              : 1024
  /
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  </TASK>
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
   .se->sum_exec_runtime          : 34424.300264
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
 Call Trace:
 ? do_pte_missing (mm/memory.c:4763 mm/memory.c:3731) 
   .util_avg                      : 1024
   .se->avg.runnable_avg          : 3073
 
   .load                          : 3145728
   .util_est_enqueued             : 1346
 smpboot_thread_fn (kernel/smpboot.c:160) 
  <TASK>
  /
   .removed.load_avg              : 0
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  </TASK>
   .se->load.weight               : 3521
 
  <TASK>
  R
   .util_avg                      : 1024
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 hrtimer_nanosleep (kernel/time/hrtimer.c:2101) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .se->avg.load_avg              : 2
   .load_avg                      : 3072
 cfs_rq[52]:/
     pending:
 kthread (kernel/kthread.c:388) 
 task:sleep           state:R
   .removed.util_avg              : 0
 -------------------------------------------------------------------------------------------------------------
   .load_avg                      : 4
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  stack:0     pid:4055  tgid:4055  ppid:4018   flags:0x00000002
  stack:0     pid:1731  tgid:1731  ppid:2      flags:0x00004000
   .removed.runnable_avg          : 0
 ? fill_page_cache_func (kernel/rcu/tree.c:3261 (discriminator 3)) 
   .runnable_avg                  : 3072
 
   .runnable_avg                  : 2047
   .se->avg.util_avg              : 1023
   .util_avg                      : 1024
  R
   .exec_clock                    : 0.000000
   .util_avg                      : 1023
    ksoftirqd/16   116     66687.032812 E     66690.032812         3.000000         0.161350         8   120 
   .se->avg.runnable_avg          : 2047
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .util_est_enqueued             : 0
         0.000000         0.161350         0.000000         0.000000
 Call Trace:
   .util_est_enqueued             : 0
   .left_vruntime                 : 253596.183443
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   .removed.load_avg              : 0
 Call Trace:
  S
 
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .removed.util_avg              : 0
   .removed.load_avg              : 0
  /
        cpuhp/50   317      7794.497451 E      7797.492040         3.000000         1.639626        35   120 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
    kworker/27:1  1641     26062.664491 E     26065.664491         3.000000         0.314750        24   120 
  /
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .removed.runnable_avg          : 0
 cfs_rq[53]:/
 
         0.000000         1.639626         0.000000         0.000000
 worker_thread (kernel/workqueue.c:2734) 
 ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1935) 
  </TASK>
 ? try_to_wake_up (./arch/x86/include/asm/preempt.h:104 ./include/linux/preempt.h:484 ./include/linux/preempt.h:484 kernel/sched/core.c:4217) 
   .util_est_enqueued             : 0
 Workqueue:  0x0
 kthread (kernel/kthread.c:388) 
   .min_vruntime                  : 253598.301742
   .tg_load_avg_contrib           : 3042
   .exec_clock                    : 0.000000
         0.000000         0.314750         0.000000         0.000000
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  I
   .removed.load_avg              : 0
   .avg_vruntime                  : 286666.275501
 Workqueue:  0x0
  pm_runtime_work
  /
   .tg_load_avg                   : 178559
 worker_thread (kernel/workqueue.c:2734) 
 Call Trace:
   .tg_load_avg_contrib           : 0
  <TASK>
 R13: 00007ffd3c963120 R14: 0000000000000002 R15: 00007ffd3c963120
   .left_vruntime                 : 265668.598558
 
  /
   .tg_load_avg                   : 0
    kworker/16:0   117        41.657500 E        44.657500         3.000000         0.001594         4   120 
   .min_vruntime                  : 265685.378461
  S
   .throttled                     : 0
   .right_vruntime                : 253596.183443
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  idle_inject/50   318        -1.045356 E         1.952059         3.000000         0.007742         3    49 
 task:migration/127   state:S
  I
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .spread                        : 0.000000
 
         0.000000         0.001594         0.000000         0.000000
   .removed.util_avg              : 0
 worker_thread (kernel/workqueue.c:2734) 
         0.000000         0.007742         0.000000         0.000000
   .throttled                     : 0
   .throttle_count                : 0
 
   .avg_vruntime                  : 286627.043269
   .nr_spread_over                : 0
   .nr_running                    : 2
   .throttle_count                : 0
   .right_vruntime                : 274436.242937
    kworker/27:2  1859        48.309998 E        51.299781         3.000000         7.118016         9   120 
  /
  <TASK>
   running task    
   .removed.runnable_avg          : 0
   .spread                        : 8767.644379
  /
 
   .tg_load_avg_contrib           : 4
 
 
   .tg_load_avg                   : 1488
  I
   .h_nr_running                  : 4
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
         0.000000         7.118016         0.000000         0.000000
  stack:0     pid:781   tgid:781   ppid:2      flags:0x00004000
 ? __pfx_kthread (kernel/kthread.c:341) 
   .idle_nr_running               : 0
   .nr_spread_over                : 0
   kworker/16:0H   118        51.029924 E        51.064418         3.000000         0.017708         4   100 
  stack:0     pid:4288  tgid:4288  ppid:3942   flags:0x00000002
  </TASK>
   .se->exec_start                : 208005.280425
         0.000000         0.017708         0.000000         0.000000
  (mm_percpu_wq)
 ret_from_fork (arch/x86/kernel/process.c:147) 
  /
   .nr_running                    : 3
   .idle_h_nr_running             : 0
   .throttled                     : 0
 
 rt_rq[25]:
 
   .load                          : 1054213
  /
 Call Trace:
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .h_nr_running                  : 4
   .rt_nr_running                 : 0
  I
   .se->vruntime                  : 2070475.190185
  R
   .rt_throttled                  : 0
    kworker/27:3  1860        41.217299 E        44.214125         3.000000         0.010947         2   120 
 dl_rq[162]:
 
   .se->sum_exec_runtime          : 34797.213562
 Stopper: 0x0 <- 0x0
 kthread (kernel/kthread.c:388) 
 
  (rcu_par_gp)
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .rt_time                       : 0.000000
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .load_avg                      : 1029
   .removed.util_avg              : 0
   .idle_nr_running               : 0
   .throttle_count                : 0
   .rt_runtime                    : 950.000000
   .idle_h_nr_running             : 0
   .se->load.weight               : 18037
         0.000000         0.010947         0.000000         0.000000
   .runnable_avg                  : 4097
    migration/50   319        49.130632 E        49.879409         0.750000     10261.103701        47     0 
   .se->avg.load_avg              : 16
 
   .util_avg                      : 1024
 Workqueue:  0x0
 kthread (kernel/kthread.c:388) 
 Call Trace:
  I
 Call Trace:
   .removed.runnable_avg          : 0
  /
   .load                          : 2100673
         0.000000     10261.103701         0.000000         0.000000
 dl_rq[25]:
 ? __pfx_kthread (kernel/kthread.c:341) 
  kworker/u450:7  1421        41.657500 E        41.876554         3.000000        42.929731         3   120 
   .util_est_enqueued             : 1266
   .load_avg                      : 2050
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .se->exec_start                : 208059.574049
   .dl_nr_running                 : 0
 
  </TASK>
   .runnable_avg                  : 4095
   .removed.load_avg              : 0
   .se->vruntime                  : 11601569.351706
   .se->avg.util_avg              : 1024
         0.000000        42.929731         0.000000         0.000000
  <TASK>
  I
   .util_avg                      : 1023
   .dl_nr_running                 : 0
   kworker/27:1H  2091        53.123206 E        53.157785         3.000000         0.020736         2   100 
   .removed.util_avg              : 0
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .se->avg.runnable_avg          : 3072
   .util_est_enqueued             : 930
         0.000000         0.020736         0.000000         0.000000
   .removed.runnable_avg          : 0
  /
   .dl_bw->bw                     : 996147
   .tg_load_avg_contrib           : 0
   .se->sum_exec_runtime          : 34424.300264
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
  /
  /
  R
  I
 
  <TASK>
   .tg_load_avg                   : 0
   .removed.load_avg              : 0
   .se->load.weight               : 3521
   .removed.util_avg              : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .tg_load_avg_contrib           : 17
 
 ? __pfx_kthread (kernel/kthread.c:341) 
  </TASK>
   .removed.runnable_avg          : 0
   .dl_bw->total_bw               : 0
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 
   .throttled                     : 0
 >R
    kworker/16:1  1630     64498.686713 E     64501.686713         3.000000         0.906720        19   120 
   .tg_load_avg_contrib           : 0
  R
   .se->avg.load_avg              : 2
 ? watchdog_hardlockup_check (kernel/watchdog.c:175) 
 
   .se->avg.util_avg              : 1023
 kthread (kernel/kthread.c:388) 
   .tg_load_avg                   : 0
         0.000000         0.906720         0.000000         0.000000
 runnable tasks:
 console_blast.s  3530     34414.775057 N     34415.156603         3.000000     34401.655334         4   120 
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
    ksoftirqd/50   320    276865.549246 E    276868.549246         3.000000         0.032880         7   120 
   .se->avg.runnable_avg          : 2047
   .throttled                     : 0
 -------------------------------------------------------------------------------------------------------------
 kthread (kernel/kthread.c:388) 
 cfs_rq[20]:/user.slice/user-0.slice
  </TASK>
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  <TASK>
  /
 ? __pfx_kthread (kernel/kthread.c:341) 
   .throttle_count                : 0
 kworker/u453:23  1577       314.638416 E       317.188142         3.000000        22.628685        37   120 
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .throttle_count                : 0
 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .exec_clock                    : 0.000000
 
 Workqueue:  0x0
 
 
 kthread (kernel/kthread.c:388) 
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 cfs_rq[53]:/
 schedule_preempt_disabled (kernel/sched/core.c:6856) 
 rt_rq[53]:
         0.000000     34401.655334         0.000000         0.000000
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .left_vruntime                 : 0.000001
  S
 rt_rq[52]:
   .rt_nr_running                 : 0
   .min_vruntime                  : 2070598.189932
 workqueue kacpid: flags=0x0
         0.000000         0.032880         0.000000         0.000000
        cpuhp/25   167      7034.347940 E      7037.344060         3.000000         1.355944        35   120 
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .avg_vruntime                  : 2070598.189932
   .rt_throttled                  : 0
  </TASK>
   .right_vruntime                : 0.000001
  I
   .rt_time                       : 0.000000
  I
   .dl_bw->bw                     : 996147
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .rt_nr_running                 : 0
   .exec_clock                    : 0.000000
  /
   .left_vruntime                 : 265668.598558
   .spread                        : 0.000000
 task:kworker/10:0    state:I
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .rt_runtime                    : 950.000000
   kworker/16:1H  2287      1318.056182 E      1318.090734         3.000000         0.017695         3   100 
   .nr_spread_over                : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  /user.slice/user-0.slice/session-1.scope
   .rt_throttled                  : 0
   .min_vruntime                  : 265685.378461
 
 task:sleep           state:R
         0.000000         1.355944         0.000000         0.000000
 
  S
 
   .nr_running                    : 1
  </TASK>
         0.000000         0.017695         0.000000         0.000000 /
 ? __pfx_kthread (kernel/kthread.c:341) 
   .avg_vruntime                  : 286627.043269
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .dl_bw->total_bw               : 0
  (events_unbound)
  S
   pwq 0:
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .h_nr_running                  : 3
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 task:console_blast.s state:S
  </TASK>
   .right_vruntime                : 274436.242937
   .idle_nr_running               : 0
 irq/338-idxd-mi  3209      7826.080206 E      7829.075933         3.000000         0.027938         3    49 
 console_blast.s  3740        13.308723 E        15.812479         3.000000         3.672988         5   120 
 ret_from_fork (arch/x86/kernel/process.c:147) 
  stack:0     pid:81    tgid:81    ppid:2      flags:0x00004000
 dl_rq[53]:
 kthread (kernel/kthread.c:388) 
 task:kworker/170:1   state:I
         0.000000         0.027938         0.000000         0.000000
  cpus=0
  /
  (events_unbound)
   kworker/177:1  1785     12730.838592 E     12733.829955         3.000000         0.514560        40   120 
  I
   .idle_h_nr_running             : 0
   .rt_time                       : 0.000000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 task:cpuhp/39        state:S
 
 task:kworker/18:0H   state:I
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
  node=0
  /
   .spread                        : 8767.644379
   .rt_runtime                    : 950.000000
 do_nanosleep (kernel/time/hrtimer.c:1446 kernel/time/hrtimer.c:2049) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  stack:0     pid:251   tgid:251   ppid:2      flags:0x00004000
         0.000000        22.628685         0.000000         0.000000
   .load                          : 18037
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
    kworker/50:0   321      7788.065883 E      7790.887220         3.000000         0.187322         6   120 
 >R
   .dl_nr_running                 : 0
   .load_avg                      : 17
         0.000000         3.672988         0.000000         0.000000
   .runnable_avg                  : 3072
 console_blast.s  3487     34778.915212 N     34781.389204         3.000000     34773.480133         6   120 
 
  S
 Call Trace:
 dl_rq[52]:
 Workqueue:  0x0
   .dl_bw->bw                     : 996147
         0.000000         0.514560         0.000000         0.000000
   .dl_nr_running                 : 0
         0.000000     34773.480133         0.000000         0.000000
   .dl_bw->total_bw               : 0
  /user.slice/user-0.slice/session-1.scope
   .util_avg                      : 1024
 ? __pfx_kthread (kernel/kthread.c:341) 
         0.000000         0.187322         0.000000         0.000000
  idle_inject/25   168        -1.048608 E         1.951392         3.000000         0.001548         3    49 
   .util_est_enqueued             : 0
 
 
   .dl_bw->bw                     : 996147
   .nr_spread_over                : 0
   .removed.load_avg              : 0
  S
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 console_blast.s  3932        15.315284 E        17.825060         3.000000         3.120333         5   120 
   .dl_bw->total_bw               : 0
   .nr_running                    : 3
  /
  stack:0     pid:3941  tgid:3941  ppid:3454   flags:0x00000002
  stack:0     pid:130   tgid:130   ppid:2      flags:0x00004000
   .h_nr_running                  : 4
  /user.slice/user-0.slice/session-1.scope
 
  (events)
 ? __pfx_rescuer_thread (kernel/workqueue.c:2822) 
  I
         0.000000         3.120333         0.000000         0.000000
 runnable tasks:
   kworker/50:0H   322       131.469806 E       131.503793         3.000000         0.062893         4   100 
         0.000000         0.001548         0.000000         0.000000
 
 ? __pfx_kthread (kernel/kthread.c:341) 
 RIP: 0033:0x7f1f7f5c9c74
   .removed.util_avg              : 0
 Call Trace:
   .removed.runnable_avg          : 0
  /user.slice/user-0.slice/session-1.scope
  stack:0     pid:1572  tgid:1572  ppid:2      flags:0x00004000
   .tg_load_avg_contrib           : 17
  flags=0x0 nice=0
 
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  <TASK>
 
 Workqueue:  0x0
   .tg_load_avg                   : 2026
   .idle_nr_running               : 0
  /
  (mm_percpu_wq)
  S
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 task:migration/14    state:R
 runnable tasks:
   .idle_h_nr_running             : 0
  active=1/1 refcnt=2
 console_blast.s  3706         6.196533 E         8.708289         3.000000         3.575946         5   120 
  /
   .throttled                     : 0
   .load                          : 2100673
         0.000000         0.062893         0.000000         0.000000
 smpboot_thread_fn (kernel/smpboot.c:160) 
 kthread (kernel/kthread.c:388) 
 kthread (kernel/kthread.c:388) 
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
 
         0.000000         3.575946         0.000000         0.000000
 -------------------------------------------------------------------------------------------------------------
   .load_avg                      : 2050
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  stack:0     pid:1570  tgid:1570  ppid:2      flags:0x00004000
  /
  <TASK>
 
  (events_highpri)
  </TASK>
  /
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 -------------------------------------------------------------------------------------------------------------
 common_nsleep (kernel/time/posix-timers.c:1353) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  stack:0     pid:1782  tgid:1782  ppid:2      flags:0x00004000
 task:kworker/103:1   state:I
 Workqueue:  0x0
  <TASK>
  /user.slice/user-0.slice/session-1.scope
   .throttle_count                : 0
 
 
  stack:0     pid:1561  tgid:1561  ppid:2      flags:0x00004000
 ? try_to_wake_up (./arch/x86/include/asm/preempt.h:104 ./include/linux/preempt.h:484 ./include/linux/preempt.h:484 kernel/sched/core.c:4217) 
   .se->exec_start                : 208009.254121
 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .tg_load_avg                   : 2026
  R
 Call Trace:
 
  (events_unbound)
 __mutex_lock.constprop.0 (kernel/locking/mutex.c:197 kernel/locking/mutex.c:681 kernel/locking/mutex.c:747) 
 
   .runnable_avg                  : 4095
  S
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .se->vruntime                  : 4401788.968903
  R
        cpuhp/52   329      1316.328938 E      1319.324334         3.000000         1.364705        35   120 
  I
  S
           sleep  4222       775.938814 E       778.938814         3.000000         1.058992         1   120 
 Workqueue:  0x0
   .util_avg                      : 1023
 worker_thread (kernel/workqueue.c:2734) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .se->sum_exec_runtime          : 34801.187258
 kworker/u452:16  1463        43.049371 E        45.782723         3.000000        44.094070         3   120 
    migration/25   169        41.974646 E        42.723865         0.750000     10239.047864        47     0 
   .util_est_enqueued             : 930
         0.000000         1.058992         0.000000         0.000000
   .se->load.weight               : 8798
  stack:0     pid:1715  tgid:1715  ppid:2      flags:0x00004000
  S
 ? __perf_event_overflow (kernel/events/core.c:9612 (discriminator 2)) 
   .removed.load_avg              : 0
   .removed.util_avg              : 0
 hrtimer_nanosleep (kernel/time/hrtimer.c:2101) 
 
         0.000000        44.094070         0.000000         0.000000
 
   .removed.runnable_avg          : 0
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
        cpuhp/53   335       321.131496 E       324.127291         3.000000         2.330872        35   120 
         0.000000     10239.047864         0.000000         0.000000
   .tg_load_avg_contrib           : 0
   .se->avg.load_avg              : 7
 console_blast.s  3900         7.665190 E        10.222764         3.000000         3.035136         4   120 
  /
  /user.slice/user-0.slice/session-1.scope
  /
 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  (btrfs-endio)
   .tg_load_avg                   : 0
 kthread (kernel/kthread.c:388) 
 do_nanosleep (kernel/time/hrtimer.c:1446 kernel/time/hrtimer.c:2049) 
  I
 Workqueue:  0x0
   .se->avg.util_avg              : 1024
    kworker/50:1  1664      7794.214185 E      7797.208466         3.000000         0.318829        34   120 
         0.000000         1.364705         0.000000         0.000000
 
         0.000000         3.035136         0.000000         0.000000
 Call Trace:
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ? __pfx_kthread (kernel/kthread.c:341) 
  R
  /
 ? __pfx_kthread (kernel/kthread.c:341) 
         0.000000         2.330872         0.000000         0.000000
  </TASK>
  /user.slice/user-0.slice/session-1.scope
 ? __pfx_kthread (kernel/kthread.c:341) 
   .throttled                     : 0
   running task    
 
   .se->avg.runnable_avg          : 3072
           sleep  4284      1153.243484 E      1156.243484         3.000000         1.126132         1   120 
  S
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  idle_inject/52   330        -1.048464 E         1.951536         3.000000         0.001833         3    49 
  /
  I
  <TASK>
 ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1935) 
 
 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 
 cfs_rq[20]:/user.slice
     pending:
 
 task:kworker/141:1   state:I
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
         0.000000         0.318829         0.000000         0.000000
   .throttle_count                : 0
         0.000000         0.001833         0.000000         0.000000
  /
 Call Trace:
  </TASK>
  R
  I
 
   .exec_clock                    : 0.000000
  stack:0     pid:103   tgid:103   ppid:2      flags:0x00004000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 
  acpi_os_execute_deferred
           sleep  4211       767.549102 E       770.549102         3.000000         1.074312         1   120 
  /
  S
         0.000000         1.126132         0.000000         0.000000
  R
  R
    ksoftirqd/25   170    243059.798538 E    243062.798538         3.000000         0.809738         3   120 
  kworker/177:1H  2568      2095.469601 E      2095.504180         3.000000         0.135817         5   100 
         0.000000         1.074312         0.000000         0.000000
  I
         0.000000         0.809738         0.000000         0.000000
   .left_vruntime                 : 0.000001
 common_nsleep (kernel/time/posix-timers.c:1353) 
  /user.slice/user-0.slice/session-1.scope
 rt_rq[53]:
  /user.slice/user-0.slice/session-1.scope
   .rt_nr_running                 : 0
   .min_vruntime                  : 4401788.968903
 smpboot_thread_fn (kernel/smpboot.c:160) 
   kworker/50:1H  2731       131.471556 E       131.506147         3.000000         0.011530         2   100 
 worker_thread (kernel/workqueue.c:2734) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  idle_inject/53   336        -1.048416 E         1.951584         3.000000         0.002267         3    49 
 
         0.000000         0.011530         0.000000         0.000000
 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .rt_throttled                  : 0
    migration/52   331        49.834186 E        50.583186         0.750000     10262.181147        46     0 
   .avg_vruntime                  : 4401788.968903
   .rt_time                       : 0.000000
  /
         0.000000         0.002267         0.000000         0.000000
 
  /
   .right_vruntime                : 0.000001
 
 
   .spread                        : 0.000000
   .rt_runtime                    : 950.000000
 kthread (kernel/kthread.c:388) 
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
  I
  I
 cpu#28, 1900.000 MHz
 smpboot_thread_fn (kernel/smpboot.c:160) 
 
 task:idle_inject/97  state:S
  R
         0.000000     10262.181147         0.000000         0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
 __x64_sys_clock_nanosleep (kernel/time/posix-timers.c:1396 kernel/time/posix-timers.c:1373 kernel/time/posix-timers.c:1373) 
   .nr_running                    : 5
   .nr_spread_over                : 0
   kworker/169:1  1780     17062.233443 E     17065.230308         3.000000         0.619638        34   120 
   .throttled                     : 0
  </TASK>
 ? __pfx_kthread (kernel/kthread.c:341) 
   .nr_running                    : 1
    kworker/25:0   171        49.221004 E        52.221004         3.000000         0.001349         4   120 
 
  /
   .nr_switches                   : 842
           sleep  4274      1144.530391 E      1147.530391         3.000000         1.231738         1   120 
 task:kworker/11:0    state:I
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
         0.000000         1.231738         0.000000         0.000000
 dl_rq[53]:
   .h_nr_running                  : 3
  /user.slice/user-0.slice/session-1.scope
         0.000000         0.001349         0.000000         0.000000
   .idle_nr_running               : 0
 
 
   .idle_h_nr_running             : 0
 kworker/R-0000:  3236      7563.854930 E      7563.889524         3.000000         0.014703         2   100 
 Workqueue:  0x0
  <TASK>
 ret_from_fork (arch/x86/kernel/process.c:147) 
 
   .load                          : 8798
   .nr_uninterruptible            : -9
  S
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .load_avg                      : 8
         0.000000         0.014703         0.000000         0.000000
 
  /
   .runnable_avg                  : 3072
  /
   .next_balance                  : 4294.870318
  stack:0     pid:600   tgid:600   ppid:2      flags:0x00004000
  R
 runnable tasks:
  </TASK>
         0.000000         0.619638         0.000000         0.000000
    ksoftirqd/52   332         0.266993 E         1.950999         3.000000         0.784975         3   120 
 hrtimer_nanosleep (kernel/time/hrtimer.c:2101) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
 cpu#17, 1900.000 MHz
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
    kworker/50:2  3290    268170.491452 E    268173.491452         3.000000         0.247312        25   120 
   .util_avg                      : 1024
 ret_from_fork (arch/x86/kernel/process.c:147) 
 Call Trace:
  stack:0     pid:87    tgid:87    ppid:2      flags:0x00004000
 ? fill_page_cache_func (kernel/rcu/tree.c:3261 (discriminator 3)) 
   .util_est_enqueued             : 0
   .curr->pid                     : 3533
   .removed.load_avg              : 0
 Workqueue:  0x0
   .removed.util_avg              : 0
  /
 kthread (kernel/kthread.c:388) 
 
         0.000000         0.247312         0.000000         0.000000
   .dl_nr_running                 : 0
  I
   .nr_running                    : 6
  /
   .removed.runnable_avg          : 0
   .nr_switches                   : 355
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .clock                         : 208136.821159
  (events_unbound)
 ? __pfx_kthread (kernel/kthread.c:341) 
   .tg_load_avg_contrib           : 8
 
   kworker/25:0H   172       107.523453 E       107.557997         3.000000         0.015087         4   100 
   .nr_uninterruptible            : 2
 >R
   .dl_bw->bw                     : 996147
 task:ksoftirqd/106   state:S
         0.000000         0.015087         0.000000         0.000000
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .tg_load_avg                   : 1488
  R
 ? avc_has_perm_noaudit (security/selinux/avc.c:1167) 
 console_blast.s  3613     34429.493690 N     34429.528981         3.000000     34430.296732         6   120 
         0.000000         0.784975         0.000000         0.000000
   .next_balance                  : 4294.870320
   .clock_task                    : 207962.507992
         0.000000     34430.296732         0.000000         0.000000
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 
  /
  <TASK>
   running task    
 __x64_sys_clock_nanosleep (kernel/time/posix-timers.c:1396 kernel/time/posix-timers.c:1373 kernel/time/posix-timers.c:1373) 
   .avg_idle                      : 1000000
  /
 
   .throttled                     : 0
   .curr->pid                     : 3490
 ? handle_pmi_common (arch/x86/events/intel/core.c:3052 (discriminator 1)) 
  /user.slice/user-0.slice/session-1.scope
 
   .clock                         : 208136.715991
   .dl_bw->total_bw               : 0
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
 Workqueue:  0x0
  I
         0.000000         0.135817         0.000000         0.000000
   .throttle_count                : 0
    migration/53   337        50.226335 E        50.975278         0.750000     10263.028501        46     0 
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
 
 worker_thread (kernel/workqueue.c:2734) 
   .clock_task                    : 208029.184588
 
    kworker/52:0   333        34.436812 E        37.431970         3.000000         0.008109         4   120 
 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->exec_start                : 208009.254121
 ret_from_fork (arch/x86/kernel/process.c:147) 
 Call Trace:
   .avg_idle                      : 1000000
 worker_thread (kernel/workqueue.c:2734) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .max_idle_balance_cost         : 500000
  </TASK>
 
  S
 Call Trace:
  stack:0     pid:656   tgid:656   ppid:2      flags:0x00004000
         0.000000     10263.028501         0.000000         0.000000
  I
  (mm_percpu_wq)
         0.000000         0.008109         0.000000         0.000000
   .max_idle_balance_cost         : 500000
  /
  stack:0     pid:4230  tgid:4230  ppid:3764   flags:0x00000002
 ? __pfx_kthread (kernel/kthread.c:341) 
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
 runnable tasks:
 
 task:idle_inject/39  state:S
 
 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .se->vruntime                  : 7059428.096095
 
  /
 cfs_rq[28]:/user.slice/user-0.slice/session-1.scope
 ? set_pte_vaddr_p4d (arch/x86/mm/init_64.c:307 arch/x86/mm/init_64.c:315) 
 worker_thread (kernel/workqueue.c:2734) 
 
 cfs_rq[17]:/user.slice/user-0.slice/session-1.scope
  /
  <TASK>
   .exec_clock                    : 0.000000
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .exec_clock                    : 0.000000
  R
 
 Call Trace:
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  I
 ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1935) 
 RSP: 002b:00007ffec4639108 EFLAGS: 00000202
 Call Trace:
 Call Trace:
   .se->sum_exec_runtime          : 34801.187258
   kworker/52:0H   334        73.615530 E        73.649793         3.000000         0.042464         4   100 
 
   .left_vruntime                 : 767.543871
 Workqueue:  0x0
   .se->load.weight               : 5637
  kworker/u456:0  1368        49.221004 E        49.775388         3.000000        50.269580         4   120 
 console_blast.s  3805         0.814064 E         3.344904         3.000000         3.277275         4   120 
 ? flush_tlb_one_kernel (./arch/x86/include/asm/paravirt.h:81 arch/x86/mm/tlb.c:1171 arch/x86/mm/tlb.c:1126) 
   .left_vruntime                 : 1145.560279
    ksoftirqd/53   338    274436.242937 E    274439.242937         3.000000         0.002555         3   120 
  /
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
  stack:0     pid:252   tgid:252   ppid:2      flags:0x00004000
 do_wait (kernel/exit.c:1625 (discriminator 4)) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->avg.load_avg              : 4
         0.000000        50.269580         0.000000         0.000000
  <TASK>
 Call Trace:
 kthread (kernel/kthread.c:388) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  (mm_percpu_wq)
         0.000000         0.002555         0.000000         0.000000
   .min_vruntime                  : 767.543871
 ? __pfx_kthread (kernel/kthread.c:341) 
 kthread (kernel/kthread.c:388) 
         0.000000         0.042464         0.000000         0.000000
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
   .avg_vruntime                  : 12231.489035
   .min_vruntime                  : 1145.560279
  /
  <TASK>
   .throttle_count                : 0
         0.000000         3.277275         0.000000         0.000000
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .right_vruntime                : 1146.188899
 
  /
 -------------------------------------------------------------------------------------------------------------
 
 kthread (kernel/kthread.c:388) 
  I
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
  <TASK>
 Call Trace:
  R
   .se->avg.util_avg              : 1024
  </TASK>
 iterate_tty_write (drivers/tty/tty_io.c:957 (discriminator 1) drivers/tty/tty_io.c:973 (discriminator 1)) 
 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .se->avg.runnable_avg          : 3072
    kworker/25:1  1644    235690.131483 E    235693.131483         3.000000         0.129072        15   120 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  <TASK>
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
   .spread                        : 378.645028
  /user.slice/user-0.slice/session-1.scope
   .avg_vruntime                  : 12462.171482
 
  /
   .se->exec_start                : 207963.261501
  S
 
   .nr_spread_over                : 0
 
 cfs_rq[20]:/
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .exec_clock                    : 0.000000
        cpuhp/53   335       321.131496 E       324.127291         3.000000         2.330872        35   120 
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .nr_running                    : 3
  I
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
 ? __schedule (kernel/sched/core.c:6714) 
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
   .right_vruntime                : 1522.809229
 
         0.000000         0.129072         0.000000         0.000000
 Call Trace:
         0.000000         2.330872         0.000000         0.000000
    kworker/53:0   339        36.959343 E        39.956448         3.000000         0.004667         4   120 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  /
  ORIG_RAX: 0000000000000001
 
  I
  /
   .h_nr_running                  : 3
 ? native_set_fixmap (arch/x86/mm/pgtable.c:679 arch/x86/mm/pgtable.c:688) 
  R
 Call Trace:
   .idle_nr_running               : 0
   .spread                        : 377.248950
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
  kworker/169:1H  2565       184.779943 E       184.814527         3.000000         0.010232         2   100 
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
           sleep  4246       790.110901 E       793.110901         3.000000         1.203562         1   120 
 RIP: 0033:0x7fb29f2e1167
 kworker/u452:22  1509        34.431970 E        37.431970         3.000000        35.918421         3   120 
   .idle_h_nr_running             : 0
  I
         0.000000         1.203562         0.000000         0.000000
         0.000000         0.004667         0.000000         0.000000
  <TASK>
 ? __pfx_kthread (kernel/kthread.c:341) 
 task:kworker/193:1   state:I
   .nr_spread_over                : 0
         0.000000         0.010232         0.000000         0.000000
   .left_vruntime                 : 65513.355468
   .load                          : 3145728
 common_nsleep (kernel/time/posix-timers.c:1353) 
   .nr_running                    : 3
 RIP: 0033:0x7f5eb8fa6167
  /user.slice/user-0.slice/session-1.scope
         0.000000        35.918421         0.000000         0.000000
  /
 
   .h_nr_running                  : 3
   kworker/25:1H  2638       107.523439 E       107.558031         3.000000         0.014532         2   100 
 
   .load_avg                      : 3072
 
   .se->vruntime                  : 4393937.012123
  S
 
   .runnable_avg                  : 3072
  idle_inject/53   336        -1.048416 E         1.951584         3.000000         0.002267         3    49 
 ? ghes_copy_tofrom_phys (drivers/acpi/apei/ghes.c:330) 
   .idle_nr_running               : 0
   .min_vruntime                  : 65522.307768
 ? __pfx_kthread (kernel/kthread.c:341) 
         0.000000         0.002267         0.000000         0.000000
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
   .idle_h_nr_running             : 0
         0.000000         0.014532         0.000000         0.000000
   .util_avg                      : 1024
  /
   .load                          : 3145728
  I
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
 
  /
 cpu#51, 1900.000 MHz
   .util_est_enqueued             : 0
   .load_avg                      : 3072
   .avg_vruntime                  : 98383.785872
  /
   kworker/53:0H   340        37.899491 E        37.933990         3.000000         0.023389         4   100 
   .removed.load_avg              : 0
 RSP: 002b:00007fffe8a591e8 EFLAGS: 00000202
   .right_vruntime                : 97262.314120
   .nr_running                    : 4
 
   .spread                        : 31748.958652
 __x64_sys_clock_nanosleep (kernel/time/posix-timers.c:1396 kernel/time/posix-timers.c:1373 kernel/time/posix-timers.c:1373) 
   .nr_switches                   : 391
   .removed.util_avg              : 0
         0.000000         0.023389         0.000000         0.000000
   .nr_spread_over                : 0
   .removed.runnable_avg          : 0
  /
  R
   .runnable_avg                  : 3072
 
    migration/53   337        50.226335 E        50.975278         0.750000     10263.028501        46     0 
   .nr_uninterruptible            : -2
   .nr_running                    : 3
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .tg_load_avg_contrib           : 3041
  R
 ? file_has_perm (security/selinux/hooks.c:1759) 
  /
         0.000000     10263.028501         0.000000         0.000000
   .util_avg                      : 1024
 Call Trace:
    kworker/52:1  1667    253596.183443 E    253599.183443         3.000000         0.110518        14   120 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  /
         0.000000         0.110518         0.000000         0.000000
   .next_balance                  : 4294.870340
  <TASK>
 
 -------------------------------------------------------------------------------------------------------------
 Call Trace:
 kernel_wait4 (kernel/exit.c:1786) 
   .h_nr_running                  : 5
   .curr->pid                     : 3810
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .util_est_enqueued             : 0
   .tg_load_avg                   : 178559
 
   .idle_nr_running               : 0
 Call Trace:
   .idle_h_nr_running             : 0
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .removed.load_avg              : 0
  </TASK>
  <TASK>
   .clock                         : 208137.463513
   .throttled                     : 0
 
 kthread (kernel/kthread.c:388) 
 
  <TASK>
 >R
 kthread (kernel/kthread.c:388) 
   .removed.util_avg              : 0
   .clock_task                    : 208024.838205
   .throttle_count                : 0
 RAX: ffffffffffffffda RBX: 000000000000005b RCX: 00007f1f7f5c9c74
  R
  /
 Call Trace:
    ksoftirqd/53   338    274436.242937 E    274439.242937         3.000000         0.002555         3   120 
   .se->exec_start                : 208030.360708
  I
   .avg_idle                      : 1000000
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .se->vruntime                  : 2070052.454146
 kworker/u452:18  1477        36.956448 E        37.228265         3.000000        38.004859         3   120 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 
   .removed.runnable_avg          : 0
   .load                          : 2102789
 RDX: 000000000000005b RSI: 0000558a87b6e2c0 RDI: 0000000000000001
  <TASK>
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 console_blast.s  3519     34781.602244 N     34783.276571         3.000000     34775.680993         5   120 
  stack:0     pid:1750  tgid:1750  ppid:2      flags:0x00004000
 ? __pfx_kthread (kernel/kthread.c:341) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
         0.000000         0.002555         0.000000         0.000000
  I
   .max_idle_balance_cost         : 500000
  /
         0.000000     34775.680993         0.000000         0.000000
 
   .load_avg                      : 2053
  <TASK>
  stack:0     pid:1801  tgid:1801  ppid:2      flags:0x00004000
 
   kworker/52:1H  2967        73.615840 E        73.650417         3.000000         0.012694         2   100 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
         0.000000        38.004859         0.000000         0.000000
 cfs_rq[51]:/user.slice/user-0.slice/session-1.scope
   .tg_load_avg_contrib           : 3046
  /
  I
 Stopper: 0x0 <- 0x0
   .runnable_avg                  : 5121
  /user.slice/user-0.slice/session-1.scope
 ? intel_pmu_handle_irq (./arch/x86/include/asm/msr.h:84 ./arch/x86/include/asm/msr.h:118 arch/x86/events/intel/core.c:2427 arch/x86/events/intel/core.c:3118) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .exec_clock                    : 0.000000
   .tg_load_avg                   : 178559
   .se->sum_exec_runtime          : 34784.378588
   .util_avg                      : 1024
    kworker/53:0   339        36.959343 E        39.956448         3.000000         0.004667         4   120 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 file_tty_write.isra.0 (drivers/tty/tty_io.c:1092) 
   .se->load.weight               : 18036
 kthread (kernel/kthread.c:388) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
 
 
   .left_vruntime                 : 29882.540004
   .util_est_enqueued             : 1320
         0.000000         0.012694         0.000000         0.000000
   .se->avg.load_avg              : 16
   .min_vruntime                  : 19826.431616
  S
   .se->avg.util_avg              : 1024
 Workqueue:  0x0
  /
 ? __pfx_kthread (kernel/kthread.c:341) 
         0.000000         0.004667         0.000000         0.000000 /
  R
   .removed.load_avg              : 0
 console_blast.s  3734         6.316129 E         8.909189         3.000000         3.334433         3   120 
   .avg_vruntime                  : 24854.485810
   .se->avg.runnable_avg          : 3072
 
  </TASK>
   .throttled                     : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
    kworker/53:1  1668    265668.598558 E    265671.598558         3.000000         0.244240        15   120 
 
 ? __pfx_child_wait_callback (kernel/exit.c:1510) 
   .throttle_count                : 0
 RSP: 002b:00007ffc0efe2038 EFLAGS: 00000202
 
   .se->exec_start                : 207964.196942
 workqueue i40e: flags=0x8
  <TASK>
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .right_vruntime                : 29882.540004
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .removed.util_avg              : 0
  ORIG_RAX: 00000000000000e6
 cfs_rq[17]:/user.slice/user-0.slice
         0.000000         3.334433         0.000000         0.000000
  I
 ret_from_fork (arch/x86/kernel/process.c:147) 
 >R
   .spread                        : 0.000000
   .se->vruntime                  : 2092359.339934
   .removed.runnable_avg          : 0
  /user.slice/user-0.slice/session-1.scope
 console_blast.s  3618     34394.344179 N     34395.149488         3.000000     34393.469514         4   120 
         0.000000         0.244240         0.000000         0.000000
   .exec_clock                    : 0.000000
   .nr_spread_over                : 0
 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   kworker/53:0H   340        37.899491 E        37.933990         3.000000         0.023389         4   100 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .tg_load_avg_contrib           : 0
  <TASK>
         0.000000     34393.469514         0.000000         0.000000
  S
   .tg_load_avg                   : 0
   .nr_running                    : 2
   .left_vruntime                 : 0.000001
  S
   .se->sum_exec_runtime          : 34720.968034
   .h_nr_running                  : 2
  /user.slice/user-0.slice/session-1.scope
   .min_vruntime                  : 2070052.454146
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
 worker_thread (kernel/workqueue.c:2734) 
   .idle_nr_running               : 0
  /
 
   .avg_vruntime                  : 2070052.454146
         0.000000         0.023389         0.000000         0.000000
   .se->load.weight               : 18037
  /
 vfs_write (./include/linux/fs.h:2020 fs/read_write.c:491 fs/read_write.c:584) 
  S
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 
   .idle_h_nr_running             : 0
   .right_vruntime                : 0.000001
   .throttled                     : 0
 console_blast.s  3813         0.833437 E         3.329484         3.000000         3.661653         5   120 
 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .spread                        : 0.000000
   .load                          : 2097152
   .throttle_count                : 0
 console_blast.s  3928         7.822891 E        10.346808         3.000000         3.246692         4   120 
   .load_avg                      : 2048
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .runnable_avg                  : 2048
 ret_from_fork (arch/x86/kernel/process.c:147) 
  I
 
         taskset  4158         6.319979 E         8.210525         3.000000         1.109454         1   120 
   .nr_spread_over                : 0
   .se->avg.load_avg              : 16
 Call Trace:
   .se->sum_exec_runtime          : 34763.444574
         0.000000         3.246692         0.000000         0.000000
 task:ksoftirqd/127   state:S
 do_nanosleep (kernel/time/hrtimer.c:1446 kernel/time/hrtimer.c:2049) 
   .se->avg.util_avg              : 1024
   .util_avg                      : 1024
 rt_rq[20]:
  /user.slice/user-0.slice/session-1.scope
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   kworker/53:1H  2831        82.279389 E        82.313955         3.000000         0.033790         8   100 
         0.000000         3.661653         0.000000         0.000000
   .util_est_enqueued             : 0
  I
 ? __pfx_kthread (kernel/kthread.c:341) 
   .removed.load_avg              : 0
   .rt_nr_running                 : 0
 
   .nr_running                    : 1
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
  S
   .h_nr_running                  : 3
   .removed.util_avg              : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .se->avg.runnable_avg          : 3072
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
  /user.slice/user-0.slice/session-1.scope
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
         0.000000         1.109454         0.000000         0.000000
   .idle_nr_running               : 0
 smpboot_thread_fn (kernel/smpboot.c:160) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 console_blast.s  4047         4.139249 E         6.827856         3.000000         2.340944         3   120 
 
 
   .removed.runnable_avg          : 0
         0.000000         0.033790         0.000000         0.000000
 kworker/u452:18  1477        36.956448 E        37.228265         3.000000        38.004859         3   120 
   pwq 0:
  <TASK>
  cpus=0
   .tg_load_avg_contrib           : 2020
 ? perf_event_nmi_handler (arch/x86/events/core.c:1743 arch/x86/events/core.c:1729) 
   .se->load.weight               : 8798
 cfs_rq[28]:/user.slice/user-0.slice
         0.000000         2.340944         0.000000         0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
  <TASK>
   .idle_h_nr_running             : 0
 RBP: 00007ffec4639130 R08: 0000000000000000 R09: 0000000000000001
 kthread (kernel/kthread.c:388) 
         0.000000        38.004859         0.000000         0.000000
  S
   .tg_load_avg                   : 178559
   .load                          : 18036
   .throttled                     : 0
  /
  /user.slice/user-0.slice/session-1.scope
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  /
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 
   .exec_clock                    : 0.000000
  stack:0     pid:782   tgid:782   ppid:2      flags:0x00004000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 kthread (kernel/kthread.c:388) 
 
   .rt_throttled                  : 0
  R
   .load_avg                      : 17
 ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5839 (discriminator 1) kernel/sched/core.c:5836 (discriminator 1) kernel/sched/core.c:5864 (discriminator 1)) 
  </TASK>
   .throttle_count                : 0
   .left_vruntime                 : 0.000001
 R10: 0000000000000004 R11: 0000000000000202 R12: 000000000000005b
   .min_vruntime                  : 2092444.218209
   .rt_time                       : 0.000000
 cpu#178, 1900.000 MHz
 Call Trace:
 
 worker_thread (kernel/workqueue.c:2734) 
  S
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->exec_start                : 208026.395470
  S
 >R
   .avg_vruntime                  : 2092472.856055
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
    kworker/53:1  1668    265668.598558 E    265671.598558         3.000000         0.244240        15   120 
 ? up_read (./arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1622) 
   .runnable_avg                  : 3072
   .rt_runtime                    : 950.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
   .right_vruntime                : 0.000001
  /user.slice/user-0.slice/session-1.scope
 
   .util_avg                      : 1024
   .spread                        : 0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
         0.000000         0.244240         0.000000         0.000000
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 console_blast.s  3622     34452.049073 N     34455.049073         3.000000     34452.470317         6   120 
 console_blast.s  4006         2.490438 E         4.947241         3.000000         3.002378         5   120 
   .nr_spread_over                : 0
  /
 Workqueue:  0x0
   .util_est_enqueued             : 0
   .removed.load_avg              : 0
 dl_rq[20]:
  node=0
   .dl_nr_running                 : 0
 ? do_user_addr_fault (arch/x86/mm/fault.c:1445 (discriminator 1)) 
 kthread (kernel/kthread.c:388) 
   .removed.util_avg              : 0
 
   .se->vruntime                  : 3164381.501305
         0.000000     34452.470317         0.000000         0.000000
 ksys_write (fs/read_write.c:637) 
         taskset  4102         5.271925 E         7.139249         3.000000         1.132676         1   120 
   .nr_running                    : 1
   .nr_running                    : 0
   .dl_bw->bw                     : 996147
   .se->sum_exec_runtime          : 34391.758616
 ret_from_fork (arch/x86/kernel/process.c:147) 
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
  I
       cpuhp/162   989       802.473507 E       805.468289         3.000000         1.904840        35   120 
   .dl_bw->total_bw               : 0
   .removed.runnable_avg          : 0
   kworker/53:1H  2831        82.279389 E        82.313955         3.000000         0.033790         8   100 
   .h_nr_running                  : 3
 
   .se->load.weight               : 12024
   .tg_load_avg_contrib           : 17
  </TASK>
 
         0.000000         3.002378         0.000000         0.000000
 runnable tasks:
   .tg_load_avg                   : 2026
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  (events)
 ? nmi_handle (arch/x86/kernel/nmi.c:150) 
 ? __pfx_kthread (kernel/kthread.c:341) 
  /user.slice/user-0.slice/session-1.scope
   .se->avg.load_avg              : 10
  (mm_percpu_wq)
 task:kworker/u450:26 state:I
 worker_thread (kernel/workqueue.c:2734) 
  <TASK>
 task:kworker/106:0   state:I
   .se->avg.util_avg              : 1024
 task:migration/97    state:S
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 ? __x64_sys_rt_sigaction (kernel/signal.c:4477 (discriminator 1) kernel/signal.c:4458 (discriminator 1) kernel/signal.c:4458 (discriminator 1)) 
  flags=0x0 nice=0
 ret_from_fork (arch/x86/kernel/process.c:147) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
         0.000000         1.132676         0.000000         0.000000
   .idle_nr_running               : 0
         0.000000         1.904840         0.000000         0.000000
   .throttled                     : 0
 -------------------------------------------------------------------------------------------------------------
 
  /user.slice/user-0.slice/session-1.scope
  stack:0     pid:601   tgid:601   ppid:2      flags:0x00004000
 ? __schedule (kernel/sched/core.c:6714) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .se->avg.runnable_avg          : 2048
   .idle_h_nr_running             : 0
  S
   .se->avg.load_avg              : 7
 
   .load                          : 18037
  stack:0     pid:657   tgid:657   ppid:2      flags:0x00004000
 
   .throttle_count                : 0
  S
   .load_avg                      : 17
   .se->exec_start                : 208033.491020
  /user.slice/user-0.slice/session-1.scope
  ORIG_RAX: 00000000000000e6
 
 cfs_rq[51]:/user.slice/user-0.slice
 
         0.000000         0.033790         0.000000         0.000000
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
   .exec_clock                    : 0.000000
   .se->vruntime                  : 4398353.428294
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .nr_switches                   : 913
 worker_thread (kernel/workqueue.c:2734) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .left_vruntime                 : 0.000001
 ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
  (mm_percpu_wq)
 R13: 0000558a87b6e2c0 R14: 00007f1f7f69a5c0 R15: 00007f1f7f697f20
   .se->sum_exec_runtime          : 34787.508900
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .min_vruntime                  : 3164381.501305
 Call Trace:
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
  /
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
        cpuhp/20   137      1251.357580 E      1254.354032         3.000000         2.107902        35   120 
  active=1/256 refcnt=2
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .runnable_avg                  : 3072
   .se->avg.util_avg              : 1024
  /
   .avg_vruntime                  : 3164381.501305
  </TASK>
 cpu#170, 1900.000 MHz
 Workqueue:  0x0
 Stopper: 0x0 <- 0x0
 ? do_syscall_64 (arch/x86/entry/common.c:102) 
   .se->load.weight               : 8798
 
   .util_avg                      : 1024
 
  </TASK>
   .util_est_enqueued             : 0
   .right_vruntime                : 0.000001
         0.000000         2.107902         0.000000         0.000000
 
  R
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 kthread (kernel/kthread.c:388) 
  S
 RAX: ffffffffffffffda RBX: 00007fffe8a59240 RCX: 00007f5eb8fa6167
 console_blast.s  3816         0.833077 E         3.313971         3.000000         3.252947         4   120 
 >R
   .spread                        : 0.000000
   .nr_uninterruptible            : -3
           sleep  4247       760.991109 E       763.991109         3.000000         1.168133         1   120 
 RAX: ffffffffffffffda RBX: 00007ffc0efe2090 RCX: 00007fb29f2e1167
   .removed.load_avg              : 0
  S
 Call Trace:
  <TASK>
   .nr_spread_over                : 0
 worker_thread (kernel/workqueue.c:2734) 
  /
         0.000000         1.168133         0.000000         0.000000
 
 
  (mm_percpu_wq)
 ? do_syscall_64 (arch/x86/entry/common.c:102) 
  </TASK>
   .next_balance                  : 4294.870313
  /user.slice/user-0.slice/session-1.scope
 console_blast.s  4116         5.673854 E         8.299992         3.000000         2.476680         4   120 
 console_blast.s  3622     34452.049073 N     34455.049073         3.000000     34452.470317         6   120 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  <TASK>
   .removed.util_avg              : 0
 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  S
   .nr_running                    : 1
         0.000000     34452.470317         0.000000         0.000000
   .se->avg.load_avg              : 7
         0.000000         2.476680         0.000000         0.000000
         0.000000         3.252947         0.000000         0.000000
 task:kworker/147:1   state:I
   .se->avg.util_avg              : 1024
  idle_inject/20   138        -1.048470 E         1.951530         3.000000         0.001521         3    49 
  /user.slice/user-0.slice/session-1.scope
  R
 
   .se->avg.runnable_avg          : 3072
   .removed.runnable_avg          : 0
   .h_nr_running                  : 2
  /user.slice/user-0.slice/session-1.scope
  R
   .idle_nr_running               : 0
   .nr_running                    : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 kthread (kernel/kthread.c:388) 
 schedule_timeout (kernel/time/timer.c:1635 ./include/linux/timer.h:199 kernel/time/timer.c:2175) 
           sleep  4219       766.197110 E       769.197110         3.000000         1.060727         1   120 
   .tg_load_avg_contrib           : 17
  /user.slice/user-0.slice/session-1.scope
 
 
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
         0.000000         0.001521         0.000000         0.000000
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 RDX: 00007fffe8a59240 RSI: 0000000000000000 RDI: 0000000000000000
 cfs_rq[17]:/user.slice
   .tg_load_avg                   : 2026
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
           sleep  4306      1139.575216 E      1142.575216         3.000000         1.191652         1   120 
   .idle_h_nr_running             : 0
  /
         0.000000         1.060727         0.000000         0.000000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  R
  S
 
   .exec_clock                    : 0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
    migration/20   139        40.541546 E        41.290758         0.750000     10235.071352        45     0 
   .left_vruntime                 : 0.000001
   .throttled                     : 0
  /user.slice/user-0.slice/session-1.scope
   .min_vruntime                  : 4398353.428294
 
     pending:
 ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
         0.000000         1.191652         0.000000         0.000000
   .nr_switches                   : 1317
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
  R
         0.000000     10235.071352         0.000000         0.000000
   .curr->pid                     : 0
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
 console_blast.s  3816         0.833077 E         3.313971         3.000000         3.252947         4   120 
 worker_thread (kernel/workqueue.c:2734) 
  R
 smpboot_thread_fn (kernel/smpboot.c:160) 
 idle_inject/162   990        -1.042195 E         1.954926         3.000000         0.008217         3    49 
   .throttle_count                : 0
 RDX: 00007ffc0efe2090 RSI: 0000000000000000 RDI: 0000000000000000
   .avg_vruntime                  : 4398353.428294
  /user.slice/user-0.slice/session-1.scope
   .load                          : 12024
 
  /
  </TASK>
   .nr_uninterruptible            : -2
 
 task:taskset         state:S
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
 
           sleep  4248       790.763772 E       793.763772         3.000000         1.142544         1   120 
  R
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
           sleep  4280      1331.430690 E      1334.430690         3.000000         1.124666         2   120 
    ksoftirqd/20   140     97262.314120 E     97265.314120         3.000000         0.000881         3   120 
 
   .load_avg                      : 11
  stack:0     pid:1759  tgid:1759  ppid:2      flags:0x00004000
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
  stack:0     pid:4098  tgid:4098  ppid:4060   flags:0x00000002
 RBP: 00007ffc0efe2040 R08: 0000000000000000 R09: 0000000000000000
 ? __pfx_process_timeout (kernel/time/timer.c:2098) 
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
   .right_vruntime                : 0.000001
 cpu#53, 1900.000 MHz
   .clock                         : 208129.555375
         0.000000         1.124666         0.000000         0.000000
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .se->exec_start                : 207967.102214
  /user.slice/user-0.slice/session-1.scope
   .runnable_avg                  : 2048
   .nr_running                    : 5
 kthread (kernel/kthread.c:388) 
 Call Trace:
         0.000000         1.142544         0.000000         0.000000
   .spread                        : 0.000000
 ? _raw_spin_lock (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4)) 
   .next_balance                  : 4294.870413
   .util_avg                      : 1024
   .se->vruntime                  : 4456597.212089
         0.000000         0.000881         0.000000         0.000000
   .se->avg.runnable_avg          : 3072
   .nr_switches                   : 269
  /
   .nr_spread_over                : 0
   .se->sum_exec_runtime          : 34723.873306
         0.000000         3.252947         0.000000         0.000000
   .util_est_enqueued             : 0
 
 worker_thread (kernel/workqueue.c:2734) 
  /user.slice/user-0.slice/session-1.scope
  /user.slice/user-0.slice/session-1.scope
  </TASK>
  I
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
   .nr_running                    : 1
   .nr_uninterruptible            : -4
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
 task:cpuhp/19        state:S
 
   .clock_task                    : 208090.886111
   .next_balance                  : 4294.870351
 
   .removed.load_avg              : 0
   .se->load.weight               : 8798
    kworker/20:0   141        38.956058 E        41.956058         3.000000         0.001667         4   120 
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
  </TASK>
 
   .removed.util_avg              : 0
 
 
   .h_nr_running                  : 3
   .curr->pid                     : 3622
   .se->avg.load_avg              : 7
 Call Trace:
 cpu#54, 1900.000 MHz
         0.000000         0.001667         0.000000         0.000000
  R
   .nr_running                    : 2
   .idle_nr_running               : 0
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->avg.util_avg              : 1024
           sleep  4248       790.763772 E       793.763772         3.000000         1.142544         1   120 
 ? do_syscall_64 (arch/x86/entry/common.c:102) 
   .se->avg.runnable_avg          : 3072
 task:migration/39    state:R
   .removed.runnable_avg          : 0
   .idle_h_nr_running             : 0
   .nr_switches                   : 301
  /
 R10: 00007ffc0efe2080 R11: 0000000000000202 R12: 00007fb29f2056c8
 
   .nr_uninterruptible            : -3
   .load                          : 8798
   .tg_load_avg_contrib           : 11
 
 cpu#26, 1900.000 MHz
   .load_avg                      : 8
 Call Trace:
   .clock                         : 208138.007006
         0.000000         1.142544         0.000000         0.000000
 cfs_rq[28]:/user.slice
   .nr_running                    : 5
  I
   .clock_task                    : 208088.464512
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .tg_load_avg                   : 2026
   kworker/20:0H   142       181.803384 E       181.837903         3.000000         0.015103         4   100 
   .nr_switches                   : 838
   .runnable_avg                  : 3072
  /user.slice/user-0.slice/session-1.scope
   .avg_idle                      : 1000000
  <TASK>
  i40e_service_task [i40e]
   .util_avg                      : 1024
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
         0.000000         0.015103         0.000000         0.000000
   .max_idle_balance_cost         : 500000
 
   .nr_uninterruptible            : 5
   .next_balance                  : 4294.870387
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .throttled                     : 0
   .exec_clock                    : 0.000000
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 
   .curr->pid                     : 3820
 Workqueue:  0x0
 
  /
 kthread (kernel/kthread.c:388) 
   .util_est_enqueued             : 0
   .next_balance                  : 4294.870340
 
   .curr->pid                     : 3524
 RIP: 0033:0x7ff079799c74
   .left_vruntime                 : 0.000001
  </TASK>
   running task    
   .throttle_count                : 0
   .clock                         : 208142.896875
   .min_vruntime                  : 4456735.892024
   .clock_task                    : 208037.638922
 cpu#54, 1900.000 MHz
   .se->exec_start                : 208028.447682
 cfs_rq[53]:/user.slice/user-0.slice/session-1.scope
   .clock                         : 208141.406132
   .exec_clock                    : 0.000000
   .nr_running                    : 2
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .avg_vruntime                  : 4456735.892024
  (events_unbound)
   .clock_task                    : 208006.423060
 RBP: 00007fffe8a591f0 R08: 0000000000000000 R09: 0000000000000000
   .avg_idle                      : 1000000
   .left_vruntime                 : 790.763772
 ? __pfx_kthread (kernel/kthread.c:341) 
   .avg_idle                      : 1000000
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
  I
   .max_idle_balance_cost         : 500000
   .removed.load_avg              : 0
   .nr_switches                   : 301
   .right_vruntime                : 0.000001
 RSP: 002b:00007fff94510368 EFLAGS: 00000202
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 kworker/u450:16  1454        38.956058 E        41.818696         3.000000        40.004528         3   120 
   .se->vruntime                  : 6964116.547114
   .spread                        : 0.000000
 R10: 00007fffe8a59230 R11: 0000000000000202 R12: 00007f5eb8eca6c8
   .max_idle_balance_cost         : 500000
   .min_vruntime                  : 790.763772
  stack:0     pid:253   tgid:253   ppid:2      flags:0x00004000
   .nr_spread_over                : 0
 kthread (kernel/kthread.c:388) 
   .se->sum_exec_runtime          : 34393.810828
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .avg_vruntime                  : 17621.406422
  stack:0     pid:131   tgid:131   ppid:2      flags:0x00004000
   .avg_idle                      : 1114779
   .right_vruntime                : 790.763772
 
  <TASK>
 cfs_rq[54]:/user.slice/user-0.slice/session-1.scope
   .spread                        : 0.000000
 ? __handle_mm_fault (mm/memory.c:5180) 
   .se->load.weight               : 5693
 
   .removed.util_avg              : 0
   .se->avg.load_avg              : 4
   .nr_running                    : 1
 cfs_rq[26]:/user.slice/user-0.slice/session-1.scope
   .exec_clock                    : 0.000000
 ret_from_fork (arch/x86/kernel/process.c:147) 
         0.000000        40.004528         0.000000         0.000000
   .se->avg.util_avg              : 1024
 task:kworker/11:0H   state:I
   .nr_uninterruptible            : -3
   .removed.runnable_avg          : 0
  /
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .left_vruntime                 : 33777.074030
 ret_from_fork (arch/x86/kernel/process.c:147) 
 Call Trace:
   .se->avg.runnable_avg          : 2048
 
         0.000000         0.008217         0.000000         0.000000
 
 
   .min_vruntime                  : 17883.838663
   .exec_clock                    : 0.000000
   .nr_spread_over                : 0
   .next_balance                  : 4294.870387
   .h_nr_running                  : 3
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 cfs_rq[51]:/user.slice
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  <TASK>
 R13: 00007fffe8a59230 R14: 0000000000000002 R15: 00007fffe8a59230
 ? __pfx_kthread (kernel/kthread.c:341) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 Call Trace:
  R
   .curr->pid                     : 0
  <TASK>
   .avg_vruntime                  : 25830.673055
   .exec_clock                    : 0.000000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .left_vruntime                 : 767.733831
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .clock                         : 208010.267801
 
   .right_vruntime                : 33777.074030
 
   .max_idle_balance_cost         : 615743
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 schedule_preempt_disabled (kernel/sched/core.c:6856) 
   .tg_load_avg_contrib           : 8
   .min_vruntime                  : 767.733831
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .left_vruntime                 : 0.000001
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  (events_highpri)
   .tg_load_avg                   : 1488
   .clock_task                    : 207961.599389
   .nr_running                    : 2
 R13: 00007ffc0efe2080 R14: 0000000000000002 R15: 00007ffc0efe2080
  </TASK>
 worker_thread (kernel/workqueue.c:2734) 
   .spread                        : 0.000000
 Stopper: 0x0 <- 0x0
   .h_nr_running                  : 2
   .throttled                     : 0
 
   .avg_vruntime                  : 12296.053301
 kthread (kernel/kthread.c:388) 
  </TASK>
   .throttle_count                : 0
   .idle_nr_running               : 0
   .nr_spread_over                : 0
   .min_vruntime                  : 6964338.572227
   .curr->pid                     : 3820
   .se->exec_start                : 208034.879130
    kworker/20:1  1635     65513.355468 E     65516.355468         3.000000         0.113279        14   120 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->vruntime                  : 7051119.625257
  /
   .nr_running                    : 2
   .idle_nr_running               : 0
  <TASK>
   .idle_h_nr_running             : 0
         0.000000         0.113279         0.000000         0.000000
 worker_thread (kernel/workqueue.c:2734) 
  (mm_percpu_wq)
   .avg_vruntime                  : 6964338.572227
   .idle_h_nr_running             : 0
   .se->sum_exec_runtime          : 34788.897010
   .load                          : 2097152
   .right_vruntime                : 1332.724096
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .load_avg                      : 2047
 ? try_to_wake_up (./arch/x86/include/asm/preempt.h:104 ./include/linux/preempt.h:484 ./include/linux/preempt.h:484 kernel/sched/core.c:4217) 
   .avg_idle                      : 2121695
   .right_vruntime                : 0.000001
  </TASK>
   .clock                         : 208143.547951
   .se->load.weight               : 5637
  /
   .load                          : 8798
 
   .clock_task                    : 208006.856478
 
   .runnable_avg                  : 2047
   .se->avg.load_avg              : 4
   .spread                        : 0.000000
   .h_nr_running                  : 2
   .avg_idle                      : 1000000
  stack:0     pid:88    tgid:88    ppid:2      flags:0x00004000
 cfs_rq[178]:/
   .se->avg.util_avg              : 1024
 smpboot_thread_fn (kernel/smpboot.c:160) 
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .nr_spread_over                : 0
   .se->avg.runnable_avg          : 3072
   .idle_nr_running               : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .load_avg                      : 8
   .util_avg                      : 1023
 Call Trace:
   .max_idle_balance_cost         : 500000
   .max_idle_balance_cost         : 1130474
 Workqueue:  0x0
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 task:sleep           state:R
   .spread                        : 564.990265
   .nr_running                    : 1
  I
   .idle_h_nr_running             : 0
 
   .h_nr_running                  : 2
   .nr_spread_over                : 0
   .load                          : 2097152
 
   .runnable_avg                  : 3072
 kthread (kernel/kthread.c:388) 
 cfs_rq[54]:/user.slice/user-0.slice/session-1.scope
   .nr_running                    : 3
   .idle_nr_running               : 0
   .util_est_enqueued             : 0
 __mutex_lock.constprop.0 (kernel/locking/mutex.c:197 kernel/locking/mutex.c:681 kernel/locking/mutex.c:747) 
   .idle_h_nr_running             : 0
   .util_avg                      : 1024
  <TASK>
   .load_avg                      : 2048
   .load                          : 5693
 worker_thread (kernel/workqueue.c:2734) 
 cfs_rq[17]:/
   kworker/20:1H  2823       181.803656 E       181.838242         3.000000         0.009815         2   100 
 ? __pfx_kthread (kernel/kthread.c:341) 
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .util_est_enqueued             : 0
   .removed.load_avg              : 0
   .load_avg                      : 5
  (events_highpri)
   .exec_clock                    : 0.000000
  </TASK>
   .h_nr_running                  : 3
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .removed.load_avg              : 0
 
   .idle_nr_running               : 0
   .removed.util_avg              : 0
   .removed.util_avg              : 0
   .idle_h_nr_running             : 0
   .removed.runnable_avg          : 0
   .left_vruntime                 : 33777.074030
   .runnable_avg                  : 2048
 task:kworker/10:0H   state:I
   .runnable_avg                  : 2048
 worker_thread (kernel/workqueue.c:2734) 
   running task    
   .exec_clock                    : 0.000000
   .util_avg                      : 1024
 ? __pfx_kthread (kernel/kthread.c:341) 
   .util_avg                      : 1024
   .left_vruntime                 : 55735.034269
 ? __pfx_kthread (kernel/kthread.c:341) 
   .load                          : 3145728
  stack:0     pid:82    tgid:82    ppid:2      flags:0x00004000
   .removed.runnable_avg          : 0
   .min_vruntime                  : 17885.102426
   .min_vruntime                  : 55735.254269
   .exec_clock                    : 0.000000
 task:kworker/127:0   state:I
 kthread (kernel/kthread.c:388) 
   .avg_vruntime                  : 87308.720187
   .util_est_enqueued             : 0
   .load_avg                      : 3072
   .right_vruntime                : 84879.423171
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .util_est_enqueued             : 0
   .tg_load_avg_contrib           : 2042
   .avg_vruntime                  : 25831.088228
  S
  stack:0     pid:1521  tgid:1521  ppid:2      flags:0x00004000
 task:kworker/162:1   state:I
 
   .runnable_avg                  : 3072
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
  ORIG_RAX: 0000000000000001
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
 task:kworker/u450:20 state:I
 Workqueue:  0x0
   .util_avg                      : 1024
   .removed.load_avg              : 0
 
   .right_vruntime                : 33777.074030
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
         0.000000         0.009815         0.000000         0.000000
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .removed.util_avg              : 0
   .util_est_enqueued             : 0
   .removed.load_avg              : 0
 RIP: 0033:0x7f6d0c61cd07
 pool 234:
  /
   .removed.util_avg              : 0
   .spread                        : 0.000000
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .removed.load_avg              : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .removed.runnable_avg          : 0
 
 task:kworker/198:1   state:I
 Call Trace:
   .tg_load_avg_contrib           : 5
   .nr_spread_over                : 0
   .tg_load_avg                   : 1488
  stack:0     pid:4274  tgid:4274  ppid:3900   flags:0x00000002
 RSP: 002b:00007ffef1f14b58 EFLAGS: 00000202
 ? __pfx_kthread (kernel/kthread.c:341) 
 smpboot_thread_fn (kernel/smpboot.c:160) 
   .removed.util_avg              : 0
   .throttled                     : 0
   .tg_load_avg_contrib           : 8
   .spread                        : 29144.388902
   .tg_load_avg                   : 178559
   .removed.runnable_avg          : 0
   .tg_load_avg                   : 1488
   migration/162   991        88.612763 E        91.611703         3.000000     10459.643851        55     0 
   .throttled                     : 0
 kthread (kernel/kthread.c:388) 
 >R
   .throttle_count                : 0
 console_blast.s  3500     34809.276853 N     34812.276853         3.000000     34786.282495         5   120 
   .nr_spread_over                : 0
   .se->exec_start                : 208030.441781
 ? __pfx_kthread (kernel/kthread.c:341) 
   .nr_running                    : 2
   .removed.runnable_avg          : 0
   .throttle_count                : 0
         0.000000     34786.282495         0.000000         0.000000
  stack:0     pid:783   tgid:783   ppid:2      flags:0x00004000
   .h_nr_running                  : 2
 ? __pfx_kthread (kernel/kthread.c:341) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 kthread (kernel/kthread.c:388) 
   .throttled                     : 0
 ? avc_has_perm_noaudit (security/selinux/avc.c:1167) 
         0.000000     10459.643851         0.000000         0.000000
 
   .tg_load_avg_contrib           : 2024
 ret_from_fork (arch/x86/kernel/process.c:147) 
  <TASK>
   .se->exec_start                : 208088.464512
   .idle_nr_running               : 0
   .throttle_count                : 0
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 cfs_rq[4]:/user.slice
   .se->vruntime                  : 11718824.508045
   .idle_h_nr_running             : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .se->vruntime                  : 3168692.520104
   .se->exec_start                : 207969.491837
   .tg_load_avg                   : 178559
  stack:0     pid:1473  tgid:1473  ppid:2      flags:0x00004000
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->sum_exec_runtime          : 34453.190727
   .nr_running                    : 3
   .se->sum_exec_runtime          : 34395.804927
  /user.slice/user-0.slice/session-1.scope
   .h_nr_running                  : 5
  ORIG_RAX: 000000000000003d
 ? __pfx_kthread (kernel/kthread.c:341) 
 cfs_rq[170]:/
   .throttled                     : 0
 smpboot_thread_fn (kernel/smpboot.c:160) 
  </TASK>
   .load                          : 2097152
   .se->vruntime                  : 7040612.160458
   .se->load.weight               : 12026
   .tg_load_avg_contrib           : 3047
   .idle_nr_running               : 0
 Workqueue:  0x0
   .se->sum_exec_runtime          : 34727.705227
   .se->avg.load_avg              : 10
   .throttle_count                : 0
 
   .se->load.weight               : 3523
   .se->exec_start                : 208007.686823
   .se->load.weight               : 5637
   .load_avg                      : 2048
  (events_highpri)
   .se->avg.load_avg              : 2
 iterate_tty_write (drivers/tty/tty_io.c:957 (discriminator 1) drivers/tty/tty_io.c:973 (discriminator 1)) 
  stack:0     pid:1774  tgid:1774  ppid:2      flags:0x00004000
   .runnable_avg                  : 2048
  </TASK>
 ? fill_page_cache_func (kernel/rcu/tree.c:3261 (discriminator 3)) 
   .se->avg.load_avg              : 4
   .se->avg.util_avg              : 1024
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 kthread (kernel/kthread.c:388) 
  cpus=117
   .util_avg                      : 1024
 RAX: ffffffffffffffda RBX: 00000000000010bf RCX: 00007f6d0c61cd07
   .tg_load_avg                   : 178559
   .idle_h_nr_running             : 0
   .se->avg.util_avg              : 1024
   .exec_clock                    : 0.000000
 ? file_has_perm (security/selinux/hooks.c:1759) 
   .se->avg.runnable_avg          : 2048
  S
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 console_blast.s  3720        22.687922 E        25.266887         3.000000         3.494354         4   120 
   .load                          : 2102789
 
   .se->vruntime                  : 3164876.002386
 task:sleep           state:R
   .load_avg                      : 2053
   .se->avg.runnable_avg          : 3072
 cfs_rq[51]:/
         0.000000         3.494354         0.000000         0.000000
   .util_est_enqueued             : 0
   .se->avg.util_avg              : 1023
 hrtimer_nanosleep (kernel/time/hrtimer.c:2101) 
 
   .throttled                     : 0
  (mm_percpu_wq)
 cfs_rq[28]:/
   .exec_clock                    : 0.000000
  /user.slice/user-0.slice/session-1.scope
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 kthread (kernel/kthread.c:388) 
   .exec_clock                    : 0.000000
   .se->avg.runnable_avg          : 2047
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->sum_exec_runtime          : 34397.506925
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .left_vruntime                 : 10547918.653827
   .left_vruntime                 : 59318.094212
   .throttle_count                : 0
 
  </TASK>
   .se->load.weight               : 12025
   .se->exec_start                : 208038.586015
   .removed.load_avg              : 0
 task:ksoftirqd/97    state:S
   .left_vruntime                 : 0.000001
 
   .runnable_avg                  : 5120
 cfs_rq[53]:/user.slice/user-0.slice
   .min_vruntime                  : 59318.094212
   .removed.util_avg              : 0
  S
 task:ksoftirqd/39    state:R
   .se->avg.load_avg              : 10
   .min_vruntime                  : 10549972.653827
  stack:0     pid:1814  tgid:1814  ppid:2      flags:0x00004000
   .left_vruntime                 : 0.000001
   .se->vruntime                  : 2079640.954164
  stack:0     pid:602   tgid:602   ppid:2      flags:0x00004000
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .removed.runnable_avg          : 0
   .exec_clock                    : 0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
 console_blast.s  3912        25.143113 E        27.566505         3.000000         3.290408         5   120 
   .avg_vruntime                  : 93242.568992
 ? __pfx_kthread (kernel/kthread.c:341) 
   .util_avg                      : 1024
   .left_vruntime                 : 0.000001
   .avg_vruntime                  : 10551339.902245
   .se->sum_exec_runtime          : 34790.825437
   .se->avg.util_avg              : 1024
 kcompactd (mm/compaction.c:3086 (discriminator 13)) 
  node=0
   .min_vruntime                  : 3168692.520104
 RAX: ffffffffffffffda RBX: 000000000000005b RCX: 00007ff079799c74
   .right_vruntime                : 59318.094212
   .min_vruntime                  : 4395792.774550
   .tg_load_avg_contrib           : 2024
 RIP: 0033:0x7f4002dba167
 
   .se->load.weight               : 18037
   .se->avg.runnable_avg          : 2048
 file_tty_write.isra.0 (drivers/tty/tty_io.c:1092) 
   .right_vruntime                : 10547918.653827
         0.000000         3.290408         0.000000         0.000000
 
   .se->avg.load_avg              : 16
  </TASK>
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .spread                        : 0.000000
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 RDX: 0000000000000000 RSI: 00007ffef1f14b90 RDI: 00000000ffffffff
 Call Trace:
   .tg_load_avg                   : 178559
 worker_thread (kernel/workqueue.c:2734) 
   .spread                        : 0.000000
   .avg_vruntime                  : 3168692.520104
  flags=0x0 nice=0
   .se->avg.util_avg              : 1024
   running task    
 Call Trace:
 Call Trace:
   .right_vruntime                : 0.000001
   .util_est_enqueued             : 1356
   .spread                        : 0.000000
 vfs_write (./include/linux/fs.h:2020 fs/read_write.c:491 fs/read_write.c:584) 
   .throttled                     : 0
  /user.slice/user-0.slice/session-1.scope
  /
   .se->avg.runnable_avg          : 3072
 cfs_rq[54]:/user.slice/user-0.slice
   .nr_spread_over                : 0
   running task    
 
   .nr_spread_over                : 0
   .nr_spread_over                : 0
 
   .throttle_count                : 0
   .exec_clock                    : 0.000000
 cfs_rq[26]:/user.slice/user-0.slice
   .nr_running                    : 2
 Workqueue:  0x0
   .exec_clock                    : 0.000000
   .nr_running                    : 2
   .removed.load_avg              : 0
   .se->exec_start                : 208008.835791
  S
   .removed.util_avg              : 0
  <TASK>
   .left_vruntime                 : 0.000001
   .h_nr_running                  : 4
   .nr_running                    : 1
   .removed.runnable_avg          : 0
  hung=19s workers=4
   .left_vruntime                 : 0.000001
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .min_vruntime                  : 16272.963166
   .tg_load_avg_contrib           : 0
 ksys_write (fs/read_write.c:637) 
   .min_vruntime                  : 2079767.836377
   .h_nr_running                  : 2
 ? __pfx_kthread (kernel/kthread.c:341) 
   .avg_vruntime                  : 4395792.774550
  </TASK>
 ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1935) 
   .min_vruntime                  : 3164982.960861
   .idle_nr_running               : 0
   .se->vruntime                  : 3164982.960861
   .h_nr_running                  : 3
 console_blast.s  4091        22.266887 E        24.855117         3.000000         2.499660         3   120 
 RDX: 000000000000005b RSI: 0000560f80c8d2c0 RDI: 0000000000000001
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .idle_nr_running               : 0
  idle: 1726
   .avg_vruntime                  : 3164982.960861
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .tg_load_avg                   : 0
   .idle_h_nr_running             : 0
   .avg_vruntime                  : 2079767.836377
   .throttled                     : 0
   .idle_h_nr_running             : 0
   .idle_nr_running               : 0
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
 task:kworker/106:0H  state:I
   .right_vruntime                : 0.000001
   .throttle_count                : 0
   .avg_vruntime                  : 16272.963166
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  3301
 
 common_nsleep (kernel/time/posix-timers.c:1353) 
 ? __schedule (kernel/sched/core.c:6714) 
   .load                          : 1054213
  <TASK>
   .se->sum_exec_runtime          : 34397.506925
   .right_vruntime                : 0.000001
         0.000000         2.499660         0.000000         0.000000
   .spread                        : 0.000000
 kthread (kernel/kthread.c:388) 
   .se->load.weight               : 12025
  <TASK>
   .idle_h_nr_running             : 0
   .se->avg.load_avg              : 10
  stack:0     pid:254   tgid:254   ppid:2      flags:0x00004000
 
   .load                          : 1052099
  stack:0     pid:658   tgid:658   ppid:2      flags:0x00004000
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 rt_rq[17]:
  /user.slice/user-0.slice/session-1.scope
   .load_avg                      : 1029
   .load_avg                      : 1027
   .load                          : 12026
   .rt_nr_running                 : 0
   .nr_spread_over                : 0
   .right_vruntime                : 0.000001
   .load_avg                      : 11
 ? __pfx_kthread (kernel/kthread.c:341) 
   .runnable_avg                  : 4097
 
 ? handle_mm_fault (mm/memory.c:5222 mm/memory.c:5361) 
 
   .runnable_avg                  : 3073
   .nr_running                    : 1
 ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
   .rt_throttled                  : 0
   .se->avg.util_avg              : 1024
 Workqueue:  0x0
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .spread                        : 0.000000
   .util_avg                      : 1024
 RBP: 00007ffef1f14bd0 R08: 0000558cba56b1d0 R09: 0000000000000001
 ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5839 (discriminator 1) kernel/sched/core.c:5836 (discriminator 1) kernel/sched/core.c:5864 (discriminator 1)) 
   .right_vruntime                : 0.000001
   .nr_spread_over                : 0
 ? __pfx_kthread (kernel/kthread.c:341) 
   .util_est_enqueued             : 1588
 task:ksoftirqd/14    state:R
   .util_avg                      : 1024
   .runnable_avg                  : 2047
  S
   .se->avg.runnable_avg          : 2048
   .nr_running                    : 1
   .util_est_enqueued             : 511
   .util_avg                      : 1023
  R          sleep  4215       786.779707 E       789.779707         3.000000         1.076314         1   120 
 worker_thread (kernel/workqueue.c:2734) 
 RSP: 002b:00007ffdba3de878 EFLAGS: 00000202
   .h_nr_running                  : 2
   .spread                        : 0.000000
         0.000000         1.076314         0.000000         0.000000
   .removed.load_avg              : 0
   .h_nr_running                  : 3
   .removed.load_avg              : 0
 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 RBP: 00007fff94510390 R08: 0000000000000000 R09: 0000000000000001
  /user.slice/user-0.slice/session-1.scope
   .removed.util_avg              : 0
   ksoftirqd/162   992        -1.041676 E         1.956071         3.000000         0.007274         3   120 
   .idle_nr_running               : 0
 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
   .idle_nr_running               : 0
   .removed.util_avg              : 0
   .util_est_enqueued             : 0
  </TASK>
   .removed.runnable_avg          : 0
   .idle_h_nr_running             : 0
   .rt_time                       : 0.000000
   .tg_load_avg_contrib           : 0
 
 
   .exec_clock                    : 0.000000
 ? __pfx_kcompactd (mm/compaction.c:3060) 
  ORIG_RAX: 00000000000000e6
   .idle_h_nr_running             : 0
 cfs_rq[54]:/user.slice/user-0.slice
  (events_highpri)
   .exec_clock                    : 0.000000
   .tg_load_avg                   : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .load                          : 12025
   .load                          : 18037
   .removed.runnable_avg          : 0
  R
   .load_avg                      : 11
 kthread (kernel/kthread.c:388) 
   .rt_runtime                    : 950.000000
 Workqueue:  0x0
 Workqueue:  0x0
 Call Trace:
   .removed.load_avg              : 0
           sleep  4277      1164.357159 E      1167.357159         3.000000         0.951373         1   120 
   .throttled                     : 0
   .tg_load_avg_contrib           : 0
   .load_avg                      : 17
   .left_vruntime                 : 0.000001
   .tg_load_avg                   : 0
   .runnable_avg                  : 2048
         0.000000         0.951373         0.000000         0.000000
   .runnable_avg                  : 3072
 ? up_read (./arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1622) 
   .util_avg                      : 1024
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .throttled                     : 0
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .nr_spread_over                : 0
   .util_est_enqueued             : 0
   .throttle_count                : 0
  /user.slice/user-0.slice/session-1.scope
 ? do_user_addr_fault (arch/x86/mm/fault.c:1445 (discriminator 1)) 
 R10: 0000000000000004 R11: 0000000000000202 R12: 000000000000005b
 
   .util_avg                      : 1024
 
 RAX: ffffffffffffffda RBX: 00007ffdba3de8d0 RCX: 00007f4002dba167
 task:kcompactd0      state:S
   .removed.load_avg              : 0
  (cgroup_destroy)
  stack:0     pid:4248  tgid:4248  ppid:3816   flags:0x00000002
 
   .util_est_enqueued             : 0
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .min_vruntime                  : 3165099.171269
   .removed.util_avg              : 0
 dl_rq[17]:
 Call Trace:
 
   .removed.util_avg              : 0
   .throttle_count                : 0
 rt_rq[51]:
 kthread (kernel/kthread.c:388) 
 
   .nr_running                    : 0
   .removed.runnable_avg          : 0
   .rt_nr_running                 : 0
   .removed.runnable_avg          : 0
   .removed.load_avg              : 0
 task:idle_inject/19  state:S
   .dl_nr_running                 : 0
         0.000000         0.007274         0.000000         0.000000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
   .avg_vruntime                  : 3165169.892991
 
   .tg_load_avg_contrib           : 11
   .rt_throttled                  : 0
 cpu#21, 1900.000 MHz
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .right_vruntime                : 0.000001
 Call Trace:
 ? default_do_nmi (arch/x86/kernel/nmi.c:351) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 R13: 0000560f80c8d2c0 R14: 00007ff07986a5c0 R15: 00007ff079867f20
   .removed.util_avg              : 0
 smpboot_thread_fn (kernel/smpboot.c:160) 
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .spread                        : 0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
 worker_thread (kernel/workqueue.c:2734) 
   .tg_load_avg_contrib           : 11
   .rt_time                       : 0.000000
 rt_rq[28]:
 ? __pfx_kthread (kernel/kthread.c:341) 
   .left_vruntime                 : 0.000001
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
  <TASK>
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 ? exc_nmi (arch/x86/kernel/nmi.c:545) 
 kthread (kernel/kthread.c:388) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .rt_runtime                    : 950.000000
 worker_thread (kernel/workqueue.c:2734) 
   .nr_running                    : 5
   .dl_bw->bw                     : 996147
  </TASK>
   .h_nr_running                  : 0
   .spread                        : 0.000000
   .rt_nr_running                 : 0
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 kthread (kernel/kthread.c:388) 
   .nr_spread_over                : 0
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .tg_load_avg                   : 2026
  </TASK>
   .dl_bw->total_bw               : 0
  <TASK>
   running task    
 
   .nr_running                    : 1
 ? __pfx_kthread (kernel/kthread.c:341) 
   .removed.runnable_avg          : 0
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
 Call Trace:
 
   .nr_switches                   : 571
   .tg_load_avg_contrib           : 17
 __x64_sys_clock_nanosleep (kernel/time/posix-timers.c:1396 kernel/time/posix-timers.c:1373 kernel/time/posix-timers.c:1373) 
 dl_rq[51]:
   .throttled                     : 0
 runnable tasks:
   .nr_uninterruptible            : -2
   .dl_nr_running                 : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .rt_throttled                  : 0
 worker_thread (kernel/workqueue.c:2734) 
   .next_balance                  : 4294.870340
   .tg_load_avg                   : 2026
   .h_nr_running                  : 2
   .tg_load_avg                   : 2026
   .throttle_count                : 0
   .dl_bw->bw                     : 996147
 ? __pfx_kthread (kernel/kthread.c:341) 
   .rt_time                       : 0.000000
 RDX: 00007ffdba3de8d0 RSI: 0000000000000000 RDI: 0000000000000000
   .curr->pid                     : 3501
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
 ? __pfx_kthread (kernel/kthread.c:341) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .se->exec_start                : 208088.464512
   .dl_bw->total_bw               : 0
   .clock                         : 208147.499540
   .rt_runtime                    : 950.000000
   .throttled                     : 0
 Call Trace:
   .idle_nr_running               : 0
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 
 worker_thread (kernel/workqueue.c:2734) 
   .throttle_count                : 0
 -------------------------------------------------------------------------------------------------------------
   .clock_task                    : 208037.119313
 dl_rq[28]:
   .se->vruntime                  : 6974999.717662
   .idle_h_nr_running             : 0
   .avg_idle                      : 975453
  <TASK>
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 Call Trace:
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 
   .throttled                     : 0
 Workqueue:  0x0
   .se->sum_exec_runtime          : 34453.190727
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 
 runnable tasks:
   .load                          : 12025
   .se->exec_start                : 208010.843851
   .max_idle_balance_cost         : 500000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .dl_nr_running                 : 0
   .se->vruntime                  : 6965484.659526
  S
   .throttle_count                : 0
   .se->load.weight               : 5693
   .dl_bw->bw                     : 996147
   .se->sum_exec_runtime          : 34399.514985
  stack:0     pid:104   tgid:104   ppid:2      flags:0x00004000
   .se->load.weight               : 5693
 RIP: 0033:0x7f1042c5fc74
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_kthread (kernel/kthread.c:341) 
  </TASK>
 Call Trace:
   .nr_spread_over                : 0
  <TASK>
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
        cpuhp/17   119       422.431808 E       425.427449         3.000000         1.531719        35   120 
   .load_avg                      : 11
 
  </TASK>
   .se->exec_start                : 208043.148735
   .dl_bw->total_bw               : 0
  /
 -------------------------------------------------------------------------------------------------------------
   .runnable_avg                  : 2048
   .se->avg.load_avg              : 4
         0.000000         1.531719         0.000000         0.000000
  (mm_percpu_wq)
   .se->avg.load_avg              : 4
 
 task:kworker/168:1   state:I
 Call Trace:
   .se->avg.util_avg              : 1024
 cfs_rq[21]:/user.slice/user-0.slice/session-1.scope
   .se->vruntime                  : 4425426.460114
   .util_avg                      : 1024
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .se->sum_exec_runtime          : 34795.388157
  </TASK>
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->avg.runnable_avg          : 2048
   .exec_clock                    : 0.000000
  /
   .se->avg.util_avg              : 1023
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 task:console_blast.s state:S
 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 runnable tasks:
  S
 
   .min_vruntime                  : 21076.391649
  <TASK>
   .se->load.weight               : 8798
  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  idle_inject/17   120        -1.045752 E         1.951434         3.000000         0.006978         3    49 
   .left_vruntime                 : 765.923807
   .util_est_enqueued             : 0
  (events_unbound)
   .se->avg.load_avg              : 7
 do_nanosleep (kernel/time/hrtimer.c:1446 kernel/time/hrtimer.c:2049) 
  </TASK>
         0.000000         0.006978         0.000000         0.000000
   .se->avg.runnable_avg          : 2047
 
  /
 
   .se->avg.util_avg              : 1024
 cfs_rq[54]:/user.slice
 ? fill_page_cache_func (kernel/rcu/tree.c:3261 (discriminator 3)) 
   .removed.load_avg              : 0
 
 cfs_rq[53]:/user.slice
   .removed.util_avg              : 0
   .se->avg.runnable_avg          : 3072
  </TASK>
  R
 RBP: 00007ffdba3de880 R08: 0000000000000000 R09: 0000000000000000
   .exec_clock                    : 0.000000
    migration/17   121        39.697241 E        40.446470         0.750000     10233.033387        46     0 
 task:kworker/171:1   state:I
 
   .removed.runnable_avg          : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .left_vruntime                 : 0.000001
   .tg_load_avg_contrib           : 11
   .min_vruntime                  : 6974999.717662
 -------------------------------------------------------------------------------------------------------------
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .avg_vruntime                  : 6974999.717662
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .tg_load_avg                   : 2026
   .exec_clock                    : 0.000000
  S
  stack:0     pid:3942  tgid:3942  ppid:3454   flags:0x00000002
 cfs_rq[26]:/user.slice
   .min_vruntime                  : 765.923807
   .avg_vruntime                  : 21076.391649
 Call Trace:
   .throttled                     : 0
  S
   .right_vruntime                : 0.000001
        cpuhp/51   323      2096.880431 E      2099.874038         3.000000         1.579524        35   120 
        cpuhp/28   185       300.474850 E       303.470940         3.000000         1.430283        35   120 
         0.000000     10233.033387         0.000000         0.000000
   .left_vruntime                 : 0.000001
   .avg_vruntime                  : 12296.313565
         0.000000         1.579524         0.000000         0.000000
         0.000000         1.430283         0.000000         0.000000
   .exec_clock                    : 0.000000
   .min_vruntime                  : 6965694.959634
  /
   .right_vruntime                : 1331.022673
   .spread                        : 0.000000
  S
 RSP: 002b:00007ffc5ac123d8 EFLAGS: 00000202
  /
   .spread                        : 565.098866
   .throttle_count                : 0
 
   .nr_spread_over                : 0
  idle_inject/51   324        -1.046441 E         1.951574         3.000000         0.007516         3    49 
  stack:0     pid:1601  tgid:1601  ppid:2      flags:0x00004000
  R
   .nr_spread_over                : 0
   .nr_running                    : 1
   .avg_vruntime                  : 6965694.959634
  stack:0     pid:132   tgid:132   ppid:2      flags:0x00004000
   .nr_running                    : 3
  </TASK>
   .left_vruntime                 : 0.000001
   .se->exec_start                : 208011.870707
  /
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
    ksoftirqd/17   122     84879.423171 E     84882.423171         3.000000         0.024133         5   120 
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
 
   .se->vruntime                  : 6965694.959634
         0.000000         0.024133         0.000000         0.000000
  ORIG_RAX: 0000000000000001
 ? __schedule (kernel/sched/core.c:6714) 
  S
 Call Trace:
   .nr_running                    : 1
   .min_vruntime                  : 4425426.460114
 kthread (kernel/kthread.c:388) 
   .h_nr_running                  : 3
 ? fill_page_cache_func (kernel/rcu/tree.c:3261 (discriminator 3)) 
  idle_inject/28   186         0.858638 E         1.951437         3.000000         0.193871         3    49 
  <TASK>
   .se->sum_exec_runtime          : 34400.541841
   .avg_vruntime                  : 4425426.460114
         0.000000         0.007516         0.000000         0.000000
   .idle_nr_running               : 0
  /
   .right_vruntime                : 0.000001
 ? end_repeat_nmi (arch/x86/entry/entry_64.S:1394) 
   .right_vruntime                : 0.000001
   .h_nr_running                  : 2
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .spread                        : 0.000000
 
   .idle_nr_running               : 0
 ? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1515 arch/x86/mm/fault.c:1563) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .idle_nr_running               : 0
  stack:0     pid:1778  tgid:1778  ppid:2      flags:0x00004000
 Call Trace:
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
   .spread                        : 0.000000
 kthread (kernel/kthread.c:388) 
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .idle_h_nr_running             : 0
         0.000000         0.193871         0.000000         0.000000
  /
  I
 task:kworker/97:0    state:I
   .nr_spread_over                : 0
   .nr_spread_over                : 0
   .se->load.weight               : 5693
 
 worker_thread (kernel/workqueue.c:2734) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 task:kworker/142:1   state:I
  <TASK>
 
  /
   .se->avg.load_avg              : 4
  R
 ret_from_fork (arch/x86/kernel/process.c:147) 
    kworker/17:0   123        41.440664 E        44.440664         3.000000         0.001570         4   120 
 ? __pfx_kthread (kernel/kthread.c:341) 
  <TASK>
   .nr_running                    : 1
 kthread (kernel/kthread.c:388) 
   .idle_h_nr_running             : 0
  stack:0     pid:1783  tgid:1783  ppid:2      flags:0x00004000
  (btrfs-endio-meta)
         0.000000         0.001570         0.000000         0.000000
 hrtimer_nanosleep (kernel/time/hrtimer.c:2101) 
   .nr_running                    : 1
    migration/51   325        49.479633 E        50.229058         0.750000     10262.170012        47     0 
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 
   .load                          : 3145728
   .idle_h_nr_running             : 0
   .h_nr_running                  : 3
  stack:0     pid:603   tgid:603   ppid:2      flags:0x00004000
 kthread (kernel/kthread.c:388) 
   .h_nr_running                  : 3
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 Call Trace:
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->avg.util_avg              : 1024
 RAX: ffffffffffffffda RBX: 000000000000005b RCX: 00007f1042c5fc74
  </TASK>
   .se->avg.runnable_avg          : 2048
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .load                          : 0
   .h_nr_running                  : 2
   .load_avg                      : 3072
   .idle_nr_running               : 0
   .idle_nr_running               : 0
 ret_from_fork (arch/x86/kernel/process.c:147) 
  /
 RIP: 0033:0x7fc3970ac167
 RDX: 000000000000005b RSI: 00005625ccb682c0 RDI: 0000000000000001
   .idle_h_nr_running             : 0
 
 do_nanosleep (kernel/time/hrtimer.c:1446 kernel/time/hrtimer.c:2049) 
   .load                          : 5693
 worker_thread (kernel/workqueue.c:2734) 
         0.000000     10262.170012         0.000000         0.000000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .right_vruntime                : 0.000001
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  I
 task:taskset         state:S
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .load_avg                      : 0
   kworker/17:0H   124        48.219887 E        48.254073         3.000000         0.043475         4   100 
   .spread                        : 0.000000
   .load_avg                      : 4
  /
   .load                          : 8798
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
   .runnable_avg                  : 2047
 ret_from_fork (arch/x86/kernel/process.c:147) 
  <TASK>
  R
 Workqueue:  0x0
 ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1935) 
 
 task:kworker/122:1   state:I
  stack:0     pid:1753  tgid:1753  ppid:2      flags:0x00004000
 
 smpboot_thread_fn (kernel/smpboot.c:160) 
 
   .util_avg                      : 1023
   .runnable_avg                  : 3072
  S
   .util_avg                      : 1024
 ? __pfx_kthread (kernel/kthread.c:341) 
   .idle_h_nr_running             : 0
   .runnable_avg                  : 0
   .util_est_enqueued             : 0
 ? __pfx_kthread (kernel/kthread.c:341) 
 R10: 00007ffdba3de8c0 R11: 0000000000000202 R12: 00007f4002cde6c8
    ksoftirqd/51   326      2854.180743 E      2857.165365         3.000000         0.020810         4   120 
  (mm_percpu_wq)
 ? __pfx_kthread (kernel/kthread.c:341) 
 common_nsleep (kernel/time/posix-timers.c:1353) 
 RBP: 00007ffc5ac12400 R08: 0000000000000000 R09: 0000000000000001
    migration/28   187        42.813203 E        43.562459         0.750000     10240.580888        47     0 
  <TASK>
   .load                          : 5693
   .removed.load_avg              : 0
   .load_avg                      : 8
   .load_avg                      : 5
   .nr_spread_over                : 0
 R13: 0000000000000000 R14: 0000000000000000 R15: 00007f4002ebafc0
 cfs_rq[54]:/user.slice
   .runnable_avg                  : 3072
         0.000000         0.043475         0.000000         0.000000
   .removed.util_avg              : 0
   .util_avg                      : 1024
  /
   .exec_clock                    : 0.000000
         0.000000     10240.580888         0.000000         0.000000
   .left_vruntime                 : 0.000001
 Call Trace:
         0.000000         0.020810         0.000000         0.000000
   .util_est_enqueued             : 0
   .removed.runnable_avg          : 0
   .util_est_enqueued             : 0
 
  /
   .idle_nr_running               : 0
   .removed.load_avg              : 0
  stack:0     pid:4057  tgid:4057  ppid:4016   flags:0x00000002
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .tg_load_avg_contrib           : 4
 ret_from_fork (arch/x86/kernel/process.c:147) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  /
   .removed.util_avg              : 0
   .runnable_avg                  : 2048
 
   .removed.load_avg              : 0
 
   .removed.util_avg              : 0
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 ? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:115 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2164 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1296 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4)) 
   .tg_load_avg                   : 1488
   .nr_running                    : 0
 task:cpuhp/12        state:S
  I
   .throttled                     : 0
  I
  S
   .min_vruntime                  : 6965694.959634
 RSP: 002b:00007ffcccdb45d8 EFLAGS: 00000202
   .removed.runnable_avg          : 0
 ? __pfx_kthread (kernel/kthread.c:341) 
    kworker/51:0   327        40.836423 E        43.828130         3.000000         0.010866         4   120 
 
  </TASK>
  I
  kworker/u450:8  1427        41.440664 E        41.804848         3.000000        42.486212         3   120 
   .avg_vruntime                  : 6965694.959634
    ksoftirqd/28   188        -1.045149 E         1.952472         3.000000         0.003857         3   120 
 Workqueue:  0x0
   .util_avg                      : 0
   .removed.runnable_avg          : 0
   .util_avg                      : 1024
   .idle_h_nr_running             : 0
 hrtimer_nanosleep (kernel/time/hrtimer.c:2101) 
   .right_vruntime                : 0.000001
         0.000000        42.486212         0.000000         0.000000
   .tg_load_avg_contrib           : 8
   .spread                        : 0.000000
  ORIG_RAX: 00000000000000e6
         0.000000         0.003857         0.000000         0.000000
  <TASK>
   .util_est_enqueued             : 0
 task:kworker/127:0H  state:I
 
  stack:0     pid:89    tgid:89    ppid:2      flags:0x00004000
  stack:0     pid:1734  tgid:1734  ppid:2      flags:0x00004000
         0.000000         0.010866         0.000000         0.000000
  /
   .load                          : 8798
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 kthread (kernel/kthread.c:388) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .removed.load_avg              : 0
  stack:0     pid:784   tgid:784   ppid:2      flags:0x00004000
 __x64_sys_clock_nanosleep (kernel/time/posix-timers.c:1396 kernel/time/posix-timers.c:1373 kernel/time/posix-timers.c:1373) 
   .throttle_count                : 0
   .nr_spread_over                : 0
 Call Trace:
   .removed.util_avg              : 0
 kthread (kernel/kthread.c:388) 
   kworker/162:0   993        -1.039343 E         1.958324         3.000000         0.006918         4   120 
   .tg_load_avg_contrib           : 3055
   .se->exec_start                : 208088.464512
  /
  /
   .tg_load_avg                   : 1488
   .tg_load_avg                   : 177599
 
 
   .throttled                     : 0
   .nr_running                    : 1
 
  I
   .removed.runnable_avg          : 0
   .throttle_count                : 0
 Call Trace:
   .h_nr_running                  : 2
 Call Trace:
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
  </TASK>
 Workqueue:  0x0
  <TASK>
   kworker/51:0H   328       114.234904 E       114.269398         3.000000         0.021361         4   100 
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .throttled                     : 0
   .se->exec_start                : 208044.417476
 ret_from_fork (arch/x86/kernel/process.c:147) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  I
   .idle_nr_running               : 0
         0.000000         0.021361         0.000000         0.000000
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 kthread (kernel/kthread.c:388) 
   .util_est_enqueued             : 0
 R10: 0000000000000004 R11: 0000000000000202 R12: 000000000000005b
   .tg_load_avg_contrib           : 5
  R
   .se->vruntime                  : 11611430.629741
   .se->vruntime                  : 7038437.899121
  /
   .throttle_count                : 0
    kworker/17:1  1631     55735.034269 E     55738.034269         3.000000         0.253657        19   120 
    kworker/28:0   189        37.897547 E        40.897547         3.000000         0.001321         4   120 
   .idle_h_nr_running             : 0
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .se->sum_exec_runtime          : 34453.190727
   .se->sum_exec_runtime          : 34796.656898
  <TASK>
   .tg_load_avg                   : 1488
   .se->exec_start                : 208040.777009
   .throttled                     : 0
   .load                          : 5693
         0.000000         0.253657         0.000000         0.000000
   .se->load.weight               : 5637
 ? try_to_wake_up (./arch/x86/include/asm/preempt.h:104 ./include/linux/preempt.h:484 ./include/linux/preempt.h:484 kernel/sched/core.c:4217) 
  /
 task:sleep           state:R
   .se->vruntime                  : 2079949.534792
   .load_avg                      : 5
  <TASK>
   .se->avg.load_avg              : 4
  I
   .se->sum_exec_runtime          : 34795.774033
 RAX: ffffffffffffffda RBX: 00007ffcccdb4630 RCX: 00007fc3970ac167
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
   .se->avg.util_avg              : 1024
   .load_avg                      : 8
 ? __pfx_kthread (kernel/kthread.c:341) 
         0.000000         0.001321         0.000000         0.000000
   .se->load.weight               : 3521
 
 kworker/u452:17  1469        37.199095 E        37.631311         3.000000        38.245536         3   120 
  <TASK>
   .se->avg.runnable_avg          : 3072
 Workqueue:  0x0
         0.000000        38.245536         0.000000         0.000000
   .throttle_count                : 0
   .se->avg.load_avg              : 2
   .se->load.weight               : 18135
   .se->exec_start                : 208014.674547
   .h_nr_running                  : 0
 kthread (kernel/kthread.c:388) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
  (events_highpri)
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
  </TASK>
   .runnable_avg                  : 2048
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 Workqueue:  0x0
 task:kworker/28:1    state:R
   .se->avg.util_avg              : 1023
  I
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 smpboot_thread_fn (kernel/smpboot.c:160) 
 
  /
   .se->avg.load_avg              : 16
   kworker/17:1H  2489        48.220159 E        48.254739         3.000000         0.020348         2   100 
 cfs_rq[26]:/
         0.000000         0.020348         0.000000         0.000000
   .se->avg.runnable_avg          : 2047
   .util_avg                      : 1024
 
   .se->vruntime                  : 11640656.065238
   .se->avg.util_avg              : 1024
   .exec_clock                    : 0.000000
  I
   .util_est_enqueued             : 0
 worker_thread (kernel/workqueue.c:2734) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .removed.load_avg              : 0
   kworker/28:0H   190        93.435844 E        93.470287         3.000000         0.021741         4   100 
  /
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .removed.load_avg              : 0
 RDX: 00007ffcccdb4630 RSI: 0000000000000000 RDI: 0000000000000000
   .left_vruntime                 : 240480.766952
 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
 ? __schedule (kernel/sched/core.c:6714) 
 smpboot_thread_fn (kernel/smpboot.c:160) 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 
   .se->sum_exec_runtime          : 34403.345681
  <TASK>
   .idle_nr_running               : 0
 smpboot_thread_fn (kernel/smpboot.c:160) 
  (mm_percpu_wq)
   .removed.util_avg              : 0
 kthread (kernel/kthread.c:388) 
  /
 >R
   .se->avg.runnable_avg          : 3072
   .min_vruntime                  : 240496.180960
 ? __pfx_kthread (kernel/kthread.c:341) 
 
 R13: 00005625ccb682c0 R14: 00007f1042d305c0 R15: 00007f1042d2df20
         0.000000         0.006918         0.000000         0.000000
 kthread (kernel/kthread.c:388) 
 
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
 kthread (kernel/kthread.c:388) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .removed.runnable_avg          : 0
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
 worker_thread (kernel/workqueue.c:2734) 
 
  I
 Call Trace:
 cfs_rq[53]:/
 
 console_blast.s  3490     34793.174413 N     34794.741364         3.000000     34789.492844         5   120 
         0.000000         0.021741         0.000000         0.000000
 kworker/u451:25  1582        40.828130 E        43.607466         3.000000        11.615802         5   120 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .exec_clock                    : 0.000000
 cfs_rq[21]:/user.slice/user-0.slice
 Call Trace:
   .se->load.weight               : 3523
   .avg_vruntime                  : 273514.135274
  /
  </TASK>
  </TASK>
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .left_vruntime                 : 265668.598558
   .tg_load_avg_contrib           : 5
 ? __pfx_kthread (kernel/kthread.c:341) 
 
 ret_from_fork (arch/x86/kernel/process.c:147) 
   .min_vruntime                  : 265685.378461
   .right_vruntime                : 240480.766952
   .removed.util_avg              : 0
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .se->avg.load_avg              : 2
   .avg_vruntime                  : 286641.467372
   .tg_load_avg                   : 1488
   .exec_clock                    : 0.000000
   .right_vruntime                : 274436.242937
   .throttled                     : 0
         0.000000     34789.492844         0.000000         0.000000
   .spread                        : 8767.644379
         0.000000        11.615802         0.000000         0.000000
   .runnable_avg                  : 3072
   .spread                        : 0.000000
  /
   .se->avg.util_avg              : 1024
 RBP: 00007ffcccdb45e0 R08: 0000000000000000 R09: 0000000000000000
   .se->avg.runnable_avg          : 2048
 ? __pfx_smpboot_thread_fn (kernel/smpboot.c:107) 
 worker_thread (kernel/workqueue.c:2734) 
  </TASK>
  /user.slice/user-0.slice/session-1.scope
  I
   .nr_spread_over                : 0
   .nr_spread_over                : 0
   .throttle_count                : 0
 
 
 kthread (kernel/kthread.c:388) 
   .nr_running                    : 2
 cfs_rq[54]:/
  kworker/u451:7  1407       235.252529 E       238.174464         3.000000        49.705933        35   120 
   .h_nr_running                  : 4
  S
   .left_vruntime                 : 0.000001
   .idle_nr_running               : 0
   .se->exec_start                : 208014.674547
 task:kworker/39:0    state:I
 ? __pfx_kthread (kernel/kthread.c:341) 
   .removed.runnable_avg          : 0
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
   .util_avg                      : 1024
   .se->vruntime                  : 11640987.856939
 Call Trace:
 
         0.000000        49.705933         0.000000         0.000000
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ? __count_memcg_events (mm/memcontrol.c:631 (discriminator 4) mm/memcontrol.c:936 (discriminator 4)) 
   .idle_h_nr_running             : 0
   .nr_running                    : 3
  (mm_percpu_wq)
   .min_vruntime                  : 2079949.534792
   .load                          : 1054213
  R
   .idle_h_nr_running             : 0
   .exec_clock                    : 0.000000
   .se->sum_exec_runtime          : 34404.317727
 console_blast.s  3708         4.545572 E         7.100117         3.000000         3.332835         4   120 
  /
 kthread (kernel/kthread.c:388) 
   .avg_vruntime                  : 2080018.807367
   .load_avg                      : 1029
   .h_nr_running                  : 4
 ? __pfx_kthread (kernel/kthread.c:341) 
   .runnable_avg                  : 4097
    kworker/51:1  1666  10547918.653827 E  10547921.653827         3.000000         0.503578        15   120 
   .se->load.weight               : 3523
   .left_vruntime                 : 0.000001
   .util_avg                      : 1024
         0.000000         3.332835         0.000000         0.000000
  R
   .min_vruntime                  : 11640987.856939
  /user.slice/user-0.slice/session-1.scope
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .idle_nr_running               : 0
    kworker/28:1  1642     59318.094212 E     59321.094212         3.000000         2.414195       253   120 
   .avg_vruntime                  : 11640987.856939
   .tg_load_avg_contrib           : 0
   .right_vruntime                : 0.000001
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
         0.000000         0.503578         0.000000         0.000000
   .util_est_enqueued             : 1328
   .idle_h_nr_running             : 0
   .se->avg.load_avg              : 2
         0.000000         2.414195         0.000000         0.000000
  /
   .spread                        : 0.000000
   .right_vruntime                : 0.000001
  </TASK>
   .nr_spread_over                : 0
  /
   .se->avg.util_avg              : 1024
 ? __pfx_hrtimer_wakeup (kernel/time/hrtimer.c:1935) 
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
   .load                          : 2100673
 ? __pfx_kthread (kernel/kthread.c:341) 
 task:taskset         state:S
 
   .removed.load_avg              : 0
   .nr_running                    : 1
 ? __pfx_kthread (kernel/kthread.c:341) 
 
   .h_nr_running                  : 3
  S
   .load_avg                      : 2050
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
   .spread                        : 0.000000
   .se->avg.runnable_avg          : 2048
   .idle_nr_running               : 0
   .removed.util_avg              : 0
   .util_est_enqueued             : 0
  <TASK>
 do_wait (kernel/exit.c:1625 (discriminator 4)) 
 console_blast.s  3901         5.990935 E         8.526463         3.000000         3.076880         4   120 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .nr_spread_over                : 0
 
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ? __pfx_kthread (kernel/kthread.c:341) 
 
   .runnable_avg                  : 4095
   .idle_h_nr_running             : 0
  stack:0     pid:4100  tgid:4100  ppid:4061   flags:0x00000002
 schedule_preempt_disabled (kernel/sched/core.c:6856) 
  /
 cfs_rq[54]:/
   .nr_running                    : 1
   .util_avg                      : 1023
   .exec_clock                    : 0.000000
   .load                          : 18237
 
         0.000000         3.076880         0.000000         0.000000
   .util_est_enqueued             : 930
   .load_avg                      : 17
   .left_vruntime                 : 0.000001
  I
  /user.slice/user-0.slice/session-1.scope
   .h_nr_running                  : 2
  S
   .min_vruntime                  : 11640987.856939
   .idle_nr_running               : 0
         kswapd2  1845        38.002790 E        40.963900         3.000000         0.055285         4   120 
 Workqueue:  0x0
   running task    
   .runnable_avg                  : 3072
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 ? preempt_count_add (./include/linux/ftrace.h:977 kernel/sched/core.c:5839 kernel/sched/core.c:5836 kernel/sched/core.c:5864) 
   .removed.runnable_avg          : 0
 sysrq: Show State
 
   .util_avg                      : 1024
   .avg_vruntime                  : 11640987.856939
  </TASK>
   .right_vruntime                : 0.000001
 task:cpuhp/11        state:S
   kworker/51:1H  2822      1892.062876 E      1892.097374         3.000000         0.080855         6   100 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .spread                        : 0.000000
 smpboot_thread_fn (kernel/smpboot.c:160) 
 ? handle_mm_fault (mm/memory.c:5222 mm/memory.c:5361) 
   .removed.load_avg              : 0
  R
   .removed.load_avg              : 0
   .nr_spread_over                : 0
   .tg_load_avg_contrib           : 0
 ? fill_page_cache_func (kernel/rcu/tree.c:3261 (discriminator 3)) 
   .util_est_enqueued             : 0
 kernel_wait4 (kernel/exit.c:1786) 
   .nr_running                    : 1
   running task    
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
           sleep  4210       767.543871 E       770.543871         3.000000         1.021893         1   120 
  <TASK>
   .idle_h_nr_running             : 0
   .removed.load_avg              : 0
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
         0.000000         0.080855         0.000000         0.000000
 ? __pfx_child_wait_callback (kernel/exit.c:1510) 
  stack:0     pid:255   tgid:255   ppid:2      flags:0x00004000
         0.000000         0.055285         0.000000         0.000000
   .load                          : 0
         0.000000         1.021893         0.000000         0.000000
   .removed.util_avg              : 0
   .tg_load_avg                   : 0
   .h_nr_running                  : 2
  /
   .tg_load_avg                   : 0
  /
 ? __pfx_kthread (kernel/kthread.c:341) 
 kthread (kernel/kthread.c:388) 
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
  (mm_percpu_wq)
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .throttled                     : 0
 
 task:kworker/97:0H   state:I
   .idle_nr_running               : 0
 ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5839 (discriminator 1) kernel/sched/core.c:5836 (discriminator 1) kernel/sched/core.c:5864 (discriminator 1)) 
   .load                          : 3523
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 worker_thread (kernel/workqueue.c:2734) 
   .throttle_count                : 0
  <TASK>
  S
  </TASK>
   .removed.runnable_avg          : 0
   .idle_h_nr_running             : 0
 R10: 00007ffcccdb4620 R11: 0000000000000202 R12: 00007fc396fd06c8
 
   .tg_load_avg_contrib           : 17
 
   .load_avg                      : 3
 
 common_nsleep (kernel/time/posix-timers.c:1353) 
   .load                          : 3523
 rt_rq[26]:
   .removed.util_avg              : 0
 ? __pfx_kthread (kernel/kthread.c:341) 
   irq/49-aerdrv  1875        39.642784 E        42.642719         3.000000         0.015890         3    49 
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
   .tg_load_avg                   : 2026
  /user.slice/user-0.slice/session-1.scope
  R
   .removed.runnable_avg          : 0
   .rt_nr_running                 : 0
   .runnable_avg                  : 2048
 console_blast.s  3615     29882.540004 N     29885.540004         3.000000     29883.915066         5   120 
   .throttled                     : 0
   .load_avg                      : 3
 ? __pfx_kthread (kernel/kthread.c:341) 
 
 ? __pfx_kthread (kernel/kthread.c:341) 
   .util_avg                      : 1024
 Workqueue:  0x0
   .tg_load_avg_contrib           : 0
         0.000000         0.015890         0.000000         0.000000
 ? __pfx_kthread (kernel/kthread.c:341) 
 ? __pfx_kthread (kernel/kthread.c:341) 
  stack:0     pid:604   tgid:604   ppid:2      flags:0x00004000
   .runnable_avg                  : 2048
   .tg_load_avg                   : 0
   .throttle_count                : 0
         0.000000     29883.915066         0.000000         0.000000
   .load_avg                      : 0
   .se->exec_start                : 208042.810223
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
 __x64_sys_clock_nanosleep (kernel/time/posix-timers.c:1396 kernel/time/posix-timers.c:1373 kernel/time/posix-timers.c:1373) 
   .util_est_enqueued             : 387
   .throttled                     : 0
   .util_avg                      : 1024
 ? up_read (./arch/x86/include/asm/preempt.h:104 kernel/locking/rwsem.c:1354 kernel/locking/rwsem.c:1622) 
  /
 task:systemd         state:S
  /user.slice/user-0.slice/session-1.scope
 schedule (kernel/sched/core.c:6784 kernel/sched/core.c:6798) 
  (mm_percpu_wq)
   .rt_throttled                  : 0
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
 ? syscall_exit_to_user_mode (kernel/entry/common.c:299) 
   .se->vruntime                  : 4424947.833142
  stack:0     pid:83    tgid:83    ppid:2      flags:0x00004000
   .rt_time                       : 0.000000
 ? __pfx_worker_thread (kernel/workqueue.c:2727) 
  (mm_percpu_wq)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
  R
 __schedule (kernel/sched/core.c:5396 kernel/sched/core.c:6708) 
 
 ret_from_fork (arch/x86/kernel/process.c:147) 
 
 schedule_timeout (kernel/time/timer.c:1635 ./include/linux/timer.h:199 kernel/time/timer.c:2175) 
 >R
 
   .removed.load_avg              : 0
  </TASK>
   .se->sum_exec_runtime          : 34797.807247
 R13: 00007ffcccdb4620 R14: 0000000000000002 R15: 00007ffcccdb4620
   .throttle_count                : 0
 console_blast.s  3810     19840.925913 E     19843.377808         3.000000      4523.842729         4   120 
   .rt_runtime                    : 950.000000
 
 
   .removed.util_avg              : 0
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
 ? __pfx_kthread (kernel/kthread.c:341) 
  I
 ? __pfx_kthread (kernel/kthread.c:341) 
 rt_rq[53]:
 ? do_user_addr_fault (arch/x86/mm/fault.c:1445 (discriminator 1)) 
 dl_rq[26]:
  stack:0     pid:1642  tgid:1642  ppid:2      flags:0x00004000
   .se->load.weight               : 8798
   .rt_nr_running                 : 0
         0.000000      4523.842729         0.000000         0.000000
 task:cpuhp/107       state:S
   .dl_nr_running                 : 0
   .removed.runnable_avg          : 0
           sleep  4272      1146.188899 E      1149.188899         3.000000         1.275331         1   120 
   .se->avg.load_avg              : 7
   .rt_throttled                  : 0
 ? do_syscall_64 (arch/x86/entry/common.c:102) 
  </NMI>

---------------------------------

 <NMI>
 dump_stack_lvl (lib/dump_stack.c:107) 
 panic (kernel/panic.c:344) 
 nmi_panic (kernel/panic.c:203) 
 watchdog_hardlockup_check (kernel/watchdog.c:180) 
 __perf_event_overflow (kernel/events/core.c:9612 (discriminator 2)) 
 handle_pmi_common (arch/x86/events/intel/core.c:3052 (discriminator 1)) 
 ? set_pte_vaddr_p4d (arch/x86/mm/init_64.c:307 arch/x86/mm/init_64.c:315) 
 ? flush_tlb_one_kernel (./arch/x86/include/asm/paravirt.h:81 arch/x86/mm/tlb.c:1171 arch/x86/mm/tlb.c:1126) 
 ? native_set_fixmap (arch/x86/mm/pgtable.c:679 arch/x86/mm/pgtable.c:688) 
 ? ghes_copy_tofrom_phys (drivers/acpi/apei/ghes.c:330) 
 intel_pmu_handle_irq (./arch/x86/include/asm/msr.h:84 ./arch/x86/include/asm/msr.h:118 arch/x86/events/intel/core.c:2427 arch/x86/events/intel/core.c:3118) 
 perf_event_nmi_handler (arch/x86/events/core.c:1743 arch/x86/events/core.c:1729) 
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
 nmi_handle (arch/x86/kernel/nmi.c:150) 
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
 default_do_nmi (arch/x86/kernel/nmi.c:351) 
 exc_nmi (arch/x86/kernel/nmi.c:545) 
 end_repeat_nmi (arch/x86/entry/entry_64.S:1394) 
 RIP: 0010:native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
 Code: 00 00 77 77 f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 09 d0 3d ff 00 00 00 77 53 85 c0 74 10 0f b6 03 84 c0 74 09 <f3> 90 0f b6 03 84 c0 75 f7 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	77 77                	ja     0x7b
   4:	f0 0f ba 2b 08       	lock btsl $0x8,(%rbx)
   9:	0f 92 c2             	setb   %dl
   c:	8b 03                	mov    (%rbx),%eax
   e:	0f b6 d2             	movzbl %dl,%edx
  11:	c1 e2 08             	shl    $0x8,%edx
  14:	30 e4                	xor    %ah,%ah
  16:	09 d0                	or     %edx,%eax
  18:	3d ff 00 00 00       	cmp    $0xff,%eax
  1d:	77 53                	ja     0x72
  1f:	85 c0                	test   %eax,%eax
  21:	74 10                	je     0x33
  23:	0f b6 03             	movzbl (%rbx),%eax
  26:	84 c0                	test   %al,%al
  28:	74 09                	je     0x33
  2a:*	f3 90                	pause		<-- trapping instruction
  2c:	0f b6 03             	movzbl (%rbx),%eax
  2f:	84 c0                	test   %al,%al
  31:	75 f7                	jne    0x2a
  33:	b8 01 00 00 00       	mov    $0x1,%eax
  38:	66 89 03             	mov    %ax,(%rbx)
  3b:	5b                   	pop    %rbx
  3c:	5d                   	pop    %rbp
  3d:	41 5c                	pop    %r12
  3f:	41                   	rex.B

Code starting with the faulting instruction
===========================================
   0:	f3 90                	pause
   2:	0f b6 03             	movzbl (%rbx),%eax
   5:	84 c0                	test   %al,%al
   7:	75 f7                	jne    0x0
   9:	b8 01 00 00 00       	mov    $0x1,%eax
   e:	66 89 03             	mov    %ax,(%rbx)
  11:	5b                   	pop    %rbx
  12:	5d                   	pop    %rbp
  13:	41 5c                	pop    %r12
  15:	41                   	rex.B
 RSP: 0018:ff26217019714e98 EFLAGS: 00000002
 RAX: 0000000000000001 RBX: ffffffff8e8d49c0 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8e8d49c0
 RBP: 0000000000000046 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: ff26217019714ff8 R12: 0000000000000000
 R13: ff15126c46b88000 R14: 00000000000000c2 R15: ff15130c44681254
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
 ? native_queued_spin_lock_slowpath (./arch/x86/include/asm/vdso/processor.h:13 ./arch/x86/include/asm/vdso/processor.h:18 kernel/locking/qspinlock.c:383) 
  </NMI>


-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel


