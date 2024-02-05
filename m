Return-Path: <linux-kernel+bounces-53253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFEC84A2B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8851C2245A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EEB48780;
	Mon,  5 Feb 2024 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W8ZMFNjr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29069482F5;
	Mon,  5 Feb 2024 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159101; cv=none; b=EeGbGeLZVoWbMEOom2FDhxClWSO8QyrvzTOka1e7uCSvx7S2ySWADKSyrAegw+hDoVX7KLttY/I8JLfTakwf/CODvNaCWJ2BrQg56XfrpbcPCVlaJAEllsthjHV/wPgfofxpsp3QAvA7sFqH1xrhRMZKwKAx6qAm9spdL5jajvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159101; c=relaxed/simple;
	bh=1Yz0aDGADYgQdE2doyv2rtAIBB6bqY8anSRMkEBl85s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s76z6637RdPYAd5btmkbhxT/4OzLxXe2GPXRO9C+WJKHtVGnLmecLq7SeQs1EZzce/siLtdM3nvJuVa9smhN9Zx+1c1bgUgllRdFpcQe2ZAhcgmmB1tprMMC7c8d2PPjEGBDvZV95HVnu3/IjkDQrc4IDbmyzgcGus3XwQ2zsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W8ZMFNjr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415IpUZB009480;
	Mon, 5 Feb 2024 12:51:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707159090;
	bh=aXOMJrqtHKHMeefJeHoXGLCjylOfaN2TWjTF1AKGefk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=W8ZMFNjrDyGar8GX3tVH/R3BbAVvLeOWLfHP/y65n0Fl/XrQuebF6mTXN5ud8ehSM
	 CIbpCP1ji0B9PUXE2iZ1WSOhz29n4IKIj6kE3KlOTcu2tpUtD5dzOwsC8EJHmEsIho
	 uDzyEjjukZGXQ7ZhYLf7nrd/qC/qcQQleNomCQ24=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415IpTIT016407
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 12:51:29 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 12:51:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 12:51:29 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415IpSRs088536;
	Mon, 5 Feb 2024 12:51:29 -0600
Message-ID: <4aa84df1-af69-4ecb-94ce-536286e907fc@ti.com>
Date: Mon, 5 Feb 2024 12:51:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: Brandon Brnich <b-brnich@ti.com>, Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Darren
 Etheridge <detheridge@ti.com>
References: <20240201184238.2542695-1-b-brnich@ti.com>
 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
 <20240202125257.p4astjuxpzr5ltjs@dragster>
 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
 <20240202155813.szxvi7bfp5xh7rvw@babble>
 <adfef53c-d64e-4855-ab61-101b6fa419e5@linaro.org>
 <20240205141255.z5kybm42qld44tdz@portfolio>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240205141255.z5kybm42qld44tdz@portfolio>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/5/24 8:12 AM, Nishanth Menon wrote:
> On 17:08-20240202, Krzysztof Kozlowski wrote:
>> On 02/02/2024 16:58, Nishanth Menon wrote:
>>> On 14:56-20240202, Krzysztof Kozlowski wrote:
>>>> On 02/02/2024 13:52, Nishanth Menon wrote:
>>>>> On 11:47-20240202, Krzysztof Kozlowski wrote:
>>>>>> On 01/02/2024 19:42, Brandon Brnich wrote:
>>>>>>> Wave521c has capability to use SRAM carveout to store reference data with
>>>>>>> purpose of reducing memory bandwidth. To properly use this pool, the driver
>>>>>>> expects to have an sram and sram-size node. Without sram-size node, driver
>>>>>>> will default value to zero, making sram node irrelevant.
>>>>>>
>>>>>> I am sorry, but what driver expects should not be rationale for new
>>>>>> property. This justification suggests clearly it is not a property for DT.
>>>>>>
>>>>>
>>>>> Yup, the argumentation in the commit message is from the wrong
>>>>> perspective. bindings are OS agnostic hardware description, and what
>>>>> driver does with the description is driver's problem.
>>>>>
>>>>> I will at least paraphrase my understanding:
>>>>> In this case, however, the hardware block will limp along with
>>>>> the usage of DDR (as is the current description), due to the
>>>>> latencies involved for DDR accesses. However, the hardware block
>>>>> has capability to use a substantially lower latency SRAM to provide
>>>>> proper performance and hence for example, deal with higher resolution
>>>>> data streams. This SRAM is instantiated at SoC level rather than
>>>>> embedded within the hardware block itself.
>>>>
>>>> That sounds like OS policy. Why would different boards with the same
>>>> component have this set differently? Based on amount of available
>>>> memory? This, I believe, is runtime configuration because it might
>>>> depend on user-space you run. Based on purpose (e.g. optimize for
>>>> decoding or general usage)? Again, run-time because same hardware board
>>>> can be used for different purposes.
>>>>
>>>
>>> Why is this OS policy? It is a hardware capability.
>>
>> How amount of SRAM size is hardware capability? Each hardware can work
>> probably with 1, 2 or 100 pages.
>>
>>> Traditionally
>>> many similar hardware blocks would have allocated local SRAM for
>>> worst case inside the hardware block itself and don't need to use
>>> DDR in the first place. However, for this hardware block, it has
>>> capability to use some part of one of the many SRAM blocks in the SoC,
>>> not be shared for some part of the system - so from a hardware
>>> description perspective, we will need to call that out as to which
>>> SRAM is available for the hardware block.
>>
>> Just because more than one device wants some memory, does not mean this
>> is hardware property. Drivers can ask how much memory available there
>> is. OS knows how many users of memory there is, so knows how much to
>> allocate for each device.
>>
>>>
>>> Why would different boards need this differently? simply because
>>> different cameras have different resolution and framerates - and you
>>> dont want to pay the worst case sram penalty for all product
>>> configuration.
>>
>> Choice of resolution and framerate is runtime choice or use-case
>> dependent, not board level configuration, therefore amount of SRAM size
>> to use is as well.
> 
> I am arguing this is similar to what we have for remote-procs. Yes,
> usecases usage come to a conclusion that sram size X is needed. Sure.
> Lets even argue that sram = <&sram> has X+100 bytes available, so as
> far as allocator is concerned, it can allocate. But how does the driver
> know that 1k of that sram is already used by a remote core or some other
> function?

The driver could ask the SRAM provider all that info (gen_pool_avail()).
The driver should at runtime determine the amount of SRAM it needs and
only then attempt to allocate the amount it needed. (and free it after
it is done too)

There is no need to hardcode the amount we think our usecase will need
into DT. Sure it may fail to get as much as it wants if we don't carveout
some out up front, but that is true for any memory allocation. Let's not
turn DT into a static memory allocator tool..

> 
> This is no different from a remote proc usecase, following which, I
> wonder if "memory-region" is the right way to describe this usage? That
> would be a very specific bucket that is made available to the driver.
> And I'd say sram and memory-region are two mutually exclusive option?
> 

Our use of "memory-region" for remote proc memory was also a questionable
thing to do IMHO. Something we will have to cleanup at some point. Might be
good to not call too much attention to that :)

Andrew

>>
>>>
>>> Further, Linux is not the only thing that runs on these SoCs.. these are
>>> mixed systems with autonomous operations of uC cores who may or maynot
>>> (typically not) even need to communicate with MPU to state which part of
>>> resource they are hogging (hence the board level definition).
>>
>> OK that could be the case but I could also say choice of RTOS or any
>> other is also board-independent.

