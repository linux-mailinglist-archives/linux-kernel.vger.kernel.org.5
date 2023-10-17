Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD77CC320
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjJQM0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjJQM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:26:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE8DFD;
        Tue, 17 Oct 2023 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697545560; x=1729081560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQ9JzogYoM8lZ2rQwhtTOmw7I8+Aql/bN4b4lbUehJ8=;
  b=BGHmkwZMm3BVtNP6j0Al3YR7Vs5UDaxjoFnDTlb5p2+gSQ06vwf669/k
   9wSClOn9LqMxpzPmRRMFjBXcNUCfVKyq+MoULtrFpH3aqLhozSo4Utzmc
   QNfgppnxjXI3ne1l9KYDkb5dctqbrqHVXeRN8Xr4/isD47fN0AyC38Ogc
   gXGimVhhvr/ecRVP8fBtdK5jTnb45FyVDAwRVArgOoDj/d1/6hf9SzlNO
   BuzWOhzWI7UZFT+wMAYsblfkIhw7a/XjYEfWOlhJV3WQAMTIf8OsEUHHA
   i0c6h/qp99QHTlXBQfhRaCQV6jxQjKNedLXJWzPc2Su1YDGqLga/GqR4P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366029451"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="366029451"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="749669241"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="749669241"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2023 05:25:53 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsj8w-0009aI-32;
        Tue, 17 Oct 2023 12:25:50 +0000
Date:   Tue, 17 Oct 2023 20:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [net-next PATCH v3 3/4] net: stmmac: move TX timer arm after DMA
 enable
Message-ID: <202310172026.wU2jdMzf-lkp@intel.com>
References: <20231014092954.1850-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014092954.1850-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-introduce-napi_is_scheduled-helper/20231017-133614
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231014092954.1850-4-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v3 3/4] net: stmmac: move TX timer arm after DMA enable
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172026.wU2jdMzf-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172026.wU2jdMzf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172026.wU2jdMzf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2550: warning: Function parameter or member 'pending_packets' not described in 'stmmac_tx_clean'


vim +2550 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

