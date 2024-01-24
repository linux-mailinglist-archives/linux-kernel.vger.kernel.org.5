Return-Path: <linux-kernel+bounces-37002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D583AA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E213DB2843C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F64677F01;
	Wed, 24 Jan 2024 12:40:58 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9D77654;
	Wed, 24 Jan 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100057; cv=none; b=mMUS4cF+1NVmTbF8iUXZjAHvN8Soec9icbax/e9z+NU/FWOeOrUqE0ai3DHg1J5fUAPpXo8i02UTzXxjPaJWllUldhXBT/czLcm994dYYfB7lXSMcMnSfIjT70bqNKOdo0n/jd7HeLZ0WUVwJY98kE7xM9jJYZMVnKydhWZK/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100057; c=relaxed/simple;
	bh=BYm3NH99pVOBTU4P7iAI8QFB06WkmURzy0AgZjwq83Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryJOYdnzQPfmnVY50YgEd3INnKkG1Z/OSWwycVMhD6Q9/uhgLn0eVVM/dZRs8KWIBxXpnFtzBvDRMrRIGlLjpiMJFtrbWblEofM0wH1UqEtQ4RQFvBSSmvqP7Gc07E+4P2uyWrMYbk2grG4unEQpG+vN/iLvsAmDilwbU+ihsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id 8A0DA7F712; Wed, 24 Jan 2024 14:40:51 +0200 (EET)
Date: Wed, 24 Jan 2024 14:40:51 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Niklas Cassel <nks@flawful.org>
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZbEFU-rycTXxOtfW@wantstofly.org>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
 <ZaaQpiW3OOZTSyXw@x1-carbon>
 <ZahDNr97MSPNSHW_@wantstofly.org>
 <ZahaKaV1jlHQ0sUx@x1-carbon>
 <ZbAo_LqpbiGMfTtW@wantstofly.org>
 <ZbDjL0TDnUfzknZS@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbDjL0TDnUfzknZS@x1-carbon>

On Wed, Jan 24, 2024 at 11:15:11AM +0100, Niklas Cassel wrote:

> > This all suggests to me that the ASM1061 drops the upper 21 bits of all
> > DMA addresses.  Going back to the original report, on the Asus Pro WS
> > WRX80E-SAGE SE WIFI, we also see DMA addresses that seem to have been
> > capped to 43 bits:
> > 
> > > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
> > > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> > > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> > > [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]
> > 
> > Since in this test the X570 AHCI controller is inside the chipset and
> > the ASM1061 in a PCIe slot, this doesn't 100% prove that the ASM1061 is
> > at fault (e.g. the upstream IOMMUs for the X570 AHCI controller and the
> > ASM1061 could be behaving differently), and to 100% prove this theory I
> > would have to find a non-ASM1061 AHCI controller and put it in the same
> > PCIe slot as the ASM1061 is currently in, and try to make it DMA to
> > address 0xffffffff00000000, and verify that the I/O page faults on the
> > host report 0xffffffff00000000 and not 0x7fffff00000 -- but I think that
> > the current evidence is perhaps good enough?
> 
> It does indeed look like the same issue on the internal ASMedia ASM1061 on
> your Asus Pro WS WRX80E-SAGE SE WIFI and the stand alone ASMedia ASM1061
> PCI card connected to your other X570 based motherboard.
> 
> However, ASMedia ASM1061 seems to be quite common, so I'm surprised that
> no one has ever reported this problem before, so what has changed?
> Perhaps there is some recent kernel patch that introduced this?
> 
> The commit was introduced:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bf7fda4dce22214c70c49960b1b6438e6260b67
> was reverted:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=af3e9579ecfbe1796334bb25a2f0a6437983673a
> and was then introduced in a new form:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=791c2b17fb4023f21c3cbf5f268af01d9b8cb7cc
> 
> I suppose that these commits might be recent enough that we have not received
> any bug reports for ASMedia ASM1061 since then.

I don't know exactly what triggered the I/O page faults that started
this email thread, but note that it was working OK for a week or two
before this happened.  When the issue originally triggered, there was
a lot of write I/O going on to a pair of (slow) QLC SSDs connected to
the ASM1061, so there may have been timeouts or I/O errors involved.

