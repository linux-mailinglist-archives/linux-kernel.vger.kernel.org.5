Return-Path: <linux-kernel+bounces-109692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB63881C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616101C212CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053FB3A8CB;
	Thu, 21 Mar 2024 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L603CopG"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED4C153;
	Thu, 21 Mar 2024 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002674; cv=none; b=bi3XydkMqYLbUM/GO9i1Ufav5FApuWZMHhRIjDCu5vmfxRsiyQYJcAo5qNNtljNYUX44iYC1/VfKCJKGe1yyunysiBpFAqrRX2GZ4VrtekindOkbzFM5ESJUwwUAXJqi09T09UeC6oFBjgIEiTmTJXt8KZgaBCOGlrB4k9/g56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002674; c=relaxed/simple;
	bh=sbdLq+CSq6E0bzokDR/Td3+L8V7Ur74akZHEGjUUpHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZmTjhmgFOtgSUHpY6BMJQE8u2yTvtGESvWtnRXTCi+k8wbspKJvmn5jredqF4xJE42NUHFenoZbBcthfL03QSFR7Fmt0bTy4viA0jeVHabV5UEuW9617EKiU1OFIR10r8fZdqqVpnNb6OlIu0EBnEkG1oNf3s8sHJK7SMeVYfko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L603CopG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42L6UkXd098221;
	Thu, 21 Mar 2024 01:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711002646;
	bh=rpdiJJ5eevOn74K0PaFnWxndVLDkQXyZa1juiP1FVx0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L603CopGxvt8nWOetVk0Lx7VS/76r/K6XOF0HDly12PgqaLdSiokGzJ+Xzj0FD+0i
	 BTHEaN+8Nn0SAzlGkEEEKch7OoXNKy562QBLtDnxU50ZPazDG1RA4EdZBmr4U8HBhv
	 yK5Avm3VLxPc9R0YXVqHSF3ETcQ4yvy594ramq1o=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42L6UkEm110795
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Mar 2024 01:30:46 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Mar 2024 01:30:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Mar 2024 01:30:45 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42L6Ubd6030896;
	Thu, 21 Mar 2024 01:30:38 -0500
Message-ID: <22a1e5fd-5858-43ff-b8fd-6b4124f6bd89@ti.com>
Date: Thu, 21 Mar 2024 12:00:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Ayush Singh <ayushdevel1325@gmail.com>,
        Michael Walle <mwalle@kernel.org>,
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
 <20240319-unmoral-map-3ab9a467b637@spud>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240319-unmoral-map-3ab9a467b637@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Conor,

On 19/03/24 23:49, Conor Dooley wrote:
> On Tue, Mar 19, 2024 at 11:05:37PM +0530, Vaishnav Achath wrote:
>> Hi Andrew,
>>
>> On 19/03/24 17:55, Andrew Lunn wrote:
>>>> The device tree defines the SPI controller associated with mikroBUS SPI
>>>> pins. The driver on match queries and takes a reference to the SPI
>>>> controller but does nothing with it. Once a mikroBUS add-on board is
>>>> detected (by passing manifest using sysfs or reading from 1-wire EEPROM),
>>>> the driver parses the manifest, and if it detects an SPI device in manifest,
>>>> it registers SPI device along with setting properties such as `chip_select`,
>>>> `max_speed_hz`, `mode`, etc.,
>>>
>>> How complex can the description of the hardware be in the manifest?
>>>
>>> Could i describe an SPI to I2C converter? And then a few temperature
>>> sensors, a fan controller, and a GPIO controller on that I2C bus? And
>>> the GPIO controller is then used for LEDs and a push button? DT
>>> overlays could describe that. Can the manifest?
>>
>> No, it cannot describe such complex hardware, it can only describe simple
>> devices (sensors/displays .etc) on a standard mikroBUS add-on board, we did
>> a analysis on what mikroBUS add-on boards have driver support in Linux and
>> then noticed that most devices does not need this kind of complex
>> description to work:
>> https://elinux.org/MikroEClicks_with_Linux_Support
> 
> What happens to the devices that fall outside of the "do not need a
> complex description" category? Do you expect that those would be
> described by a dt overlay?
> 

Yes, those would need a device tree overlay, but most mikroBUS add-on 
boards does not need this, almost all the boards need the standard bus 
properties (SPI/I2C properties), IRQ, named-gpios, named properties, 
regulators, clocks and the current implementation supports this.

Looking at the example Andrew provided above (SPI-I2C converter with 
sensors .etc on the I2C bus and GPIO controller) - usually you will not 
find such a mikroBUS add-on board, because if there are I2C devices they 
would directly be on the mikroBUS I2C bus rather than on the converter, 
now someone can do this in their custom solution but then it is no 
different than an I2C adapter on USB/PCIe, does the standard discovery 
mechanism on those buses help instantiate devices on the I2C? my 
understanding is NO and you will need to write a custom device tree 
overlay for the same and same will be the case here.

>> The greybus manifest already is being used in the greybus susbystem for
>> describing an interface and there are already greybus controllers (SPI/I2C
>> .etc) being created according to the manifest contents, all this driver does
>> is to extend that format to be able to instantiate devices on these buses.
>> The primary goals for introducing the driver for mikroBUS add-on boards are:
>>
>> 1) A way to isolate platform specific information from add-on board specific
>> information - so that each permutation of connecting the add-on board on
>> different ports on different board does not require a new overlay.
>> 2) A way to instantiate add-on boards on greybus created virtual mikroBUS
>> ports.
>> 3) Both 1 and 2 should use the same add-on board description format.
>>
>> Standard device tree overlays did not help to achieve this and that is why
>> the standard interface discovery mechanism in greybus, the manifest was
>> extended even though it is not the most optimal way to describe hardware.
>>
>> The greybus manifest extensions were made with the following things in mind
>> and three new descriptor were introduced:
>> 1) mikrobus descriptor - pinmux/port state
>> 2) device descriptor - contains information which is a superset of struct
>> i2c_board_info , struct spi_board_info .etc
>> 3) property descriptor - to describe named properties of the types defined
>> under https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/property.h#n22
>>
>> With these we were able to test around 150 add-on boards with corresponding
>> drivers in Linux :
>> https://github.com/MikroElektronika/click_id/tree/main/manifests
>>
>> The mechanism is not as robust a device tree and should not be compared, the
> 
> Why not? You're suggesting this as a method for describing devices and you
> seem to have extended the manifest to support more complex properties, why
> shouldn't someone question make that comparison?
> 

Agreed, but the comparison need to limited to the expansion interface 
(mikroBUS) under discussion as the idea is not to create an alternate 
interface for describing generic devices, the   class of add-on boards 
that can fit in the mikroBUS add-on board form factor and on the buses 
exposed by mikroBUS requires only simple descriptions - namely standard 
bus properties (SPI/I2C properties), IRQ, named-gpios, named properties, 
regulators, clocks and the extensions to manifest were made for those 
properties only. Also the extensions were done to support the properties 
under unified device property interface under include/linux/property.h

Thanks and Regards,
Vaishnav

>> intent was not to create a new hardware description format, but extend the
>> existing greybus manifest format to be able to instantiate devices on the
>> greybus SPI/I2C/GPIO/ (mikroBUS)
> 

