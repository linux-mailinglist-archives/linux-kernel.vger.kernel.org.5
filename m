Return-Path: <linux-kernel+bounces-125938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75CE892E67
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C5C28244A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468121C33;
	Sun, 31 Mar 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZy4sLvw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42B15A5;
	Sun, 31 Mar 2024 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711855579; cv=none; b=UN4Z+4QpcfhpeX/06Hyh7j/feyuOxu6BnzG1srRKT+lkBbPT9JLsvjFgzhxzjaQyMRUqMAL1T9fOwlaRfIHuH+fZxymbNsJOEyUWR3QTrszPsPNUdYwYJM0aZRnoDAsVwu/UtPRkXf0ZrmYHZgHB2AcZuJBE3C6x15jRQWYEzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711855579; c=relaxed/simple;
	bh=mcOlxyFsflrwoL63B7r2X+EHxgx+Zstva2sSGp2qJjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOHmrgc6Tcdopdz9uGbg5/5k7ZOxe/IAgrkLcGE+ep0/wmRZkP9txKgEg8SLVCxoWzDhCJuK57xKqshg2vse2a+U+AIR81+d9lvF8VG7S1Nv/8R/WHoixIHCY5fDctYPlDQ+rL+dxqStc7o7fEAe0qRnPMFqMbCX1RlJ1qRwAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZy4sLvw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711855576; x=1743391576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcOlxyFsflrwoL63B7r2X+EHxgx+Zstva2sSGp2qJjg=;
  b=CZy4sLvw31/6k8LJBmxkgUy2mLG84IWAq95N79WW81obgocTBGYmiXkj
   9YDqlbD05IYcxrv4IMJkMturYvVVEpmizEN91T44GmVz1Yya8yzgrNvka
   Z/lD8kBQmybphu3S2nN/qOFOanGhcfYDDKYJDO6VEoZ7UA44i6R+vsAdw
   ogL+7kcG0xaqGZte4rJ2YWmBNI66CqWED4imBy9opoShJAeg4UmYj3GNw
   0lj7hQ+OVfKHzVxe32EHayPU3z+OxPaoi9Dfps6Zjp8xZBuBP0OZ8+sYf
   7aFLBlHQQacnlxQ5f/ltBZvkjajt3uignEPz9CPbZts3S65PCp2xwTtjH
   A==;
X-CSE-ConnectionGUID: aXUUi6lES8yR9wX5GnDhbw==
X-CSE-MsgGUID: fXPPYzYsQU6UPvIs/Ltrrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="18146966"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="18146966"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 20:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="22050680"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Mar 2024 20:26:13 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqlpi-0000ka-2S;
	Sun, 31 Mar 2024 03:26:10 +0000
Date: Sun, 31 Mar 2024 11:25:52 +0800
From: kernel test robot <lkp@intel.com>
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, broonie@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	pthombar@cadence.com, Witold Sadowski <wsadowski@marvell.com>
Subject: Re: [PATCH 5/5] cadence-xspi: Add xfer capabilities
Message-ID: <202403311133.jOI5kbg4-lkp@intel.com>
References: <20240329194849.25554-6-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329194849.25554-6-wsadowski@marvell.com>

