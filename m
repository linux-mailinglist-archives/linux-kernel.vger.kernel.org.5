Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE504812564
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442876AbjLNCk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjLNCkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:40:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC29D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:40:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D069DC433C9;
        Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702521625;
        bh=rSEkVppOSVp3U7mpXX0xxO5F5GbcJeH95BX98axL9zM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rFDA+nr79uUVmdYCblim2LQ5fbwT3XnRdXogE8AvDQnm+k7OrvRkH2Rbe29VGWpae
         Y/9axyvLUG+ghDePPq10noq6MhY55hyvTq4uE+wI+D9NEMP1yLo/en9vXxMPtGb4lQ
         0Z2xMyhCTuZ3IBBImjLe8fw4fXsfvfHwPiZY0JFfTpgP4a1eOaHXnivjT1fUstzfV8
         PeDvs30MfTA1hhvXeQJvsc+UBA/T3FxBxDKZ+fD7gJzW+PQu0sfJ2WACmuQ1CryHZY
         8OavsAeJLQNUONK1tRLNMPe6twMtApLgzT/EkNiN4amkyO5kVLbcJOQLq8mrcT4p/C
         kjJJCC9BE4mDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B43C6C4314C;
        Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cxgb3: Avoid potential string truncation in desc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170252162573.2494.15854060448020289393.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 02:40:25 +0000
References: <20231212220954.work.219-kees@kernel.org>
In-Reply-To: <20231212220954.work.219-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     rajur@chelsio.com, lkp@intel.com, davem@davemloft.net,
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

On Tue, 12 Dec 2023 14:09:57 -0800 you wrote:
> Builds with W=1 were warning about potential string truncations:
> 
> drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c: In function 'cxgb_up':
> drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
>   394 |                                  "%s-%d", d->name, pi->first_qset + i);
>       |                                      ^~
> In function 'name_msix_vecs',
>     inlined from 'cxgb_up' at drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:1264:3: drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:34: note: directive argument in the range [-2147483641, 509]
>   394 |                                  "%s-%d", d->name, pi->first_qset + i);
>       |                                  ^~~~~~~
> drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:393:25: note: 'snprintf' output between 3 and 28 bytes into a destination of size 21
>   393 |                         snprintf(adap->msix_info[msi_idx].desc, n,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   394 |                                  "%s-%d", d->name, pi->first_qset + i);
>       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - cxgb3: Avoid potential string truncation in desc
    https://git.kernel.org/netdev/net-next/c/bc044ae9d64b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


