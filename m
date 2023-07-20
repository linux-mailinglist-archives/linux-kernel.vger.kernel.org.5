Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03475B7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGTTUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9534A171D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A278616B4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1AAC433C8;
        Thu, 20 Jul 2023 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689880816;
        bh=7J8RBLCwafwPtaQ9gdKbvPgytbTGrbMuKVN30E0FCJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AZIEIranBXAghUEn8aWNlwC2xwxMfluBCSUNbcdXxYRcg3nDj46sDuwcKMohX1aod
         21J0PdrL49BC2Q7HfjBPxNHU0+t2CV0TUS6V8sbEqwxOs7C5CzMhAoUmsSj9hbH/9X
         ZLSS4Sk8qWZJ3JZWFWkCjTDUJWuPYB/g4glqK4iAHuelQwqey6AoePPkaKTqeTGRZ6
         PEVkqiYqTunUgZFDc+6VzGegHiD07F3HiyV+w4JBWo9I6JXNCyaJat1WUzuAalKPEp
         pOdqZ+5oI65b88Y2QGu3lETqDm9lOzDnKfT0OEfjW65H4fegIY+gRIPcbGGJuMzx/D
         lsYoTVVCkkzgA==
Date:   Thu, 20 Jul 2023 12:20:15 -0700
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
Message-ID: <20230720122015.1e7efc21@kernel.org>
In-Reply-To: <b3884ff9-d903-948d-797a-1830a39b1e71@intel.com>
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

On Thu, 20 Jul 2023 20:13:07 +0200 Alexander Lobakin wrote:
> IOW, it reports we're in softirq no bloody matter if interrupts are
> enabled or not. Either I did something wrong or the entire in_*irq()
> family, including interrupt_context_level(), doesn't protect from
> anything at all and doesn't work the way that most devs expect it to work?
> 
> (or was it just me? :D)
> 
> I guess the only way to be sure is to always check irqs_disabled() when
> in_softirq() returns true.

We can as well check
	(in_softirq() && !irqs_disabled() && !in_hardirq())
?

The interrupt_context_level() thing is fairly new, I think.
Who knows what happens to it going forward...

> >> Right now page pool only supports BH and process contexts. IOW the
> >> "else" branch of if (in_softirq()) in page pool is expecting to be
> >> in process context.
> >>
> >> Supporting hard irq would mean we need to switch to _irqsave() locking.
> >> That's likely way too costly.
> >>
> >> Or stash the freed pages away and free them lazily.
> >>
> >> Or add a lockdep warning and hope nobody will ever free a page-pool
> >> backed skb from hard IRQ context :)  
> > 
> > I told you under the previous version that this function is not supposed
> > to be called under hardirq context, so we don't need to check for it :D
> > But I was assuming nobody would try to do that. Seems like not really
> > (netcons) if you want to sanitize this...

netcons or anyone who freed socket-less skbs from hardirq.
Until pp recycling was added freeing an skb from hardirq was legal,
AFAICT.
