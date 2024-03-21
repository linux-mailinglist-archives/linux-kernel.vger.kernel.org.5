Return-Path: <linux-kernel+bounces-109731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD58854F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF181F22313
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB03057318;
	Thu, 21 Mar 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TziBhDd+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C548C153;
	Thu, 21 Mar 2024 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711006552; cv=none; b=IkboqDqFLB3d5F9YiSnuXRPMv9YZ/Mm1l5DfYwL4UpGHw3Gv0YpiZtjO5WxAPzqjhtOQTO460EBBaAEwQfpmrezoHkklChgQerxFUKNorVgM2UoVfNZOUfCpM/q9PIaR3Banyxb1dRzUmpg5gO4PQDvukgWaF94gFlu0U3Ba9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711006552; c=relaxed/simple;
	bh=l3XHxGpUD80HFnlqU/qXkkV/AbISSLG1O1P8bH0VDto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KGKrPPPTGS3tR50K3x1TGp2mVNVAH0pB1b7xwWbURgZoRCnhVAB8I8/YCqQQmCfn3jGWRQHPWSknHOaajg2e+AN8qsxCDBIWoiVskp6pRDepxyDG+Nat+cdMPXVkwATeNcJY5mFyty7df5q2K0mysM3bj8Bm5S+HTy1nk4ee78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TziBhDd+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42L7ZNbo075909;
	Thu, 21 Mar 2024 02:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711006523;
	bh=KwkoU2lZ2JJrHgYrLkBhgW9349Ie/raH4I2wZXm5JMg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TziBhDd+1T3XNQLxwtjzovjhnP5ZpmM4lDDTU/rRLJfwdv9pfMJcoydM01QQj/TR+
	 82qgkKqAjEDBTEbQRD4gyrcO93UioSTe2xx6VAxWRyN4QUoJGhO5YSEM2grkg5pjnW
	 B2tII4pDMVk0LI343dXLgxReSaPwXoRnfmr6Ll44=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42L7ZN4f017132
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Mar 2024 02:35:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Mar 2024 02:35:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Mar 2024 02:35:22 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42L7ZFxT004743;
	Thu, 21 Mar 2024 02:35:16 -0500
Message-ID: <9ea69bd3-977d-442e-aacc-3c819b1a5630@ti.com>
Date: Thu, 21 Mar 2024 13:05:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Ayush Singh <ayushdevel1325@gmail.com>
CC: Michael Walle <mwalle@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
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
References: <c8031e17-5ae8-4794-8b8c-1736be6452d3@gmail.com>
 <CZXMK3W52AFO.1APK080GVJESK@kernel.org>
 <5a9b1cd9-05ec-4606-92b6-eadbc7af6202@gmail.com>
 <CZXPQZY8PUGE.QZM8XSOUNMT4@kernel.org>
 <81ec4156-8758-406e-876b-5acf13951d09@gmail.com>
 <CZXSKOLK6S1S.N86E2AZG2V90@kernel.org>
 <2eec6437-dd11-408d-9bcb-92ba2bee4487@ti.com>
 <28c995cb-1660-435f-9ee4-1195439231f0@gmail.com>
 <f53cd006-5eb0-47f2-8f84-e7915154f12d@lunn.ch>
 <c3223f90-6e7c-4fdc-905a-770c474445e2@gmail.com>
 <c368ee3b-1b80-46b1-9aa7-b7fc0094e3a1@lunn.ch>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <c368ee3b-1b80-46b1-9aa7-b7fc0094e3a1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 21/03/24 00:14, Andrew Lunn wrote:
