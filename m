Return-Path: <linux-kernel+bounces-38289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD3383BD87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821E21C2262D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6C71C6BF;
	Thu, 25 Jan 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hxtb5kt/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945E1C686
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175486; cv=none; b=Rfn4XnRYFnbVdY5kWzhdLcobD/WabJ/0eBv5EBtTacF0H10zbwTh0TBGgzBKE9dxlMVxWhxrw7HbHrXzH2OqJVz57RP/KVVjCnrlQInrvL0qm/J3oXT9LD4FeXoDGKtlsxZVEby8Kv/+czVdhEjfgpz8tqytOXInWaTAwD+oiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175486; c=relaxed/simple;
	bh=yG81cTllFEjaTu43SogQYuhthByCM+AVIe1A6soPGns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAcQtbZSRmfB1KCJVkUWxp6HQV4kIi5kYqWg+GjQdu2ZLR+AZwVh1pmu+K06BULvCJNCS8o6daV2UVDHOUTiMtzdwekmegQDBQBuHh2nTxPC1T712EVjtp3rl2mufAx0V5JpaiZW8MrmP5W7yv+/jfPuvjGXfhnWkIBpeRZIRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hxtb5kt/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706175484; x=1737711484;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yG81cTllFEjaTu43SogQYuhthByCM+AVIe1A6soPGns=;
  b=Hxtb5kt/gmHI0OU3rRwCyWoo9GYYmZy4ZSyGHqgGK2VB1EsqHyDs2e5X
   G8bFaz8v2H5T9RsegBD1jEmCo/7RbUEnb11tdZUPe97yNBexAl1kEiGrG
   r6CsRo/GcJEEyKRaf86B86q0iFiWLsGEGSG1db3GivbwsXSQVVITwUU3m
   EwZfaAE6AFx7oodJQAli2hvCWv6D4ZGqVVOEeVr3/BkwWsubLY7Uk94yv
   8hK0FYxC1/aSBX8NmYKk77MF5RuXZTaAizpAibOXMgnAcZ1G0h2g+dmyI
   Kr7ClksOU7xH13eaZLvqM6EBYMBZB9Q6NpiUk2+ccHma+L/1bVyah9Rqi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="2004932"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2004932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:38:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905904562"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="905904562"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.212.253]) ([10.254.212.253])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:38:01 -0800
Message-ID: <a6e18e0a-2721-4126-aa8a-ae650fa86edb@linux.intel.com>
Date: Thu, 25 Jan 2024 17:37:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dell XPS 13 9360: DMAR errors `DRHD: handling fault status reg 2`
 and `[INTR-REMAP] Request device [f0:1f.0] fault index 0x0`
To: "Christian A. Ehrhardt" <lk@c--e.de>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <9a24c335-8ec5-48c9-9bdd-b0dac5ecbca8@molgen.mpg.de>
 <cb71c806-b100-4673-a131-faac77344002@linux.intel.com>
 <Za5xYauQDe8xcVGr@cae.in-ulm.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <Za5xYauQDe8xcVGr@cae.in-ulm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/22/2024 9:45 PM, Christian A. Ehrhardt wrote:
