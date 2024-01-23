Return-Path: <linux-kernel+bounces-36051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C03E839ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF491C23A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6818253BA;
	Tue, 23 Jan 2024 21:00:58 +0000 (UTC)
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA4524B;
	Tue, 23 Jan 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.239.204.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043657; cv=none; b=E9cDDcpqC/XsxCprD3aXXXeqsop0Rn+G9EcOMHiOTZ9UaOEGxsI/KfqfIljiLx6dvyvV3IVh1jK12q7bynTMGWyfF/Nvk1XhvCruCktKCFcpAEBrx4M+ig6dAvdFzQzIXzmIeOGqrLQO9gV9LZgpkUCOgUHbqMuKWi3tqtPrm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043657; c=relaxed/simple;
	bh=6tcBKAeuAQxfVhY7DIrcnMRRPzuGZNmYnwOKZ5nBPJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpn4DX5MYVlIGn51hkB7jTM7yPFPYVYihYxzGZIlCUWIvR0y9hRVujoLWHWVPnIYyTiZp+19B+a7neUNe0MDlQ7O5Ay97IMCws/Y2ax1QhKWGtrChTGkLprZeEc2AkpUozvTIgAFYrkbFubVEFRtQ8Rjqam0zX29d+uOhVw0Cik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org; spf=pass smtp.mailfrom=wantstofly.org; arc=none smtp.client-ip=213.239.204.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantstofly.org
Received: by mail.wantstofly.org (Postfix, from userid 1000)
	id 755BA7F70C; Tue, 23 Jan 2024 23:00:44 +0200 (EET)
Date: Tue, 23 Jan 2024 23:00:44 +0200
From: Lennert Buytenhek <kernel@wantstofly.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZbAo_LqpbiGMfTtW@wantstofly.org>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
 <ZaaQpiW3OOZTSyXw@x1-carbon>
 <ZahDNr97MSPNSHW_@wantstofly.org>
 <ZahaKaV1jlHQ0sUx@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZahaKaV1jlHQ0sUx@x1-carbon>

On Wed, Jan 17, 2024 at 11:52:25PM +0100, Niklas Cassel wrote:

> Hello Lennert,

Hi Niklas,

Thank you for your patience.  I think that I have gotten to the bottom
of the issue.  See below.


> > > > On kernel 6.6.x, with an ASMedia ASM1062 (AHCI) controller, on an
> > 
> > Minor correction to this: lspci says that this is an ASM1062, but it's
> > actually an ASM1061.  I think that the two parts share a PCI device ID,
> > and I've submitted a PCI ID DB change here:
> > 
> > https://admin.pci-ids.ucw.cz/read/PC/1b21/0612
> 
> FWIW, the kernel states that 0x0612 is ASM1062, and 0x0611 is ASM1061:
> https://github.com/torvalds/linux/blob/v6.7/drivers/ata/ahci.c#L603-L604
> 
> But that could of course be incorrect.

I think that is incorrect.

FWIW, I bought the following PCIe x1 2-port SATA controller from Amazon.
The brand seems to be "10Gtek", and there does not seem to be a brand
model number for this card.

	https://www.amazon.de/dp/B09Y5FDCGX

The card has an ASM1061 on it according to the product page, and the
main chip on the card that I got indeed says "ASM1061" on it, along
with some other markings -- but lspci says 0x612:

# lspci -s 07:00.0
07:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02)
# lspci -s 07:00.0 -n
07:00.0 0106: 1b21:0612 (rev 02)
#

Digging into the git history, the commit that added the note that
claims that 0x0612 is ASM1062 and 0x0611 is ASM1061 is this one:

	https://github.com/torvalds/linux/commit/7b4f6ecacb14f384adc1a5a67ad95eb082c02bd1

Which does:

        /* Asmedia */
-       { PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },   /* ASM1061 */
+       { PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },   /* ASM1060 */
+       { PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },   /* ASM1060 */
+       { PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },   /* ASM1061 */
+       { PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },   /* ASM1062 */

Note that it removes the line that says that 0x612 is ASM1061!

This commit's description references:

	https://bugzilla.kernel.org/show_bug.cgi?id=42804

This bug report is not 100% clear to me, but the reporter of that bug
seems to say that they have a PCIe card with a :0x611 device ID that
reports itself as an IDE controller but can nevertheless operate in
AHCI mode.  And indeed, their 0x611 ASM1061 reports a prog-if of 85:

04:00.0 IDE interface: ASMedia Technology Inc. ASM1061 SATA IDE Controller (rev 01) (prog-if 85 [Master SecO PriO])

While my 0x612 ASM1061s have prog-ifs of 01.  The two controllers on the
Asus Pro WS WRX80E SAGE SE WIFI mainboard:

# lspci -v | grep "^2[78]"
27:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02) (prog-if 01 [AHCI 1.0])
28:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02) (prog-if 01 [AHCI 1.0])

And the discrete PCIe card (in another machine):

# lspci -v | grep ^07
07:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02) (prog-if 01 [AHCI 1.0])

