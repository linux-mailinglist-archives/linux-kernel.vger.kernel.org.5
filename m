Return-Path: <linux-kernel+bounces-107901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577BC88034A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0611C22799
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C811B812;
	Tue, 19 Mar 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VegveruJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C721364;
	Tue, 19 Mar 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710868796; cv=none; b=pfgZIHp/dyWUYbZX2OLERg5jsuCApm/o878MlbCsp12xtYYKemq/cc2IgSmoEvZv55UhXRhSDlkU7Bxea099FIAzTOaCk+7p37JEQ/AnC3eobS7uk8HX1BLRE7433JDZZmSnApPd+L1o5WOySQcUTw0tBTAaXkl+oc2a3MZmXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710868796; c=relaxed/simple;
	bh=HC9OjD7zg/k/bihYiIHNnTcfY6vCEvxX/PXqx6EPFlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sSAdSfhg1ORHonoEgrrG1whmK8yWWk78gLAZ+wbog3hkaKOfJXDvtH4u/xU+mr4nf6g2gEs/r4V3uga0Wr88khJC/JSqJxa6mT95krXvy3e5OMOblIrLjXdiUdDpa4xQ08ExPL8eT544WSRPXEBXMuAHhr5OJFL6Qd7PyaAnw+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VegveruJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JHJXtq068463;
	Tue, 19 Mar 2024 12:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710868773;
	bh=BH9qfxNyCsy/GWmWpNoowK/fBARVTuvdS6rh2Mpl9hs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VegveruJA/NSUHBNK3l+cByHBQDqY3KQZIfd0ZQuKBmvzjxqyNcNyk6fGNm2+Aowd
	 cSob5VVolCFhjbWy9kuXL4kbzaX/zom4/DGIWbJONBWyJsqiq6LDr2apNN04J47Rn4
	 ZNdW3/CKI0f8Z8raouRncqYgxvJVGgO2kcpJfS6c=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JHJXGI022515
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 12:19:33 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 12:19:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 12:19:32 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JHJPwE048813;
	Tue, 19 Mar 2024 12:19:25 -0500
Message-ID: <2eec6437-dd11-408d-9bcb-92ba2bee4487@ti.com>
Date: Tue, 19 Mar 2024 22:49:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Ayush Singh <ayushdevel1325@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
CC: <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
        <lorforlinux@beagleboard.org>, Rob Herring <robh@kernel.org>,
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
 <0f3f56d4-3381-44f1-91bc-c126f3ced085@linaro.org>
 <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
 <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
 <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
 <CZXPQZY8PUGE.QZM8XSOUNMT4@kernel.org>
 <81ec4156-8758-406e-876b-5acf13951d09@gmail.com>
 <CZXSKOLK6S1S.N86E2AZG2V90@kernel.org>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <CZXSKOLK6S1S.N86E2AZG2V90@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Michael,

On 19/03/24 19:51, Michael Walle wrote:
> On Tue Mar 19, 2024 at 2:03 PM CET, Ayush Singh wrote:
>>>>>> Regardless, this patch actually does not contain any code for EEPROM
>>>>>> support I have just mentioned it to give more context on why mikroBUS
>>>>>> manifest is the focus of this patch instead of DT overlay or something
>>>>>> else.
>>>>> Right, and I think this is the crux here. Why can't you use DT
>>>>> overlays? The manifest files, seem to be yet another hardware
>>>>> description (method) and we already have DT. Can't we have some kind
>>>>> of userspace helper that could translate them to DT overlays? That
>>>>> way, you could also handle the EEPROM vs non-EEPROM case, or have
>>>>> some other kind of method to load a DT overlay.
>>>>>
>>>>> Admittedly, I've never worked with in-kernel overlays, but AFAIK
>>>>> they work with some subsystems.
>>>>>
>>>>> -michael
>>>>
>>>> So let me 1st go over 3 cases that the driver needs to support:
>>>>
>>>> 1. Non EEPROM boards:
>>>>
>>>> Using overlays should be pretty similar to current solution. If the
>>>> manifest is converted to overlay in userspace, then we do not even need
>>>> to do manifest parsing, setting up spi, i2c etc in the kernel driver.
>>>>
>>>>
>>>> 2. EEPROM boards
>>>>
>>>> How do you propose handling these. If you are proposing storing dt
>>>> overlay in EEPROM, then this raises some questions regarding support
>>>> outside of Linux.
>>>>
>>>> The other option would be generating overlay from manifest in the kernel
>>>> driver, which I'm not sure is significantly better than registering the
>>>> i2c, spi, etc. interfaces separately using standard kernel APIs.
>>> You did answer that yourself in (1): you could use a user space
>>> helper to translate it to a DT overlay, I don't think this has to be
>>> done in the kernel.
>>
>> I do not understand what you mean. For EEPROM supported boards, user
>> space is not involved. The driver can directly read the manifest from
>> add-on board and setup everything, so it is plug and play.
> 
> A driver could call a user-space helper, which will read the EEPROM
> content (or maybe the driver already passes the content to the
> helper), translate it to a DT overlay, and load it. Wouldn't that
> work?
> 
> I'm not saying that is the way to go, just evaluate some ideas.
> 

