Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB3C781BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHTAgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjHTAgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234BB234610
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A096861479
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAB02C433C9;
        Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692470062;
        bh=zno65NsaCDTBTahswRO/GiauKWv/QcZvhjy0PyEpGB8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fVVqJ5Wa/wNE7YzQT9DvtGYEhD0gKhKjR1bVu0mdSMg2de18quTSxqnvkbAe3RND6
         FXvrc0EuKiyKCG15Y7huQtxhlVqyxhEfsKnXo4xXLlNqUeIfqnKJuqiw+ez1Z2NjL0
         dRtSZBIYhFrBdIiMwHCMZh3SOTzGC/UTTxF7DevhF9osCH0UiFf4UQY6XxyFrnKj6k
         jrvOfAzYWlcv5R0bV5L2QuDPydfN3Rq1m7H70WALsNqpupl53fdMokaX2m5nohWNYy
         5Spr0UCpqIy3TiRbXeNidR9+fLDFFP6wyxPbJlAF1zlMRGrQOiyPXPPnw9JIANqaNO
         Crq8pklFLPxOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF928E26D32;
        Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: Fix deadlocking in phy_error() invocation
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169247006184.18695.13657924227141073910.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Aug 2023 18:34:21 +0000
References: <20230818125449.32061-1-fancer.lancer@gmail.com>
In-Reply-To: <20230818125449.32061-1-fancer.lancer@gmail.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, francesco.dolcini@toradex.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 15:54:45 +0300 you wrote:
> Since commit 91a7cda1f4b8 ("net: phy: Fix race condition on link status
> change") all the phy_error() method invocations have been causing the
> nested-mutex-lock deadlock because it's normally done in the PHY-driver
> threaded IRQ handlers which since that change have been called with the
> phydev->lock mutex held. Here is the calls thread:
> 
> IRQ: phy_interrupt()
>      +-> mutex_lock(&phydev->lock); <--------------------+
>          drv->handle_interrupt()                         | Deadlock due
>          +-> ERROR: phy_error()                          + to the nested
>                     +-> phy_process_error()              | mutex lock
>                         +-> mutex_lock(&phydev->lock); <-+
>                             phydev->state = PHY_ERROR;
>                             mutex_unlock(&phydev->lock);
>          mutex_unlock(&phydev->lock);
> 
> [...]

Here is the summary with links:
  - [net] net: phy: Fix deadlocking in phy_error() invocation
    https://git.kernel.org/netdev/net/c/a0e026e7b37e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


