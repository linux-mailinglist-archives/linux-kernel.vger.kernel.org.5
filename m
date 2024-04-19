Return-Path: <linux-kernel+bounces-151240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2368AAB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BFBB2224C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08EB7BAEE;
	Fri, 19 Apr 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NuWIeyog"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7442AAF;
	Fri, 19 Apr 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519681; cv=none; b=dmMlNaONNQkCYst7+Rh9vJFoaSbS+o8+1fxUOITdQJuPA+RiMEu0ltiOLRBSYuI3fmk9yBlKffmF666QSTZaJmNfeY4u4Zf8pLf/gNEHuhewTNRMNWQe8wGfj5aFFVBPg09kouOhDNaa8yedeyoGw3GRkmRdLObspkCJNVCS9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519681; c=relaxed/simple;
	bh=BqLh51iZfzKjJwxshA2ena596WdsSjA7IqCowsvvULc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JT8janlFlRNlzW/Fs65/8uP7IzEcFxORw4Uj2nHfs+lKwdzv9M5XZ1HSaOk/vr+9iuF6TJnjQnNnKb31OB1I7ZEXAgZjKYZTMeB7v9bdp2ZIiD79o9CO2MKCMskGIpA08LcLudBnloX1+koXT/mAQIK0kOrqb+hq6ymxD4EUxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NuWIeyog; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J9fAUb032127;
	Fri, 19 Apr 2024 04:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713519670;
	bh=atVafkvYDqVFc5Tb4wCxnaZOhDv+uug6Mn9lQ8yUcEo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NuWIeyogGfzqX38NefmDj+P+BAu1KP4kN4kUewfD18f+lq3Vrn9mb26khp4t5YDgV
	 UnarsUVJi7vkCqLVB6sUAyCD+Fa50ulwYwTqZry10Akqd2YTiutVsGg4u805fYmvnZ
	 i9HGN7ejptF2KZ62soYd3fOy1WtUt1Mhtb7YMLOw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J9fA0m015180
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 04:41:10 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 04:41:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 04:41:10 -0500
Received: from [172.24.31.60] (lt5cd2489kgj.dhcp.ti.com [172.24.31.60])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J9f6GE057654;
	Fri, 19 Apr 2024 04:41:07 -0500
Message-ID: <8ce03ffe-6440-432c-9bed-77e3a01ae150@ti.com>
Date: Fri, 19 Apr 2024 15:11:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add support for multiple
 CAN instances
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
References: <20240411201747.18697-1-b-kapoor@ti.com>
 <85ea2b33-05ac-400f-8017-5539d21ebe32@ti.com>
 <8d9a6dc7-7590-412d-aa81-18a6cf5d09ca@ti.com>
 <9c7f0e3d-4558-4a73-bbb1-ceb7ebe02cd9@ti.com>
 <e9e3ac5d-a048-4058-a5a1-205ded24cb8d@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <e9e3ac5d-a048-4058-a5a1-205ded24cb8d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 4/19/2024 2:49 PM, Bhavya Kapoor wrote:
> On 16/04/24 15:24, Kumar, Udit wrote:
>> Hello Bhavya
>>
>> On 4/16/2024 2:52 PM, Bhavya Kapoor wrote:
>>> On 15/04/24 10:42, Kumar, Udit wrote:
>>>> Hello Bhavya,
>>>>
>>>> On 4/12/2024 1:47 AM, Bhavya Kapoor wrote:
>>>>> CAN instances 0 and 1 in the mcu domain and 16 in the main domain are
>>>>> brought on the evm through headers J42, J43 and J46 respectively. Thus,
>>>>> add their respective transceiver's 0, 1 and 2 dt nodes to add support
>>>>> for these CAN instances.
>>>> Looking at schematic and board data sheet, it appears, board has 6 CAN interfaces.
>>>>
>>>> [J41--J46],  but we are enabling only 4.
>>>>
>>>> I understand, other interfaces might be used for other purpose.
>>>>
>>>> Vignesh/Nishanth,
>>>>
>>>> Do you think, this make sense to code all available interfaces on board and
>>>>
>>>> mark as reserved, if used for other purpose , similar to what is done for wkup_uart for this board.
>>>>
>>> Hi Udit, there is a mux that is used between audio and the signal lines of other 2 cans.
>>>
>>> If we turn on the other 2 cans or even mark  them as reserved, we will still have to
>>>
>>> alter the mux sel lines which will impact the audio.
>>
>> How it will impact ?
>>
>> Audio and CAN lines goes to 1B port of mux .
>>
>> IMO, even CAN or Audio does mux select they are going to select same port no ?
>>
>> I refer U58 and U50 MUX of schematic, Hope we are on same page
>>
>>
> Hi Udit, Thanks for the clarity on muxes number otherwise we would have been in a lot of confusion
> I was referring to muxes U112 and U108.
> After U58 and UU50 , the signal will pass to U112 and U108 and in these 2 Muxes,
>
> we will either have to select _B1 or _B2 ie from audio or the can signals. And, we
>
> are going for audio signals.


