Return-Path: <linux-kernel+bounces-52834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA7A849D33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707901C22535
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B72C1A8;
	Mon,  5 Feb 2024 14:39:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E724B4A;
	Mon,  5 Feb 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143986; cv=none; b=nsSFxv/4EI63JPrhb3vj4p3g7DbPEh0L1xfrEJbtEiqojgUQ2gxkvG1iWDCu3p/kp8MliQIE80TVUEmc1EC5xMjGAlRq5WSw/mnqWVKRiBYqbsr2VnWEFmpComRs1v/zRXdloeCe+xxpDqCMRklQj0C0t9mIdRCtLDM8/nRZV1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143986; c=relaxed/simple;
	bh=HNpZgFINo5CuPlmAVI1ccSarJBMiy/d4BsWA5ccPASk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=St7NLBjF9Moy/sLG6UPpybJ3y90E6K8VGK7F43nAwKqJJlR9wXG9V9fpLmmwvHQ+/qcJ6JEFbGlUbDY9Vr8INKiPpwp4YH+34XKH2FklO7HafZM414s9+KqEEf+FMzXan41Tn82tG3pSBxs8Ic5AM8aO7fRLCJbRg0iNd+y2RA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA37F1FB;
	Mon,  5 Feb 2024 06:40:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD60D3F5A1;
	Mon,  5 Feb 2024 06:39:41 -0800 (PST)
Date: Mon, 5 Feb 2024 14:39:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: richard clark <richard.xnu.clark@gmail.com>, nico@fluxnic.net,
	mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: Question about the ipi_raise filter usage and output
Message-ID: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205080609.563df00f@rorschach.local.home>

[adding Valentin]

On Mon, Feb 05, 2024 at 08:06:09AM -0500, Steven Rostedt wrote:
> On Mon, 5 Feb 2024 10:28:57 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > > I try to write below:
> > > echo 'target_cpus == 11 && reason == "Function call interrupts"' >
> > > events/ipi/ipi_raise/filter  
> > 
> > The '=' checks if the target_cpus bitmap *only* contains CPU 11. If the cpumask
> > contains other CPUs, the filter will skip the call.
> > 
> > I believe you can use '&' to check whether a cpumask contains a CPU, e.g.
> > 
> > 	'target_cpus & 11'
> 
> 11 == 0xb = b1011
> 
> So the above would only be true for CPUs 0,1 and 3 ;-)

Sorry, I misunderstood the scalar logic and thought that we treated:

	'$mask $OP $scalar', e.g. 'target_cpus & 11'

.. as a special case meaning a cpumask with that scalar bit set, i.e.

	'$mask $OP CPUS{$scalar}', e.g. 'target_cpus & CPUS{11}'

.. but evidently I was wrong.

> I think you meant: 'target_cpus & 0x800' 
> 
> I tried "1 << 11' but it appears to not allow shifts. I wonder if we should add that?

Hmm... shouldn't we make 'CPUS{11}' work for that?

From a quick test (below), that doesn't seem to work, though I think it
probably should?

  # cat /sys/devices/system/cpu/online 
  0-3
  # echo 1 > /sys/kernel/tracing/events/ipi/ipi_raise/enable 
  # echo 'target_cpus & CPUS{3}' > /sys/kernel/tracing/events/ipi/ipi_raise/filter 
  # grep IPI /proc/interrupts 
  IPI0:        54         41         32         42       Rescheduling interrupts
  IPI1:      1202       1035        893        909       Function call interrupts
  IPI2:         0          0          0          0       CPU stop interrupts
  IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
  IPI4:         0          0          0          0       Timer broadcast interrupts
  IPI5:         0          0          0          0       IRQ work interrupts
  # sleep 1
  # grep IPI /proc/interrupts 
  IPI0:        54         42         32         42       Rescheduling interrupts
  IPI1:      1209       1037        912        927       Function call interrupts
  IPI2:         0          0          0          0       CPU stop interrupts
  IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
  IPI4:         0          0          0          0       Timer broadcast interrupts
  IPI5:         0          0          0          0       IRQ work interrupts
  # cat /sys/devices/system/cpu/online 
  0-3
  # cat /sys/kernel/tracing/trace
  # tracer: nop
  #
  # entries-in-buffer/entries-written: 0/0   #P:4
  #
  #                                _-----=> irqs-off/BH-disabled
  #                               / _----=> need-resched
  #                              | / _---=> hardirq/softirq
  #                              || / _--=> preempt-depth
  #                              ||| / _-=> migrate-disable
  #                              |||| /     delay
  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
  #              | |         |   |||||     |         |
  # 

