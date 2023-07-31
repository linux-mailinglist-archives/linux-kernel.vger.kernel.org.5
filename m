Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EBE769D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjGaQwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGaQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:52:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8712AA6;
        Mon, 31 Jul 2023 09:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1939F61230;
        Mon, 31 Jul 2023 16:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D0C433C8;
        Mon, 31 Jul 2023 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690822321;
        bh=CGzW4Z4n87oXkmDgD3NYNy1uk7m9r4O9fbpQ0K4fcrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JwP2f6UiI/vu1DP9is9j8UII+ounDJXNS96unDEUTuoypnss/KVF645UcDhKT1oX+
         MxD72lxig3/MfG2acIqu6QYXzcHTRD5Gu2QeJ6BWlTu+W14gikM9dg20Pvkl4iGC+G
         Wb3fiR6p4u6l0Lw05mRLbxTf3rRvNlY/kN5F1TO9wnosooHIRdQdF2wn+c9Fk0QW8T
         sEteJiW0DkcJXo8tJiRf+5rIuQbj1/OEKValoXbf/8RXyTqb50vvXO7t4kezgIE4mw
         /TrUY9WAxRAxGCdWYmP88TLvkiq7acc2xKsWUdoHC2bewk8jBZdMPE/Ua1P2QOVY4t
         L2Af9fI3xDQMw==
Date:   Mon, 31 Jul 2023 09:51:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Message-ID: <20230731095159.3b7e3b75@kernel.org>
In-Reply-To: <8790da4f-1378-410c-f637-f85ca4d34604@ti.com>
References: <20230727112827.3977534-1-danishanwar@ti.com>
        <20230727112827.3977534-7-danishanwar@ti.com>
        <20230728172419.702b4ac0@kernel.org>
        <8790da4f-1378-410c-f637-f85ca4d34604@ti.com>
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

On Mon, 31 Jul 2023 16:49:59 +0530 Md Danish Anwar wrote:
> There are five error handling cases in xmit().
> 
> 1. DMA Mapping the linear buffer -- If we fail to map dma, we will return
> NETDEV_TX_OK and goto drop_free_skb which will free the skb and drop the packet.
> 
> 2. Allocating descriptor for linear buffer -- If we fail to allocate descriptor
> this means it is a occupancy issue and we will goto drop_stop_q_busy which will
> stop queue and return NETDEV_TX_BUSY.
> 
> 3. Allocating descriptor when skb is fragmented. -- If we fail to allocate
> descriptor when skb is fragmented, we will goto drop_stop_q which will stop the
> queue, free the descriptor, free the skb, drop the packet and return NETDEV_TX_OK.

This one should be BUSY, right? goto free_desc_stop_q_busy

> 4. DMA mapping for fragment. -- If DMA mapping for fragment fails, we will go
> to drop_free_descs which will free the descriptor, free the skb, drop the
> packet and return NETDEV_TX_OK.
> 
> 5. Tx push failed. -- If tx push fails we will goto drop_free_descs which will
> free the descriptor, free the skb, drop the packet and return.
> 
> We will only stop queue in case 2 and 3 where we failed to allocate descriptor.
> In case 1, 4 and 5 we are encountering dma mapping error, so for these cases we
> will not stop the queue.
> 
> Below will be my goto labels.
> 
> drop_stop_q:
> 	netif_tx_stop_queue(netif_txq);
> 
> drop_free_descs:
> 	prueth_xmit_free(tx_chn, first_desc);
> 
> drop_free_skb:
> 	dev_kfree_skb_any(skb);
> 
> 	/* error */
> 	ndev->stats.tx_dropped++;
> 	netdev_err(ndev, "tx: error: %d\n", ret);
> 
> 	return ret;

free_desc_stop_q_busy:
 	prueth_xmit_free(tx_chn, first_desc);
> drop_stop_q_busy:
> 	netif_tx_stop_queue(netif_txq);
> 	return NETDEV_TX_BUSY;