Then my suggestion will be to have this mux in your series and mark as 
reserved.

When audio will come, audio can enable this mux as needed.

>
> Regards
>
>>> Thanks.
>>>
>>> ~B-Kapoor
>>>
>>>>> CAN instance 4 in the main domain is brought on the evm through header
>>>>> J45. The CAN High and Low lines from the SoC are routed through a mux
>>>>> on the evm. The select lines need to be set for the CAN signals to
>>>>> reach to its transceiver on the evm. Therefore, add transceiver 3
>>>>> dt node to add support for this CAN instance.
>>>>>
>>>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>>>> ---
>>>>>
>>>>> rebased to next-20240411
>>>>>
>>>>>     arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 107 +++++++++++++++++++++++
>>>>>     1 file changed, 107 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>>>> index 81fd7afac8c5..e56901973895 100644
>>>>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>>>>> @@ -272,6 +272,45 @@ dp0_connector_in: endpoint {
>>>>>                 };
>>>>>             };
>>>>>         };
>>>>> +
>>>>> +    transceiver0: can-phy0 {
>>>>> +        compatible = "ti,tcan1042";
>>>>> +        #phy-cells = <0>;
>>>>> +        max-bitrate = <5000000>;
>>>>> +        pinctrl-names = "default";
>>>>> +        pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
>>>>> +        standby-gpios = <&wkup_gpio0 69 GPIO_ACTIVE_HIGH>;
>>>>> +    };
>>>>> +
>>>>> +    transceiver1: can-phy1 {
>>>>> +        compatible = "ti,tcan1042";
>>>>> +        #phy-cells = <0>;
>>>>> +        max-bitrate = <5000000>;
>>>>> +        pinctrl-names = "default";
>>>>> +        pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
>>>>> +        standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
>>>>> +    };
>>>>> +
>>>>> +    transceiver2: can-phy2 {
>>>>> +        /* standby pin has been grounded by default */
>>>>> +        compatible = "ti,tcan1042";
>>>>> +        #phy-cells = <0>;
>>>>> +        max-bitrate = <5000000>;
>>>>> +    };
>>>>> +
>>>>> +    transceiver3: can-phy3 {
>>>>> +        compatible = "ti,tcan1042";
>>>>> +        #phy-cells = <0>;
>>>>> +        max-bitrate = <5000000>;
>>>>> +        standby-gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
>>>>> +        mux-states = <&mux1 1>;
>>>>> +    };
>>>>> +
>>>>> +    mux1: mux-controller {
>>>>> +        compatible = "gpio-mux";
>>>>> +        #mux-state-cells = <1>;
>>>>> +        mux-gpios = <&exp2 14 GPIO_ACTIVE_HIGH>;
>>>> Could you help here on logic to choose pin 14
>>>>
>>>> As I see for this mux
>>>>
>>>> S0 is CANUART_MUX_SEL0 [Pin 14, which you want to control as high]
>>>>
>>>> S1 is Pin 15 is "CANUART_MUX2_SEL1"
>>>>
>>>> S2 is high
>>>>
>>>> So in order to get CAN on mux output
>>>>
>>>> All, S0, S1 and S2 should be high.
>>>>
>>>> IMO, you should control both S0 and S1, or just S1 and S0 with dip switch
>>> Hi Udit, S0 comes at a default Active High State always. Thus, i have kept it the same.
>>>
>>> This was done in the same way as it was done for mux2 for  j721s2. mcan 5
>>>
>>> Thanks
>> May be i was not clear in my previous comment
>>
>> Looking at schematic
>>
>> S0 is CANUART_MUX_SEL0 , which is connected with DIP switch and IO expander U173
>>
>> S1 is CANUART_MUX2_SEL1, which is connected only IO with expander U173
>>
>> S2 is CANUART_MUX_SEL2 is pulled high by hardware itself .
>>
>> Here all lines high are needed to route CAN correctly out from mux.
>>
>> So this patch is controlling CANUART_MUX_SEL0 but not controlling CANUART_MUX2_SEL1.
>>
>> IMO, CANUART_MUX_SEL0 can be controlled by dip switch and CANUART_MUX2_SEL1 should be controlled by driver.
> Hi Udit, thanks for conveying this in a much more explained way.
>
> What i am trying to say that in the  default state as well we are getting s1 signal as high itself.
>
> So, if you  want that we should specifically add gpio for that in dts, we can also go ahead with that.


Just control (S1 which is CANUART_MUX2_SEL1) by your dts files

>
> Regards
>
> ~B-Kapoor
>
>>
>>>>> +    };
>>>>>     };
>>>>>       &wkup_gpio0 {
>>>>> @@ -336,6 +375,20 @@ J784S4_IOPAD(0x014, PIN_INPUT_PULLUP, 8) /* (AG33) MCAN14_TX.I2C4_SCL */
>>>>>                 J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
>>>>>             >;
>>>>>         };
>>>>> +
>>>>> +    main_mcan4_pins_default: main-mcan4-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            J784S4_IOPAD(0x088, PIN_INPUT, 0) /* (AF36) MCAN4_RX */
>>>>> +            J784S4_IOPAD(0x084, PIN_OUTPUT, 0) /* (AG38) MCAN4_TX */
>>>>> +        >;
>>>>> +    };
>>>>> +
>>>>> +    main_mcan16_pins_default: main-mcan16-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            J784S4_IOPAD(0x028, PIN_INPUT, 0) /* (AE33) MCAN16_RX */
>>>>> +            J784S4_IOPAD(0x024, PIN_OUTPUT, 0) /* (AH34) MCAN16_TX */
>>>>> +        >;
>>>>> +    };
>>>>>     };
>>>>>       &wkup_pmx2 {
>>>>> @@ -415,6 +468,32 @@ J784S4_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
>>>>>                 J784S4_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
>>>>>             >;
>>>>>         };
>>>>> +
>>>>> +    mcu_mcan0_pins_default: mcu-mcan0-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            J784S4_WKUP_IOPAD(0x050, PIN_OUTPUT, 0) /* (K33) MCU_MCAN0_TX */
>>>>> +            J784S4_WKUP_IOPAD(0x054, PIN_INPUT, 0) /* (F38) MCU_MCAN0_RX */
>>>>> +        >;
>>>>> +    };
>>>>> +
>>>>> +    mcu_mcan1_pins_default: mcu-mcan1-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (H35) WKUP_GPIO0_4.MCU_MCAN1_TX */
>>>>> +            J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (K36) WKUP_GPIO0_5.MCU_MCAN1_RX */
>>>>> +        >;
>>>>> +    };
>>>>> +
>>>>> +    mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            J784S4_WKUP_IOPAD(0x040, PIN_INPUT, 7) /* (J38) MCU_SPI0_D1.WKUP_GPIO0_69 */
>>>>> +        >;
>>>>> +    };
>>>>> +
>>>>> +    mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-default-pins {
>>>>> +        pinctrl-single,pins = <
>>>>> +            J784S4_WKUP_IOPAD(0x060, PIN_INPUT, 7) /* (J35) WKUP_GPIO0_2 */
>>>>> +        >;
>>>>> +    };
>>>>>     };
>>>>>       &wkup_pmx1 {
>>>>> @@ -1105,3 +1184,31 @@ dp0_out: endpoint {
>>>>>             };
>>>>>         };
>>>>>     };
>>>>> +
>>>>> +&mcu_mcan0 {
>>>>> +    status = "okay";
>>>>> +    pinctrl-names = "default";
>>>>> +    pinctrl-0 = <&mcu_mcan0_pins_default>;
>>>>> +    phys = <&transceiver0>;
>>>>> +};
>>>>> +
>>>>> +&mcu_mcan1 {
>>>>> +    status = "okay";
>>>>> +    pinctrl-names = "default";
>>>>> +    pinctrl-0 = <&mcu_mcan1_pins_default>;
>>>>> +    phys = <&transceiver1>;
>>>>> +};
>>>>> +
>>>>> +&main_mcan16 {
>>>>> +    status = "okay";
>>>>> +    pinctrl-names = "default";
>>>>> +    pinctrl-0 = <&main_mcan16_pins_default>;
>>>>> +    phys = <&transceiver2>;
>>>>> +};
>>>>> +
>>>>> +&main_mcan4 {
>>>>> +    status = "okay";
>>>>> +    pinctrl-names = "default";
>>>>> +    pinctrl-0 = <&main_mcan4_pins_default>;
>>>>> +    phys = <&transceiver3>;
>>>>> +};