More confusingly, if I use '8', I get events with cpumasks which shouldn't
match AFAICT:

  echo 'target_cpus & 8' > /sys/kernel/tracing/events/ipi/ipi_raise/filter 
  # echo '' > /sys/kernel/tracing/trace
  # grep IPI /proc/interrupts 
  IPI0:        55         46         34         43       Rescheduling interrupts
  IPI1:      1358       1155        994       1021       Function call interrupts
  IPI2:         0          0          0          0       CPU stop interrupts
  IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
  IPI4:         0          0          0          0       Timer broadcast interrupts
  IPI5:         0          0          0          0       IRQ work interrupts
  # sleep 1
  # grep IPI /proc/interrupts 
  IPI0:        56         46         34         43       Rescheduling interrupts
  IPI1:      1366       1158       1005       1038       Function call interrupts
  IPI2:         0          0          0          0       CPU stop interrupts
  IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
  IPI4:         0          0          0          0       Timer broadcast interrupts
  IPI5:         0          0          0          0       IRQ work interrupts
  # cat /sys/kernel/tracing/trace
  # tracer: nop
  #
  # entries-in-buffer/entries-written: 91/91   #P:4
  #
  #                                _-----=> irqs-off/BH-disabled
  #                               / _----=> need-resched
  #                              | / _---=> hardirq/softirq
  #                              || / _--=> preempt-depth
  #                              ||| / _-=> migrate-disable
  #                              |||| /     delay
  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
  #              | |         |   |||||     |         |
            <idle>-0       [000] d.h4.   480.720312: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   480.720763: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
                sh-144     [003] d.h1.   480.721584: ipi_raise: target_mask=00000000,00000001 (Function call interrupts)
            <idle>-0       [000] d.h4.   481.552179: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   481.552742: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] dNs4.   481.553728: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
                sh-144     [003] d.h1.   481.553742: ipi_raise: target_mask=00000000,00000002 (Function call interrupts)
            <idle>-0       [000] d.h4.   481.730502: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   481.730917: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] d.h4.   481.800820: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   481.801249: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
      kworker/u8:1-37      [002] d.h2.   481.801483: ipi_raise: target_mask=00000000,00000001 (Function call interrupts)
            <idle>-0       [000] d.h4.   481.916178: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   481.916610: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
                sh-144     [003] d.h1.   481.917581: ipi_raise: target_mask=00000000,00000001 (Function call interrupts)
            <idle>-0       [000] d.h4.   482.280864: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   482.281310: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
      kworker/u8:1-37      [002] d.h2.   482.281514: ipi_raise: target_mask=00000000,00000001 (Function call interrupts)
                sh-144     [003] d.h1.   482.285681: ipi_raise: target_mask=00000000,00000001 (Function call interrupts)
                sh-144     [003] d..2.   482.287634: ipi_raise: target_mask=00000000,00000001 (Rescheduling interrupts)
                sh-144     [003] d.h1.   482.289705: ipi_raise: target_mask=00000000,00000002 (Function call interrupts)
              grep-183     [000] d.h1.   482.293649: ipi_raise: target_mask=00000000,00000002 (Function call interrupts)
              grep-183     [000] d.s3.   482.301758: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
              grep-183     [000] d.h1.   482.325713: ipi_raise: target_mask=00000000,00000002 (Function call interrupts)
              grep-183     [000] d..4.   482.349025: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] d.h4.   482.701197: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   482.701856: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] d.h4.   482.921567: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   482.921998: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] d.h4.   483.044683: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   483.045123: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] d.h4.   483.154449: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   483.154896: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] d.h4.   483.296925: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)
      kworker/u8:1-37      [002] d.h2.   483.297455: ipi_raise: target_mask=00000000,00000001 (Function call interrupts)
      kworker/u8:1-37      [002] d..3.   483.297719: ipi_raise: target_mask=00000000,00000008 (Function call interrupts)
            <idle>-0       [000] d.h4.   483.602777: ipi_raise: target_mask=00000000,00000004 (Function call interrupts)

Have I completely misunderstood how this is supposed to work, or is that a bug?

Mark.

