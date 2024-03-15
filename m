Return-Path: <linux-kernel+bounces-104957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8E087D689
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FE01F236C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFA56B6E;
	Fri, 15 Mar 2024 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jBvuTU4P"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CADC5786D;
	Fri, 15 Mar 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541504; cv=none; b=H78d8rrlVR9ed+C70wQprQL5NcXXNKloFmM4zkSF2f4T09LRymx/+ZZOsMB9QetkVDRGd2qp8OixPf5gWcJTIvZYyo2F9NgDGJvzjEL26+ZWph5NU0hC+LqMUMv/NanR7dmpk0j0uxTSOaXhBS1pss2yBEPuu9FYD/hN8pWdzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541504; c=relaxed/simple;
	bh=gKI0QRm4j0OzFx550DCprUCTtsOsFDxWULN64dYYzgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t2ociWNmKgKjTXDkPJLCeYTTMsgKS+Dk9Ys09SPf2JzTgca3MbwGSIk+dAaKD2hNADCrxvQXVmaHKMFBoDvABIPdHq+5nDRrq7xcuxAMwt3aBSNqgY+pE5CwZQ2r8phIU7ngQjUWO5Um7Rg8nbWtRElasvrX+QpHHkBU4emvI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jBvuTU4P; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42FMOfxG011563;
	Fri, 15 Mar 2024 17:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710541481;
	bh=sunSCv/xsSqCGdvTZwCoW4fTMw2WHemLRRzjRRph9NY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jBvuTU4P08Sr6AXJEEFsx7iQxUeB+1wh1WGgVav7oK2O6eqstVD+Uzpl7qiMKLmkK
	 hteAl5XWb4L3CA2/jgPVsQx/lWnfAIZIEBEKMwLPXkTnIAXcHZvt6pUjcc5SoUyCt2
	 f0AFmdbUn8/p+wyXDM+azKa1u6KRZ+KlTdffos9A=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42FMOfAa075965
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Mar 2024 17:24:41 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Mar 2024 17:24:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Mar 2024 17:24:41 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42FMOYsO015919;
	Fri, 15 Mar 2024 17:24:34 -0500
Message-ID: <0f38a3e1-c056-47be-bbaa-fc793c753780@ti.com>
Date: Sat, 16 Mar 2024 03:54:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] misc: Add mikroBUS driver
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>,
        Vaishnav M A
	<vaishnav@beagleboard.org>
CC: <linux-kernel@vger.kernel.org>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>, Rob Herring <robh@kernel.org>,
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
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder
	<elder@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <greybus-dev@lists.linaro.org>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <CALudOK5v_uCUffxHGKS-jA-DKLNV7xwmKkxJwjHaMWWgDdPDqA@mail.gmail.com>
 <656ca446-9e56-4879-bb42-cd29063e0a82@gmail.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <656ca446-9e56-4879-bb42-cd29063e0a82@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Ayush,

