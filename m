Return-Path: <linux-kernel+bounces-44423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469608421E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BE1C2488E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299B65BC0;
	Tue, 30 Jan 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmJdtmmQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA5657DD;
	Tue, 30 Jan 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611685; cv=none; b=Fgs9cWSP29Zv+9a/0EFcRwYEk6hV2/IGN6oEhCKkfAidMHtgr09qa4gMBDmA8/bW5/uHe5cPJEkUQGbBMzo8pDG0UNbslA60JEKwm4g4XdwtXiLLMsyfF4YSvXeLCIvTW2nITYzrGXhoZsbYygWtaCJUIEnthOzXn5GU3AhISCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611685; c=relaxed/simple;
	bh=w/MKL51/KMzuU6jcclHA9RjjMgmailHfLNebdTP5/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKi0MlafLyct3/jgdz2v6SR+t2w08BtcxmMvBoRZ0c3vqdz0ZNmVQavRG9iBn/UkRG0sf4OYFxDRaP+uxnQ4e7Ij4NECnswK06v2hl9jADxhpZaSAe7c2Dxp9sJIhXHeO1ZVbBKK8nn9RvicyxgezyYBSrxEi9pbdz7wCutN07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmJdtmmQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706611682; x=1738147682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/MKL51/KMzuU6jcclHA9RjjMgmailHfLNebdTP5/f4=;
  b=JmJdtmmQH/gFK8MmPysSrwKymfhXcZ9mhMZ5kG1a5UoZ9RK77TS8ZZVV
   cGNFRmBscFH8SNWk6kaYfnXBoKgYJ1z7kJYl9VukwsCNwN/lnjEVgx5rH
   aGkryw3WHcmCQGz2LA1RJj1P8sY1UFt8jlVGCaWjtLRH/S0+JtbUPGl5V
   egX38uz73txF0pNl7FjYd4PAMnSFgxPh3Qoh4/+6pXkOy63pqs+uvR8Cy
   Biq2l/8/ML0Il8NdAix9VTmGnpeNavWQ1hXpDSPf+bydsuEnSH4FVBK1H
   OUFUYnQZwLyLsh5OwhYIua8iSirC3jcNJszH7Jmg9x3O0LiGYpf6XnBHp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3077976"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3077976"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:48:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="36460719"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 30 Jan 2024 02:47:58 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUleg-0000Cw-02;
	Tue, 30 Jan 2024 10:47:51 +0000
Date: Tue, 30 Jan 2024 18:46:16 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
	Michal Simek <monstr@monstr.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 17/33] spi: bitbang: Follow renaming of SPI "master"
 to "controller"
Message-ID: <202401301813.fehkuS9c-lkp@intel.com>
References: <b2035a8030b77e8a3eea87adf7e4a191c0a18717.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2035a8030b77e8a3eea87adf7e4a191c0a18717.1705944943.git.u.kleine-koenig@pengutronix.de>

