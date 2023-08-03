Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F065E76F043
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjHCRBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjHCRBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64273C16
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541CC61E42
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F72DC433C7;
        Thu,  3 Aug 2023 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691082067;
        bh=wA474XymD65CC5dKuW2W6SsS3E8kJfOKWrF/MmoRlJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jsZfPcoyR8Af89qv4Cg96ZnoZCeyumtSb2fNCwWlelSv5SUZpq3/Cqai2s+krJ8LN
         /RFqxgf87lMmNZ/q31ff9mKTT7kK/Cec8imGAtL1KxAEBshrLkzbSRhVPuEW7V9H/r
         dJNHaU3MMbtiii9M3LQ5ly4cMH4OhrD99/CPCzjnN0pgdRPYiL3tKfJdRe1QU6Hpj4
         NYHAIKopdtKTg37LajlwF8z1d7DxhwSJwdjZEZi65n37nGZu1gaZKNG4rtzHQaKq0q
         Z+flf6uRcd5T/OktAdV5yNF5z7oWiXWMrHmJmza/VXe/7+UzQgHhjS941QcJxIQ0zQ
         +bU2z6iOKAIFA==
Date:   Thu, 3 Aug 2023 10:01:06 -0700
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
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/6] page_pool: a couple of assorted
 optimizations
Message-ID: <20230803100106.4dd4f12a@kernel.org>
In-Reply-To: <20230803164014.993838-1-aleksander.lobakin@intel.com>
References: <20230803164014.993838-1-aleksander.lobakin@intel.com>
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

On Thu,  3 Aug 2023 18:40:08 +0200 Alexander Lobakin wrote:
> That initially was a spin-off of the IAVF PP series[0], but has grown
> (and shrunk) since then a bunch. In fact, it consists of three
> semi-independent blocks:
> 
> * #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
>   not overbloat the consumers not needing complex inline helpers and
>   then stop including it in skbuff.h at all. The first patch is also
>   prereq for the whole series.
> * #3: Improve cacheline locality for users of the Page Pool frag API.
> * #4-6: Use direct cache recycling more aggressively, when it is safe
>   obviously. In addition, make sure nobody wants to use Page Pool API
>   with disabled interrupts.
> 
> Patches #1 and #5 are authored by Yunsheng and Jakub respectively, with
> small modifications from my side as per ML discussions.
> For the perf numbers for #3-6, please see individual commit messages.
> 
> Also available on my GH with many more Page Pool goodies[1].

Replying here so that potential reviewers see.

I just pushed the update to docs which will conflict with this series.
Please rebase and repost (without the 24h wait).
-- 
pw-bot: cr
