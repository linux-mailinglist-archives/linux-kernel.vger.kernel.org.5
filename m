Return-Path: <linux-kernel+bounces-131812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575B898C18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D003C1F29915
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4512BF02;
	Thu,  4 Apr 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zMxwsJVw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343201E522;
	Thu,  4 Apr 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248146; cv=none; b=c+dHEo1Utb1G2ETwrfaIkstPfOg8Pj0D/UrNHME6otIhb9tRW+9Nnwzmwg/mtKSHBcXqP/iY+JNbl15e4O/+EyDD5Q+Tun9HjfKH1oPQFoQw6/JpxIu0N/8UKHkuXC5cHQUO8S26gwOPr1MHkLfjtNP1m4w1zXUdDf2FoslQABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248146; c=relaxed/simple;
	bh=ZDSXC0SJ+CerDgWVbaTYvwjZpvTsijT6HMMUXVGDLpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I+ANRsAT6XgbjTQRLUGD8E8KhToSZ/EeT2mn9+iqYHJajwa5AkcmGppG2atbLLFNSevRbzOZy0QloBgbusbclSTaLv4WGMZYIPyt0ckN4RkZy5nfguGuiBUAda09ececF/gyeaQ8bf5mbWA7jeE8FvKi102Q1WmR70QrdcLebdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zMxwsJVw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434GSq2U114723;
	Thu, 4 Apr 2024 11:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712248132;
	bh=8QSW8mPiC0nENIietXOD7FuT/weRbNpR3GRy7poQaQA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zMxwsJVwRBjhGETfhL6jy4OlQufSTYwXXhXo4pqrqCIbI8QYkbAAtNZNlsmO8ooCw
	 8lrFlnViQSXCb2VzvasQx3i5gvqlX8L8Lbc3I3t+eErlH0hXU4WsT15Nen/Zw/sDv1
	 +gyfZH7GAg/iNChoXK5zAPZ5cZwnCY+oRVWyw6qw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434GSqse053068
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 11:28:52 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 11:28:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 11:28:51 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434GSp17117692;
	Thu, 4 Apr 2024 11:28:51 -0500
Message-ID: <6d11aed3-242d-45c4-9647-894eea4e427b@ti.com>
Date: Thu, 4 Apr 2024 11:28:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62p: use eFuse MAC Address for
 CPSW3G Port 1
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240404081845.622707-1-s-vadapalli@ti.com>
 <18eb0e55-38ad-44f9-90b7-1917d8c0d5bb@linaro.org>
 <75b53dda-23aa-4915-944a-4d9a619bd165@ti.com>
 <903ad855-ab26-4ef3-80bd-249917056188@linaro.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <903ad855-ab26-4ef3-80bd-249917056188@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/4/24 5:00 AM, Krzysztof Kozlowski wrote:
