Return-Path: <linux-kernel+bounces-27461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6982F076
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD0E28250D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405101BF26;
	Tue, 16 Jan 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEEgMqJR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083A1BDFD;
	Tue, 16 Jan 2024 14:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B176AC433C7;
	Tue, 16 Jan 2024 14:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705414828;
	bh=s3MaVUzUaiBM2JgZKhqzcpejtJtUYM+TF+W2d4L3Rzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEEgMqJRMyQjKgUcwL32FCJcgiCOXPZ8SQfzGWsLZld49moLHRcb/LsTpXJcCL2/I
	 1QvkEeA4R9hfPbXs8K2Nwq8x+7BsDzzFnl2heeprJ7GoA4E8Q7irb4ErU8NJeGD7em
	 fD+GIWPyGk2I2K7KqS4TWQ6oIIhnSXaPULRyUeieniB+YGBjZ922aHc4Zh3BiXZ7VA
	 XZSTUC61uSd7LfT5WTVWQkrVIkH3FlUDvRieN+0XHSsnEwnkauakmLHYzRWZE5QDpd
	 8p4v/1LChr7SqOl/TS5cljpAhXh3vYKN5SidIQxKFlokN0cVWiX4WoEHLN9DCAtuTn
	 iU5p07liJRwXQ==
Date: Tue, 16 Jan 2024 15:20:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZaaQpiW3OOZTSyXw@x1-carbon>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaZ2PIpEId-rl6jv@wantstofly.org>

Hello Lennert,

On Tue, Jan 16, 2024 at 02:27:40PM +0200, Lennert Buytenhek wrote:
> Hi,
> 
> On kernel 6.6.x, with an ASMedia ASM1062 (AHCI) controller, on an
> ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, PCI ID 1b21:0612 and
> subsystem ID 1043:858d, I got a total apparent controller hang,
> rendering the two attached SATA devices unavailable, that was
> immediately preceded by the following kernel messages:
> 
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]
> 
> It seems as if the controller has problems with 64-bit DMA addresses,
> and the comments around the source of the message in
> drivers/iommu/dma-iommu.c seem to point into that same direction:
> 
>         /*
>          * Try to use all the 32-bit PCI addresses first. The original SAC vs.
>          * DAC reasoning loses relevance with PCIe, but enough hardware and
>          * firmware bugs are still lurking out there that it's safest not to
>          * venture into the 64-bit space until necessary.
>          *
>          * If your device goes wrong after seeing the notice then likely either
>          * its driver is not setting DMA masks accurately, the hardware has
>          * some inherent bug in handling >32-bit addresses, or not all the
>          * expected address bits are wired up between the device and the IOMMU.
>          */
>         if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
>                 iova = alloc_iova_fast(iovad, iova_len,
>                                        DMA_BIT_MASK(32) >> shift, false);
>                 if (iova)
>                         goto done;
> 
>                 dev->iommu->pci_32bit_workaround = false;
>                 dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
>         }

The DMA mask is set here:
https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L967

And should be called using:
hpriv->cap & HOST_CAP_64
https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L1929

Where hpriv->cap is capabilities reported by the AHCI controller itself.
So it definitely seems like your controller supports 64-bit addressing.

I guess it could be some problem with your BIOS.
Have you tried updating your BIOS?


If that does not work, perhaps you could try this (completely untested) patch:
(You might need to modify the strings to match the exact strings reported by
your BIOS.)

If it works, we need to add a specific BIOS version too, see e.g.
https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L1310


diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 3a5f3255f51b..35dead43142c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1034,6 +1034,30 @@ static void ahci_p5wdh_workaround(struct ata_host *host)
        }
 }
 
+static bool ahci_broken_64_bit(struct pci_dev *pdev)
+{
+       static const struct dmi_system_id sysids[] = {
+               {
+                       .ident = "ASUS Pro WS WRX80E-SAGE",
+                       .matches = {
+                               DMI_MATCH(DMI_BOARD_VENDOR,
+                                         "ASUSTeK Computer INC."),
+                               DMI_MATCH(DMI_BOARD_NAME, "Pro WS WRX80E-SAGE"),
+                       },
+               },
+               { }
+       };
+       const struct dmi_system_id *dmi = dmi_first_match(sysids);
+
+       if (!dmi)
+               return false;
+
+       dev_warn(&pdev->dev, "%s: forcing 32bit DMA, update BIOS\n",
+                dmi->ident);
+
+       return true;
+}
+
 /*
  * Macbook7,1 firmware forcibly disables MCP89 AHCI and changes PCI ID when
  * booting in BIOS compatibility mode.  We restore the registers but not ID.
@@ -1799,6 +1823,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
        if (ahci_broken_devslp(pdev))
                hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
 
+       /* must set flag prior to save config in order to take effect */
+       if (ahci_broken_64_bit(pdev))
+               hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+
 #ifdef CONFIG_ARM64
        if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
            pdev->device == 0xa235 &&

