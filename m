Return-Path: <linux-kernel+bounces-69051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D18583D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414361C232D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80526137C31;
	Fri, 16 Feb 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceYp5PZ6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAB134CDC;
	Fri, 16 Feb 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103556; cv=none; b=oW9Brj6nqSbpNSosDr3kopTbcWaqOdimPVGqF6rDC0T0ZG0lNljbV8pCAgjlL4lyps8AwTT1StIwW4eDinsUn/vy0KfDzgPrELKdiPdtPWPlxnhUQKmssYC/8GI9Hv0PvZP4fKTdWFMosCxlzxBCcsb83KIm3QTLIdYeewzKmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103556; c=relaxed/simple;
	bh=K6UtEVBR6uRkR+4SVn/AX4Wfv7U6gUrkLF6U4slDXBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVF46r45o5tz26l1W1edyqbvT4sGh8uxsSMuZ/hUM5tevXbd5tvQwRGWn2G/aE0xuXfRBvJ7218D3CqQGC7dzp65qZVThtc8AU7St+Pkq5uYakAfrSh38l25Xaky65HuvjeRYLTJuPI4SH4BHM/z+6wGqkCxldFmlFTUkWm+qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceYp5PZ6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708103555; x=1739639555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6UtEVBR6uRkR+4SVn/AX4Wfv7U6gUrkLF6U4slDXBs=;
  b=ceYp5PZ6isEufS0m9uMRRoq7B+AMFlaAdQvrBmJk5EoP5jWsfu0BjK0Z
   Rml4X9Z6Njc9GrVS1RhUuSskovju0uNGUMOEflP85j4rSCXDxgSYT+I3l
   38HDysT/7wSynC5EhRvnJMEUoabvLFNTO5ZUBAVet9NEAco2ZrSR8OXZ+
   bIUqxd8G/h2qB+O4shAPNnAgV+A0WsxsLF9VcbGfITYFf1UNiObTWLNJh
   t+LMtBrXZb715a+UA5WwTgCprZ75sjHKcFIx2hYDgwotRMVyeZTep902w
   CERDGITUsawfD/3Q3C7ij4mIDN/RzhqotfWB+4zEDs+8OwqO/6VLPh3Pr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12782911"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12782911"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8486686"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 16 Feb 2024 09:11:59 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rb1kV-0001UC-29;
	Fri, 16 Feb 2024 17:11:48 +0000
