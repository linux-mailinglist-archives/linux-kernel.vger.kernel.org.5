Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9375338F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjGNHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjGNHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA5630EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D728D61C4A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38620C433C9;
        Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689321021;
        bh=cwHRXo/wW2oWNu56lQpWumfN9yIRdiC3B4zek6vqFec=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vPwcgOZyxDwpM34uramttyAkJZPb9WG+KRYmXwhhnI8u9UNgZkvtX/vKp6+o2Vo1y
         toH97iB2AdbR1UpRzpbkruQi9ilVVO2JmGOQrPqGvrHtULzmFGsfEtYAnDicRo681l
         kJFvTLCYaUK126+6IrOqemh00oEGkQudQNnc86ftIDvVOGbNTs7HedAwyOPxL578AZ
         OFDs3jemP8Fo2OVRaOUFDru+its8yfF3MflfS99KDov4ZHGrjusaLobaMS1LqmtCGp
         cXHTmAPVWB9CettzqZ1ReS1c7houLKId2fAlp22a6OD4bv5e8v70r6BHq+LL+8G3OD
         WDK0gebedr3XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F4FDE4508F;
        Fri, 14 Jul 2023 07:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: handle probe deferral
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168932102112.13275.16065030882031894328.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Jul 2023 07:50:21 +0000
References: <ZK9klTi7XoZZDMeE@makrotopia.org>
In-Reply-To: <ZK9klTi7XoZZDMeE@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        igvtee@gmail.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 03:42:29 +0100 you wrote:
> Move the call to of_get_ethdev_address to mtk_add_mac which is part of
> the probe function and can hence itself return -EPROBE_DEFER should
> of_get_ethdev_address return -EPROBE_DEFER. This allows us to entirely
> get rid of the mtk_init function.
> 
> The problem of of_get_ethdev_address returning -EPROBE_DEFER surfaced
> in situations in which the NVMEM provider holding the MAC address has
> not yet be loaded at the time mtk_eth_soc is initially probed. In this
> case probing of mtk_eth_soc should be deferred instead of falling back
> to use a random MAC address, so once the NVMEM provider becomes
> available probing can be repeated.
> 
> [...]

Here is the summary with links:
  - net: ethernet: mtk_eth_soc: handle probe deferral
    https://git.kernel.org/netdev/net/c/1d6d537dc55d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


