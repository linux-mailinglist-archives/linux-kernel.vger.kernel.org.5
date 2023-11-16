Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E727EE90F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbjKPWA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKPWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA6181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F081DC433C9;
        Thu, 16 Nov 2023 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700172024;
        bh=yQtv/XbeQj4ZiMdGFmNSnpGWxcBjcfX/juK7/JFBKlw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nKPAIER1c8hQuaYq4S687FCejIoc2s8Ev3RokPfqDQrNybJtrlJ+0ga2kxYr9xIGF
         SCA5ZiXM6IXyfQvIMfbMYLnbhO/Q7bgoWfw2vd2KLBlJq0g7kxmILwwbk1pjW3zBLf
         5BKRP5hNbggkUi+eO7jq/wbVZiZ7zebtGYLtGZS42iV1aatEe3p2i/7FVO/XL18CPM
         boAXxN9bPUnvIXPbovdOF+hLjultY5sun+/+u5pDwy6EIK8PzQF5pRt813JCyVBb9w
         sLIgLVLeSLoQVIl0yS8z5fI+FGRIu6j3vATImFVyG5fYwO3QRdJkvwPuP/5LMXXp9c
         Q7pcjY+1ORl6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4DF8C395F0;
        Thu, 16 Nov 2023 22:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 RESEND 0/4] Cleanup and optimizations to transmit
 code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170017202386.32455.7477139166082285049.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Nov 2023 22:00:23 +0000
References: <20231114134535.2455051-1-srasheed@marvell.com>
In-Reply-To: <20231114134535.2455051-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 05:45:31 -0800 you wrote:
> Pad small packets to ETH_ZLEN before transmit, cleanup dma sync calls,
> add xmit_more functionality and then further remove atomic
> variable usage in the prior.
> 
> Changes:
> V3:
>   - Stop returning NETDEV_TX_BUSY when ring is full in xmit_patch.
>     Change to inspect early if next packet can fit in ring instead of
>     current packet, and stop queue if not.
>   - Add smp_mb between stopping tx queue and checking if tx queue has
>     free entries again, in queue full check function to let reflect
>     IQ process completions that might have happened on other cpus.
>   - Update small packet padding patch changelog to give more info.
> V2: https://lore.kernel.org/all/20231024145119.2366588-1-srasheed@marvell.com/
>   - Added patch for padding small packets to ETH_ZLEN, part of
>     optimization patches for transmit code missed out in V1
>   - Updated changelog to provide more details for dma_sync remove patch
>   - Updated changelog to use imperative tone in add xmit_more patch
> V1: https://lore.kernel.org/all/20231023114449.2362147-1-srasheed@marvell.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v3,RESEND,1/4] octeon_ep: add padding for small packets
    https://git.kernel.org/netdev/net-next/c/5827fe2bc9c4
  - [net-next,v3,RESEND,2/4] octeon_ep: remove dma sync in trasmit path
    https://git.kernel.org/netdev/net-next/c/2fba5069959c
  - [net-next,v3,RESEND,3/4] octeon_ep: implement xmit_more in transmit
    https://git.kernel.org/netdev/net-next/c/373d9a55ba74
  - [net-next,v3,RESEND,4/4] octeon_ep: remove atomic variable usage in Tx data path
    https://git.kernel.org/netdev/net-next/c/dc9c02b7faa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


