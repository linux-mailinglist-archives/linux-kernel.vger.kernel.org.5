Return-Path: <linux-kernel+bounces-109714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE9A881CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0901F21C23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6250267;
	Thu, 21 Mar 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nhmui8e1"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E552F70;
	Thu, 21 Mar 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711004893; cv=none; b=CSGA6cQQi25yGK65yHJ4c6XpF5w4ql+4fWLJxndVGx/Naj2w13XArA2z0FFzTgtOuSWRC0g3X/HGNk/UkSYS5eJjFA3nyTfu+2M/Jy7HEzaU9WZqVbLsUvde+iiCOlbPCjOeqPbh0x9hllOXbOR8+6DMcat4Q0loN2DnALVK2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711004893; c=relaxed/simple;
	bh=uy0mTMJPuf2amvrZ+mjeLMK5I7Cy7ICcR146zGb66mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ltcv8jaIjUeEbvwV1JN4bCVnL1YYlHshROzFf0+bRSzGNP4sKYNCl7ZAU5P/rS+4oxhFMpCJ/6nfBQ33dMJ8mcUIHD8X/kL07/FURvm6YjpANyX0cc8m5w7JDCo7cBwvmeRTFvJWSZ8eGtjzQILaQ6vawKsSo9TQV+V3HFLRseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nhmui8e1; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42L77nEt070288;
	Thu, 21 Mar 2024 02:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711004869;
	bh=bIbFFh/UMsEvkruGmEgvqDcn1jVngW3XTM1axT6qu7o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nhmui8e10qPiqSjzmEiVMY44RZTmLLgWOr1ri0bgQYQxOPVz4EgLy6gsvfSSLA9/j
	 LX2/nOTWOEt+rzZKnpnHT63nyPQ8Hg7PmQADb96UkGGoJx71twPLG4keSj8lLjYCTn
	 5OmdA2QEeO2zNn2QBpFlX0I4mFDnY/BJ83IaCATk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42L77nnh010129
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Mar 2024 02:07:49 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Mar 2024 02:07:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Mar 2024 02:07:49 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42L77eHF097425;
	Thu, 21 Mar 2024 02:07:41 -0500
Message-ID: <ded6c350-4c70-4a26-8b18-6605dcc6e084@ti.com>
Date: Thu, 21 Mar 2024 12:37:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Ayush Singh <ayushdevel1325@gmail.com>, Michael Walle <mwalle@kernel.org>,
        open list <linux-kernel@vger.kernel.org>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>, <lorforlinux@beagleboard.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
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
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <4c299d42-84c7-46fc-952f-292cef1bb4b4@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 20/03/24 00:53, Andrew Lunn wrote:
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
> Is that because the current software support is too limited? Are there
> manufactures who want to create more complex designed, but are limited
> by what can be described in the manifest?
> 

most mikroBUS add-on boards in production lies in the category of 
sensors, displays, connectivity, mixed signal (ADC/DAC .etc) and if you 
look at the existing bindings under bindings/iio/ , most devices need 
only simple descriptions and the properties are mainly standard bus 
properties (SPI/I2C properties), IRQ, named-gpios, named properties, 
regulators, clocks the extension to manifest was made taking this into 
account and the named property description interface just maps the 
manifest entries to the unified device property interface under 
include/linux/property.h

> Do you have a list of boards without Linux support? Why do they not
> have Linux support? Is there a "vendor crap" driver which makes them
> work? Does it make them work by working around the manifest
> limitations?
> 

I did the survey in 2020, close to 600 board did not have Linux support 
and 150 board had support then, the boards which did not have Linux 
support was mostly because there was no corresponding driver present and 
a lot of these were similar to the 150 that had support (IIO sensors, 
ADC, DACs .etc), there is no vendor(Example MikroElektronika) drivers 
being maintained, so I am not sure if there are drivers working around 
limitations of manifests , but for the 150 boards that we have tested 
support we never had to make any changes to the underlying device 
drivers to be supported.

>> The greybus manifest already is being used in the greybus susbystem for
>> describing an interface and there are already greybus controllers (SPI/I2C
>> .etc) being created according to the manifest contents, all this driver does
>> is to extend that format to be able to instantiate devices on these buses.
> 
> I don't know anything about greybus, so let me ask a few background
> questions. Are these SPI and I2C controller plain Linux SPI and I2C
> controllers? They fit the usual device model, they appear in
> /sys/class/bus etc? Are the GPIO controllers also just plain Linux
> GPIO controllers? All the drivers have a bottom interface which uses
> greybus to perform some sort of RPC, but the top interface is standard
> Linux. So in fact they are not so different to I2C over USB, SPI over
> USB, GPIO over USB?

They are very similar and all the details you mentioned are correct, I 
will provide some comments on the DT proposal you made and why we could 
not implement that approach initially, primarily it is because PCIe and 
USB has OF device tree support and USB interface nodes are children of 
USB device nodes and there is some hardware parent we can tie USB 
interface to and share/derive the of_node, but in case of greybus we 
could not find such mapping - looking at your proposal that is more 
maintainable in the long term, have some doubts regarding the proposal 
will post in the other thread.

Thanks and Regards,
Vaishnav

> 
>       Andrew

