Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12483812562
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjLNCkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0AE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1CF0C43397;
        Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702521626;
        bh=oNpKOec2ST05tlPJgQy+n4kAfENZeKy96q0lzZpGODU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vCaIOPh3ZWESPnYdDezpTfrpwmDdcNZRZFpH0eHXcS5EhhXCO7sAi+tWSBPYoSEL3
         gY84e4pXgkQQG8jS+dkxmmjRfH1tgRSReIDYLj11u04PDM+a4qibNFZfJQKHVV4uEK
         3bgcL5Ah3BUX8Qn0OpMjUWz2objK5ramqrWajjxmPvsuHSBqZonWrz3ZuS6M/Lp6na
         wBuE0PThM09itqeOuBJDFyUXhgy4oRQtszmwRoQwCr8lyounilEvc0mZhvlKNWO/LI
         jQDQNAcqcWpYdiDZmwfHDJy6FQ7LsM4SzVft0co/2LdWUL9sqBk2Zi/hPiMHQKbOR4
         Qc1CG7uw7DRrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4B08DD4F15;
        Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] amd-xgbe: Avoid potential string truncation in name
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170252162586.2494.9298983108679557532.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 02:40:25 +0000
References: <20231212221312.work.830-kees@kernel.org>
In-Reply-To: <20231212221312.work.830-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shyam-sundar.S-k@amd.com, lkp@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 14:13:12 -0800 you wrote:
> Build with W=1 were warning about a potential string truncation:
> 
> drivers/net/ethernet/amd/xgbe/xgbe-drv.c: In function 'xgbe_alloc_channels':
> drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:73: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 8 [-Wformat-truncation=]
>   211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
>       |                                                                         ^~
> drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:64: note: directive argument in the range [0, 4294967294]
>   211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
>       |                                                                ^~~~~~~~~~~~
> drivers/net/ethernet/amd/xgbe/xgbe-drv.c:211:17: note: 'snprintf' output between 10 and 19 bytes into a destination of size 16
>   211 |                 snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - amd-xgbe: Avoid potential string truncation in name
    https://git.kernel.org/netdev/net-next/c/84cc99199a34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


