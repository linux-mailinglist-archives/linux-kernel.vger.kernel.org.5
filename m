Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFC675B83D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjGTTqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGTTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:46:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7D19BE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C058661C28
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE4DC433C8;
        Thu, 20 Jul 2023 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689882409;
        bh=u8Lr+3WeqKvD4svXmrwr31VT12gwAWyndJkuUoaFWe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dgUAImpkQX2xyyBOB386xmAqsmG8JYcFPL94qeMMMyIzU+M7Bz7oO9cPYeYJVlHmn
         en5+cHaudEko4aDipf061qdfcOutcy+GR57a88hjjE2MnoLvOndXX/cDxL7kbGxj+S
         O3oOlp9cgL+f/YgyOqQsRQ38YRq2TXckOaK9lLyFQRyfWvCE/UBwYeQkLWuFACZsF6
         ibTtRutI6YKw4nINr+L4k9m+xiPXdgVxcYYI331zVu9zfAQJblX0w2x/eTZ7OEqedG
         rrsxCq5nr+6DsOePN8mX8gExOMrW/cHI8e79Ovq10GgKJmbXgzl1ION/quv3EFRAZW
         XPwPl48H6ul0A==
Date:   Thu, 20 Jul 2023 12:46:47 -0700
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
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle
 PP pages directly when in softirq
Message-ID: <20230720124647.413363d5@kernel.org>
In-Reply-To: <e542f6b5-4eea-5ac6-a034-47e9f92dbf7e@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
        <20230714170853.866018-10-aleksander.lobakin@intel.com>
        <20230718174042.67c02449@kernel.org>
        <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
        <20230719135150.4da2f0ff@kernel.org>
        <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
        <20230720101231.7a5ff6cd@kernel.org>
        <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
        <20230720110027.4bd43ee7@kernel.org>
        <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
        <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
        <20230720122015.1e7efc21@kernel.org>
        <e542f6b5-4eea-5ac6-a034-47e9f92dbf7e@intel.com>
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

On Thu, 20 Jul 2023 21:33:40 +0200 Alexander Lobakin wrote:
> > We can as well check
> > 	(in_softirq() && !irqs_disabled() && !in_hardirq())
> > ?  
> 
> Yes, something like that. Messy, but I see no other options...
> 
> So, I guess you want to add an assertion to make sure that we're *not*
> in this:
> 
> in_hardirq() || irqs_disabled()
> 
> Does this mean that after it's added, my patch is sane? :p

Well... it's acceptable. Make sure you add a good, informative
but concise comment :)

> > The interrupt_context_level() thing is fairly new, I think.
> > Who knows what happens to it going forward...  
> 
> Well, it counts the number of active hard interrupts, but doesn't take
> into account that if there are no hardirqs we can still disable them
> manually. Meh.
> Should I try to send a patch for it? :D

Depends on how you like to send your time :)

> > netcons or anyone who freed socket-less skbs from hardirq.
> > Until pp recycling was added freeing an skb from hardirq was legal,
> > AFAICT.  
> 
> I don't think so. Why do we have dev_kfree_skb_any() then? It checks for
> 
> in_hardirq() || irqs_disabled()
> 
> and if it's true, defers the skb to process it by backlog task.
> "Regular" skb freeing functions don't do that. The _any() variant lives
> here for a long time IIRC, so it's not something recent.

Drivers (or any other users of dev_kfree_skb_any()) should be fine. 
I'm only paranoid about some unknown bits of code which thought they
can be clever and call kfree_skb() directly, as long as !skb->sk.

But if you add the hard irq checks to your patch then you're strictly
safer than the existing code. Hopefully the checks are not too
expensive.
