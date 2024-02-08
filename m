Return-Path: <linux-kernel+bounces-57510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A687184DA03
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A50428342C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2667E6D;
	Thu,  8 Feb 2024 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lDLRGOo7"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7A67C79;
	Thu,  8 Feb 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373339; cv=none; b=P0Niyb9YZwtvuMSZ3hwDg7BpBMYMJkm2vTa83Hkvu6ObeAlXhC5Qqk3xeXdSUW2nzb1+cxOm8fzaaHDxQ5PO0eBq8uBfC1aZmSXJ8woZaUeUBTZCVmAs5p249hzBPnv4crlvBWSB4s1geDGFF7X9l+RUMU+s7CWv02l5dObnoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373339; c=relaxed/simple;
	bh=r14oebp+KeyBZkqFTuBJOO3xPPUWEpLLOwLHbAbBBMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K4oSHi64PsFK2eohGVbcGPNoQoIOwJwoZlSryUEOtHNrhLKoIBofmogNLSenrlc+BBa9mCrKxMSfYMgqBBmoDYjCQrpng4+QYUmleBWymvZrolbDjcVvhXJkn2w7AeJYs3T0qBnS1mKLxX3/gyvZxazUpySCh5Z0W3NbJ2AFmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lDLRGOo7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4186M8dj113275;
	Thu, 8 Feb 2024 00:22:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707373328;
	bh=ejWOb2HuMreagglrbUJOiWVLACXdSChrO+PXOXWj+hQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lDLRGOo7ngTXbcQy66+2yupUpd2NSMm0Obx4tYAX84WHSCr4pMKp7eCe6FN/mgbeH
	 f4MDRAFGm6Yq34wh2MNm7BWj6YGi5QZ1TTo9HhgCY7/lNkG86Qtdwn4j4g62ZRqnem
	 jeWH1fogkHrOGCcx46GBSw3aVX+30jYhG85lM9oQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4186M8a1030841
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 00:22:08 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 00:22:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 00:22:08 -0600
Received: from [10.250.146.202] ([10.250.146.202])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4186M3Co092479;
	Thu, 8 Feb 2024 00:22:03 -0600
Message-ID: <ab029558-fc04-854e-1f97-785f5cec0681@ti.com>
Date: Thu, 8 Feb 2024 11:52:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Content-Language: en-US
To: Brandon Brnich <b-brnich@ti.com>, Nishanth Menon <nm@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nas Chung
	<nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Darren Etheridge <detheridge@ti.com>
References: <20240201184238.2542695-1-b-brnich@ti.com>
 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
 <20240202125257.p4astjuxpzr5ltjs@dragster>
 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
 <20240202155813.szxvi7bfp5xh7rvw@babble>
 <adfef53c-d64e-4855-ab61-101b6fa419e5@linaro.org>
 <20240205141255.z5kybm42qld44tdz@portfolio>
 <20240205192003.3qns6cxqurqnnj7c@udba0500997>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240205192003.3qns6cxqurqnnj7c@udba0500997>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Brandon, et-al,

On 06/02/24 00:50, Brandon Brnich wrote:
> On 08:12-20240205, Nishanth Menon wrote:
>> On 17:08-20240202, Krzysztof Kozlowski wrote:
>>> On 02/02/2024 16:58, Nishanth Menon wrote:
>>>> On 14:56-20240202, Krzysztof Kozlowski wrote:
>>>>> On 02/02/2024 13:52, Nishanth Menon wrote:
>>>>>> On 11:47-20240202, Krzysztof Kozlowski wrote:
>>>>>>> On 01/02/2024 19:42, Brandon Brnich wrote:
>>>>>>>> Wave521c has capability to use SRAM carveout to store reference data with
>>>>>>>> purpose of reducing memory bandwidth. To properly use this pool, the driver
>>>>>>>> expects to have an sram and sram-size node. Without sram-size node, driver
>>>>>>>> will default value to zero, making sram node irrelevant.
>>>>>>>
>>>>>>> I am sorry, but what driver expects should not be rationale for new
>>>>>>> property. This justification suggests clearly it is not a property for DT.
>>>>>>>
>>>>>>
>>>>>> Yup, the argumentation in the commit message is from the wrong
>>>>>> perspective. bindings are OS agnostic hardware description, and what
>>>>>> driver does with the description is driver's problem.
>>>>>>
>>>>>> I will at least paraphrase my understanding:
>>>>>> In this case, however, the hardware block will limp along with
>>>>>> the usage of DDR (as is the current description), due to the
>>>>>> latencies involved for DDR accesses. However, the hardware block
>>>>>> has capability to use a substantially lower latency SRAM to provide
>>>>>> proper performance and hence for example, deal with higher resolution
>>>>>> data streams. This SRAM is instantiated at SoC level rather than
>>>>>> embedded within the hardware block itself.
>>>>>
>>>>> That sounds like OS policy. Why would different boards with the same
>>>>> component have this set differently? Based on amount of available
>>>>> memory? This, I believe, is runtime configuration because it might
>>>>> depend on user-space you run. Based on purpose (e.g. optimize for
>>>>> decoding or general usage)? Again, run-time because same hardware board
>>>>> can be used for different purposes.
>>>>>
>>>>
>>>> Why is this OS policy? It is a hardware capability.
>>>
>>> How amount of SRAM size is hardware capability? Each hardware can work
>>> probably with 1, 2 or 100 pages.
>>>
>>>> Traditionally
>>>> many similar hardware blocks would have allocated local SRAM for
>>>> worst case inside the hardware block itself and don't need to use
>>>> DDR in the first place. However, for this hardware block, it has
>>>> capability to use some part of one of the many SRAM blocks in the SoC,
>>>> not be shared for some part of the system - so from a hardware
>>>> description perspective, we will need to call that out as to which
>>>> SRAM is available for the hardware block.
>>>
>>> Just because more than one device wants some memory, does not mean this
>>> is hardware property. Drivers can ask how much memory available there
>>> is. OS knows how many users of memory there is, so knows how much to
>>> allocate for each device.
>>>
>>>>
>>>> Why would different boards need this differently? simply because
>>>> different cameras have different resolution and framerates - and you
>>>> dont want to pay the worst case sram penalty for all product
>>>> configuration.
>>>
>>> Choice of resolution and framerate is runtime choice or use-case
>>> dependent, not board level configuration, therefore amount of SRAM size
>>> to use is as well.
>>
>> I am arguing this is similar to what we have for remote-procs. Yes,
>> usecases usage come to a conclusion that sram size X is needed. Sure.
>> Lets even argue that sram = <&sram> has X+100 bytes available, so as
>> far as allocator is concerned, it can allocate. But how does the driver
>> know that 1k of that sram is already used by a remote core or some other
>> function?
>>
>> This is no different from a remote proc usecase, following which, I
>> wonder if "memory-region" is the right way to describe this usage? That
>> would be a very specific bucket that is made available to the driver.
>> And I'd say sram and memory-region are two mutually exclusive option?
> 
> Wouldn't this just be a static allocation of the SRAM then? I believe
> the correct way to do this is highlighted in Rob's[0] response. This is
> also something we have done in the past[1], but I thought dynamic
> allocation was preferred method so that the VPU didn't hog a portion of
> SRAM. Seems wasteful in cases where the VPU is not being used.
> 

