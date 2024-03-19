Return-Path: <linux-kernel+bounces-107232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4743E87F9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A15F1C21A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D354775;
	Tue, 19 Mar 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vv39uHjK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2653E3F;
	Tue, 19 Mar 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836824; cv=none; b=nt7nTlhzHcvdAVTnu74yDI8v4B4x3o05meXCwlwTjFnM8ft5doDx+prfywJRTkxPcFHL+rTngbClIlx3yMfKPVLA0Y7XK+UTPGZ+etOyR/HLx5KM0EzBEFSvPzjfoPKNwU/UYJ0neUxrbJ84fh61QRJL0OPX8Y9p7PDqgh0PKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836824; c=relaxed/simple;
	bh=Bq/AA70/5q9Dxb347nnOr2s8AeJGp1yWvsl0P7aV0QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E9pjagznUhhH+z9mYfCFaffIuwkJ1qRddHMD8FfO07thKqRim8inPneJ5t/fKt3e3/xaPDXm3ls1AUkf0gwTxEt4wUE53lB57IFG6ixham9i/ZLgH+GH3T+CK0kv7QTU8ifY5kJ8UDUw5jSENVC1NXnzBpLSm/ztAezD/a3PpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vv39uHjK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42J8QbiB090324;
	Tue, 19 Mar 2024 03:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710836797;
	bh=Oz20PFNHtij4CjpERCZKBDH6sdX95lWDbXHhrBALB3Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Vv39uHjK3U/KoMzTdnafeFXWGNP57XS6IUbkMztSozHy0OQakUx8I1j1K8HD4dnJd
	 tCg3CFq5eQBQQsMsr53lDr5lNuuIAs1WNHTk5iaPIQiF4dU4ziKFdPtp0TAGYtuMvG
	 zArp4WiwB5tI3QUGBUh77iI3Qe7WNl7FjsVFAVYo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42J8Qbi1072590
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 03:26:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 03:26:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 03:26:36 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42J8QTSH052033;
	Tue, 19 Mar 2024 03:26:30 -0500
Message-ID: <6eff590b-3f4a-4824-95e7-b2a94656408b@ti.com>
Date: Tue, 19 Mar 2024 13:56:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] greybus: Add mikroBUS manifest types
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>,
        open list
	<linux-kernel@vger.kernel.org>
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
 <20240317193714.403132-4-ayushdevel1325@gmail.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240317193714.403132-4-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 18/03/24 01:07, Ayush Singh wrote:
> DONOTMERGE
> 

Why?

> mikroBUS addon boards allow using same mikroBUS connector for a wide
> range of peripherals. It is also possible for the addon board not to use
> all the pins in mikroBUS socket (marked by NC or Not Connected). This
> would require the need to create an almost new overlays for each
> permutation of the hardware.
> 
> To overcome this, a manifest format based on Greybus manifest
> specification was created which allows describing mikroBUS addon boards.
> The reason for choosing greybus manifest for the identifier is that so far
> we discussed only about physical mikroBUS ports on the board, but we can

you will need to reword the commit message properly in imperative mood, 
here and in multiple other places.

> also have mikroBUS ports on a remote microcontroller appearing on host
> over greybus and there a device tree overlay solution does not work as the
> standard identifier mechanism.
> 
> The patch introduces 3 new greybus descriptor types:
> 1. mikrobus-descriptor:
>     Is a fixed-length descriptor (12 bytes), and the manifest shall have
>     precisely one mikroBUS descriptor. Each byte describes a configuration
>     of the corresponding pin on the mikroBUS addon board in a clockwise
>     direction starting from the PWM pin omitting power (VCC and ground)
>     pins as same as the default state of the pin.
>     There are mikroBUS addon boards that use some dedicated SPI, UART, PWM,
>     and I2C pins as GPIO pins, so it is necessary to redefine the default
>     pin configuration of that pins on the host system. Also, sometimes it is
>     required the pull-up on the host pin for correct functionality
> 2. property-descriptor:
>     Are used to pass named properties or named GPIOs to the host. The host
>     system uses this information to properly configure specific board
>     drivers by passing the properties and GPIO name. There can be multiple
>     instances of property descriptors per add-on board manifest.
> 3. device-descriptor:
>     Describes a device on the mikroBUS port. The device descriptor is a
>     fixed-length descriptor, and there can be multiple instances of device
>     descriptors in an add-on board manifest in cases where the add-on board
>     presents more than one device to the host.
> 
> New mikroBUS addon boards also sometimes contain a 1-wire EEPROM with
> the mikroBUS manifest, thus enabling plug and play support.
> 

new mikroBUS sometimes contain an EEPROM? aren't these called Click ID 
compliant add-on boards? there should be clarity in the commit message.