Hi Witold,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Witold-Sadowski/spi-cadence-Add-new-bindings-documentation-for-Cadence-XSPI/20240330-035124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20240329194849.25554-6-wsadowski%40marvell.com
patch subject: [PATCH 5/5] cadence-xspi: Add xfer capabilities
config: x86_64-randconfig-123-20240331 (https://download.01.org/0day-ci/archive/20240331/202403311133.jOI5kbg4-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240331/202403311133.jOI5kbg4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403311133.jOI5kbg4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-cadence-xspi.c: In function 'cdns_xspi_setup':
   drivers/spi/spi-cadence-xspi.c:892:36: error: implicit declaration of function 'spi_master_get_devdata'; did you mean 'spi_mem_get_drvdata'? [-Werror=implicit-function-declaration]
     struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
                                       ^~~~~~~~~~~~~~~~~~~~~~
                                       spi_mem_get_drvdata
   drivers/spi/spi-cadence-xspi.c:892:66: error: 'struct spi_device' has no member named 'master'
     struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
                                                                     ^~
   drivers/spi/spi-cadence-xspi.c: In function 'cdns_xspi_transfer_one_message_b0':
>> drivers/spi/spi-cadence-xspi.c:1029:36: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(master);
                                       ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-cadence-xspi.c:1035:11: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
     int cs = spi->chip_select;
              ^~~
   drivers/spi/spi-cadence-xspi.c: At top level:
   drivers/spi/spi-cadence-xspi.c:1242:0: error: unterminated #ifdef
    #ifdef CONFIG_OF
    
   cc1: some warnings being treated as errors


vim +1029 drivers/spi/spi-cadence-xspi.c

  1025	
  1026	int cdns_xspi_transfer_one_message_b0(struct spi_controller *master,
  1027						   struct spi_message *m)
  1028	{
> 1029		struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(master);
  1030		struct spi_device *spi = m->spi;
  1031		struct spi_transfer *t = NULL;
  1032	
  1033		const int max_len = XFER_QWORD_BYTECOUNT * XFER_QWORD_COUNT;
  1034		int current_cycle_count;
> 1035		int cs = spi->chip_select;
  1036		int cs_change = 0;
  1037	
  1038		/* Enable xfer state machine */
  1039		if (!cdns_xspi->xfer_in_progress) {
  1040			u32 xfer_control = readl(cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
  1041	
  1042			cdns_xspi->current_xfer_qword = 0;
  1043			cdns_xspi->xfer_in_progress = true;
  1044			xfer_control |= (XFER_RECEIVE_ENABLE |
  1045					 XFER_CLK_CAPTURE_POL |
  1046					 XFER_FUNC_START |
  1047					 XFER_SOFT_RESET |
  1048					 FIELD_PREP(XFER_CS_N_HOLD, (1 << cs)));
  1049			xfer_control &= ~(XFER_FUNC_ENABLE | XFER_CLK_DRIVE_POL);
  1050			writel(xfer_control, cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
  1051		}
  1052	
  1053		list_for_each_entry(t, &m->transfers, transfer_list) {
  1054			u8 *txd = (u8 *) t->tx_buf;
  1055			u8 *rxd = (u8 *) t->rx_buf;
  1056			u8 data[10];
  1057			u32 cmd_regs[6];
  1058	
  1059			if (!txd)
  1060				txd = data;
  1061	
  1062			cdns_xspi->in_buffer = txd + 1;
  1063			cdns_xspi->out_buffer = txd + 1;
  1064	
  1065			while (t->len) {
  1066	
  1067				current_cycle_count = t->len > max_len ? max_len : t->len;
  1068	
  1069				if (current_cycle_count < 10) {
  1070					cdns_xspi_prepare_generic(cs, txd, current_cycle_count,
  1071								  false, cmd_regs);
  1072					cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
  1073					if (cdns_xspi_stig_ready(cdns_xspi, true))
  1074						return -EIO;
  1075				} else {
  1076					cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
  1077					cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
  1078					cdns_xspi_prepare_transfer(cs, 1, current_cycle_count - 1,
  1079								   cmd_regs);
  1080					cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
  1081					if (cdns_xspi_sdma_ready(cdns_xspi, true))
  1082						return -EIO;
  1083					cdns_xspi_sdma_handle(cdns_xspi);
  1084					if (cdns_xspi_stig_ready(cdns_xspi, true))
  1085						return -EIO;
  1086	
  1087					cdns_xspi->in_buffer += current_cycle_count;
  1088					cdns_xspi->out_buffer += current_cycle_count;
  1089				}
  1090	
  1091				if (rxd) {
  1092					int j;
  1093	
  1094					for (j = 0; j < current_cycle_count / 8; j++)
  1095						cdns_xspi_read_single_qword(cdns_xspi, &rxd);
  1096					cdns_xspi_finish_read(cdns_xspi, &rxd, current_cycle_count);
  1097				} else {
  1098					cdns_xspi->current_xfer_qword += current_cycle_count /
  1099									 XFER_QWORD_BYTECOUNT;
  1100					if (current_cycle_count % XFER_QWORD_BYTECOUNT)
  1101						cdns_xspi->current_xfer_qword++;
  1102	
  1103					cdns_xspi->current_xfer_qword %= XFER_QWORD_COUNT;
  1104				}
  1105				cs_change = t->cs_change;
  1106				t->len -= current_cycle_count;
  1107			}
  1108		}
  1109	
  1110		if (!cs_change) {
  1111			u32 xfer_control = readl(cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
  1112	
  1113			xfer_control &= ~(XFER_RECEIVE_ENABLE |
  1114					  XFER_SOFT_RESET);
  1115			writel(xfer_control, cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
  1116			cdns_xspi->xfer_in_progress = false;
  1117		}
  1118	
  1119		m->status = 0;
  1120		spi_finalize_current_message(master);
  1121	
  1122		return 0;
  1123	}
  1124	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

