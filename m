Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2B762A35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGZERo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjGZERP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C17855AB;
        Tue, 25 Jul 2023 21:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A6BB611BF;
        Wed, 26 Jul 2023 04:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD6BC433C8;
        Wed, 26 Jul 2023 04:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690344581;
        bh=ku1nE39/TTrl/Uk7uhUIacdlmfCDkaxNE1UEjYekZco=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cl+tt96BUc+4oGpCAUspkgwUXGcWQm+hGLkPXiAiOsfTtS0+PC7Ud9PZRw61XFN+D
         GMijLReeVQfeloe6NBB/+zZwnr48Lbnw93ky0jOb8QZXMLnn6+DwV0KrmFe3FyQdLB
         d2oo+rZlkkJ+VQbsKbyMPiol/qZUrZyVhn6LWph1ZeLzx1Kl5az4CsIY6aIfO93jt3
         LatHN1gFnRd5I0hM3uuAe0okMGec7W8vwCzc2z/7UzLWXVUHPAxoZqM5xmlux00dyr
         yEoeCJUdfW3CZlrgZTUJijb8VycOMcuaNC/AqqHxtFQkuLJ9FWCZZgWS7nc8J1Va9J
         5kRmmN2VYjkmg==
Date:   Tue, 25 Jul 2023 21:09:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v11 06/10] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230725210939.56d77726@kernel.org>
In-Reply-To: <20230724112934.2637802-7-danishanwar@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
        <20230724112934.2637802-7-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 16:59:30 +0530 MD Danish Anwar wrote:
>  drivers/net/ethernet/ti/Kconfig        |   13 +
>  drivers/net/ethernet/ti/Makefile       |    3 +
>  drivers/net/ethernet/ti/icssg_prueth.c | 1831 ++++++++++++++++++++++++
>  drivers/net/ethernet/ti/icssg_prueth.h |   48 +

Please create a sub-directory for the driver.

> +static int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
> +{
> +	struct prueth *prueth = emac->prueth;
> +	int i, ret;
> +
> +	for (i = 0; i < emac->tx_ch_num; i++) {
> +		struct prueth_tx_chn *tx_chn = &emac->tx_chns[i];
> +
> +		netif_napi_add_tx_weight(emac->ndev, &tx_chn->napi_tx,
> +					 emac_napi_tx_poll, NAPI_POLL_WEIGHT);

Skip specifying weight, please.

> +/**
> + * emac_ndo_start_xmit - EMAC Transmit function
> + * @skb: SKB pointer
> + * @ndev: EMAC network adapter
> + *
> + * Called by the system to transmit a packet  - we queue the packet in
> + * EMAC hardware transmit queue
> + * Doesn't wait for completion we'll check for TX completion in
> + * emac_tx_complete_packets().
> + *
> + * Return: enum netdev_tx
> + */
> +static enum netdev_tx emac_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct netdev_queue *netif_txq;
> +	struct prueth_tx_chn *tx_chn;
> +	dma_addr_t desc_dma, buf_dma;
> +	int i, ret = 0, q_idx;
> +	void **swdata;
> +	u32 pkt_len;
> +	u32 *epib;
> +
> +	pkt_len = skb_headlen(skb);
> +	q_idx = skb_get_queue_mapping(skb);
> +
> +	tx_chn = &emac->tx_chns[q_idx];
> +	netif_txq = netdev_get_tx_queue(ndev, q_idx);
> +
> +	/* Map the linear buffer */
> +	buf_dma = dma_map_single(tx_chn->dma_dev, skb->data, pkt_len, DMA_TO_DEVICE);
> +	if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
> +		netdev_err(ndev, "tx: failed to map skb buffer\n");
> +		ret = NETDEV_TX_BUSY;

Drop it if it can't be mapped and return OK. What's going to re-enable
the queue in this case?

> +		goto drop_stop_q;
> +	}
> +
> +	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
> +	if (!first_desc) {
> +		netdev_dbg(ndev, "tx: failed to allocate descriptor\n");
> +		dma_unmap_single(tx_chn->dma_dev, buf_dma, pkt_len, DMA_TO_DEVICE);
> +		ret = NETDEV_TX_BUSY;
> +		goto drop_stop_q_busy;
> +	}
> +
> +	cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
> +			 PRUETH_NAV_PS_DATA_SIZE);
> +	cppi5_hdesc_set_pkttype(first_desc, 0);
> +	epib = first_desc->epib;
> +	epib[0] = 0;
> +	epib[1] = 0;
> +
> +	/* set dst tag to indicate internal qid at the firmware which is at
> +	 * bit8..bit15. bit0..bit7 indicates port num for directed
> +	 * packets in case of switch mode operation
> +	 */
> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
> +	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
> +	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
> +	swdata = cppi5_hdesc_get_swdata(first_desc);
> +	*swdata = skb;
> +
> +	if (!skb_is_nonlinear(skb))
> +		goto tx_push;

Why the goto? The loop won't be entered.