This would work in most cases when we want to instantiate devices on a 
physical mikroBUS port on the host running Linux, but another use case 
we need to support is to instantiate devices on a virtual/greybus 
mikroBUS port created through greybus, this is the case when a remote 
microcontroller board (Example BeagleConnect Freedom) has mikroBUS ports 
and through the magic of greybus these virtual ports (corresponding to 
the physical remote ports) appear on the Linux host - now we cannot use 
a device tree overlay to instantiate a Weather click (BME280) sensor on 
this port, that is why the choice of extending greybus manifest was 
chosen, another alternative here is to go and add device tree as a 
description mechanism for greybus, please let know if that is the 
recommended way forward?

The greybus manifest already is being used in the greybus susbystem for 
describing an interface and there are already greybus controllers 
(SPI/I2C .etc) being created according to the manifest contents, all 
this driver does is to extend that format to be able to instantiate 
devices on these buses. The primary goals for introducing the driver for 
mikroBUS add-on boards are:

1) A way to isolate platform specific information from add-on board 
specific information - so that each permutation of connecting the add-on 
board on different ports on different board does not require a new overlay.
2) A way to instantiate add-on boards on greybus created virtual 
mikroBUS ports.
3) Both 1 and 2 should use the same add-on board description format.

Standard device tree overlays did not help to achieve this and that is 
why the standard interface discovery mechanism in greybus, the manifest 
was extended even though it is not the most optimal way to describe 
hardware.

>> The manual involvement of user space is only for non EEPROM boards since
>> we do not have a way to identify the board without the user needing to
>> provide the manifest.
> 
> FWIW, I'm not talking about manual steps here. But more of
> call_usermodehelper(). Or maybe udev can do it?
> 
> Btw, [1] mentions hot-plugging. Is that really hot-plugging while
> the system is running? How would that work?
> 

This should be corrected, it is not recommended to hot-plug the board as 
the connector standard does not ensure any power sequencing and can 
cause damage.

