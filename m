Return-Path: <linux-kernel+bounces-62991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A9852894
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71FEB211F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D6712E48;
	Tue, 13 Feb 2024 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u4zOq6gS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECC125B2;
	Tue, 13 Feb 2024 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804619; cv=none; b=Wi8sq6V7+3EWfa1lZLb6KKZv+v1Gn2TAncn/HCkEqMeIm31IvGESormid/Mlq7oDMJI/7nC1a79O8Nbp+H5DR+/kM6s+RPJ7GwRvnusqJcuP2Aq8CkkNYs0QAmEaaHX1fgVQwI/cXWHd+/v7Nyte+xkKfN169v89s5M6KKF4nnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804619; c=relaxed/simple;
	bh=s1up70ZXW+9oM55cz1WmbskRPTMYaaYeCjZg+jmbZ/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s96zN8cUeCJv4Pny8hSYzQFP8f/1IJrRaDUr6rtCeSIN/tdnwJVEVhr4/JJFmDEoQL86P8jp6AJeDTvGkcUOLh2h1LsXuxDzqs9My6Lo7QpchpUIJ+VREG1pYl1rdsfBvkOAYgZizB5nh4dZNI74Uy4m9zF5IEXZeTDC7BWmoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u4zOq6gS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D69ilp078848;
	Tue, 13 Feb 2024 00:09:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707804584;
	bh=Kn7/FfLHyz0ebYOkvTUmyOmHjjckiFLLNK6m12sdElM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=u4zOq6gSVQkOmvu3B4mYlV7do6+VpcVW6HtOBsgUfaPbpf1pbi8I0vlizP+MMQ+Kz
	 OHbodbO1DBbzZ69+wXZpNY0RMtOIINvGTY+/WFRycD77dM6HuCdQxrCvJ+v1e/3XEJ
	 1hhN/vsR1sdtVDmHL++URjYccxrax/z+OgqJB/TY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D69i3M010056
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 00:09:44 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 00:09:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 00:09:43 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D69cxd046033;
	Tue, 13 Feb 2024 00:09:39 -0600
Message-ID: <57d24319-eabb-48d6-b5a0-cab333c9cc68@ti.com>
Date: Tue, 13 Feb 2024 11:39:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Suman Anna <s-anna@ti.com>, MD Danish Anwar
	<danishanwar@ti.com>,
        Andrew Davis <afd@ti.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
 <359993c5-3387-443c-8cef-30ee7ad1f521@ti.com>
 <b918364e-cfca-4342-acc2-2b51bad75596@solid-run.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <b918364e-cfca-4342-acc2-2b51bad75596@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 12/02/24 22:09, Josua Mayer wrote:
> Hi Vignesh,
> 
> Am 12.02.24 um 05:10 schrieb Vignesh Raghavendra:
>> Hi Josua,
>>
>> On 11/02/24 20:37, Josua Mayer wrote:
>>> This series adds DT bindings and dts descriptions for SolidRun AM642
>>> based SoM and Hummingboard EVB.
>>>
>>> Additionally a commit from downstream vendor kernel are included,
>>> enhancing support for pru based ethernet.
>>> I wasn't sure how to properly annotate it in commit description /
>>> signed-off area ...:
>>>
>>> 1. add description for "Industrial Ethernet Peripherals" (IEP) to am64
>>>    https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-am64-main.dtsi?h=ti-linux-6.1.y-cicd&id=5afb73d82a014b59462162d960b350b8c58e5ae6
>>>    IEP is already supported in-tree by a driver, and used in
>>>    k3-am65-main.dtsi.
>>>
>>> Unfortunately dtbs_check reported many problems, I put some remarks:
>>>
>>> - 'mux-controller' does not match any of the regexes
>>>   The expectation seems to be that a mux-controller at minimum has an
>>>   address, something to put behind an @. However this is a gpio mux, not
>>>   sure how to name it better.
>>>
>> I don't see this warning locally. Are you using updated dt-schema?
> pip3 install dtschema --upgrade
> Defaulting to user installation because normal site-packages is not writeable
> Requirement already satisfied: dtschema in ~/.local/lib/python3.11/site-packages (2023.11)
> 
> Re-Tested on 6.8-rc1
> 
>> reg
>> is not necessary gpio-mux as per gpio-mux.yaml
> The error is not about reg property, it is about the node name:
> 
> mux-controller {
>     compatible = "gpio-mux";
>     ...
> };
> 
>   DTC_CHK arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb
> .../arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: syscon@43000000: 'mux-controller' does not match any of the regexes: '^chipid@[0-9a-f]+$', '^clock-controller@[0-9a-f]+$', '^mux-controller@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>        from schema $id: http://devicetree.org/schemas/mfd/ti,j721e-system-controller.yaml#

This warning exists not because of gpio-mux but because of SoC level
(k3-am64-main.dtsi) dtsi issue. There is a separate series to fix the
same. So this should be okay to ignore for now.


>>
>>> - unevaluated properties: interrupts, interrupt-parent
>>>   sensors and flash yaml are missing interrupt descriptions, but these
>>>   parts definitely have an interrupt signal in this solidrun board.
>>>
>> Please add them to appropriate schema as necessary
> Okay.
> Looks like it is only two:

> .../arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: humidity-sensor@41: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
>        from schema $id: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#
> .../arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: flash@0: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
>        from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#

Yup, thanks!


you could post a cut down version of the dts with all the problematic
nodes removed until yaml updates are merged, so as to get the basic
support in.


>>
>>> - wrong names for pinctrl nodes
>>>   Other TI DTSs consistently end with *-pins-default. Should a different
>>>   naming convention be used?
>>>
>> No, pinctrl nodes need to end in -pins. All TI boards have been updated
>> to new schema [0] and sysconfig tool on dev.ti.com/sysconfig generates
>> appropriately. Please fix
> Okay, will do ...
>>
>>
>>> - cdns,phy-type required property
>>>   inherited from k3-am64-main.dtsi
>>>   there is a PHY_NONE value in dt-bindings/phy/phy.h,
>>>   but not allowed in phy-cadence-torrent.yaml
>>>
>> Sorry, I didnt get what's the issue wrt cdns,phy-type ?
> There were two issues, but they both disappeared as per 6.8-rc1 :)
>>

That's nice!


-- 
Regards
Vignesh