Date: Sat, 17 Feb 2024 01:11:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v6 1/5] drm: Stop using `select ACPI_VIDEO` in all drivers
Message-ID: <202402170047.miJMtqIc-lkp@intel.com>
References: <20240214215756.6530-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214215756.6530-2-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.8-rc4 next-20240216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-Stop-using-select-ACPI_VIDEO-in-all-drivers/20240215-055936
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240214215756.6530-2-mario.limonciello%40amd.com
patch subject: [PATCH v6 1/5] drm: Stop using `select ACPI_VIDEO` in all drivers
config: alpha-kismet-CONFIG_FB_BACKLIGHT-CONFIG_FB_RIVA-0-0 (https://download.01.org/0day-ci/archive/20240217/202402170047.miJMtqIc-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240217/202402170047.miJMtqIc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402170047.miJMtqIc-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for FB_BACKLIGHT when selected by FB_RIVA
   .config:69:warning: symbol value 'n' invalid for FAT_DEFAULT_CODEPAGE
   .config:240:warning: symbol value 'n' invalid for SATA_MOBILE_LPM_POLICY
   .config:307:warning: symbol value 'n' invalid for XEN_MEMORY_HOTPLUG_LIMIT
   .config:328:warning: symbol value 'n' invalid for PSTORE_BLK_MAX_REASON
   .config:359:warning: symbol value 'n' invalid for AIC79XX_DEBUG_MASK
   .config:429:warning: symbol value 'n' invalid for KFENCE_SAMPLE_INTERVAL
   .config:612:warning: symbol value 'n' invalid for CRYPTO_DEV_QCE_SW_MAX_LEN
   .config:613:warning: symbol value 'n' invalid for DRM_XE_JOB_TIMEOUT_MIN
   .config:702:warning: symbol value 'n' invalid for VGA_ARB_MAX_GPUS
   .config:715:warning: symbol value 'n' invalid for PANEL_LCD_CHARSET
   .config:789:warning: symbol value 'n' invalid for SND_AC97_POWER_SAVE_DEFAULT
   .config:793:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_Y
   .config:811:warning: symbol value 'n' invalid for AIC79XX_CMDS_PER_DEVICE
   .config:830:warning: symbol value 'n' invalid for DRM_I915_MAX_REQUEST_BUSYWAIT
   .config:855:warning: symbol value 'n' invalid for SND_AT73C213_TARGET_BITRATE
   .config:877:warning: symbol value 'n' invalid for PANEL_LCD_PIN_SDA
   .config:893:warning: symbol value 'n' invalid for DRM_XE_PREEMPT_TIMEOUT_MIN
   .config:901:warning: symbol value 'n' invalid for NET_EMATCH_STACK
   .config:903:warning: symbol value 'n' invalid for VMCP_CMA_SIZE
   .config:1095:warning: symbol value 'n' invalid for USB_GADGET_STORAGE_NUM_BUFFERS
   .config:1130:warning: symbol value 'n' invalid for RCU_CPU_STALL_TIMEOUT
   .config:1159:warning: symbol value 'n' invalid for MTDRAM_ERASE_SIZE
   .config:1238:warning: symbol value 'n' invalid for SERIAL_UARTLITE_NR_UARTS
   .config:1397:warning: symbol value 'n' invalid for LEGACY_PTY_COUNT
   .config:1524:warning: symbol value 'n' invalid for PANEL_LCD_PIN_E
   .config:1528:warning: symbol value 'n' invalid for AIC7XXX_RESET_DELAY_MS
   .config:1726:warning: symbol value 'n' invalid for IBM_EMAC_POLL_WEIGHT
   .config:1763:warning: symbol value 'n' invalid for SCSI_MESH_RESET_DELAY_MS
   .config:1817:warning: symbol value 'n' invalid for DRM_I915_STOP_TIMEOUT
   .config:2048:warning: symbol value 'n' invalid for KCOV_IRQ_AREA_SIZE
   .config:2143:warning: symbol value 'n' invalid for RCU_FANOUT_LEAF
   .config:2237:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MAX
   .config:2290:warning: symbol value 'n' invalid for PANEL_LCD_BWIDTH
   .config:2523:warning: symbol value 'n' invalid for PANEL_PARPORT
   .config:2568:warning: symbol value 'n' invalid for SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST_NUM
   .config:2606:warning: symbol value 'n' invalid for NOUVEAU_DEBUG_DEFAULT
   .config:2707:warning: symbol value 'n' invalid for AIC79XX_RESET_DELAY_MS
   .config:2779:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_BAUDRATE
   .config:2791:warning: symbol value 'n' invalid for KCSAN_REPORT_ONCE_IN_MS
   .config:2888:warning: symbol value 'n' invalid for KCSAN_UDELAY_INTERRUPT
   .config:2910:warning: symbol value 'n' invalid for PANEL_LCD_PIN_BL
   .config:2934:warning: symbol value 'n' invalid for INITRAMFS_ROOT_GID
   .config:2968:warning: symbol value 'n' invalid for DUMMY_CONSOLE_ROWS
   .config:3008:warning: symbol value 'n' invalid for PSTORE_BLK_CONSOLE_SIZE
   .config:3038:warning: symbol value 'n' invalid for ATM_FORE200E_TX_RETRY
   .config:3078:warning: symbol value 'n' invalid for FB_OMAP2_DSS_MIN_FCK_PER_PCK
   .config:3203:warning: symbol value 'n' invalid for BOOKE_WDT_DEFAULT_TIMEOUT
   .config:3248:warning: symbol value 'n' invalid for MTD_REDBOOT_DIRECTORY_BLOCK
   .config:3294:warning: symbol value 'n' invalid for KCSAN_UDELAY_TASK
   .config:3407:warning: symbol value 'n' invalid for MMC_BLOCK_MINORS
   .config:3455:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_SYNC
   .config:3570:warning: symbol value 'n' invalid for UCLAMP_BUCKETS_COUNT
   .config:3636:warning: symbol value 'n' invalid for SERIAL_MCF_BAUDRATE
   .config:3708:warning: symbol value 'n' invalid for DE2104X_DSL
   .config:3721:warning: symbol value 'n' invalid for BLK_DEV_RAM_COUNT
   .config:3787:warning: symbol value 'n' invalid for STACK_MAX_DEFAULT_SIZE_MB
   .config:3964:warning: symbol value 'n' invalid for IP_VS_SH_TAB_BITS
   .config:4094:warning: symbol value 'n' invalid for CMA_AREAS
   .config:4105:warning: symbol value 'n' invalid for USBIP_VHCI_HC_PORTS
   .config:4149:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_X
   .config:4235:warning: symbol value 'n' invalid for FTRACE_RECORD_RECURSION_SIZE
   .config:4264:warning: symbol value 'n' invalid for RIONET_RX_SIZE
   .config:4416:warning: symbol value 'n' invalid for RADIO_TYPHOON_PORT
   .config:4524:warning: symbol value 'n' invalid for SERIAL_TXX9_NR_UARTS
   .config:4565:warning: symbol value 'n' invalid for IBM_EMAC_TXB
   .config:4948:warning: symbol value 'n' invalid for ARCH_MMAP_RND_BITS
   .config:4975:warning: symbol value 'n' invalid for IP_VS_MH_TAB_INDEX
   .config:5029:warning: symbol value 'n' invalid for DRM_I915_FENCE_TIMEOUT
   .config:5051:warning: symbol value 'n' invalid for TTY_PRINTK_LEVEL
   .config:5209:warning: symbol value 'n' invalid for MIPS_EJTAG_FDC_KGDB_CHAN
   .config:5298:warning: symbol value 'n' invalid for KDB_DEFAULT_ENABLE
   .config:5316:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_MAXPORTS
   .config:5323:warning: symbol value 'n' invalid for PANEL_PROFILE
   .config:5384:warning: symbol value 'n' invalid for PPC_EARLY_DEBUG_EHV_BC_HANDLE
   .config:5424:warning: symbol value 'n' invalid for PANEL_LCD_PIN_RW
   .config:5570:warning: symbol value 'n' invalid for CRYPTO_DEV_FSL_CAAM_INTC_TIME_THLD
   .config:5574:warning: symbol value 'n' invalid for PANEL_LCD_HWIDTH
   .config:5605:warning: symbol value 'n' invalid for LOCKDEP_CHAINS_BITS
   .config:5694:warning: symbol value 'n' invalid for DRM_I915_HEARTBEAT_INTERVAL
   .config:5702:warning: symbol value 'n' invalid for KCSAN_SKIP_WATCH
   .config:5724:warning: symbol value 'n' invalid for PSTORE_BLK_KMSG_SIZE
   .config:5929:warning: symbol value 'n' invalid for SERIAL_8250_RUNTIME_UARTS
   .config:6021:warning: symbol value 'n' invalid for ARCH_MMAP_RND_COMPAT_BITS
   .config:6127:warning: symbol value 'n' invalid for RCU_BOOST_DELAY
   .config:6186:warning: symbol value 'n' invalid for RADIO_TRUST_PORT
   .config:6198:warning: symbol value 'n' invalid for SERIAL_SH_SCI_NR_UARTS
   .config:6321:warning: symbol value 'n' invalid for VERBOSE_MCHECK_ON
   .config:6560:warning: symbol value 'n' invalid for CMA_SIZE_PERCENTAGE
   .config:6580:warning: symbol value 'n' invalid for DRM_XE_PREEMPT_TIMEOUT_MAX
   .config:6708:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MIN
   .config:6757:warning: symbol value 'n' invalid for DVB_MAX_ADAPTERS
   .config:6760:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_MAX_TAGS
   .config:6777:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
   .config:7048:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_MAX_TAGS
   .config:7062:warning: symbol value 'n' invalid for ZSMALLOC_CHAIN_SIZE
   .config:7140:warning: symbol value 'n' invalid for IBM_EMAC_RXB
   .config:7148:warning: symbol value 'n' invalid for MTD_UBI_WL_THRESHOLD
   .config:7167:warning: symbol value 'n' invalid for RIONET_TX_SIZE
   .config:7172:warning: symbol value 'n' invalid for SERIAL_ARC_NR_PORTS
   .config:7266:warning: symbol value 'n' invalid for LOCKDEP_BITS

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

