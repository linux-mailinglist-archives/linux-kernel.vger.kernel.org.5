Return-Path: <linux-kernel+bounces-48846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D151384624B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C2B1C24B97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC653CF71;
	Thu,  1 Feb 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/8CTtw9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932A33CD2;
	Thu,  1 Feb 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821525; cv=none; b=kNpXBOWEXeyxx9K/cSyIkkTSfszaRjmtk1zaMo7Nsg8icyMGGadNpLNpyy0zWFgAYZBTEQJkyRNptdGd1iVQy5ks0mFxssx7wW1+IzfgkUrvHWT6fsMU7PSnMjMJqA6xdIeMQ2DijsWeMF8giyauz0Z9FKWIzHO3aT2j9B2GpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821525; c=relaxed/simple;
	bh=JrM9MmagdwnLeiIua1l4obRDHVnkZ/6XWzUT3gcqtQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuwSag7pR/CrAHUyiIhmPUYQlR7fVvZNpMkGWJYYBoDSHt7HMxWhLIl/AwzEBvylF70PcfvEN6hTTbuen9TJS6AiZgMp8r83PtmWukv2hgCTDFAKmpllQAuo1bftcNJa6MK/szM7ibUPgXModBzGG4JwuUbaEWWHPpFrsCLr6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/8CTtw9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706821524; x=1738357524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JrM9MmagdwnLeiIua1l4obRDHVnkZ/6XWzUT3gcqtQA=;
  b=N/8CTtw9KR54R5RcGJGvth6zxCuf/0J6BDZFh/nWEK6VYRUlsNOWyaO7
   AHk8/WoGLW8V3wxU+f7WvnEPpgWazE7N/I2WPFTtCQiCqvHbyg1fMh0dC
   YIkeYrVbaFmXLmbn37bNUVBgNqeXnO90pB+RznXckLc0bIUlJ0VssPZYR
   Dd3BR+/p/GENNgirDDvAG7MVINm89eUmKZ/tjeZmQEOtX8/kD7fnRMP9x
   vArmkyxqfoEDQae88A+HLyNsFnp2GWyeYQdJX1IGeGJpQPBH8v3oWsKpl
   Q8JYes38C1tH2U4kGtuM81+ZhVQCukJWNGTXFf3x21E/Qfb3bSYRfeXC/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="228017"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="228017"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 13:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="215002"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 01 Feb 2024 13:05:16 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVeFG-0003Cr-0o;
	Thu, 01 Feb 2024 21:05:14 +0000
Date: Fri, 2 Feb 2024 05:05:00 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu <claudiu.beznea@tuxon.dev>, wim@linux-watchdog.org,
	linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 02/11] watchdog: rzg2l_wdt: Select PM
Message-ID: <202402020445.TOBlFPcS-lkp@intel.com>
References: <20240131102017.1841495-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131102017.1841495-3-claudiu.beznea.uj@bp.renesas.com>