> On 04/04/2024 11:12, Siddharth Vadapalli wrote:
>> On Thu, Apr 04, 2024 at 10:43:04AM +0200, Krzysztof Kozlowski wrote:
>>> On 04/04/2024 10:18, Siddharth Vadapalli wrote:
>>>> Add the "cpsw-mac-efuse" node within "wkup_conf" node corresponding to the
>>>> CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the compatible
>>>> "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations on these
>>>> registers. The MAC Address programmed in the eFuse is accessible through
>>>> the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree property
>>>> points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver to fetch
>>>> the MAC Address and assign it to the network interface associated with
>>>> CPSW3G MAC Port 1.
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>
>>>> This patch is based on linux-next tagged next-20240404.
>>>> Patch depends on:
>>>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
>>>> for the newly added "ti,am62p-cpsw-mac-efuse" compatible.
>>>>
>>>> v1:
>>>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402094200.4036076-1-s-vadapalli@ti.com/
>>>> Changes since v1:
>>>> - Since "wkup_conf" is modelled as a "simple-bus" rather than being
>>>
>>> And maybe the hardware representation is not correct? What bus is it?
>>
>> I will let Andrew comment on it. Andrew had posted a patch at:
>> https://lore.kernel.org/r/20240124184722.150615-10-afd@ti.com/
>> to convert an equivalent "main_conf" node for AM62 SoC to "simple-bus"
>> from the existing "syscon".
>>
>>>
>>>>    modelled as a System Controller node with the "syscon" compatible,
>>>>    directly passing the reference to the "wkup_conf" node using the
>>>>    "ti,syscon-efuse" device-tree property will not work.
>>>>    Therefore, I posted the patch at:
>>>>    https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
>>>>    in order to add a new compatible to be used for modelling the
>>>>    CTRLMMR_MAC_IDx registers as System Controller nodes, thereby
>>>>    allowing the existing "ti,syscon-efuse" property to be used.
>>>>    Now, "ti,syscon-efuse" points to the "cpsw_mac_efuse" node within
>>>>    "wkup_conf" node, with "cpsw_mac_efuse" being a "syscon" node.
>>>>
>>>> Logs verifying that the CPSW driver assigns the MAC Address from the
>>>> eFuse based on the CTRLMMR_MAC_IDx registers at 0x43000200 and 0x43000204
>>>> to the interface eth0 corresponding to CPSW3G MAC Port 1:
>>>> https://gist.github.com/Siddharth-Vadapalli-at-TI/9982c6f13bf9b8cfaf97e8517e7dea13
>>>>
>>>> Regards,
>>>> Siddharth.
>>>>
>>>>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 1 +
>>>>   arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 5 +++++
>>>>   2 files changed, 6 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>>> index 7337a9e13535..848ca454a411 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
>>>> @@ -696,6 +696,7 @@ cpsw_port1: port@1 {
>>>>   				label = "port1";
>>>>   				phys = <&phy_gmii_sel 1>;
>>>>   				mac-address = [00 00 00 00 00 00];
>>>> +				ti,syscon-efuse = <&cpsw_mac_efuse 0x0>;
>>>
>>> Why this is not nvmem cell, like or efuses?
>>
>> Since it belongs to the MMIO register set. You had recommended *not*
>> using nvmem for such MMIO registers at:
>> https://lore.kernel.org/r/48902771-5d3b-448a-8a74-ac18fb4f1a86@linaro.org/
>> "nvmem is for non-volatile memory, like OCOTP and eFUSE. This is not for
>> accessing regular MMIO registers of system-controller..."
>>
>> Despite the "ti,syscon-efuse" property containing the term "efuse" in its
>> name, it is reading the CTRLMMR_MAC_IDx MMIO registers. So I assumed that
>> the existing approach which has been used on all K3 SoCs apart from this
>> one, will be suitable for this SoC as well.
> 
> OK, I totally forgot we discussed this.
> 

Discussed but never finalized, here is the last message[0] but with
no response.

You even asked above, "Why this is not nvmem cell", you should trust
your instincts, this *should* be a NVMEM cell. That is how everyone else
handles eFused MACs, no clue why you want us to use syscon?? We would
have no way forward in removing all our DT check warnings with syscon.

Syscon is a hacky dead-end filled with custom compatible strings like
"ti,am62p-cpsw-mac-efuse" and custom properties like "ti,syscon-efuse".

NVMEM is a standard, forcing us to use TI custom syscon properties will
prevent our DT from working on anything other than Linux (unless we go
manually add support for every TI custom property to every DT using SW,
defeats the whole purpose DT).

Andrew

[0] https://lore.kernel.org/all/e7114cb4-e24f-4e78-a89f-4e2e2e704b8a@ti.com/

>>
>>>
>>>>   			};
>>>>   
>>>>   			cpsw_port2: port@2 {
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>>> index a84756c336d0..df9d40f64e3b 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
>>>> @@ -18,6 +18,11 @@ chipid: chipid@14 {
>>>>   			reg = <0x14 0x4>;
>>>>   			bootph-all;
>>>>   		};
>>>> +
>>>> +		cpsw_mac_efuse: cpsw-mac-efuse@200 {
>>>
>>> Node names should be generic. See also an explanation and list of
>>> examples (not exhaustive) in DT specification:
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> I was following the convention that other mfd-syscon compatible nodes
>> seemed to be using:
>> https://github.com/torvalds/linux/blob/41bccc98fb7931d63d03f326a746ac4d429c1dd3/arch/arm64/boot/dts/ti/k3-am65-main.dtsi#L502
>> The node is:
>> dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0
>> corresponding to the compatible:
>> "ti,am654-dss-oldi-io-ctrl"
>> which was added by commit:
>> https://github.com/torvalds/linux/commit/cb523495ee2a5938fbdd30b8a35094d386c55c12
> 
> So if that one was wrong, then what? I don't know really what type of
> device is it, but just because one contributor called it that way, does
> not mean you should keep going. Maybe investigate why that contributor
> did not decide to follow Devicetree spec recommendation?
> 
> Best regards,
> Krzysztof
> 

