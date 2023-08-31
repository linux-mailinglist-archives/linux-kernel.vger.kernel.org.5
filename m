Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981E78F5D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbjHaWwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHaWwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:52:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F27CF;
        Thu, 31 Aug 2023 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693522336; x=1725058336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FuQPMXB2hrMkwbwe+y0VdlVr+7bGItkbctGZUbDvjS4=;
  b=QJWhZsmdpXgcsMFGGmsTODGDZqese6kGrxA5xlOUwcDpg+BZFo1DBEan
   siqNhHlSmPzYqLzf03/7DOJaeq0GGaDfmdd8XyxwEjPIHxZu6M5lyUtUH
   Pc+oaC6iEGXPLd1gLJmGjNGSdgsTlLhqvbtPeZZ19k1dTANoYFLb6rWeN
   kZl78mJAXSImvq1x8zlsg49G31VSlgeC56TzhlidFSR+z4/ILpW2DiRIl
   3tVqanM9sMDNOpuMp8/c9s2mI3Hsb89aM4U2Jhq46dz6NNqIgxmgNEcyu
   N3MbaZHL6SYP+UHvw3qMhyTpflPfkC952HI69H/XiOphAL/v5VNckHC+3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355582688"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="355582688"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 15:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854462866"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="854462866"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2023 15:52:11 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbqWH-0000ct-1M;
        Thu, 31 Aug 2023 22:52:09 +0000
Date:   Fri, 1 Sep 2023 06:51:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Brown <broonie@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
Message-ID: <202309010647.GUOYgT4J-lkp@intel.com>
References: <20230831194934.19628-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831194934.19628-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master next-20230831]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/spi-bcm2835-reduce-the-abuse-of-the-GPIO-API/20230901-035139
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230831194934.19628-1-brgl%40bgdev.pl
patch subject: [RFT PATCH] spi: bcm2835: reduce the abuse of the GPIO API
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230901/202309010647.GUOYgT4J-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309010647.GUOYgT4J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309010647.GUOYgT4J-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-bcm2835.c:146: warning: Function parameter or member 'cs_gpio' not described in 'bcm2835_spi'


vim +146 drivers/spi/spi-bcm2835.c

