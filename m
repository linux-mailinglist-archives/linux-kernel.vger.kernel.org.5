Return-Path: <linux-kernel+bounces-46676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B1E8442A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B0FB33309
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7684A50;
	Wed, 31 Jan 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWOKkJDm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80A82867;
	Wed, 31 Jan 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713248; cv=none; b=Y9jptGioA2lW4rS4nOZYDGKfa9RuyexQCSrA1rmmkntzzGSGT504RbGgRJymyO6lO4f5I/1gzC/zEnaMAAMMHYBAyV7YJ6dszq5Rsiyz7ZuBDE6CAH1X4UN0eu44A7veICK7X+NiB+sBL3Tj8drsG9QZEQipYqCYmKt8HF5Igl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713248; c=relaxed/simple;
	bh=XHXmUrXB0DQ91NntNyc8xAkHA9J2SJKaW6SzVulinmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKD48gOC5E6+yW6SXSUBXLfCKNzm6cugUkLrE0heO/Pj0b/MlTbbcrEyWJVC5c8g7JsCqK51OkuQBJnJ94Aub0JfZ+I87mxh8fsfmcpumVEc65aTOfgnTgQxFh52Y5lzPUn5GQsdo9Jk+nHvlYYFdSQ8QHDeS+VoHGYB+kumojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWOKkJDm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706713247; x=1738249247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XHXmUrXB0DQ91NntNyc8xAkHA9J2SJKaW6SzVulinmY=;
  b=QWOKkJDmQ10bh9ScmNFgFbSqajw2ZpSxCd+EZlyNhfLxT8DueRQou2Kd
   oVVpxsftz22PdIKsgXvhXKMYRigFBvpvfwktyGNjsOq9wg9npKRILm7ZN
   0Y/g1/rdW8/bqPM25RjPG4zBye5qxMXlO5NC8lOvpwEjN6HJwZt7gAicn
   t/APn0stKMtxxpNgoRyDOYVJktBalUXb7LMRg97WEpLRcPcHgJe12Jo72
   hnzJ+XL8OzIDx3gxm1YIMrIFr6drZyF23gpH68ODwXdXeVZZNzoL3sEa/
   DAeN+LnhdHxOdhfnpC0PvihffXPMk9s6LBiubFqukj1zq+A4tCFXeDj54
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10257208"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10257208"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 07:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30525905"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2024 07:00:37 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVC4o-0001eh-2h;
	Wed, 31 Jan 2024 15:00:34 +0000