> On Wed, Mar 20, 2024 at 10:09:05PM +0530, Ayush Singh wrote:
>> On 3/20/24 01:02, Andrew Lunn wrote:
>>
>>>> Yes, after discussion with Vaishnav and trying to brainstorm some way to do
>>>> the same thing with dt overlays, it seems that trying to use dt overlays
>>>> will mean need to have completely separate implementation of mikroBUS for
>>>> local ports and mikroBUS over greybus.
>>> Could you explain why please?
>>>
>>> Are greybus I2C bus masters different from physical I2C bus masters?
>>> Are greybus SPI bus masters different from physical SPI bus masters?
>>
>> Well, they are virtual, so they are not declared in the device tree. I have
>> linked the greybus i2c implementation. It basically allocates an i2c_adpater
>> and then adds it using `i2c_add_adapter` method. This adapter can then be
>> passed to say mikroBUS driver where it can be used as a normal i2c_adapter,
>> and we can register the device to it.
> 
> Being virtual does not really stop it being added to the DT.
> 
> I'm making this all up, but i assume it will look something like this:
> 
> greybus@42 {
>          compatible = "acme,greybus";
>          reg = <0x42 0x100>;
> 
> This would represent the greybus host controller.
> 
> 	module@0 {
> 		 reg = <0>;
> 
> This would represent a module discovered on the bus. I assume there is
> some sort of addressing? The greybus core code dynamically creates the
> node in DT to describe the modules it has discovered. This is not too
> different to USB. You can already describe USB devices in DT, but the
> assumption is you know they exists, e.g. because they are hard wired,
> not hot-plugable. The USB core will associate the USB device with the
> node in DT. But actually creating a node in DT is not too big a jump.
> 
> 		interface@0 {
>       			compatible = "greybus,i2c";
> 			reg = <0>;
> 		}
> 		interface@1 {
>       			compatible = "greybus,spi";
> 			reg = <1>;
> 		}
> 		interface@10 {
>       			compatible = "greybus,gpio";
> 			reg = <10>;
> 		}
> 
> It can then enumerate the interfaces on the module, and create the I2C
> node, SPI bus node, the gpio controller etc. Again, the greybus core
> can add nodes to DT to described the discovered hardware, and
> associate them to the linux devices which are created.
> 

This proposal looks great and would be the ideal solution, but we met 
with few challenges when initially trying to implement something like 
this and had to drop and take the route with minimal development effort 
to just instantiate mikroBUS devices.

 From what we understand, you are recommending to change the manifest 
description format used by greybus to device tree and also add of_bus 
support for greybus - now this will not only solve instantiating 
mikrobus devices on greybus but even complex devices on greybus making 
it a robust solution and using standard tools and support DT offers.

However we have a few doubts:
* For USB or PCIe, to add OF device tree support the parent devices are 
physically present, for example USB device is a child node of USB 
controller (physically description available in a SoC DT) and USB 
interfaces are child of USB devices, how would that hierarchy look for 
greybus devices?
Would it be
USB/UART/transport controller -> AP Bridge host controller -> Module -> 
interface -> bundle -> CPort ?

When this mikrobus driver was initially implemented we could not think 
of such an approach as the SVC and Control functionality were 
implemented in userspace with gbridge ( 
https://github.com/anobli/gbridge ) with a netlink interface to kernel 
greybus, but today there are references to do it completely in kernel ( 
drivers/greybus/gb-beagleplay.c) and your proposal is implementable.

Also with this the manifesto tool which is not very well maintained is 
not necessary : https://github.com/projectara/manifesto

> That gives you what you need to load a DT overlay to make use of these
> devices. That overlay would contain one of your virtual mikroBUS
> controllers. This virtual controller is basically a phandle-proxy. The
> virtual mikroBUS controllers is a consumer of phandles to an I2C bus,
> an SPI bus, GPIO bus which makes up the pins routed to the mikroBUS
> connector. The virtual mikroBUS controllers is also a provider of an
> I2C bus, an SPI bus, GPIO controller. The mikroBUS device consumes
> these I2C bus, SPI bus etc. The virtual mikroBUS controllers makes it
> simpler for the device to find the resources it needs, since they are
> all in one place. For a physical mikroBUS you have a DT node with
> phandles to the physical devices. For greybus you create a virtual
> device with phandles to the virtual devices added to the DT bus.
> 
> You then have everything you need to describe the mikroBUS
> devices. For very simple devices you convert the manifest to a DT
> overlay and load it. For complex devices you directly use a DT
> overlay.
> 
> I also don't see any need to do the manifest to DT overlay conversion
> on the fly. You have a database of manifests. They could be converted
> to DT and then added to the linux-firmware repo, for example. If
> device with an unknown manifest is found,

  How do we know if we found a device with unknown manifest if we don't 
read the EEPROM?

  it should be possible to
> read the manifest in userspace via its eeprom in /sys/class/. An tool
> could create DT blob and add it to /lib/firmware to get it working
> locally, and provide suggestions how to contribute it to the linux
> firmware project?

Agreed, but on what basis will you load the particular manifest for a 
add-on board if you are not reading the DT overlay (or manifest blob) 
from the EEPROM?

Thanks and Regards,
Vaishnav

> 
>     Andrew

