Return-Path: <linux-kernel+bounces-31451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9281832E81
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC781F24D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1586157897;
	Fri, 19 Jan 2024 17:57:51 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F053A5786C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687070; cv=none; b=gf/8RFWNLYGD1jG9UWu8/Kv2/FMtizFKdC/E/Z2WUS5MyOuIoyt124lRvrqLNeV0Gs+yaWz1JgBS1iTFrkR9fqTBPgrQtsprmylVP6HgRBvFB05ZdxWl+/sUZJyaE35JmsrAzTyWQvxmcuURbSlWPRWz2ocRyoR5H+9Q+MyKBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687070; c=relaxed/simple;
	bh=voIW9PusSvzcgKBkn4IpN4TfY7zjS3V3Y8OcuBR+d4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEAxoNkJpPb5OcRAyM8C1X6/LKwXO00jUBs4JRUjiOPrsTrR2SGtpLDrFvJGxQF3f2AFWOWc+JCnx38J7KZT2Y7h4/FW25RYYF8v6MALQV0Nz4oOtfuMUCniN/eEXRInCD/CbXM+/7i2PpepjnC7sxGfb1/eJv00S8cu++aGop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 91CC1140186; Fri, 19 Jan 2024 18:57:46 +0100 (CET)
Date: Fri, 19 Jan 2024 18:57:46 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Dell XPS 13 9360: DMAR errors `DRHD: handling fault status reg
 2` and `[INTR-REMAP] Request device [f0:1f.0] fault index 0x0`
Message-ID: <Zaq4Gv2SWhd12Lx0@cae.in-ulm.de>
References: <9a24c335-8ec5-48c9-9bdd-b0dac5ecbca8@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a24c335-8ec5-48c9-9bdd-b0dac5ecbca8@molgen.mpg.de>


Hi Paul,

On Fri, Jan 19, 2024 at 01:59:29PM +0100, Paul Menzel wrote:
> On a Dell XPS 13 9360 Linux 6.6.8, 6.6.11 and 6.7 (and earlier versions) log
> the lines below when resuming from ACPI S3 (deep):
> 
>     [    0.000000] Linux version 6.7-amd64 (debian-kernel@lists.debian.org)
> (x86_64-linux-gnu-gcc-13 (Debian 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for
> Debian) 2.41.50.20231227) #1 SMP PREEMPT_DYNAMIC Debian 6.7-1~exp1
> (2024-01-08)
>     [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.7-amd64
> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer
> mem_sleep_default=deep log_buf_len=8M
>     […]
>     [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022
>     […]
>     [   99.711230] PM: suspend entry (deep)
>     […]
>     [   99.722101] printk: Suspending console(s) (use no_console_suspend to
> debug)
>     [  100.285178] ACPI: EC: interrupt blocked
>     [  100.319908] ACPI: PM: Preparing to enter system sleep state S3
>     [  100.331793] ACPI: EC: event blocked
>     [  100.331798] ACPI: EC: EC stopped
>     [  100.331800] ACPI: PM: Saving platform NVS memory
>     [  100.335224] Disabling non-boot CPUs ...
>     [  100.337412] smpboot: CPU 1 is now offline
>     [  100.341065] smpboot: CPU 2 is now offline
>     [  100.346441] smpboot: CPU 3 is now offline
>     [  100.353086] ACPI: PM: Low-level resume complete
>     [  100.353129] ACPI: EC: EC started
>     [  100.353129] ACPI: PM: Restoring platform NVS memory
>     [  100.355219] Enabling non-boot CPUs ...
>     [  100.355244] smpboot: Booting Node 0 Processor 1 APIC 0x2
>     [  100.355954] CPU1 is up
>     [  100.355972] smpboot: Booting Node 0 Processor 2 APIC 0x1
>     [  100.356698] CPU2 is up
>     [  100.356716] smpboot: Booting Node 0 Processor 3 APIC 0x3
>     [  100.357371] CPU3 is up
>     [  100.360217] ACPI: PM: Waking up from system sleep state S3
>     [  100.668380] ACPI: EC: interrupt unblocked
>     [  100.668598] pcieport 0000:00:1c.0: Intel SPT PCH root port ACS
> workaround enabled
>     [  100.668606] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS
> workaround enabled
>     [  100.668643] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS
> workaround enabled
>     [  100.690996] DMAR: DRHD: handling fault status reg 2
>     [  100.691001] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault index
> 0x0 [fault reason 0x25] Blocked a compatibility format interrupt request
> 
> But I am unable to find the device f0:1f.0:

This is probably an ACPI enumerated device. These are platform
devices that pose as a PCI device for the purpose of interrupt
remapping but do not enumerate via PCI. The PCI ID assigned to
these hidden devices is enumerated via ANDD entries in the
DMAR table. You can decode this table with from
/sys/firmware/acpi/tables/DMAR with iasl to verify.

Your dmesg shows two ANDD records for your I2C controllers,
so somehwo the I2C controller is sending interrups that DMAR
doesn't like (probably because the I2C controller is not yet
resumed properly).

Thus my guess is that this is an issue with the suspend/resume hooks
of the I2C controllers not with the IOMMU.

      regards   Christian


