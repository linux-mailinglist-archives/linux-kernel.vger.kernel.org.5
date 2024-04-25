Return-Path: <linux-kernel+bounces-158523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A38B21A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9229287782
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1CF12D1F4;
	Thu, 25 Apr 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TFeNhrep"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90EE1E49F;
	Thu, 25 Apr 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048219; cv=none; b=pTIoIdwgZuUP2uzLq9t1PMGZGW1KE+LmmEQDHo9CZx3QVvShzpM1RKEskw1mkHd5nr2cEqv7/jj/6rmupSCy+cw9nl95OMPl2vhEDZV+Eu5vdp9V7EnK9KikaTX9iWrFhiYPLHc6dkPd7Fn4iqIe/DTNnYIrC2vNaVLpRa4238s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048219; c=relaxed/simple;
	bh=wGkdtvWsaHvy4ymo30Wd5phw/uUJKWlc9GxyzuB9M2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hhgn367TwOcngUcrNHvD3fjczhfsIdaLP7xwZYddDNJv31rdKaEQqMZdb7FiuGlIx7Me/NVLi4PkbL60Olz240u6NeqC0M/ojKOJkQ+ViAhT89MjsZAIKOgoNp9LZMGeQXZW38JSgGbV1UIT4eVpE3vJs/4ttCgMWkjG79aqmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TFeNhrep; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PCUBsw024236;
	Thu, 25 Apr 2024 07:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714048211;
	bh=fMTgnEMfaWX/vbY2QFUgxcKyoi2JE050xcMTWtHcFt8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TFeNhrepNNHQdJnmTFS6cfWHkPnA/Z+FW8eeoI4VjcallbnDMRosREwn2B9FUPEEN
	 2bbEESQpDMbTEIlR/WYPzE/6rl9N/1yG+DGHsBkVwr+Niixw/ohlXh85HJn30vnlDP
	 Fa5azfThSZEwjnl2JUagI7satdOB0X+aYPoTDxjc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PCUBsP048723
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 07:30:11 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:30:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:30:11 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PCU7qk097494;
	Thu, 25 Apr 2024 07:30:08 -0500
Message-ID: <c13ac165-7cbd-4e53-914e-8c6bc28250e3@ti.com>
Date: Thu, 25 Apr 2024 18:00:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Add bootph-all property in
 phy_gmii_sel node
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240425095448.1946293-1-c-vankar@ti.com>
 <20240425115535.t6bpcfhddacqfrbr@during>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240425115535.t6bpcfhddacqfrbr@during>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 25/04/24 17:25, Nishanth Menon wrote:
> On 15:24-20240425, Chintan Vankar wrote:
>> Add missing bootph-all property for CPSW MAC's PHY node
>> phy_gmii_sel.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> This patch is based on linux-next tagged next-20240424.
>>
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index e9cffca073ef..7a6f7cdc4cbe 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -52,6 +52,7 @@ phy_gmii_sel: phy@4044 {
>>   			compatible = "ti,am654-phy-gmii-sel";
>>   			reg = <0x4044 0x8>;
>>   			#phy-cells = <1>;
>> +			bootph-all;
> 
> Do not do this at SoC level for peripherals that may or maynot be used
> at various boards.
> 

Okay. I will move it to "k3-am625-sk.dts".

>>   		};
>>   
>>   		epwm_tbclk: clock-controller@4130 {
>> -- 
>> 2.34.1
>>
> 

