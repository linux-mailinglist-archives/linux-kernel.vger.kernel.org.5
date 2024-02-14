Return-Path: <linux-kernel+bounces-65027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B68546E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9500C1F26DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD92171C4;
	Wed, 14 Feb 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UlLsptYk"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6603633;
	Wed, 14 Feb 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905550; cv=none; b=rdCDcXldpfNOawGmXTKZemUV28gTH8NSz6h8xDGbUQvFPyDUHUFndKFu9RCeqPawIe2eCot8AiwPU/j/1dNjsKY3TnJKLHvoR/EqpkIqlYX9IIlSZ/58PQNIkyPuaV4mpVrLPMllBKlHtV3c+aEP5qzoCZyotfSlprSYLGJsaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905550; c=relaxed/simple;
	bh=RLCvrrflZorAq9nAsP+7+IT8f8mOlNWhvnR0sd8IqNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KaLevJIX8wJo76Yzm5tQoKEyZ92DURO8Kn3ftPGrK3n1fYVFKBGRnyuiOV5rJ6MmOY8Q82LchHobkGGDQC+T6L8Yh+9X/50cApk/CYZ9lLH+acSeMpFUl2/w8GBE44uZ12FegMXguUzQViNszPwQKHPwisLeRMDlpHd7V5Q4vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UlLsptYk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EACMC0100217;
	Wed, 14 Feb 2024 04:12:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707905542;
	bh=sYFG4wG96nGDWnLOzQCoY4382ryKOg3IRV8vs+gaUP4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UlLsptYkusp0Iw6B5U+okrlzZPv0qd77+eePI5EYCgppISyDn5mMhoXg2dwzbpI3y
	 TtQ4oMnjx+a3YsqOrgbjYrTohStT63wpMWeYWHYN2ZTDT7PnVuxtgwL0VlGiLNrgLq
	 AiIThphdcrw6CfMId2dwqrnP4lw4SR0xDF9Qgr1U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EACMJX045154
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 04:12:22 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 04:12:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 04:12:21 -0600
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EACIO0011533;
	Wed, 14 Feb 2024 04:12:19 -0600
Message-ID: <a113aa78-82d5-48c8-bfd4-663144936798@ti.com>
Date: Wed, 14 Feb 2024 15:42:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 1/4] arm64: dts: ti: k3-j7200-common-proc-board:
 Modify Pinmux for wkup_uart0 and mcu_uart0
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240212104417.1058993-1-b-kapoor@ti.com>
 <20240212104417.1058993-2-b-kapoor@ti.com>
 <2c1da868-0295-4398-8811-6367c589df52@ti.com>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <2c1da868-0295-4398-8811-6367c589df52@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 14/02/24 12:58 pm, Vignesh Raghavendra wrote:
>
> On 12/02/24 16:14, Bhavya Kapoor wrote:
>> WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies
>> under wkup_pmx2 for J7200. Thus, modify pinmux for both
>> of them.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
>
> This warrants a Fixes: tag. Can you provide one here? I can fix it up
> when merging.
Yes , i agree to that. I will send a v3 with the required changes
>>   .../boot/dts/ti/k3-j7200-common-proc-board.dts  | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 1d8bddcae90e..160580a0584a 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -119,24 +119,25 @@ transceiver3: can-phy3 {
>>   };
>>   
>>   &wkup_pmx0 {
>> +};
>> +
>> +&wkup_pmx2 {
>>   	mcu_uart0_pins_default: mcu-uart0-default-pins {
>>   		pinctrl-single,pins = <
>> -			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
>> -			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
>> -			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
>> -			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
>> +			J721E_WKUP_IOPAD(0x90, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
>> +			J721E_WKUP_IOPAD(0x94, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
>> +			J721E_WKUP_IOPAD(0x8c, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
>> +			J721E_WKUP_IOPAD(0x88, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
>>   		>;
>>   	};
>>   
>>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
>>   		pinctrl-single,pins = <
>> -			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
>> -			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
>> +			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
>> +			J721E_WKUP_IOPAD(0x4c, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
>>   		>;
>>   	};
>> -};
>>   
>> -&wkup_pmx2 {
>>   	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
>>   		pinctrl-single,pins = <
>>   			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */

