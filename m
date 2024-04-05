Return-Path: <linux-kernel+bounces-133024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3E8899DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DF11C22D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F716D322;
	Fri,  5 Apr 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="quVeVfye"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3A16C865;
	Fri,  5 Apr 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321765; cv=none; b=Gcyhn6HZlCEyAyFkUcV2Zc+DiCuT9nrH0sgbccrBk6lcN0Qc0JuW/NYHrW/V1vsJJ+Rv9lNYvB8pMnzGyrAHGdBUtmdLG6ZSWa9HBAns0Mk6Ytkagwz8ucRxUCQaZeU9rpvwBnZ0cdYLMeH4ZlIvDaQNei1iNXkDgXDlu0SCVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321765; c=relaxed/simple;
	bh=Jt7XdZcky85qUvtj0r+UUgcnr1CXhmm50Fbe7A6YBL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oMgwwrWuayASyY+wZMxjH6zd2IoW9uE8KMw2uGOUwonJE4scE+oOABz1y2w8NTczyYyeElrY2k0PH2ecjHZYFFWjQfer8JBV7DKJ5nr3OdilvNPIBOadezUvViTGyuQR2n3m+D6Ve2cHmAXkYDXp6eSAwo8A03Wy3NGD1a5eBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=quVeVfye; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4359k059006253;
	Fri, 5 Apr 2024 14:55:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=u9U4WwRzJom55b4PN6C3BKumZRjKpy21ICeFTyNM43U=; b=qu
	VeVfyeceGvHaxQgU5Lb1nnhXiC+JKizmuSxZGN+7Oz3AvM4P+tmgO9pE/PFiKWhi
	E2iPNoZ5hWNtGJJR6blWxmcjyFkj7tKrKJ54OCmKwxgXvGftf8XdhpJY7VFcdlZI
	r6+TPhDvcA6kpPSKhFK3jn5zoAjgRMjxqdzJ8ibXlJ1Ht+nWWMhGeyuF8f2PwXoU
	ZBG+UYqERY5t+JzLsi5SVOJyf+C0K/Pr4ZUWXc293IPBKcRgt+RkPT5WHWdHJRkb
	4FcSft5mRe5x9qD/lK26dwQ2P/3wmhj1owvpGFRMl8v3NpZLNpaLY4PQp1dw3pb2
	93JhR8jYvTIQwr66vLGQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9empqj14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:55:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D581D4002D;
	Fri,  5 Apr 2024 14:55:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 15CA521682F;
	Fri,  5 Apr 2024 14:54:33 +0200 (CEST)
Received: from [10.252.8.38] (10.252.8.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 14:54:31 +0200
Message-ID: <2b9bf652-fc8e-4c9a-9761-ce42ad6e8316@foss.st.com>
Date: Fri, 5 Apr 2024 14:54:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v9 2/4] dt-bindings: stm32: update DT bingding for
 stm32mp25
To: Rob Herring <robh@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240402125312.277052-1-gabriel.fernandez@foss.st.com>
 <20240402125312.277052-3-gabriel.fernandez@foss.st.com>
 <20240404135201.GA2320777-robh@kernel.org>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <20240404135201.GA2320777-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-05_01,2023-05-22_02


On 4/4/24 15:52, Rob Herring wrote:
> On Tue, Apr 02, 2024 at 02:53:10PM +0200, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Now RCC driver use '.index' of clk_parent_data struct to define a parent.
>> The majority of parents are SCMI clocks, then dt-bindings must be fixed.
> This is an ABI change. Please make that clear and justify why that is
> okay. Changing a driver is not a valid reason. What about other drivers
> besides Linux?

As the SoC STM32MP25X is not yet official and it is not available

outside STMicroelectronics, it is not a issue to have ABI change
and I will upstream the driver in other component (TF-A, U-Boot
and OP-TEE) when binding and driver will be accepted and merged
in Linux repository to avoid binding divergence.

Today no other STM32MP25 RCC drivers are yet upstreamed.

Best Regards,

Gabriel

>> Fixes: b5be49db3d47 ("dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform")
>>
> Should not have a blank line here.
ok
>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
> Please put version history for a patch within the patch here.

ok


