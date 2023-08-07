Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA875772EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjHGTa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHGTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA171717
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E41621A8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC2D3C433CC;
        Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691436624;
        bh=uE2fa7Fe0pYN2Kl+HM144jNfenom/57ArJYynw749Y8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rKa2GrlyguweRNZ5knCI8EenRhfj2Xvv2Ldea63alaBe7mpjAlGAOeHhsepJQ14gb
         Jm8DJwFzGVGq3VyFl8f43PeOU/f/g56xUljiQnpgRNFf31oqYOKnl56HfUFW9ee0Uw
         x2fiek2lEFT/bjTqiWdNZ+YTEdt18OjnpYIn093Pb4A72qsKCER1Gm5ID5oxgWCrTP
         hSpy8fDAYm6XQQJPeeDzjc26MsT9BJYnhCbYlY7COpBJY+SKT/0p4aGDOzCmLu0Orx
         h7gYTFFULHHfLZZtUvi9q+U3h6XA4FJgoQaKdHWAFNK45uIaMreW5vGFCzImfKZouL
         CNchHLHJC/bqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE4E5E270C3;
        Mon,  7 Aug 2023 19:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169143662470.21933.13583691380398650705.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 19:30:24 +0000
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
In-Reply-To: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, linux@armlinux.org.uk,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kurt@linutronix.de, lkp@intel.com
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Aug 2023 17:44:28 +0200 you wrote:
> ---
> Changes in v3:
> - work in Richard's review feedback. Thank you for reviewing my patch:
>   - as some of the hardware may have no or invalid correction value
>     registers: introduce feature switch which can be enabled in the glue
>     code drivers depending on the actual hardware support
>   - only enable the feature on the i.MX8MP for the time being, as the patch
>     improves timing accuracy and is tested for this hardware
> - Link to v2: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net: stmmac: correct MAC propagation delay
    https://git.kernel.org/netdev/net-next/c/26cfb838aa00
  - [v3,2/2] net: stmmac: dwmac-imx: enable MAC propagation delay correction for i.MX8MP
    https://git.kernel.org/netdev/net-next/c/6cb2e613c796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


