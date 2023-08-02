Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75B676C3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjHBEK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjHBEKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6425FED
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3CF061796
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28FC5C433C7;
        Wed,  2 Aug 2023 04:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690949421;
        bh=gY+pFREnHGNaE3/T5rj7xb/LfgIc84catNrHdsvr+7Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WKCixldlRqyOGg5lbuv0ot0pX0c5JM0TwyqK07pSy/7ia00TxxUbkXDq+i8vA2qFo
         0bJDW/HaQSLSfZIzGfAhCWh104t0WcTUE1/zSMu28Zp5ggSQ430BgAmRDMggPPtgqd
         IDLxHopbANLx9KR4Lwv2pR8hfykEuDNd4VOoMyiIO9G/iEmrah+hx3WR984sNnd6Vm
         7Ul6JTFQZjyxYVUMRnZZF7VW9fb1nEFWgpBn3J/SvKb+TVLPxaFNqefN47m0oI1dNz
         dISMlqoR5sUb00G2beQsSbl27Atq3qZ3uURwTUobyalBAPQAx5+nhuk5ihF/EIPueJ
         L6A2yXcQ16x+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D1BDC691F0;
        Wed,  2 Aug 2023 04:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dcb: choose correct policy to parse DCB_ATTR_BCN
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169094942104.31458.13970223585358485274.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 04:10:21 +0000
References: <20230801013248.87240-1-linma@zju.edu.cn>
In-Reply-To: <20230801013248.87240-1-linma@zju.edu.cn>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, daniel.machon@microchip.com, petrm@nvidia.com,
        peter.p.waskiewicz.jr@intel.com, jeffrey.t.kirsher@intel.com,
        alexander.h.duyck@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        horms@kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Aug 2023 09:32:48 +0800 you wrote:
> The dcbnl_bcn_setcfg uses erroneous policy to parse tb[DCB_ATTR_BCN],
> which is introduced in commit 859ee3c43812 ("DCB: Add support for DCB
> BCN"). Please see the comment in below code
> 
> static int dcbnl_bcn_setcfg(...)
> {
>   ...
>   ret = nla_parse_nested_deprecated(..., dcbnl_pfc_up_nest, .. )
>   // !!! dcbnl_pfc_up_nest for attributes
>   //  DCB_PFC_UP_ATTR_0 to DCB_PFC_UP_ATTR_ALL in enum dcbnl_pfc_up_attrs
>   ...
>   for (i = DCB_BCN_ATTR_RP_0; i <= DCB_BCN_ATTR_RP_7; i++) {
>   // !!! DCB_BCN_ATTR_RP_0 to DCB_BCN_ATTR_RP_7 in enum dcbnl_bcn_attrs
>     ...
>     value_byte = nla_get_u8(data[i]);
>     ...
>   }
>   ...
>   for (i = DCB_BCN_ATTR_BCNA_0; i <= DCB_BCN_ATTR_RI; i++) {
>   // !!! DCB_BCN_ATTR_BCNA_0 to DCB_BCN_ATTR_RI in enum dcbnl_bcn_attrs
>   ...
>     value_int = nla_get_u32(data[i]);
>   ...
>   }
>   ...
> }
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dcb: choose correct policy to parse DCB_ATTR_BCN
    https://git.kernel.org/netdev/net/c/31d49ba03309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


