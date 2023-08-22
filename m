Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D61783E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjHVKuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHVKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA147BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46F0A651AD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DC2AC433C9;
        Tue, 22 Aug 2023 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692701422;
        bh=CH4qI6lnmD8k/tSVu+AnqbRi0a34eJdMTltkb/mszUs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i4N/ZSZk6ryQekpxHYWZ6dph6GenS542CIK3x/0WkX7n5vw9MgjzMaq5Ovx7bDQ+a
         Vwhz305q7nFkc4Mrfnk7BDg31qlu8kc6mGiV43HiUapHeVrnwmjCpJfaSiAVD8V+TN
         hWNHGkzd76x+B8GceNwzBzseRB41tAm8hJ0Ekh32vcZPezzBieWgdeBYYCXxGw0Epr
         tZFmt878V5+NaDQxcOz7wzpKO2dBZXdLaVIgmE7sP2A12TJBrT1HZW5Sxs3Rp3srwo
         BDrSBnBfVKlen6g43YQ1ib4qR88GgBuopSEsSJU8/qlQa1dKg/xjS38CoHV7X6yzdC
         /rplZtS+bW7WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4265EE21ECD;
        Tue, 22 Aug 2023 10:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] alx: fix OOB-read compiler warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169270142226.5727.3369298753541384409.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Aug 2023 10:50:22 +0000
References: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230821013218.1614265-1-gongruiqi@huaweicloud.com>
To:     GONG@ci.codeaurora.org, Ruiqi <gongruiqi@huaweicloud.com>
Cc:     chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, gustavoars@kernel.org, gongruiqi1@huawei.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Aug 2023 09:32:18 +0800 you wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> The following message shows up when compiling with W=1:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘alx_get_ethtool_stats’ at drivers/net/ethernet/atheros/alx/ethtool.c:297:2:
> ./include/linux/fortify-string.h:592:4: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |    __read_overflow2_field(q_size_field, size);
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] alx: fix OOB-read compiler warning
    https://git.kernel.org/netdev/net-next/c/3a198c95c95d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


