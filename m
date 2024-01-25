Return-Path: <linux-kernel+bounces-37980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB783B91F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A131F247AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1818101D4;
	Thu, 25 Jan 2024 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tkSBl/n7"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5EC8FF;
	Thu, 25 Jan 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161653; cv=none; b=ZZe7tEvk90vfHWJD3XbNx0Qq1hzzZd3DKQ6tUO6xxT6valm8Ae6weAByuyjpXWQA1LTLBMSkMmSBkSBl/wB7W1vlDcchVpne5TdCBAKQMRfS9aFaBqcr9O3Wqs2Y2vbjHq7eyNrWpcFiLFSIDoIgtJMJDrSYCHywMzhiQJbOle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161653; c=relaxed/simple;
	bh=gQWtfYbGfOV2oVcNNevVHq51J9XY+vPhOrVMnjb/6q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T1deqzjjbvaT1iFe5VzIUVZxPCH+QEWpBRhBxPIyagE1kcfWhIyj3Lv3lUxr0JZE3gTQaTXvQrWoyc6FST1e3J3IKhMHaU1FSStPodq7cBLHnNEGgYiXzpEdFOJCLtVAlW7FttZfl+uDLo2rQNdSbWO0s48YwYctEEQutISjqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tkSBl/n7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40P5lHdZ002805;
	Wed, 24 Jan 2024 23:47:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706161637;
	bh=XYm18jVRWbK0xPk1IDYRqvQ4AolTdoU+U2rtIDmzOAs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tkSBl/n72J8iF9D82TzBERbnqxFsMd9EkjXnYnThKyglQZkiqfaEookLAEtX7Uxw/
	 sbe5G+LV6wpsyf1EIrgbSXYFDDaB3d9yTW2c+VhG/aFZqh1+qSPYxgJZrq3ous2RE7
	 kcvmcncp7DytXGP5SGB4PLqC+B+2ZIn8X2Kla7iQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40P5lH57043952
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 23:47:17 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 23:47:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 23:47:16 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40P5lCbK094683;
	Wed, 24 Jan 2024 23:47:13 -0600
Message-ID: <2291204f-97d5-4887-b68f-8789fe85f838@ti.com>
Date: Thu, 25 Jan 2024 11:17:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and
 wakeup R5FSS nodes
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20240121134017.374992-1-vaishnav.a@ti.com>
 <0fcec921-0220-4251-afa4-44db5e80d2ef@ti.com>
 <20240124172151.ngxaq6k5tnvsx4jr@proud>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240124172151.ngxaq6k5tnvsx4jr@proud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 24/01/24 22:51, Nishanth Menon wrote:
> On 11:26-20240124, Jayesh Choudhary wrote:
>> Hello Vaishnav,
>>
>> On 21/01/24 19:10, Vaishnav Achath wrote:
>>> K3 Remoteproc R5 driver requires reserved memory carveouts and
>>> mailbox configuration to instantiate the cores successfully.
>>> Since this is a board level dependency, keep the R5 subsytem
>>> disabled at SoC dtsi, otherwise it results in probe errors like
>>> below during AM62P SK boot:
>>>
>>> r5fss@79000000: reserved memory init failed, ret = -22
>>> r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
>>> r5fss@78000000: reserved memory init failed, ret = -22
>>> r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22
>>>
>>> Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
>>>
>>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>>
>> Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>
>>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    | 2 ++
>>>    arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 1 +
>>>    2 files changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
>>> index c4b0b91d70cf..14eb9ba836d3 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
>>> @@ -187,6 +187,8 @@ mcu_r5fss0: r5fss@79000000 {
>>>    		ranges = <0x79000000 0x00 0x79000000 0x8000>,
>>>    			 <0x79020000 0x00 0x79020000 0x8000>;
>>>    		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
>>> +		status = "disabled";
>>> +
>>>    		mcu_r5fss0_core0: r5f@79000000 {
>>>    			compatible = "ti,am62-r5f";
>>>    			reg = <0x79000000 0x00008000>,
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>> index 19f42b39394e..10a7059b2d9b 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>> @@ -78,6 +78,7 @@ wkup_r5fss0: r5fss@78000000 {
>>>    		ranges = <0x78000000 0x00 0x78000000 0x8000>,
>>>    			 <0x78100000 0x00 0x78100000 0x8000>;
>>>    		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
>>> +		status = "disabled";
> 
> Is there a reason for difference in white space addition?
> 

For mcu_r5fss0_core0 child node there was no blank line as per the 
recommended coding style : 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n124

So I added a newline there and wkup_r5fss0 already had it correct, since 
the change was trivial it was not mentioned in commit message.

Thanks and Regards,
Vaishnav

>>>    		wkup_r5fss0_core0: r5f@78000000 {
>>>    			compatible = "ti,am62-r5f";
>>
>> Thanks.
> 

