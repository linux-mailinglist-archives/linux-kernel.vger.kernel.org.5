Return-Path: <linux-kernel+bounces-154077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412ED8AD727
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EDB282241
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28751F95A;
	Mon, 22 Apr 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wWIwGw0H"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851218AED;
	Mon, 22 Apr 2024 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824199; cv=none; b=nwt0obHxhPXWyDRFiy1cCazK4ojh+0tEHWbVvsAxeD7tJjKcalZ9KtJds1FwFGIQj9bIpDnICicv1+34J/zUnSMOJM6+qgCE4Fwd8Rp9WwMdClChENtIhgibZWJLG4sTCmYU4JX2CrGDqlSAtys5Ufo+VLOuqA+ESFiBeCjm1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824199; c=relaxed/simple;
	bh=s63qWirH6LnQOQhdFuM5UCirhhZiyGhBxJTNyk0JRPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RSaEUUIEFqtfTAbeLHwpTwRIlwFcQeQJlotBaSSoPdke4MPiXh4VDBzeaoFGQElzo+mnbsqlBuwK62W9k9s5K1VgcaTD67lrk9m2t86sguS52znLthe2c3jyDQpGJ4qhV0+X43smI8+OLwRxDsVl647MFPYDA5sCoXT1IZGjE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wWIwGw0H; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MMFUbB129084;
	Mon, 22 Apr 2024 17:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713824130;
	bh=TGSyHDDNUUS+JmaQ28HCmCuprjBJyEqRRCDtdPXLLOs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wWIwGw0HCkcxnacVEtadTNnclC2hEiRWiofhJg84iLQbACfgjmPFrgzPJ70nSvHWC
	 TfiOcEaWp5LXQyGdln4Qi5Sbyz9PtuFz+1q/Xhh254PaDBKh+VNaqyC7W7L3GWZ70p
	 nrv2wJA8eGTLRkYhgoj6FdFZ5mU7VZpOUYczSzXw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MMFUA3123197
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 17:15:30 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 17:15:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 17:15:30 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MMFU2W122172;
	Mon, 22 Apr 2024 17:15:30 -0500
Message-ID: <a4fcaaad-de8a-4809-9277-ffb63f6227b3@ti.com>
Date: Mon, 22 Apr 2024 17:15:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: counter: Update TI eQEP binding
To: David Lechner <david@lechnology.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <20240418221417.1592787-1-jm@ti.com>
 <20240418221417.1592787-6-jm@ti.com>
 <4cf5f463-dccd-4637-b7ce-e8d8eac044b7@lechnology.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <4cf5f463-dccd-4637-b7ce-e8d8eac044b7@lechnology.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/22/24 1:25 PM, David Lechner wrote:
> On 4/18/24 5:14 PM, Judith Mendez wrote:
>> Update eQEP binding for TI K3 devices.
> 
> 
> It would make more sense to have this patch first in the series
> before the dts changes.

Got it.

> 
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   Documentation/devicetree/bindings/counter/ti-eqep.yaml | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> index 85f1ff83afe72..11755074c8a91 100644
>> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> @@ -14,19 +14,23 @@ properties:
>>       const: ti,am3352-eqep
>>   
> 
> As Krzysztof hinted, it sounds like we need to add new compatibles
> here and have some -if: statements to account for the differences
> in SoCs rather than making the bindings less strict.

Yes, I see this is the correct action. Thanks.

> 
>>     reg:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>>   
>>     interrupts:
>>       description: The eQEP event interrupt
>>       maxItems: 1
>>   
>>     clocks:
>> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
>> +    description: The clock that determines the clock rate for the eQEP
>>         peripheral.
>>       maxItems: 1
>>   
>>     clock-names:
>> -    const: sysclkout
>> +    maxItems: 1
> 
> In hindsight, this is not the best name. Since we only have one clock
> we don't really need the name anyway, so for the new compatibles, we
> could set clock-names: false.

Ok, will add this to new compatible.

> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>>   
>>   required:
>>     - compatible
> 
> 
> I see that the CFG0 syscon register on AM62x has some control knobs for
> the EQEP so it would be good to add this to the bindings now too to try
> to make the bindings as complete as possible. (I didn't look at other
> chips so the same may apply to others as well.)

Got it (:

~ Judith

> 


