Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589DD80F6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377106AbjLLTcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjLLTcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:32:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52C9B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:32:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9E4C433C8;
        Tue, 12 Dec 2023 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702409534;
        bh=TY0fTx0ctTq290WnoWAWUZDkJDQeQKPE92XPLQbudrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZNxbmsS/+h1vg1YDha+zs73ry/J6JwD9wUqhXowYooyJXnc44pEUjmKhLQx1Mccdg
         kp/fOLDBP/VN2SkWVyFbkoQIfdPhk1LY6Ssd1gF99lkSc/nNyP/BS859V6zdU3/dDM
         cPvs3qwtLTYvWOAp/csw9reTXvq578vQePaIA5WReWVOmdqAYUA8eRNSqT7Yxb/6nN
         g9zWOYXZByVNKBeAtw+LzrjWitaL/efLkvAa3XQ6amXDrpFyuoe8wFwd8RieVCN1Ye
         1fL40FWifvmwR0psB1eBxwUflDm/kuU629zzOnmDVMJ6Nf9ETF2YdCAZ5PgYZBNMPK
         NB08Xl1EqSiRw==
Date:   Tue, 12 Dec 2023 11:32:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20231212113212.1cfb9e19@kernel.org>
In-Reply-To: <20231208094733.1671296-7-justinlai0215@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-7-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 17:47:26 +0800 Justin Lai wrote:
> +static int tx_handler(struct rtase_ring *ring, int budget)

I don't see how this is called, the way you split the submission makes
it a bit hard to review, oh well. Anyway - if you pass the NAPI budget
here - that's not right, it may be 0, and you'd loop forever.
For Tx - you should try to reap some fixed number of packets, say 128,
the budget is for Rx, not for Tx.

> +	const struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	int workdone = 0;
> +	u32 dirty_tx;
> +	u32 tx_left;
> +
> +	dirty_tx = ring->dirty_idx;
> +	tx_left = READ_ONCE(ring->cur_idx) - dirty_tx;
> +
> +	while (tx_left > 0) {
> +		u32 entry = dirty_tx % NUM_DESC;
> +		struct tx_desc *desc = ring->desc +
> +				       sizeof(struct tx_desc) * entry;
> +		u32 len = ring->mis.len[entry];
> +		u32 status;
> +
> +		status = le32_to_cpu(desc->opts1);
> +
> +		if (status & DESC_OWN)
> +			break;
> +
> +		rtase_unmap_tx_skb(tp->pdev, len, desc);
> +		ring->mis.len[entry] = 0;
> +		if (ring->skbuff[entry]) {
> +			dev_consume_skb_any(ring->skbuff[entry]);

napi_consume_skb, assuming you call this from NAPI

> +			ring->skbuff[entry] = NULL;
> +		}
> +
> +		dev->stats.tx_bytes += len;
> +		dev->stats.tx_packets++;
> +		dirty_tx++;
> +		tx_left--;
> +		workdone++;
> +
> +		if (workdone == budget)
> +			break;
> +	}
> +
> +	if (ring->dirty_idx != dirty_tx) {
> +		WRITE_ONCE(ring->dirty_idx, dirty_tx);
> +
> +		if (__netif_subqueue_stopped(dev, ring->index) &&
> +		    rtase_tx_avail(ring))
> +			netif_start_subqueue(dev, ring->index);

Please use the start / stop macros from include/net/netdev_queues.h
I'm pretty sure the current code is racy.

> +		if (ring->cur_idx != dirty_tx)
> +			rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> +	}
> +
> +	return workdone;
> +}

> +	/* multiqueues */
> +	q_idx = skb_get_queue_mapping(skb);
> +	ring = &tp->tx_ring[q_idx];

As Paolo pointed out elsewhere you seem to only support one queue.
Remove this indirection, please, and always use queue 0, otherwise
it's a bit confusing.
