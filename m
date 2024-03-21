Return-Path: <linux-kernel+bounces-109987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371898858A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923F7B21FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08065B1F7;
	Thu, 21 Mar 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wLyXcSx9"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FE3C17;
	Thu, 21 Mar 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022159; cv=none; b=AhWGAH/RLXE909gImteopLLXFHJy2R7wbGTv0Yql1I1DB4Cirz2LyFLUiNAS2QT66uu9nzwZ1PgUF9eVgzBSTE1pRbQey3FujV3MwpFhsePLCkISe3En5k8C10zHePtkCrThxXQQTSW2+oslGPhu4kDZf0FtNn1ork0U0dqNI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022159; c=relaxed/simple;
	bh=OOKeFMdqN/oRnbdKq0PnsVOa1ssNxlZTwhJ9GrYbeOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z4FowFJroMD7AY65vfKUuDGM4qCna6eNCSsLr/3NzqmQoXE3y4t9ndZ9k6wWr74kj/pVt36Od8IgUftR+smlNEISWxsb6Y2M0ZqFndMQjb9wQjFndVpb3QCMgDfaWXrCWuvlJvRztsn2NKHgoJbiCEMTTM2PyuJAaO3dJG4jg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wLyXcSx9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42LBtIum009191;
	Thu, 21 Mar 2024 06:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711022118;
	bh=bfXSNgzfF39TmycWQT9ljrIkLfLOmINJWk7nXQyV6gU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wLyXcSx94ZSt8JqZDiY6Ry8Ubk8G1CwXaejforsyVW7LKcjbYEi9+6tIwpVDAS/yo
	 agpOJCZdtJ8VLLYAnPSZSyK1kQ2nQYVxTjllp40J54ikcgBili0q9Zx4GdZsiei8kV
	 Zkx9l6Yg/JahLyS2WsZYKN19Bc61AsbWYZEvknPY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42LBtIV2032767
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Mar 2024 06:55:18 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Mar 2024 06:55:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Mar 2024 06:55:18 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42LBtAWR111394;
	Thu, 21 Mar 2024 06:55:10 -0500
Message-ID: <ef6a1c28-70dc-4077-b644-2704ac3cf30f@ti.com>
Date: Thu, 21 Mar 2024 17:25:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Ayush Singh
	<ayushdevel1325@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>, <lorforlinux@beagleboard.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Derek Kiernan
	<derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann
	<arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder
	<elder@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/TEXAS INSTRUMENTS
 K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "open list:SPI
 SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "moderated list:GREYBUS SUBSYSTEM"
	<greybus-dev@lists.linaro.org>,
        Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <b62915ca-c151-4e37-bb03-c92c569c84ff@lunn.ch>
 <4b319264-bff7-48e5-85e8-201ca0bafec6@ti.com>
 <4c299d42-84c7-46fc-952f-292cef1bb4b4@lunn.ch>
 <ded6c350-4c70-4a26-8b18-6605dcc6e084@ti.com>
 <CZZBT3ZMDCVI.40UX5MB6LY4I@kernel.org>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <CZZBT3ZMDCVI.40UX5MB6LY4I@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 21/03/24 15:08, Michael Walle wrote:
> Hi,
> 
>>> Is that because the current software support is too limited? Are there
>>> manufactures who want to create more complex designed, but are limited
>>> by what can be described in the manifest?
>>>
>>
>> most mikroBUS add-on boards in production lies in the category of
>> sensors, displays, connectivity, mixed signal (ADC/DAC .etc) and if you
>> look at the existing bindings under bindings/iio/ , most devices need
>> only simple descriptions and the properties are mainly standard bus
>> properties (SPI/I2C properties), IRQ, named-gpios, named properties,
>> regulators, clocks the extension to manifest was made taking this into
>> account and the named property description interface just maps the
>> manifest entries to the unified device property interface under
>> include/linux/property.h
> 
> How will the ethernet boards ([1], [2]) work? Where do they get
> their MAC address from, for example. The DT has some nice properties
> for that, but I doubt that will be possible with the manifest files.
> I've looked at the manifest file for the w5500 board [3] and to me
> it looks like that board will come up with a random MAC address on
> each start. Thus, even today, you have some boards which require
> a more complex description.
> 

Agreed, this is a limitation, unless the corresponding 
drivers/subsystems use device_property_read_* helper to fetch 
properties, it will not work and net/core/of_net.c only implements 
of_get_* helpers even though the underlying functions can be implemented 
with equivalent device_property_read_* equivalent as well.

> Apart from the discussion whether the manifest is a suitable or
> sufficient mechanism to describe the hardware, I think the main
> problem with the proposed binding, is that it doesn't follow the
> binding Rob was proposing for a socket. If I want to use DT
> overlays, how would you describe an add-on board?
> 
> The proposal was that the base board has something like
> 
> mikrobus: socket {
> 	compatible = "mikrobus-socket";
> 	i2c-parent = <&i2c0>;
> 	spi-parent = <&spi0>;
> 
> 	i2c {};
> 	spi {};
> };
> 
> an add-on board can then have a DT snippet/overlay like the
> following:
> 
> &mikrobus {
> 	i2c {
> 		eeprom@52: {
> 			reg = <52>;
> 			compatible = <atmel,at24..>;
> 		}
> 	};
> 
> 	spi {
> 		sensor@0: {
> 			reg = <0>;
> 			compatible = <foobar>;
> 		};
> 	};
> };
> 
> That should be possible with a binding for the mikrobus, which
> in fact it is just a pin header with a standard pinout. Also as
> Russell pointed out in v3, the EEPROM/manifest is not part of the
> mikrobus standard. So maybe that deserves an own compatible, like
> 
>     compatible = "mikroe,click", "mikrobus-socket";
> 
> Or maybe click-eeprom? Although click seems to be the brand name of
> MikroElektronika.

Agreed, there is nothing preventing us to convert the binding and update 
the driver to follow the above proposed format and will be done in next 
revision. Click is brand name of MikroElektronika and they don't allow 
custom boards to use that branding, however clickid can be used in the 
case where EEPROM is present/enable the socket to be probeable.

Thanks and Regards,
Vaishnav

> 
> -michael
> 
> [1] https://www.mikroe.com/eth-3-click
> [2] https://www.mikroe.com/eth-wiz-click
> [3] https://github.com/MikroElektronika/click_id/blob/main/manifests/ETH-WIZ-CLICK.mnfs

