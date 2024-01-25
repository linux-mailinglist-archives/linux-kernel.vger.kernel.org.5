Return-Path: <linux-kernel+bounces-38727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E6F83C4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B451F26154
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A4C6E2BC;
	Thu, 25 Jan 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S3i9JLAF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E06340E;
	Thu, 25 Jan 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193263; cv=none; b=WxAK+zfgQ9/7kUfb1UAiPxLR4L110H7X9Fyr6bB7cykK7DDYKFit4l5T4EpGS5HdIKldePBNfM7pG9nxrgo5d8xIjKeAqAGV/60Q2A+Yo0DAXBLJMHVpGw+gXPV7/3n80/UOW0tbuy7DA2e/o3kOtXnEd9XWjyvtUq7a3qbF8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193263; c=relaxed/simple;
	bh=sjdoDcDKRSkLx4UDwlfMTbTX9nBFU/s/iUda1EdkDKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qJIJSZZUEJHZTY8VFpnEjAk5ckf87uk87Gjro66U01/dzO+ooA6SJuEE8F+sRaef1WiAf1SJBViT+n0SBygWbQ8tdEI1m9eee1u2PUaR4MCQ30kyPEFvHGO4uDpOsXuwy0UCTOywWfVlsLZt4D+AeZoxqN1c7cy54C7sGMkKgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S3i9JLAF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PEXsZn003349;
	Thu, 25 Jan 2024 08:33:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706193234;
	bh=D3et9L4RHHyPosS3VDVQzoYncrvITyHk1dVQbc6iud8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=S3i9JLAFv/yOUIvqQltF0KZwma/RCvGqNExNYIpZXMRkFerkygu+XtgdcXNRAe/E+
	 wMDR0ducWngXiGpABRGbxXH4nLQRLmbwhH60TRobQknis7fiOEVs5mHMh84B029fzV
	 47V1e2KNcoFTOsmivniaScYuG/FFSc8Dt+hDFr9k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PEXsPY129184
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 08:33:54 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 08:33:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 08:33:54 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PEXr4k008480;
	Thu, 25 Jan 2024 08:33:53 -0600
Message-ID: <9a5f017c-530c-482b-9cbf-a07281e92589@ti.com>
Date: Thu, 25 Jan 2024 08:33:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB system
 controller
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
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CYNQHXOZ73YR.3QODFI2X08KC6@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/25/24 5:01 AM, Théo Lebrun wrote:
> Hello,
> 
> On Thu Jan 25, 2024 at 8:51 AM CET, Krzysztof Kozlowski wrote:
>> On 24/01/2024 16:14, Rob Herring wrote:
>>>> +
>>>> +      pinctrl-b {
>>>> +        compatible = "mobileye,eyeq5-b-pinctrl";
>>>> +        #pinctrl-cells = <1>;
>>>> +      };
>>>> +    };
>>>
>>> This can all be simplified to:
>>>
>>> system-controller@e00000 {
>>>      compatible = "mobileye,eyeq5-olb", "syscon";
>>>      reg = <0xe00000 0x400>;
>>>      #reset-cells = <2>;
>>>      #clock-cells = <1>;
>>>      clocks = <&xtal>;
>>>      clock-names = "ref";
>>>
>>>      pins { ... };
>>> };
>>>
>>> There is no need for sub nodes unless you have reusable blocks or each
>>> block has its own resources in DT.
>>
>> Yes, however I believe there should be resources here: each subnode
>> should get its address space. This is a bit tied to implementation,
>> which currently assumes "everyone can fiddle with everything" in this block.
>>
>> Theo, can you draw memory map?
> 
> It would be a mess. I've counted things up. The first 147 registers are
> used in this 0x400 block. There are 31 individual blocks, with 7
> registers unused (holes to align next block).
> 
> Functions are reset, clocks, LBIST, MBIST, DDR control, GPIO,
> accelerator control, CPU entrypoint, PDTrace, IRQs, chip info & ID
> stuff, control registers for PCIe / eMMC / Eth / SGMII / DMA / etc.
> 
> Some will never get used from Linux, others might. Maybe a moderate
> approach would be to create ressources for major blocks and make it
> evolve organically, without imposing that all uses lead to a new
> ressource creation.
> 

That is usually how nodes are added to DT. If you modeled this
system-controller space as a "simple-bus" instead of a "syscon"
device, you could add nodes as you implement them. Rather than
all at once as you have to by treating this space as one large
blob device.

Andrew

> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

