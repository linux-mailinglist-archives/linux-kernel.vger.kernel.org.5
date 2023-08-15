Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988C777D552
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbjHOVlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbjHOVki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D1A1FD4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D1464A58
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 21:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6DB2C433CA;
        Tue, 15 Aug 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692135624;
        bh=/bWGDQI0tm0gMzYgGACwqNFcJi1YggVNzpHDJbmiBZw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k0ULCpGSHhlcH/jVqQveUbqW3VVAfNchO7aVRfjlWWK2U7FTXozSN35/9DzICKoKR
         LPS342DeZS4rieCPcMuFWquonoPQXwFyo7bI1Ct26TTgynP8XfLx/4bgZz0QjzmFsd
         bwBTWCYPoyBaPgHm69yJyWH5brU+qLRgF43vmyWaGrxdSLQEQ3wQKqtglCUrITA0vU
         wrw+SVtsL0CDcPQjSSpCBTzES+D+49Y0t7KT0Ib2qPCt38aJ7Ho0Oy40L0qG8ZbrTo
         xSLvBoy+gXNBLuHJhCB4iIUkIUQ8dMPpUH803SySY4H4vNZF9ZOmKzVcG/lGl0HTSn
         ZqXDIrd6XGseA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD4A6E93B37;
        Tue, 15 Aug 2023 21:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] net: Fix slab-out-of-bounds in
 inet[6]_steal_sock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169213562383.15576.3157581774148181550.git-patchwork-notify@kernel.org>
Date:   Tue, 15 Aug 2023 21:40:23 +0000
References: <20230815-bpf-next-v2-1-95126eaa4c1b@isovalent.com>
In-Reply-To: <20230815-bpf-next-v2-1-95126eaa4c1b@isovalent.com>
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, daniel@iogearbox.net, kuniyu@amazon.com,
        martin.lau@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, memxor@gmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 15 Aug 2023 09:53:41 +0100 you wrote:
> Kumar reported a KASAN splat in tcp_v6_rcv:
> 
>   bash-5.2# ./test_progs -t btf_skc_cls_ingress
>   ...
>   [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
>   [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] net: Fix slab-out-of-bounds in inet[6]_steal_sock
    https://git.kernel.org/bpf/bpf-next/c/8897562f67b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