>
>>   .../bindings/clock/st,stm32mp25-rcc.yaml      | 171 ++++++++++++++++--
>>   1 file changed, 155 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> index 7732e79a42b9..57bd4e7157bd 100644
>> --- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> @@ -38,22 +38,87 @@ properties:
>>         - description: CK_SCMI_MSI Low Power Internal oscillator (~ 4 MHz or ~ 16 MHz)
>>         - description: CK_SCMI_LSE Low Speed External oscillator (32 KHz)
>>         - description: CK_SCMI_LSI Low Speed Internal oscillator (~ 32 KHz)
>> -
>> -  clock-names:
>> -    items:
>> -      - const: hse
>> -      - const: hsi
>> -      - const: msi
>> -      - const: lse
>> -      - const: lsi
>> -
>> +      - description: CK_SCMI_HSE_DIV2 CK_SCMI_HSE divided by 2 (coud be gated)
>> +      - description: CK_SCMI_ICN_HS_MCU High Speed interconnect bus clock
>> +      - description: CK_SCMI_ICN_LS_MCU Low Speed interconnect bus clock
>> +      - description: CK_SCMI_ICN_SDMMC SDMMC interconnect bus clock
>> +      - description: CK_SCMI_ICN_DDR DDR interconnect bus clock
>> +      - description: CK_SCMI_ICN_DISPLAY Display interconnect bus clock
>> +      - description: CK_SCMI_ICN_HSL HSL interconnect bus clock
>> +      - description: CK_SCMI_ICN_NIC NIC interconnect bus clock
>> +      - description: CK_SCMI_ICN_VID Video interconnect bus clock
>> +      - description: CK_SCMI_FLEXGEN_07 flexgen clock 7
>> +      - description: CK_SCMI_FLEXGEN_08 flexgen clock 8
>> +      - description: CK_SCMI_FLEXGEN_09 flexgen clock 9
>> +      - description: CK_SCMI_FLEXGEN_10 flexgen clock 10
>> +      - description: CK_SCMI_FLEXGEN_11 flexgen clock 11
>> +      - description: CK_SCMI_FLEXGEN_12 flexgen clock 12
>> +      - description: CK_SCMI_FLEXGEN_13 flexgen clock 13
>> +      - description: CK_SCMI_FLEXGEN_14 flexgen clock 14
>> +      - description: CK_SCMI_FLEXGEN_15 flexgen clock 15
>> +      - description: CK_SCMI_FLEXGEN_16 flexgen clock 16
>> +      - description: CK_SCMI_FLEXGEN_17 flexgen clock 17
>> +      - description: CK_SCMI_FLEXGEN_18 flexgen clock 18
>> +      - description: CK_SCMI_FLEXGEN_19 flexgen clock 19
>> +      - description: CK_SCMI_FLEXGEN_20 flexgen clock 20
>> +      - description: CK_SCMI_FLEXGEN_21 flexgen clock 21
>> +      - description: CK_SCMI_FLEXGEN_22 flexgen clock 22
>> +      - description: CK_SCMI_FLEXGEN_23 flexgen clock 23
>> +      - description: CK_SCMI_FLEXGEN_24 flexgen clock 24
>> +      - description: CK_SCMI_FLEXGEN_25 flexgen clock 25
>> +      - description: CK_SCMI_FLEXGEN_26 flexgen clock 26
>> +      - description: CK_SCMI_FLEXGEN_27 flexgen clock 27
>> +      - description: CK_SCMI_FLEXGEN_28 flexgen clock 28
>> +      - description: CK_SCMI_FLEXGEN_29 flexgen clock 29
>> +      - description: CK_SCMI_FLEXGEN_30 flexgen clock 30
>> +      - description: CK_SCMI_FLEXGEN_31 flexgen clock 31
>> +      - description: CK_SCMI_FLEXGEN_32 flexgen clock 32
>> +      - description: CK_SCMI_FLEXGEN_33 flexgen clock 33
>> +      - description: CK_SCMI_FLEXGEN_34 flexgen clock 34
>> +      - description: CK_SCMI_FLEXGEN_35 flexgen clock 35
>> +      - description: CK_SCMI_FLEXGEN_36 flexgen clock 36
>> +      - description: CK_SCMI_FLEXGEN_37 flexgen clock 37
>> +      - description: CK_SCMI_FLEXGEN_38 flexgen clock 38
>> +      - description: CK_SCMI_FLEXGEN_39 flexgen clock 39
>> +      - description: CK_SCMI_FLEXGEN_40 flexgen clock 40
>> +      - description: CK_SCMI_FLEXGEN_41 flexgen clock 41
>> +      - description: CK_SCMI_FLEXGEN_42 flexgen clock 42
>> +      - description: CK_SCMI_FLEXGEN_43 flexgen clock 43
>> +      - description: CK_SCMI_FLEXGEN_44 flexgen clock 44
>> +      - description: CK_SCMI_FLEXGEN_45 flexgen clock 45
>> +      - description: CK_SCMI_FLEXGEN_46 flexgen clock 46
>> +      - description: CK_SCMI_FLEXGEN_47 flexgen clock 47
>> +      - description: CK_SCMI_FLEXGEN_48 flexgen clock 48
>> +      - description: CK_SCMI_FLEXGEN_49 flexgen clock 49
>> +      - description: CK_SCMI_FLEXGEN_50 flexgen clock 50
>> +      - description: CK_SCMI_FLEXGEN_51 flexgen clock 51
>> +      - description: CK_SCMI_FLEXGEN_52 flexgen clock 52
>> +      - description: CK_SCMI_FLEXGEN_53 flexgen clock 53
>> +      - description: CK_SCMI_FLEXGEN_54 flexgen clock 54
>> +      - description: CK_SCMI_FLEXGEN_55 flexgen clock 55
>> +      - description: CK_SCMI_FLEXGEN_56 flexgen clock 56
>> +      - description: CK_SCMI_FLEXGEN_57 flexgen clock 57
>> +      - description: CK_SCMI_FLEXGEN_58 flexgen clock 58
>> +      - description: CK_SCMI_FLEXGEN_59 flexgen clock 59
>> +      - description: CK_SCMI_FLEXGEN_60 flexgen clock 60
>> +      - description: CK_SCMI_FLEXGEN_61 flexgen clock 61
>> +      - description: CK_SCMI_FLEXGEN_62 flexgen clock 62
>> +      - description: CK_SCMI_FLEXGEN_63 flexgen clock 63
>> +      - description: CK_SCMI_ICN_APB1 Peripheral bridge 1
>> +      - description: CK_SCMI_ICN_APB2 Peripheral bridge 2
>> +      - description: CK_SCMI_ICN_APB3 Peripheral bridge 3
>> +      - description: CK_SCMI_ICN_APB4 Peripheral bridge 4
>> +      - description: CK_SCMI_ICN_APBDBG Peripheral bridge for degub
>> +      - description: CK_SCMI_TIMG1 Peripheral bridge for timer1
>> +      - description: CK_SCMI_TIMG2 Peripheral bridge for timer2
>> +      - description: CK_SCMI_PLL3 PLL3 clock
>> +      - description: clk_dsi_txbyte DSI byte clock
> Need a blank line here.
>
>>   required:
>>     - compatible
>>     - reg
>>     - '#clock-cells'
>>     - '#reset-cells'
>>     - clocks
>> -  - clock-names
>>   
>>   additionalProperties: false
>>   
>> @@ -66,11 +131,85 @@ examples:
>>           reg = <0x44200000 0x10000>;
>>           #clock-cells = <1>;
>>           #reset-cells = <1>;
>> -        clock-names = "hse", "hsi", "msi", "lse", "lsi";
>> -        clocks = <&scmi_clk CK_SCMI_HSE>,
>> -                 <&scmi_clk CK_SCMI_HSI>,
>> -                 <&scmi_clk CK_SCMI_MSI>,
>> -                 <&scmi_clk CK_SCMI_LSE>,
>> -                 <&scmi_clk CK_SCMI_LSI>;
>> +        clocks =  <&scmi_clk CK_SCMI_HSE>,
>> +                  <&scmi_clk CK_SCMI_HSI>,
>> +                  <&scmi_clk CK_SCMI_MSI>,
>> +                  <&scmi_clk CK_SCMI_LSE>,
>> +                  <&scmi_clk CK_SCMI_LSI>,
>> +                  <&scmi_clk CK_SCMI_HSE_DIV2>,
>> +                  <&scmi_clk CK_SCMI_ICN_HS_MCU>,
>> +                  <&scmi_clk CK_SCMI_ICN_LS_MCU>,
>> +                  <&scmi_clk CK_SCMI_ICN_SDMMC>,
>> +                  <&scmi_clk CK_SCMI_ICN_DDR>,
>> +                  <&scmi_clk CK_SCMI_ICN_DISPLAY>,
>> +                  <&scmi_clk CK_SCMI_ICN_HSL>,
>> +                  <&scmi_clk CK_SCMI_ICN_NIC>,
>> +                  <&scmi_clk CK_SCMI_ICN_VID>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_07>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_08>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_09>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_10>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_11>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_12>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_13>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_14>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_15>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_16>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_17>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_18>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_19>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_20>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_21>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_22>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_23>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_24>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_25>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_26>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_27>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_28>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_29>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_30>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_31>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_32>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_33>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_34>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_35>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_36>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_37>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_38>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_39>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_40>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_41>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_42>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_43>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_44>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_45>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_46>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_47>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_48>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_49>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_50>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_51>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_52>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_53>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_54>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_55>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_56>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_57>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_58>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_59>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_60>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_61>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_62>,
>> +                  <&scmi_clk CK_SCMI_FLEXGEN_63>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB1>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB2>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB3>,
>> +                  <&scmi_clk CK_SCMI_ICN_APB4>,
>> +                  <&scmi_clk CK_SCMI_ICN_APBDBG>,
>> +                  <&scmi_clk CK_SCMI_TIMG1>,
>> +                  <&scmi_clk CK_SCMI_TIMG2>,
>> +                  <&scmi_clk CK_SCMI_PLL3>,
>> +                  <&clk_dsi_txbyte>;
>>       };
>>   ...
>> -- 
>> 2.25.1
>>

