Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4776454C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjG0FK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjG0FKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74EF26AE;
        Wed, 26 Jul 2023 22:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43759614A8;
        Thu, 27 Jul 2023 05:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9376DC433D9;
        Thu, 27 Jul 2023 05:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690434623;
        bh=4y6u2oRadKe4rbPOWeXyCffpFw8g8kqrXrl7kOvqkVE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dKypFyKn4AmKaTtTpFdOTikQKNZ6A9ORXpAjff81NHaCac9RWvUunjuYfm8xx2Kbr
         qwRcroPY3TGbL0XtTYDZ4knj5ERhuVNyjvs+1l3ZzFfc/Koc9aJCGp5+ToTxOOMrSy
         QxnmHBa+3usJ4uhUal604dWTp5rcRxvfgmDhiC7rpb9sQ280JiTavAro877GUSsCIr
         pan1QV8yCkcfmz6qzyzuy0YWZDQhVaUzg+thcJpiO/gd1zD/yWqS2wVIebNcg8yvpi
         oULVtPj5Pe36TzjYrNNLQ4FibO1NOD47CQwUsKtJKscnX01rqbQhG71eVp4QorenWZ
         bmqoeNUmo2y5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C945C595D0;
        Thu, 27 Jul 2023 05:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/8] net: ethernet: mtk_eth_soc: add basic
 support for MT7988 SoC
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169043462350.30073.405534761855593169.git-patchwork-notify@kernel.org>
Date:   Thu, 27 Jul 2023 05:10:23 +0000
References: <cover.1690246066.git.daniel@makrotopia.org>
In-Reply-To: <cover.1690246066.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux@armlinux.org.uk, gerg@kernel.org, bjorn@mork.no,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jul 2023 01:51:00 +0100 you wrote:
> The MediaTek MT7988 SoC introduces a new version (3) of the NETSYS
> block and comes with three instead of two MACs.
> 
> The first MAC can be internally connected to a built-in Gigabit
> Ethernet switch with four 1000M/100M/10M twisted pair user ports.
> 
> The second MAC can be internally connected to a built-in 2500Base-T
> Ethernet PHY.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/8] dt-bindings: net: mediatek,net: add missing mediatek,mt7621-eth
    https://git.kernel.org/netdev/net-next/c/1cbf487d7d3a
  - [net-next,v6,2/8] dt-bindings: net: mediatek,net: add mt7988-eth binding
    https://git.kernel.org/netdev/net-next/c/c94a9aabec36
  - [net-next,v6,3/8] net: ethernet: mtk_eth_soc: add version in mtk_soc_data
    https://git.kernel.org/netdev/net-next/c/a008e2a84e6b
  - [net-next,v6,4/8] net: ethernet: mtk_eth_soc: increase MAX_DEVS to 3
    https://git.kernel.org/netdev/net-next/c/6ca265571b9e
  - [net-next,v6,5/8] net: ethernet: mtk_eth_soc: rely on MTK_MAX_DEVS and remove MTK_MAC_COUNT
    https://git.kernel.org/netdev/net-next/c/e05fd6274ee6
  - [net-next,v6,6/8] net: ethernet: mtk_eth_soc: add NETSYS_V3 version support
    https://git.kernel.org/netdev/net-next/c/1953f134a1a8
  - [net-next,v6,7/8] net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64
    https://git.kernel.org/netdev/net-next/c/51a4df60db5c
  - [net-next,v6,8/8] net: ethernet: mtk_eth_soc: convert clock bitmap to u64
    https://git.kernel.org/netdev/net-next/c/c75e416ccfd2
  - [v6,net-next,9/9] net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


