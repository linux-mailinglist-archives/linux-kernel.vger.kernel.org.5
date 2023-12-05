Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C506980451E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376336AbjLECkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbjLECkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2AFCA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:40:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 531B8C433CA;
        Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701744025;
        bh=7qPKJ3S8i489bnlJf7/hjHyGn4ZzVXxeyHWMQ4xpB9c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oG7pXZNZFIrMvULwRVn7OecljZ6pHpBXbJVi8D3HPtCieQXObKyz7G1D4BtAlcVNl
         JapKceXN0Nfyk7jz1QPw9H/WFmNAwOhDGGOWyPE+Bl6boUvOyTVJVw69WDbDJWYANE
         oSG1pvF+Si2GOFb2pCVkCX/niRgDMXIBIErbis2orwx4QSCy6QkGi3B/QJ19IR9BSZ
         dUOqRXdQZquGaRBOEAystgW+dzDVL2d1EsGFiZpJV58Jp3nVzwOs0GH0Fniu5i8pl5
         Mfu8WfNCOuYj7A4ruEaOrVxbXzcGMO0F+ACzfa0xUvhV9eC/D7IWxx0NoGRi28Dw+S
         bwjPdUzaizKCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E8DDDD4EF1;
        Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: stmmac: fix FPE events losing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170174402518.31470.16495979069997859149.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Dec 2023 02:40:25 +0000
References: <CY5PR12MB637225A7CF529D5BE0FBE59CBF81A@CY5PR12MB6372.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB637225A7CF529D5BE0FBE59CBF81A@CY5PR12MB6372.namprd12.prod.outlook.com>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     alexandre.torgue@foss.st.com, Jose.Abreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, horms@kernel.org,
        ahalaney@redhat.com, bartosz.golaszewski@linaro.org,
        shenwei.wang@nxp.com, j.zink@pengutronix.de,
        rmk+kernel@armlinux.org.uk, jh@henneberg-systemdesign.com,
        weifeng.voon@intel.com, mohammad.athari.ismail@intel.com,
        boon.leong.ong@intel.com, tee.min.tan@intel.com,
        James.Li1@synopsys.com, Martin.McKenny@synopsys.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Dec 2023 03:22:03 +0000 you wrote:
> The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
> 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
> handler missing FPE event status and leads to FPE handshaking failure and
> retries.
> To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
> and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
> cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> MAC_FPE_CTRL_STS in those methods.
> 
> [...]

Here is the summary with links:
  - [v4] net: stmmac: fix FPE events losing
    https://git.kernel.org/netdev/net/c/37e4b8df27bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


