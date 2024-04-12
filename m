Return-Path: <linux-kernel+bounces-143402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D385B8A387D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDA51C220B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C715219A;
	Fri, 12 Apr 2024 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="alAl95UL"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC52F875;
	Fri, 12 Apr 2024 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960112; cv=none; b=AkrH7s9AnuUhqJA9GSvB+Yktcgo4mzuev/M+ekPWR8qPiy/gyBC+daxGkLKJiws3e/umq0IKutD+5pendtvbn0fLZwjUb15PDVzDdOwjlu3PJf7ucKd4FJaXPeo0Wb/MtDQvi4sDNTtr3ELHDUgrQ6KbMC1pgDazAtm86jwA7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960112; c=relaxed/simple;
	bh=ebTMRwxY9j3HcZykWoWmGbwaogRkNcdamLv0+bgMnGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LPwUreYgvzRkYYHW0YC6qELkB2AnBuK7MF8mi4yp/VhjOmK3F4CYZ832KpTa1UNjt4tr0Mr/PN+CceftnjzWWK8Rso6G86MXNSxqlw6RXRFhb8rU4ohSQcHgnwPH7maX4s+1bckgryVD5y8pzhQBjG2TQrnR4PFFxc4WsO3idzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=alAl95UL; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43CMEuBO075658;
	Fri, 12 Apr 2024 17:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712960096;
	bh=PvBz61Heps7ek0t23TECXFmw2hjtwgGpLdFaTr3b168=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=alAl95ULfUiZSRPelw82UonGeoHhk8aIc4jBVFlzjfktkMwLL8UVWKKYQ1w2PxhEb
	 JoEmBznBXlbyPVhhc+IxShMshJnIglZuyhmghjWInt6iD/NGS5K55ghVdtiq1MIhqf
	 S2VZkAF+nyah1wDWtMMF7Ey6qodBvJc47co/Sjps=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43CMEugm113812
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 17:14:56 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 17:14:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 17:14:55 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43CMEtHv033796;
	Fri, 12 Apr 2024 17:14:55 -0500
Message-ID: <9059cfb5-d8fa-4b16-a2a0-14bb08655226@ti.com>
Date: Fri, 12 Apr 2024 17:14:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: ti: k3-j784s4-evm: Remove HS400 mode
 support for eMMC
To: "Kumar, Udit" <u-kumar1@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
 <20240411225257.383889-8-jm@ti.com>
 <f59e7f17-b978-4ff3-86d4-a77191ca66ac@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <f59e7f17-b978-4ff3-86d4-a77191ca66ac@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 4/11/24 11:52 PM, Kumar, Udit wrote:
> Hi Judith
> 
> On 4/12/2024 4:22 AM, Judith Mendez wrote:
>> From: Udit Kumar <u-kumar1@ti.com>
>>
>> The eMMC fails to enumerate intermittently on HS400 mode. Also
>> observing multiple CQE recovery warnings.
>>
>> Update the sdhci0 node to disable HS400.
>>
>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> Cc: Bhavya Kapoor <b-kapoor@ti.com>
>> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> [Judith: Reword commit]
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts 
>> b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index 81fd7afac8c57..04a241a91e6b8 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -791,6 +791,7 @@ &main_sdhci0 {
>>       non-removable;
>>       ti,driver-strength-ohm = <50>;
>>       disable-wp;
>> +    no-mmc-hs400;
> 
> This is just WA to get rid of CQE errors. I prefer to hold this patch 
> under debug from hardware side is not complete.
> 
> Moreover, CQE errors are seen with 32GB variant not with 16GB, So we can 
> not blame controller for this

Will drop, thanks.

~ Judith

> 
> 
>>   };
>>   &main_sdhci1 {


