Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0DB7E0FFC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjKDO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjKDO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:57:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD371BC;
        Sat,  4 Nov 2023 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Ex9cofny33QV6p/OTbMgVfmXHo630/2h/gGAekdBznw=; b=PF8ho379sX1yb4AoefxLHRgiv8
        9nAWf4huNuAoVrBmmhwl6I01NiL2OSnND2u7PEKmzIZODKciOSrbWJ81s5ZCC9ssZ5ONayEcU+Zl3
        GMFT4QUvI3jkZXQWhSDJOupianQdWzYG4lkOz9FPQrdpkcIlEpfXsuScP7dHy/nDWk7I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qzI55-000sS0-KO; Sat, 04 Nov 2023 15:56:59 +0100
Date:   Sat, 4 Nov 2023 15:56:59 +0100
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
Subject: Re: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
Message-ID: <036b481e-ac5b-4e77-b93a-4badaf19e185@lunn.ch>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
 <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1170,7 +1171,14 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
>  		word3 |= mtu;
>  	}
>  
> -	if (skb->ip_summed != CHECKSUM_NONE) {
> +	if (skb->len >= ETH_FRAME_LEN) {
> +		/* Hardware offloaded checksumming isn't working on frames
> +		 * bigger than 1514 bytes. Perhaps the buffer is only 1518
> +		 * bytes fitting mach a normal frame and a checksum?

mach ?

> +		 * Just bypass on bigger frames.
> +		 */
> +		word1 |= TSS_BYPASS_BIT;
> +	} else if (skb->ip_summed != CHECKSUM_NONE) {

I've never looked at how the network stack does checksums. But looking
at this patch, it made me wounder, how do you tell the stack it needs
to do a software checksum because the hardware cannot? Or for this
driver, is it always calculating a checksum, which is then ignored?
Maybe you can improve performance a little but disabling software
checksum when it is not needed?

	 Andrew
