Return-Path: <linux-kernel+bounces-103155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C393087BBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7F1F237FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F026E61E;
	Thu, 14 Mar 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U98kc1nW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C496E61D;
	Thu, 14 Mar 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414294; cv=none; b=BToCI/izYfJtQyohZUFPdJkGRAHJELhOfZ2OxdVbKEGsO6nAgnqES+r+dJwhAJrRmx07UxjzMBYDPZE6VrtpVIJrmUJtTdn0aoxeYKXG3WUSr2IK4j2g99KtLjv4WPxh27zGJeAX9H/McVP/a05ZjmkdzBlEDwvqAhTF0xCZAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414294; c=relaxed/simple;
	bh=2a0RIMF71eqmHpWNl5CknlJnLgYzYu8AkijO4N6tr+I=;
	h=From:Message-ID:To:Cc:Date:Subject:MIME-Version:Content-Type; b=EjawnUoTlbHFwrHBG5yReByr4ri91VJFSWz2qCVXPTIdZPzU0NXCZhgaUyhLLkqrTZ5WMjHj3807U2PrmEo52xA88KdVIKsxBpjbZP7isFMzm1xSJGZk9oJmbz7iaEvNAU0SbOmhHQSNL1ubdhvbB5J2t5THC8LOsslGS2XacD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U98kc1nW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710414292; x=1741950292;
  h=from:message-id:to:cc:date:subject:mime-version:
   content-transfer-encoding;
  bh=2a0RIMF71eqmHpWNl5CknlJnLgYzYu8AkijO4N6tr+I=;
  b=U98kc1nWKrczGuWNtrjjOEpQGpofn5tO5ejQ5UOOK2uIGVgBIfGiDdvX
   qgeWNfiBqilPQS1hAxc3ceBo0K94+deYFaPn6SvYAi7gduYR4lMdLA3+m
   rGtCfTNYEeWSmTwyMhaUUJvlttLUSJexRMJnJRnVKvUQwGjuyH5vIgJ4t
   BWImBYxEVZu0VOX8H4oyPuRoOpUDlnSn8+TbRGJ4Sw22Xsr79T5r74m7I
   kUkDKC7cD/FymSNHzJpcns64aloaU0CSZXWTeVUF9bg5UaKfqN+abk1nY
   nwhSne5qKuSsF0K87/ohnTgV7gykTGrRFDRvD33N/1cXa0YCjy2YPYNM4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5349486"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5349486"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12326088"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.8])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 04:04:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <4844b67c9b1feca386eb739a4592bdbf.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 14 Mar 2024 12:42:27 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.9-1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for v6.9.

Just that you know up front, I ended up replacing a (non-top) commit very
recently to correct a patch that related to input uapi (just a define name
changed to another). Thus, some of the commits have my commit timestamps
that reflect to that. I don't usually like touching history like this but
figured this was good enough case to be an exception.

Highlights:
 - acer-wmi:		New HW support
 - amd/pmf:		Support for new revision of heartbeat notify
 - asus-wmi:		Correctly handle HW without LEDs
 - fujitsu-laptop:	Battery charge control support
 - hp-wmi:		Support for new thermal profiles
 - ideapad-laptop:	Support for refresh rate key
 - intel/pmc:		Put AI accelerator (GNA) into D3 if it has no
			driver to allow entry into low-power modes, and
			temporarily removed Lunar Lake SSRAM support due
			to breaking FW changes causing probe fail
			(further breaking FW changes are still pending)
 - pmc/punit_atom:	Report devices that prevent reacing low power
			levels
 - surface:		Fan speed function support
 - thinkpad_acpi:	Support for more sperial keys and complete the
			list of models with non-standard fan registers
 - touchscreen_dmi:	New HW support
 - wmi:			Continued modernization efforts
 - Removal of obsoleted ledtrig-audio call and the related dependency
 - Debug & metrics interface improvements
 - Miscellaneous cleanups / fixes / improvements

Regards, i.


The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-1