Therefore, I suspect that 0x611 is "ASM1061/ASM1062 in IDE mode
presenting with a prog-if of 85" and 0x612 is "ASM1061/ASM1062 in AHCI
mode presenting with a prog-if of 01", and that the bug reporter wanted
to run their IDE mode controller in AHCI mode, which the ASM106x seems
to allow as it seems to present the same BARs (legacy I/O port ranges
as well as an AHCI register memory BAR) in both modes.


> When you are dumping the LnkCap in the PCI ID DB change request,
> are you dumping the LnkCap for the AHCI controller or the PCI bridge?
> 
> (Because you use # lspci -s 27:00.0 in the PCI ID DB change request,
> but # lspci -s 28:00.0 further down in this email.)
> 
> (Perhaps the PCI bride only has one PCI lane, but the AHCI controller
> has two?)

There was more information in the PCI ID DB change request at first, but
I had to trim the comment because there is a 1024 character limit. :-(

The Asus Pro WS WRX80E SAGE SE WIFI mainboard has two ASM1061 controllers:

27:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02)
28:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 02)

The one throwing the I/O page faults that led to this email thread was
the 28:00.0 one, while for the PCI ID DB change request I had to trim
one of the controllers out of the comment field for it to fit, and I
decided to trim the second one and leave the first one.

The section of PCIe topology that pertains to these controllers is:

 +-[0000:20]-+-00.0
 |           +-00.2
 |           +-01.0
 |           +-01.1-[21-2c]----00.0-[22-2c]--+-01.0-[23]----00.0
 |           |                               +-02.0-[24-25]--+-00.0
 |           |                               |               \-00.1
 |           |                               +-03.0-[26]----00.0
 |           |                               +-04.0-[27]----00.0
 |           |                               +-05.0-[28]----00.0
 |           |                               +-06.0-[29-2a]----00.0-[2a]----00.0
 |           |                               +-08.0-[2b]--+-00.0
 |           |                               |            +-00.1
 |           |                               |            \-00.3
 |           |                               \-0a.0-[2c]----00.0

Where the controllers themselves both report 5GT/s x1:

# lspci -s 27:00.0 -vv | egrep -e "Lnk(Cap|Sta):"
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s, Exit Latency L0s unlimited
                LnkSta: Speed 5GT/s, Width x1
# lspci -s 28:00.0 -vv | egrep -e "Lnk(Cap|Sta):"
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s, Exit Latency L0s unlimited
                LnkSta: Speed 5GT/s, Width x1
#

And their upstream ports both report 16GT/s x1:

# lspci -s 22:04.0 -vv | egrep -e "Lnk(Cap|Sta):"
                LnkCap: Port #4, Speed 16GT/s, Width x1, ASPM L1, Exit Latency L1 <32us
                LnkSta: Speed 5GT/s, Width x1
# lspci -s 22:05.0 -vv | egrep -e "Lnk(Cap|Sta):"
                LnkCap: Port #5, Speed 16GT/s, Width x1, ASPM L1, Exit Latency L1 <32us
                LnkSta: Speed 5GT/s, Width x1
#


> > (I checked the available datasheets, but there is no mention of whether
> > or not the part supports 64-bit DMA.)
> 
> If you are curious, hpriv->cap is the HBA capabilities reported by the
> device, see:
> https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/serial-ata-ahci-spec-rev1-3-1.pdf
> 
> 3.1.1 Offset 00h: CAP – HBA Capabilities
> 
> Bit 31 - Supports 64-bit Addressing (S64A).
> 
> It seems a bit silly that the AHCI controller vendor accidentally set this
> bit to 1.

It sets S64A, but from some testing with this discrete 10Gtek ASM1061
PCIe card, it seems that while the ASM106x supports more than 32 DMA
address bits, it doesn't support the full 64 DMA address bits -- it
only seems to support 43 DMA address bits, and this is likely what
tripped it up here.  See below.


> > I will do some tests with PCI passthrough to a VM, to see whether, and if
> > it does, exactly how the controller mangles DMA addresses.
> 
> Were you running in a VM when testing this?
> (Usually you need to pass through all PCI devices in the same iommu group.)

There are some VMs, but the I/O page faults that started this email
thread happened on the host, i.e. no PCI device passthrough involved.


