Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BCF7E21E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjKFMk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFMk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:40:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1014AD;
        Mon,  6 Nov 2023 04:40:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso7342264a12.1;
        Mon, 06 Nov 2023 04:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699274422; x=1699879222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/j5ZdORQp2c8s4IMJhl7QIq4MbRa4fgg20gEx4WXX8=;
        b=AMMoHTJvo9+1QinCV+oigPoHv4LKZ2GUiik+1o9UwWxfg/S8KNVeHgfi/bqpSaRtJ+
         8xbIG71fLlRhColRkza1PsIOfwNMDQoiGBlplJH6Wd+TlrGQyhtKCOqtZfMVLVUoNRad
         +01xsdf700eturdjs4rHbbw8bS2IdNLzxXzBHJnhBJe8zWyVz9x32QkFfmZegDe6gkxc
         Or8Clxvpxw7A1FKkblzdZuNM5/pPO3t5NBsdtJ2E33iI594xEqImGrePm6wtP0QyILpt
         6ymsWJwMAlYSUWVuovh/GW6htvxAj45CRAv9/pWdHayXgSscYK7FGWLfFpOZ6PxShoSF
         oq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699274422; x=1699879222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/j5ZdORQp2c8s4IMJhl7QIq4MbRa4fgg20gEx4WXX8=;
        b=TPYG7HDnwOBC6e6mpCoOgOzY2sLHWrUNYxSg/DSgN94RRsE+q1VSVzTLAOR9jut6h2
         FhyOg6MH/HinaGJgnkKtTQnds9YSGvbIwnsu4lRL6fY8zYTBXM2yuTkEz/ztLmY/9EOR
         pmBdopaJjbPUm0p2Xfq4iw8aAiwGqXHGVhs80yIYn0xQS6rx8NpkILCcxkryMSM/Jp4v
         ozUqM9w+5SkElaykkEPAobPye1WlmCfWxF+P21JlLof6vtAvOHQ501oQZ8JUTxieFcAV
         +0QreSu0B0DwyUgXNmGZaopPvdFY8QHCKXhBbxr0TMjc2fdirGSNTkM8d496AVoLUs8h
         LDgg==
X-Gm-Message-State: AOJu0YwjAJqk1bzFZ0FY8Q40U+Fm6wmD/Rp05zNLmbwzj9LNNvpMploj
        Otz6tY1KaRho/noI1tMbezk=
X-Google-Smtp-Source: AGHT+IGAz6Uu6354N+6w/E0T+0S1OgMe1mnBTFZ5yII6j2prs0Cc+X6f/ro/zCVVkp3kzBMo/wnpag==
X-Received: by 2002:a17:906:7313:b0:9be:7de2:927c with SMTP id di19-20020a170906731300b009be7de2927cmr13174418ejc.70.1699274421947;
        Mon, 06 Nov 2023 04:40:21 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id fi3-20020a170906da0300b0099ce188be7fsm4060117ejb.3.2023.11.06.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 04:40:21 -0800 (PST)
Date:   Mon, 6 Nov 2023 14:40:19 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] net: ethernet: cortina: Protect against
 oversized frames
Message-ID: <20231106124019.ethagifngefgcihm@skbuf>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
 <20231105-gemini-largeframe-fix-v2-3-cd3a5aa6c496@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105-gemini-largeframe-fix-v2-3-cd3a5aa6c496@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 09:57:25PM +0100, Linus Walleij wrote:
> The max size of a transfer no matter the MTU is 64KB-1 so immediately
> bail out if the skb exceeds that.
> 
> The calling site tries to linearize the skbuff on error so return a
> special error code -E2BIG to indicate that this will not work in
> any way and bail out immediately if this happens.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index b21a94b4ab5c..576174a862a9 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1151,6 +1151,12 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  	if (skb->protocol == htons(ETH_P_8021Q))
>  		mtu += VLAN_HLEN;
>  
> +	if (skb->len > 65535) {
> +		/* The field for length is only 16 bits */
> +		netdev_err(netdev, "%s: frame too big, max size 65535 bytes\n", __func__);
> +		return -E2BIG;
> +	}
> +

Prints in the packet data path are extremely discouraged, since if they
trigger, they will spam your serial console and make it unusable.

I see that the out_drop label already bumps a counter. That should be
enough to signal there is a problem.

>  	word1 = skb->len;
>  	word3 = SOF_BIT;
>  
> @@ -1232,6 +1238,7 @@ static netdev_tx_t gmac_start_xmit(struct sk_buff *skb,
>  	struct gmac_txq *txq;
>  	int txq_num, nfrags;
>  	union dma_rwptr rw;
> +	int ret;
>  
>  	if (skb->len >= 0x10000)
>  		goto out_drop_free;

Since you already have this test, does the newly introduced one make
this redundant? Why not just change the limit here?

> @@ -1269,7 +1276,11 @@ static netdev_tx_t gmac_start_xmit(struct sk_buff *skb,
>  		}
>  	}
>  
> -	if (gmac_map_tx_bufs(netdev, skb, txq, &w)) {
> +	ret = gmac_map_tx_bufs(netdev, skb, txq, &w);
> +	if (ret == -E2BIG)
> +		goto out_drop;

Why out_drop and not out_drop_free? This handling will eventually cause an OOM.

The fact that it didn't makes me suspect that you never actually hit this condition,
because the network stack isn't delivering skbs larger than dev->mtu.
Maybe net/core/pktgen.c doesn't take the MTU into consideration, I'm not
completely sure there...

> +	if (ret) {
> +		/* Linearize and retry */
>  		if (skb_linearize(skb))
>  			goto out_drop;
>  
> 
> -- 
> 2.34.1
> 
