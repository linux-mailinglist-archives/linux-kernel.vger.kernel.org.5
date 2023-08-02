Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C664176C99B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjHBJkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjHBJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68090E5C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1FDD6188A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC47C433C8;
        Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690969221;
        bh=bPpUbVJ8g+WfRXA8L/dbqhku1vmPtOZ22exFereT1AY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QSUj/c162+ie7S9gfe/Fu3ASh4GC3YpdvAnXOx3ZsC42Nt4cTDfEgb7VeOLUrOkop
         2NbM1KfuEKAMsYLgC5OOmVGbpAkqT78slxmulP6ZxqmMBfHPbnCYev1gXKOsyLCE3O
         GeNBu3cGCyOkoigjeUJ8/MxW8lYFoLp/dMjC1Mhjzhi6owotvM6IanGFKXnHgsSnc+
         fbFyqxKdWDgU62pjiRd2Y7p3oqJpC3JIrW528C7YtqzSBf6HhvUzNeM/mYjGrg3xur
         Q1TU4ItxSMM0uZX8AxCfP53MYPc1oFBf8hy9iw4pppS0hharQj2CQJnDhlEKNPg5Gb
         CxL+V4Io9D8jQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34B11C6445A;
        Wed,  2 Aug 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169096922121.16759.10593210308395776255.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 09:40:21 +0000
References: <20230801064318.34408-1-yuehaibing@huawei.com>
In-Reply-To: <20230801064318.34408-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        simon.horman@corigine.com
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
by David S. Miller <davem@davemloft.net>:

On Tue, 1 Aug 2023 14:43:18 +0800 you wrote:
> skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
>  head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6reg
>  ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:192!
>  invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>  CPU: 2 PID: 22968 Comm: kworker/2:11 Not tainted 6.5.0-rc3-00044-g0a8db05b571a #236
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  Workqueue: ipv6_addrconf addrconf_dad_work
>  RIP: 0010:skb_panic+0x152/0x1d0
>  Call Trace:
>   <TASK>
>   skb_push+0xc4/0xe0
>   ip6mr_cache_report+0xd69/0x19b0
>   reg_vif_xmit+0x406/0x690
>   dev_hard_start_xmit+0x17e/0x6e0
>   __dev_queue_xmit+0x2d6a/0x3d20
>   vlan_dev_hard_start_xmit+0x3ab/0x5c0
>   dev_hard_start_xmit+0x17e/0x6e0
>   __dev_queue_xmit+0x2d6a/0x3d20
>   neigh_connected_output+0x3ed/0x570
>   ip6_finish_output2+0x5b5/0x1950
>   ip6_finish_output+0x693/0x11c0
>   ip6_output+0x24b/0x880
>   NF_HOOK.constprop.0+0xfd/0x530
>   ndisc_send_skb+0x9db/0x1400
>   ndisc_send_rs+0x12a/0x6c0
>   addrconf_dad_completed+0x3c9/0xea0
>   addrconf_dad_work+0x849/0x1420
>   process_one_work+0xa22/0x16e0
>   worker_thread+0x679/0x10c0
>   ret_from_fork+0x28/0x60
>   ret_from_fork_asm+0x11/0x20
> 
> [...]

Here is the summary with links:
  - [v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
    https://git.kernel.org/netdev/net/c/30e0191b16e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


