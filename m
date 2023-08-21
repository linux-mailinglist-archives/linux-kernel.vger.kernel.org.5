Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588B178365F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHUXfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHUXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:35:12 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C28CF8;
        Mon, 21 Aug 2023 16:34:34 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qYEOV-0004Xb-34;
        Mon, 21 Aug 2023 23:33:13 +0000
Date:   Tue, 22 Aug 2023 00:32:58 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 4/4] net: ethernet: mtk_eth_soc: support
 36-bit DMA addressing on MT7988
Message-ID: <ZOP0KrmKTzHPfD22@makrotopia.org>
References: <cover.1692660046.git.daniel@makrotopia.org>
 <e4121c507e065c5bca59ddae8909664374b5e396.1692660046.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4121c507e065c5bca59ddae8909664374b5e396.1692660046.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 12:30:34AM +0100, Daniel Golle wrote:
> Systems having 4 GiB of RAM and more require DMA addressing beyond the
> current 32-bit limit. Starting from MT7988 the hardware now supports
> 36-bit DMA addressing, let's use that new capability in the driver to
> avoid running into swiotlb on systems with 4 GiB of RAM or more.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 34 ++++++++++++++++++---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.h | 22 +++++++++++--
>  2 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index ec6a251a0f026..c40e69ac2eeaa 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1136,7 +1136,7 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
>  	int i;
>  
>  	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM))
> -		eth->scratch_ring = eth->sram_base;
> +		eth->scratch_ring = (void __force *)eth->sram_base;

Ooops that was supposed to go into the previous commit obviously.
I will submit v3 after some time with that fixed.