> I have also created PR to add mikrobus descriptors in Greybus spec and I
> think the old PR on manifesto by Vaishnav should also work. However,
> both of these repositories seem to be inactive. I am guessing the
> greybus mailing list can provide more information on how I should go
> about these.

Why is information like these inside the commit message, these go below 
the tear line.


> 
> Here is a sample mikroBUS manifest:
> ```
> ;;
> ; PRESSURE CLICK
> ; https://www.mikroe.com/pressure-click
> ; CONFIG_IIO_ST_PRESS
> ;
> ; Copyright 2020 BeagleBoard.org Foundation
> ; Copyright 2020 Texas Instruments
> ;
> 
> [manifest-header]
> version-major = 0
> version-minor = 1
> 
> [interface-descriptor]
> vendor-string-id = 1
> product-string-id = 2
> 
> [string-descriptor 1]
> string = MIKROE
> 
> [string-descriptor 2]
> string = Pressure
> 
> [mikrobus-descriptor]
> pwm-state = 4
> int-state = 1
> rx-state = 7
> tx-state = 7
> scl-state = 6
> sda-state = 6
> mosi-state = 5
> miso-state = 5
> sck-state = 5
> cs-state = 5
> rst-state = 2
> an-state = 1
> 
> [device-descriptor 1]
> driver-string-id = 3
> protocol = 0x3
> reg = 0x5d
> 
> [string-descriptor 3]
> string = lps331ap
> ```
> 
> Link: https://www.mikroe.com/clickid ClickID
> Link:
> https://docs.beagleboard.org/latest/projects/beagleconnect/index.html
> beagleconnect
> Link: https://github.com/projectara/greybus-spec Greybus Spec
> Link: https://github.com/projectara/greybus-spec/pull/4 Greybus Spec PR
> Link: https://github.com/projectara/manifesto/pull/2 manifesto PR
> 

The manifesto PR might not be updated.

Thanks and Regards,
Vaishnav

> Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>   include/linux/greybus/greybus_manifest.h | 49 ++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
> index bef9eb2093e9..83241e19d9b3 100644
> --- a/include/linux/greybus/greybus_manifest.h
> +++ b/include/linux/greybus/greybus_manifest.h
> @@ -23,6 +23,9 @@ enum greybus_descriptor_type {
>   	GREYBUS_TYPE_STRING		= 0x02,
>   	GREYBUS_TYPE_BUNDLE		= 0x03,
>   	GREYBUS_TYPE_CPORT		= 0x04,
> +	GREYBUS_TYPE_MIKROBUS		= 0x05,
> +	GREYBUS_TYPE_PROPERTY		= 0x06,
> +	GREYBUS_TYPE_DEVICE		= 0x07,
>   };
>   
>   enum greybus_protocol {
> @@ -151,6 +154,49 @@ struct greybus_descriptor_cport {
>   	__u8	protocol_id;	/* enum greybus_protocol */
>   } __packed;
>   
> +/*
> + * A mikrobus descriptor is used to describe the details
> + * about the bus ocnfiguration for the add-on board
> + * connected to the mikrobus port.
> + */
> +struct greybus_descriptor_mikrobus {
> +	__u8 pin_state[12];
> +} __packed;
> +
> +/*
> + * A property descriptor is used to pass named properties
> + * to device drivers through the unified device properties
> + * interface under linux/property.h
> + */
> +struct greybus_descriptor_property {
> +	__u8 length;
> +	__u8 id;
> +	__u8 propname_stringid;
> +	__u8 type;
> +	__u8 value[];
> +} __packed;
> +
> +/*
> + * A device descriptor is used to describe the
> + * details required by a add-on board device
> + * driver.
> + */
> +struct greybus_descriptor_device {
> +	__u8 id;
> +	__u8 driver_stringid;
> +	__u8 protocol;
> +	__u8 reg;
> +	__le32 max_speed_hz;
> +	__u8 irq;
> +	__u8 irq_type;
> +	__u8 mode;
> +	__u8 prop_link;
> +	__u8 gpio_link;
> +	__u8 reg_link;
> +	__u8 clock_link;
> +	__u8 pad[1];
> +} __packed;
> +
>   struct greybus_descriptor_header {
>   	__le16	size;
>   	__u8	type;		/* enum greybus_descriptor_type */
> @@ -164,6 +210,9 @@ struct greybus_descriptor {
>   		struct greybus_descriptor_interface	interface;
>   		struct greybus_descriptor_bundle	bundle;
>   		struct greybus_descriptor_cport		cport;
> +		struct greybus_descriptor_mikrobus	mikrobus;
> +		struct greybus_descriptor_property	property;
> +		struct greybus_descriptor_device	device;
>   	};
>   } __packed;
>   

