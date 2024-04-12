Return-Path: <linux-kernel+bounces-141917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519338A2517
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB2B2836F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3828918637;
	Fri, 12 Apr 2024 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IZiDCNPG"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB5D17BCE;
	Fri, 12 Apr 2024 04:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895727; cv=none; b=fJ271P45BAtSUfItqrhmt3wMQjCP3pmk05GTQe6CecsCbgW6ZfEF/YrIQcedNhoUv+rDgd6aBUV3Mb7sFhowcGFPx4r0keglLnu6MYSLDJZniWKjN5ln9Zu/Ve24K5/+RA58eIqsKIf48M1rXLfboi2l99iPo1stm+W36YUOdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895727; c=relaxed/simple;
	bh=gP5LcIf5f6zwt9CFFHTn+3rpUH5B2COOjEncatfqQFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l/k0u/ZSUCZZB8Lv93dwYTE3FAHgSFRR9qtVo794h/RMdsD6gXM1VTN9zNMEPTMa1h1iuvJaN+9nHtpgWvLoFSYAKhnmIMQzE1f1/kJJyrM0vWzgovSKGApymcPCrXBQBhgs6vQy7k5HISo8hkJ0yOAnZN0R3M+OO3iHNvuAWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IZiDCNPG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C4LqrR110576;
	Thu, 11 Apr 2024 23:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712895712;
	bh=nGD2bN17wRnZMsRcdmhnQoilyoPWepFQGNVdEgjLmYs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IZiDCNPGRXfVZKAmwgvy+HWQMADF1YwNU0nmE20GqJB9lH4z/JahoJ9Mx3MA3SV2v
	 OBjzTqAu94ivxygPVdTSg80x2yZm1FoRTAWFEe1eShD+pCSakgV9kI5cMW/UjLO+9Y
	 UrJABkoYRx8bp89TMQ8HF0plaBFMFhq3mPBSEmYE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C4Lqic094399
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:21:52 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 23:21:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 23:21:52 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C4LmQ5079580;
	Thu, 11 Apr 2024 23:21:49 -0500
Message-ID: <3111e684-249e-42f9-9105-f62700fe9959@ti.com>
Date: Fri, 12 Apr 2024 09:51:48 +0530
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

Hi Udit

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

At firmware level, the MAIN R5s are set to split mode.

-- 
Thanking You
Neha Malcom Francis

