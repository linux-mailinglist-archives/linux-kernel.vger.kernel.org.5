Return-Path: <linux-kernel+bounces-27384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018782EF18
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3991C232C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0C1BC30;
	Tue, 16 Jan 2024 12:36:42 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725A1BC26;
	Tue, 16 Jan 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id AB7DD7F5C3; Tue, 16 Jan 2024 14:27:40 +0200 (EET)
Date: Tue, 16 Jan 2024 14:27:40 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using 64-bit
 DMA addresses"
Message-ID: <ZaZ2PIpEId-rl6jv@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On kernel 6.6.x, with an ASMedia ASM1062 (AHCI) controller, on an
ASUSTeK Pro WS WRX80E-SAGE SE WIFI mainboard, PCI ID 1b21:0612 and
subsystem ID 1043:858d, I got a total apparent controller hang,
rendering the two attached SATA devices unavailable, that was
immediately preceded by the following kernel messages:

[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00400 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00680 flags=0x0000]
[Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00700 flags=0x0000]

It seems as if the controller has problems with 64-bit DMA addresses,
and the comments around the source of the message in
drivers/iommu/dma-iommu.c seem to point into that same direction:

        /*
         * Try to use all the 32-bit PCI addresses first. The original SAC vs.
         * DAC reasoning loses relevance with PCIe, but enough hardware and
         * firmware bugs are still lurking out there that it's safest not to
         * venture into the 64-bit space until necessary.
         *
         * If your device goes wrong after seeing the notice then likely either
         * its driver is not setting DMA masks accurately, the hardware has
         * some inherent bug in handling >32-bit addresses, or not all the
         * expected address bits are wired up between the device and the IOMMU.
         */
        if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
                iova = alloc_iova_fast(iovad, iova_len,
                                       DMA_BIT_MASK(32) >> shift, false);
                if (iova)
                        goto done;

                dev->iommu->pci_32bit_workaround = false;
                dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
        }

Are there any tests you can think of that I can run to further narrow
down this issue?  By itself, the issue reproduces only rarely.

Thank you in advance.

Kind regards,
Lennert

