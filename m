Return-Path: <linux-kernel+bounces-154074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 591438AD722
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCC51F21AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F101F922;
	Mon, 22 Apr 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AKPYQyhs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDB1CD37;
	Mon, 22 Apr 2024 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823916; cv=none; b=Ynnzu5h75JRnYoaDCRNGCnFNFJNN58l4JKMBLVbFxqD1S9v475/KShrhawi+tYIhhrgdbgA58RI6jmm1Trh4eRn+39WlYy8II0fVV0ddkejhQYHnzCgANNnZFqpT0r57w7gBtCEeRVwQBw9ZSu24csNjEgaV4qxXaALIw2lvLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823916; c=relaxed/simple;
	bh=fMqTg+ALbPPQgs7rTdv6T2nOXcEf/oZ/GuUPUdH41mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QMR3G65t+6Lo7u6MZdGhDCByyTWWQqy/VQhbBRuCByPF/3JVl6NHpiHf/pC2O1S6yj638DblUEKFeHrQt6hU9a7bE3GAX6YzBa/T/dAQS9t+EEqoSE6xp7yvCVHeZqVPGU6u6njVh46wct3Dfpq3dcKG79Loao3pxsHZ6hxcbMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AKPYQyhs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MMB3pb059759;
	Mon, 22 Apr 2024 17:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713823863;
	bh=rSK6kXL1FV2TlEwDfOirLbkw0NX0VcHRLzaNKZMrYeU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AKPYQyhsrAPuShM0E2UAwm8AT5pGqhltDDYtFVeUk7nz8btDa3Z8kbdg+Vtzbbor/
	 wro/NfJySg8OPHW/G/ZSUq07TysXuxGrvnq3JpgVXjsalSE/49sjJwMiyXHtb92bHg
	 YuT4tHPGpOWKVVOf2f4GK7xUhDcZlJz+wsV/l8tQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MMB3YG105447
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 17:11:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 17:11:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 17:11:02 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MMB2w9113725;
	Mon, 22 Apr 2024 17:11:02 -0500
Message-ID: <e58ff9ee-b050-4ad8-a060-dc0e33cc4896@ti.com>
Date: Mon, 22 Apr 2024 17:11:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] dt-bindings: counter: Update TI eQEP binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt
 Gray <william.gray@linaro.org>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <20240418221417.1592787-1-jm@ti.com>
 <20240418221417.1592787-6-jm@ti.com>
 <a0eee08b-17c0-4089-85eb-d645cbcafae3@linaro.org>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <a0eee08b-17c0-4089-85eb-d645cbcafae3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/19/24 8:55 AM, Krzysztof Kozlowski wrote:
> On 19/04/2024 00:14, Judith Mendez wrote:
>> Update eQEP binding for TI K3 devices.
> 
> Here and in subject: everything is an update. Be specific.
> 
> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Will fix, thanks.

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
>>     reg:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
> 
> Why? This must be constrained. Devices either have 1 or 2, no both at
> the same time.

Will fix for v2.

> 
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
> NAK. That's just wrong, not explained at all either.
> 

The intention was to make the binding a bit more generic, but I see
that is not the correct direction to go, thanks for the feedback.

~ Judith

> 
> Best regards,
> Krzysztof
> 
> 


