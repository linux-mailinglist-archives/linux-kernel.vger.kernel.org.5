Return-Path: <linux-kernel+bounces-104953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5D87D676
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC4D1C221DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6557155C05;
	Fri, 15 Mar 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VAdU83y6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B544393;
	Fri, 15 Mar 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710540656; cv=none; b=YO3+SrFSPJgFEXGAIkm6ayLrMzQ6XbhwG0KlSjzn830uRYw06Mvf2G//pPxPb0zh7FDbHLda0rhxIXIGA64dqcIlnbOsooJfYaHQm6a0SpgV6jI/9QkGdFoATUlx6wpddpysT7C5gVTS16Tl3x0LoFogCEFTXodBrlYqQajNUwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710540656; c=relaxed/simple;
	bh=PNQJWd7HxXcJnbYgdzJBU4kUBm0Ch11S8O3iK9HqbcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DvQBHRU+ZrzT98N7+oGf7o/Itel6gc+spwPUbvB3FF8izrfJJXHi6LB9KVV87yi/7sTWIQ9wXRU+BxisBOLdCUL6GuPykDj4QBoE0M83PLKDM8DRHoCDqjVkU/AZ4aZ43wnFNufvR4RuHP5T9w3VkUd9IpMUCEkiH9NFPf2kjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VAdU83y6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42FMAInl061560;
	Fri, 15 Mar 2024 17:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710540618;
	bh=f7izHaMoJ965KSuRUF5+A7MIQq48w7B7wci0lhYv5oU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VAdU83y6bVG5zZ4WltjUGbUTQxOdcqEWzvastPiyMaNDKqsw1M/455XapO4C68Jg/
	 1getJEmUJw2wbNpzO0Mk0/gFv4VO6q3pMBqu3+ZzpVvfIY5DxgYTF834G13TCR2UBc
	 j57aHRyMOhDme6WIJzpkJaeclbbd10wyYeZGc88Y=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42FMAI3l012049
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Mar 2024 17:10:18 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Mar 2024 17:10:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Mar 2024 17:10:18 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42FMAAfW000976;
	Fri, 15 Mar 2024 17:10:11 -0500
Message-ID: <163ecd0f-3e3d-44d5-8ae4-be20ea6956a0@ti.com>
Date: Sat, 16 Mar 2024 03:40:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Ayush Singh
	<ayushdevel1325@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder
	<elder@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <greybus-dev@lists.linaro.org>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-8-ayushdevel1325@gmail.com>
 <ZfSiaT9WltBDY9yD@shell.armlinux.org.uk>
 <46ba778a-5966-4b99-b820-f0d047a56227@gmail.com>
 <ZfS7Za/KITnQiYjh@shell.armlinux.org.uk>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <ZfS7Za/KITnQiYjh@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Russell,

I had originally worked on this and will try to provide
some more context which is missing in this series. I am
replying from my TI email as I am active here.

On 16/03/24 02:49, Russell King (Oracle) wrote:
> On Sat, Mar 16, 2024 at 02:17:24AM +0530, Ayush Singh wrote:
>> On 3/16/24 01:02, Russell King (Oracle) wrote:
>>
>>> On Sat, Mar 16, 2024 at 12:19:05AM +0530, Ayush Singh wrote:
>>>> diff --git a/drivers/misc/mikrobus/Kconfig b/drivers/misc/mikrobus/Kconfig
>>>> new file mode 100644
>>>> index 000000000000..f0770006b4fe
>>>> --- /dev/null
>>>> +++ b/drivers/misc/mikrobus/Kconfig
>>>> @@ -0,0 +1,19 @@
>>>> +menuconfig MIKROBUS
>>>> +	tristate "Module for instantiating devices on mikroBUS ports"
>>>> +	depends on GPIOLIB
>>>> +	depends on W1
>>>> +	depends on W1_MASTER_GPIO
>>>> +	help
>>>> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
>>>> +	  board socket standard that offers maximum expandability with
>>>> +	  the smallest number of pins. The mikroBUS driver instantiates
>>>> +	  devices on a mikroBUS port described by identifying data present
>>>> +	  in an add-on board resident EEPROM, more details on the mikroBUS
>>>> +	  driver support and discussion can be found in this eLinux wiki :
>>>> +	  elinux.org/Mikrobus
>>> I think this is a fallacy. I have boards that support Mikrobus - some of
>>> the SolidRun products do. I have several Mikrobus "click" boards.
>>>
>>> This help text seems to imply that Mikrobus click boards include an
>>> EEPROM that identify them, hence you make the support for mikroBUS
>>> depend on it. No, this is not the case - the click boards do not
>>> contain a 1-wire EEPROM.
>>>
>>> Please fetch a copy of the official Mikrobus specification which is
>>> available here:
>>>
>>> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
>>>
>>> and rather than creating something that is implementation specific but
>>> appears to be generic, create something that is generic with
>>> implementation specific extensions.
>>
>> I think you mean mikroBUS addon boards? mikroBUS is an open socket and click
>> boards™ are MikroElektronika’s brand of mikroBUS™ add-on boards.
> 
> MikroElektronika _owns_ the standard for mikroBUS, they're the ones
> who publish it and it has their logo plastered all over it.
> 

