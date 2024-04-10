Return-Path: <linux-kernel+bounces-137946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F2089EA14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E121C220AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACF1CAA9;
	Wed, 10 Apr 2024 05:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mSF6LNcr"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C18C129;
	Wed, 10 Apr 2024 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728220; cv=none; b=KeXLSpJlNX+VXGOtIX+BipIjqtwJqdIjipowMpbYKXYeFka9hmrLCibufJD3bv/VUGVZd/eWgm1OfYyR3SFbBW0l9H4rjQusHT6IesEg2gE2mtWySh52U7rLsDyEJWgcdSs06zmBNYHHVp4sxAXIfrm8vZy8mfwD/Jw1aEEkMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728220; c=relaxed/simple;
	bh=mE3wdc1DOkb50uwVNeVO674CYQlqQLZ0mb5S9QHj+Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U9hJm+H0nVjUqD/eOLOTrHHZIaPTGU+kl0gsA5GoOKoiw14lc1M+m+3XNAGDpaI8GcGiC6HHSKnk6uMWBlT97INoV55uRWXkg92Q0+XnLWmtlZBcfIXLoqVV6NJsi9cpzM8pIzxkfi1kmp+PfYilIKT4AeOSBMXQGaQq6ClNl1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mSF6LNcr; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A5oCUd021652;
	Wed, 10 Apr 2024 00:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712728212;
	bh=oZkn8d2j4nmaOqVBuP3zIFxdTKj6xmAUtvy/+QTiZVk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mSF6LNcryQUBdCoVJuAb6B60dLEdTdu1QcHNgoaZ7k6skrKkH/p3UV/DVagVvJSR8
	 0ikBd7/LT6sGz/HTCUrB/wMYawFGvO2Mm6PzL4baQONt7jRaqk9V6YAWMuH44y/Ebl
	 +hoX6KgZlak/a1tM6hNTNBj+DhKWJDk1iLRQ25bw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A5oC7v005475
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 00:50:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 00:50:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 00:50:11 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A5o8YX031933;
	Wed, 10 Apr 2024 00:50:09 -0500
Message-ID: <6eae9461-53aa-4d37-9829-3f8176c328bb@ti.com>
Date: Wed, 10 Apr 2024 11:20:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-j721e-main: Add the MAIN domain
 watchdog instances
To: "Kumar, Udit" <u-kumar1@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-4-n-francis@ti.com>
 <a329fc6b-561c-4300-8778-c90ca97b70f3@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <a329fc6b-561c-4300-8778-c90ca97b70f3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 10/04/24 11:06, Kumar, Udit wrote:
> Hi Neha
> 
> On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
>> There are 10 watchdog instances in the MAIN domain:
>>     * one each for the 2 A72 cores
>>     * one for the GPU core
>>     * one for the C7x core
>>     * one each for the 2 C66x cores
>>     * one each for the 4 R5F cores
>>
>> Currently, the devicetree only describes watchdog instances for the A72
>> cores and enables them. Describe the remaining but reserve them as they
>> will be used by their respective firmware.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 93 +++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index c7eafbc862f9..d8930b8ea8ec 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -2157,6 +2157,99 @@ watchdog1: watchdog@2210000 {
>>           assigned-clock-parents = <&k3_clks 253 5>;
>>       };
> 
> Looking at TRM, SPRUIJ7*3–December 2018–Revised March 2019,
> 
> Table 12-22646. RTI Instances, says There is gap in numbering
> 
> RTI0, RTI1, RTI15 and so on
> 
> IMO, labels for watchdog should be as per TRM.
> 
> eg watchdog2 to watchdog15, But I don't have strong opinion on either .
> 
> Let maintainer suggest on this
> 

Yes, perhaps sticking to the TRM numbering with gaps will improve readability. I 
can change that in next version if no objections.
> 
> 
>> +    /*
>> +     * The following RTI instances are coupled with MCU R5Fs, c7x and
>> +     * GPU so keeping them reserved as these will be used by their
>> +     * respective firmware
>> +     */
>> +    watchdog2: watchdog@22f0000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x22f0000 0x00 0x100>;
>> +        clocks = <&k3_clks 257 1>;
>> +        power-domains = <&k3_pds 257 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 257 1>;
>> +        assigned-clock-parents = <&k3_clks 257 5>;
>> +        /* reserved for GPU */
>> +        status = "reserved";
>> +    };
> 
> Please help me to understand, where from you got it for GPU,
> 
> May be I am looking at wrong data, Again above TRM
> 
> Table 12-22645. RTI Hardware Requests. RTI-15 says esm0
> 

