Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DD876E4ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHCJuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHCJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E7F2D72
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898AB61D28
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3011C433CA;
        Thu,  3 Aug 2023 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691056220;
        bh=5teddj2SN5uHH7Si3IIw2pyAJaD+T63Hwxfu9DgEaIw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jcjK8+6o+Bt0eL5T4UTMwErmFKD3og+MJ/jhFjWE/ceH3PYJn56d4zSgbKprnxigL
         I5BSPLypjS8Hscsg06NWdc/WffxROyC5HWHyJiHjbtCGds57XapIKG6640RDWRToZv
         vcddMEwzlMY+QPzQWeoEcFd39RR7T1G4D9SNrT6UxG1qYH6Pcgzn8QFVMYzm3C303T
         XNyGRF5iQ4S+VJsQPEYbC+jodebQR+w0D4FFaFnKJP6keneFqa1m4KOKAQYjlDETG/
         ozCotrUNcZuEDtvdH7srcaEc85DYqd1TvfTmf0SivxpF/dxeEzE60k9SgTj6Ot9Fnn
         VL/fsX0lxGsNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3E4FC43168;
        Thu,  3 Aug 2023 09:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ethernet: mtk_eth_soc: support per-flow
 accounting on MT7988
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169105622073.28699.8955916123146908854.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 09:50:20 +0000
References: <37a0928fa8c1253b197884c68ce1f54239421ac5.1690946442.git.daniel@makrotopia.org>
In-Reply-To: <37a0928fa8c1253b197884c68ce1f54239421ac5.1690946442.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
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

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 2 Aug 2023 04:31:09 +0100 you wrote:
> NETSYS_V3 uses 64 bits for each counters while older SoCs are using
> 48/40 bits for each counter.
> Support reading per-flow byte and package counters on NETSYS_V3.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: correct calculation, local variables
> v2: fix typo bytes_cnt_* -> byte_cnt_*
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ethernet: mtk_eth_soc: support per-flow accounting on MT7988
    https://git.kernel.org/netdev/net-next/c/571e9c496887

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


