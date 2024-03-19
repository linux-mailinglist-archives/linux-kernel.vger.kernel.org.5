Return-Path: <linux-kernel+bounces-108056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB923880554
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1B1F233F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3739FED;
	Tue, 19 Mar 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kxyukcQ7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4B39FC1;
	Tue, 19 Mar 2024 19:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876248; cv=none; b=C9J2RKvIdp41X5XvC50BMaFNlXl9MmgewJ/YLd35GKHBKICjNXAcv8ogRWgIFoyF1jthBwI0pUnFIBKjT+aBYWWsexo5ewX18+RRnE+Cj2Vw0r3vcL4thmcIDey7YlwSsGaLMqp61PB6MaKiJPg0Cpogc3tcjtoajVArHpJ46lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876248; c=relaxed/simple;
	bh=UJH2kzC1Em7wmFXJxczK3eDw1rovxIWu8Rx02N/kWqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUi5pziIwUPfb/cQRUNZ2kahRHErYzzU6zlGi5LSmaDIX7KYTd2FqJqkssFQoPA5Qum8fV9jVybwld9cOjUvlAN6RSFUqz6QzTCjYaFKvKGpO00ea2AGjpz9J6VocJM9Amehp5NMlt29M1tD3CKvDVf4WGf4UjnxWpUMhn88VuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kxyukcQ7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3dk87gpZwKgp6whYfukpPS0+UxSYh70ZbjfjLRa3Yw4=; b=kxyukcQ7H5ctTHrXjmI0/F65Kx
	ygj+SYJ7Ig68VIjkHT2N7bNZ+nfnt0xc2R/RK6tIL+GgVGqedwtdnBeGGPKPbnEfm+XswybUyEABb
	gNI51K1QEFggwEGU25wow5ASDRHb4SEkeU0AKlrJnUKHzDCQNyvJwSJqPffDf2ZQw4Jg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rmf3t-00Ajf7-Hs; Tue, 19 Mar 2024 20:23:49 +0100
Date: Tue, 19 Mar 2024 20:23:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	open list <linux-kernel@vger.kernel.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: misc: Add mikrobus-connector
Message-ID: <4c299d42-84c7-46fc-952f-292cef1bb4b4@lunn.ch>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-2-ayushdevel1325@gmail.com>
 <CZWVF90JJO98.2M7ARQ9WMGC94@kernel.org>
 <d4dc4d94-d323-4158-8c08-b7d37d8750d3@gmail.com>
 <b62915ca-c151-4e37-bb03-c92c569c84ff@lunn.ch>
 <4b319264-bff7-48e5-85e8-201ca0bafec6@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b319264-bff7-48e5-85e8-201ca0bafec6@ti.com>

On Tue, Mar 19, 2024 at 11:05:37PM +0530, Vaishnav Achath wrote:
> Hi Andrew,
> 
> On 19/03/24 17:55, Andrew Lunn wrote:
> > > The device tree defines the SPI controller associated with mikroBUS SPI
> > > pins. The driver on match queries and takes a reference to the SPI
> > > controller but does nothing with it. Once a mikroBUS add-on board is
> > > detected (by passing manifest using sysfs or reading from 1-wire EEPROM),
> > > the driver parses the manifest, and if it detects an SPI device in manifest,
> > > it registers SPI device along with setting properties such as `chip_select`,
> > > `max_speed_hz`, `mode`, etc.,
> > 
> > How complex can the description of the hardware be in the manifest?
> > 
> > Could i describe an SPI to I2C converter? And then a few temperature
> > sensors, a fan controller, and a GPIO controller on that I2C bus? And
> > the GPIO controller is then used for LEDs and a push button? DT
> > overlays could describe that. Can the manifest?
> 
> No, it cannot describe such complex hardware, it can only describe simple
> devices (sensors/displays .etc) on a standard mikroBUS add-on board, we did
> a analysis on what mikroBUS add-on boards have driver support in Linux and
> then noticed that most devices does not need this kind of complex
> description to work:
> https://elinux.org/MikroEClicks_with_Linux_Support

Is that because the current software support is too limited? Are there
manufactures who want to create more complex designed, but are limited
by what can be described in the manifest?

Do you have a list of boards without Linux support? Why do they not
have Linux support? Is there a "vendor crap" driver which makes them
work? Does it make them work by working around the manifest
limitations?

> The greybus manifest already is being used in the greybus susbystem for
> describing an interface and there are already greybus controllers (SPI/I2C
> .etc) being created according to the manifest contents, all this driver does
> is to extend that format to be able to instantiate devices on these buses.

I don't know anything about greybus, so let me ask a few background
questions. Are these SPI and I2C controller plain Linux SPI and I2C
controllers? They fit the usual device model, they appear in
/sys/class/bus etc? Are the GPIO controllers also just plain Linux
GPIO controllers? All the drivers have a bottom interface which uses
greybus to perform some sort of RPC, but the top interface is standard
Linux. So in fact they are not so different to I2C over USB, SPI over
USB, GPIO over USB?

     Andrew

