Return-Path: <linux-kernel+bounces-157447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A28B11C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4531F21EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C6E16D9B8;
	Wed, 24 Apr 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFSuGby5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F416D329
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982385; cv=none; b=T0O3KRL4RIkSKDpsJ5GjOGibH1Vw3hmGYCxMMdVe9YAZerYjlUMg1xW34ZrzT9VNd/8HREQPfr4n46zk3TYij1vJMRW8aliQNUdUPBunjKKM5Cif12dJlqc8lJP6Xz5G2RCbphbRxkPo9TfhwSkaSjNd+UnoqQyFlcZic/bf25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982385; c=relaxed/simple;
	bh=R6ZiefLsgg0LsDG7JIwWM8sSX7uOZitF5p9YcYiG8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAqzEbiSZ2rv/F+wu8Ur8kGFhBi0EcwugJnxuk/UCb3c9pBKskK2eirkZXcAg3mk9C81ksxKylyS5qYnr6uLG7kJCQvJgZ/tln5qEfmPxmlBswA6ylWmRBjLywU9tAv8rQWt2+bED27OBrl3pUKMEKhEpTEaj02BgKY66EMv2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFSuGby5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982383; x=1745518383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R6ZiefLsgg0LsDG7JIwWM8sSX7uOZitF5p9YcYiG8Gw=;
  b=gFSuGby5NEoOzkhJgOEo/hQ5wJw3XTi7WiZqTHzZh/K06vipJqUudraw
   uxBQAEEKl3xm9cyMucWvlUfw8L155Mel5p+7ZSoxZtog/VtwqxpILHXfh
   QyJYizzj1kdJeDoHs337UdWJUXT0IUqL+2SVRAqDeVJkV/Om2HEsKZRBk
   z61Ik6jOQKB4CUvYPQOJiqvy55G+6hkzHUoGWZ8t3NYH66Jsq7+KH8e/A
   1AF1dgSo9Y2vNxd9nqC1B+u94ZSt9zyybBo57HYMFwMMjfqZPWm/8Kv1q
   JsEBvLnD5Scjgv65Ud3CwjlVzFfImMO0eIiZxfVR8Q1yG3mAQ2Jdtm1wm
   A==;
X-CSE-ConnectionGUID: YXJTuy7wTLGuA5MbElVS5g==
X-CSE-MsgGUID: oDqwlNoaSuKS5qgQ1qizqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20183051"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="20183051"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:13:02 -0700
X-CSE-ConnectionGUID: eU+u0W26QHKTpS6GjOR1oQ==
X-CSE-MsgGUID: cI/TV3QsS6uyVFDIMi7vYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24863871"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:13:01 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 00/71] New Intel CPUID families
Date: Wed, 24 Apr 2024 11:12:45 -0700
Message-ID: <20240424181245.41141-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Full v3 description and patches here:
Link: https://lore.kernel.org/all/20240416211941.9369-1-tony.luck@intel.com/

But the tl;dr version is that some surgery is required to make adding
CPUs with new CPUID "family" values elegant.

Signed-off-by: Tony Luck <tony.luck@intel.com>

Changes since v3:

*) Parts 1-3 have been applied to tip x86/cpu (Thanks Boris!) so dropped from this series.
   Patches haved trickled through system and are now in linux-next (tag next-20240424)
   or higher). So from this new series any of parts 1-69 could be tested against
   tip x86/cpu or linux-next. There are hardly any interdependencies. Mostly safe
   to just pick out the patches you care about.

*) Base commit for v4 of the series is now tip x86/cpu
	f055b6260eb3 ("x86/cpu/vfm: Update arch/x86/include/asm/intel-family.h")

*) Fixed "Subject:" lines in each patch to use appropriate prefix for subsystem 
   followed by "Switch to new Intel CPU model defines"

*) Re-ordered remmaining patches to bring those with Acked-by or Reviewed-by
   tags to the head of the queue in case Boris wants to pick off some/all of
   patches 0001..0015 into tip x86/cpu (hint hint!).

*) Moved arch/x86/events/rapl.c patch to back of queue (patch 0069). It would
   have a conflict with the tip perf/core branch. This can be resolved with a
   future version against v6.10-rc1

*) Updated "peci" patches to have a copy of the VFM_*() macros instead of
   trying to include <asm/cpu_device_id.h> which doesn't work when building
   for a non-x86 target.

