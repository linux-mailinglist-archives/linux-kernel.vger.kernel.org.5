Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2679F76F17D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHCSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjHCSKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A93C25
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E331D61E57
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A43CC433CB;
        Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086228;
        bh=zrPIRxFjq0KdaitqvNccDNu+R+Bux2zXtbmruB/8WmU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sBPGKDZYUjAozVrFwwCu+ghQp9b/5LXqVYfRPZBAsEqPXyb1WywfttbuMD4fhet1W
         HPQeXtgqBB1UnZbgKFcmKXHppdUXqt8s9+aBf3uJY23aQdIUwE756PizAGZrgs7yU/
         n787027yvd7SF7lyw12VK4oG8F+odPmgMxpuPcrAma3ObKO4z5LjGuJg/g8+eipBzl
         SItACUN7fTBpzDlnwm1mMdmU+uOM6S0VpFv22nYhFLGQ/Psc1Urbk+3Jhk+qbd2u1Y
         x0MRVUEqnAIa2eupDTJxkeucM0L3gBVXkvQmVq/5mMV082XtwCr8XfVylph2xD3XzU
         cAFr75qQm5wmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 298C0C595C2;
        Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] prestera: fix fallback to previous version on same major
 version
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169108622816.23543.13453786898223633114.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 18:10:28 +0000
References: <20230802092357.163944-1-jonas.gorski@bisdn.de>
In-Reply-To: <20230802092357.163944-1-jonas.gorski@bisdn.de>
To:     Jonas Gorski <jonas.gorski@bisdn.de>
Cc:     taras.chornyi@plvision.eu, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew@lunn.ch, vkochan@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Aug 2023 11:23:56 +0200 you wrote:
> When both supported and previous version have the same major version,
> and the firmwares are missing, the driver ends in a loop requesting the
> same (previous) version over and over again:
> 
>     [   76.327413] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.1.img firmware, fall-back to previous 4.0 version
>     [   76.339802] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.352162] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.364502] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.376848] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.389183] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.401522] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.413860] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     [   76.426199] Prestera DX 0000:01:00.0: missing latest mrvl/prestera/mvsw_prestera_fw-v4.0.img firmware, fall-back to previous 4.0 version
>     ...
> 
> [...]

Here is the summary with links:
  - prestera: fix fallback to previous version on same major version
    https://git.kernel.org/netdev/net/c/b755c25fbcd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


