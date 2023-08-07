Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04B773039
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHGUU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHGUUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA86810DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D25A62090
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF103C433C8;
        Mon,  7 Aug 2023 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691439623;
        bh=V9AFzfpmpeFOjhnhAQI/RQMk0Kz5hdHnESDiZoo0NE0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZBLyIvkTP6BBmNj0Hw8jMi44b6gjK4DwS8jvbZVclYdwWi1kFgkt8v95qVsiaho7n
         ntMLXdtZmc3F7GYidww1VJZ0sR+hvnBYjKJiBL46mkHIPFRb4CP8a+61uuvTdsBpBS
         l6HKVoB4wBUmnCJpFpTvizNq30D4XNUxH5/N0dhbdLaiDoXFh/f9Sz2DJNt4+8mM76
         xkDK/yKk5h9B42oYwhs0cD7OzYJI/YNRaFrYHYUCfAPZhBfyvrye+hcyo+6bH9YZuW
         +14X7q/s3fJin4CfmY+JKGGiKEb+gsOa3rcHzEIuLns+hJyhI2UTLBhmA/m/LwV7D8
         u6T/fo2GIDYlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3FCAE505D5;
        Mon,  7 Aug 2023 20:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] page_pool: a couple of assorted optimizations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169143962373.20323.15736867821555960200.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 20:20:23 +0000
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
In-Reply-To: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, maciej.fijalkowski@intel.com,
        larysa.zaremba@intel.com, linyunsheng@huawei.com,
        alexanderduyck@fb.com, hawk@kernel.org,
        ilias.apalodimas@linaro.org, simon.horman@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Aug 2023 20:05:23 +0200 you wrote:
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
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] page_pool: split types and declarations from page_pool.h
    https://git.kernel.org/netdev/net-next/c/a9ca9f9ceff3
  - [net-next,v4,2/6] net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
    https://git.kernel.org/netdev/net-next/c/75eaf63ea7af
  - [net-next,v4,3/6] page_pool: place frag_* fields in one cacheline
    https://git.kernel.org/netdev/net-next/c/06d0fbdad612
  - [net-next,v4,4/6] net: skbuff: avoid accessing page_pool if !napi_safe when returning page
    https://git.kernel.org/netdev/net-next/c/5b899c33b3b8
  - [net-next,v4,5/6] page_pool: add a lockdep check for recycling in hardirq
    https://git.kernel.org/netdev/net-next/c/ff4e538c8c3e
  - [net-next,v4,6/6] net: skbuff: always try to recycle PP pages directly when in softirq
    https://git.kernel.org/netdev/net-next/c/4a36d0180c45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


