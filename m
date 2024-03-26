Return-Path: <linux-kernel+bounces-118403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543E88BA56
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0575B23AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5145812DDA4;
	Tue, 26 Mar 2024 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bhJxtPaf"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AF12B17A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434041; cv=none; b=L4AZ8nbk33MI4kmP7EcsCfG44Mf5aQRshHWlazJ0fTTlcu8JkNOTSqW8yaCVSXvzK6uPSrP0ioQ4VAXC7UzzBJc/MiCwjPWKXfLY5d+ogNBmBw83voKm9izYLxzjxdm/6snIpQL1d6OsRr3kArbW9IYnaL57u4Av8E8107YWu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434041; c=relaxed/simple;
	bh=ZA5ROUhSMNttRAy3HLO/xlrNqJqfQIxiF9yjTXYVEPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/V9ql/MUvB73YupCTWkpG7JWc2MrNYyhxNzCrWAkWV/sZBTzU1rUQtkcMdjD329ziDAwsWummt4opPBG+fFvd7WjMjXIsraai7x90vFfMiNjQYZxdnzYcBOI8yWnBGa9QMzSAR0f98ao4FK75GtZ8hr7JD6kOiuYAwsXitaHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bhJxtPaf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q4t0ht001860;
	Tue, 26 Mar 2024 06:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Ds72AP2X2VYffRsuZCWiXaUCA9J6zHk47cZhCV6ClUs=;
 b=bhJxtPafZkg7Ke1GebSQycdwFYJ40TAwYdhqZAOdTbMi8B4qf18cQ4tvjMw8JtUqfehw
 M81gubcfvIQ9pJuC2VccrqKEC6VLcLA4rl140R5+kqHRSS8SyeYH63m6GbubqpYREWr1
 3KTA+sjLPE2FS+gLBYi6PM2QYz/tS0sUPStzItPI9BCqimQGmi7sYCqm4YhMZkdb60mo
 nE7ZbHCN1XOh4RLkOFdluH0x3g0OJi86VUKX+MkAbFyHLmtAJWW2QYcwNPKAMqaFwBWS
 1WrPPFqPhslLPY0LHeizLOgJ325T69QTrCMyEXsfPcGmAytNGBK5YK/wEbP57CNjWgfX IA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3k3j8pa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 06:20:23 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42Q6KNLM015730;
	Tue, 26 Mar 2024 06:20:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3k3j8p9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 06:20:23 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q5VTRF016605;
	Tue, 26 Mar 2024 06:20:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dtxas0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 06:20:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42Q6KIaC45351276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 06:20:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5855A20063;
	Tue, 26 Mar 2024 06:20:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1483E20043;
	Tue, 26 Mar 2024 06:20:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.204.201.194])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 Mar 2024 06:20:14 +0000 (GMT)
Date: Tue, 26 Mar 2024 11:50:12 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, Zimuzo Ezeozue <zezeozue@google.com>
Subject: Re: [RESEND][PATCH v2] sched: Add trace_sched_waking() tracepoint to
 sched_ttwu_pending()
Message-ID: <ZgJpHAmxS4Lh8QEE@linux.ibm.com>
References: <20240318192846.75299-1-jstultz@google.com>
 <Zfpy4Z4MhErKrHBZ@linux.ibm.com>
 <CANDhNCro84C8uxTo5MJ1xX0wGnTXE7_REm4nqp7jGQ+mN0wfkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCro84C8uxTo5MJ1xX0wGnTXE7_REm4nqp7jGQ+mN0wfkQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AnozjOeip3v_kGU9oVl5_P31z6lblwjk
X-Proofpoint-GUID: d6iK-oQrrGwVMbJYrGTadFxz5gUoTmoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260040

