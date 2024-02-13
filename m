Return-Path: <linux-kernel+bounces-63965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A458536DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743811C227AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C655FBA1;
	Tue, 13 Feb 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UWDbW4DF"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407A5FB9D;
	Tue, 13 Feb 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844144; cv=none; b=uOK7+KYuiz64TwAl6tn4VGrtrXbCh8kzvIe33+stpS/tZYNa8ejYCWkN9y4OsdaMkQa4FTUM6m+U/kirVLXPe6fF5t29Rl3He9EuCFVqkcquPbagZr5EmXseK7tMLlJvlkD6GlzAznOwCSGQG5/dy27gKNFb9YIc3AqI2CJSGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844144; c=relaxed/simple;
	bh=hDjPdXfN+yMLunBnu3HBhRXW2ysCyXYaOInSXjhO410=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MWOnaNgOFEmsUaqH1jBVowCz5baf5GwQ90yRb/EEhN0EAs1JRcI2dyiQj6Ag8u/ExxD2nzcFUMdAAWIANMShWxslWVyLcwX/DpZ2xZYp1IA7JkLoKtCV1qpPzQFzfiLro6g67wvS4Y8HqJfxWq6Aq43v1MXp3nazpOisWxLQ4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UWDbW4DF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DH8nT8035273;
	Tue, 13 Feb 2024 11:08:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707844129;
	bh=OHaBar8sdC9xa0e0bmpA7en2/L+4CDhbSqeyzJZcf/M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UWDbW4DFSaB/Yo4M++aICZeEgnWv4jiCtCkNR6mNq6jUrOvRKRtPH8oUJiVNP+k1Q
	 J4IAuagKeNOYCvQoR7gbP3R4zjxPNSsA5fzzhGyAvxDqb7ItZJ1q26b8mY9H5qkD8l
	 16DYJzxWNFxfvDDZSy9w1M4d3HDRg1TNnEyU2Izo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DH8nEc021131
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 11:08:49 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 11:08:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 11:08:48 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DH8mHf037609;
	Tue, 13 Feb 2024 11:08:48 -0600
Message-ID: <af73545a-1746-4e14-a3f2-772d72e6ff97@ti.com>
Date: Tue, 13 Feb 2024 11:08:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in
 serdes_ln_ctrl
Content-Language: en-US
To: Peter Rosin <peda@axentia.se>, Siddharth Vadapalli <s-vadapalli@ti.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <c-vankar@ti.com>,
        <srk@ti.com>
References: <20240213080348.248916-1-s-vadapalli@ti.com>
 <1be60db1-f292-1074-5898-801380e1fb22@axentia.se>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <1be60db1-f292-1074-5898-801380e1fb22@axentia.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/13/24 3:19 AM, Peter Rosin wrote:
> Hi!
> 
> 2024-02-13 at 09:03, Siddharth Vadapalli wrote:
>> From: Chintan Vankar <c-vankar@ti.com>
>>
>> Change offset in mux-reg-masks property for serdes_ln_ctrl node
>> since reg-mux property is used in compatible.
>>
>> Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> Acked-by: Andrew Davis <afd@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>> Hello,
>>
>> This patch is based on linux-next tagged next-20240213.
>> The v4 of this patch is a part of the series at:
>> https://lore.kernel.org/r/20240131101441.1362409-1-c-vankar@ti.com/
>>
>> Since the v4 series mentioned above has open comments on the other
>> patches in the series, this patch is being posted separately to unblock
>> other dependent series which rely on the fix implemented by this patch.
>>
>> Changes since v4:
>> - Rebased patch on linux-next tagged next-20240213.
>>
>> Regards,
>> Siddharth.
>>
>>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> index 3cb964982792..3b7f0eca977b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
>> @@ -52,12 +52,12 @@ serdes_ln_ctrl: mux-controller@4080 {
>>   			compatible = "reg-mux";
>>   			reg = <0x00004080 0x30>;
>>   			#mux-control-cells = <1>;
>> -			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
>> -					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
>> -					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
>> -					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
>> -					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
>> -					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
>> +			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
>> +					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
>> +					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
>> +					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
>> +					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
>> +					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
>>   			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
>>   				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
>>   				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
> 
> Ouch. I suspect there is a similar problem in
> arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi:
> 
> 
> 	fss: bus@47000000 {
> 		compatible = "simple-bus";
> 		reg = <0x0 0x47000000 0x0 0x100>;
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 		ranges;
> 
> 		hbmc_mux: mux-controller@47000004 {
> 			compatible = "reg-mux";
> 			reg = <0x00 0x47000004 0x00 0x2>;
> 			#mux-control-cells = <1>;
> -			mux-reg-masks = <0x4 0x2>; /* HBMC select */
> +			mux-reg-masks = <0x0 0x2>; /* HBMC select */
> 		};
> 
> Who knows what non-upstreamed devices and devicetrees are affected?
> I guess we need to revert 2765149273f4 ("mux: mmio: use reg property
> when parent device is not a syscon") unless someone sees a sane way
> to fix this.

There are only two in-tree nodes with "reg-mux" with a reg property: the
one this patch fixes, and the hbmc_mux you point out, both in TI devices.
I'd say it is safe to assume we are the only users, and our non-upstreamed
DTs depend on that patch, reverting it would cause more issues for
out-of-tree users than just fixing the two broken nodes above.

Andrew

> 
> Cheers,
> Peter