Hi Uwe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6613476e225e090cc9aad49be7fa504e290dd33d]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/fpga-ice40-spi-Follow-renaming-of-SPI-master-to-controller/20240123-031635
base:   6613476e225e090cc9aad49be7fa504e290dd33d
patch link:    https://lore.kernel.org/r/b2035a8030b77e8a3eea87adf7e4a191c0a18717.1705944943.git.u.kleine-koenig%40pengutronix.de
patch subject: [PATCH v2 17/33] spi: bitbang: Follow renaming of SPI "master" to "controller"
config: mips-db1xxx_defconfig (https://download.01.org/0day-ci/archive/20240130/202401301813.fehkuS9c-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401301813.fehkuS9c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401301813.fehkuS9c-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-au1550.c: In function 'au1550_spi_probe':
>> drivers/spi/spi-au1550.c:803:20: error: 'struct spi_bitbang' has no member named 'master'
     803 |         hw->bitbang.master = hw->host;
         |                    ^


vim +803 drivers/spi/spi-au1550.c

63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  721  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  722  
2deff8d602e8c9 drivers/spi/spi-au1550.c Grant Likely    2013-02-05  723  static int au1550_spi_probe(struct platform_device *pdev)
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  724  {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  725  	struct au1550_spi *hw;
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  726  	struct spi_controller *host;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  727  	struct resource *r;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  728  	int err = 0;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  729  
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  730  	host = spi_alloc_host(&pdev->dev, sizeof(struct au1550_spi));
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  731  	if (host == NULL) {
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  732  		dev_err(&pdev->dev, "No memory for spi_controller\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  733  		err = -ENOMEM;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  734  		goto err_nomem;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  735  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  736  
e7db06b5d5afce drivers/spi/au1550_spi.c David Brownell  2009-06-17  737  	/* the spi->mode bits understood by this driver: */
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  738  	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  739  	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 24);
e7db06b5d5afce drivers/spi/au1550_spi.c David Brownell  2009-06-17  740  
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  741  	hw = spi_controller_get_devdata(host);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  742  
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  743  	hw->host = host;
8074cf063e410a drivers/spi/spi-au1550.c Jingoo Han      2013-07-30  744  	hw->pdata = dev_get_platdata(&pdev->dev);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  745  	hw->dev = &pdev->dev;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  746  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  747  	if (hw->pdata == NULL) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  748  		dev_err(&pdev->dev, "No platform data supplied\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  749  		err = -ENOENT;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  750  		goto err_no_pdata;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  751  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  752  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  753  	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  754  	if (!r) {
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  755  		dev_err(&pdev->dev, "no IRQ\n");
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  756  		err = -ENODEV;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  757  		goto err_no_iores;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  758  	}
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  759  	hw->irq = r->start;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  760  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  761  	hw->usedma = 0;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  762  	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  763  	if (r) {
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  764  		hw->dma_tx_id = r->start;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  765  		r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  766  		if (r) {
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  767  			hw->dma_rx_id = r->start;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  768  			if (usedma && ddma_memid) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  769  				if (pdev->dev.dma_mask == NULL)
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  770  					dev_warn(&pdev->dev, "no dma mask\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  771  				else
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  772  					hw->usedma = 1;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  773  			}
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  774  		}
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  775  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  776  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  777  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  778  	if (!r) {
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  779  		dev_err(&pdev->dev, "no mmio resource\n");
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  780  		err = -ENODEV;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  781  		goto err_no_iores;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  782  	}
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  783  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  784  	hw->ioarea = request_mem_region(r->start, sizeof(psc_spi_t),
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  785  					pdev->name);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  786  	if (!hw->ioarea) {
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  787  		dev_err(&pdev->dev, "Cannot reserve iomem region\n");
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  788  		err = -ENXIO;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  789  		goto err_no_iores;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  790  	}
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  791  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  792  	hw->regs = (psc_spi_t __iomem *)ioremap(r->start, sizeof(psc_spi_t));
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  793  	if (!hw->regs) {
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  794  		dev_err(&pdev->dev, "cannot ioremap\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  795  		err = -ENXIO;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  796  		goto err_ioremap;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  797  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  798  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  799  	platform_set_drvdata(pdev, hw);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  800  
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  801  	init_completion(&hw->host_done);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  802  
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07 @803  	hw->bitbang.master = hw->host;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  804  	hw->bitbang.setup_transfer = au1550_spi_setupxfer;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  805  	hw->bitbang.chipselect = au1550_spi_chipsel;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  806  	hw->bitbang.txrx_bufs = au1550_spi_txrx_bufs;
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  807  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  808  	if (hw->usedma) {
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  809  		hw->dma_tx_ch = au1xxx_dbdma_chan_alloc(ddma_memid,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  810  			hw->dma_tx_id, NULL, (void *)hw);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  811  		if (hw->dma_tx_ch == 0) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  812  			dev_err(&pdev->dev,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  813  				"Cannot allocate tx dma channel\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  814  			err = -ENXIO;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  815  			goto err_no_txdma;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  816  		}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  817  		au1xxx_dbdma_set_devwidth(hw->dma_tx_ch, 8);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  818  		if (au1xxx_dbdma_ring_alloc(hw->dma_tx_ch,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  819  			AU1550_SPI_DBDMA_DESCRIPTORS) == 0) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  820  			dev_err(&pdev->dev,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  821  				"Cannot allocate tx dma descriptors\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  822  			err = -ENXIO;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  823  			goto err_no_txdma_descr;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  824  		}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  825  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  826  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  827  		hw->dma_rx_ch = au1xxx_dbdma_chan_alloc(hw->dma_rx_id,
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  828  			ddma_memid, NULL, (void *)hw);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  829  		if (hw->dma_rx_ch == 0) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  830  			dev_err(&pdev->dev,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  831  				"Cannot allocate rx dma channel\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  832  			err = -ENXIO;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  833  			goto err_no_rxdma;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  834  		}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  835  		au1xxx_dbdma_set_devwidth(hw->dma_rx_ch, 8);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  836  		if (au1xxx_dbdma_ring_alloc(hw->dma_rx_ch,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  837  			AU1550_SPI_DBDMA_DESCRIPTORS) == 0) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  838  			dev_err(&pdev->dev,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  839  				"Cannot allocate rx dma descriptors\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  840  			err = -ENXIO;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  841  			goto err_no_rxdma_descr;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  842  		}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  843  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  844  		err = au1550_spi_dma_rxtmp_alloc(hw,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  845  			AU1550_SPI_DMA_RXTMP_MINSIZE);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  846  		if (err < 0) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  847  			dev_err(&pdev->dev,
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  848  				"Cannot allocate initial rx dma tmp buffer\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  849  			goto err_dma_rxtmp_alloc;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  850  		}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  851  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  852  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  853  	au1550_spi_bits_handlers_set(hw, 8);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  854  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  855  	err = request_irq(hw->irq, au1550_spi_irq, 0, pdev->name, hw);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  856  	if (err) {
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  857  		dev_err(&pdev->dev, "Cannot claim IRQ\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  858  		goto err_no_irq;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  859  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  860  
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  861  	host->bus_num = pdev->id;
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  862  	host->num_chipselect = hw->pdata->num_chipselect;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  863  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  864  	/*
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  865  	 *  precompute valid range for spi freq - from au1550 datasheet:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  866  	 *    psc_tempclk = psc_mainclk / (2 << DIV)
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  867  	 *    spiclk = psc_tempclk / (2 * (BRG + 1))
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  868  	 *    BRG valid range is 4..63
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  869  	 *    DIV valid range is 0..3
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  870  	 *  round the min and max frequencies to values that would still
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  871  	 *  produce valid brg and div
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  872  	 */
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  873  	{
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  874  		int min_div = (2 << 0) * (2 * (4 + 1));
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  875  		int max_div = (2 << 3) * (2 * (63 + 1));
9cae7e9d78e27d drivers/spi/spi-au1550.c corentin        2021-01-22  876  
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  877  		host->max_speed_hz = hw->pdata->mainclk_hz / min_div;
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  878  		host->min_speed_hz =
0dd26e53b56137 drivers/spi/spi-au1550.c Axel Lin        2014-02-11  879  				hw->pdata->mainclk_hz / (max_div + 1) + 1;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  880  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  881  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  882  	au1550_spi_setup_psc_as_spi(hw);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  883  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  884  	err = spi_bitbang_start(&hw->bitbang);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  885  	if (err) {
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  886  		dev_err(&pdev->dev, "Failed to register SPI host\n");
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  887  		goto err_register;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  888  	}
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  889  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  890  	dev_info(&pdev->dev,
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  891  		"spi host registered: bus_num=%d num_chipselect=%d\n",
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  892  		host->bus_num, host->num_chipselect);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  893  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  894  	return 0;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  895  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  896  err_register:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  897  	free_irq(hw->irq, hw);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  898  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  899  err_no_irq:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  900  	au1550_spi_dma_rxtmp_free(hw);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  901  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  902  err_dma_rxtmp_alloc:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  903  err_no_rxdma_descr:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  904  	if (hw->usedma)
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  905  		au1xxx_dbdma_chan_free(hw->dma_rx_ch);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  906  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  907  err_no_rxdma:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  908  err_no_txdma_descr:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  909  	if (hw->usedma)
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  910  		au1xxx_dbdma_chan_free(hw->dma_tx_ch);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  911  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  912  err_no_txdma:
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  913  	iounmap((void __iomem *)hw->regs);
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  914  
3a93a159c61e38 drivers/spi/au1550_spi.c Manuel Lauss    2008-07-23  915  err_ioremap:
30670539b867d0 drivers/spi/spi-au1550.c Himangi Saraogi 2014-07-04  916  	release_mem_region(r->start, sizeof(psc_spi_t));
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  917  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  918  err_no_iores:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  919  err_no_pdata:
0c35cc597b211e drivers/spi/spi-au1550.c Yang Yingliang  2023-08-07  920  	spi_controller_put(hw->host);
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  921  
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  922  err_nomem:
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  923  	return err;
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  924  }
63bd23591e6c38 drivers/spi/au1550_spi.c Jan Nikitenko   2007-05-08  925  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

