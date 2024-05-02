Return-Path: <linux-kernel+bounces-166343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F172C8B994E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA681F21415
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E925FDA6;
	Thu,  2 May 2024 10:43:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9225D903;
	Thu,  2 May 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646579; cv=none; b=M4INnz3pOsHaY3RMlKxjruD+EyhGO9hcKTM4j4lmFeQco744/Ae/4bjEK80s9lFwGSc7WJVng1cuMrTkqsVOR0uuBwyJm/autyNN1H1M/fNLLi73olHFzWpjEITKsNem41j6j1G4XeKY2kd5fCQt83s1TuoGJo6ri4dC2JH5LH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646579; c=relaxed/simple;
	bh=mWltd/gOE5XsQz1QXZSwePIgn+C1/IEfeyFxSyG5sPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPNk4ILcPRX9X5nLEJBsbvt37VUXzHUpojDIClvPRrG20S6Xxn01FkTYHIEfBFDIZFHDPc5KX/L2Bz4Y1Y23LVpQsLWtbOrqNozZB7/vvfdTsT2B+kkdiFX7zokjTU1/FvZvyGolxUzsITxhG9XmS6vIOg8Zhcj40mZdSO8G858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 886882F4;
	Thu,  2 May 2024 03:43:22 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5AB3F793;
	Thu,  2 May 2024 03:42:55 -0700 (PDT)
Message-ID: <050c561c-487e-4e89-a7b2-9752cebc9f46@arm.com>
Date: Thu, 2 May 2024 12:42:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v1 3/3] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
References: <7663799.EvYhyI6sBW@kreacher> <1799046.VLH7GnMWUR@kreacher>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <1799046.VLH7GnMWUR@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 21:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make intel_pstate use the HWP_HIGHEST_PERF values from
> MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
> via the previously introduced arch_set_cpu_capacity() on hybrid
> systems without SMT.

Are there such systems around? My i7-13700K has P-cores (CPU0..CPU15)
with SMT.

> Setting asymmetric CPU capacity is generally necessary to allow the
> scheduler to compute task sizes in a consistent way across all CPUs
> in a system where they differ by capacity.  That, in turn, should help
> to improve task placement and load balancing decisions.  It is also
> necessary for the schedutil cpufreq governor to operate as expected
> on hybrid systems where tasks migrate between CPUs of different
> capacities.
> 
> The underlying observation is that intel_pstate already uses
> MSR_HWP_CAPABILITIES to get CPU performance information which is
> exposed by it via sysfs and CPU performance scaling is based on it.
> Thus using this information for setting asymmetric CPU capacity is
> consistent with what the driver has been doing already.  Moreover,
> HWP_HIGHEST_PERF reflects the maximum capacity of a given CPU including
> both the instructions-per-cycle (IPC) factor and the maximum turbo
> frequency and the units in which that value is expressed are the same
> for all CPUs in the system, so the maximum capacity ratio between two
> CPUs can be obtained by computing the ratio of their HWP_HIGHEST_PERF
> values.  Of course, in principle that capacity ratio need not be
> directly applicable at lower frequencies, so using it for providing the
> asymmetric CPU capacity information to the scheduler is a rough
> approximation, but it is as good as it gets.  Also, measurements
> indicate that this approximation is not too bad in practice.

So cpu_capacity has a direct mapping to itmt prio. cpu_capacity is itmt
prio with max itmt prio scaled to 1024.

Running it on i7-13700K (while allowing SMT) gives:

root@gulliver:~# dmesg | grep sched_set_itmt_core_prio
[    3.957826] sched_set_itmt_core_prio() cpu=0 prio=68
[    3.990401] sched_set_itmt_core_prio() cpu=1 prio=68
[    4.015551] sched_set_itmt_core_prio() cpu=2 prio=68
[    4.040720] sched_set_itmt_core_prio() cpu=3 prio=68
[    4.065871] sched_set_itmt_core_prio() cpu=4 prio=68
[    4.091018] sched_set_itmt_core_prio() cpu=5 prio=68
[    4.116175] sched_set_itmt_core_prio() cpu=6 prio=68
[    4.141374] sched_set_itmt_core_prio() cpu=7 prio=68
[    4.166543] sched_set_itmt_core_prio() cpu=8 prio=69
[    4.196289] sched_set_itmt_core_prio() cpu=9 prio=69
[    4.214964] sched_set_itmt_core_prio() cpu=10 prio=69
[    4.239281] sched_set_itmt_core_prio() cpu=11 prio=69
[    4.263438] sched_set_itmt_core_prio() cpu=12 prio=68
[    4.283790] sched_set_itmt_core_prio() cpu=13 prio=68
[    4.308905] sched_set_itmt_core_prio() cpu=14 prio=68
[    4.331751] sched_set_itmt_core_prio() cpu=15 prio=68
[    4.356002] sched_set_itmt_core_prio() cpu=16 prio=42
[    4.381639] sched_set_itmt_core_prio() cpu=17 prio=42
[    4.395175] sched_set_itmt_core_prio() cpu=18 prio=42
[    4.425625] sched_set_itmt_core_prio() cpu=19 prio=42
[    4.449670] sched_set_itmt_core_prio() cpu=20 prio=42
[    4.479681] sched_set_itmt_core_prio() cpu=21 prio=42
[    4.506319] sched_set_itmt_core_prio() cpu=22 prio=42
[    4.523774] sched_set_itmt_core_prio() cpu=23 prio=42

