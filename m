Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0323767B59
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjG2BuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG2BuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:50:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C51E75
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF1686221A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 01:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38B02C433C8;
        Sat, 29 Jul 2023 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690595420;
        bh=zHRAX00K8JGJW6dPGn+b56RgcIdMCopEEB6OpFLjofY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SVOJVsRo+HAth4PzRQAYGD6N1akStIDGe+gEYlXS5EzSxf3Ynz3gVOGPWhWNcjiVT
         LQgfBSNeiMkuaH15IYZPw3LR7xJ0jjSaUGE6XKyK/JBPMWl5JyeT+euJYbg0yCBrux
         8lPASg9hB9U0gixiNQ+q5ZmmD2lM/4IK+ByDQTaBloV410UBDt1nCzAS7GrQQzoapG
         z0ZEoLs0GlMSXPgJ+H4Af7hqRqIP8PNsC3YhNLNGpZOyWFcWxOK2Z6VRKn5UV6hq/k
         Hqc2BV27Gy4bSfPMUKomHgGoEPtu3R43mmny94056rq6VjOqyvmo+9GieQ1iuapJkT
         6zf0uF4Hklt+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BEBCE1CF31;
        Sat, 29 Jul 2023 01:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] mISDN: hfcpci: Fix potential deadlock on &hc->lock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169059542010.13127.16700262507413576636.git-patchwork-notify@kernel.org>
Date:   Sat, 29 Jul 2023 01:50:20 +0000
References: <20230727085619.7419-1-dg573847474@gmail.com>
In-Reply-To: <20230727085619.7419-1-dg573847474@gmail.com>
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     isdn@linux-pingi.de, alexanderduyck@fb.com, duoming@zju.edu.cn,
        yangyingliang@huawei.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 27 Jul 2023 08:56:19 +0000 you wrote:
> As &hc->lock is acquired by both timer _hfcpci_softirq() and hardirq
> hfcpci_int(), the timer should disable irq before lock acquisition
> otherwise deadlock could happen if the timmer is preemtped by the hadr irq.
> 
> Possible deadlock scenario:
> hfcpci_softirq() (timer)
>     -> _hfcpci_softirq()
>     -> spin_lock(&hc->lock);
>         <irq interruption>
>         -> hfcpci_int()
>         -> spin_lock(&hc->lock); (deadlock here)
> 
> [...]

Here is the summary with links:
  - [v2] mISDN: hfcpci: Fix potential deadlock on &hc->lock
    https://git.kernel.org/netdev/net/c/56c6be35fcbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