Hi Claudiu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on geert-renesas-devel/next]
[also build test WARNING on robh/for-next groeck-staging/hwmon-next linus/master v6.8-rc2]
[cannot apply to geert-renesas-drivers/renesas-clk next-20240201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu/clk-renesas-r9a08g045-Add-clock-and-reset-support-for-watchdog/20240131-182642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
patch link:    https://lore.kernel.org/r/20240131102017.1841495-3-claudiu.beznea.uj%40bp.renesas.com
patch subject: [PATCH v2 02/11] watchdog: rzg2l_wdt: Select PM
config: m68k-kismet-CONFIG_PM-CONFIG_RENESAS_RZG2LWDT-0-0 (https://download.01.org/0day-ci/archive/20240202/202402020445.TOBlFPcS-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240202/202402020445.TOBlFPcS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402020445.TOBlFPcS-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PM when selected by RENESAS_RZG2LWDT
   .config:35:warning: symbol value 'n' invalid for RAPIDIO_DISC_TIMEOUT
   .config:63:warning: symbol value 'n' invalid for FAT_DEFAULT_CODEPAGE
   .config:193:warning: symbol value 'n' invalid for KERNELBASE
   .config:231:warning: symbol value 'n' invalid for SATA_MOBILE_LPM_POLICY
   .config:333:warning: symbol value 'n' invalid for PSTORE_BLK_MAX_REASON
   .config:428:warning: symbol value 'n' invalid for KFENCE_SAMPLE_INTERVAL
   .config:462:warning: symbol value 'n' invalid for AIC79XX_DEBUG_MASK
   .config:605:warning: symbol value 'n' invalid for CRYPTO_DEV_QCE_SW_MAX_LEN
   .config:607:warning: symbol value 'n' invalid for DRM_XE_JOB_TIMEOUT_MIN
   .config:708:warning: symbol value 'n' invalid for PANEL_LCD_CHARSET
   .config:763:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_Y
   .config:785:warning: symbol value 'n' invalid for SND_AC97_POWER_SAVE_DEFAULT
   .config:823:warning: symbol value 'n' invalid for DRM_I915_MAX_REQUEST_BUSYWAIT
   .config:824:warning: symbol value 'n' invalid for AIC79XX_CMDS_PER_DEVICE
   .config:870:warning: symbol value 'n' invalid for PANEL_LCD_PIN_SDA
   .config:884:warning: symbol value 'n' invalid for DRM_XE_PREEMPT_TIMEOUT_MIN
   .config:895:warning: symbol value 'n' invalid for NET_EMATCH_STACK
   .config:897:warning: symbol value 'n' invalid for VMCP_CMA_SIZE
   .config:1053:warning: symbol value 'n' invalid for USB_GADGET_STORAGE_NUM_BUFFERS
   .config:1118:warning: symbol value 'n' invalid for RCU_CPU_STALL_TIMEOUT
   .config:1143:warning: symbol value 'n' invalid for MTDRAM_ERASE_SIZE
   .config:1218:warning: symbol value 'n' invalid for SERIAL_UARTLITE_NR_UARTS
   .config:1378:warning: symbol value 'n' invalid for LEGACY_PTY_COUNT
   .config:1461:warning: symbol value 'n' invalid for PANEL_LCD_PIN_E
   .config:1505:warning: symbol value 'n' invalid for AIC7XXX_RESET_DELAY_MS
   .config:1706:warning: symbol value 'n' invalid for IBM_EMAC_POLL_WEIGHT
   .config:1783:warning: symbol value 'n' invalid for DRM_I915_STOP_TIMEOUT
   .config:1882:warning: symbol value 'n' invalid for PANEL_PROFILE
   .config:1953:warning: symbol value 'n' invalid for ROMVEC
   .config:2001:warning: symbol value 'n' invalid for KCOV_IRQ_AREA_SIZE
   .config:2016:warning: symbol value 'n' invalid for SCSI_MESH_RESET_DELAY_MS
   .config:2112:warning: symbol value 'n' invalid for RCU_FANOUT_LEAF
   .config:2204:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MAX
   .config:2254:warning: symbol value 'n' invalid for PANEL_LCD_BWIDTH
   .config:2487:warning: symbol value 'n' invalid for PANEL_PARPORT
   .config:2536:warning: symbol value 'n' invalid for SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST_NUM
   .config:2573:warning: symbol value 'n' invalid for NOUVEAU_DEBUG_DEFAULT
   .config:2591:warning: symbol value 'n' invalid for AIC79XX_RESET_DELAY_MS
   .config:2759:warning: symbol value 'n' invalid for KCSAN_REPORT_ONCE_IN_MS
   .config:2854:warning: symbol value 'n' invalid for KCSAN_UDELAY_INTERRUPT
   .config:2878:warning: symbol value 'n' invalid for PANEL_LCD_PIN_BL
   .config:2896:warning: symbol value 'n' invalid for DEBUG_OBJECTS_ENABLE_DEFAULT
   .config:2902:warning: symbol value 'n' invalid for INITRAMFS_ROOT_GID
   .config:2933:warning: symbol value 'n' invalid for PSTORE_BLK_CONSOLE_SIZE
   .config:3007:warning: symbol value 'n' invalid for ATM_FORE200E_TX_RETRY
   .config:3013:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_BAUDRATE
   .config:3049:warning: symbol value 'n' invalid for FB_OMAP2_DSS_MIN_FCK_PER_PCK
   .config:3098:warning: symbol value 'n' invalid for BOOKE_WDT_DEFAULT_TIMEOUT
   .config:3142:warning: symbol value 'n' invalid for DUMMY_CONSOLE_ROWS
   .config:3167:warning: symbol value 'n' invalid for MTD_REDBOOT_DIRECTORY_BLOCK
   .config:3236:warning: symbol value 'n' invalid for KCSAN_UDELAY_TASK
   .config:3371:warning: symbol value 'n' invalid for MMC_BLOCK_MINORS
   .config:3374:warning: symbol value 'n' invalid for INET_TABLE_PERTURB_ORDER
   .config:3415:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_SYNC
   .config:3532:warning: symbol value 'n' invalid for UCLAMP_BUCKETS_COUNT
   .config:3558:warning: symbol value 'n' invalid for SERIAL_MCF_BAUDRATE
   .config:3634:warning: symbol value 'n' invalid for DE2104X_DSL
   .config:3647:warning: symbol value 'n' invalid for BLK_DEV_RAM_COUNT
   .config:3685:warning: symbol value 'n' invalid for STACK_MAX_DEFAULT_SIZE_MB
   .config:3797:warning: symbol value 'n' invalid for RAMSIZE
   .config:3874:warning: symbol value 'n' invalid for IP_VS_SH_TAB_BITS
   .config:3993:warning: symbol value 'n' invalid for USBIP_VHCI_HC_PORTS
   .config:4101:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_X
   .config:4174:warning: symbol value 'n' invalid for FTRACE_RECORD_RECURSION_SIZE
   .config:4216:warning: symbol value 'n' invalid for RIONET_RX_SIZE
   .config:4313:warning: symbol value 'n' invalid for RADIO_TYPHOON_PORT
   .config:4428:warning: symbol value 'n' invalid for SERIAL_TXX9_NR_UARTS
   .config:4512:warning: symbol value 'n' invalid for IBM_EMAC_TXB
   .config:4886:warning: symbol value 'n' invalid for ARCH_MMAP_RND_BITS
   .config:4922:warning: symbol value 'n' invalid for IP_VS_MH_TAB_INDEX
   .config:4964:warning: symbol value 'n' invalid for DRM_I915_FENCE_TIMEOUT
   .config:4986:warning: symbol value 'n' invalid for TTY_PRINTK_LEVEL
   .config:5135:warning: symbol value 'n' invalid for MIPS_EJTAG_FDC_KGDB_CHAN
   .config:5226:warning: symbol value 'n' invalid for KDB_DEFAULT_ENABLE
   .config:5245:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_MAXPORTS
   .config:5282:warning: symbol value 'n' invalid for PPC_EARLY_DEBUG_EHV_BC_HANDLE
   .config:5388:warning: symbol value 'n' invalid for PANEL_LCD_PIN_RW
   .config:5435:warning: symbol value 'n' invalid for CRYPTO_DEV_FSL_CAAM_INTC_TIME_THLD
   .config:5501:warning: symbol value 'n' invalid for PANEL_LCD_HWIDTH
   .config:5515:warning: symbol value 'n' invalid for MBAR
   .config:5538:warning: symbol value 'n' invalid for LOCKDEP_CHAINS_BITS
   .config:5621:warning: symbol value 'n' invalid for DRM_I915_HEARTBEAT_INTERVAL
   .config:5627:warning: symbol value 'n' invalid for KCSAN_SKIP_WATCH
   .config:5649:warning: symbol value 'n' invalid for PSTORE_BLK_KMSG_SIZE
   .config:5846:warning: symbol value 'n' invalid for SERIAL_8250_RUNTIME_UARTS
   .config:5870:warning: symbol value 'n' invalid for VECTORBASE
   .config:5922:warning: symbol value 'n' invalid for IPSBAR
   .config:5939:warning: symbol value 'n' invalid for ARCH_MMAP_RND_COMPAT_BITS
   .config:6041:warning: symbol value 'n' invalid for RCU_BOOST_DELAY
   .config:6061:warning: symbol value 'n' invalid for SERIAL_SH_SCI_NR_UARTS
   .config:6097:warning: symbol value 'n' invalid for RADIO_TRUST_PORT
   .config:6448:warning: symbol value 'n' invalid for CMA_SIZE_PERCENTAGE
   .config:6486:warning: symbol value 'n' invalid for DRM_XE_PREEMPT_TIMEOUT_MAX
   .config:6593:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MIN
   .config:6631:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_MAX_TAGS
   .config:6633:warning: symbol value 'n' invalid for DVB_MAX_ADAPTERS
   .config:6647:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
   .config:6945:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_MAX_TAGS
   .config:6995:warning: symbol value 'n' invalid for IBM_EMAC_RXB
   .config:7029:warning: symbol value 'n' invalid for MTD_UBI_WL_THRESHOLD

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

