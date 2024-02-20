Return-Path: <linux-kernel+bounces-73271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D4D85C048
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE80D1F24BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203D762D9;
	Tue, 20 Feb 2024 15:46:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D376058
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443978; cv=none; b=A0QJnFEZugq3hgxJ0Wbz5984xbLVXR56jPsHiOUvsJyyKyaqrRrlzpWl0VzAlzFz+pxe5WWIH8Jnih50iAJbfKKWe5yAGZXxmzL+j6RY1Qq8Nhq99I56BCsbdMAKTukRxyWNXmZhKdo1u8DJlciwzoogUmCOiYeWE1WYwqlC8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443978; c=relaxed/simple;
	bh=lpRfG1ew9kP4olbwW13c/v736z8V8B8hTx8epxhtpMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guHhMA7sd0MAH4wNAI5dvK0qwOyTzpMgjupAS09JqUT1XXVGvCU8ssxtN+KDW30iTBd7mMXlcXlaDtrTL6/kvecknGMTDCYqOGkdgjMm6OEdNRpP6KSh4rXyFLaPG2muRBiOx6Q4l/Zx/4XOEn+9Dlt57mChGzi15shTrHkIZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6E1FEC;
	Tue, 20 Feb 2024 07:46:54 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03B453F73F;
	Tue, 20 Feb 2024 07:46:12 -0800 (PST)
Message-ID: <59ebda21-6164-4dff-9ba8-956d5a715048@arm.com>
Date: Tue, 20 Feb 2024 15:46:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/24] x86/resctrl: kfree() rmid_ptrs from
 resctrl_exit()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-3-james.morse@arm.com>
 <52f81c45-efa7-42c7-86f4-fc1084b1d57a@redhat.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <52f81c45-efa7-42c7-86f4-fc1084b1d57a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

On 20/02/2024 15:27, David Hildenbrand wrote:
> On 13.02.24 19:44, James Morse wrote:
>> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
>>
>> While the exit text ends up in the linker script's DISCARD section,
>> the direction of travel is for resctrl to be/have loadable modules.
>>
>> Add resctrl_put_mon_l3_config() to cleanup any memory allocated
>> by rdt_get_mon_l3_config().
>>
>> There is no reason to backport this to a stable kernel.

>> +static void __exit dom_data_exit(void)
>> +{
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    kfree(rmid_ptrs);
>> +    rmid_ptrs = NULL;
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
> 
> Just curious: is grabbing that mutex really required?
> 
> Against which race are we trying to protect ourselves?

Not a race, but its to protect against having to think about memory ordering!


> I suspect this mutex is not required here: if we could racing with someone else, likely
> freeing that memory would not be safe either.

All the accesses to that variable take the mutex, its necessary to take the mutex to
ensure the most recently stored values are seen. In this case the array values don't
matter, but rmid_ptrs is written under the mutex too.
There is almost certainly a control dependency that means the CPU calling dom_data_exit()
will see the value of rmid_ptrs from dom_data_init() - but its much simpler to check that
all accesses take the mutex.

With MPAM this code can be invoked from an error IRQ signalled by the hardware, so it
could happen anytime.


> Apart from that LGTM.

Thanks for taking a look!


Thanks,

James