root@gulliver:~# dmesg | grep hybrid_set_cpu_capacity
[    4.450883] hybrid_set_cpu_capacity() cpu=0 cap=1009
[    4.455846] hybrid_set_cpu_capacity() cpu=1 cap=1009
[    4.460806] hybrid_set_cpu_capacity() cpu=2 cap=1009
[    4.465766] hybrid_set_cpu_capacity() cpu=3 cap=1009
[    4.470730] hybrid_set_cpu_capacity() cpu=4 cap=1009
[    4.475699] hybrid_set_cpu_capacity() cpu=5 cap=1009
[    4.480664] hybrid_set_cpu_capacity() cpu=6 cap=1009
[    4.485626] hybrid_set_cpu_capacity() cpu=7 cap=1009
[    4.490588] hybrid_set_cpu_capacity() cpu=9 cap=1024
[    4.495550] hybrid_set_cpu_capacity() cpu=10 cap=1024
[    4.500598] hybrid_set_cpu_capacity() cpu=11 cap=1024
[    4.505649] hybrid_set_cpu_capacity() cpu=12 cap=1009
[    4.510701] hybrid_set_cpu_capacity() cpu=13 cap=1009
[    4.515749] hybrid_set_cpu_capacity() cpu=14 cap=1009
[    4.520802] hybrid_set_cpu_capacity() cpu=15 cap=1009
[    4.525846] hybrid_set_cpu_capacity() cpu=16 cap=623
[    4.530810] hybrid_set_cpu_capacity() cpu=17 cap=623
[    4.535772] hybrid_set_cpu_capacity() cpu=18 cap=623
[    4.540732] hybrid_set_cpu_capacity() cpu=19 cap=623
[    4.545690] hybrid_set_cpu_capacity() cpu=20 cap=623
[    4.550651] hybrid_set_cpu_capacity() cpu=21 cap=623
[    4.555612] hybrid_set_cpu_capacity() cpu=22 cap=623
[    4.560571] hybrid_set_cpu_capacity() cpu=23 cap=623

> If the given system is hybrid and non-SMT, the new code disables ITMT
> support in the scheduler (because it may get in the way of asymmetric CPU
> capacity code in the scheduler that automatically gets enabled by setting
> asymmetric CPU capacity) after initializing all online CPUs and finds
> the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
> capacity number for each (online) CPU by dividing the product of its
> HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PERF.

SO either CAS at wakeup and in load_balance or SIS at wakeup and ITMT in
load balance.

> When a CPU goes offline, its capacity is reset to SCHED_CAPACITY_SCALE
> and if it is the one with the maximum HWP_HIGHEST_PERF value, the
> capacity numbers for all of the other online CPUs are recomputed.  This
> also takes care of a cleanup during driver operation mode changes.
> 
> Analogously, when a new CPU goes online, its capacity number is updated
> and if its HWP_HIGHEST_PERF value is greater than the current maximum
> one, the capacity numbers for all of the other online CPUs are
> recomputed.
> 
> The case when the driver is notified of a CPU capacity change, either
> through the HWP interrupt or through an ACPI notification, is handled
> similarly to the CPU online case above, except that if the target CPU
> is the current highest-capacity one and its capacity is reduced, the
> capacity numbers for all of the other online CPUs need to be recomputed
> either.
> 
> If the driver's "no_trubo" sysfs attribute is updated, all of the CPU
> capacity information is computed from scratch to reflect the new turbo
> status.

So if I do:

echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo

I get:

[ 1692.801368] hybrid_update_cpu_scaling() called
[ 1692.801381] hybrid_update_cpu_scaling() max_cap_perf=44, max_perf_cpu=0
[ 1692.801389] hybrid_set_cpu_capacity() cpu=1 cap=1024
[ 1692.801395] hybrid_set_cpu_capacity() cpu=2 cap=1024
[ 1692.801399] hybrid_set_cpu_capacity() cpu=3 cap=1024
[ 1692.801402] hybrid_set_cpu_capacity() cpu=4 cap=1024
[ 1692.801405] hybrid_set_cpu_capacity() cpu=5 cap=1024
[ 1692.801408] hybrid_set_cpu_capacity() cpu=6 cap=1024
[ 1692.801410] hybrid_set_cpu_capacity() cpu=7 cap=1024
[ 1692.801413] hybrid_set_cpu_capacity() cpu=8 cap=1024
[ 1692.801416] hybrid_set_cpu_capacity() cpu=9 cap=1024
[ 1692.801419] hybrid_set_cpu_capacity() cpu=10 cap=1024
[ 1692.801422] hybrid_set_cpu_capacity() cpu=11 cap=1024
[ 1692.801425] hybrid_set_cpu_capacity() cpu=12 cap=1024
[ 1692.801428] hybrid_set_cpu_capacity() cpu=13 cap=1024
[ 1692.801431] hybrid_set_cpu_capacity() cpu=14 cap=1024
[ 1692.801433] hybrid_set_cpu_capacity() cpu=15 cap=1024
[ 1692.801436] hybrid_set_cpu_capacity() cpu=16 cap=605
[ 1692.801439] hybrid_set_cpu_capacity() cpu=17 cap=605
[ 1692.801442] hybrid_set_cpu_capacity() cpu=18 cap=605
[ 1692.801445] hybrid_set_cpu_capacity() cpu=19 cap=605
[ 1692.801448] hybrid_set_cpu_capacity() cpu=20 cap=605
[ 1692.801451] hybrid_set_cpu_capacity() cpu=21 cap=605
[ 1692.801453] hybrid_set_cpu_capacity() cpu=22 cap=605
[ 1692.801456] hybrid_set_cpu_capacity() cpu=23 cap=605

Turbo on this machine stands only for the cpu_capacity diff 1009 vs 1024?

[...]


