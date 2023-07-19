Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753E2759267
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjGSKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGSKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3465A171D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A20DB61389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2FC2C43391;
        Wed, 19 Jul 2023 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689761421;
        bh=c2UEHPFuhGfZOFd31QJQjfIX++Nbo6YKMqG9JatMuTU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oJMsmvwZmkpUeh7anTEfAa/IBxDqJUCHmHkgHDIIC5FGvua/XZKRDcyLRJjcLbhmu
         ueSV/ebApoM4f/6qK0rBZdPe/0Cz7qM8kXV3m+J7wju1TgoryW3WhwKE6Hk9y1k2p6
         M2aQ50hU90xwEjG8R4rzRN9i2VMMQ+TL+BNciL/J+IZ8R463ML8G70gRRyoIvmmpLa
         NSmX5l7GkcTiAuj8pl9Owg3sG6NbRWzh7YnN6JwSWc7CmzTLAV25LMFwP2dwjQ36J4
         yM0YJLuZ9ycu3aNchxsZusFBumZPBXZW19rDYQXhzrJOiQKZ8llfPHhrd8RXAMSJID
         WMKqRbkn/aOcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5A30E21EFF;
        Wed, 19 Jul 2023 10:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: Fix L3L4 filter count
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168976142174.5988.2207846071493224223.git-patchwork-notify@kernel.org>
Date:   Wed, 19 Jul 2023 10:10:21 +0000
References: <20230717120603.5053-1-rohan.g.thomas@intel.com>
In-Reply-To: <20230717120603.5053-1-rohan.g.thomas@intel.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     davem@davemloft.net, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jul 2023 20:06:03 +0800 you wrote:
> Get the exact count of L3L4 filters when the L3L4FNUM field of
> HW_FEATURE1 register is >= 8. If L3L4FNUM < 8, then the number of L3L4
> filters supported by XGMAC is equal to L3L4FNUM. From L3L4FNUM >= 8
> the number of L3L4 filters goes on like 8, 16, 32, ... Current
> maximum of L3L4FNUM = 10.
> 
> Also, fix the XGMAC_IDDR bitmask of L3L4_ADDR_CTRL register. IDDR
> field starts from the 8th bit of the L3L4_ADDR_CTRL register. IDDR[3:0]
> indicates the type of L3L4 filter register while IDDR[8:4] indicates
> the filter number (0 to 31). So overall 9 bits are used for IDDR
> (i.e. L3L4_ADDR_CTRL[16:8]) to address the registers of all the
> filters. Currently, XGMAC_IDDR is GENMASK(15,8), causing issues
> accessing L3L4 filters above 15 for those XGMACs configured with more
> than 16 L3L4 filters.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] net: stmmac: xgmac: Fix L3L4 filter count
    https://git.kernel.org/netdev/net-next/c/47448ff2d5c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


