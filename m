Return-Path: <linux-kernel+bounces-62027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8338851A52
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3603D1F24455
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDB3D578;
	Mon, 12 Feb 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OoobwbyB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C983D555;
	Mon, 12 Feb 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757157; cv=none; b=fp6D5VPlxiQdmj4QDHK2qIr9E89IWMGMvnc2CPXtGIeNwNlD12qFZunOzd1jke1XVwajKej3v6LrNm/X/xSc8YLD9yJ5iUCVveKuypSnSr95XmnRP/DBT+zE9a6ncksCEh9E4hySF4kdnXA8l/5nkCPoHBeOqgnKZjotB37ygg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757157; c=relaxed/simple;
	bh=5p6lcAM5uCVDCqa9PLQwQdZns2EPPvsUH0B6n9Zpzhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lpITNMwLMwPCZOBOx7nBtGXJf3Q76XmgCCiln6P7ZmrgCQDbPUnbheh1b1+W/LkRSmyJea6dTMdRrmyAOoCyAvx/1ugUbeT+okMXRMKrwWd4Dtgu3EqNptMbdM8O9xMIzX/DdXI7zVMnCCFDopi64VTV0mgHHBpZZcSMrVneNSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OoobwbyB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGwxlJ085838;
	Mon, 12 Feb 2024 10:58:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707757139;
	bh=PISZoT3QXJstu+Olwl27x4IhcTlCvY6q/N4khZGRgaU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OoobwbyBw83TL4qnAyLqbWqAkB79JzykGKzAVeyITEGsZJJEkTscqAdb0FuaIEPF1
	 +xFZherLRqELBDgB78yGxPFFzBjT23t1V2PBibaxOpj1siODEds8oZSvqROq/99DuN
	 ugOSJZLN08XYSYHSXSe+n+TObtIxDJnOGiO1gnv8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGwxFU074266
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:58:59 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:58:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:58:59 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGwwHK001151;
	Mon, 12 Feb 2024 10:58:58 -0600
Message-ID: <faaca11f-508e-450c-83f2-1aa03734b7cd@ti.com>
Date: Mon, 12 Feb 2024 10:58:58 -0600
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
To: Josua Mayer <josua@solid-run.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
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
        Suman Anna <s-anna@ti.com>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
 <359993c5-3387-443c-8cef-30ee7ad1f521@ti.com>
 <b918364e-cfca-4342-acc2-2b51bad75596@solid-run.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <b918364e-cfca-4342-acc2-2b51bad75596@solid-run.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/12/24 10:39 AM, Josua Mayer wrote:
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
>>>     https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-am64-main.dtsi?h=ti-linux-6.1.y-cicd&id=5afb73d82a014b59462162d960b350b8c58e5ae6
>>>     IEP is already supported in-tree by a driver, and used in
>>>     k3-am65-main.dtsi.
>>>
>>> Unfortunately dtbs_check reported many problems, I put some remarks:
>>>
>>> - 'mux-controller' does not match any of the regexes
>>>    The expectation seems to be that a mux-controller at minimum has an
>>>    address, something to put behind an @. However this is a gpio mux, not
>>>    sure how to name it better.
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
>      compatible = "gpio-mux";
>      ...
> };
> 
>    DTC_CHK arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb
> .../arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: syscon@43000000: 'mux-controller' does not match any of the regexes: '^chipid@[0-9a-f]+$', '^clock-controller@[0-9a-f]+$', '^mux-controller@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/mfd/ti,j721e-system-controller.yaml#

This is an existing issue that we are working to fix. Nothing you
can do about it, all boards that include k3-am64-main.dtsi
will have this warning currently.

Andrew

>>
>>> - unevaluated properties: interrupts, interrupt-parent
>>>    sensors and flash yaml are missing interrupt descriptions, but these
>>>    parts definitely have an interrupt signal in this solidrun board.
>>>
>> Please add them to appropriate schema as necessary
> Okay.
> Looks like it is only two:
> .../arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: humidity-sensor@41: 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/iio/humidity/ti,hdc2010.yaml#
> .../arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dtb: flash@0: Unevaluated properties are not allowed ('interrupt-parent', 'interrupts' were unexpected)
>         from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
>>
>>> - wrong names for pinctrl nodes
>>>    Other TI DTSs consistently end with *-pins-default. Should a different
>>>    naming convention be used?
>>>
>> No, pinctrl nodes need to end in -pins. All TI boards have been updated
>> to new schema [0] and sysconfig tool on dev.ti.com/sysconfig generates
>> appropriately. Please fix
> Okay, will do ...
>>
>>
>>> - cdns,phy-type required property
>>>    inherited from k3-am64-main.dtsi
>>>    there is a PHY_NONE value in dt-bindings/phy/phy.h,
>>>    but not allowed in phy-cadence-torrent.yaml
>>>
>> Sorry, I didnt get what's the issue wrt cdns,phy-type ?
> There were two issues, but they both disappeared as per 6.8-rc1 :)
>>
>>
>> Note, I really don't want to accept patches that add new dtbs_check
>> issues especially for nodes that already have YAML bindings. Please
>> update the .yaml files as necessary.
> I have succeeded locally getting rid of all but one, the node name of mux-controller mentioned above.
> Will include yaml patches in next version.
>>
>> [0]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a49568115143435390f20965902809471b6f830c
>>
>>

