Return-Path: <linux-kernel+bounces-117347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052688AA45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B0C1C36C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEEB127B56;
	Mon, 25 Mar 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZEoLc7F"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6E6EB78;
	Mon, 25 Mar 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379794; cv=none; b=LVG5Ck/qjKk5MVeVUmH7OsOLMCDuTMG//FHnQoezBWfnTDh6Y6suFBxhGcNCFJdEEdUYqNJsP3CEuu2YbSUlr4akuq46/SWJLV3p/UUmTIiPxG4xvs04ddHPB5D4Qs8BDb68taTgg5VkkFO0eGRMJ9zG7fWPiwo3b1+Bs0nuRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379794; c=relaxed/simple;
	bh=sJHknhvLFXx6F/uFdlhS7vBBGNyIiF/G3OFP4ScZt6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2dzvHwlmApiPOCY/sLTMf0jzZuS3bstFKnzh/zrjcA4YDc8MZ70Z/XlwYRh8PJZTgj6FwWw1tddmSTwOWwjOTUFk2LsEerD3Scex0SHSb/XKn69jUmWwuckAnMfAcyEgTmdGpktnSEck9yquTmtfZJPxxPHoiKxxrr7QZklAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZEoLc7F; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 749E3E0002;
	Mon, 25 Mar 2024 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711379789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zILQTNBcTDxO5fBO/CmRnjgqLj5kaQ3+vU/H6Uz0dYo=;
	b=kZEoLc7FKXiKVU3CBxN6Ah/AykdqnLo0lW+7wxiO1XshvuSoe3nf+PA1KJ8o/NTJSzxdZV
	WrDK+WfZFj3o5KfewDU0e4oQDuUJfCXQY7ijKYDu07wjxv940/YeTZIwJSG46+mDOzgOw0
	tIgTtX6x0nK0Ae0o0b/T+6NLzYIxAvSmvSS+ZDBda72F3sd3KTUjb/LPBr1sALF1Njugwc
	uljh6vbDMjX+5wqLYTBzHkJvMoge20RleSFhAQj0st2ZQ6gRxGdsgRh5XAFn0UFLIstpXa
	9KpX7662nB9YlTwsmTXMR9NygyFrToei3gbxYMs4SIoYqx4tu3q1mZkOqIRIGA==
Date: Mon, 25 Mar 2024 16:16:27 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sui Jingfeng
 <sui.jingfeng@linux.dev>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <20240325161627.1c0fc955@bootlin.com>
In-Reply-To: <ZgF-_ww5k3h9pvEm@smile.fi.intel.com>
References: <Y/0uC1LgeWR0V0ts@smile.fi.intel.com>
	<20230227234411.jqmwshzkeyx6iqyo@skbuf>
	<Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
	<20230301143625.7kdnzujlv4psbhla@skbuf>
	<Y/9qtT0vckSikOKJ@smile.fi.intel.com>
	<20230301152527.khyzifds4w3rkebt@skbuf>
	<Y/9wlDkuh39auAgF@smile.fi.intel.com>
	<20230301171845.oliqbso7v2vmyqr3@skbuf>
	<Y/+MaRO4vrCRFXE8@smile.fi.intel.com>
	<20230301174309.5nqul7vg5uygwtpy@skbuf>
	<ZgF-_ww5k3h9pvEm@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Vladimir,

+Cc: Rob, Lizhi and Luca.

On Mon, 25 Mar 2024 15:41:19 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> +Cc: people who might be also interested in this topic.
> 
..
> > 
> > I agree we don't want to have multiple approaches of doing the same thing,
> > but I debate whether I am really doing the same thing?
> > 
> > If software nodes are not designed to be a good fit for my kind of use
> > case, then what are they designed for?  
> 
> I think the hardware should be described in the respective format. Yet, you
> have a point that it's too verbose to the cases when we know the layout of
> the attached (not-hotpluggable) devices.
> 
> There are discussions [1,2] on how to enable DT for the cases when
> non-discoverable HW needs to be detected and enumerated.
> 
> I don't know which solution will eventually be accepted, but my personal
> opinion here that we would like to distantiate from board files as much
> as possible.
> 
> Btw, for the internal (board files) code we may also use property to
> go with (see how spi-pxa2xx uses that) to distinguish configurations.
> But it might be not that straight as with driver data.
> 
> So far, I haven't seen the code (am I mistaken?) which makes use of driver data
> for software nodes.
> 
> [1]: https://lore.kernel.org/lkml/20231128084236.157152-1-wenst@chromium.org/
> [2]: https://lore.kernel.org/lkml/1692120000-46900-1-git-send-email-lizhi.hou@amd.com/
> 
> Aux topics which might not directly be related (in order of declining relevance
> from my p.o.v.):
> https://lore.kernel.org/lkml/20231130165700.685764-1-herve.codina@bootlin.com/
> https://lore.kernel.org/lkml/DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com/
> https://lore.kernel.org/lkml/20240217010557.2381548-1-sboyd@kernel.org/
> 

I work on PCI DT overlay support.
The idea is to have a PCI driver that loads a DT overlay to describe the
hardware embedded in the related PCI device. Some features related to this
topic are already upstream.

Rob did a presentation of this topic at the Linux Plumber conference last
year (https://www.youtube.com/watch?v=MVGElnZW7BQ).

IMHO, your use-case is pretty much the same. Of course it is not a PCI
device but a SPI device. Even if the device beyond the SPI bus cannot be
memory mapped, the idea seems pretty much the same: describe the hardware
embedded in a specific device.

You mentioned that you need the '-@' option when you compile your base dtb.
In fact, it depends on the resources you need to reference from your overlay.
On my case (DT overlay to describe a PCI device), I don't need any references
to a base dtb from the overlay. I don't need to use the '-@' option.
Even more, I started (not yet upstream) to use all of this feature on an ACPI
base system and it works.

My PCI device is a Microchip LAN9662 PCI device.
The Microchip LAN9962 can be a "traditional" SoC with CPU cores and several
IPs but also a PCI device.
When provided as a PCI device, the internal CPU cores are no more available
and replaced by a PCI endpoint IP.
All the accesses done by the SoC CPU cores are replaced by accesses done by
the host PCI system through the PCI endpoint.
Drivers were already present upstream (traditional SoC platform driver such
as i2c mdio, clock, switch, ...) and are used without any modifications for
the PCI device.
All the wiring (mapping) between the PCI world and the internal device
hardware is done using a DT overlay.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

