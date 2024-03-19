Return-Path: <linux-kernel+bounces-107920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBE188038F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69C2284460
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A720332;
	Tue, 19 Mar 2024 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="trZHbNJo"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8E19BDC;
	Tue, 19 Mar 2024 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869766; cv=none; b=Soa/bMdDEAf2Pl91+51P8GpqGzP9Xqx3tBZJOPe7j4ulBC24JnAJ828eId7ql4T+5hiZ8DSzD4Bl7m/g7iyrKhXuN8dFYG2x9aKcOjTlYXePYPQ8rfNnDVsHkV1pgZ5JN3muc+g99hSYYP4KNJ2VAhaF3RMwgN2e7UZM9fCkQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869766; c=relaxed/simple;
	bh=tk3YWbCjBAgqaMu3m4ZPt5MZ1O447J6fwx7jDX/IqvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rlyymmKLgqPeYWa2HTFTUyZdC8jfIOrUDnTDNRl7E5OuIuLz/aCDcCF2O3wG34AFNQIHfrQO7dXuBxfV6H2sZvvzP2AauD17s71r1JbfLWY9Csvx0qSAnawyOHJTl4eOamiu9Cio0sWrSqXGxOCu4EMhTSAIsVrY3f3p3jPq/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=trZHbNJo; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JHZjQD096712;
	Tue, 19 Mar 2024 12:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710869745;
	bh=efpn64adRKaugLUnDIE4XDjDeD0LJO7uSxUeR2TSGJU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=trZHbNJoztj0Z0zu4ijAbHvGQFtHrelyonZLzHqkAJ39ueEhDA479t1QAbVB3TeJe
	 Ol37n80AZokPGDr51uNzBI4PTEKDUsSxayR7lrjYIDnfw8AVhZntlA97z4WnVwq+Ql
	 8SO2A4QeKeGHsysezdvVeCfbPo9LTIJsovFlWo0Y=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JHZjeN035903
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 12:35:45 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 12:35:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 12:35:45 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JHZbRI026612;
	Tue, 19 Mar 2024 12:35:38 -0500
Message-ID: <4b319264-bff7-48e5-85e8-201ca0bafec6@ti.com>
Date: Tue, 19 Mar 2024 23:05:37 +0530
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
        open list
	<linux-kernel@vger.kernel.org>, <jkridner@beagleboard.org>,
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
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <b62915ca-c151-4e37-bb03-c92c569c84ff@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 19/03/24 17:55, Andrew Lunn wrote:
>> The device tree defines the SPI controller associated with mikroBUS SPI
>> pins. The driver on match queries and takes a reference to the SPI
>> controller but does nothing with it. Once a mikroBUS add-on board is
>> detected (by passing manifest using sysfs or reading from 1-wire EEPROM),
>> the driver parses the manifest, and if it detects an SPI device in manifest,
>> it registers SPI device along with setting properties such as `chip_select`,
>> `max_speed_hz`, `mode`, etc.,
> 
> How complex can the description of the hardware be in the manifest?
> 
> Could i describe an SPI to I2C converter? And then a few temperature
> sensors, a fan controller, and a GPIO controller on that I2C bus? And
> the GPIO controller is then used for LEDs and a push button? DT
> overlays could describe that. Can the manifest?

No, it cannot describe such complex hardware, it can only describe 
simple devices (sensors/displays .etc) on a standard mikroBUS add-on 
board, we did a analysis on what mikroBUS add-on boards have driver 
support in Linux and then noticed that most devices does not need this 
kind of complex description to work:
https://elinux.org/MikroEClicks_with_Linux_Support

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

The greybus manifest extensions were made with the following things in 
mind and three new descriptor were introduced:
1) mikrobus descriptor - pinmux/port state
2) device descriptor - contains information which is a superset of 
struct i2c_board_info , struct spi_board_info .etc
3) property descriptor - to describe named properties of the types 
defined under 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/property.h#n22

With these we were able to test around 150 add-on boards with 
corresponding drivers in Linux : 
https://github.com/MikroElektronika/click_id/tree/main/manifests

The mechanism is not as robust a device tree and should not be compared, 
the intent was not to create a new hardware description format, but 
extend the existing greybus manifest format to be able to instantiate 
devices on the greybus SPI/I2C/GPIO/ (mikroBUS)

Thanks and Regards,
Vaishnav


> 
> 	Andrew