f8043872e79614 Chris Boot          2013-03-11   77  
ff245d90ebed8d Martin Sperl        2019-04-23   78  /* define polling limits */
cbd632ea8ee4ae Jason Yan           2020-09-12   79  static unsigned int polling_limit_us = 30;
ff245d90ebed8d Martin Sperl        2019-04-23   80  module_param(polling_limit_us, uint, 0664);
ff245d90ebed8d Martin Sperl        2019-04-23   81  MODULE_PARM_DESC(polling_limit_us,
ff245d90ebed8d Martin Sperl        2019-04-23   82  		 "time in us to run a transfer in polling mode\n");
ff245d90ebed8d Martin Sperl        2019-04-23   83  
acf0f856959937 Lukas Wunner        2018-11-08   84  /**
acf0f856959937 Lukas Wunner        2018-11-08   85   * struct bcm2835_spi - BCM2835 SPI controller
acf0f856959937 Lukas Wunner        2018-11-08   86   * @regs: base address of register map
acf0f856959937 Lukas Wunner        2018-11-08   87   * @clk: core clock, divided to calculate serial clock
c45c1e82bba130 Alexandru Tachici   2021-07-17   88   * @clk_hz: core clock cached speed
acf0f856959937 Lukas Wunner        2018-11-08   89   * @irq: interrupt, signals TX FIFO empty or RX FIFO ¾ full
3bd7f6589f67f0 Lukas Wunner        2018-11-08   90   * @tfr: SPI transfer currently processed
afe7e36360f4c9 Robin Murphy        2020-06-16   91   * @ctlr: SPI controller reverse lookup
acf0f856959937 Lukas Wunner        2018-11-08   92   * @tx_buf: pointer whence next transmitted byte is read
acf0f856959937 Lukas Wunner        2018-11-08   93   * @rx_buf: pointer where next received byte is written
acf0f856959937 Lukas Wunner        2018-11-08   94   * @tx_len: remaining bytes to transmit
acf0f856959937 Lukas Wunner        2018-11-08   95   * @rx_len: remaining bytes to receive
3bd7f6589f67f0 Lukas Wunner        2018-11-08   96   * @tx_prologue: bytes transmitted without DMA if first TX sglist entry's
3bd7f6589f67f0 Lukas Wunner        2018-11-08   97   *	length is not a multiple of 4 (to overcome hardware limitation)
3bd7f6589f67f0 Lukas Wunner        2018-11-08   98   * @rx_prologue: bytes received without DMA if first RX sglist entry's
3bd7f6589f67f0 Lukas Wunner        2018-11-08   99   *	length is not a multiple of 4 (to overcome hardware limitation)
3bd7f6589f67f0 Lukas Wunner        2018-11-08  100   * @tx_spillover: whether @tx_prologue spills over to second TX sglist entry
154f7da56f1ecb Martin Sperl        2019-04-23  101   * @debugfs_dir: the debugfs directory - neede to remove debugfs when
154f7da56f1ecb Martin Sperl        2019-04-23  102   *      unloading the module
154f7da56f1ecb Martin Sperl        2019-04-23  103   * @count_transfer_polling: count of how often polling mode is used
154f7da56f1ecb Martin Sperl        2019-04-23  104   * @count_transfer_irq: count of how often interrupt mode is used
154f7da56f1ecb Martin Sperl        2019-04-23  105   * @count_transfer_irq_after_polling: count of how often we fall back to
154f7da56f1ecb Martin Sperl        2019-04-23  106   *      interrupt mode after starting in polling mode.
154f7da56f1ecb Martin Sperl        2019-04-23  107   *      These are counted as well in @count_transfer_polling and
154f7da56f1ecb Martin Sperl        2019-04-23  108   *      @count_transfer_irq
154f7da56f1ecb Martin Sperl        2019-04-23  109   * @count_transfer_dma: count how often dma mode is used
00be843bc1c3c7 Yang Yingliang      2023-07-28  110   * @target: SPI target currently selected
8259bf667a0f9e Lukas Wunner        2019-09-11  111   *	(used by bcm2835_spi_dma_tx_done() to write @clear_rx_cs)
8259bf667a0f9e Lukas Wunner        2019-09-11  112   * @tx_dma_active: whether a TX DMA descriptor is in progress
8259bf667a0f9e Lukas Wunner        2019-09-11  113   * @rx_dma_active: whether a RX DMA descriptor is in progress
8259bf667a0f9e Lukas Wunner        2019-09-11  114   *	(used by bcm2835_spi_dma_tx_done() to handle a race)
2b8279aec1829d Lukas Wunner        2019-09-11  115   * @fill_tx_desc: preallocated TX DMA descriptor used for RX-only transfers
2b8279aec1829d Lukas Wunner        2019-09-11  116   *	(cyclically copies from zero page to TX FIFO)
2b8279aec1829d Lukas Wunner        2019-09-11  117   * @fill_tx_addr: bus address of zero page
acf0f856959937 Lukas Wunner        2018-11-08  118   */
f8043872e79614 Chris Boot          2013-03-11  119  struct bcm2835_spi {
f8043872e79614 Chris Boot          2013-03-11  120  	void __iomem *regs;
f8043872e79614 Chris Boot          2013-03-11  121  	struct clk *clk;
1098696c0d4d2d Bartosz Golaszewski 2023-08-31  122  	struct gpio_desc *cs_gpio;
c45c1e82bba130 Alexandru Tachici   2021-07-17  123  	unsigned long clk_hz;
f8043872e79614 Chris Boot          2013-03-11  124  	int irq;
3bd7f6589f67f0 Lukas Wunner        2018-11-08  125  	struct spi_transfer *tfr;
afe7e36360f4c9 Robin Murphy        2020-06-16  126  	struct spi_controller *ctlr;
f8043872e79614 Chris Boot          2013-03-11  127  	const u8 *tx_buf;
f8043872e79614 Chris Boot          2013-03-11  128  	u8 *rx_buf;
e34ff011c70e5f Martin Sperl        2015-03-26  129  	int tx_len;
e34ff011c70e5f Martin Sperl        2015-03-26  130  	int rx_len;
3bd7f6589f67f0 Lukas Wunner        2018-11-08  131  	int tx_prologue;
3bd7f6589f67f0 Lukas Wunner        2018-11-08  132  	int rx_prologue;
b31a9299bca66c Lukas Wunner        2018-11-29  133  	unsigned int tx_spillover;
154f7da56f1ecb Martin Sperl        2019-04-23  134  
154f7da56f1ecb Martin Sperl        2019-04-23  135  	struct dentry *debugfs_dir;
154f7da56f1ecb Martin Sperl        2019-04-23  136  	u64 count_transfer_polling;
154f7da56f1ecb Martin Sperl        2019-04-23  137  	u64 count_transfer_irq;
154f7da56f1ecb Martin Sperl        2019-04-23  138  	u64 count_transfer_irq_after_polling;
154f7da56f1ecb Martin Sperl        2019-04-23  139  	u64 count_transfer_dma;
8259bf667a0f9e Lukas Wunner        2019-09-11  140  
00be843bc1c3c7 Yang Yingliang      2023-07-28  141  	struct bcm2835_spidev *target;
8259bf667a0f9e Lukas Wunner        2019-09-11  142  	unsigned int tx_dma_active;
8259bf667a0f9e Lukas Wunner        2019-09-11  143  	unsigned int rx_dma_active;
2b8279aec1829d Lukas Wunner        2019-09-11  144  	struct dma_async_tx_descriptor *fill_tx_desc;
2b8279aec1829d Lukas Wunner        2019-09-11  145  	dma_addr_t fill_tx_addr;
ec679bda639fe8 Lukas Wunner        2021-05-27 @146  };
ec679bda639fe8 Lukas Wunner        2021-05-27  147  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
