Return-Path: <linux-kernel+bounces-56189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC5684C729
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D581F25A73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F220DFA;
	Wed,  7 Feb 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK8i5+wP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0120DCF;
	Wed,  7 Feb 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297652; cv=none; b=IP51l2Xn+Z1rrLzyXxCbbPfm3be64aw4ae0r4aS2QCoF6NkTyApQb9xOECOZgB+nYQOZXVG5nHvACLDOPnoHjCJZ8OYRWVxguRBNqE/hiNCeNVguuvOexZQ9RIwQN4VMmEKlNW9Dm0xNrKVMhxd7XPARiC+uwCfKjSsnAesffxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297652; c=relaxed/simple;
	bh=6YvQzVV4nusevcHCqpVYqUFJYCCJgg8JwrDhNoV+FTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnOctq25G/YtUctrk3a/5arMP+Sm3svPdwvby4ACslznA5bxH8xup1dpZWjxGVqHGtTAMEhbz0pFzQ4ySHHwqo6hE0giPJ4RJq93iGi+vHCZ1saq8aOfPuATPlMLgowFwDT/OgeOd1BqK6D0BRe1XO3p6YZp55Xu/DTelXDVS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK8i5+wP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707297651; x=1738833651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6YvQzVV4nusevcHCqpVYqUFJYCCJgg8JwrDhNoV+FTM=;
  b=kK8i5+wPmRsUKNu3gKq/P+rKxfHYbk709xj9yW8agh1lFzqLGeOC49Jk
   SzLJiu0eC1bamZRpBqNjtQb3o7LID1pCtoGz04qwP2+W+NY9AdwfE7F1S
   6G3trwOaOkUakGt8kuczB9NqRqRuRnjrTBaapJ5+rlasoosuj48CzWiFl
   LjojzbiVwDLiba9eYc3ovJijqhGJgFJM4Bpv3EL6Vng9SNIsntFj10sQb
   H2Kz8xZqGmBgu8+YfMX4JIFFuDyH0XiwxJHnny9KIDQ38uA0k1VeKMQK0
   ti+O6XZbtQ+HyXZa53qyqMKjGGP/UKTOCtg7PMDkrrTmR9Q2kjC71VoHL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1086070"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1086070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="6050463"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Feb 2024 01:20:47 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXe6m-0002Rg-2D;
	Wed, 07 Feb 2024 09:20:44 +0000
Date: Wed, 7 Feb 2024 17:19:54 +0800
From: kernel test robot <lkp@intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com,
	Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add support for MULTI-mode
Message-ID: <202402071719.e1p4tUge-lkp@intel.com>
References: <20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0@bootlin.com>

Hi Louis,

kernel test robot noticed the following build errors:

[auto build test ERROR on 41bccc98fb7931d63d03f326a746ac4d429c1dd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Louis-Chauvet/Revert-spi-spi-omap2-mcspi-c-Toggle-CS-after-each-word/20240206-180243
base:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
patch link:    https://lore.kernel.org/r/20240126-spi-omap2-mcspi-multi-mode-v1-2-d143d33f0fe0%40bootlin.com
patch subject: [PATCH 2/2] spi: omap2-mcspi: Add support for MULTI-mode
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240207/202402071719.e1p4tUge-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071719.e1p4tUge-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402071719.e1p4tUge-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/spi/spi-omap2-mcspi.c: In function 'omap2_mcspi_prepare_message':
>> drivers/spi/spi-omap2-mcspi.c:1415:30: error: 'master' undeclared (first use in this function)
    1415 |         omap2_mcspi_set_mode(master);
         |                              ^~~~~~
   drivers/spi/spi-omap2-mcspi.c:1415:30: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/spi/spi-omap2-mcspi.c:1388:13: warning: unused variable 'speed_hz' [-Wunused-variable]
    1388 |         u32 speed_hz;
         |             ^~~~~~~~


vim +/master +1415 drivers/spi/spi-omap2-mcspi.c

  1379	
  1380	static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
  1381					       struct spi_message *msg)
  1382	{
  1383		struct omap2_mcspi	*mcspi = spi_controller_get_devdata(ctlr);
  1384		struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
  1385		struct omap2_mcspi_cs	*cs;
  1386		struct spi_transfer	*tr;
  1387		u8 bits_per_word;
> 1388		u32 speed_hz;
  1389	
  1390		/*
  1391		 * The conditions are strict, it is mandatory to check each transfer of the list to see if
  1392		 * multi-mode is applicable.
  1393		 */
  1394		mcspi->use_multi_mode = true;
  1395		list_for_each_entry(tr, &msg->transfers, transfer_list) {
  1396			if (!tr->bits_per_word)
  1397				bits_per_word = msg->spi->bits_per_word;
  1398			else
  1399				bits_per_word = tr->bits_per_word;
  1400	
  1401			/* Check if the transfer content is only one word */
  1402			if ((bits_per_word < 8 && tr->len > 1) ||
  1403			    (bits_per_word >= 8 && tr->len > bits_per_word / 8))
  1404				mcspi->use_multi_mode = false;
  1405	
  1406			/* Check if transfer asks to change the CS status after the transfer */
  1407			if (!tr->cs_change)
  1408				mcspi->use_multi_mode = false;
  1409	
  1410			/* If at least one message is not compatible, switch back to single mode */
  1411			if (!mcspi->use_multi_mode)
  1412				break;
  1413		}
  1414	
> 1415		omap2_mcspi_set_mode(master);
  1416	
  1417		/* In single mode only a single channel can have the FORCE bit enabled
  1418		 * in its chconf0 register.
  1419		 * Scan all channels and disable them except the current one.
  1420		 * A FORCE can remain from a last transfer having cs_change enabled
  1421		 *
  1422		 * In multi mode all FORCE bits must be disabled.
  1423		 */
  1424		list_for_each_entry(cs, &ctx->cs, node) {
  1425			if (msg->spi->controller_state == cs && !mcspi->use_multi_mode) {
  1426				continue;
  1427			}
  1428	
  1429			if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_FORCE)) {
  1430				cs->chconf0 &= ~OMAP2_MCSPI_CHCONF_FORCE;
  1431				writel_relaxed(cs->chconf0,
  1432						cs->base + OMAP2_MCSPI_CHCONF0);
  1433				readl_relaxed(cs->base + OMAP2_MCSPI_CHCONF0);
  1434			}
  1435		}
  1436	
  1437		return 0;
  1438	}
  1439	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

