Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE0785336
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjHWI4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjHWIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431B11988
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C62FF6582A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0429AC433C7;
        Wed, 23 Aug 2023 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692780622;
        bh=pxRRnBzDZ/2vYB1cFW0TTmq3bLH+DeXMv2KfeXWwJf8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VmAvzXFhpwawFU4vjFJQSFafE84E+weJiH5qvP6zdxyjDYHwQWSvPZZY/UojBZUDO
         NfjsNa6Ctlo6frS61P++kCCwofa+7BDrdTl7iDbuP4vvf2auxHpklSxCgXkt07ESaX
         ZQ7kmyjNCUuQZAw8h9NVCfyCsoggqRaDqWfN7POjN2DEWxe/sbzUHumBX+jY3XlC0p
         rC+OP3tjI05wBVpTZhg7IgKyZdyH16gYG2Nfbt41o+x50dSACfH9lpN8PoYsdXsIZU
         SyBjfQ/s2etOJizTvM2jb8kAZOhIhpu6Aip754WjckMyTKgXhIH3tbysa/YWoTxbhc
         ZZFeFKOT+m81Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA54AE21ED3;
        Wed, 23 Aug 2023 08:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net/sched: fix a qdisc modification with ambiguous
 command request
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169278062189.13745.3034926060241116473.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 08:50:21 +0000
References: <20230822101231.74388-1-jhs@mojatatu.com>
In-Reply-To: <20230822101231.74388-1-jhs@mojatatu.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
        xiyou.wangcong@gmail.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, shaozhengchao@huawei.com,
        syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com,
        vladimir.oltean@nxp.com, victor@mojatatu.com,
        pctammela@mojatatu.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 22 Aug 2023 06:12:31 -0400 you wrote:
> When replacing an existing root qdisc, with one that is of the same kind, the
> request boils down to essentially a parameterization change  i.e not one that
> requires allocation and grafting of a new qdisc. syzbot was able to create a
> scenario which resulted in a taprio qdisc replacing an existing taprio qdisc
> with a combination of NLM_F_CREATE, NLM_F_REPLACE and NLM_F_EXCL leading to
> create and graft scenario.
> The fix ensures that only when the qdisc kinds are different that we should
> allow a create and graft, otherwise it goes into the "change" codepath.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net/sched: fix a qdisc modification with ambiguous command request
    https://git.kernel.org/netdev/net/c/da71714e359b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


