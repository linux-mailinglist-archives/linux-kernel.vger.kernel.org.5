Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F9760E06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGYJK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjGYJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBAB127
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C7F46156C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9C5DC433A9;
        Tue, 25 Jul 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690276225;
        bh=+I3MrAkozYgkZ/ft0JFCrt2ovq1ZVfIjLtRLYDP33Co=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RpOeLjq0O8uuZNCUT4tikvPjADpnk+kFZFoJVVM/QcmqtAYeffGu3ONdhASc9sXYm
         djR9jWSd1hMWApUKRc3D6nanYBiTd0HkVir3lLUP+9xuAQgrH55mHQD8vKLz5KSSsG
         boDmbuZoALT+F0txVEPrGeaEDH/SImFOv7WTF67TE89j6QSvIWJ2IZjXD6FUlIEiJX
         cD4+BNjXPtiRAJhWfx6qtDbjd49qY96ESkFqsj5GYsGXbiScbz3GHvySjzNx/zmAbO
         h7v9KBWhCe6paxAtWVhOjlft3V16p7s9bSu/Fx8HsYUTfP23b+i3rLuNc1+4f5R4Ir
         HkWfCQohpD2Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCDC7C595D0;
        Tue, 25 Jul 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: Apply redundant write work around on 4.xx
 too
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169027622483.7192.11650697551791902221.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 09:10:24 +0000
References: <20230721-stmmac-tx-workaround-v1-1-9411cbd5ee07@axis.com>
In-Reply-To: <20230721-stmmac-tx-workaround-v1-1-9411cbd5ee07@axis.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
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

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jul 2023 15:39:20 +0200 you wrote:
> commit a3a57bf07de23fe1ff779e0fdf710aa581c3ff73 ("net: stmmac: work
> around sporadic tx issue on link-up") worked around a problem with TX
> sometimes not working after a link-up by avoiding a redundant write to
> MAC_CTRL_REG (aka GMAC_CONFIG), since the IP appeared to have problems
> with handling multiple writes to that register in some cases.
> 
> That commit however only added the work around to dwmac_lib.c (apart
> from the common code in stmmac_main.c), but my systems with version
> 4.21a of the IP exhibit the same problem, so add the work around to
> dwmac4_lib.c too.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: Apply redundant write work around on 4.xx too
    https://git.kernel.org/netdev/net/c/284779dbf4e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


