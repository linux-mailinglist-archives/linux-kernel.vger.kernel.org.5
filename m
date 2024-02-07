Return-Path: <linux-kernel+bounces-55825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0084C229
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AF7B240DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F1DDA1;
	Wed,  7 Feb 2024 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZ137Yaq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28559E55F;
	Wed,  7 Feb 2024 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270932; cv=none; b=l+TWf2WwJIuKCUxno73xA3Z9adVU++Zj8QBi/tY9Or7aP1f82dWLAaHUYhV3XkNmfKrY/1lv1uJLBvX2snY+fgF3RmPkXYTC1oofb7Nt8vpvlYVd5d3s2lm/CnIJ3aEGyPonreE3cbuBxDircJu7PrkCk7porOMRjpNBO15fHh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270932; c=relaxed/simple;
	bh=qVCFsLivte1S/ce5qOTm6k+2M84hodTLb/kSDHgC290=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNlwuIFnFWGvAQ478TqWh8G+IU/je+aL3R8Rq+tTzhvYAxPp33w8nPFPriSgQXZDafSXdS+bwc5EVgc7HeOE44zyVR8a6mCcwOwxo7vcvg5SBD2/jAlzaTT0+VF8zkMrP9wEkfK27ZSRpR0m14S1MSc4c4npblcYuP6E+8cbfLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZ137Yaq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707270930; x=1738806930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qVCFsLivte1S/ce5qOTm6k+2M84hodTLb/kSDHgC290=;
  b=UZ137YaqVVT9IfYFZhRDXqsfnIT4Afh+CXtfHNJ1+QTUy2yjB6hI3muy
   x9PuO8EIBTH1oA3Pc+Yphl7xmZzGEsetOTzzSZyG/9QH3vYdQwvpzkU5o
   CN696PtAH0i7xXG4GTk/yUyKVN/sA2HcKJSzpGFLEt209uGbsMWtVTJl0
   OzpPQr5kMnpz70kK1T84IPHd/cW4WocSjcn7dV7doYClsdLUBAgaWzg4T
   ceqRnPJwjebtkHnsJZkTsOlYzlejHW5bFgS0H3T5501uaJBLn00lqu1wE
   +qxKzlwXYv5xxEH/OdMavvh6iOijj93AiGnr3haQ1QPIZjyvmaExECfmU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11624214"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11624214"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909828900"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="909828900"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2024 17:55:26 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXX9o-0001yO-1R;
	Wed, 07 Feb 2024 01:55:24 +0000
Date: Wed, 7 Feb 2024 09:54:35 +0800
From: kernel test robot <lkp@intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com,
	Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH 2/2] spi: omap2-mcspi: Add support for MULTI-mode
Message-ID: <202402070919.C08LpTkR-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20240207 (https://download.01.org/0day-ci/archive/20240207/202402070919.C08LpTkR-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402070919.C08LpTkR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402070919.C08LpTkR-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/spi/spi-omap2-mcspi.c:1415:23: error: use of undeclared identifier 'master'
    1415 |         omap2_mcspi_set_mode(master);
         |                              ^
   1 error generated.


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
  1388		u32 speed_hz;
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