Yes, MikroE owns the standard but they do not prevent anyone from 
creating new add-on boards or adding the sockets in commercially 
available boards, with the only condition that custom mikroBUS add-on
boards cannot be marketed with the name "click" board.

>> So I think
>> all click boards™ do have clickID support, but yes, mikroBUS spec is not the
>> same as clickID and thus are not mutually dependent.
> 
> None of the MikroElektronika "click" boards that I have (and thus
> officially produced boards) have any ID EEPROM on them, so your
> statement is false. For example, if you look at the "relay click"
> board schematic:
> 
> https://download.mikroe.com/documents/add-on-boards/click/relay/relay-click-schematic-v100-a.pdf
> 
> you will find no EEPROM.
> 
> The "relay 3" click board also doesn't:
> 
> https://download.mikroe.com/documents/add-on-boards/click/relay-3/relay-3-schematic-v100.pdf
> 
> However, the "relay 4" click board does:
> 
> https://download.mikroe.com/documents/add-on-boards/click/relay_4_click/Relay_4_Click_v100_Schematic.PDF
> 
> Now, ClickID is relatively new. Note that the mikroBUS standard dates
> from 2011, with v2 coming out in 2015. A blog post introducing ClickID
> was posted in November 2023, just some 5 months ago, so that leaves an
> awful lot of click boards out there at the moment which have no EEPROM
> on them.
> 
> If what you have written assumes that all click boards have this EEPROM
> then you are - in my opinion - intolerably constraining the usefulness
> of your idea for those of us who have click boards bought over the past
> few years, and this will confuse users who have these older boards.
> "I've enabled mikroBUS support in the kernel, but my board isn't
> recognised" will probably end up being a regular cry from people with
> this.
> 
> So, I think you need to consider how to support the already vast number
> of click boards that do not support ClickID.
> 

The same series actually can support mikroBUS add-on boards without 
EEPROM as well, it exposes a sysfs interface similar to i2c new_device,
so all you need to do is to plug-in the add-on board, the pass the 
manifest using this interface.
Example :
cat /lib/firmware/mikrobus/AMBIENT-2-CLICK.mnfb > 
/sys/bus/mikrobus/devices/mikrobus-0/new_device

Reference: 
https://docs.beagleboard.org/latest/boards/beagleplay/demos-and-tutorials/using-mikrobus.html#what-if-my-add-on-doesn-t-have-clickid

I am not sure if passing binary manifest blob using the sysfs interface 
is an ideal solution, but the driver can support boards without EEPROM.
Actually the 150+ boards we have validated in the past did not have 
EEPROM on all of them : 
https://github.com/MikroElektronika/click_id/tree/main/manifests

> At the moment, my own personal solution is currently to hack the
> platform's DT file for the board I wish to use, creating a new variant
> of the platform which configures the SoC so the mikroBUS connector pins
> are appropriately configured. It would be good to get away from the need
> to do that.

Yes, the pain point with creating device tree overlays for mikroBUS 
add-on boards is that you need an almost new overlays for each 
permutation of the hardware (150+ add-on boards with driver support in 
Linux connected on just BeagleBoard platforms like BeaglePlay[1 port], 
PocketBeagle [2 port], mikroBUS cape on BB black[4 ports]) is more than
1000 overlays to maintain, this driver aims to split the platform 
aspects of mikroBUS (pinmux, SPI/I2C/GPIO controller .etc) from the 
add-on board information, thus requiring one device tree overlay per 
port and just a single manifest describing the add-on board.

The reason for choosing greybus manifest for the identifier is that so 
far we discussed only about physical mikroBUS ports on the board, but we 
can also have mikroBUS ports on a remote microcontroller appearing on 
host over greybus and there a device tree overlay solution does not work 
as the standard identifier mechanism is greybus manifest, some details 
on the remote greybus mikrobus port is available here:

https://docs.beagleboard.org/boards/beagleconnect/technology/index.html

Here is an old video of the concept working: 
https://www.youtube.com/watch?v=JKrCRRuCw3c

To summarise, the driver with proper fixes and feedback incorporated can 
support mikroBUS Click ID boards(plug and play), existing mikroBUS 
add-on boards (with a clean way to pass the manifest to driver, slight 
manual intervention compared to click ID boards) and also mikroBUS 
add-on board connected to a remote microcontroller appearing over 
greybus (not part of the series, but mentioning it so that it is clear 
why greybus manifest is chosen as the descriptor format).

Thanks and Regards,
Vaishnav



> 

