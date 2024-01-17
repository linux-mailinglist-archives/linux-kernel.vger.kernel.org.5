Return-Path: <linux-kernel+bounces-29450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F62830E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1220EB240D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE225563;
	Wed, 17 Jan 2024 21:14:41 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF322561B;
	Wed, 17 Jan 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526081; cv=none; b=DwCB3MzUs6rhDdFlZF9kiv8WkDfHWk56fD9TxMdlw80StJfQmZJYqgKHRTgBH5rUGhM7NzU/DF2ddBD3xYWzhyO5k1kTqcHqc0lEv8+Rt5iJTOMYJxogo5lk2z2FUM366rCU9/UpTYpIwsExB0HHzxM9zBBhtM7NHVzsN97QNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526081; c=relaxed/simple;
	bh=uZZZcDpaYstX/m9EAYE17yFQT4QDVYHscrtHVl/4fIQ=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=J2baWErXdEhW4nDtUSd469MMBuIcn9hrSInQ0N5ysBYAiUaIuv1oLIwy2HrOJw4x4xUK6JPpQojQK5CAT09X0X6jcQWduVXZDbybu8SCxS4jLkGY7b94x58CWRJNLSKmhxc3Cp9a7TDVrNpUlgLLPLuwc+OBC99BBxqRAdZEpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id 06BAA7F5DA; Wed, 17 Jan 2024 23:14:30 +0200 (EET)
Date: Wed, 17 Jan 2024 23:14:30 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZahDNr97MSPNSHW_@wantstofly.org>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
 <ZaaQpiW3OOZTSyXw@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaaQpiW3OOZTSyXw@x1-carbon>

On Tue, Jan 16, 2024 at 03:20:23PM +0100, Niklas Cassel wrote:

> Hello Lennert,

Hi Niklas,

Thanks for your reply!


> > On kernel 6.6.x, with an ASMedia ASM1062 (AHCI) controller, on an

Minor correction to this: lspci says that this is an ASM1062, but it's
actually an ASM1061.  I think that the two parts share a PCI device ID,
and I've submitted a PCI ID DB change here:

https://admin.pci-ids.ucw.cz/read/PC/1b21/0612


> > ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, PCI ID 1b21:0612 and
> > subsystem ID 1043:858d, I got a total apparent controller hang,
> > rendering the two attached SATA devices unavailable, that was
> > immediately preceded by the following kernel messages:
> > 
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
> > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]
> > 
> > It seems as if the controller has problems with 64-bit DMA addresses,
> > and the comments around the source of the message in
> > drivers/iommu/dma-iommu.c seem to point into that same direction:
> > 
> >         /*
> >          * Try to use all the 32-bit PCI addresses first. The original SAC vs.
> >          * DAC reasoning loses relevance with PCIe, but enough hardware and
> >          * firmware bugs are still lurking out there that it's safest not to
> >          * venture into the 64-bit space until necessary.
> >          *
> >          * If your device goes wrong after seeing the notice then likely either
> >          * its driver is not setting DMA masks accurately, the hardware has
> >          * some inherent bug in handling >32-bit addresses, or not all the
> >          * expected address bits are wired up between the device and the IOMMU.
> >          */
> >         if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
> >                 iova = alloc_iova_fast(iovad, iova_len,
> >                                        DMA_BIT_MASK(32) >> shift, false);
> >                 if (iova)
> >                         goto done;
> > 
> >                 dev->iommu->pci_32bit_workaround = false;
> >                 dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
> >         }
> 
> The DMA mask is set here:
> https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L967
> 
> And should be called using:
> hpriv->cap & HOST_CAP_64
> https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L1929
> 
> Where hpriv->cap is capabilities reported by the AHCI controller itself.
> So it definitely seems like your controller supports 64-bit addressing.

Perhaps, or maybe it's misreporting its capabilities, as it is an old
part (from 2011 or before), and given that it doesn't seem to support
64-bit MSI addressing, either, which for a part with a 64-bit DMA engine
would be an odd restriction:

# lspci -s 28:00.0 -vv | grep -A1 MSI:
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee00000  Data: 0000
#

(I checked the available datasheets, but there is no mention of whether
or not the part supports 64-bit DMA.)


> I guess it could be some problem with your BIOS.
> Have you tried updating your BIOS?

The machine is running the latest BIOS available from the vendor at
the time of this writing, version 1201:

# dmidecode | grep -A2 "^BIOS Information"
BIOS Information
        Vendor: American Megatrends Inc.
        Version: 1201
#

Per:

	https://www.asus.com/motherboards-components/motherboards/workstation/pro-ws-wrx80e-sage-se-wifi/helpdesk_bios?model2Name=Pro-WS-WRX80E-SAGE-SE-WIFI

However, some Googling suggests that the ASM106x loads its own firmware
from a directly attached SPI flash chip, and there are several versions
of this firmware available in the wild, with different versions of the
firmware apparently available for legacy IDE mode and for AHCI mode.  If
(some of) the AHCI logic is indeed contained inside the firmware, I
could see a firmware bug leading to the controller incorrectly presenting
itself as being 64-bit DMA capable.

Some poking around in the BIOS image suggests that there is no copy of
the ASM106x firmware inside the BIOS image.  In other words, it could be
that, even though the machine is running the latest available BIOS, the
ASM1061 might be running an older firmware version.

The ASM1061 firmware does not seem to be readable from software via a
ROM BAR, and it doesn't seem to readable from software in general (the
vendor-supplied DOS .exe updater tool only allows you to erase or
update the SPI flash), so I can't check which firmware version it is
currently using.


> If that does not work, perhaps you could try this (completely untested) patch:
> (You might need to modify the strings to match the exact strings reported by
> your BIOS.)

Thanks for the patch!

I will do some tests with PCI passthrough to a VM, to see whether, and if
it does, exactly how the controller mangles DMA addresses.

I've also ordered a discrete PCIe card with an ASM1061 chip on it, and I
will perform similar tests with that card, to see exactly where the issue
is, i.e. whether it is specific to this mainboard or not.

I will follow up once I will have more information.

Kind regards,
Lennert

