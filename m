Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4B7E0FF6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKDOqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKDOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:46:21 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E531BF;
        Sat,  4 Nov 2023 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Vglbr5OscBwmzXeDr7ryPvhrzWRRWsVXpMVy/3stZxs=; b=K2szq9Vaf0baMpHPaet72S7gAX
        NY7TsMRGmHSDRdpMRbHdpzKIEMm4nvW4upJD6DHOvaCpqxKDD25G6CkzSIfaSE6E/MjpM8+6jv91S
        WSW9qQpbvErgsQ9dBQ5vCNXnnRsLVQm0nsXJsXVtc/COKRYLrabAJ03zKJ4bqwE8pZ6g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qzHub-000sOR-PD; Sat, 04 Nov 2023 15:46:09 +0100
Date:   Sat, 4 Nov 2023 15:46:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] net: ethernet: cortina: Protect against
 oversized frames
Message-ID: <39debb25-bf30-4ede-99b1-d9f6091a039c@lunn.ch>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-3-9c5513f22f33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-gemini-largeframe-fix-v1-3-9c5513f22f33@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 01:43:50PM +0100, Linus Walleij wrote:
> The max size of a transfer no matter the MTU is 64KB-1 so immediately
> bail out if the skb exceeds that.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index fd08f098850b..23723c9c0f93 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1156,6 +1156,12 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  		mtu = MTU_SIZE_BIT_MASK;
>  	}
>  
> +	if (skb->len > 65535) {
> +		/* The field for length is only 16 bits */
> +		netdev_err(netdev, "%s: frame too big, max size 65535 bytes\n", __func__);
> +		return -EINVAL;
> +	}
> +

The caller of gmac_map_tx_bufs() is a but funky:

	if (gmac_map_tx_bufs(netdev, skb, txq, &w)) {
		if (skb_linearize(skb))
			goto out_drop;

		u64_stats_update_begin(&port->tx_stats_syncp);
		port->tx_frags_linearized++;
		u64_stats_update_end(&port->tx_stats_syncp);

		if (gmac_map_tx_bufs(netdev, skb, txq, &w))
			goto out_drop_free;
	}

So return -EINVAL is going to cause the skb to be linearised, and then
re-tried. Maybe you want to check the error code here, and go straight
to out_drop?

   Andrew
