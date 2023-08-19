Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E326578167F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 03:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbjHSBue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 21:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243173AbjHSBuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CE33C38
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 343FC6210F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91142C433C7;
        Sat, 19 Aug 2023 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692409820;
        bh=1xKOo8e+yHe9yBvf4r8j1yhlME4v4ZCTxC16aU0cd78=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CkBoF/x+7S44myTvhVD2plfaBPWcr7AjJZCYjiYQp+JsWkwY4Oo5n0dYASUY9J3Hd
         qBO1wYtnDCaD+LhSCAE/W97tBlw4ep+bCvRWalRTTkIC1KjG0rhx3cQvqd8cB9kpa6
         7IbZn/csBnxGdbxO7bvfpQ+R828vzX2wZ174hJVS6sgE79g61IuMwUN9ZGPCubDdt4
         WW0Pkn6Qr4INtkYcFJnIUuB11B6NYFQ+A6V6srP6Tft/uoJqyaciR6UojmFV8cU2Pb
         cZ9WWjJxWjszkbN7/HQH1wegzqzBJUv3LFoCsrUg9lA3XoejD/hJbQ58q3j1EnnUWi
         9P4ogWrNJeCFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74351C395DC;
        Sat, 19 Aug 2023 01:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: felix: fix oversize frame dropping for always
 closed tc-taprio gates
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169240982047.25977.11170971681748850525.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Aug 2023 01:50:20 +0000
References: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xiaoliang.yang_1@nxp.com,
        claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com,
        michael@walle.cc, richard.pearn@nxp.com,
        linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 15:01:11 +0300 you wrote:
> The blamed commit resolved a bug where frames would still get stuck at
> egress, even though they're smaller than the maxSDU[tc], because the
> driver did not take into account the extra 33 ns that the queue system
> needs for scheduling the frame.
> 
> It now takes that into account, but the arithmetic that we perform in
> vsc9959_tas_remaining_gate_len_ps() is buggy, because we operate on
> 64-bit unsigned integers, so gate_len_ns - VSC9959_TAS_MIN_GATE_LEN_NS
> may become a very large integer if gate_len_ns < 33 ns.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: felix: fix oversize frame dropping for always closed tc-taprio gates
    https://git.kernel.org/netdev/net/c/d44036cad311

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