for you to fetch changes up to 16f8091b49175f327120cdbbdde135d38a853ae1:

  platform/x86/intel/pmc: Improve PKGC residency counters debug (2024-03-12 12:56:04 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.9-1

Highlights:
 - acer-wmi:		New HW support
 - amd/pmf:		Support for new revision of heartbeat notify
 - asus-wmi:		Correctly handle HW without LEDs
 - fujitsu-laptop:	Battery charge control support
 - hp-wmi:		Support for new thermal profiles
 - ideapad-laptop:	Support for refresh rate key
 - intel/pmc:		Put AI accelerator (GNA) into D3 if it has no
			driver to allow entry into low-power modes, and
			temporarily removed Lunar Lake SSRAM support due
			to breaking FW changes causing probe fail
			(further breaking FW changes are still pending)
 - pmc/punit_atom:	Report devices that prevent reacing low power
			levels
 - surface:		Fan speed function support
 - thinkpad_acpi:	Support for more sperial keys and complete the
			list of models with non-standard fan registers
 - touchscreen_dmi:	New HW support
 - wmi:			Continued modernization efforts
 - Removal of obsoleted ledtrig-audio call and the related dependency
 - Debug & metrics interface improvements
 - Miscellaneous cleanups / fixes / improvements

The following is an automated shortlog grouped by driver:

acer-wmi:
 -  Add predator_v4 module parameter
 -  Add support for Acer PH16-71

amd/hsmp:
 -  Add support for ACPI based probing
 -  Cache pci_dev in struct hsmp_socket
 -  Change devm_kzalloc() to devm_kcalloc()
 -  Check num_sockets against MAX_AMD_SOCKETS
 -  Create static func to handle platdev
 -  Define a struct to hold mailbox regs
 -  Move dev from platdev to hsmp_socket
 -  Move hsmp_test to probe
 -  Non-ACPI support for AMD F1A_M00~0Fh
 -  Remove extra parenthesis and add a space
 -  Restructure sysfs group creation

amd/pmf:
 -  Add missing __iomem attribute to policy_base
 -  Add support to get APTS index numbers for static slider
 -  Add support to get sbios requests in PMF driver
 -  Add support to get sps default APTS index values
 -  Add support to notify sbios heart beat event
 -  Differentiate PMF ACPI versions
 -  Disable debugfs support for querying power thermals
 -  Do not use readl() for policy buffer access
 -  Fix possible out-of-bound memory accesses
 -  Fix return value of amd_pmf_start_policy_engine()
 -  Update sps power thermals according to the platform-profiles
 -  Use struct for cookie header

asus-wmi:
 -  Consider device is absent when the read is ~0
 -  Revert: Support WMI event queue

clk: x86:
 -  Move clk-pmc-atom register defines to include/linux/platform_data/x86/pmc_atom.h

dell-privacy:
 -  Remove usage of wmi_has_guid()

Documentation/x86/amd/hsmp:
 -  Updating urls

drivers/mellanox:
 -  Convert snprintf to sysfs_emit

fujitsu-laptop:
 -  Add battery charge control support

hp-wmi:
 -  Add thermal profile support for 8BAD boards
 -  Tidy up module source code

ideapad-laptop:
 -  map Fn + R key to KEY_REFRESH_RATE_TOGGLE
 -  support Fn+R dual-function key

Input:
 -  allocate keycode for Display refresh rate toggle

intel/ifs:
 -  Add an entry rendezvous for SAF
 -  Add current batch number to trace output
 -  Remove unnecessary initialization of 'ret'
 -  Replace the exit rendezvous with an entry rendezvous for ARRAY_BIST
 -  Trace on all HT threads when executing a test

intel/pmc/arl:
 -  Put GNA device in D3

intel/pmc:
 -  Improve PKGC residency counters debug

intel/pmc/lnl:
 -  Remove SSRAM support

intel_scu_ipcutil:
 -  Make scu static

intel_scu_pcidrv:
 -  Remove unused intel-mid.h

intel_scu_wdt:
 -  Remove unused intel-mid.h

intel/tpmi:
 -  Change vsec offset to u64

intel/vsec:
 -  Remove nuisance message

ISST:
 -  Allow reading core-power state on HWP disabled systems

mlxbf-pmc:
 -  Cleanup signed/unsigned mix-up
 -  fix signedness bugs
 -  Ignore unsupported performance blocks

mlxbf-pmc: mlxbf_pmc_event_list():
 -  make size ptr optional

mlxbf-pmc:
 -  Replace uintN_t with kernel-style types

mlxreg-hotplug:
 -  Remove redundant NULL-check

pmc_atom:
 -  Annotate d3_sts register bit defines
 -  Check state of PMC clocks on s2idle
 -  Check state of PMC managed devices on s2idle

silicom-platform:
 - clean up a check

surface: aggregator_registry:
 -  add entry for fan speed

thinkpad_acpi:
 -  Add more ThinkPads with non-standard reg address for fan
 -  Fix to correct wrong temp reporting on some ThinkPads
 -  remove redundant assignment to variable i
 -  Simplify thermal mode checking
 -  Support for mode FN key

touchscreen_dmi:
 -  Add an extra entry for a variant of the Chuwi Vi8 tablet

wmi:
 -  Always evaluate _WED when receiving an event
 -  Check if event data is not NULL
 -  Check if WMxx control method exists
 -  Do not instantiate older WMI drivers multiple times
 -  Ignore duplicated GUIDs in legacy matches
 -  Make input buffer mandatory when evaluating methods
 -  Prevent incompatible event driver from probing
 -  Remove obsolete duplicate GUID allowlist
 -  Remove unnecessary out-of-memory message
 -  Replace pr_err() with dev_err()
 -  Stop using ACPI device class
 -  Update documentation regarding _WED
 -  Use ACPI device name in netlink event
 -  Use FW_BUG when warning about missing control methods

x86/atom:
 -  Check state of Punit managed devices on s2idle

x86: ibm_rtl:
 -  make rtl_subsys const

x86: wmi:
 -  make wmi_bus_type const

platform/x86:
 -  make fw_attr_class constant
 -  remove obsolete calls to ledtrig_audio_get

Merges:
 -  Merge tag 'platform-drivers-x86-v6.8-2' into pdx/for-next
 -  Merge tag 'platform-drivers-x86-v6.8-4' into pdx86/for-next

----------------------------------------------------------------
Alban Boyé (1):
      platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet

Alexis Belmonte (2):
      platform/x86: hp-wmi: Tidy up module source code
      platform/x86: hp-wmi: Add thermal profile support for 8BAD boards

Andy Shevchenko (2):
      platform/x86: intel_scu_wdt: Remove unused intel-mid.h
      platform/x86: intel_scu_pcidrv: Remove unused intel-mid.h

Armin Wolf (27):
      platform/x86: wmi: Fix error handling in legacy WMI notify handler functions
      platform/x86: wmi: Return immediately if an suitable WMI event is found
      platform/x86: wmi: Decouple legacy WMI notify handlers from wmi_block_list
      platform/x86: wmi: Fix notify callback locking
      platform/x86: intel-wmi-sbl-fw-update: Fix function name in error message
      platform/x86: wmi: Use ACPI device name in netlink event
      platform/x86: wmi: Stop using ACPI device class
      platform/x86: wmi: Check if WMxx control method exists
      platform/x86: wmi: Use FW_BUG when warning about missing control methods
      platform/x86: wmi: Remove unnecessary out-of-memory message
      platform/x86: wmi: Replace pr_err() with dev_err()
      platform/x86: wmi: Make input buffer mandatory when evaluating methods
      platform/x86: wmi: Prevent incompatible event driver from probing
      platform/x86: wmi: Check if event data is not NULL
      platform/x86: wmi: Always evaluate _WED when receiving an event
      platform/x86: wmi: Update documentation regarding _WED
      Revert "platform/x86: asus-wmi: Support WMI event queue"
      platform/x86: dell-privacy: Remove usage of wmi_has_guid()
      platform/x86: wmi: Ignore duplicated GUIDs in legacy matches
      platform/x86: wmi: Do not instantiate older WMI drivers multiple times
      platform/x86: wmi: Remove obsolete duplicate GUID allowlist
      platform/x86/amd/pmf: Add missing __iomem attribute to policy_base
      platform/x86: intel_scu_ipcutil: Make scu static
      platform/x86/amd/pmf: Fix return value of amd_pmf_start_policy_engine()
      platform/x86/amd/pmf: Do not use readl() for policy buffer access
      platform/x86/amd/pmf: Use struct for cookie header
      platform/x86/amd/pmf: Fix possible out-of-bound memory accesses

Ashok Raj (4):
      platform/x86/intel/ifs: Trace on all HT threads when executing a test
      platform/x86/intel/ifs: Add current batch number to trace output
      platform/x86/intel/ifs: Replace the exit rendezvous with an entry rendezvous for ARRAY_BIST
      platform/x86/intel/ifs: Add an entry rendezvous for SAF

Colin Ian King (1):
      platform/x86: thinkpad_acpi: remove redundant assignment to variable i

Cong Liu (1):
      platform/x86/amd/pmf: Fix memory leak in amd_pmf_get_pb_data()

Dan Carpenter (3):
      platform/x86: wmi: Fix wmi_dev_probe()
      platform/x86: silicom-platform: clean up a check
      platform/mellanox: mlxbf-pmc: fix signedness bugs

Daniil Dulov (1):
      platform/mellanox: mlxreg-hotplug: Remove redundant NULL-check

David E. Box (3):
      platform/x86/intel/vsec: Remove nuisance message
      platform/x86/intel/pmc/lnl: Remove SSRAM support
      platform/x86/intel/pmc/arl: Put GNA device in D3

Erwan Velu (1):
      Documentation/x86/amd/hsmp: Updating urls

Gergo Koteles (3):
      platform/x86: ideapad-laptop: support Fn+R dual-function key
      Input: allocate keycode for Display refresh rate toggle
      platform/x86: ideapad-laptop: map Fn + R key to KEY_REFRESH_RATE_TOGGLE

Hans de Goede (14):
      platform/x86: silicom-platform: Add missing "Description:" for power_cycle sysfs attr
      MAINTAINERS: remove defunct acpi4asus project info from asus notebooks section
      platform/x86: intel: int0002_vgpio: Pass IRQF_ONESHOT to request_irq()
      platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names
      platform/x86: touchscreen_dmi: Consolidate Goodix upside-down touchscreen data
      platform/x86: x86-android-tablets: Fix keyboard touchscreen on Lenovo Yogabook1 X90
      platform/x86: Add new get_serdev_controller() helper
      platform/x86: x86-android-tablets: Fix serdev instantiation no longer working
      platform/x86: x86-android-tablets: Fix acer_b1_750_goodix_gpios name
      platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler
      platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR
      clk: x86: Move clk-pmc-atom register defines to include/linux/platform_data/x86/pmc_atom.h
      platform/x86: pmc_atom: Annotate d3_sts register bit defines
      platform/x86: pmc_atom: Check state of PMC clocks on s2idle

Harshit Mogalapalli (1):
      platform/x86/amd/pmf: Fix missing error code in amd_pmf_init_smart_pc()

Heiner Kallweit (2):
      MAINTAINERS: Remove Perry Yuan as DELL WMI HARDWARE PRIVACY SUPPORT maintainer
      platform/x86: remove obsolete calls to ledtrig_audio_get

Ilpo Järvinen (3):
      platform/x86/intel/ifs: Remove unnecessary initialization of 'ret'
      Merge tag 'platform-drivers-x86-v6.8-2' into pdx/for-next
      Merge tag 'platform-drivers-x86-v6.8-4' into pdx86/for-next

Ivor Wanders (1):
      platform/surface: aggregator_registry: add entry for fan speed

Jithu Joseph (1):
      platform/x86/intel/ifs: Call release_firmware() when handling errors.

Johannes Stezenbach (2):
      platform/x86: pmc_atom: Check state of PMC managed devices on s2idle
      x86/platform/atom: Check state of Punit managed devices on s2idle

Kai-Heng Feng (1):
      platform/x86: asus-wmi: Consider device is absent when the read is ~0

Kane Chen (1):
      platform/x86/intel/pmc: Improve PKGC residency counters debug

Li Zhijian (1):
      drivers/platform/mellanox: Convert snprintf to sysfs_emit

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Drop Tx network packet when Tx TmFIFO is full

Luiz Capitulino (2):
      platform/mellanox: mlxbf-pmc: mlxbf_pmc_event_list(): make size ptr optional
      platform/mellanox: mlxbf-pmc: Ignore unsupported performance blocks

Luke D. Jones (1):
      MAINTAINERS: add Luke Jones as maintainer for asus notebooks

Mario Limonciello (5):
      platform/x86/amd/pmf: Fix a suspend hang on Framework 13
      platform/x86/amd/pmf: Add debugging message for missing policy data
      platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()
      platform/x86/amd/pmf: Fix a potential race with policy binary sideload
      platform/x86: thinkpad_acpi: Only update profile if successfully converted

Mark Pearson (2):
      platform/x86: Support for mode FN key
      platform/x86: think-lmi: Fix password opcode ordering for workstations

Nathan Chancellor (1):
      platform/x86: intel-uncore-freq: Fix types in sysfs callbacks

Phoenix Chen (1):
      platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet

Ricardo B. Marliere (3):
      platform: x86: wmi: make wmi_bus_type const
      platform: x86: ibm_rtl: make rtl_subsys const
      platform/x86: make fw_attr_class constant

Shin'ichiro Kawasaki (2):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
      platform/x86: p2sb: Use pci_resource_n() in p2sb_read_bar0()

Shravan Kumar Ramani (3):
      platform/mellanox: mlxbf-pmc: Fix offset calculation for crspace events
      platform/mellanox: mlxbf-pmc: Replace uintN_t with kernel-style types
      platform/mellanox: mlxbf-pmc: Cleanup signed/unsigned mix-up

Shyam Sundar S K (11):
      platform/x86/amd/pmf: Get Human presence information from AMD SFH driver
      platform/x86/amd/pmf: Get ambient light information from AMD SFH driver
      platform/x86/amd/pmf: Remove smart_pc_status enum
      platform/x86/amd/pmf: Fix TEE enact command failure after suspend and resume
      platform/x86/amd/pmf: Differentiate PMF ACPI versions
      platform/x86/amd/pmf: Disable debugfs support for querying power thermals
      platform/x86/amd/pmf: Add support to get sbios requests in PMF driver
      platform/x86/amd/pmf: Add support to notify sbios heart beat event
      platform/x86/amd/pmf: Add support to get APTS index numbers for static slider
      platform/x86/amd/pmf: Add support to get sps default APTS index values
      platform/x86/amd/pmf: Update sps power thermals according to the platform-profiles

Srinivas Pandruvada (2):
      platform/x86: ISST: Allow reading core-power state on HWP disabled systems
      platform/x86/intel/tpmi: Change vsec offset to u64

Suma Hegde (11):
      platform/x86/amd/hsmp: Move hsmp_test to probe
      platform/x86/amd/hsmp: Cache pci_dev in struct hsmp_socket
      platform/x86/amd/hsmp: Create static func to handle platdev
      platform/x86/amd/hsmp: Define a struct to hold mailbox regs
      platform/x86/amd/hsmp: Move dev from platdev to hsmp_socket
      platform/x86/amd/hsmp: Restructure sysfs group creation
      platform/x86/amd/hsmp: Add support for ACPI based probing
      platform/x86/amd/hsmp: Non-ACPI support for AMD F1A_M00~0Fh
      platform/x86/amd/hsmp: Check num_sockets against MAX_AMD_SOCKETS
      platform/x86/amd/hsmp: Remove extra parenthesis and add a space
      platform/x86/amd/hsmp: Change devm_kzalloc() to devm_kcalloc()

SungHwan Jung (2):
      platform/x86: acer-wmi: Add support for Acer PH16-71
      platform/x86: acer-wmi: Add predator_v4 module parameter

Szilard Fabian (1):
      platform/x86/fujitsu-laptop: Add battery charge control support

Vishnu Sankar (3):
      platform/x86: thinkpad_acpi: Simplify thermal mode checking
      platform/x86: thinkpad_acpi: Fix to correct wrong temp reporting on some ThinkPads
      platform/x86: thinkpad_acpi: Add more ThinkPads with non-standard reg address for fan

 Documentation/ABI/testing/sysfs-platform-silicom   |   1 +
 .../admin-guide/laptops/thinkpad-acpi.rst          |   7 +-
 Documentation/arch/x86/amd_hsmp.rst                |   7 +-
 Documentation/wmi/acpi-interface.rst               |   5 +-
 MAINTAINERS                                        |   5 +-
 arch/x86/platform/atom/punit_atom_debug.c          |  54 +-
 drivers/clk/x86/clk-pmc-atom.c                     |  13 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   1 +
 drivers/platform/mellanox/mlxbf-bootctl.c          |  14 +-
 drivers/platform/mellanox/mlxbf-pmc.c              | 271 +++++-----
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  67 +++
 drivers/platform/mellanox/mlxreg-hotplug.c         |  14 -
 .../platform/surface/surface_aggregator_registry.c |   7 +
 drivers/platform/x86/Kconfig                       |   7 +-
 drivers/platform/x86/acer-wmi.c                    |  17 +-
 drivers/platform/x86/amd/Kconfig                   |   2 +-
 drivers/platform/x86/amd/hsmp.c                    | 584 ++++++++++++++++-----
 drivers/platform/x86/amd/pmf/Kconfig               |   1 +
 drivers/platform/x86/amd/pmf/acpi.c                | 136 ++++-
 drivers/platform/x86/amd/pmf/core.c                |  32 +-
 drivers/platform/x86/amd/pmf/pmf.h                 |  98 +++-
 drivers/platform/x86/amd/pmf/spc.c                 |  36 ++
 drivers/platform/x86/amd/pmf/sps.c                 | 145 ++++-
 drivers/platform/x86/amd/pmf/tee-if.c              | 101 ++--
 drivers/platform/x86/asus-wmi.c                    |  84 +--
 drivers/platform/x86/dell/Kconfig                  |   3 -
 drivers/platform/x86/dell/dell-laptop.c            |   2 -
 drivers/platform/x86/dell/dell-wmi-ddv.c           |   1 +
 drivers/platform/x86/dell/dell-wmi-privacy.c       |   5 -
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c |   2 +-
 drivers/platform/x86/firmware_attributes_class.c   |   4 +-
 drivers/platform/x86/firmware_attributes_class.h   |   2 +-
 drivers/platform/x86/fujitsu-laptop.c              | 117 +++++
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       |   2 +-
 drivers/platform/x86/hp/hp-wmi.c                   |  71 ++-
 drivers/platform/x86/huawei-wmi.c                  |   1 -
 drivers/platform/x86/ibm_rtl.c                     |   2 +-
 drivers/platform/x86/ideapad-laptop.c              |   4 +-
 drivers/platform/x86/intel/ifs/load.c              |   5 +-
 drivers/platform/x86/intel/ifs/runtest.c           | 101 ++--
 drivers/platform/x86/intel/int0002_vgpio.c         |   2 +-
 drivers/platform/x86/intel/pmc/arl.c               |   2 +
 drivers/platform/x86/intel/pmc/core.c              |  47 +-
 drivers/platform/x86/intel/pmc/core.h              |   7 +-
 drivers/platform/x86/intel/pmc/lnl.c               |  40 +-
 .../x86/intel/speed_select_if/isst_tpmi_core.c     |   4 +-
 drivers/platform/x86/intel/tpmi.c                  |   9 +-
 .../uncore-frequency/uncore-frequency-common.c     |  82 +--
 .../uncore-frequency/uncore-frequency-common.h     |  32 +-
 drivers/platform/x86/intel/vbtn.c                  |   3 -
 drivers/platform/x86/intel/vsec.c                  |   5 +-
 drivers/platform/x86/intel/wmi/sbl-fw-update.c     |   5 +-
 drivers/platform/x86/intel/wmi/thunderbolt.c       |   1 +
 drivers/platform/x86/intel_scu_ipcutil.c           |   2 +-
 drivers/platform/x86/intel_scu_pcidrv.c            |   1 -
 drivers/platform/x86/intel_scu_wdt.c               |   1 -
 drivers/platform/x86/p2sb.c                        | 177 +++++--
 drivers/platform/x86/pmc_atom.c                    |  79 +++
 drivers/platform/x86/serdev_helpers.h              |  80 +++
 drivers/platform/x86/silicom-platform.c            |   7 +-
 drivers/platform/x86/think-lmi.c                   |  22 +-
 drivers/platform/x86/thinkpad_acpi.c               | 258 ++++++---
 drivers/platform/x86/touchscreen_dmi.c             |  73 ++-
 drivers/platform/x86/wmi-bmof.c                    |   1 +
 drivers/platform/x86/wmi.c                         | 377 +++++++------
 drivers/platform/x86/x86-android-tablets/core.c    |  38 +-
 drivers/platform/x86/x86-android-tablets/lenovo.c  |   1 +
 drivers/platform/x86/x86-android-tablets/other.c   |   4 +-
 .../x86/x86-android-tablets/x86-android-tablets.h  |   1 +
 include/linux/platform_data/x86/pmc_atom.h         |  25 +-
 include/linux/wmi.h                                |   4 +-
 include/trace/events/intel_ifs.h                   |  12 +-
 include/uapi/linux/input-event-codes.h             |   1 +
 73 files changed, 2466 insertions(+), 968 deletions(-)
 create mode 100644 drivers/platform/x86/serdev_helpers.h

