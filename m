Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDF0758A28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGSAkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGSAkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D2113D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8724615D5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B230EC433C8;
        Wed, 19 Jul 2023 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689727244;
        bh=OObyhr4FvtnpD48DJkziD/tIkyd9HmMhKTkALpnmvec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QBtDVeiPgdEoT2uTqA6emOA+x0jK9PKcfrZuJy3nLjvMfdFOE7CfJDEG3debe2H4J
         YSYkReYKOXc10kUA4TVcUqsqTCXNzwRpQJh9CUqIfdOKtbqjC1zdv5lMC1ta33TKkl
         9I6B0KnH7S2w36qS/1+Z+M4ELdiUtuflEtk0H6BksIPhKmpSDS3cqWazs+T1zGnp7I
         b0XnBUeZnOQvqpxxhSsSMZxFj90D5cfO/INTprfjYHfKoQqY45vFeZTFdDX2V7rSKk
         5MgEMTiP1hXae16iMLPf/Gbky0rLUKWAkdCILHRI3VMDkdPdi/Sieoh5v9LLTOnDk2
         bijVdfja0kbGw==
Date:   Tue, 18 Jul 2023 17:40:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle
 PP pages directly when in softirq
Message-ID: <20230718174042.67c02449@kernel.org>
In-Reply-To: <20230714170853.866018-10-aleksander.lobakin@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
        <20230714170853.866018-10-aleksander.lobakin@intel.com>
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

On Fri, 14 Jul 2023 19:08:52 +0200 Alexander Lobakin wrote:
> Suggested-by: Jakub Kicinski <kuba@kernel.org> # in_softirq()

I thought I said something along the lines as "if this is safe you can
as well" which falls short of a suggestion, cause I don't think it is
safe :)

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index fc1470aab5cf..1c22fd33be6c 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -902,7 +902,7 @@ bool page_pool_return_skb_page(struct page *page, bool napi_safe)
>  	 * in the same context as the consumer would run, so there's
>  	 * no possible race.
>  	 */
> -	if (napi_safe) {
> +	if (napi_safe || in_softirq()) {
>  		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
>  
>  		allow_direct = napi &&

What if we got here from netpoll? napi budget was 0, so napi_safe is
false, but in_softirq() can be true or false.

XDP SKB is a toy, I really don't think 3-4% in XDP SKB warrants the
risk here.
