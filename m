Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C175E170
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGWKk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:40:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA386186
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B43D60C8A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EC93C433C9;
        Sun, 23 Jul 2023 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690108822;
        bh=h2/d1cfHOZ62zqj3dX1qlhbMC676qqkOThcZ4MePpvs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hr9gFV36IjKumo0RFvApYGSfSQKfszEPzBazK2Ayl8vS+FHi8qHlfSBw3DTRy7Re+
         V9qLlmaZGfZgJzzlV3IrdtNNSsCIveWpNHIHk47RNynsQTF3qekHBHhkkea3VeKbqI
         npKvByas9fLncH/Jb3HpRauhmFD9qmcBTZJlPh6H87Xx/VCu/gFkC6jKB3pRBoaY/s
         GRLtXK2fkET7/ylWbDOkKySg/iGNcSASu0PS9GFKghmzzYSMPpHwMOKI+e64QTK41N
         sginJB6z3UdzzmhWGqjqEKjtidpEDzmRtDRLQ+LuJanu7CJuSjauhC0xG/r/9ymwow
         +Ll/htbcZAErg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 851ACC595C1;
        Sun, 23 Jul 2023 10:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/6] Process connector bug fixes & enhancements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169010882253.17686.11040484082696320491.git-patchwork-notify@kernel.org>
Date:   Sun, 23 Jul 2023 10:40:22 +0000
References: <20230719201821.495037-1-anjali.k.kulkarni@oracle.com>
In-Reply-To: <20230719201821.495037-1-anjali.k.kulkarni@oracle.com>
To:     Anjali Kulkarni <Anjali.K.Kulkarni@oracle.com>
Cc:     davem@davemloft.net, Liam.Howlett@Oracle.com,
        akpm@linux-foundation.org, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        anjali.k.kulkarni@oracle.com
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
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jul 2023 13:18:15 -0700 you wrote:
> Oracle DB is trying to solve a performance overhead problem it has been
> facing for the past 10 years and using this patch series, we can fix this
> issue.
> 
> Oracle DB runs on a large scale with 100000s of short lived processes,
> starting up and exiting quickly. A process monitoring DB daemon which
> tracks and cleans up after processes that have died without a proper exit
> needs notifications only when a process died with a non-zero exit code
> (which should be rare).
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/6] netlink: Reverse the patch which removed filtering
    https://git.kernel.org/netdev/net-next/c/a3377386b564
  - [net-next,v10,2/6] netlink: Add new netlink_release function
    https://git.kernel.org/netdev/net-next/c/a4c9a56e6a2c
  - [net-next,v10,3/6] connector/cn_proc: Add filtering to fix some bugs
    https://git.kernel.org/netdev/net-next/c/2aa1f7a1f47c
  - [net-next,v10,4/6] connector/cn_proc: Performance improvements
    https://git.kernel.org/netdev/net-next/c/743acf351bae
  - [net-next,v10,5/6] connector/cn_proc: Allow non-root users access
    https://git.kernel.org/netdev/net-next/c/bfdfdc2f3b70
  - [net-next,v10,6/6] connector/cn_proc: Selftest for proc connector
    https://git.kernel.org/netdev/net-next/c/73a29531f45f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


