Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A3D760352
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGXXwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGXXwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B261712
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5C2261462
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87873C433C7;
        Mon, 24 Jul 2023 23:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690242719;
        bh=OMraFAIU6GX2b7xer6c5z+lNJyNLTIbcVU50mdmeTFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qhKrfI3Or14X3j2O9LZ7JNuqCMKQX9vzAsQOp6XbX6FSExFA6FBlLzKRqyZcjzeeU
         ZsY/pFTrPjdBJoMHxWsKwAyhaf9jX49ClhvDOeMJzr6RVcJ4dFQ6oCjA1ipDN1pXrD
         FxDEeGByaHk45a05vNFCklfBYjFpA+jmiasHrmnkDIZkoORbvYCi6N9pJTZN96Knms
         AvaverxxPIocxTGCQxsC6sDCdoZTFF3yM2wNqvnWL8mAEubkOeQ3hLH60pex8j2kz/
         cTKGZY+WY86bpzDjrdgP3Cnx1yH9KxoO1cJU1x7e1mZVsNYJd3/yot3R3frcD8DYyN
         V61kfRc4FFi2A==
Date:   Mon, 24 Jul 2023 16:51:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V2 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230724165157.7094468a@kernel.org>
In-Reply-To: <20230721062153.2769871-1-wei.fang@nxp.com>
References: <20230721062153.2769871-1-wei.fang@nxp.com>
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

On Fri, 21 Jul 2023 14:21:53 +0800 Wei Fang wrote:
> +			/* Tx processing cannot call any XDP (or page pool) APIs if
> +			 * the "budget" is 0. Because NAPI is called with budget of
> +			 * 0 (such as netpoll) indicates we may be in an IRQ context,
> +			 * however, we can't use the page pool from IRQ context.
> +			 */
> +			if (unlikely(!budget))
> +				break;
> +
>  			xdpf = txq->tx_buf[index].xdp;
> -			if (bdp->cbd_bufaddr)
> +			if (bdp->cbd_bufaddr &&
> +			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
>  				dma_unmap_single(&fep->pdev->dev,
>  						 fec32_to_cpu(bdp->cbd_bufaddr),
>  						 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1474,7 +1486,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
>  			/* Free the sk buffer associated with this last transmit */
>  			dev_kfree_skb_any(skb);
>  		} else {
> -			xdp_return_frame(xdpf);
> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
> +				xdp_return_frame(xdpf);
> +			else
> +				xdp_return_frame_rx_napi(xdpf);

I think that you need to also break if (!budget) here,
xdp_return_frame() may call page pool APIs to return the frame 
to a page pool owned by another driver. And that needs to be fixed
in net/main already?
-- 
pw-bot: cr