*) I had added #include <asm/cpu_device_id.h> to around a dozen files just before
   the #include <asm/intel-family.h>. But the former includes the latter. So
   simplify by just including <asm/cpu_device_id.h>

Tony Luck (71):
  tpm: Switch to new Intel CPU model defines
  platform/x86/intel/ifs: Switch to new Intel CPU model defines
  KVM: x86/pmu: Switch to new Intel CPU model defines
  KVM: VMX: Switch to new Intel CPU model defines
  ACPI: LPSS: Switch to new Intel CPU model defines
  ACPI: x86: Switch to new Intel CPU model defines
  cpufreq: intel_pstate: Switch to new Intel CPU model defines
  cpufreq: Switch to new Intel CPU model defines
  intel_idle: Switch to new Intel CPU model defines
  PCI: PM: Switch to new Intel CPU model defines
  powercap: intel_rapl: Switch to new Intel CPU model defines
  powercap: intel_rapl: Switch to new Intel CPU model defines
  ASoC: Intel: Switch to new Intel CPU model defines
  thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model
    defines
  tools/power/turbostat: Switch to new Intel CPU model defines
  crypto: x86/poly1305 - Switch to new Intel CPU model defines
  crypto: x86/twofish - Switch to new Intel CPU model defines
  perf/x86/intel/cstate: Switch to new Intel CPU model defines
  perf/x86/lbr: Switch to new Intel CPU model defines
  perf/x86/intel/pt: Switch to new Intel CPU model defines
  perf/x86/intel/uncore: Switch to new Intel CPU model defines
  perf/x86/intel/uncore: Switch to new Intel CPU model defines
  perf/x86/intel/uncore: Switch to new Intel CPU model defines
  perf/x86/msr: Switch to new Intel CPU model defines
  x86/apic: Switch to new Intel CPU model defines
  x86/aperfmperf: Switch to new Intel CPU model defines
  x86/bugs: Switch to new Intel CPU model defines
  x86/bugs: Switch to new Intel CPU model defines
  x86/cpu/intel: Switch to new Intel CPU model defines
  x86/cpu/intel_epb: Switch to new Intel CPU model defines
  x86/cpu: Switch to new Intel CPU model defines
  x86/mce: Switch to new Intel CPU model defines
  x86/mce: Switch to new Intel CPU model defines
  x86/mce: Switch to new Intel CPU model defines
  x86/microcode/intel: Switch to new Intel CPU model defines
  x86/resctrl: Switch to new Intel CPU model defines
  x86/resctrl: Switch to new Intel CPU model defines
  x86/cpu/: Switch to new Intel CPU model defines
  x86/tsc: Switch to new Intel CPU model defines
  x86/tsc_msr: Switch to new Intel CPU model defines
  x86/mm: Switch to new Intel CPU model defines
  x86/PCI: Switch to new Intel CPU model defines
  x86/virt/tdx: Switch to new Intel CPU model defines
  perf/x86/intel: Switch to new Intel CPU model defines
  x86/platform/intel-mid: Switch to new Intel CPU model defines
  x86/platform/atom: Switch to new Intel CPU model defines
  x86/cpu: Switch to new Intel CPU model defines
  x86/boot: Switch to new Intel CPU model defines
  EDAC/i10nm: Switch to new Intel CPU model defines
  EDAC, pnd2: Switch to new Intel CPU model defines
  EDAC/sb_edac: Switch to new Intel CPU model defines
  EDAC/skx: Switch to new Intel CPU model defines
  extcon: axp288: Switch to new Intel CPU model defines
  peci: cpu: Switch to new Intel CPU model defines
  hwmon: (peci/cputemp) Switch to new Intel CPU model defines
  platform/x86: intel_ips: Switch to new Intel CPU model defines
  platform/x86/intel/pmc: Switch to new Intel CPU model defines
  platform/x86/intel: pmc: Switch to new Intel CPU model defines
  platform/x86: intel_scu_wdt: Switch to new Intel CPU model defines
  platform/x86: ISST: Switch to new Intel CPU model defines
  platform/x86: intel_speed_select_if: Switch to new Intel CPU model
    defines
  platform/x86: intel_telemetry: Switch to new Intel CPU model defines
  platform/x86: intel: telemetry: Switch to new Intel CPU model defines
  platform/x86: intel_turbo_max_3: Switch to new Intel CPU model defines
  platform/x86: intel-uncore-freq: Switch to new Intel CPU model defines
  platform/x86: p2sb: Switch to new Intel CPU model defines
  media: atomisp: Switch to new Intel CPU model defines
  ASoC: Intel: avs: es8336: Switch to new Intel CPU model defines
  perf/x86/rapl: Switch to new Intel CPU model defines
  x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
  x86/cpu/vfm: Delete all the *_FAM6_ CPU #defines

 .../atomisp/include/linux/atomisp_platform.h  |  27 +--
 include/linux/peci-cpu.h                      |  24 ++
 include/linux/platform_data/x86/soc.h         |  12 +-
 arch/x86/include/asm/cpu_device_id.h          |  28 +--
 arch/x86/include/asm/intel-family.h           |  85 +------
 drivers/char/tpm/tpm.h                        |   2 +-
 drivers/char/tpm/tpm_tis_core.h               |   2 +-
 arch/x86/boot/cpucheck.c                      |   2 +-
 arch/x86/crypto/poly1305_glue.c               |   4 +-
 arch/x86/crypto/twofish_glue_3way.c           |  10 +-
 arch/x86/events/intel/core.c                  | 212 +++++++++---------
 arch/x86/events/intel/cstate.c                | 144 ++++++------
 arch/x86/events/intel/lbr.c                   |   3 +-
 arch/x86/events/intel/pt.c                    |  12 +-
 arch/x86/events/intel/uncore.c                | 100 ++++-----
 arch/x86/events/intel/uncore_nhmex.c          |   3 +-
 arch/x86/events/intel/uncore_snbep.c          |   5 +-
 arch/x86/events/msr.c                         | 132 +++++------
 arch/x86/events/rapl.c                        |  84 +++----
 arch/x86/kernel/apic/apic.c                   |  38 ++--
 arch/x86/kernel/cpu/aperfmperf.c              |  17 +-
 arch/x86/kernel/cpu/bugs.c                    |  30 +--
 arch/x86/kernel/cpu/common.c                  | 154 +++++++------
 arch/x86/kernel/cpu/intel.c                   | 115 +++++-----
 arch/x86/kernel/cpu/intel_epb.c               |  12 +-
 arch/x86/kernel/cpu/match.c                   |   2 +-
 arch/x86/kernel/cpu/mce/core.c                |   6 +-
 arch/x86/kernel/cpu/mce/intel.c               |  21 +-
 arch/x86/kernel/cpu/mce/severity.c            |  10 +-
 arch/x86/kernel/cpu/microcode/intel.c         |   5 +-
 arch/x86/kernel/cpu/resctrl/core.c            |  10 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  22 +-
 arch/x86/kernel/smpboot.c                     |   6 +-
 arch/x86/kernel/tsc.c                         |   6 +-
 arch/x86/kernel/tsc_msr.c                     |  14 +-
 arch/x86/kvm/pmu.c                            |   8 +-
 arch/x86/kvm/vmx/vmx.c                        |  20 +-
 arch/x86/mm/init.c                            |  16 +-
 arch/x86/pci/intel_mid_pci.c                  |   4 +-
 arch/x86/platform/atom/punit_atom_debug.c     |  11 +-
 arch/x86/platform/intel-mid/intel-mid.c       |   7 +-
 arch/x86/virt/vmx/tdx/tdx.c                   |   8 +-
 drivers/acpi/acpi_lpss.c                      |   4 +-
 drivers/acpi/x86/utils.c                      |  42 ++--
 drivers/cpufreq/intel_pstate.c                |  90 ++++----
 drivers/cpufreq/speedstep-centrino.c          |   8 +-
 drivers/edac/i10nm_base.c                     |  20 +-
 drivers/edac/pnd2_edac.c                      |   4 +-
 drivers/edac/sb_edac.c                        |  14 +-
 drivers/edac/skx_base.c                       |   2 +-
 drivers/extcon/extcon-axp288.c                |   2 +-
 drivers/hwmon/peci/cputemp.c                  |   6 +-
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
 sound/soc/intel/avs/boards/es8336.c           |   8 +-
 tools/power/x86/turbostat/turbostat.c         | 161 +++++++------
 73 files changed, 1103 insertions(+), 1163 deletions(-)


base-commit: f055b6260eb3ef20a6e310d1e555a5d5a0a28ca0
-- 
2.44.0


