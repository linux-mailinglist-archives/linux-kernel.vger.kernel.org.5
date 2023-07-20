Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D675B546
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGTRMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGTRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F58AA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E79B61B8F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CDEC433C8;
        Thu, 20 Jul 2023 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873152;
        bh=zts5NGHn5WQO6o2e+6B3ydRceosp6xQJd00HqAw+IqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MGgQOpn/VZvgDzWlCQN9LvoD1UVj9oGVDzUyA3BzkG8l0/DDAKaasuWhF+jmTBwMP
         YgzWR2xlknaz/X5CbhkIIAM5GtDSv5WiO51OqlwYHFA+QIC8TjW6XF3Ikex7J3jVWm
         C/tA19VEADT/7ZnAV49R+vV5cAlrVIxy8LYJAR7fC4vBDkOt8xj9FR+6Kgw9lieP1K
         6kC2/2BmnR1sX2CVDRbpiAE8xFQV/Wpb99OWsgaSQ7hIzSi3i0EyMcecBdrEhost88
         bmeThMTvqtp9uuZsy9MvD09bPob5spz9okpkSRP6yomR+frUdgyV/nBMdkW+sG53VN
         zY8N1jsB/Qicg==
Date:   Thu, 20 Jul 2023 10:12:31 -0700
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
Message-ID: <20230720101231.7a5ff6cd@kernel.org>
In-Reply-To: <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
        <20230714170853.866018-10-aleksander.lobakin@intel.com>
        <20230718174042.67c02449@kernel.org>
        <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
        <20230719135150.4da2f0ff@kernel.org>
        <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
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

On Thu, 20 Jul 2023 18:46:02 +0200 Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Wed, 19 Jul 2023 13:51:50 -0700
> 
> > On Wed, 19 Jul 2023 18:34:46 +0200 Alexander Lobakin wrote:  
>  [...]  
> >>
> >> If we're on the same CPU where the NAPI would run and in the same
> >> context, i.e. softirq, in which the NAPI would run, what is the problem?
> >> If there really is a good one, I can handle it here.  
> > 
> > #define SOFTIRQ_BITS		8
> > #define SOFTIRQ_MASK		(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
> > # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
> > #define in_softirq()		(softirq_count())  
> 
> I do remember those, don't worry :)
> 
> > I don't know what else to add beyond that and the earlier explanation.  
> 
> My question was "how can two things race on one CPU in one context if it
> implies they won't ever happen simultaneously", but maybe my zero
> knowledge of netcons hides something from me.

One of them is in hardirq.

> > AFAIK pages as allocated by page pool do not benefit from the usual
> > KASAN / KMSAN checkers, so if we were to double-recycle a page once
> > a day because of a netcons race - it's going to be a month long debug
> > for those of us using Linux in production.  
> 
> if (!test_bit(&napi->state, NPSVC))

if you have to the right check is !in_hardirq()

> ? It would mean we're not netpolling.
> Otherwise, if this still is not enough, I'do go back to my v1 approach
> with having a NAPI flag, which would tell for sure we're good to go. I
> got confused by your "wouldn't just checking for softirq be enough"! T.T
> Joking :D

I guess the problem I'm concerned about can already happen.
I'll send a lockdep annotation shortly.
