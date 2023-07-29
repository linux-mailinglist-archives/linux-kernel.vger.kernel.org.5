Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB53768085
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjG2QKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjG2QKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 12:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AFD3C21
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 09:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA4A60C7B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 16:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75FD3C433CA;
        Sat, 29 Jul 2023 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690647021;
        bh=oi5WpSWXZ+R74NunSULul0Bo/wksFDSKKr8cGlB4QyI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uulKBsgx3MTAz2P/tk4zgthX4NmGQSZ9CWwYGoA4TX4i5RlfCTADiRm+p3zGDtBz8
         OBHVr8NreJbCOBPjsS0ZAA3Xwc5T5uTI9+19OknBPehkrBaLf7A2EnTry9C3bJ/BSC
         CAjqbav4w5Bv3s82U/L+6YyiFjv7alT03KGafASjptHxnhoE+AktnfxviEk/clrW47
         cW+5yTsNmeEH/IfEIQY/QQqtaAJ/9aLXcMYwXFg5wvF1+HXMYfMakchfgGjT6kWJsg
         rCyVxOs8VdydUtgoiQ+wBR9Y7T1XWqVamtvTzAMfsdO9YOAMJTfM4eNc3l2KRV/D7t
         dbuqtLLs8qmHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 537F6C43169;
        Sat, 29 Jul 2023 16:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: microchip: KSZ9477 register regmap alignment to 32
 bit boundaries
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169064702132.23345.436670879049888015.git-patchwork-notify@kernel.org>
Date:   Sat, 29 Jul 2023 16:10:21 +0000
References: <20230727081342.3828601-1-lukma@denx.de>
In-Reply-To: <20230727081342.3828601-1-lukma@denx.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
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
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jul 2023 10:13:42 +0200 you wrote:
> The commit (SHA1: 5c844d57aa7894154e49cf2fc648bfe2f1aefc1c) provided code
> to apply "Module 6: Certain PHY registers must be written as pairs instead
> of singly" errata for KSZ9477 as this chip for certain PHY registers
> (0xN120 to 0xN13F, N=1,2,3,4,5) must be accesses as 32 bit words instead
> of 16 or 8 bit access.
> Otherwise, adjacent registers (no matter if reserved or not) are
> overwritten with 0x0.
> 
> [...]

Here is the summary with links:
  - net: dsa: microchip: KSZ9477 register regmap alignment to 32 bit boundaries
    https://git.kernel.org/netdev/net/c/8d7ae22ae9f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