On 16/03/24 03:11, Ayush Singh wrote:
> On 3/16/24 02:50, Vaishnav M A wrote:
> 
>> Hi Ayush,
>>
>> On Sat, Mar 16, 2024 at 12:19 AM Ayush Singh 
>> <ayushdevel1325@gmail.com> wrote:
>>> MikroBUS is an open standard  developed by MikroElektronika for 
>>> connecting
>>> add-on boards to microcontrollers or microprocessors. It essentially
>>> allows you to easily expand the functionality of your main boards using
>>> these add-on boards.
>>>
>>> This patchset adds mikroBUS as a Linux bus type and provides a driver to
>>> parse, and flash mikroBUS manifest and register the mikroBUS board.
>>>
>> As Russel had provided the feedback, this patchset does not add support
>> for mikrobus, but a subset of mikrobus add-on boards which have a
>> 1-wire click ID EEPROM with an identifier blob that is similar to the 
>> greybus
>> manifest. This series lacks the necessary context and details to the
>> specifications that is implemented.
>>
>> https://www.mikroe.com/clickid - you should atleast point to this specs.
>>
>>> The v1 and v2 of this patchset was submitted by Vaishnav M A back in
>>> 2020. This patchset also includes changes made over the years as part of
>>> BeagleBoards kernel.
>>>
>>> Link: https://www.mikroe.com/mikrobus
>>> Link: https://docs.beagleboard.org/latest/boards/beagleplay/
>>> Link: 
>>> https://lore.kernel.org/lkml/20200818124815.11029-1-vaishnav@beagleboard.org/ Patch v2
>>>
>> Thank you for making the effort to upstream this, arriving at the
>> latest revision of the public available click ID hardware took almost 
>> 2-3 years
>> and I could not personally keep up with upstreaming, my sincere 
>> apologies to
>> the maintainers that provided feedback on the earlier revisions. I 
>> hope an
>> updated version of this series lands upstream with your work as the  
>> efforts
>> made at BeagleBoard.org Foundation makes development simpler by adding
>> plug and play support to these add-on boards. Also this series 
>> mentions only
>> the case where mikroBUS port is present physically on the board, but 
>> there
>> can be mikroBUS ports appearing over greybus and that is the reason why
>> greybus manifest was chose as descriptor format - the series needs to
>> describe these details so that a reviewer has the necessary information
>> to review your patches. A link to beagleconnect is also helpful to 
>> reviewers.
>>
>> https://docs.beagleboard.org/latest/projects/beagleconnect/index.html
> 
> 
> Yes, I left out the mikroBUS over greybus patches for now since this 
> patch series is already too big.
> 

Agreed, I would recommend splitting this series into logically separate 
changes, for example the W1 EEPROM driver could be separate, some extra 
features on the mikroBUS driver could be separate patches or be part of 
a separate series later.

>>> Changes in v3:
>>> - Use phandle instead of busname for spi
>>> - Use spi board info for registering new device
>>> - Convert dt bindings to yaml
>>> - Add support for clickID
>>> - Code cleanup and style changes
>>> - Additions required to spi, serdev, w1 and regulator subsystems
>>>
>>> Changes in v2:
>>> - support for adding mikroBUS ports from DT overlays,
>>> - remove debug sysFS interface for adding mikrobus ports,
>>> - consider extended pin usage/deviations from mikrobus standard
>>>    specifications
>>> - use greybus CPort protocol enum instead of new protocol enums
>>> - Fix cases of wrong indentation, ignoring return values, freeing 
>>> allocated
>>>    resources in case of errors and other style suggestions in v1 review.
>>>
>>> Ayush Singh (7):
>> It looks like the version you have sent is very similar to the
>> version I had previously updated for Beagleboard git with
>> only rebases and cleanup, but I don't see major functional
>> changes. I request you give credit to the original author
>> atleast as a Co-author with Co-developed by tag, As there
>> there was a significant amount of work done by myself to
>> come up with this specs and get everything working on close
>> to 150 mikrobus add-on boards on physical mikroBUS ports
>> and over greybus:
>> https://github.com/vaishnavachath/manifesto/tree/mikrobusv3/manifests
> 
> Yes, I will add Co-author and Co-developed tags. I think I should use 
> your ti email? I would have preferred to keep you as the author in the 
> git commit but I could not get the patches applied cleanly back when I 
> tried it.
> 

Thank you, please keep yourself as the primary author as you are putting 
in the effort to get the driver upstream and you will need to work on 
multiple revisions to address maintainer feedback and I feel you should 
get credit for that, please put my BeagleBoard.org e-mail with 
Co-developed-by tag as most of the work was done before I moved to the 
Linux team at TI.