> The errors from your previous email:
> [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged
> 
> could also suggest an iommu issue. Have you tried booting with iommu=off
> and/or amd_iommu=off on the kernel command line?
> (Or temporarily disable the iommu in BIOS.)

If the card has a DMA mask problem, then that would likely lead to
memory and/or disk corruption.


For my testing, I used a different, random X570 based test system I
had lying around, as the Asus Pro WS WRX80E SAGE SE WIFI based one is
currently being used in production.

On the X570 machine, I passed the ASM1061 PCIe card as well as the
X570 chipset's AHCI controller through to a virtual machine, and I used
the following kernel patch in the virtual machine to force I/O page
faults on writes.  (This works because the virtual machine boots from a
virtio block device.)

--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1667,6 +1667,12 @@ static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
                dma_addr_t addr = sg_dma_address(sg);
                u32 sg_len = sg_dma_len(sg);
 
+               printk(KERN_INFO "mapping dma_address=%.16lx sg_len=%.8lx dma_dir=%d\n",
+                       (unsigned long)addr, (unsigned long)sg_len, qc->dma_dir);
+
+               if (qc->dma_dir == DMA_TO_DEVICE)
+                       addr = 0xffffffff00000000;
+
                ahci_sg[si].addr = cpu_to_le32(addr & 0xffffffff);
                ahci_sg[si].addr_hi = cpu_to_le32((addr >> 16) >> 16);
                ahci_sg[si].flags_size = cpu_to_le32(sg_len - 1);

When trying to write to the first sector of a disk on the X570 chipset's
AHCI controller from the virtual machine, I then get these sorts of I/O
page faults on the host, entirely as expected:

[Tue Jan 23 21:34:24 2024] vfio-pci 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0xffffffff00000000 flags=0x0010]
[Tue Jan 23 21:34:25 2024] vfio-pci 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0xffffffff00000000 flags=0x0010]
[Tue Jan 23 21:34:25 2024] vfio-pci 0000:0a:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0xffffffff00000000 flags=0x0010]

However, if I write to the first sector of a disk on the ASM1061 PCIe
card, I get very different I/O page faults:

[Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000000 flags=0x0010]
[Tue Jan 23 21:31:55 2024] vfio-pci 0000:07:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0021 address=0x7ff00000500 flags=0x0010]

Note how the upper 21 bits in the reported DMA addresses in the ASM1061
case are all clear.

The host PCIe topology shows that the chipset controller and ASM1061
are on sibling buses, suggesting that they are in a similar IOMMU
environment:

           +-01.2-[02-0a]----00.0-[03-0a]--+-03.0-[04]--+-00.0
           |                               |            \-00.1
           |                               +-04.0-[05]----00.0
           |                               +-05.0-[06]----00.0
           |                               +-06.0-[07]----00.0  <== ASM1061
           |                               +-08.0-[08]--+-00.0
           |                               |            +-00.1
           |                               |            \-00.3
           |                               +-09.0-[09]----00.0  <== X570 AHCI
           |                               \-0a.0-[0a]----00.0  <== X570 AHCI

I did another test where I force the upper 21 DMA address bits to 1
for all writes:

--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1667,6 +1667,12 @@ static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
                dma_addr_t addr = sg_dma_address(sg);
                u32 sg_len = sg_dma_len(sg);
 
+               printk(KERN_INFO "mapping dma_address=%.16lx sg_len=%.8lx dma_dir=%d\n",
+                       (unsigned long)addr, (unsigned long)sg_len, qc->dma_dir);
+
+               if (qc->dma_dir == DMA_TO_DEVICE)
+                       addr |= 0xfffff80000000000;
+
                ahci_sg[si].addr = cpu_to_le32(addr & 0xffffffff);
                ahci_sg[si].addr_hi = cpu_to_le32((addr >> 16) >> 16);
                ahci_sg[si].flags_size = cpu_to_le32(sg_len - 1);

As expected, this breaks writes to the disk on the X570 AHCI controller,
which now all give I/O page faults on the host, but I/O to the disk on
the ASM1061 controller seems completely unaffected by this patch, and I
can create a btrfs filesystem, clone linux.git onto it, scrub it with
no errors, unmount and remount, scrub it again with no errors, reboot
and mount it again, and again scrub it with no errors, etc.

This all suggests to me that the ASM1061 drops the upper 21 bits of all
DMA addresses.  Going back to the original report, on the Asus Pro WS
WRX80E-SAGE SE WIFI, we also see DMA addresses that seem to have been
capped to 43 bits:

> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: Using 64-bit DMA addresses
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00000 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00300 flags=0x0000]
> [Thu Jan  4 23:12:54 2024] ahci 0000:28:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0035 address=0x7fffff00380 flags=0x0000]

Since in this test the X570 AHCI controller is inside the chipset and
the ASM1061 in a PCIe slot, this doesn't 100% prove that the ASM1061 is
at fault (e.g. the upstream IOMMUs for the X570 AHCI controller and the
ASM1061 could be behaving differently), and to 100% prove this theory I
would have to find a non-ASM1061 AHCI controller and put it in the same
PCIe slot as the ASM1061 is currently in, and try to make it DMA to
address 0xffffffff00000000, and verify that the I/O page faults on the
host report 0xffffffff00000000 and not 0x7fffff00000 -- but I think that
the current evidence is perhaps good enough?

There are two ways to handle this -- either set the DMA mask for ASM106x
parts to 43 bits, or take the lazy route and just use AHCI_HFLAG_32BIT_ONLY
for these parts.  I feel that the former would be more appropriate, as
there seem to be plenty of bits beyond bit 31 that do work, but I will
defer to your judgement on this matter.  What do you think the right way
to handle this apparent hardware quirk is?

Thanks again for your consideration.

Kind regards,
Lennert

