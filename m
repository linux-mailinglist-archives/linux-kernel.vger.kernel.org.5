Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0F75B86E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjGTUA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjGTUA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBB270D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE9161C36
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFAAAC433CB;
        Thu, 20 Jul 2023 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689883222;
        bh=hI8Fmqr0ttPE2QGhKjWCiJYj6F0Ufd8KmtHO2g2k3ok=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sHAeUz3OWQtRW31l8Etvc4TyALefATcwLb+C+tDcdKsVHE7skYeNWwqyxCjpD4Ha7
         +n/BM/oNytEWQe4EOg8ZCNJADu6vcrqhR5YS/2RNrWbZYtJFRxAr6zHSiRlVSYf1RY
         w9PlAzj2T+f6NA6KobHHgVXoxnUpHdCtoUJdz4qKrqkvePM4FTULibCjXcKaqHcu3P
         iS27EWov3q81RT/cyhKaStSnRnJkNsOxXEe98P/yM+zHuDWGvQQ6Ywry+RitDzaMQa
         pNYtL6ruNJddUhIaVBkC6MFDfI+pfrUeydbrQmu4HxEcJgUM/jw2uhEzgAtDGPLrvJ
         rCJrg+r1jjduA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3DF0E21EF5;
        Thu, 20 Jul 2023 20:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: prevent stale pointer dereference in phy_init()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168988322273.13634.6290441658966987818.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 20:00:22 +0000
References: <20230720000231.1939689-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230720000231.1939689-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 03:02:31 +0300 you wrote:
> mdio_bus_init() and phy_driver_register() both have error paths, and if
> those are ever hit, ethtool will have a stale pointer to the
> phy_ethtool_phy_ops stub structure, which references memory from a
> module that failed to load (phylib).
> 
> It is probably hard to force an error in this code path even manually,
> but the error teardown path of phy_init() should be the same as
> phy_exit(), which is now simply not the case.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: prevent stale pointer dereference in phy_init()
    https://git.kernel.org/netdev/net/c/1c613beaf877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


