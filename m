Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E17767971
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjG2AYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjG2AYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6762680;
        Fri, 28 Jul 2023 17:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF5262219;
        Sat, 29 Jul 2023 00:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221CAC433C7;
        Sat, 29 Jul 2023 00:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690590260;
        bh=LcvjFZ5wQlT1R6n8uisvWwenXjdvtew/LYTUALvrObc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k8ANMUwVHZyTxyGa3n7sz2LHzbUGdyjNE/J3IJLU9ml/Zqn6ToTj3nqSMmnWv86HE
         ljVs22Qb90Bw9NXXmPFj9pNMI0mq0ESXP12HP1NQUg4oNm0oy2FQE11CB0NBNUd0G+
         OewanG+lTJsH17XqdIOPY6NDhrNj+/bVoLB85cpAdgD1AUB923nedsJMnJtEMBykQS
         vBKZA7MRLDZpu0nFrKX+91j2/g7V7BH+5Zc5MjXXDr7PLLHcemQwj9NdSemoFJUeOf
         bNGaOXZewZpKb7A4Mupld1931Itsmi/3gwfgRyJlZkoHY1y7tmMWkfVBXjBJ/f5kgi
         Bg9wqklNDEBrQ==
Date:   Fri, 28 Jul 2023 17:24:19 -0700
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
Subject: Re: [PATCH v12 06/10] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230728172419.702b4ac0@kernel.org>
In-Reply-To: <20230727112827.3977534-7-danishanwar@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
        <20230727112827.3977534-7-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 16:58:23 +0530 MD Danish Anwar wrote:
> +static int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
> +				    int budget)
> +{
> +	struct net_device *ndev = emac->ndev;
> +	struct cppi5_host_desc_t *desc_tx;
> +	struct netdev_queue *netif_txq;
> +	struct prueth_tx_chn *tx_chn;
> +	unsigned int total_bytes = 0;
> +	struct sk_buff *skb;
> +	dma_addr_t desc_dma;
> +	int res, num_tx = 0;
> +	void **swdata;
> +
> +	tx_chn = &emac->tx_chns[chn];
> +
> +	while (budget) {
> +		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
> +		if (res == -ENODATA)
> +			break;

You shouldn't limit the number of serviced packets to budget for Tx
NAPI.

https://docs.kernel.org/next/networking/napi.html#driver-api

> +	skb->dev = ndev;
> +	if (!netif_running(skb->dev)) {
> +		dev_kfree_skb_any(skb);
> +		return 0;
> +	}

why do you check if the interface is running?
If a packet arrives, it means the interface is running..

> +drop_free_descs:
> +	prueth_xmit_free(tx_chn, first_desc);
> +drop_stop_q:
> +	netif_tx_stop_queue(netif_txq);

Do not stop the queue on DMA errors. If the queue is empty nothing
will wake it up. Queue should only be stopped based on occupancy.

> +	dev_kfree_skb_any(skb);
> +
> +	/* error */
> +	ndev->stats.tx_dropped++;
> +	netdev_err(ndev, "tx: error: %d\n", ret);
> +
> +	return ret;
-- 
pw-bot: cr
