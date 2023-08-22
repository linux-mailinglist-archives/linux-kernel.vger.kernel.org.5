Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149437837D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjHVCU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHVCU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33EEFD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B85F617CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF374C433C9;
        Tue, 22 Aug 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692670824;
        bh=WiuutlKZGSfnMqcEk2Hi4ACANiW2639zyoroXwPM8rY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qWwXRsyzXz/KvxTnNXQ9LEanWGs786Wm+OXoPuh2fuCHLLhwhBE8yyKxOB0xk3Wvj
         qDfNH2UoUt2j0sAFtlNTwJZwF/2DBvjBgyf+4wpsO+ex5Jc2laV4fuPavls02355Ki
         MTg6o6ODcPUVQm2aYtF6GXCB2zp2O9IXm2CzInxd0WO39M7KaIwsJ6TAJhh1jsgoIJ
         yu3HQat2zAsLmpM1pA7v1MEC9nfyT85wY1PuueulyBpaDQC5S3lAAFxKSd7hImXWak
         O5ShNTCb+xbbCva0BjuzdEWmYhIuyITcTiWUYgDWSVLl2SUB7KtpcuVMhosMCNMY/x
         S6noww69Hm7vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0B5BE4EAFB;
        Tue, 22 Aug 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pcs: lynxi: implement pcs_disable op
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169267082465.27540.3832216650125518638.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Aug 2023 02:20:24 +0000
References: <f23d1a60d2c9d2fb72e32dcb0eaa5f7e867a3d68.1692327891.git.daniel@makrotopia.org>
In-Reply-To: <f23d1a60d2c9d2fb72e32dcb0eaa5f7e867a3d68.1692327891.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     lynxis@fe80.eu, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Aug 2023 04:07:46 +0100 you wrote:
> When switching from 10GBase-R/5GBase-R/USXGMII to one of the interface
> modes provided by mtk-pcs-lynxi we need to make sure to always perform
> a full configuration of the PHYA.
> 
> Implement pcs_disable op which resets the stored interface mode to
> PHY_INTERFACE_MODE_NA to trigger a full reconfiguration once the LynxI
> PCS driver had previously been deselected in favor of another PCS
> driver such as the to-be-added driver for the USXGMII PCS found in
> MT7988.
> 
> [...]

Here is the summary with links:
  - [net-next] net: pcs: lynxi: implement pcs_disable op
    https://git.kernel.org/netdev/net-next/c/90308679c297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


