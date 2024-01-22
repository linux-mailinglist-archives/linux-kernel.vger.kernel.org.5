Return-Path: <linux-kernel+bounces-33902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A488371D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A76B285A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BC85F855;
	Mon, 22 Jan 2024 18:06:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035515F863
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946790; cv=none; b=ZaMM3basFFaW2OJ7Fz9iQOwd9fUygy0FbjJPQZee8nlxF0L1y1AV6QCuNKkvmjXzSAn7g5NJv+VSRMsQqJq5TFmQ4YNChJSg6YPqAol8VPtfmpnQLDqObW4ELCoZ6J6NOjhVyoC7RpGu/ipjou2feEN0NDflY7EnDYdIUHyiJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946790; c=relaxed/simple;
	bh=cQLkUPBBLrRH/cRaXmUrTHiSWdeMuSt7rHG+1NHts0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCEh/Pb1h0bKLLkjY4RHYu157nKii54a5iVRKPCS+y2Gryt3QgyLWpEUMDoqBsnLqyUUafq0/BzxLNgdfM4NAe1UubjN9rTg7aMxdWzOoyX9YS3BWVlpHvfDjEaG3S0RNKqLxp1OdDfojnIWCwQbR+uBWrpMxMaGsuuZmXHYs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4012D1476;
	Mon, 22 Jan 2024 10:07:13 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C6963F5A1;
	Mon, 22 Jan 2024 10:06:24 -0800 (PST)
Message-ID: <c4351ab9-9524-595d-9765-f5f50371023e@arm.com>
Date: Mon, 22 Jan 2024 18:06:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
Content-Language: en-GB
To: babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-15-james.morse@arm.com>
 <290d6066-236d-4681-8dc5-8a380c878aeb@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <290d6066-236d-4681-8dc5-8a380c878aeb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 03/01/2024 19:43, Moger, Babu wrote:
> On 12/15/23 11:43, James Morse wrote:
>> MPAM's cache occupancy counters can take a little while to settle once
>> the monitor has been configured. The maximum settling time is described
>> to the driver via a firmware table. The value could be large enough
>> that it makes sense to sleep. To avoid exposing this to resctrl, it
>> should be hidden behind MPAM's resctrl_arch_rmid_read().
>>
>> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
>> to sleep. In this case resctrl_arch_rmid_read() should return an error
>> if it needs to sleep. This will only affect MPAM platforms where
>> the cache occupancy counter isn't available immediately, nohz_full is
>> in use, and there are no housekeeping CPUs in the necessary domain.
>>
>> There are three callers of resctrl_arch_rmid_read():
>> __mon_event_count() and __check_limbo() are both called from a
>> non-migrateable context. mon_event_read() invokes __mon_event_count()
>> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
>> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
>> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
>> also adds work to a per-cpu workqueue.
>>
>> The remaining call is add_rmid_to_limbo() which is called in response
>> to a user-space syscall that frees an RMID. This opportunistically
>> reads the LLC occupancy counter on the current domain to see if the
>> RMID is over the dirty threshold. This has to disable preemption to
>> avoid reading the wrong domain's value. Disabling pre-emption here
>> prevents resctrl_arch_rmid_read() from sleeping.
>>
>> add_rmid_to_limbo() walks each domain, but only reads the counter
>> on one domain. If the system has more than one domain, the RMID will
>> always be added to the limbo list. If the RMIDs usage was not over the
>> threshold, it will be removed from the list when __check_limbo() runs.
>> Make this the default behaviour. Free RMIDs are always added to the
>> limbo list for each domain.
>>
>> The user visible effect of this is that a clean RMID is not available
>> for re-allocation immediately after 'rmdir()' completes, this behaviour
>> was never portable as it never happened on a machine with multiple
>> domains.
>>
>> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
>> with interrupts unmasked. Document this is the expected behaviour, and
>> add a might_sleep() annotation to catch changes that won't work on arm64.

> Reviewed-by: Babu Moger <babu.moger@amd.com>


Thanks!

James

