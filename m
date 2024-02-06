Return-Path: <linux-kernel+bounces-55497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588C84BD69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA878B222AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C8171A9;
	Tue,  6 Feb 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xqh2WmC1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE81168DD;
	Tue,  6 Feb 2024 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245459; cv=none; b=lpK6FBQmd3bkq81Jg2NgoE98nMVqv0KQ/NQQ2siSeV/P7xcY/+QwiJhnydnq9md1tBi8NzVkK08rAML2iQZ4dUg0sCtg6a65lrx5nmnY8+2L6+4bacDwcZJ9mez9mFAbg5KDXszQSt21DUaGbQyBZliw6kGNgN8kOs35w2/Gej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245459; c=relaxed/simple;
	bh=Vr/Q4qfwvGJrydQHPnsIop8KV5TVqh0RZULrvzhraFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n00oIm0g+rgAhn/o0eRyjw2dh32AtB1LgCRlep29WqJghDBn6F9CmQpH6oYKcvLBVWOX3OXRvby3ZqYbXk4bfiXkxduJqZzwW54CeSnU+UT9kDgdsfFPud0PdUfpdBeK2DZTIV5GIvxtArz/Q3oAXjCJnOGBmI6uK+oJny05BEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xqh2WmC1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416IodJv046178;
	Tue, 6 Feb 2024 12:50:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707245439;
	bh=jW5SdOE3WyIMKBSfBWIvIauASsolGdLvD8Pbpcc1dQk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xqh2WmC1g3vctyVP9kXUSfO/jFugnzYdAJs6EE3aKG9eD3brYzYEOhI3nCUbc1j4Q
	 zR3UewsfOIL3LsYRv0iJOljmZUnCUf+D/7fQ8Hn+QeMPIoAVsjmacj16OFw1qkwoOv
	 19khursHfDW4HuYaMUpK2Ry4GfHCBXTh8aNOV1dA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416Iodbf104944
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 12:50:39 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 12:50:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 12:50:39 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416Iocwt005084;
	Tue, 6 Feb 2024 12:50:38 -0600
Message-ID: <b5b70049-81f6-455e-b2bf-d03431e5b27b@ti.com>
Date: Tue, 6 Feb 2024 12:50:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: mallow: add TPM device
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240126165136.28543-1-francesco@dolcini.it>
 <65a24f21-4cc6-4843-b838-b1c7020ca45d@ti.com>
 <26F9C286-606C-40C6-994E-EABDFFCDFDC4@dolcini.it>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <26F9C286-606C-40C6-994E-EABDFFCDFDC4@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/6/24 12:36 PM, Francesco Dolcini wrote:
> 
> 
> Il 6 febbraio 2024 19:29:13 CET, Andrew Davis <afd@ti.com> ha scritto:
>> On 1/26/24 10:51 AM, Francesco Dolcini wrote:
>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> Add TPM device to Mallow device tree file, the device is connected to
>>> the SoC with SPI1/CS1, the same SPI interface is also available on an
>>> extension header together with an additional CS0 signal.
>>>
>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>> ---
>>>    arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
>>> index 17b93534f658..77b1beb638ad 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
>>> @@ -127,6 +127,16 @@ &main_spi1 {
>>>    		    <&pinctrl_qspi1_cs2_gpio>;
>>>    	cs-gpios = <0>, <&main_gpio0 12 GPIO_ACTIVE_LOW>;
>>>    	status = "okay";
>>> +
>>> +	tpm@1 {
>>> +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
>>> +		reg = <1>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_qspi1_dqs_gpio>;
>>> +		interrupt-parent = <&main_gpio1>;
>>> +		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
>>
>> Just a heads-up, the SLB9670 datasheet says this device uses
>> an active low interrupt (IRQ_TYPE_LEVEL_LOW). Using TYPE_EDGE
>> here can cause missed interrupts if the line stays low for
>> multiple interrupts.
> 
> 
> The driver interrupt handler would need to take care of it, if needed.
> 
> The SOC does not support level interrupt, so there is no other solution, am I wrong?

Correct, our K3 SoCs do not support level interrupts and so are not compatible
with most hardware that uses interrupts (unless you are okay with missing
some interrupts every now and then..).

As you say, our interrupt driver needs to be modified to handle that. Possibly
by re-checking the line level after the interrupt handlers have all run to see
if it is still high/low, then manually re-triggering the interrupt if so.

The heads-up is just that you should be aware of this in case you have issues.
When(if) our interrupt driver is ever fixed you will need to update the DT here
to take advantage of the level handler.

Andrew

>   
> Francesco
> 