I think even with the approach selected in [1] i.e. referring the
mmio-sram node using DT property, you can still use dynamic SRAM
allocation.
The driver can still allocate from global sram pool dynamically using
of_gen_pool API as being explained here [3] i.e allocate when first
instance is opened and free up later when no instances are running.

But I agree with Nishanth's point too that we may not want to give all
of SRAM to VPU. For e.g. on AM62A we have 64KiB SRAM and a 1080p
use-case requires 48KiB and even higher for 4K so if there is another
peripheral who is referring this sram node, then it may not get enough
as VPU will hog the major chunk (or all) of it while it is running and
this is where an optional property like sram-size will help to cap the
max sram usage for VPU and so this helps especially on platforms with
limited SRAM availability.

As I understand, the sram size allocation is dependent on resolution and
once programmed can't be changed until all instances of VPU are done,
and we can't predict how many instances user will launch and with what
resolutions.

So here's the flow we had thought of some time back :
1) Define worst case sram size (per 4K use-case as I believe that's the
max for CnM wave521c) as a macro in driver

Then the condition for determining sram size to be allocated should be
as below  :

2) When first instance of VPU is opened, allocate as per sram-size if
sram-size property is specified.

3) If sram-size is not specified then :
   -> Allocate as per worst case size macro defined in driver from sram
pool,
   -> If worst case size of SRAM > max SRAM size, then allocate
      max SRAM size

4). When all of the instances of VPU are closed, then free up all
allocated SRAM.

[3] :
https://wiki.analog.com/resources/tools-software/linuxdsp/docs/linux-kernel-and-drivers/sram

Regards
Devarsh

> The device itself has the capability of doing runtime allocation before
> any decoder/encoder stream instances are opened. All of these opened
> streams will share this one allocated pool, meaning first open stream
> allocates and the rest share. Because of this, the goal is to allocate
> enough to meet maximum use case of VPU (4K60) or max case supported by
> the SoC itself if the SoC is unable to handle 4K60.
> 
> Is there preferred method for dynamic SRAM allocation? I understand
> point that framerate and resolution are runtime choice, but these
> properties are not guaranteed to be known when streams are being opened.
> 
> If static SRAM allocation is the correct method to go, then this series
> can be ignored and I will add section in device tree and remove check
> for parameter in driver as that will now be a bug.
> 
> [0]: https://patchwork.kernel.org/project/linux-media/patch/20240201184238.2542695-1-b-brnich@ti.com/#25696671
> [1]: https://patchwork.kernel.org/project/linux-media/patch/20231108-wave5-v14-rebased-v14-8-0b4af1258656@collabora.com/
>  
>>>
>>>>
>>>> Further, Linux is not the only thing that runs on these SoCs.. these are
>>>> mixed systems with autonomous operations of uC cores who may or maynot
>>>> (typically not) even need to communicate with MPU to state which part of
>>>> resource they are hogging (hence the board level definition).
>>>
>>> OK that could be the case but I could also say choice of RTOS or any
>>> other is also board-independent.
>> -- 
>> Regards,
>> Nishanth Menon
>> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> 
> Thanks,
> Brandon
> 

