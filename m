Return-Path: <linux-kernel+bounces-33053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958068363BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F971C264C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA28C3BB4F;
	Mon, 22 Jan 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bORKlVmd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925993A1CF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928029; cv=none; b=iQKjKOOWv7BHJYMzcnmnnN52e05TfStPdEbapZeDueSS0tGSm/SKXAOrz5ayHSjsXlOdZ47NsvxVwqW9oCENbvfq1DSoH0oDTPIBskD5cDeMyhHz5y7b4nZ0KUt2NTV3baFMkoW2D/rFPGrIrta2QikmgEJWgIIcz5TDXrHuwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928029; c=relaxed/simple;
	bh=MazwQ8q2pvfnwQPhUg2bHX9ShgaH8lEI34lE9fmmHEY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SL3FOujAyof72fMc8e5iQo32toGc2Syi3jx5ENbzSgnXQTlw02XMdSkzaksVSsO1ZVUWI19dNwFgcw9t0U0Czwuj4yMrVXtCLFMxo/n+3RqFWlXZTryxpS0X1bl0iXxn0WcSQC71gihTD+7p31bCu4AZ/n6LxW7nB6p7bCTMI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bORKlVmd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705928028; x=1737464028;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MazwQ8q2pvfnwQPhUg2bHX9ShgaH8lEI34lE9fmmHEY=;
  b=bORKlVmdqMz8enXx5xslxEV0XoxvGO14N+ywcNXwqUIdSPRyRE+MYEkF
   NtHr4OcfQTKatqb3AinOSmw25Xb6Ux7zMwhEkB3xFQqs80XPtNgRyvpGA
   MbhWv7zgJsrPGpi6Jjc/eAAE7I9GXi69ia3CWC+iAStL34Dh8U8SzOaOa
   AcskGSSoducaySGlhj5fBJu6dfWISLxb2l+W02yHGnsGmh8dmkv3vFNtM
   KMiJ974kgbqiPmOHKgXKviHi5KWXxawhihcbTklWjJk/Qjd13WCtZoVSu
   Lpqz7YWM3mtFrphhqRIGLXsYW22lAZasyWqPgISDG4N3tdhw7UMW+bK2E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="1086418"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1086418"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1203527"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.139]) ([10.249.173.139])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:53:46 -0800
Message-ID: <cb71c806-b100-4673-a131-faac77344002@linux.intel.com>
Date: Mon, 22 Jan 2024 20:53:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: Dell XPS 13 9360: DMAR errors `DRHD: handling fault status reg 2`
 and `[INTR-REMAP] Request device [f0:1f.0] fault index 0x0`
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <9a24c335-8ec5-48c9-9bdd-b0dac5ecbca8@molgen.mpg.de>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9a24c335-8ec5-48c9-9bdd-b0dac5ecbca8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/19 20:59, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell XPS 13 9360 Linux 6.6.8, 6.6.11 and 6.7 (and earlier versions) 
> log the lines below when resuming from ACPI S3 (deep):
> 
>      [    0.000000] Linux version 6.7-amd64 
> (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-13 (Debian 
> 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1 
> SMP PREEMPT_DYNAMIC Debian 6.7-1~exp1 (2024-01-08)
>      [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.7-amd64 
> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer 
> mem_sleep_default=deep log_buf_len=8M
>      […]
>      [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0 
> 06/02/2022
>      […]
>      [   99.711230] PM: suspend entry (deep)
>      […]
>      [   99.722101] printk: Suspending console(s) (use 
> no_console_suspend to debug)
>      [  100.285178] ACPI: EC: interrupt blocked
>      [  100.319908] ACPI: PM: Preparing to enter system sleep state S3
>      [  100.331793] ACPI: EC: event blocked
>      [  100.331798] ACPI: EC: EC stopped
>      [  100.331800] ACPI: PM: Saving platform NVS memory
>      [  100.335224] Disabling non-boot CPUs ...
>      [  100.337412] smpboot: CPU 1 is now offline
>      [  100.341065] smpboot: CPU 2 is now offline
>      [  100.346441] smpboot: CPU 3 is now offline
>      [  100.353086] ACPI: PM: Low-level resume complete
>      [  100.353129] ACPI: EC: EC started
>      [  100.353129] ACPI: PM: Restoring platform NVS memory
>      [  100.355219] Enabling non-boot CPUs ...
>      [  100.355244] smpboot: Booting Node 0 Processor 1 APIC 0x2
>      [  100.355954] CPU1 is up
>      [  100.355972] smpboot: Booting Node 0 Processor 2 APIC 0x1
>      [  100.356698] CPU2 is up
>      [  100.356716] smpboot: Booting Node 0 Processor 3 APIC 0x3
>      [  100.357371] CPU3 is up
>      [  100.360217] ACPI: PM: Waking up from system sleep state S3
>      [  100.668380] ACPI: EC: interrupt unblocked
>      [  100.668598] pcieport 0000:00:1c.0: Intel SPT PCH root port ACS 
> workaround enabled
>      [  100.668606] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS 
> workaround enabled
>      [  100.668643] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS 
> workaround enabled
>      [  100.690996] DMAR: DRHD: handling fault status reg 2
>      [  100.691001] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault 
> index 0x0 [fault reason 0x25] Blocked a compatibility format interrupt 
> request
> 
> But I am unable to find the device f0:1f.0:
> 
>      $ lspci -nn
>      00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th 
> Gen Core Processor Host Bridge/DRAM Registers [8086:5904] (rev 02)
>      00:02.0 VGA compatible controller [0300]: Intel Corporation HD 
> Graphics 620 [8086:5916] (rev 02)
>      00:04.0 Signal processing controller [1180]: Intel Corporation Xeon 
> E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem 
> [8086:1903] (rev 02)
>      00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP 
> USB 3.0 xHCI Controller [8086:9d2f] (rev 21)
>      00:14.2 Signal processing controller [1180]: Intel Corporation 
> Sunrise Point-LP Thermal subsystem [8086:9d31] (rev 21)
>      00:15.0 Signal processing controller [1180]: Intel Corporation 
> Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
>      00:15.1 Signal processing controller [1180]: Intel Corporation 
> Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
>      00:16.0 Communication controller [0780]: Intel Corporation Sunrise 
> Point-LP CSME HECI #1 [8086:9d3a] (rev 21)
>      00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI 
> Express Root Port #1 [8086:9d10] (rev f1)
>      00:1c.4 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI 
> Express Root Port #5 [8086:9d14] (rev f1)
>      00:1d.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI 
> Express Root Port #9 [8086:9d18] (rev f1)
>      00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-LP LPC 
> Controller [8086:9d58] (rev 21)
>      00:1f.2 Memory controller [0580]: Intel Corporation Sunrise 
> Point-LP PMC [8086:9d21] (rev 21)
>      00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD 
> Audio [8086:9d71] (rev 21)
>      00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus 
> [8086:9d23] (rev 21)
>      01:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>      02:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>      02:01.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>      02:02.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3 
> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>      39:00.0 USB controller [0c03]: Intel Corporation DSL6340 USB 3.1 
> Controller [Alpine Ridge] [8086:15b5]
>      3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 
> 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
>      3b:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe 
> Solid State Drive 512GB [1c5c:1284]
> 
> As this is logged as an error, can this be fixed somehow?

This appears to be a platform problem. The hidden device (f0:1f.0) is
not visible to the OS, so no driver can program the interrupt remapping
table for the device's interrupts.

Best regards,
baolu

