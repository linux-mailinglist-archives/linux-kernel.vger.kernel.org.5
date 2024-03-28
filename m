Return-Path: <linux-kernel+bounces-123278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7738905DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A831F244A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0A13A418;
	Thu, 28 Mar 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtvsOjQ6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0D13A41B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643876; cv=none; b=hySP2QbEs1w6y7tD40lYLkHjS2BltfbbMbK+QOFhOLCQ03JpbItrcn5sVEuI1lnGAmeRVwGXWrmU7ajADMk1XDV3nuZhwCFsau9//IWTMInyh8qOOappUd5qzzBmCLuXmlVRW/45fctLtbt/Ok9GBEuTLVZacddPq3RRxsoiUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643876; c=relaxed/simple;
	bh=0kNwVzCbfCMNGoOxBfZPY7zyoeVfnGaCcVqz433zuec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTjUahNWzGZShItWdXTIh1oeYDwnQ43Q5zu9wlyvPM2ZZLFuDOB3Skq9kd8SJWyJoRFcsWMLR9+7NL1LUtGTo32/OaDxLuFrjvXyuWxuDBleQaz5W/KyjIEG7FslyWRHue2sElRVGmBgu0Du+eL+KqblUPAYJbs8WyJ+czWdwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtvsOjQ6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711643873; x=1743179873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0kNwVzCbfCMNGoOxBfZPY7zyoeVfnGaCcVqz433zuec=;
  b=OtvsOjQ66UUO3LhndydQ5qk3GrVsqK73/Jun7/3/+Nj8GOQZfcjBIZ8w
   qH7qk0yYh5AYehL6QQCgcImbMulNhRmY8eLNusjsYxSzJNrLn/z6SH1He
   ZbKO8k9lWNVJdKxDTj07BB00jxqJMJNHIU5b1dXi1sIazz5lrVdBMbNYO
   Y5YrfEQCvsIohqh2OnrNb0umzcJxWzb9Ulp4ByPX05PSw5u7GLOJhrJ2j
   1wtJXD0fzf2lh85Eo4a7qmhHqMU69DFKaIePozOWEn7qJdIzrlVOAsAAg
   Dr+m3RRo/JFChbL76AxOiHUv98461SMf/h1VuIdhMPQKjbb9sjo+/XcrT
   A==;
X-CSE-ConnectionGUID: Wzn2dY5tTuSdEge/4l3DmA==
X-CSE-MsgGUID: J5LTghV7RKqROv/Ss9/VSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24296525"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24296525"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39852819"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:37:52 -0700
From: Tony Luck <tony.luck@intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 00/74] New Intel CPUID families
Date: Thu, 28 Mar 2024 09:37:43 -0700
Message-ID: <20240328163746.243023-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Q1: Where are all the other parts of this series. I only got 1-3.
A1: There are ~2700 subscribers to LKML. I want to get some feedback
on the approach and naming etc. before spamming everyone with a 74
patch series.

Q2: Can I get the other parts?
A2: Sure. I posted them to patches@lists.linux.dev so you can get them
with:
$ b4 am 20240328090459.242500-tony.luck@intel.com
or get from kernel.org with:
$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git new_families

Q3: When are CPUs using new families coming?
A3: Soon-ish. We have some time to get the infrastructure right.

Intel has been using family 6 almost exclusively for many
years. As a result, Linux has built up infrastructure like
X86_MATCH_INTEL_FAM6_MODEL() to make it easy for model specific code to
use the #defines for each Intel CPU model.

But the reign of family 6 is about to end. Intel will begin using non-zero
values for the extended family field in CPUID(1).EAX. The minimal patch
size approach to handle these would be to clone the FAM6 macros. But
that will get messy as these prolifrate. This approach does not have an
elegant solution if a switch() statement needs to choose between CPUs
from different families.

Dave Hansen suggested that a more general cleanup that provides
CPU #defines that encode all of <vendor, family, model> would make
existing code better, and provide infrastructure that makes it trivial
to incorporate new families.