> Hi,
>
> On Mon, Jan 22, 2024 at 08:53:43PM +0800, Baolu Lu wrote:
>> On 2024/1/19 20:59, Paul Menzel wrote:
>>> Dear Linux folks,
>>>
>>>
>>> On a Dell XPS 13 9360 Linux 6.6.8, 6.6.11 and 6.7 (and earlier versions)
>>> log the lines below when resuming from ACPI S3 (deep):
>>>
>>>       [    0.000000] Linux version 6.7-amd64
>>> (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-13 (Debian
>>> 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1
>>> SMP PREEMPT_DYNAMIC Debian 6.7-1~exp1 (2024-01-08)
>>>       [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.7-amd64
>>> root=UUID=32e29882-d94d-4a92-9ee4-4d03002bfa29 ro quiet pci=noaer
>>> mem_sleep_default=deep log_buf_len=8M
>>>       […]
>>>       [    0.000000] DMI: Dell Inc. XPS 13 9360/0596KF, BIOS 2.21.0
>>> 06/02/2022
>>>       […]
>>>       [   99.711230] PM: suspend entry (deep)
>>>       […]
>>>       [   99.722101] printk: Suspending console(s) (use
>>> no_console_suspend to debug)
>>>       [  100.285178] ACPI: EC: interrupt blocked
>>>       [  100.319908] ACPI: PM: Preparing to enter system sleep state S3
>>>       [  100.331793] ACPI: EC: event blocked
>>>       [  100.331798] ACPI: EC: EC stopped
>>>       [  100.331800] ACPI: PM: Saving platform NVS memory
>>>       [  100.335224] Disabling non-boot CPUs ...
>>>       [  100.337412] smpboot: CPU 1 is now offline
>>>       [  100.341065] smpboot: CPU 2 is now offline
>>>       [  100.346441] smpboot: CPU 3 is now offline
>>>       [  100.353086] ACPI: PM: Low-level resume complete
>>>       [  100.353129] ACPI: EC: EC started
>>>       [  100.353129] ACPI: PM: Restoring platform NVS memory
>>>       [  100.355219] Enabling non-boot CPUs ...
>>>       [  100.355244] smpboot: Booting Node 0 Processor 1 APIC 0x2
>>>       [  100.355954] CPU1 is up
>>>       [  100.355972] smpboot: Booting Node 0 Processor 2 APIC 0x1
>>>       [  100.356698] CPU2 is up
>>>       [  100.356716] smpboot: Booting Node 0 Processor 3 APIC 0x3
>>>       [  100.357371] CPU3 is up
>>>       [  100.360217] ACPI: PM: Waking up from system sleep state S3
>>>       [  100.668380] ACPI: EC: interrupt unblocked
>>>       [  100.668598] pcieport 0000:00:1c.0: Intel SPT PCH root port ACS
>>> workaround enabled
>>>       [  100.668606] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS
>>> workaround enabled
>>>       [  100.668643] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS
>>> workaround enabled
>>>       [  100.690996] DMAR: DRHD: handling fault status reg 2
>>>       [  100.691001] DMAR: [INTR-REMAP] Request device [f0:1f.0] fault
>>> index 0x0 [fault reason 0x25] Blocked a compatibility format interrupt
>>> request
>>>
>>> But I am unable to find the device f0:1f.0:
>>>
>>>       $ lspci -nn
>>>       00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th
>>> Gen Core Processor Host Bridge/DRAM Registers [8086:5904] (rev 02)
>>>       00:02.0 VGA compatible controller [0300]: Intel Corporation HD
>>> Graphics 620 [8086:5916] (rev 02)
>>>       00:04.0 Signal processing controller [1180]: Intel Corporation Xeon
>>> E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
>>> [8086:1903] (rev 02)
>>>       00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-LP
>>> USB 3.0 xHCI Controller [8086:9d2f] (rev 21)
>>>       00:14.2 Signal processing controller [1180]: Intel Corporation
>>> Sunrise Point-LP Thermal subsystem [8086:9d31] (rev 21)
>>>       00:15.0 Signal processing controller [1180]: Intel Corporation
>>> Sunrise Point-LP Serial IO I2C Controller #0 [8086:9d60] (rev 21)
>>>       00:15.1 Signal processing controller [1180]: Intel Corporation
>>> Sunrise Point-LP Serial IO I2C Controller #1 [8086:9d61] (rev 21)
>>>       00:16.0 Communication controller [0780]: Intel Corporation Sunrise
>>> Point-LP CSME HECI #1 [8086:9d3a] (rev 21)
>>>       00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
>>> Express Root Port #1 [8086:9d10] (rev f1)
>>>       00:1c.4 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
>>> Express Root Port #5 [8086:9d14] (rev f1)
>>>       00:1d.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
>>> Express Root Port #9 [8086:9d18] (rev f1)
>>>       00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-LP LPC
>>> Controller [8086:9d58] (rev 21)
>>>       00:1f.2 Memory controller [0580]: Intel Corporation Sunrise
>>> Point-LP PMC [8086:9d21] (rev 21)
>>>       00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-LP HD
>>> Audio [8086:9d71] (rev 21)
>>>       00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-LP SMBus
>>> [8086:9d23] (rev 21)
>>>       01:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
>>> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>>>       02:00.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
>>> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>>>       02:01.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
>>> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>>>       02:02.0 PCI bridge [0604]: Intel Corporation DSL6340 Thunderbolt 3
>>> Bridge [Alpine Ridge 2C 2015] [8086:1576]
>>>       39:00.0 USB controller [0c03]: Intel Corporation DSL6340 USB 3.1
>>> Controller [Alpine Ridge] [8086:15b5]
>>>       3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174
>>> 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
>>>       3b:00.0 Non-Volatile memory controller [0108]: SK hynix PC300 NVMe
>>> Solid State Drive 512GB [1c5c:1284]
>>>
>>> As this is logged as an error, can this be fixed somehow?
>> This appears to be a platform problem. The hidden device (f0:1f.0) is
>> not visible to the OS, so no driver can program the interrupt remapping
>> table for the device's interrupts.
> The hidden device has been identified as the IO-APIC. It is visible
> and properly declared to use 0f:1f.0 in the DMAR table.

Didn't see the warning

          "Compatibility-format IRQs enabled despite intr remapping;\n"

          "you are vulnerable to IRQ injection.\n");

So assume the DMA_GSTS_CFIS bit of GSTS_REG shows the interrupt

remapping was programmed to the right behaviour -- Compatibility

format interrupts are blocked.

But the device f0:1f.0 is still armed to inject compatible format interrupt

that is dangerous mistake if not be blocked, so far no such exception

that should be passed through, appears not iommu issue per my

understanding.

Thanks,

Ethan


>
>       regards  Christian
>
>

