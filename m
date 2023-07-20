Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33E75A4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGTDp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTDp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:45:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943961FCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E6776126D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A2EC433C8;
        Thu, 20 Jul 2023 03:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689824754;
        bh=z0i62JjuZ7ZlCOWbWdYwj78VlFeYhWN9ot1ReDkacAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ky2dINi/AGQI0jKAECg1n2BYUJ8uk4hUBYBW4SzCHcMKYROrxiFVxazf9OL2VMrNP
         Tgc1Wv94Y+mKhMa8Mwm/EPHSlvJ4ktx4xD99UCujutg8jaK8i0KUR3DbzCJltUsDvz
         WTbJnDmH7pgx4tbBa7profEpRE1O+6PEhwbKLmclwpQAGtsfLsA+mN7PWhzAmlEBPl
         8d+WVRLU7ACijBa5G66YVkol8cYX7H5As5Cl0/FqzsK0zm3QC3SjOx4/sCLG1BZlAF
         7O0m/tFTMYdG3YqwJkBleaOSRAg7/8B/EYGy/sliPQmRa7QPfzr+ox02xnUxybv4J4
         JefDu/63+IWRw==
Date:   Wed, 19 Jul 2023 20:45:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, xiaoning.wang@nxp.com,
        shenwei.wang@nxp.com, netdev@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: fec: add XDP_TX feature support
Message-ID: <20230719204553.46856b29@kernel.org>
In-Reply-To: <20230717103709.2629372-1-wei.fang@nxp.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
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

On Mon, 17 Jul 2023 18:37:09 +0800 Wei Fang wrote:
> -			xdp_return_frame(xdpf);
> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
> +				xdp_return_frame(xdpf);
> +			else
> +				xdp_return_frame_rx_napi(xdpf);

Are you taking budget into account? When NAPI is called with budget 
of 0 we are *not* in napi / softirq context. You can't be processing
any XDP tx under such conditions (it may be a netpoll call from IRQ
context).

> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> +				struct xdp_buff *xdp)
> +{
> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_tx_q *txq;
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +	int queue, ret;
> +
> +	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
> +	txq = fep->tx_queue[queue];
> +	nq = netdev_get_tx_queue(fep->netdev, queue);
> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
> +
> +	__netif_tx_unlock(nq);

If you're reusing the same queues as the stack you need to call
txq_trans_cond_update() at some point, otherwise the stack may
print a splat complaining the queue got stuck.
-- 
pw-bot: cr
