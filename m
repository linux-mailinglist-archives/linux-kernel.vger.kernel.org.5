Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0DA7D8963
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjJZUDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjJZUDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:03:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C1B9;
        Thu, 26 Oct 2023 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698350625; x=1729886625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uMJoNr1drMyaV4vwEoxpe+493cdkpAVp/nhiLRli/U=;
  b=Mvs/81EnzwYUu/7L8GjmNI0psMMtd8R/AJNoJEjF3XMBK6iACqsOdNos
   0LuqVQTAnbo1NuTLMbc4Hy98+m7htpdbnllWqYMeqoU47J3C1zTw1ydPu
   ER+pFQiR7qZPlFus76TILguxwYZTeyHW6vTATjCd5NIVpBFLWuQ5f/HZN
   Prq8EpujDiXgBOSIVZJLowjif+WWeE2Ig3y6SLLrWZ1zRxFUE/kLwpua/
   0prOhN8etJT7mEuUNcEj6vJQhKUjt8cVVoJ4DtxYf2upiahJH4cJjUmAI
   pjP9yARYi1Kxm1Kcnhx66fcz0/MH31UGcb26MwohAi1gZAOaIwp8gcJbx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="9180850"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="9180850"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 13:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709194246"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="709194246"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Oct 2023 13:03:40 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qw6Zt-000A6N-2p;
        Thu, 26 Oct 2023 20:03:37 +0000
Date:   Fri, 27 Oct 2023 04:03:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eberhard Stoll <estl@gmx.net>, Han Xu <han.xu@nxp.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Eberhard Stoll <eberhard.stoll@kontron.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Michal Simek <monstr@monstr.eu>,
        Rob Herring <robh@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 4/4] spi: spi-fsl-qspi: Add support for rx data sample
 point adjustment
Message-ID: <202310270332.mcbckKCr-lkp@intel.com>
References: <20231026152316.2729575-5-estl@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026152316.2729575-5-estl@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eberhard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1]

url:    https://github.com/intel-lab-lkp/linux/commits/Eberhard-Stoll/spi-Add-parameter-for-clock-to-rx-delay/20231026-232547
base:   05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
patch link:    https://lore.kernel.org/r/20231026152316.2729575-5-estl%40gmx.net
patch subject: [PATCH 4/4] spi: spi-fsl-qspi: Add support for rx data sample point adjustment
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231027/202310270332.mcbckKCr-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310270332.mcbckKCr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310270332.mcbckKCr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-fsl-qspi.c: In function 'fsl_qspi_select_mem':
>> drivers/spi/spi-fsl-qspi.c:558:38: warning: suggest parentheses around comparison in operand of '|' [-Wparentheses]
     558 |         if (chip->rx_sample_delay_ns != spi->rx_sample_delay_ns |
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +558 drivers/spi/spi-fsl-qspi.c

   550	
   551	static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi)
   552	{
   553		unsigned long rate = spi->max_speed_hz;
   554		int ret;
   555		struct fsl_qspi_chip_data *chip = spi_get_ctldata(spi);
   556		const char *sampling_ident = sampling_mode[0];
   557	
 > 558		if (chip->rx_sample_delay_ns != spi->rx_sample_delay_ns |
   559		    chip->rate != rate) {
   560			chip->rx_sample_delay_ns = spi->rx_sample_delay_ns;
   561			chip->rate = rate;
   562	
   563			chip->smpr_sampling =
   564				(2 * spi->rx_sample_delay_ns * (rate >> 10)) / (1000000000 >> 10);
   565			dev_dbg(q->dev, "smpr_sampling = %u (delay %u ns)\n",
   566				chip->smpr_sampling, spi->rx_sample_delay_ns);
   567	
   568			if (chip->smpr_sampling > 3) {
   569				dev_err(q->dev, "rx sample delay for device %s exceeds hw capabilities! Clamp value to maximum setting.\n",
   570					dev_name(&spi->dev));
   571				chip->smpr_sampling = 3;
   572				sampling_ident = "(I2 clamped to max)";
   573			} else {
   574				sampling_ident = sampling_mode[chip->smpr_sampling];
   575			}
   576	
   577			chip->smpr_sampling <<= 5;
   578			dev_info(q->dev, "sampling point %s at %lu kHz used for device %s\n",
   579				 sampling_ident, rate / 1000, dev_name(&spi->dev));
   580			fsl_qspi_update_smpr_sampling(q, chip->smpr_sampling);
   581		}
   582	
   583		if (q->selected == spi_get_chipselect(spi, 0))
   584			return;
   585	
   586		fsl_qspi_update_smpr_sampling(q, chip->smpr_sampling);
   587	
   588		if (needs_4x_clock(q))
   589			rate *= 4;
   590	
   591		fsl_qspi_clk_disable_unprep(q);
   592	
   593		ret = clk_set_rate(q->clk, rate);
   594		if (ret)
   595			return;
   596	
   597		ret = fsl_qspi_clk_prep_enable(q);
   598		if (ret)
   599			return;
   600	
   601		q->selected = spi_get_chipselect(spi, 0);
   602	
   603		fsl_qspi_invalidate(q);
   604	}
   605	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
