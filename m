Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71875B60A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGTSAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGTSAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E38270D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B257C61BB6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B174CC433C7;
        Thu, 20 Jul 2023 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689876029;
        bh=7zlXtpjQE5GsiUCG8T5VeQsjP7xxM1cSIbwNm1yLxBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q9i2KlNic8DT0aV6wei/pn/69NnpnLEOl6A5KpT0D+5gBE5EQ75jsSPR2pszdDquy
         h0Vr8sba6J3Z8Z6XUGYoqxiTYSvYq/y+u3YPm21zno40p5GItvroYgfGafZxv2OZdQ
         NnROMTed50T0p4vtabWit1SP/F5q4TVbmVKy9UpfTC3qo676e0x5oda7gb++e3Bnc+
         DqL86OoukRxtv1Nt4UKGoVBdt0YDTPzQuD4oo9eniO++HlR3BKBipBd70U4zH3FepH
         oRGNqovTUNhPvvjJ52w35hqz4LV0ybJhcUEjw9ZGA4ggDpXYqRP8Prp8v4fG3Lj/y2
         NKsx0/bGGfvsg==
Date:   Thu, 20 Jul 2023 11:00:27 -0700
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
Message-ID: <20230720110027.4bd43ee7@kernel.org>
In-Reply-To: <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
        <20230714170853.866018-10-aleksander.lobakin@intel.com>
        <20230718174042.67c02449@kernel.org>
        <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
        <20230719135150.4da2f0ff@kernel.org>
        <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
        <20230720101231.7a5ff6cd@kernel.org>
        <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
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

On Thu, 20 Jul 2023 19:48:06 +0200 Alexander Lobakin wrote:
> >> My question was "how can two things race on one CPU in one context if it
> >> implies they won't ever happen simultaneously", but maybe my zero
> >> knowledge of netcons hides something from me.  
> > 
> > One of them is in hardirq.  
> 
> If I got your message correctly, that means softirq_count() can return
> `true` even if we're in hardirq context, but there are some softirqs
> pending? 

Not pending, being executed. Hardirq can come during softirq.

> I.e. if I call local_irq_save() inside NAPI poll loop,
> in_softirq() will still return `true`? (I'll check it myself in a bit,
> but why not ask).

Yes.

> Isn't checking for `interrupt_context_level() == 1` more appropriate
> then? Page Pool core code also uses in_softirq(), as well as a hellaton
> of other networking-related places.

Right now page pool only supports BH and process contexts. IOW the
"else" branch of if (in_softirq()) in page pool is expecting to be
in process context.

Supporting hard irq would mean we need to switch to _irqsave() locking.
That's likely way too costly.

Or stash the freed pages away and free them lazily.

Or add a lockdep warning and hope nobody will ever free a page-pool
backed skb from hard IRQ context :)