The table you are looking at mentions where the interrupt from the watchdog is 
routed to.

In the TRM, in sub-section 12.10.2 Windowed Watchdog Timer (WWDT) > 12.19.2.1 
RTI Overview; it is mentioned that RTI15 is dedicated to the GPU.


>> +
>> +    watchdog3: watchdog@2300000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x2300000 0x00 0x100>;
>> +        clocks = <&k3_clks 256 1>;
>> +        power-domains = <&k3_pds 256 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 256 1>;
>> +        assigned-clock-parents = <&k3_clks 256 5>;
>> +        /* reserved for C7X */
>> +        status = "reserved";
> 
> This I see in above table for Compute Cluster
> 
> 
>> +    };
>> +
>> +    watchdog4: watchdog@2380000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x2380000 0x00 0x100>;
>> +        clocks = <&k3_clks 254 1>;
>> +        power-domains = <&k3_pds 254 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 254 1>;
>> +        assigned-clock-parents = <&k3_clks 254 5>;
>> +        /* reserved for C66X_0 */
>> +        status = "reserved";
>> +    };
>> +
>> +    watchdog5: watchdog@2390000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x2390000 0x00 0x100>;
>> +        clocks = <&k3_clks 255 1>;
>> +        power-domains = <&k3_pds 255 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 255 1>;
>> +        assigned-clock-parents = <&k3_clks 255 5>;
>> +        /* reserved for C66X_1 */
>> +        status = "reserved";
>> +    };
>> +
>> +    watchdog6: watchdog@23c0000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x23c0000 0x00 0x100>;
>> +        clocks = <&k3_clks 258 1>;
>> +        power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 258 1>;
>> +        assigned-clock-parents = <&k3_clks 258 5>;
>> +        /* reserved for MAIN_R5F0_0 */
> 
> TRM says, this covers both MAIN_R5F0_0 and MAIN_R5F0_1.
> 
> Suggest , if split is done at fw level
> 
>> +        status = "reserved";
>> +    };
>> +
>> +    watchdog7: watchdog@23d0000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x23d0000 0x00 0x100>;
>> +        clocks = <&k3_clks 259 1>;
>> +        power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 259 1>;
>> +        assigned-clock-parents = <&k3_clks 259 5>;
>> +        /* reserved for MAIN_R5F0_1 */
>> +        status = "reserved";
> 
> TRM says, this covers both MAIN_R5F0_0 and MAIN_R5F0_1.
> 
> Suggest , if split is done at fw level

I didn't quite understand, these watchdogs are mentioned only for DTS 
completeness sake.
> 
>> +    };
>> +
>> +    watchdog8: watchdog@23e0000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x23e0000 0x00 0x100>;
>> +        clocks = <&k3_clks 260 1>;
>> +        power-domains = <&k3_pds 260 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 260 1>;
>> +        assigned-clock-parents = <&k3_clks 260 5>;
>> +        /* reserved for MAIN_R5F1_0 */
>> +        status = "reserved";
>> +    };
> 
> 
> TRM says, this covers both MAIN_R5F1_0 and MAIN_R5F1_1.
> 
> Suggest , if split is done at fw level
> 
>> +
>> +    watchdog9: watchdog@23f0000 {
>> +        compatible = "ti,j7-rti-wdt";
>> +        reg = <0x00 0x23f0000 0x00 0x100>;
>> +        clocks = <&k3_clks 261 1>;
>> +        power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
>> +        assigned-clocks = <&k3_clks 261 1>;
>> +        assigned-clock-parents = <&k3_clks 261 5>;
>> +        /* reserved for MAIN_R5F1_1 */
> 
> TRM says, this covers both MAIN_R5F1_0 and MAIN_R5F1_1.
> 
> Suggest , if split is done at fw level
> 
>> +        status = "reserved";
>> +    };
>> +
>>       main_r5fss0: r5fss@5c00000 {
>>           compatible = "ti,j721e-r5fss";
>>           ti,cluster-mode = <1>;

-- 
Thanking You
Neha Malcom Francis

