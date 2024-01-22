Return-Path: <linux-kernel+bounces-33901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE0837010
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D421C284C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32925F848;
	Mon, 22 Jan 2024 18:06:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB55EE9D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946785; cv=none; b=IQoWi2gF+5bEqPVPnMnV1n6PJlWJkE9dWnduW9v8DExr3xDxw4A0zwTUdsicGORU5kOpFXc1sIL0AKas6J4J2jOaLxp4Bem29tWvrYAFwNZSIUIr51vYl2TA39oKzivj8E9ZxYrbXIXBZaxuqcOTyzm/V3eSu/l9+Yl2eF3mmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946785; c=relaxed/simple;
	bh=Pi4h6swE+i8pYTDukMHiZgPIdJvq2y30molNGDLekRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Snl53cFx9dLxE78Zi0BR5NNCMtvMQ5vNMMs1HD6d+pG/eNtl/771vUjJUWKZ59TpbaYNad6wHN9orAcWP/dHSRnH/tqiT50amKz3PwqCfbMzvrZj4Zw3meAdMK3iHofwkIrf39Q7NMLsKPd4u16m4zzRyvt7FXgUR+b9KX53B3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E4C9143D;
	Mon, 22 Jan 2024 10:07:08 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4913F5A1;
	Mon, 22 Jan 2024 10:06:19 -0800 (PST)
Message-ID: <93c86af6-7eaa-4cd5-3599-34f2f033a1f5@arm.com>
Date: Mon, 22 Jan 2024 18:06:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 13/24] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
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
 <20231215174343.13872-14-james.morse@arm.com>
 <cf72ab6a-83b7-4609-8dec-7756f8ae5808@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <cf72ab6a-83b7-4609-8dec-7756f8ae5808@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 03/01/2024 19:43, Moger, Babu wrote:
> On 12/15/23 11:43, James Morse wrote:
>> Intel is blessed with an abundance of monitors, one per RMID, that can be
>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>> the number implemented is up to the manufacturer. This means when there are
>> fewer monitors than needed, they need to be allocated and freed.
>>
>> MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
>> CSU counter is allowed to return 'not ready' for a small number of
>> micro-seconds after programming. To allow one CSU hardware monitor to be
>> used for multiple control or monitor groups, the CPU accessing the
>> monitor needs to be able to block when configuring and reading the
>> counter.
>>
>> Worse, the domain may be broken up into slices, and the MMIO accesses
>> for each slice may need performing from different CPUs.
>>
>> These two details mean MPAMs monitor code needs to be able to sleep, and
>> IPI another CPU in the domain to read from a resource that has been sliced.
>>
>> mon_event_read() already invokes mon_event_count() via IPI, which means
>> this isn't possible. On systems using nohz-full, some CPUs need to be
>> interrupted to run kernel work as they otherwise stay in user-space
>> running realtime workloads. Interrupting these CPUs should be avoided,
>> and scheduling work on them may never complete.
>>
>> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
>> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
>> in a domain are using nohz-full, then an IPI is used as the fallback.
>>
>> This function is only used in response to a user-space filesystem request
>> (not the timing sensitive overflow code).
>>
>> This allows MPAM to hide the slice behaviour from resctrl, and to keep
>> the monitor-allocation in monitor.c. When the IPI fallback is used on
>> machines where MPAM needs to make an access on multiple CPUs, the counter
>> read will always fail.

> Reviewed-by: Babu Moger <babu.moger@amd.com>


Thanks!

James