>>> Also how do you know whether there is an EEPROM
>>> or not?
>>
>> Set RST GPIO to low. clickID supported board will enter ID MODE, Then
>> check if CS line has a w1 gpio bus.
> 
> Ok.
> 
>>>> 3. Over Greybus
>>>>
>>>> It is quite important to have mikroBUS over greybus for BeagleConnect.
>>>> This is one of the major reasons why greybus manifest was chosen for the
>>>> manifest format.
>>>>
>>>> Also, it is important to note that mikroBUS manifest is being used since
>>>> 2020 now and thus manifests for a lot of boards (both supporting clickID
>>>> and not supporting it exist). So I would prefer using it, unless of
>>>> course there are strong reasons not to.
>>> And also here, I'm not really familiar with greybus. Could you give
>>> a more complex example? My concern is that some driver might need
>>> additional properties from DT (or software nodes) to function
>>> properly. It might not only be a node with a compatible string but
>>> also more advanced bindings. How would that play together with this?
>>> My gut feeling is that you can handle any missing properties
>>> easier/better (eg. for existing modules) in user space. But maybe
>>> that is already solved in/with greybus?
>>
>> Greybus is a communication protocol designed for modular electronic
>> devices. It allows different parts of a device to be hot plugged (added
>> or removed) while the device is still running. Greybus manifest is used
>> to describe the capabilities of a module in the greybus network. The
>> host then creates appropriate bidirectional unipro connections with the
>> module based on the cports described in the manifest. I have added a
>> link to lwn article that goes into more detail.
>>
>> BeagleConnect simply allows using greybus over any bidirectional
>> transport, instead of just Unipro.
>>
>> I cannot comment much about how greybus handles missing properties.
>> While greybus also works just in kernel space, greybus protocols are
>> inherently higher level than kernel driver, so it might have an easier
>> time with this.
>>
>> I have also added a link to eLInux page which provides rational for the
>> mikroBUS manifest. But the crux seems to be that dynamic overlays were
>> not well-supported back then. Also, the use of mikroBUS using greybus
>> subsystem was already used. Hence the mikroBUS driver.
> 
> I see this as an opportunity to improve the in-kernel overlays :)
> 
>> Greybus is not a big blocker from my perspective, since it is always
>> possible to introduce a new protocol for mikroBUS in Greybus spec. I
>> think as long as both EEPROM and non EEPROM boards can be supported by
>> mikroBUS driver and dt-bindings, are can be used outside of Linux (eg:
>> ZephyrRTOS, nuttx, etc), it is fine.
>>
>>> Here's a random one: the manifest [1] just lists the compatible
>>> string apparently, but the actual DT binding has also reset-gpios,
>>> some -supply and interrupt properties.
>>>
>>> -michael
>>>
>>> [1] https://github.com/MikroElektronika/click_id/blob/main/manifests/WEATHER-CLICK.mnfs
>>
>>
>> Yes, the concern is valid. Support for validating the manifest is
>> nowhere near as good as devicetree overlays. But I think that would be a
>> problem with the device rather than the responsibility of the kernel. It
>> is up to the manufacturer to have valid manifests.
> 
> But does the manifest have the capabilities to express all that
> information? To me it looks like just some kind of pinmux, some
> vendor strings and a (DT) compatible string.
> [coming back to this after seeing [2]: there are more properties,
> but it seem just be a list of property=value]
> 
> What I'd like to avoid is some kind of in-kernel mapping list from
> manifest to actual driver instantiation.

The property descriptor is implemented to account the properties under 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/property.h#n22 


There is no in-kernel mapping that needs to be updated per driver, but a 
generic mapping and some specific mapping depending on the bus the 
device is connected (I2C/SPI/.etc)

> 
> I guess you'll get much of that with DT overlays already and if you
> have some kind of automatic translation from manifest to DT overlay,
> it will still be plug-and-play. You could fix up any missing
> properties, etc. manually loading some manifests/dt overlays for
> modules without EEPROMs.
> 
> Again, a more complex manifest file would really be appreciated
> here. Not just a simple "there is exactly one trivial SPI device on
> the bus".
> 
> FWIW, here is a more complex example [2] which uses the ssd1306
> display driver. Dunno if that is a good example, as it seems to use
> the fb_ssd1306 driver (at least that's what I'm deducing by reading
> the driver-string-id) in staging and there is also ssd1307fb.c in
> drivers/video/fbdev. But how are the additional information like
> width and height translate to the properties of the driver (device
> tree properties, swnode properties, platform_data*)?
> 

The driver uses device_property_read_* helpers to fetch the infromation 
and the mikroBUS driver populates the table of properties fetching the 
information from manifest and combining with platform information.

> On a side note, does the manifest files use the (linux) kernel
> module name for the driver-string-id?
> 

The spi_device_id is used for the driver-string-id :
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/fbtft/fbtft.h#n361

Thanks and Regards,
Vaishnav

> -michael
> 
> [1] https://github.com/MikroElektronika/click_id/blob/main/README.md
> [2] https://github.com/MikroElektronika/click_id/blob/main/manifests/OLEDB-CLICK.mnfs
> 
>> Link: https://lwn.net/Articles/715955/ Greybus
>> Link https://elinux.org/Mikrobus eLinux article
> 