> +	/* Handle the case where skb is fragmented in pages */
> +	cur_desc = first_desc;
> +	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> +		u32 frag_size = skb_frag_size(frag);
> +
> +		next_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
> +		if (!next_desc) {
> +			netdev_err(ndev,
> +				   "tx: failed to allocate frag. descriptor\n");
> +			ret = NETDEV_TX_BUSY;
> +			goto drop_free_descs;
> +		}
> +
> +		buf_dma = skb_frag_dma_map(tx_chn->dma_dev, frag, 0, frag_size,
> +					   DMA_TO_DEVICE);
> +		if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
> +			netdev_err(ndev, "tx: Failed to map skb page\n");
> +			k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
> +			ret = NETDEV_TX_BUSY;
> +			goto drop_free_descs;

this label frees the skb, you can't return BUSY

> +		}
> +
> +		cppi5_hdesc_reset_hbdesc(next_desc);
> +		k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
> +		cppi5_hdesc_attach_buf(next_desc,
> +				       buf_dma, frag_size, buf_dma, frag_size);
> +
> +		desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool,
> +						      next_desc);
> +		k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &desc_dma);
> +		cppi5_hdesc_link_hbdesc(cur_desc, desc_dma);
> +
> +		pkt_len += frag_size;
> +		cur_desc = next_desc;
> +	}
> +	WARN_ON(pkt_len != skb->len);

WARN_ON_ONCE() if at all

> +
> +tx_push:
> +	/* report bql before sending packet */
> +	netdev_tx_sent_queue(netif_txq, pkt_len);
> +
> +	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
> +	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
> +	/* cppi5_desc_dump(first_desc, 64); */
> +
> +	skb_tx_timestamp(skb);  /* SW timestamp if SKBTX_IN_PROGRESS not set */
> +	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
> +	if (ret) {
> +		netdev_err(ndev, "tx: push failed: %d\n", ret);
> +		goto drop_free_descs;
> +	}
> +
> +	if (k3_cppi_desc_pool_avail(tx_chn->desc_pool) < MAX_SKB_FRAGS) {
> +		netif_tx_stop_queue(netif_txq);
> +		/* Barrier, so that stop_queue visible to other cpus */
> +		smp_mb__after_atomic();
> +
> +		if (k3_cppi_desc_pool_avail(tx_chn->desc_pool) >=
> +		    MAX_SKB_FRAGS)

MAX_FRAGS + 1?

> +			netif_tx_wake_queue(netif_txq);
> +	}
> +
> +	return NETDEV_TX_OK;


> +static int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
> +{
> +	struct prueth_emac *emac = prueth_napi_to_emac(napi_rx);
> +	int rx_flow = PRUETH_RX_FLOW_DATA;
> +	int flow = PRUETH_MAX_RX_FLOWS;
> +	int num_rx = 0;
> +	int cur_budget;
> +	int ret;
> +
> +	while (flow--) {
> +		cur_budget = budget - num_rx;
> +
> +		while (cur_budget--) {
> +			ret = emac_rx_packet(emac, flow);
> +			if (ret)
> +				break;
> +			num_rx++;
> +		}
> +
> +		if (num_rx >= budget)
> +			break;
> +	}
> +
> +	if (num_rx < budget) {
> +		napi_complete(napi_rx);

Prefer using napi_complete_done()

> +		enable_irq(emac->rx_chns.irq[rx_flow]);
> +	}
> +
> +	return num_rx;
> +}

> +static void emac_ndo_tx_timeout(struct net_device *ndev, unsigned int txqueue)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +
> +	if (netif_msg_tx_err(emac))
> +		netdev_err(ndev, "xmit timeout");

Core already prints something, you can drop this.

> +	ndev->stats.tx_errors++;
> +}

> +static void emac_ndo_set_rx_mode_work(struct work_struct *work)
> +{
> +	struct prueth_emac *emac = container_of(work, struct prueth_emac, rx_mode_work);
> +	struct net_device *ndev = emac->ndev;
> +	bool promisc, allmulti;
> +
> +	if (!netif_running(ndev))
> +		return;
> +
> +	promisc = ndev->flags & IFF_PROMISC;
> +	allmulti = ndev->flags & IFF_ALLMULTI;
> +	emac_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_DISABLE);
> +	emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_DISABLE);
> +
> +	if (promisc) {
> +		emac_set_port_state(emac, ICSSG_EMAC_PORT_UC_FLOODING_ENABLE);
> +		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		return;
> +	}
> +
> +	if (allmulti) {
> +		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		return;
> +	}
> +
> +	if (!netdev_mc_empty(ndev)) {
> +		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
> +		return;
> +	}
> +}

There's no need for locking in this work?

> +	netif_napi_add(ndev, &emac->napi_rx,
> +		       emac_napi_rx_poll);

nit: fits on a line

> +static struct platform_driver prueth_driver = {
> +	.probe = prueth_probe,
> +	.remove = prueth_remove,

Please use .remove_new (which has a void return).
-- 
pw-bot: cr