>> The driver today is poorly written and was one of the first
>> Linux kernel development work I did while I was still in college
>> so I might have made a lot of blunders and just rebasing and
>> reposting will not get this to an acceptable state, here is what
>> I would recommend:
>>
>> * Drop all the unnecessary changes in the mikroBUS driver to
>> support fixed-regulators, fixed-clocks, serdev device .etc and
>> implement minimal changes to support the mikroBUS clickid
>> devices.
>>
>> * Provide necessary justification to why the particular descriptor
>> format (greybus manifest) is chosen, with pull request to manifesto
>> and greybus-specification.
>> https://github.com/projectara/greybus-spec
>> and similar to : https://github.com/projectara/manifesto/pull/2
>>
>> * Move the mikrobus W1 driver to w1/ subsytem, it is a standard
>> W1 EEPROM driver (also a standard part with updated family code)
>> * Keep a RFC series of changes where mikroBUS ports can appear over
>> greybus to justify why the identifier format needs to be extended greybus
>> manifest.
>>
>>>    dt-bindings: misc: Add mikrobus-connector
>>>    w1: Add w1_find_master_device
>> Dependent patches that goes to different subsytems should
>> be sent first separately to avoid confusion and then your series
>> should mention the necessary dependencies. (same for
>> spi).
>>
>>>    spi: Make of_find_spi_controller_by_node() available
>>>    regulator: fixed-helper: export regulator_register_always_on
>>>    greybus: Add mikroBUS manifest types
>>>    mikrobus: Add mikrobus driver
>>>    dts: ti: k3-am625-beagleplay: Add mikroBUS
>> Send this patch as DONOTMERGE till your bindings are
>> accepted.
> 
> Thanks, should I just add it in the message body? I cannot see anything 
> in docs about that.
> 

The reasoning behind this is that these patches go in to separate 
maintainer trees and without the bindings merged first the device tree 
changes cannot be validated, thus it is a usual practice to get the 
bindings and driver merged first and the device tree changes to go in 
the next cycle. Another alternative is you can point to your fork with 
all the changes together.

>>> Vaishnav M A (1):
>>>    serdev: add of_ helper to get serdev controller
>>>
>> Drop this from initial series,
>> I will provide further feedback from my TI e-mail,
>> Vaishnav Achath <vaishnav.a@ti.com>
>>
>> Thank again for taking this up,
>>
>> Thanks and Regards,
>> Vaishnav
>>
>>>   .../bindings/misc/mikrobus-connector.yaml     | 110 ++
>>>   MAINTAINERS                                   |   7 +
>>>   .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |  76 +-
>>>   drivers/misc/Kconfig                          |   1 +
>>>   drivers/misc/Makefile                         |   1 +
>>>   drivers/misc/mikrobus/Kconfig                 |  19 +
>>>   drivers/misc/mikrobus/Makefile                |   6 +
>>>   drivers/misc/mikrobus/mikrobus_core.c         | 942 ++++++++++++++++++
>>>   drivers/misc/mikrobus/mikrobus_core.h         | 201 ++++
>>>   drivers/misc/mikrobus/mikrobus_id.c           | 229 +++++
>>>   drivers/misc/mikrobus/mikrobus_manifest.c     | 502 ++++++++++
>>>   drivers/misc/mikrobus/mikrobus_manifest.h     |  20 +
>>>   drivers/regulator/fixed-helper.c              |   1 +
>>>   drivers/spi/spi.c                             | 206 ++--
>>>   drivers/tty/serdev/core.c                     |  19 +
>>>   drivers/w1/w1.c                               |   6 +-
>>>   drivers/w1/w1_int.c                           |  27 +
>>>   include/linux/greybus/greybus_manifest.h      |  49 +
>>>   include/linux/serdev.h                        |   4 +
>>>   include/linux/spi/spi.h                       |   4 +
>>>   include/linux/w1.h                            |   1 +
>>>   21 files changed, 2318 insertions(+), 113 deletions(-)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
>>>   create mode 100644 drivers/misc/mikrobus/Kconfig
>>>   create mode 100644 drivers/misc/mikrobus/Makefile
>>>   create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
>>>   create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
>>>   create mode 100644 drivers/misc/mikrobus/mikrobus_id.c
>>>   create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
>>>   create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
>>>
>>>
>>> base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
>>> -- 
>>> 2.44.0
>>>
> 
> I guess I will start with only i2c and spi support and go from there.
> 

Agreed, even with those you can get close to 100 add-on boards working.
But do keep the extension to the greybus manifest .etc for all 
buses/devices so that approvals for extending the greybus manifest is 
common.

Thanks and Regards,
Vaishnav

Thanks and Regards,
Vaishnav
> 
> Ayush Singh
> 
> 

