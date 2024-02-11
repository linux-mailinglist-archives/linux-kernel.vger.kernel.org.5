Return-Path: <linux-kernel+bounces-60802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C68509A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7063A1C20D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BF85A102;
	Sun, 11 Feb 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVnQC1Dr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ACD2E842
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707662523; cv=none; b=JFYFbxqgcMrn4/Gb+D6RQw18bohBYCZ5htqX2y6rxKD1rujV3+KZHl+1M2EpoidlPBL0GLAbSqDerysIHwQN65bMsVNlL6dAlb7Ni5xuZEXYppLf6RpY3AO291xgepgEhm/gCOV8CDdATmYdHHyWsHTJbKIBp4/SAQQYt4hZ05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707662523; c=relaxed/simple;
	bh=qz/wr7U8OpfCyQuL/j6prxWgMX+97A8stc56eEcOhGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nRo0CovuloitW5f4AXzu9gvX4P7vOgjkGuI0eFvqQAanNgQ0xNVG9F6wPlBz1K7huPd/huHWefzQ5s9uyBdnlSUurC1EX5tSlzGiGGCUKLk3jaUqpEJDoh4eO3IUqBaveJSA5yX74qltciDgcGVYhWNvoQsUbnm+/g/S4cnjHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVnQC1Dr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707662520; x=1739198520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qz/wr7U8OpfCyQuL/j6prxWgMX+97A8stc56eEcOhGM=;
  b=fVnQC1Dr169hBX05mqZgwWjWCZSjQOKxfmZkEEJoLON3gK2Qo3uT6XnN
   uP7sTosN1uCKGVmoBbVw6JjqyZ23Ng2zgmtm2s+nClGtMPDaGwTULNMmt
   VGST1sdMfkKmZegqy6BWdL+qj5wt6LF+ffm/5zmB2FFa0w2KQFFH+w5+P
   OC5kYQQnKf9k3cp2ecYK3epo5NkRr+b5pjaI+PFtqtryeX75Yugczu+9T
   cq3X1FCBU1u4vEZ3C145T5ODERJ/Hpb47nL/o+3xoXx2+l463bFc0gAnV
   5rFKVUO7c74n4YNc+gf87RtE2h2BaYg/NDBE5kaIAmnxNG09G9koRjslr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1512169"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="1512169"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 06:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="2344927"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Feb 2024 06:41:58 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZB1o-0006bW-2J;
	Sun, 11 Feb 2024 14:41:56 +0000
Date: Sun, 11 Feb 2024 22:41:52 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: drivers/scsi/esp_scsi.c:(.text.scsi_esp_register+0x2ac): undefined
 reference to `scsi_add_host_with_dma'
Message-ID: <202402112222.Gl0udKyU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7521f258ea303c827434c101884b62a2b137a942
commit: 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
date:   1 year, 9 months ago
config: mips-randconfig-r005-20220616 (https://download.01.org/0day-ci/archive/20240211/202402112222.Gl0udKyU-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402112222.Gl0udKyU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402112222.Gl0udKyU-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_setsync':
   drivers/scsi/esp_scsi.c:(.text.esp_setsync+0x198): undefined reference to `spi_display_xfer_agreement'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_msgin_extended':
   drivers/scsi/esp_scsi.c:(.text.esp_msgin_extended+0x120): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_msgin_extended+0x2f4): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `scsi_esp_register':
>> drivers/scsi/esp_scsi.c:(.text.scsi_esp_register+0x2ac): undefined reference to `scsi_add_host_with_dma'
>> mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.scsi_esp_register+0x2d0): undefined reference to `scsi_scan_host'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `scsi_esp_unregister':
>> drivers/scsi/esp_scsi.c:(.text.scsi_esp_unregister+0x2c): undefined reference to `scsi_remove_host'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `dev_to_shost':
   drivers/scsi/esp_scsi.c:(.text.dev_to_shost+0x18): undefined reference to `scsi_is_host_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_slave_configure':
   drivers/scsi/esp_scsi.c:(.text.esp_slave_configure+0x4c): undefined reference to `scsi_change_queue_depth'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_slave_configure+0x90): undefined reference to `spi_dv_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_init':
   drivers/scsi/esp_scsi.c:(.init.text+0x24): undefined reference to `spi_attach_transport'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_data_bytes_sent':
   drivers/scsi/esp_scsi.c:(.text.esp_data_bytes_sent+0x284): undefined reference to `scsi_kmap_atomic_sg'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_data_bytes_sent+0x2a8): undefined reference to `scsi_kunmap_atomic_sg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_unmap_dma.isra.0':
   drivers/scsi/esp_scsi.c:(.text.esp_unmap_dma.isra.0+0x3c): undefined reference to `scsi_dma_unmap'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_reset_cleanup':
   drivers/scsi/esp_scsi.c:(.text.esp_reset_cleanup+0xe8): undefined reference to `__starget_for_each_device'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_reset_cleanup+0x158): undefined reference to `scsi_done'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_reset_cleanup+0x1ec): undefined reference to `scsi_done'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_eh_abort_handler':
   drivers/scsi/esp_scsi.c:(.text.esp_eh_abort_handler+0x190): undefined reference to `scsi_done'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_reconnect':
   drivers/scsi/esp_scsi.c:(.text.esp_reconnect+0xe4): undefined reference to `__scsi_device_lookup_by_target'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_msgin_process':
   drivers/scsi/esp_scsi.c:(.text.esp_msgin_process+0x290): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_maybe_execute_command.part.0':
   drivers/scsi/esp_scsi.c:(.text.esp_maybe_execute_command.part.0+0xd4): undefined reference to `spi_populate_tag_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_maybe_execute_command.part.0+0x638): undefined reference to `scsi_dma_map'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_maybe_execute_command.part.0+0x6c4): undefined reference to `spi_populate_width_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.c:(.text.esp_maybe_execute_command.part.0+0x728): undefined reference to `spi_populate_sync_msg'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_cmd_is_done':
   drivers/scsi/esp_scsi.c:(.text.esp_cmd_is_done+0x178): undefined reference to `scsi_done'
   mips64-linux-ld: drivers/scsi/esp_scsi.o: in function `esp_process_event':
   drivers/scsi/esp_scsi.c:(.text.esp_process_event+0x884): undefined reference to `scsi_track_queue_full'
   mips64-linux-ld: drivers/scsi/jazz_esp.o: in function `esp_jazz_probe':
   drivers/scsi/jazz_esp.c:(.text.esp_jazz_probe+0x34): undefined reference to `scsi_host_alloc'
   mips64-linux-ld: drivers/scsi/jazz_esp.c:(.text.esp_jazz_probe+0x94): undefined reference to `scsi_host_put'
   mips64-linux-ld: drivers/scsi/jazz_esp.o: in function `esp_jazz_remove':
   drivers/scsi/jazz_esp.c:(.text.esp_jazz_remove+0x5c): undefined reference to `scsi_host_put'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