Big picture view is that code like this:

  if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 6 && c->x86_model == INTEL_FAM6_ICELAKE_X)

can become:

  if (c->x86_vfm == INTEL_ICELAKE_X)

which is:
a)	Simpler
b)	Faster
c)	More resilient (can't forget to check vendor & family along with model)
d)	Code style doesn't change for every new family.

Note that "struct cpuinfo_x86" gains a new xf6_vfm field and the ICELAKE
#define loses the "FAM6_" substring and will be initialized with a macro
that does the bit shuffling to fit X86_VENDOR_INTEL and a family and
model into a "u32":

#define INTEL_ICELAKE_X                 IFM(6, 0x6A) /* Sunny Cove */

New CPUs in other families might look like:

#define INTEL_DOUGLASCOVE		IFM(42, 0x01) /* Adams Lake */
#define INTEL_SHELDONMONT		IFM(73, 0x01) /* Cooper Forest */

Model specific "if" statements then follow the same pattern
regardless of family:

  if (c->x86_vfm == INTEL_DOUGLASCOVE || c->x86_vfm == INTEL_SHELDONMONT) {
  }

If needed these could even appear in the same switch statement:

	switch (c->x86_vfm) {
	case INTEL_ICELAKE_X:
		...
	case INTEL_DOUGLASCOVE:
		...
	case INTEL_SHELDONMONT:
		...
	}

The existing X86_MATCH_INTEL_FAM6_MODEL() can be replaced with a new
X86_MATCH_VFM() macro.

Update can happen in three phases:

1) Add infrastructure macros, new "x86_vfm" field, new CPU #defines

2) Treewide update from old to new (around 70 files at current count)

3) Delete the old INTEL_FAM6 and X86_MATCH_INTEL_FAM6 macros

