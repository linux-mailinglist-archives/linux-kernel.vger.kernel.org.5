Return-Path: <linux-kernel+bounces-33106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB08364A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E631F252F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1EE3D0AB;
	Mon, 22 Jan 2024 13:45:08 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8243CF74
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931107; cv=none; b=Shr4xKlw9wmEo+g3SdZ6lw/MUmyEnSDcVrsBmkLp3RbGYarKstSKZ870r0yWSb3/875JooTJDAKlEwllFBVTLEAfggOHZZEZz8eXUCMdwteDEhU8qtKDGVhV2gT9W5Pv88pS2Xyv5N9s2NNAbOA8zaqKiTCYcsupdPy246rXn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931107; c=relaxed/simple;
	bh=rlj/uOhX+2J2TcdtyX2fpOBJZMek3HcpcJSp2zX5UAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkeDFdBsxWjJmpMY/Azcl5fu8b+ekDd6VwfLI7CA+dTngTmVKJmJ8pDetKzdfHGOI6POhXI1/Qr+fukADGByX30xFstaoDzAeT5duc9bzUuG1tXHH7wf2ISjRi0QLuaUm1Z8LyJdbpcBLqS01f9+PbUgs3yuXL4zqAx4hl/s7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 21E1614033C; Mon, 22 Jan 2024 14:45:05 +0100 (CET)
Date: Mon, 22 Jan 2024 14:45:05 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Dell XPS 13 9360: DMAR errors `DRHD: handling fault status reg
 2` and `[INTR-REMAP] Request device [f0:1f.0] fault index 0x0`
Message-ID: <Za5xYauQDe8xcVGr@cae.in-ulm.de>
References: <9a24c335-8ec5-48c9-9bdd-b0dac5ecbca8@molgen.mpg.de>
 <cb71c806-b100-4673-a131-faac77344002@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb71c806-b100-4673-a131-faac77344002@linux.intel.com>


Hi,

On Mon, Jan 22, 2024 at 08:53:43PM +0800, Baolu Lu wrote:
> On 2024/1/19 20:59, Paul Menzel wrote:
> > Dear Linux folks,
> > 
> > 
> > On a Dell XPS 13 9360 Linux 6.6.8, 6.6.11 and 6.7 (and earlier versions)
> > log the lines below when resuming from ACPI S3 (deep):
> > 
> >      [    0.000000] Linux version 6.7-amd64
> > (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-13 (Debian
> > 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1
> > SMP PREEMPT_DYNAMIC Debian 6.7-1~exp1 (2024-01-08)
> >      [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.7-amd64
> > root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer
> > mem_sleep_default=deep log_buf_len=8M
> >      […]
> >      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0
> > 06/02/2022
> >      […]
> >      [   99.711230] PM: suspend entry (deep)
> >      […]
> >      [   99.722101] printk: Suspending console(s) (use
> > no_console_suspend to debug)
> >      [  100.285178] ACPI: EC: interrupt blocked
> >      [  100.319908] ACPI: PM: Preparing to enter system sleep state S3
> >      [  100.331793] ACPI: EC: event blocked
> >      [  100.331798] ACPI: EC: EC stopped
> >      [  100.331800] ACPI: PM: Saving platform NVS memory
> >      [  100.335224] Disabling non-boot CPUs ...
> >      [  100.337412] smpboot: CPU 1 is now offline
> >      [  100.341065] smpboot: CPU 2 is now offline
> >      [  100.346441] smpboot: CPU 3 is now offline
> >      [  100.353086] ACPI: PM: Low-level resume complete
> >      [  100.353129] ACPI: EC: EC started
> >      [  100.353129] ACPI: PM: Restoring platform NVS memory
> >      [  100.355219] Enabling non-boot CPUs ...
> >      [  100.355244] smpboot: Booting Node 0 Processor 1 APIC 0x2
> >      [  100.355954] CPU1 is up
> >      [  100.355972] smpboot: Booting Node 0 Processor 2 APIC 0x1
> >      [  100.356698] CPU2 is up
> >      [  100.356716] smpboot: Booting Node 0 Processor 3 APIC 0x3
> >      [  100.357371] CPU3 is up
> >      [  100.360217] ACPI: PM: Waking up from system sleep state S3
> >      [  100.668380] ACPI: EC: interrupt unblocked
> >      [  100.668598] pcieport 0000:00:1c.0: Intel SPT PCH root port ACS
> > workaround enabled
> >      [  100.668606] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS
> > workaround enabled
> >      [  100.668643] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS
> > workaround enabled
> >      [  100.690996] DMAR: DRHD: handling fault status reg 2
> >      [  100.691001] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault
> > index 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
> > request
> > 
> > But I am unable to find the device f0:1f.0:
> > 
> >      $ lspci -nn
> >      00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th
> > Gen Core Processor Host Bridge/DRAM Registers [8086:5904] (rev 02)
> >      00:02.0 VGA compatible controller [0300]: Intel Corporation HD
> > Graphics 620 [8086:5916] (rev 02)
> >      00:04.0 Signal processing controller [1180]: Intel Corporation Xeon
> > E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
> > [8086:1903] (rev 02)
> >      00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP
> > USB 3.0 xHCI Controller [8086:9d2f] (rev 21)
> >      00:14.2 Signal processing controller [1180]: Intel Corporation
> > Sunrise Point-LP Thermal subsystem [8086:9d31] (rev 21)
> >      00:15.0 Signal processing controller [1180]: Intel Corporation
> > Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
> >      00:15.1 Signal processing controller [1180]: Intel Corporation
> > Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
> >      00:16.0 Communication controller [0780]: Intel Corporation Sunrise
> > Point-LP CSME HECI #1 [8086:9d3a] (rev 21)
> >      00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
> > Express Root Port #1 [8086:9d10] (rev f1)
> >      00:1c.4 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
> > Express Root Port #5 [8086:9d14] (rev f1)
> >      00:1d.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
> > Express Root Port #9 [8086:9d18] (rev f1)
> >      00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-LP LPC
> > Controller [8086:9d58] (rev 21)
> >      00:1f.2 Memory controller [0580]: Intel Corporation Sunrise
> > Point-LP PMC [8086:9d21] (rev 21)
> >      00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD
> > Audio [8086:9d71] (rev 21)
> >      00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus
> > [8086:9d23] (rev 21)
> >      01:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
> > Bridge [Alpine Ridge 2C 2015] [8086:1576]
> >      02:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
> > Bridge [Alpine Ridge 2C 2015] [8086:1576]
> >      02:01.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
> > Bridge [Alpine Ridge 2C 2015] [8086:1576]
> >      02:02.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
> > Bridge [Alpine Ridge 2C 2015] [8086:1576]
> >      39:00.0 USB controller [0c03]: Intel Corporation DSL6340 USB 3.1
> > Controller [Alpine Ridge] [8086:15b5]
> >      3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174
> > 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
> >      3b:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe
> > Solid State Drive 512GB [1c5c:1284]
> > 
> > As this is logged as an error, can this be fixed somehow?
> 
> This appears to be a platform problem. The hidden device (f0:1f.0) is
> not visible to the OS, so no driver can program the interrupt remapping
> table for the device's interrupts.

The hidden device has been identified as the IO-APIC. It is visible
and properly declared to use 0f:1f.0 in the DMAR table.

     regards  Christian


