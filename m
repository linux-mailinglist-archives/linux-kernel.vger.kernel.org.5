Return-Path: <linux-kernel+bounces-137942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B389E9DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD6BB21E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FA1A291;
	Wed, 10 Apr 2024 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y1c00JBe"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D543C129;
	Wed, 10 Apr 2024 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727596; cv=none; b=ASNidDcloHIgiBgTv0S6iwhnVJBvnOahnDPlweo6F1n9oYv2ZLxe6mmpuYORcYdzCVmXY/Ns357T7/dx5S2oatshQnk1/GLSgN5tJfkGOw9dB4C/6Cin5BQlEVl20a1A0mFgUfIHO477ewE8n+Xn8m8rm7vJMnglGezXHkPMK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727596; c=relaxed/simple;
	bh=BVGXHrctY14FefmbEJbY0jPALfNzuU8ck/xUrNnCWq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QrPTliICH5O6lD45wQ9mW4t8y1JtKFcvmF9Rc+V9euxM1aSrnQXYOb3cTiHPwW42PUwX7X0a0IH1UrcnRd+CPwUuGcAVUxuZFMgAHeD30dC4xSoTxECkegZc462uH2FnJEz7WODTCfvZNvo+HjUh4jz+5xSZR/P1IxTv2tmtC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y1c00JBe; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A5dkM4019624;
	Wed, 10 Apr 2024 00:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712727586;
	bh=BvdotQ5Ws/o5+/o9BVQZlOmHojt5wBYvSzhOanYg2eU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=y1c00JBeFWMhUa3LTj1/KmSLFFyoyYlRzEsOX3N6vl4dwPhbMttVI2O+HvEnEFFek
	 uXwYFLvBtIhZYyBt3SVUWqdT6Pb4nn9VYp+TNNI5gKcMI9thrLQP4XXaMI2ThGEYbz
	 rqxaWmIe/PGKNdl8Zio2WI+qzIP7hfUAKSt3smLg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A5dkx8014748
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 00:39:46 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 00:39:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 00:39:46 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A5dg70012620;
	Wed, 10 Apr 2024 00:39:43 -0500
Message-ID: <3b009ce1-e5b3-4696-9c8a-995488a04cc7@ti.com>
Date: Wed, 10 Apr 2024 11:09:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM
 instance
To: "Kumar, Udit" <u-kumar1@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-2-n-francis@ti.com>
 <b76578ca-9e94-43a6-93cf-690e23545529@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <b76578ca-9e94-43a6-93cf-690e23545529@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 10/04/24 10:42, Kumar, Udit wrote:
> Hi Neha
> 
> On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
>> Add the WKUP ESM instance for J721E. It has three instances in total,
>> one in the MAIN domain (main_esm) and two in the MCU-WKUP domain
>> (mcu_esm and wkup_esm).
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> index 4618b697fbc4..b0f41e9829cc 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
>> @@ -689,4 +689,9 @@ mcu_esm: esm@40800000 {
>>           ti,esm-pins = <95>;
>>           bootph-pre-ram;
>>       };
>> +
>> +    wkup_esm: esm@42080000 {
>> +        compatible = "ti,j721e-esm";
>> +        reg = <0x00 0x42080000 0x00 0x1000>;
> 
> I think , only  esm@40800000 should be good for this SOC.
> 
> I am not sure, why you want to add this. If you still want to add this for 
> completeness ,

Yes, I wanted to make sure all ESM modules are present for DTS completeness.
> 
> then two options, I suggest
> 
> 1) If you plan to use this mention bootph-pre-ram and ti,esm-pins
> 

No plans for using it as of now.

J721E ESM interrupt routing is such that the MAIN_ESM interrupt triggers an 
error event in the MCU_ESM (which is correctly set via their node ti,j721e-esm 
glue logic pins). The MCU_ESM and WKUP_ESM both generate the same interrupt 
after. So there is no ti,j721e-esm pin applicable for WKUP_ESM.

> 2) In case , no plan to use this then please mark node as disabled
> 

Yes I will mark this as disabled, I overlooked the fact that leaving this 
enabled would throw "ESM init failed" when DT syncs with U-Boot. Thanks for 
catching!

> 
>> +    };
>>   };

-- 
Thanking You
Neha Malcom Francis