Date: Wed, 31 Jan 2024 23:00:12 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	Melissa Wen <mwen@igalia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 2/4] drm: Add drm_get_acpi_edid() helper
Message-ID: <202401312256.jBAoMFd9-lkp@intel.com>
References: <20240130192608.11666-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130192608.11666-3-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/acpi-bus linus/master v6.8-rc2 next-20240131]
[cannot apply to drm-misc/drm-misc-next rafael-pm/devprop]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-video-Handle-fetching-EDID-that-is-longer-than-256-bytes/20240131-032909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240130192608.11666-3-mario.limonciello%40amd.com
patch subject: [PATCH v2 2/4] drm: Add drm_get_acpi_edid() helper
config: x86_64-kismet-CONFIG_ACPI_WMI-CONFIG_DRM-0-0 (https://download.01.org/0day-ci/archive/20240131/202401312256.jBAoMFd9-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240131/202401312256.jBAoMFd9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401312256.jBAoMFd9-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ACPI_WMI when selected by DRM
   .config:248:warning: symbol value 'n' invalid for AIC79XX_CMDS_PER_DEVICE
   .config:250:warning: symbol value 'n' invalid for SATA_MOBILE_LPM_POLICY
   .config:308:warning: symbol value 'n' invalid for SQUASHFS_FRAGMENT_CACHE_SIZE
   .config:333:warning: symbol value 'n' invalid for PANEL_LCD_PIN_SDA
   .config:356:warning: symbol value 'n' invalid for PSTORE_BLK_MAX_REASON
   .config:414:warning: symbol value 'n' invalid for FB_OMAP2_NUM_FBS
   .config:459:warning: symbol value 'n' invalid for KFENCE_SAMPLE_INTERVAL
   .config:543:warning: symbol value 'n' invalid for CFAG12864B_RATE
   .config:651:warning: symbol value 'n' invalid for CRYPTO_DEV_QCE_SW_MAX_LEN
   .config:665:warning: symbol value 'n' invalid for BLK_DEV_LOOP_MIN_COUNT
   .config:756:warning: symbol value 'n' invalid for PANEL_LCD_CHARSET
   .config:840:warning: symbol value 'n' invalid for SND_AC97_POWER_SAVE_DEFAULT
   .config:855:warning: symbol value 'n' invalid for MAGIC_SYSRQ_DEFAULT_ENABLE
   .config:893:warning: symbol value 'n' invalid for DRM_I915_MAX_REQUEST_BUSYWAIT
   .config:894:warning: symbol value 'n' invalid for RAPIDIO_DISC_TIMEOUT
   .config:917:warning: symbol value 'n' invalid for FAT_DEFAULT_CODEPAGE
   .config:920:warning: symbol value 'n' invalid for SND_AT73C213_TARGET_BITRATE
   .config:966:warning: symbol value 'n' invalid for CMA_SIZE_MBYTES
   .config:967:warning: symbol value 'n' invalid for NET_EMATCH_STACK
   .config:969:warning: symbol value 'n' invalid for VMCP_CMA_SIZE
   .config:1152:warning: symbol value 'n' invalid for NODES_SHIFT
   .config:1247:warning: symbol value 'n' invalid for MTDRAM_ERASE_SIZE
   .config:1307:warning: symbol value 'n' invalid for SERIAL_UARTLITE_NR_UARTS
   .config:1318:warning: symbol value 'n' invalid for AIC7XXX_DEBUG_MASK
   .config:1479:warning: symbol value 'n' invalid for LEGACY_PTY_COUNT
   .config:1645:warning: symbol value 'n' invalid for AIC7XXX_RESET_DELAY_MS
   .config:1682:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_Y
   .config:1861:warning: symbol value 'n' invalid for IBM_EMAC_POLL_WEIGHT
   .config:1936:warning: symbol value 'n' invalid for DRM_I915_STOP_TIMEOUT
   .config:2029:warning: symbol value 'n' invalid for USB_GADGET_STORAGE_NUM_BUFFERS
   .config:2151:warning: symbol value 'n' invalid for SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST_NUM
   .config:2259:warning: symbol value 'n' invalid for SND_HDA_PREALLOC_SIZE
   .config:2310:warning: symbol value 'n' invalid for RCU_FANOUT_LEAF
   .config:2467:warning: symbol value 'n' invalid for PANEL_LCD_BWIDTH
   .config:2523:warning: symbol value 'n' invalid for PANEL_LCD_PIN_E
   .config:2542:warning: symbol value 'n' invalid for PSTORE_BLK_CONSOLE_SIZE
   .config:2725:warning: symbol value 'n' invalid for PANEL_PARPORT
   .config:2745:warning: symbol value 'n' invalid for BOOKE_WDT_DEFAULT_TIMEOUT
   .config:2824:warning: symbol value 'n' invalid for NOUVEAU_DEBUG_DEFAULT
   .config:3026:warning: symbol value 'n' invalid for KCSAN_REPORT_ONCE_IN_MS
   .config:3136:warning: symbol value 'n' invalid for KCSAN_UDELAY_INTERRUPT
   .config:3162:warning: symbol value 'n' invalid for PANEL_LCD_PIN_BL
   .config:3190:warning: symbol value 'n' invalid for INITRAMFS_ROOT_GID
   .config:3306:warning: symbol value 'n' invalid for ATM_FORE200E_TX_RETRY
   .config:3347:warning: symbol value 'n' invalid for FB_OMAP2_DSS_MIN_FCK_PER_PCK
   .config:3351:warning: symbol value 'n' invalid for STACK_MAX_DEFAULT_SIZE_MB
   .config:3503:warning: symbol value 'n' invalid for KCSAN_UDELAY_TASK
   .config:3641:warning: symbol value 'n' invalid for AIC79XX_RESET_DELAY_MS
   .config:3722:warning: symbol value 'n' invalid for MMC_BLOCK_MINORS
   .config:3771:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_SYNC
   .config:3855:warning: symbol value 'n' invalid for SERIAL_MCF_BAUDRATE
   .config:3902:warning: symbol value 'n' invalid for UCLAMP_BUCKETS_COUNT
   .config:3944:warning: symbol value 'n' invalid for DE2104X_DSL
   .config:3956:warning: symbol value 'n' invalid for BLK_DEV_RAM_COUNT
   .config:4174:warning: symbol value 'n' invalid for IP_VS_SH_TAB_BITS
   .config:4201:warning: symbol value 'n' invalid for MTD_REDBOOT_DIRECTORY_BLOCK
   .config:4335:warning: symbol value 'n' invalid for USBIP_VHCI_HC_PORTS
   .config:4447:warning: symbol value 'n' invalid for X86_AMD_PSTATE_DEFAULT_MODE
   .config:4458:warning: symbol value 'n' invalid for CMA_AREAS
   .config:4516:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_X
   .config:4640:warning: symbol value 'n' invalid for RIONET_RX_SIZE
   .config:4685:warning: symbol value 'n' invalid for RADIO_TYPHOON_PORT
   .config:4808:warning: symbol value 'n' invalid for SERIAL_TXX9_NR_UARTS
   .config:4865:warning: symbol value 'n' invalid for MTRR_SANITIZER_SPARE_REG_NR_DEFAULT
   .config:4894:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_BAUDRATE
   .config:4965:warning: symbol value 'n' invalid for IBM_EMAC_TXB
   .config:5032:warning: symbol value 'n' invalid for DUMMY_CONSOLE_ROWS
   .config:5329:warning: symbol value 'n' invalid for FTRACE_RECORD_RECURSION_SIZE
   .config:5423:warning: symbol value 'n' invalid for CRYPTO_DEV_FSL_CAAM_INTC_TIME_THLD
   .config:5473:warning: symbol value 'n' invalid for DRM_I915_FENCE_TIMEOUT
   .config:5496:warning: symbol value 'n' invalid for TTY_PRINTK_LEVEL
   .config:5659:warning: symbol value 'n' invalid for MIPS_EJTAG_FDC_KGDB_CHAN
   .config:5712:warning: symbol value 'n' invalid for PPC_EARLY_DEBUG_EHV_BC_HANDLE
   .config:5757:warning: symbol value 'n' invalid for KDB_DEFAULT_ENABLE
   .config:5775:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_MAXPORTS
   .config:6033:warning: symbol value 'n' invalid for IP_VS_MH_TAB_INDEX
   .config:6055:warning: symbol value 'n' invalid for PANEL_LCD_HWIDTH
   .config:6189:warning: symbol value 'n' invalid for DRM_I915_HEARTBEAT_INTERVAL
   .config:6195:warning: symbol value 'n' invalid for KCSAN_SKIP_WATCH
   .config:6205:warning: symbol value 'n' invalid for EFI_MAX_FAKE_MEM
   .config:6220:warning: symbol value 'n' invalid for PSTORE_BLK_KMSG_SIZE
   .config:6443:warning: symbol value 'n' invalid for SERIAL_8250_RUNTIME_UARTS
   .config:6463:warning: symbol value 'n' invalid for PANEL_LCD_PIN_RW
   .config:6572:warning: symbol value 'n' invalid for SERIAL_SH_SCI_NR_UARTS
   .config:6726:warning: symbol value 'n' invalid for RADIO_TRUST_PORT
   .config:6937:warning: symbol value 'n' invalid for SND_MAX_CARDS
   .config:6996:warning: symbol value 'n' invalid for ZSMALLOC_CHAIN_SIZE
   .config:7104:warning: symbol value 'n' invalid for DVB_MAX_ADAPTERS
   .config:7111:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_MAX_TAGS
   .config:7124:warning: symbol value 'n' invalid for RCU_BOOST_DELAY
   .config:7130:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
   .config:7143:warning: symbol value 'n' invalid for CMA_SIZE_PERCENTAGE
   .config:7521:warning: symbol value 'n' invalid for IBM_EMAC_RXB
   .config:7815:warning: symbol value 'n' invalid for SERIAL_ARC_NR_PORTS
   .config:7944:warning: symbol value 'n' invalid for PANEL_LCD
   .config:7994:warning: symbol value 'n' invalid for SCSI_MPT3SAS_MAX_SGE
   .config:8000:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_MAX_TAGS
   .config:8084:warning: symbol value 'n' invalid for MTD_UBI_WL_THRESHOLD
   .config:8117:warning: symbol value 'n' invalid for RIONET_TX_SIZE
   .config:8132:warning: symbol value 'n' invalid for PSTORE_DEFAULT_KMSG_BYTES

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

