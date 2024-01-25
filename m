Return-Path: <linux-kernel+bounces-38804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3583C630
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED42DB25540
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E00745D0;
	Thu, 25 Jan 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E2Ffo1uh"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C986EB57;
	Thu, 25 Jan 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195519; cv=none; b=jgdgtpiwYeCILzrnL7xVpdyxrWvk7YwF9zS65LG1bOVH1xa5IPWlRTsT5U369RkgzKodZlFnGlGY5DyjLlNyYjPnYVMnY3KJmiI53nFl4LBpw7KDUFhwSIXAWTYp7BokoAwW7dsnJKbMMy9XMtH/xK/+FD2OuL2fce72I66u4Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195519; c=relaxed/simple;
	bh=4wd9RyWyfdexA0auyxKTcpoP6F7WPK4FkDs5AQI85YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Km4ihJIaMPFlaIqG7zAmbSbaG2/zC9RKGVBUnqchKpuoKf6hayzpIlaKrGkbzeaEfgwmJFmhFQcTruV5OmH9Z8kOT8cTD4BMEgo8jZEGUzbpw2YgYnE516WggkOsytXB7kvo9YEd/wakXsfC8QFEs92eghQzJa9K+Bkt4sFpxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E2Ffo1uh; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PFBTjo062885;
	Thu, 25 Jan 2024 09:11:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706195489;
	bh=nnycDpUyHEYRnXSGd7BVAApDp79zLAy9I9g2qDZQ/7o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=E2Ffo1uhKS+Wi6oSs27amFdIrvP691dLNdESwuTKuC4Qv9ef+txUdhrS2EXgNT7fn
	 3NY0ZyPtxv26l8bvImfu9DpJVooKXqxAB6lbOzcS+87TDHxtnpGnKs7gFh7PqmW/e5
	 YPzd2gbOI9PIv0GDTaEfvYT6L70byAufxkPzG9N4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PFBTBm052055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 09:11:29 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 09:11:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 09:11:28 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PFBRqW005393;
	Thu, 25 Jan 2024 09:11:28 -0600
Message-ID: <68eb9295-ffb5-4c48-a474-39f1893d6a28@ti.com>
Date: Thu, 25 Jan 2024 09:11:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
CC: Gregory CLEMENT <gregory.clement@bootlin.com>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linus
 Walleij <linus.walleij@linaro.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>,
        <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        <linux-gpio@vger.kernel.org>
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-4-392b010b8281@bootlin.com>
 <20240124151405.GA930997-robh@kernel.org>
 <dd7e723d-3c4c-4edf-afc2-51db9a074efa@linaro.org>
 <CYNQHXOZ73YR.3QODFI2X08KC6@bootlin.com>
 <9a5f017c-530c-482b-9cbf-a07281e92589@ti.com>
 <CYNVD4U0M5OS.LQ2MAKOL0LAP@bootlin.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CYNVD4U0M5OS.LQ2MAKOL0LAP@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/25/24 8:49 AM, Théo Lebrun wrote:
> Hello,
> 
> On Thu Jan 25, 2024 at 3:33 PM CET, Andrew Davis wrote:
>> On 1/25/24 5:01 AM, Théo Lebrun wrote:
>>> Hello,
>>>
>>> On Thu Jan 25, 2024 at 8:51 AM CET, Krzysztof Kozlowski wrote:
>>>> On 24/01/2024 16:14, Rob Herring wrote:
>>>>>> +
>>>>>> +      pinctrl-b {
>>>>>> +        compatible = "mobileye,eyeq5-b-pinctrl";
>>>>>> +        #pinctrl-cells = <1>;
>>>>>> +      };
>>>>>> +    };
>>>>>
>>>>> This can all be simplified to:
>>>>>
>>>>> system-controller@e00000 {
>>>>>       compatible = "mobileye,eyeq5-olb", "syscon";
>>>>>       reg = <0xe00000 0x400>;
>>>>>       #reset-cells = <2>;
>>>>>       #clock-cells = <1>;
>>>>>       clocks = <&xtal>;
>>>>>       clock-names = "ref";
>>>>>
>>>>>       pins { ... };
>>>>> };
>>>>>
>>>>> There is no need for sub nodes unless you have reusable blocks or each
>>>>> block has its own resources in DT.
>>>>
>>>> Yes, however I believe there should be resources here: each subnode
>>>> should get its address space. This is a bit tied to implementation,
>>>> which currently assumes "everyone can fiddle with everything" in this block.
>>>>
>>>> Theo, can you draw memory map?
>>>
>>> It would be a mess. I've counted things up. The first 147 registers are
>>> used in this 0x400 block. There are 31 individual blocks, with 7
>>> registers unused (holes to align next block).
>>>
>>> Functions are reset, clocks, LBIST, MBIST, DDR control, GPIO,
>>> accelerator control, CPU entrypoint, PDTrace, IRQs, chip info & ID
>>> stuff, control registers for PCIe / eMMC / Eth / SGMII / DMA / etc.
>>>
>>> Some will never get used from Linux, others might. Maybe a moderate
>>> approach would be to create ressources for major blocks and make it
>>> evolve organically, without imposing that all uses lead to a new
>>> ressource creation.
>>>
>>
>> That is usually how nodes are added to DT. If you modeled this
>> system-controller space as a "simple-bus" instead of a "syscon"
>> device, you could add nodes as you implement them. Rather than
>> all at once as you have to by treating this space as one large
>> blob device.
> 
> I see where you are coming from, but in our case modeling our DT node as
> a simple-bus would be lying about the hardware behind. There is no such
> underlying bus. Let's try to keep the devicetree an abstraction
> describing the hardware.

Sure there is a bus, every register is on a bus, all these registers are
memory mapped aren't they? "simple-bus" is just a logical grouping, it
doesn't have to imply the bus is physically separate from the rest of
the system bus. If you don't want these misc registers logically grouped
then add them all as subnodes directly on the main SoC bus node.

Calling that group of miscellaneous registers a "simple-mfd" device is
even more incorrectly modeled IMHO.

We have the same problem on our SoCs (hardware folks just love making
miscellaneous junk drawer register spaces :D). And we decided to model
it as a "syscon", "simple-mfd" too, how simple to just have all the
other nodes point to this space with phandles and pull out whatever
register they need. But that was a mistake we are still working to
unwind.

> 
> Also, we are having conflicts because multiple such child nodes are
> being added at the same time as the base node. Once this initial series
> is out (meaning dt-bindings for the OLB will exist) we'll be able to
> add new nodes or ressources on a whim.
> 

Not to this "system-controller" space you won't. If you keep it as
a "simple-mfd","syscon" you will need to update the binding every
time you add a new node.

> Have you got an opinion on the approach described in this email?
> https://lore.kernel.org/lkml/CYNRCGYA1PJ2.FYENLB4SRJWH@bootlin.com/
> 

Looks better to me, the nodes contain the registers they use which
means you could simply add a ranges property to the parent and
not need to use special accessors and offsets in the drivers too.

Andrew

> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