On Wed, Mar 20, 2024 at 03:42:31PM -0700, John Stultz wrote:
> On Tue, Mar 19, 2024 at 10:24 PM Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> > On Mon, Mar 18, 2024 at 12:28:33PM -0700, John Stultz wrote:
> > > Zimuzo reported seeing occasional cases in perfetto traces where
> > > tasks went from sleeping directly to trace_sched_wakeup()
> > > without always seeing a trace_sched_waking().
> > >
> > > Looking at the code, trace_sched_wakeup() is only called in
> > > ttwu_do_wakeup()
> > >
> > > The call paths that get you to ttwu_do_wakeup() are:
> > > try_to_wake_up() -> ttwu_do_wakeup()
> > > try_to_wake_up() -> ttwu_runnable() -> ttwu_do_wakeup()
> > > try_to_wake_up() -> ttwu_queue() -> ttwu_do_activate() -> ttwu_do_wakeup()
> > > sched_ttwu_pending() -> ttwu_do_activate() -> ttwu_do_wakeup()
> > Notably, sched_ttwu_pending() is invoked for remote wakeups.
> >
> > Given this, I anticipate a scenario similar to the following
> > occurred: When a process (P) is to be awakened on a remote CPU,
> > the scheduler adds P to the remote CPU's wakelist,a per-CPU queue,
> > and sends an IPI to the remote CPU. This action triggers
> > sched_ttwu_pending() on the remote CPU, which then processes the
> > wakelist and wakes up the queued processes.
> 
> Hey! Thanks for taking a look here and sharing this feedback.
> 
> Indeed, looking closer here I do have a hard time seeing how we can
> get to sched_ttwu_pending() without having gone through the paths in
> try_to_wake_up() that would call trace_sched_wakeup():
>   try_to_wake_up()->[ttwu_queue ->]
> ttwu_queue_wakelist()->sched_ttwu_pending()->...
> 
> > In this scenario, the "waking trace" of P, signifying the initiation
> > of the wake-up, is recorded on the CPU where try_to_wake_up was executed.
> > Meanwhile, the "wakeup trace," denoting the completion of the wake-up,
> > is observed on the remote CPU where sched_ttwu_pending() is executed.
> >
> > Is there a possibility that something other than the above occurred
> > in your case?
> 
> I suspect that the case reported may be that the task went to sleep
> right after the trace_sched_waking(). Which could result in the
> transition from sleeping to trace_sched_wakeup() without the
> trace_sched_waking() inbetween.  The added latency from the remote
> wakeup probably increases the chance for this race to occur.

Hi,

# trace-cmd record -e sched:* perf record -a -g -e sched:* ./schbench
This generates perf.data and trace.dat file.

Running a simple check for equality between sched_waking and
sched_wakeup. I see two different results.

# perf script -G | grep -i "sched_waking" | wc -l
35264
# perf script -G | grep -i "sched_wakeup:" | wc -l
35314

perf report suggests missing sched_waking events. Although trace
collected through ftrace (using trace-cmd) suggests equal waking and
wakeup events.

# trace-cmd report | grep -i "sched_waking" | wc -l
35959
# trace-cmd report | grep -i "sched_wakeup:" | wc -l
35959

Below is a stack trace for a sched_wakeup event for which sched_waking
was not recorded in perf.data file,

schbench  307346 [023] 600177.250150:    
         sched:sched_wakeup: perf:307321 [120] CPU:023
         ttwu_do_activate+0x1c0 ([kernel.kallsyms])
         print_fmt_xfs_perag_intents_class+0x0 ([xfs].data)
         sched_ttwu_pending+0x118 ([kernel.kallsyms])
=>       __flush_smp_call_function_queue+0x19c ([kernel.kallsyms])
         smp_ipi_demux_relaxed+0xec ([kernel.kallsyms])
         xive_muxed_ipi_action+0x20 ([kernel.kallsyms])
         __handle_irq_event_percpu+0x8c ([kernel.kallsyms])
         handle_irq_event_percpu+0x2c ([kernel.kallsyms])
         handle_percpu_irq+0x80 ([kernel.kallsyms])
         generic_handle_irq+0x50 ([kernel.kallsyms])
         __do_irq+0xb8 ([kernel.kallsyms])
         __do_IRQ+0x88 ([kernel.kallsyms])
         print_fmt_xfs_perag_intents_class+0x0 ([xfs].data)
         do_IRQ+0x50 ([kernel.kallsyms])
         hardware_interrupt_common_virt+0x28c ([kernel.kallsyms])
         worker_thread+0x268 (/usr/bin/schbench)
         worker_thread+0x4cc (/usr/bin/schbench)
         start_thread+0x170 (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
         __clone+0xa0 (/usr/lib64/glibc-hwcaps/power10/libc.so.6)

Also, it has been observed for cases where sched_waking is missing only
happens when perf task is woken up.

Looking at the code in __flush_smp_call_function_queue,
it invokes all the callbacks currently queue on the given cpu, and if
sched_ttwu_pending is being called, suggesting that csd of type CSD_TYPE_TTWU
was queued. Now, this happens inside try_to_wake_up.

if there are no other way to queue a csd of type CSD_TYPE_TTWU, then
this suggests some events are being missed by perf.

> 
> So I'll withdraw this change for now and sync back up to check if my
> suspicions are correct or not.
> 
> Thanks so much again for pointing this out.
> -john

