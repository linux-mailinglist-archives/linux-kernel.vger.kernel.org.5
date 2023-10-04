Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEC7B8E57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjJDUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJDUxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:53:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609289B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:53:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409C1C433C8;
        Wed,  4 Oct 2023 20:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696452798;
        bh=SoHIhhbfpAcP8a5d3STruOfrx3p2ZDfFO2aTb7XYjXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hfk00tkNAPp49k1bEyCIZIs4Dhg12Fl6W2IrA0xMGgC5GPoJ5hUVeFcWa8Ihz8f3Z
         0k30Uq8Mw75v6yNrORxKW+lVq3Zsuenn/tZPnE+NYbkUG9JK4g/5EIGwcCXbigc9CI
         zO0NMjVU+tnst/3bLiZLSyxvOU+as6U53w4d4n4c05julqEWtO6eMyYbOhE/VacFH3
         yqyEHohoHpsX09LEI0gjqLFfimmcnZcnsrCLoT8P5kNVre9fHpEE2z8BLJ1i+0oZKd
         e4KVT2cPqm8opVhmpE3ByVyedHOut4vZDuRycMEPp8+Y6Pw8bsoyVfu+/rVV3tO+eJ
         MSL2cE8ZZS8Ew==
Date:   Wed, 4 Oct 2023 13:53:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: Re: [PATCH net-next v7 3/3] net: axienet: Introduce dmaengine
 support
Message-ID: <20231004135317.2b460acf@kernel.org>
In-Reply-To: <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1695843151-1919509-4-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 01:02:31 +0530 Radhey Shyam Pandey wrote:
> +static int axienet_rx_submit_desc(struct net_device *ndev);

can the forward declaration be avoided?

> +/**
> + * axienet_dma_tx_cb - DMA engine callback for TX channel.
> + * @data:       Pointer to the axienet_local structure.
> + * @result:     error reporting through dmaengine_result.
> + * This function is called by dmaengine driver for TX channel to notify
> + * that the transmit is done.
> + */
> +static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
> +{
> +	struct axienet_local *lp = data;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +
> +	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
> +	u64_stats_update_begin(&lp->tx_stat_sync);
> +	u64_stats_add(&lp->tx_bytes, skbuf_dma->skb->len);
> +	u64_stats_add(&lp->tx_packets, 1);
> +	u64_stats_update_end(&lp->tx_stat_sync);
> +	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
> +	dev_kfree_skb_any(skbuf_dma->skb);

dev_consume_skb_any(), kfree is for drops

> +/**
> + * axienet_start_xmit_dmaengine - Starts the transmission.
> + * @skb:        sk_buff pointer that contains data to be Txed.
> + * @ndev:       Pointer to net_device structure.
> + *
> + * Return: NETDEV_TX_OK on success or any non space errors.
> + *         NETDEV_TX_BUSY when free element in TX skb ring buffer
> + *         is not available.
> + *
> + * This function is invoked from xmit to initiate transmission. The
> + * function sets the skbs, register dma call back API and submit
> + * the dma transaction.
> + * Additionally if checksum offloading is supported,
> + * it populates AXI Stream Control fields with appropriate values.
> + */
> +static netdev_tx_t
> +axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct dma_async_tx_descriptor *dma_tx_desc = NULL;
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	u32 app_metadata[DMA_NUM_APP_WORDS] = {0};
> +	u32 csum_start_off;
> +	u32 csum_index_off;
> +	int sg_len;
> +	int ret;
> +
> +	sg_len = skb_shinfo(skb)->nr_frags + 1;
> +	if (!CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX)) {
> +		netif_stop_queue(ndev);
> +		if (net_ratelimit())
> +			netdev_warn(ndev, "TX ring unexpectedly full\n");

I don't see you stopping the queue when the ring gets full,
am I not looking into the right place? Otherwise this is
sort of expected to occasionally hapen

> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_head);
> +	if (!skbuf_dma)
> +		return NETDEV_TX_OK;

Leaks the skb?

> +	lp->tx_ring_head++;
> +	sg_init_table(skbuf_dma->sgl, sg_len);
> +	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> +	if (ret < 0)
> +		return NETDEV_TX_OK;
> +
> +	ret = dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +	if (!ret)
> +		return NETDEV_TX_OK;
> +
> +	/* Fill up app fields for checksum */
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
> +			/* Tx Full Checksum Offload Enabled */
> +			app_metadata[0] |= 2;
> +		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
> +			csum_start_off = skb_transport_offset(skb);
> +			csum_index_off = csum_start_off + skb->csum_offset;
> +			/* Tx Partial Checksum Offload Enabled */
> +			app_metadata[0] |= 1;
> +			app_metadata[1] = (csum_start_off << 16) | csum_index_off;
> +		}
> +	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
> +		app_metadata[0] |= 2; /* Tx Full Checksum Offload Enabled */
> +	}
> +
> +	dma_tx_desc = lp->tx_chan->device->device_prep_slave_sg(lp->tx_chan, skbuf_dma->sgl,

Possibly store the device_prep_slave_sg pointer to a temporary variable
to make this line less painfully long?

> +	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_head);
> +	if (!skbuf_dma)
> +		return -ENOMEM;
> +	lp->rx_ring_head++;
> +	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	sg_init_table(skbuf_dma->sgl, 1);
> +	addr = dma_map_single(lp->dev, skb->data, lp->max_frm_size, DMA_FROM_DEVICE);
> +	if (unlikely(dma_mapping_error(lp->dev, addr))) {
> +		netdev_err(ndev, "DMA mapping error\n");

needs rate limiting

> +		ret = -ENOMEM;
> +		goto rx_submit_err_free_skb;

is it legal to unmap dma error ?

> +	}
> +	sg_dma_address(skbuf_dma->sgl) = addr;
> +	sg_dma_len(skbuf_dma->sgl) = lp->max_frm_size;
> +	dma_rx_desc = dmaengine_prep_slave_sg(lp->rx_chan, skbuf_dma->sgl,
> +					      1, DMA_DEV_TO_MEM,
> +					      DMA_PREP_INTERRUPT);

> +/**
> + * axienet_init_dmaengine - init the dmaengine code.
> + * @ndev:       Pointer to net_device structure
> + *
> + * Return: 0, on success.
> + *          non-zero error value on failure
> + *
> + * This is the dmaengine initialization code.
> + */
> +static int axienet_init_dmaengine(struct net_device *ndev)
> +{
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	int i, ret;
> +
> +	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
> +	if (IS_ERR(lp->tx_chan)) {
> +		ret = PTR_ERR(lp->tx_chan);
> +		return dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");

Why use dev_err_probe()? This is not on the probe path. If ndo_open
fails it fails, it won't get retried later by itself, right?

> @@ -1238,7 +1540,24 @@ static int axienet_open(struct net_device *ndev)
>  
>  	phylink_start(lp->phylink);
>  
> -	if (!lp->use_dmaengine) {
> +	if (lp->use_dmaengine) {
> +		/* Enable interrupts for Axi Ethernet core (if defined) */
> +		if (lp->eth_irq > 0) {
> +			ret = request_irq(lp->eth_irq, axienet_eth_irq, IRQF_SHARED,
> +					  ndev->name, ndev);
> +			if (ret)
> +				goto error_code;
> +		}
> +
> +		ret = axienet_init_dmaengine(ndev);
> +

pointless new line

> +		if (ret < 0) {
> +			if (lp->eth_irq > 0)
> +				free_irq(lp->eth_irq, ndev);

can't this be on the error path?

> +			goto error_code;
> +		}
> +

pointless new line

> +	} else {

-- 
pw-bot: cr
