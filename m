Return-Path: <linux-kernel+bounces-162171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2EC8B5709
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BD1F21227
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D84CE11;
	Mon, 29 Apr 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+pwZsOl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E684B5DA;
	Mon, 29 Apr 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391185; cv=none; b=us9e3mm9IAOzcpGqJ+R/o06LfZN3gBFondXF/tvyz4lmvuc4RewbpTQebRIABYYAxn4XIIjXKs2Ad65DS2tDI6fmBUKZZXoc8XKv/ASrWHWqrMD0L6rtpMzFIM7TLSddoyCRg0XR/uAthYzpTuZB5X4LzkRHOo6zoEBo7ar9EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391185; c=relaxed/simple;
	bh=NQ5SGdqdAmQZOScQ9Q82ZKMV6DbrbkLXg5mjOjzV6oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Phw0VG7GGOscOAQ78zaX/CLbTd8NKlnj3MGc3WX+rOOF7tF+2Cvw6oIeQXQM5UnyYSRLSAkIFnyTzlbKEESME6wxFSCi+EyCyHSD/NwyDku83uyqxV10FYtGy9C1Zo3Yrt9SBmNgUxO/nmaCvBYg3pNZezwApZ3gbOAefIAjs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i+pwZsOl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TBkEEF017873;
	Mon, 29 Apr 2024 06:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714391174;
	bh=UUwDz8JS3bdRJRihPsNX0v5/LIsDiQOiM2qFVEyewPQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=i+pwZsOlZ4Q7cMcilY808cuUxzTlatVMoZJuZ7dTtyKd8cbQWtLqOioY2s+ptY1Xk
	 3qS+rhj8QbQUXflNiQTrB5trQErFdCnCssqOR0ElDUL7xIlxBSlbS0xCVQqwk1lty8
	 83FojerqmkdJlZWDeXrTU6aRxE5jgnwbTKV59ueQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TBkE1u124387
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 06:46:14 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 06:46:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 06:46:14 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TBkAom098182;
	Mon, 29 Apr 2024 06:46:11 -0500
Message-ID: <f406bac9-f4c1-4289-8239-82420cd300b8@ti.com>
Date: Mon, 29 Apr 2024 17:16:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] arm64: dts: ti: k3-j784s4: Add overlay for dual
 port USXGMII mode
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
References: <20240329053130.2822129-1-c-vankar@ti.com>
 <20240329053130.2822129-6-c-vankar@ti.com>
 <1cf7f439-45cc-42cb-b707-4c87c00015ac@linaro.org>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <1cf7f439-45cc-42cb-b707-4c87c00015ac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/04/24 16:01, Krzysztof Kozlowski wrote:
> On 29/03/2024 06:31, Chintan Vankar wrote:
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
>>
>> The CPSW9G instance of the CPSW Ethernet Switch supports USXGMII mode
>> with MAC Ports 1 and 2 of the instance, which are connected to ENET
>> Expansion 1 and ENET Expansion 2 slots on the EVM respectively, through
>> the Serdes2 instance of the SERDES.
>>
>> Enable CPSW9G MAC Ports 1 and 2 in fixed-link configuration USXGMII mode
>> at 5 Gbps each.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v5:
>> https://lore.kernel.org/r/20240314072129.1520475-6-c-vankar@ti.com/
>>
>> Changes from v5 to v6:
>> - Updated order of properties in Device Nodes based on
>>    https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
>>
>>   arch/arm64/boot/dts/ti/Makefile               |  6 +-
>>   .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   | 81 +++++++++++++++++++
>>   2 files changed, 86 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index f8e47278df43..2d798ef415e4 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
>> +dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
>>   
>>   # Build time test only, enabled by CONFIG_OF_ALL_DTBS
>>   k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
>> @@ -148,6 +149,8 @@ k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
>>   	k3-j721s2-evm-pcie1-ep.dtbo
>>   k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
>>   	k3-j784s4-evm-quad-port-eth-exp1.dtbo
>> +k3-j784s4-evm-usxgmii-exp1-exp2.dtbs := k3-j784s4-evm.dtb \
>> +	k3-j784s4-evm-usxgmii-exp1-exp2.dtbo\
> 
> I have doubts this commit was ever built. It clearly fails, just like
> now linux-next fails.
> 

Apologies for the syntax error here, I will fix it and post next
version.

> Best regards,
> Krzysztof
> 

