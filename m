Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48E375A038
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGSUwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGSUv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E721FFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBCAC61834
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC22BC433C9;
        Wed, 19 Jul 2023 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799911;
        bh=R5thK8MzXZwRF74d2FHPjnura0sN99c4ZZeDzrYKSwU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mp5F+HqNOqjXJTDdywXHW0z9pnTBc98MnAf7a8vhvVxpqq28oAHkeJRUXwIZQP6L8
         DVQm0hDbNgrw0f8DhTUqr3U/4ib7oEnZ6/HgcZrCV18jEOq0FzjVeH8CWphtAjIEI4
         DI6V3i9qTGAj8YC2iJ79sng2pfupjQcw2jYK6kXjH0h3FBTnequI7uJsiXWu07MuSJ
         YsvDUj/eErevdSDanuKVwNB/LfVhDNvloJ7X9wRIjLYxWvOG9GhsbvrPdsrE9Vaz3v
         WlZ4TB+kbPqpp/MOFoNb50WyKrK7Sxco6Cp+3lTuKLcXX7Hl9ZO0/upL53VElALfl2
         /8Lf1Mvd0AmVA==
Date:   Wed, 19 Jul 2023 13:51:50 -0700
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
Message-ID: <20230719135150.4da2f0ff@kernel.org>
In-Reply-To: <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
        <20230714170853.866018-10-aleksander.lobakin@intel.com>
        <20230718174042.67c02449@kernel.org>
        <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
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

On Wed, 19 Jul 2023 18:34:46 +0200 Alexander Lobakin wrote:
> > What if we got here from netpoll? napi budget was 0, so napi_safe is
> > false, but in_softirq() can be true or false.  
> 
> If we're on the same CPU where the NAPI would run and in the same
> context, i.e. softirq, in which the NAPI would run, what is the problem?
> If there really is a good one, I can handle it here.

#define SOFTIRQ_BITS		8
#define SOFTIRQ_MASK		(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
# define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
#define in_softirq()		(softirq_count())

I don't know what else to add beyond that and the earlier explanation.

AFAIK pages as allocated by page pool do not benefit from the usual
KASAN / KMSAN checkers, so if we were to double-recycle a page once
a day because of a netcons race - it's going to be a month long debug
for those of us using Linux in production.
