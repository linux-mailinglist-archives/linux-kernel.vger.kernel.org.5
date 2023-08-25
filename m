Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC3178831E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbjHYJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbjHYJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B98E1BF2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BCE163288
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0174AC433C8;
        Fri, 25 Aug 2023 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692954622;
        bh=mgDpWw4NnHcs/igxF8pf7W15p2GZKlpLDAw/A/+uOaA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MIBkIgax3cUEiKQkoEfRP1H6BAMonfDyHs2y+V+gb3JaNOItxBOd6CQL7tU/h7FHj
         O3EOY5pKMvaMt2mi134apc1ClqUL7ld7Eh5vcnxQX7FqBiMYX6slQv2PqrF9Q7pu3y
         WBuNw3wR19RAEGu8g7OZwUK8LAkkiqTpj0U/6IOxPi3Fk3ljPqNPag+P7MXjOsuH3P
         qn/mOlmq5xhSP4xukrS58sratG2pdjeQ02x6wMT77ho//bDGlKH0AL+68HrgUUmzlh
         DRlllvZhBknGq7xW5DoepO9DtkRGI7P83sU+n2g0Arp0boVJCleHm4qZCl2FYC7BI6
         Hw+vvj178vXWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6501C595C5;
        Fri, 25 Aug 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] octeontx2-pf: fix page_pool creation fail for rings >
 32k
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169295462187.4538.1798354302418807618.git-patchwork-notify@kernel.org>
Date:   Fri, 25 Aug 2023 09:10:21 +0000
References: <20230824030301.2525375-1-rkannoth@marvell.com>
In-Reply-To: <20230824030301.2525375-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        alexander.duyck@gmail.com, ilias.apalodimas@linaro.org,
        linyunsheng@huawei.com, aleksander.lobakin@intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 08:33:01 +0530 you wrote:
> octeontx2 driver calls page_pool_create() during driver probe()
> and fails if queue size > 32k. Page pool infra uses these buffers
> as shock absorbers for burst traffic. These pages are pinned down
> over time as working sets varies, due to the recycling nature
> of page pool, given page pool (currently) don't have a shrinker
> mechanism, the pages remain pinned down in ptr_ring.
> Instead of clamping page_pool size to 32k at
> most, limit it even more to 2k to avoid wasting memory.
> 
> [...]

Here is the summary with links:
  - [v3,net] octeontx2-pf: fix page_pool creation fail for rings > 32k
    https://git.kernel.org/netdev/net/c/49fa4b0d0670

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


