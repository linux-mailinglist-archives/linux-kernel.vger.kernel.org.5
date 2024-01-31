Return-Path: <linux-kernel+bounces-46150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61178843B45
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25AA1F24DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE3A6994B;
	Wed, 31 Jan 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O87DrViM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3269944
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693927; cv=none; b=ipnpD6gHenelH+7ndZqY/0CKmY3MKSDtCTF9CytAlBMTZuOrFBGlElWSeFz85jYZNZYbctcheKSLhQcXhGze7XXpbwzFhQxlbiteoSTKpwB/1dlVtk8GxKZ/WPclQPo6DYljZ62GnsYF/k7yCkY4Cm0tTrYrPsx9lM9W47JVMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693927; c=relaxed/simple;
	bh=ueZ1o/qp07S1jEAUT0lMHJpeLaZtwe2Yg+6xj7z1b3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF42fA2sgCugGh09ziNJmiediQxi0XR+Y0rHaw/iJ4bELmwiX/jrqp18qEP7alxxUGhI5Bi2OyzpnCTzXaBKAtoI5ybVZn7vjlEGxGcYvFfhC8FAPiKXg5bfXi2ioenkkwdAKQogeE3CRIMdOjEQNoYcF/uD8YOsr4GZjTrBQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O87DrViM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7A6C433F1;
	Wed, 31 Jan 2024 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706693926;
	bh=ueZ1o/qp07S1jEAUT0lMHJpeLaZtwe2Yg+6xj7z1b3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O87DrViMDk5TcT7Q7hwDQ0sM724YLBeuKJbBXXOCvg8lhRh/VoFVsXjale1r48HWC
	 84t7wR5ahz/MiToQtf3TT5ECPWaHx9z+u+QVZqvKG5L0Cjy5n/MWox6EWjoR66JRCE
	 1EOdpu4Ya6Naa7uhcFTTaUSKYmhIIP4fkHQfW2BJgDCQ+MwPYS50JpY9bj0lY+QeGc
	 ju1TcvDtX4NcAIN7Q05QWrA+goftJ2ge0O1aWZ9lNo4z1a9piujBcDTUT55OaHZnJ0
	 h/HwUCHGIRoH3Yec3pawlrTOuEdffCvk+Vw5MVtssB3sP1vysbkG2zk/mTQbEO/Z8a
	 5YU0Y+66Ftg9A==
Message-ID: <fef66164-1238-45e4-b70c-c565caa2cf75@kernel.org>
Date: Wed, 31 Jan 2024 10:38:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-US
To: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, ke.zhao@shingroup.cn, zhijie.ren@shingroup.cn,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240131070821.11477-1-jialong.yang@shingroup.cn>
 <deb708e5-bbaf-4510-826b-17e14e69b475@kernel.org>
 <6D9001324476F76F+ee5f853d-7c69-4a99-857c-cc2b03e9eea1@shingroup.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <6D9001324476F76F+ee5f853d-7c69-4a99-857c-cc2b03e9eea1@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 10:07, Yang Jialong 杨佳龙 wrote:
> 
> 
> 在 2024/1/31 15:59, Krzysztof Kozlowski 写道:
>> On 31/01/2024 08:08, JiaLong.Yang wrote:
>>> This code is based on uncore PMUs arm_smmuv3_pmu and arm-cmn.
>>> One ni-700 can have many clock domains. Each of them has only one PMU.
>>> Here one PMU corresponds to one 'struct ni_pmu' instance.
>>> PMU name will be ni_pmu_N_M, which N means different NI-700s and M means
>>> different PMU in one NI-700. If only one NI-700 found in NI-700, name will
>>> be ni_pmu_N.
>>> Node interface event name will be xxni_N_eventname, such as
>>> asni_0_rdreq_any. There are many kinds of type of nodes in one clock
>>> domain. Also means that there are many kinds of that in one PMU. So we
>>> distinguish them by xxni string. Besides, maybe there are many nodes
>>> have same type. So we have number N in event name.
>>> By ni_pmu_0_0/asni_0_rdreq_any/, we can pinpoint accurate bus traffic.
>>> Example1: perf stat -a -e ni_pmu_0_0/asni_0_rdreq_any/,ni_pmu_0_0/cycles/
>>> EXample2: perf stat -a -e ni_pmu_0_0/asni,id=0,event=0x0/
>>>
>>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>>> ---
>>> v1 --> v2:
>>> 1. Submit MAINTANER Documentation/ files seperately.
>>
>> SEPARATE PATCHES, not patchsets. You have now checkpatch warnings
>> because of this...
> 
> ...OK. But the MAINTANER file changing should be given in which one 
> patches.
> I will submit patch v3 after talking and your permission.
> 
>>
>>> 2. Delete some useless info printing.
>>> 3. Change print from pr_xxx to dev_xxx.
>>> 4. Fix more than 75 length log info.
>>> 5. Fix dts attribute pccs-id.
>>> 6. Fix generic name according to DT specification.
>>> 7. Some indentation.
>>> 8. Del of_match_ptr macro.
>>>
>>>   drivers/perf/Kconfig     |   11 +
>>>   drivers/perf/Makefile    |    1 +
>>>   drivers/perf/hx_arm_ni.c | 1284 ++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 1296 insertions(+)
>>>   create mode 100644 drivers/perf/hx_arm_ni.c
>>>
>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>> index ec6e0d9194a1..95ef8b13730f 100644
>>> --- a/drivers/perf/Kconfig
>>> +++ b/drivers/perf/Kconfig
>>> @@ -241,4 +241,15 @@ config CXL_PMU
>>>   
>>>   	  If unsure say 'm'.
>>>   
>>> +config HX_ARM_NI_PMU
>>> +       tristate "HX ARM NI-700 PMU"
>>> +       depends on PPC_HX_C2000 && 64BIT
>>
>> 1. There is no PPC_HX_C2000.
> 
> I have been used to using this macro. However this macro is not existed 
> in mainline.
> I will replace it with ARM64. And del involved C code if OK.
> 
> 64bit:
> __ffs(unsigned long) and __fls(unsigned long) will be wrong in 32bit. I 
> pass a u64 argument.

