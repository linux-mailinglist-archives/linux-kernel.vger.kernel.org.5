Return-Path: <linux-kernel+bounces-73300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A285C09B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD502866A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F16576411;
	Tue, 20 Feb 2024 16:02:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C542C6AA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444924; cv=none; b=h59uV3WfXUPqFIRzIYx0lnziyzogyiJJTqxKNUqTtOlXIWfQ7EygH/BCbMyQc+47vhReClXBhQ13zctmDuUAATzl/q1gvVrwBJ6PS2F7ous5BK5gEw/taQ2Ksx7nSlah2CfHPSmb3K9D2W1l6na2lYXd6WOwcPLkv/xQEmBTo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444924; c=relaxed/simple;
	bh=Uqt+DFpm33CB/n7o5DFgHzyUO3un5Sb5LmiMg5MCcCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/ayVuNFT8i2v44Rp1L0keEnRVCp+wZQyL0wI2X8+oRYmEL7yrr61Yv8gkK3WtbrNtC05LAO/MQc6o/qYcseI6Pk831qNl7B5EbtTzt7s/UGmoQj2L1Jp+FxHrlHGGwj3skVfz0GsIdtFsOq/8bNLlHs9lJmQI8bg2MQUkWeOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31255FEC;
	Tue, 20 Feb 2024 08:02:40 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE18B3F7F4;
	Tue, 20 Feb 2024 08:01:58 -0800 (PST)
Message-ID: <49f42c63-63b9-4cf9-96ad-901b3fc1d50e@arm.com>
Date: Tue, 20 Feb 2024 16:01:57 +0000
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
To: Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand
 <david@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ingo Molnar <mingo@redhat.com>,
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
 <59ebda21-6164-4dff-9ba8-956d5a715048@arm.com> <87v86jgmhp.ffs@tglx>
From: James Morse <james.morse@arm.com>
In-Reply-To: <87v86jgmhp.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/02/2024 15:54, Thomas Gleixner wrote:
> On Tue, Feb 20 2024 at 15:46, James Morse wrote:
>> On 20/02/2024 15:27, David Hildenbrand wrote:
>>> On 13.02.24 19:44, James Morse wrote:
>>>> +static void __exit dom_data_exit(void)
>>>> +{
>>>> +    mutex_lock(&rdtgroup_mutex);
>>>> +
>>>> +    kfree(rmid_ptrs);
>>>> +    rmid_ptrs = NULL;
>>>> +
>>>> +    mutex_unlock(&rdtgroup_mutex);
>>>
>>> Just curious: is grabbing that mutex really required?
>>>
>>> Against which race are we trying to protect ourselves?
>>
>> Not a race, but its to protect against having to think about memory ordering!
>>
>>> I suspect this mutex is not required here: if we could racing with someone else, likely
>>> freeing that memory would not be safe either.
>>
>> All the accesses to that variable take the mutex, its necessary to take the mutex to
>> ensure the most recently stored values are seen. In this case the array values don't
>> matter, but rmid_ptrs is written under the mutex too.
>> There is almost certainly a control dependency that means the CPU calling dom_data_exit()
>> will see the value of rmid_ptrs from dom_data_init() - but its much simpler to check that
>> all accesses take the mutex.
>>
>> With MPAM this code can be invoked from an error IRQ signalled by the hardware, so it
>> could happen anytime.
> 
> Which does not work because you can't acquire a mutex from hard
> interrupt context.

Indeed - which is why that happens via schedule_work() [0]

My point was that its non-obvious where/when this will happen, so taking the lock and
forgetting about it is the simplest thing to do.


Thanks,

James


[0]
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_devices.c?h=mpam/snapshot/v6.7-rc2&id=7da1c7f9d9ef723f829bf44ed96e1fc4a46ef29f#n1299