Tony Luck (74):
  x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86
  x86/cpu/vfm: Add new macros to work with (vendor/family/model) values
  x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h
  x86/cpu/vfm: Update arch/x86/crypto/poly1305_glue.c
  x86/cpu/vfm: Update arch/x86/crypto/twofish_glue_3way.c
  x86/cpu/vfm: Update arch/x86/events/intel/cstate.c
  x86/cpu/vfm: Update arch/x86/events/intel/lbr.c
  x86/cpu/vfm: Update arch/x86/events/intel/pt.c
  x86/cpu/vfm: Update arch/x86/events/intel/uncore.c
  x86/cpu/vfm: Update arch/x86/events/intel/uncore_nhmex.c
  x86/cpu/vfm: Update arch/x86/events/intel/uncore_snbep.c
  x86/cpu/vfm: Update arch/x86/events/msr.c
  x86/cpu/vfm: Update arch/x86/events/rapl.c
  x86/cpu/vfm: Update arch/x86/kernel/apic/apic.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/aperfmperf.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/bugs.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/common.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/intel.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/intel_epb.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/match.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/core.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/intel.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/mce/severity.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/microcode/intel.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/resctrl/core.c
  x86/cpu/vfm: Update arch/x86/kernel/cpu/resctrl/pseudo_lock.c
  x86/cpu/vfm: Update arch/x86/kernel/smpboot.c
  x86/cpu/vfm: Update arch/x86/kernel/tsc.c
  x86/cpu/vfm: Update arch/x86/kernel/tsc_msr.c
  x86/cpu/vfm: Update arch/x86/kvm/pmu.c
  x86/cpu/vfm: Update arch/x86/kvm/vmx/vmx.c
  x86/cpu/vfm: Update arch/x86/mm/init.c
  x86/cpu/vfm: Update arch/x86/pci/intel_mid_pci.c
  x86/cpu/vfm: Update arch/x86/virt/vmx/tdx/tdx.c
  x86/cpu/vfm: Update drivers/acpi/acpi_lpss.c
  x86/cpu/vfm: Update drivers/acpi/x86/utils.c
  x86/cpu/vfm: Update tpm files
  x86/cpu/vfm: Update drivers/cpufreq/intel_pstate.c
  x86/cpu/vfm: Update drivers/cpufreq/speedstep-centrino.c
  x86/cpu/vfm: Update drivers/edac/i10nm_base.c
  x86/cpu/vfm: Update drivers/edac/pnd2_edac.c
  x86/cpu/vfm: Update drivers/edac/sb_edac.c
  x86/cpu/vfm: Update drivers/edac/skx_base.c
  x86/cpu/vfm: Update drivers/extcon/extcon-axp288.c
  x86/cpu/vfm: Update drivers/hwmon/peci/cputemp.c
  x86/cpu/vfm: Update drivers/idle/intel_idle.c
  x86/cpu/vfm: Update drivers/pci/pci-mid.c
  x86/cpu/vfm: Update drivers/peci/cpu.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/ifs/core.c
  x86/cpu/vfm: Update drivers/platform/x86/intel_ips.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/pmc/core.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/pmc/pltdrv.c
  x86/cpu/vfm: Update drivers/platform/x86/intel_scu_wdt.c
  x86/cpu/vfm: Update
    drivers/platform/x86/intel/speed_select_if/isst_if_common.c
  x86/cpu/vfm: Update
    drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/telemetry/debugfs.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/telemetry/pltdrv.c
  x86/cpu/vfm: Update drivers/platform/x86/intel/turbo_max_3.c
  x86/cpu/vfm: Update
    drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
  x86/cpu/vfm: Update drivers/platform/x86/p2sb.c
  x86/cpu/vfm: Update drivers/powercap/intel_rapl_common.c
  x86/cpu/vfm: Update drivers/powercap/intel_rapl_msr.c
  x86/cpu/vfm: Update
    drivers/staging/media/atomisp/include/linux/atomisp_platform.h
  x86/cpu/vfm: Update intel_soc_dts_thermal.c
  x86/cpu/vfm: Update drivers/thermal/intel/intel_tcc_cooling.c
  x86/cpu/vfm: Update sound/soc/intel/avs/boards/es8336.c
  x86/cpu/vfm: Update arch/x86/events/intel/core.c
  x86/cpu/vfm: Update arch/x86/platform/intel-mid/intel-mid.c
  x86/cpu/vfm: Update arch/x86/platform/atom/punit_atom_debug.c
  x86/cpu/vfm: Update arch/x86/events/intel/core.c
  x86/cpu/vfm: Update tools/power/x86/turbostat/turbostat.c
  x86/cpu/vfm: Update arch/x86/boot/cpucheck.c
  x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
  x86/cpu/vfm: Delete all the *_FAM6_ CPU #defines

 .../atomisp/include/linux/atomisp_platform.h  |  26 +--
 include/linux/peci-cpu.h                      |   1 +
 include/linux/platform_data/x86/soc.h         |  12 +-
 arch/x86/include/asm/cpu_device_id.h          | 103 +++++++--
 arch/x86/include/asm/intel-family.h           | 167 +++++++-------
 arch/x86/include/asm/processor.h              |  12 +-
 drivers/char/tpm/tpm.h                        |   1 +
 drivers/char/tpm/tpm_tis_core.h               |   2 +-
 arch/x86/boot/cpucheck.c                      |   2 +-
 arch/x86/crypto/poly1305_glue.c               |   3 +-
 arch/x86/crypto/twofish_glue_3way.c           |  10 +-
 arch/x86/events/intel/core.c                  | 212 +++++++++---------
 arch/x86/events/intel/cstate.c                | 144 ++++++------
 arch/x86/events/intel/lbr.c                   |   3 +-
 arch/x86/events/intel/pt.c                    |  11 +-
 arch/x86/events/intel/uncore.c                | 100 ++++-----
 arch/x86/events/intel/uncore_nhmex.c          |   3 +-
 arch/x86/events/intel/uncore_snbep.c          |   5 +-
 arch/x86/events/msr.c                         | 131 +++++------
 arch/x86/events/rapl.c                        |  84 +++----
 arch/x86/kernel/apic/apic.c                   |  38 ++--
 arch/x86/kernel/cpu/aperfmperf.c              |  17 +-
 arch/x86/kernel/cpu/bugs.c                    |  29 +--
 arch/x86/kernel/cpu/common.c                  | 154 +++++++------
 arch/x86/kernel/cpu/intel.c                   | 115 +++++-----
 arch/x86/kernel/cpu/intel_epb.c               |  12 +-
 arch/x86/kernel/cpu/match.c                   |   5 +-
 arch/x86/kernel/cpu/mce/core.c                |   5 +-
 arch/x86/kernel/cpu/mce/intel.c               |  20 +-
 arch/x86/kernel/cpu/mce/severity.c            |   9 +-
 arch/x86/kernel/cpu/microcode/intel.c         |   4 +-
 arch/x86/kernel/cpu/resctrl/core.c            |   9 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  21 +-
 arch/x86/kernel/smpboot.c                     |   6 +-
 arch/x86/kernel/tsc.c                         |   5 +-
 arch/x86/kernel/tsc_msr.c                     |  14 +-
 arch/x86/kvm/pmu.c                            |   8 +-
 arch/x86/kvm/vmx/vmx.c                        |  20 +-
 arch/x86/mm/init.c                            |  16 +-
 arch/x86/pci/intel_mid_pci.c                  |   4 +-
 arch/x86/platform/atom/punit_atom_debug.c     |  11 +-
 arch/x86/platform/intel-mid/intel-mid.c       |   7 +-
 arch/x86/virt/vmx/tdx/tdx.c                   |   7 +-
 drivers/acpi/acpi_lpss.c                      |   4 +-
 drivers/acpi/x86/utils.c                      |  42 ++--
 drivers/cpufreq/intel_pstate.c                |  90 ++++----
 drivers/cpufreq/speedstep-centrino.c          |   8 +-
 drivers/edac/i10nm_base.c                     |  20 +-
 drivers/edac/pnd2_edac.c                      |   4 +-
 drivers/edac/sb_edac.c                        |  14 +-
 drivers/edac/skx_base.c                       |   2 +-
 drivers/extcon/extcon-axp288.c                |   2 +-
 drivers/hwmon/peci/cputemp.c                  |   7 +-
 drivers/idle/intel_idle.c                     | 116 +++++-----
 drivers/pci/pci-mid.c                         |   4 +-
 drivers/peci/cpu.c                            |  28 +--
 drivers/platform/x86/intel/ifs/core.c         |  15 +-
 drivers/platform/x86/intel/pmc/core.c         |  46 ++--
 drivers/platform/x86/intel/pmc/pltdrv.c       |  16 +-
 .../intel/speed_select_if/isst_if_common.c    |   4 +-
 .../intel/speed_select_if/isst_if_mbox_msr.c  |   2 +-
 .../platform/x86/intel/telemetry/debugfs.c    |   4 +-
 drivers/platform/x86/intel/telemetry/pltdrv.c |   4 +-
 drivers/platform/x86/intel/turbo_max_3.c      |   4 +-
 .../intel/uncore-frequency/uncore-frequency.c |  56 ++---
 drivers/platform/x86/intel_ips.c              |   3 +-
 drivers/platform/x86/intel_scu_wdt.c          |   2 +-
 drivers/platform/x86/p2sb.c                   |   2 +-
 drivers/powercap/intel_rapl_common.c          | 118 +++++-----
 drivers/powercap/intel_rapl_msr.c             |  16 +-
 drivers/thermal/intel/intel_soc_dts_thermal.c |   2 +-
 drivers/thermal/intel/intel_tcc_cooling.c     |  30 +--
 sound/soc/intel/avs/boards/es8336.c           |   7 +-
 tools/power/x86/turbostat/turbostat.c         | 161 +++++++------
 74 files changed, 1258 insertions(+), 1143 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0