>  	else
>  		eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
>  						       cnt * soc->txrx.txd_size,
> @@ -1328,6 +1328,10 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
>  	data = TX_DMA_PLEN0(info->size);
>  	if (info->last)
>  		data |= TX_DMA_LS0;
> +
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA))
> +		data |= TX_DMA_PREP_ADDR64(info->addr);
> +
>  	WRITE_ONCE(desc->txd3, data);
>  
>  	 /* set forward port */
> @@ -1997,6 +2001,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  	bool xdp_flush = false;
>  	int idx;
>  	struct sk_buff *skb;
> +	u64 addr64 = 0;
>  	u8 *data, *new_data;
>  	struct mtk_rx_dma_v2 *rxd, trxd;
>  	int done = 0, bytes = 0;
> @@ -2112,7 +2117,10 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				goto release_desc;
>  			}
>  
> -			dma_unmap_single(eth->dma_dev, trxd.rxd1,
> +			if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA))
> +				addr64 = RX_DMA_GET_ADDR64(trxd.rxd2);
> +
> +			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
>  					 ring->buf_size, DMA_FROM_DEVICE);
>  
>  			skb = build_skb(data, ring->frag_size);
> @@ -2178,6 +2186,9 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  		else
>  			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size);
>  
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA))
> +			rxd->rxd2 |= RX_DMA_PREP_ADDR64(dma_addr);
> +
>  		ring->calc_idx = idx;
>  		done++;
>  	}
> @@ -2450,7 +2461,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
>  		goto no_tx_mem;
>  
>  	if (MTK_HAS_CAPS(soc->caps, MTK_SRAM)) {
> -		ring->dma = eth->sram_base + ring_size * sz;
> +		ring->dma = (void __force *)eth->sram_base + ring_size * sz;
>  		ring->phys = eth->phy_scratch_ring + ring_size * (dma_addr_t)sz;
>  	} else {
>  		ring->dma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
> @@ -2670,6 +2681,9 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  		else
>  			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size);
>  
> +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA))
> +			rxd->rxd2 |= RX_DMA_PREP_ADDR64(dma_addr);
> +
>  		rxd->rxd3 = 0;
>  		rxd->rxd4 = 0;
>  		if (mtk_is_netsys_v2_or_greater(eth)) {
> @@ -2716,6 +2730,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
>  
>  static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_sram)
>  {
> +	u64 addr64 = 0;
>  	int i;
>  
>  	if (ring->data && ring->dma) {
> @@ -2729,7 +2744,10 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
>  			if (!rxd->rxd1)
>  				continue;
>  
> -			dma_unmap_single(eth->dma_dev, rxd->rxd1,
> +			if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA))
> +				addr64 = RX_DMA_GET_ADDR64(rxd->rxd2);
> +
> +			dma_unmap_single(eth->dma_dev, ((u64)rxd->rxd1 | addr64),
>  					 ring->buf_size, DMA_FROM_DEVICE);
>  			mtk_rx_put_buff(ring, ring->data[i], false);
>  		}
> @@ -4734,6 +4752,14 @@ static int mtk_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
> +		if (err) {
> +			dev_err(&pdev->dev, "Wrong DMA config\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>  	spin_lock_init(&eth->page_lock);
>  	spin_lock_init(&eth->tx_irq_lock);
>  	spin_lock_init(&eth->rx_irq_lock);
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 7c180aedcc0cd..186767bcf6837 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -331,6 +331,14 @@
>  #define TX_DMA_PLEN1(x)		((x) & eth->soc->txrx.dma_max_len)
>  #define TX_DMA_SWC		BIT(14)
>  #define TX_DMA_PQID		GENMASK(3, 0)
> +#define TX_DMA_ADDR64_MASK	GENMASK(3, 0)
> +#if IS_ENABLED(CONFIG_64BIT)
> +# define TX_DMA_GET_ADDR64(x)	(((u64)FIELD_GET(TX_DMA_ADDR64_MASK, (x))) << 32)
> +# define TX_DMA_PREP_ADDR64(x)	FIELD_PREP(TX_DMA_ADDR64_MASK, ((x) >> 32))
> +#else
> +# define TX_DMA_GET_ADDR64(x)	(0)
> +# define TX_DMA_PREP_ADDR64(x)	(0)
> +#endif
>  
>  /* PDMA on MT7628 */
>  #define TX_DMA_DONE		BIT(31)
> @@ -343,6 +351,14 @@
>  #define RX_DMA_PREP_PLEN0(x)	(((x) & eth->soc->txrx.dma_max_len) << eth->soc->txrx.dma_len_offset)
>  #define RX_DMA_GET_PLEN0(x)	(((x) >> eth->soc->txrx.dma_len_offset) & eth->soc->txrx.dma_max_len)
>  #define RX_DMA_VTAG		BIT(15)
> +#define RX_DMA_ADDR64_MASK	GENMASK(3, 0)
> +#if IS_ENABLED(CONFIG_64BIT)
> +# define RX_DMA_GET_ADDR64(x)	(((u64)FIELD_GET(RX_DMA_ADDR64_MASK, (x))) << 32)
> +# define RX_DMA_PREP_ADDR64(x)	FIELD_PREP(RX_DMA_ADDR64_MASK, ((x) >> 32))
> +#else
> +# define RX_DMA_GET_ADDR64(x)	(0)
> +# define RX_DMA_PREP_ADDR64(x)	(0)
> +#endif
>  
>  /* QDMA descriptor rxd3 */
>  #define RX_DMA_VID(x)		((x) & VLAN_VID_MASK)
> @@ -942,6 +958,7 @@ enum mkt_eth_capabilities {
>  	MTK_RSTCTRL_PPE2_BIT,
>  	MTK_U3_COPHY_V2_BIT,
>  	MTK_SRAM_BIT,
> +	MTK_36BIT_DMA_BIT,
>  
>  	/* MUX BITS*/
>  	MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT,
> @@ -978,6 +995,7 @@ enum mkt_eth_capabilities {
>  #define MTK_RSTCTRL_PPE2	BIT_ULL(MTK_RSTCTRL_PPE2_BIT)
>  #define MTK_U3_COPHY_V2		BIT_ULL(MTK_U3_COPHY_V2_BIT)
>  #define MTK_SRAM		BIT_ULL(MTK_SRAM_BIT)
> +#define MTK_36BIT_DMA	BIT_ULL(MTK_36BIT_DMA_BIT)
>  
>  #define MTK_ETH_MUX_GDM1_TO_GMAC1_ESW		\
>  	BIT_ULL(MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT)
> @@ -1059,8 +1077,8 @@ enum mkt_eth_capabilities {
>  		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
>  		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
>  
> -#define MT7988_CAPS  (MTK_GDM1_ESW | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
> -		      MTK_RSTCTRL_PPE2 | MTK_SRAM)
> +#define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_QDMA | \
> +		      MTK_RSTCTRL_PPE1 | MTK_RSTCTRL_PPE2 | MTK_SRAM)
>  
>  struct mtk_tx_dma_desc_info {
>  	dma_addr_t	addr;
> -- 
> 2.41.0
> 
