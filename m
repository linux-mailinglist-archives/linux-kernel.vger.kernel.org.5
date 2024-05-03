Return-Path: <linux-kernel+bounces-168063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B08688BB337
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6505D1F21E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28BD15AAAA;
	Fri,  3 May 2024 18:30:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1A158D9A;
	Fri,  3 May 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761013; cv=none; b=q5dAfP4xCQdZt+zB/GmqryzNMvLMY3qbNDUL7wy2njegmLviGhHBVipY3s3Sdl+0uk/QcZwte+U5JOCjhO2luGqL7MM1ccRIx7arnxk75VvxwLLnlgxvqNX5WJ12NlIWqxwUXBS/1QhUo6VpmtB0gb+LhzwzQugO/3yWhGWpgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761013; c=relaxed/simple;
	bh=u7xb8XgMeGPLuSoLlchm5v+UliifwUuELHsYAKkW38I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb5DXpE6Ody9GCtu/aamuybdCXv0/I6/9ogqmxk0wCD2RqdRU9qzV5USP7Grg/gb9wJUL3G3ev9RH4fZVsKiZF3o30tIJCfLEKfHWNmTVTkXo8s2Np8/Oj+SW0Xbn+2M4ecGxiCZr8nqGb9XZjzL6vqs5zSfgmKVf5wMig5eNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EBFA13D5;
	Fri,  3 May 2024 11:30:35 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E1B73F762;
	Fri,  3 May 2024 11:30:07 -0700 (PDT)
Message-ID: <0b849052-0eb1-4085-aa65-73b7451cd6ba@arm.com>
Date: Fri, 3 May 2024 20:29:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v1 3/3] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers
 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
References: <7663799.EvYhyI6sBW@kreacher> <1799046.VLH7GnMWUR@kreacher>
 <050c561c-487e-4e89-a7b2-9752cebc9f46@arm.com>
 <20240503033242.GA14835@ranerica-svr.sc.intel.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240503033242.GA14835@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 05:32, Ricardo Neri wrote:
> On Thu, May 02, 2024 at 12:42:54PM +0200, Dietmar Eggemann wrote:
>> On 25/04/2024 21:06, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make intel_pstate use the HWP_HIGHEST_PERF values from
>>> MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
>>> via the previously introduced arch_set_cpu_capacity() on hybrid
>>> systems without SMT.
>>
>> Are there such systems around? My i7-13700K has P-cores (CPU0..CPU15)
>> with SMT.
> 
> We have been experimenting with nosmt in the kernel command line.

OK.

[...]

>>> If the given system is hybrid and non-SMT, the new code disables ITMT
>>> support in the scheduler (because it may get in the way of asymmetric CPU
>>> capacity code in the scheduler that automatically gets enabled by setting
>>> asymmetric CPU capacity) after initializing all online CPUs and finds
>>> the one with the maximum HWP_HIGHEST_PERF value.  Next, it computes the
>>> capacity number for each (online) CPU by dividing the product of its
>>> HWP_HIGHEST_PERF and SCHED_CAPACITY_SCALE by the maximum HWP_HIGHEST_PERF.
>>
>> SO either CAS at wakeup and in load_balance or SIS at wakeup and ITMT in
>> load balance.
> 
> May I know what CAS and SIS stand for?

Capacity Aware Scheduling and Select_Idle_Sibling().

Either   select_idle_sibling() -> select_idle_capacity()         (1)

or       select_idle_sibling() -> select_idle_cpu() /* nosmt */  (2)

So my system with now 'nosmt' goes (1).