3a6c12a0c6c3f8 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Xiaoliang Yang           2021-12-08  2540  
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2541  /**
732fdf0e5253e9 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2014-11-18  2542   * stmmac_tx_clean - to manage the transmission completion
32ceabcad3c8ab drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2013-04-08  2543   * @priv: driver private structure
d0ea5cbdc286de drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jesse Brandeburg         2020-09-25  2544   * @budget: napi budget limiting this functions packet handling
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2545   * @queue: TX queue index
732fdf0e5253e9 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2014-11-18  2546   * Description: it reclaims the transmit resources after transmission completes.
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2547   */
af9cfa9bbb7075 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Christian Marangi        2023-10-14  2548  static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
af9cfa9bbb7075 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Christian Marangi        2023-10-14  2549  			   bool *pending_packets)
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14 @2550  {
8531c80800c10e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Christian Marangi        2022-07-23  2551  	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
8070274b472e2e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-09-18  2552  	struct stmmac_txq_stats *txq_stats = &priv->xstats.txq_stats[queue];
3897957494d979 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Beniamino Galvani        2015-01-21  2553  	unsigned int bytes_compl = 0, pkts_compl = 0;
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2554  	unsigned int entry, xmits = 0, count = 0;
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2555  	u32 tx_packets = 0, tx_errors = 0;
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2556  	unsigned long flags;
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2557  
8fce3331702316 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-09-17  2558  	__netif_tx_lock_bh(netdev_get_tx_queue(priv->dev, queue));
a9097a9666fd7b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2011-10-18  2559  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2560  	tx_q->xsk_frames_done = 0;
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2561  
8d5f4b07174976 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Bernd Edlinger           2017-10-21  2562  	entry = tx_q->dirty_tx;
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2563  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2564  	/* Try to clean all TX complete frame in 1 shot */
8531c80800c10e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Christian Marangi        2022-07-23  2565  	while ((entry != tx_q->cur_tx) && count < priv->dma_conf.dma_tx_size) {
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2566  		struct xdp_frame *xdpf;
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2567  		struct sk_buff *skb;
c24602ef866493 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2013-03-26  2568  		struct dma_desc *p;
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2569  		int status;
c24602ef866493 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2013-03-26  2570  
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2571  		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX ||
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2572  		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_NDO) {
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2573  			xdpf = tx_q->xdpf[entry];
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2574  			skb = NULL;
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2575  		} else if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2576  			xdpf = NULL;
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2577  			skb = tx_q->tx_skbuff[entry];
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2578  		} else {
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2579  			xdpf = NULL;
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2580  			skb = NULL;
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2581  		}
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2582  
c24602ef866493 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2013-03-26  2583  		if (priv->extend_desc)
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2584  			p = (struct dma_desc *)(tx_q->dma_etx + entry);
579a25a854d482 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2020-01-13  2585  		else if (tx_q->tbs & STMMAC_TBS_AVAIL)
579a25a854d482 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2020-01-13  2586  			p = &tx_q->dma_entx[entry].basic;
c24602ef866493 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2013-03-26  2587  		else
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2588  			p = tx_q->dma_tx + entry;
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2589  
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2590  		status = stmmac_tx_status(priv,	&priv->xstats, p, priv->ioaddr);
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2591  		/* Check if the descriptor is owned by the DMA */
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2592  		if (unlikely(status & tx_dma_own))
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2593  			break;
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2594  
8fce3331702316 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-09-17  2595  		count++;
8fce3331702316 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-09-17  2596  
a6b25da5e7ba21 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Niklas Cassel            2018-02-26  2597  		/* Make sure descriptor fields are read after reading
a6b25da5e7ba21 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Niklas Cassel            2018-02-26  2598  		 * the own bit.
a6b25da5e7ba21 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Niklas Cassel            2018-02-26  2599  		 */
a6b25da5e7ba21 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Niklas Cassel            2018-02-26  2600  		dma_rmb();
a6b25da5e7ba21 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Niklas Cassel            2018-02-26  2601  
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2602  		/* Just consider the last segment and ...*/
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2603  		if (likely(!(status & tx_not_ls))) {
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2604  			/* ... verify the status error condition */
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2605  			if (unlikely(status & tx_err)) {
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2606  				tx_errors++;
3a6c12a0c6c3f8 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Xiaoliang Yang           2021-12-08  2607  				if (unlikely(status & tx_err_bump_tc))
3a6c12a0c6c3f8 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Xiaoliang Yang           2021-12-08  2608  					stmmac_bump_dma_threshold(priv, queue);
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2609  			} else {
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2610  				tx_packets++;
c363b6586cd424 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Fabrice Gasnier          2016-02-29  2611  			}
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2612  			if (skb)
ba1ffd74df74a9 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2016-11-14  2613  				stmmac_get_tx_hwtstamp(priv, p, skb);
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2614  		}
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2615  
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2616  		if (likely(tx_q->tx_skbuff_dma[entry].buf &&
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2617  			   tx_q->tx_skbuff_dma[entry].buf_type != STMMAC_TXBUF_T_XDP_TX)) {
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2618  			if (tx_q->tx_skbuff_dma[entry].map_as_page)
362b37be01edc7 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2014-08-27  2619  				dma_unmap_page(priv->device,
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2620  					       tx_q->tx_skbuff_dma[entry].buf,
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2621  					       tx_q->tx_skbuff_dma[entry].len,
362b37be01edc7 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2014-08-27  2622  					       DMA_TO_DEVICE);
362b37be01edc7 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2014-08-27  2623  			else
cf32deec16e4e8 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Rayagond Kokatanur       2013-03-26  2624  				dma_unmap_single(priv->device,
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2625  						 tx_q->tx_skbuff_dma[entry].buf,
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2626  						 tx_q->tx_skbuff_dma[entry].len,
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2627  						 DMA_TO_DEVICE);
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2628  			tx_q->tx_skbuff_dma[entry].buf = 0;
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2629  			tx_q->tx_skbuff_dma[entry].len = 0;
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2630  			tx_q->tx_skbuff_dma[entry].map_as_page = false;
cf32deec16e4e8 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Rayagond Kokatanur       2013-03-26  2631  		}
f748be531d7012 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Alexandre TORGUE         2016-04-01  2632  
2c520b1c9cfa7d drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-04-16  2633  		stmmac_clean_desc3(priv, tx_q, p);
f748be531d7012 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Alexandre TORGUE         2016-04-01  2634  
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2635  		tx_q->tx_skbuff_dma[entry].last_segment = false;
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2636  		tx_q->tx_skbuff_dma[entry].is_jumbo = false;
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2637  
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2638  		if (xdpf &&
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2639  		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_TX) {
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2640  			xdp_return_frame_rx_napi(xdpf);
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2641  			tx_q->xdpf[entry] = NULL;
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2642  		}
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2643  
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2644  		if (xdpf &&
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2645  		    tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XDP_NDO) {
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2646  			xdp_return_frame(xdpf);
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2647  			tx_q->xdpf[entry] = NULL;
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2648  		}
8b278a5b69a229 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2649  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2650  		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XSK_TX)
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2651  			tx_q->xsk_frames_done++;
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2652  
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2653  		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2654  			if (likely(skb)) {
3897957494d979 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Beniamino Galvani        2015-01-21  2655  				pkts_compl++;
3897957494d979 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Beniamino Galvani        2015-01-21  2656  				bytes_compl += skb->len;
7c565c33464798 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Eric W. Biederman        2014-03-15  2657  				dev_consume_skb_any(skb);
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2658  				tx_q->tx_skbuff[entry] = NULL;
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2659  			}
be8b38a722e68f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-01  2660  		}
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2661  
42de047d60bc5d drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-04-16  2662  		stmmac_release_tx_desc(priv, p, priv->mode);
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2663  
8531c80800c10e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Christian Marangi        2022-07-23  2664  		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2665  	}
ce736788e8a92c drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2666  	tx_q->dirty_tx = entry;
3897957494d979 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Beniamino Galvani        2015-01-21  2667  
c22a3f48ef99ea drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2668  	netdev_tx_completed_queue(netdev_get_tx_queue(priv->dev, queue),
c22a3f48ef99ea drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2669  				  pkts_compl, bytes_compl);
c22a3f48ef99ea drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2670  
c22a3f48ef99ea drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2671  	if (unlikely(netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev,
c22a3f48ef99ea drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2672  								queue))) &&
aa042f60e4961d drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Song, Yoong Siang        2020-09-16  2673  	    stmmac_tx_avail(priv, queue) > STMMAC_TX_THRESH(priv)) {
3897957494d979 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Beniamino Galvani        2015-01-21  2674  
b3e51069627e2b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c LABBE Corentin           2016-11-16  2675  		netif_dbg(priv, tx_done, priv->dev,
b3e51069627e2b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c LABBE Corentin           2016-11-16  2676  			  "%s: restart transmit\n", __func__);
c22a3f48ef99ea drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Joao Pinto               2017-04-06  2677  		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2678  	}
d765955d2ae0b8 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2012-06-27  2679  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2680  	if (tx_q->xsk_pool) {
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2681  		bool work_done;
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2682  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2683  		if (tx_q->xsk_frames_done)
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2684  			xsk_tx_completed(tx_q->xsk_pool, tx_q->xsk_frames_done);
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2685  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2686  		if (xsk_uses_need_wakeup(tx_q->xsk_pool))
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2687  			xsk_set_tx_need_wakeup(tx_q->xsk_pool);
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2688  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2689  		/* For XSK TX, we try to send as many as possible.
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2690  		 * If XSK work done (XSK TX desc empty and budget still
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2691  		 * available), return "budget - 1" to reenable TX IRQ.
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2692  		 * Else, return "budget" to make NAPI continue polling.
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2693  		 */
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2694  		work_done = stmmac_xdp_xmit_zc(priv, queue,
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2695  					       STMMAC_XSK_TX_BUDGET_MAX);
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2696  		if (work_done)
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2697  			xmits = budget - 1;
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2698  		else
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2699  			xmits = budget;
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2700  	}
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2701  
be1c7eae8c7dfc drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Vineetha G. Jaya Kumaran 2020-10-28  2702  	if (priv->eee_enabled && !priv->tx_path_in_lpi_mode &&
be1c7eae8c7dfc drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Vineetha G. Jaya Kumaran 2020-10-28  2703  	    priv->eee_sw_timer_en) {
c74ead223deb88 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2022-01-23  2704  		if (stmmac_enable_eee_mode(priv))
388e201d41fa1e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Vineetha G. Jaya Kumaran 2020-10-01  2705  			mod_timer(&priv->eee_ctrl_timer, STMMAC_LPI_T(priv->tx_lpi_timer));
d765955d2ae0b8 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Giuseppe CAVALLARO       2012-06-27  2706  	}
8fce3331702316 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-09-17  2707  
4ccb45857c2c07 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2019-02-19  2708  	/* We still have pending packets, let's call for a new scheduling */
4ccb45857c2c07 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2019-02-19  2709  	if (tx_q->dirty_tx != tx_q->cur_tx)
af9cfa9bbb7075 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Christian Marangi        2023-10-14  2710  		*pending_packets = true;
4ccb45857c2c07 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2019-02-19  2711  
8070274b472e2e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-09-18  2712  	flags = u64_stats_update_begin_irqsave(&txq_stats->syncp);
8070274b472e2e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-09-18  2713  	txq_stats->tx_packets += tx_packets;
8070274b472e2e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-09-18  2714  	txq_stats->tx_pkt_n += tx_packets;
8070274b472e2e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-09-18  2715  	txq_stats->tx_clean++;
8070274b472e2e drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-09-18  2716  	u64_stats_update_end_irqrestore(&txq_stats->syncp, flags);
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2717  
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2718  	priv->xstats.tx_errors += tx_errors;
133466c3bbe171 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jisheng Zhang            2023-07-18  2719  
8fce3331702316 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-09-17  2720  	__netif_tx_unlock_bh(netdev_get_tx_queue(priv->dev, queue));
8fce3331702316 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Jose Abreu               2018-09-17  2721  
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2722  	/* Combine decisions from TX clean and XSK TX */
132c32ee5bc09b drivers/net/ethernet/stmicro/stmmac/stmmac_main.c Ong Boon Leong           2021-04-13  2723  	return max(count, xmits);
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2724  }
47dd7a540b8a0c drivers/net/stmmac/stmmac_main.c                  Giuseppe Cavallaro       2009-10-14  2725  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