One thing is where the code is supposed to run, second thing is compile
testing.

Why do you use __ffs, not __ffs64 which takes u64 if you really want
only 64bit argument? unsigned long != u64, so your code is not
architecture independent. You claim you wrote it on purpose as
non-architecture-independent, but then I claim it's a bug. We are
supposed to write code which is portable, as much as possible, assuming
it does not affect readability.


> struct ni_hw_perf_event will be big than limit.
> BUILD_BUG_ON(sizeof(struct ni_hw_perf_event) > offsetof(struct 
> hw_perf_event, target));

And why do you need to use any of such code? Please open one of hundreds
of other drivers which work correctly on 32 and 64-bit platforms.

> 
>> 2. Nothing justified dependency on 64bit. Drop or explain. Your previous
>> message did not provide real rationale.
> 
> If ARM64, then drop.

..

..

>>> +	/* Step2: Traverse all clock domains. */
>>> +	for (cd_idx = 0; cd_idx < ni->cd_num; cd_idx++) {
>>> +		cd = cd_arrays[cd_idx];
>>> +
>>> +		num = ni_child_number(cd);
>>> +		dev_dbg(dev, "The %dth clock domain has %d child nodes:", cd_idx, num);
>>> +
>>> +		/* Omit pmu node */
>>> +		ni_pmu = devm_kzalloc(dev, struct_size(ni_pmu, ev_src_nodes, num - 1),
>>> +				      GFP_KERNEL);
>>> +		ni_pmu->ev_src_num = num - 1;
>>> +
>>> +		if (!ni_pmu)
>>> +			return -ENOMEM;
>>> +
>>> +		num_idx = 0;
>>> +		for (nd_idx = 0; nd_idx < num; nd_idx++) {
>>> +			nd = ni_child_pointer(pbase, cd, nd_idx);
>>> +
>>> +			node.base = nd;
>>> +			node.node_type = ni_node_node_type(nd);
>>> +
>>> +			if (unlikely(ni_node_type(nd) == NI_PMU))
>>> +				ni_pmu->pmu_node = node;
>>> +			else
>>> +				ni_pmu->ev_src_nodes[num_idx++] = node;
>>> +			dev_dbg(dev, "  name: %s   id: %d", ni_node_name[node.type], node.id);
>>> +		}
>>> +
>>> +		ni_pmu->dev = dev;
>>> +		ni_pmu->ni = ni;
>>> +		ni->ni_pmus[cd_idx] = ni_pmu;
>>> +	}
>>> +
>>> +	devm_kfree(dev, cd_arrays);
>>
>> Why? If it is not device-lifetime then allocate with usual way.
>>
> 
> No device-lifetime.
> Will allocate in stack.

I was thinking about kzalloc. But if array is small, stack could be as well.

..

>>
>>> +
>>> +static const struct of_device_id ni_pmu_of_match[] = {
>>> +	{ .compatible = "hx,c2000-arm-ni" },
>>
>> Don't send undocumented compatibles.
> 
> OK. Means I should send doc and code in one patch thread with more than 
> one patch?

Yes. Please open lore.kernel.org and look at any other submissions
involving bindings or other type of ABI documentation (like sysfs).

Best regards,
Krzysztof