This system is new and it has never run any kernel older than 6.6, so
I don't have data for older kernels.

Also note that this is 2022 CPU on a 2023 mainboard with 256 GiB of
RAM with a 2011 PCIe 2.0 SATA controller, which might not be the most
common of combinations.


> If you can find another PCIe card (e.g. a AHCI controller or NVMe
> controller) that you can plug in to the same slot on the X570
> motherboard, I agree that it would confirm your theory.

I don't have another PCIe AHCI controller handy right now, but I do
have another PCIe card that I can make DMA to arbitrary addresses, a
SuperMicro AOC-SAS2LP-MV8 PCIe SAS controller.

However, since the ASM1061 card was in a mechanically x1 slot, and
this SAS controller is a x8 card, I've had to both re-try the ASM1061
in another, larger slot, as well as test the SAS controller in that
same slot.

So, with the ASM1061 moved to another (x16) slot (where it is now
04:00.0, instead of 07:00.0 which it was before), with the same patch
as before:

+               if (qc->dma_dir == DMA_TO_DEVICE)
+                       addr = 0xffffffff00000000;

In this new slot, the I/O page faults generated look the same as before,
that is, with the upper 21 bits of the DMA addresses dropped:

[Wed Jan 24 13:59:45 2024] vfio-pci 0000:04:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000000 flags=0x0010]
[Wed Jan 24 13:59:45 2024] vfio-pci 0000:04:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000700 flags=0x0010]

After replacing the ASM1061 card with the SAS controller, which is:

04:00.0 RAID bus controller: Marvell Technology Group Ltd. 88SE9485 SAS/SATA 6Gb/s controller (rev c3)

And with the following patch applied to the mvsas driver:

diff --git a/drivers/scsi/mvsas/mv_94xx.c b/drivers/scsi/mvsas/mv_94xx.c
index fc0b8eb68204..11886e73a625 100644
--- a/drivers/scsi/mvsas/mv_94xx.c
+++ b/drivers/scsi/mvsas/mv_94xx.c
@@ -788,7 +788,7 @@ static void mvs_94xx_make_prd(struct scatterlist *scatter, int nr, void *prd)
        struct mvs_prd_imt im_len;
        *(u32 *)&im_len = 0;
        for_each_sg(scatter, sg, nr, i) {
-               buf_prd->addr = cpu_to_le64(sg_dma_address(sg));
+               buf_prd->addr = cpu_to_le64(0xffffffff00000000UL);
                im_len.len = sg_dma_len(sg);
                buf_prd->im_len = cpu_to_le32(*(u32 *)&im_len);
                buf_prd++;

The corresponding I/O page faults in the host look like this:

[Wed Jan 24 14:08:33 2024] vfio-pci 0000:04:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0xffffffff00000000 flags=0x0030]
[Wed Jan 24 14:08:33 2024] vfio-pci 0000:04:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0xffffffff00000180 flags=0x0030]

That is, with the upper 32 bits of the DMA address fully intact.

I think this shows pretty conclusively that the ASM1061 is dropping
the upper 21 bits of DMA addresses.


> > There are two ways to handle this -- either set the DMA mask for ASM106x
> > parts to 43 bits, or take the lazy route and just use AHCI_HFLAG_32BIT_ONLY
> > for these parts.  I feel that the former would be more appropriate, as
> > there seem to be plenty of bits beyond bit 31 that do work, but I will
> > defer to your judgement on this matter.  What do you think the right way
> > to handle this apparent hardware quirk is?
> 
> I've seen something similar for NVMe, where some NVMe controllers from
> Amazon was violating the spec, and only supported 48-bit DMA addresses,
> even though NVMe spec requires you to support 64-bit DMA addresses, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bdf260362b3be529d170b04662638fd6dc52241
> 
> It is possible that ASMedia ASM1061 has a similar problem (but for AHCI)
> and only supports 43-bit DMA addresses, even though it sets AHCI CAP.S64A,
> which says "Indicates whether the HBA can access 64-bit data structures.".
> 
> I think the best thing is to do a similar quirk, where we set the dma_mask
> accordingly.

I'll give that a try.


Kind regards,
Lennert

