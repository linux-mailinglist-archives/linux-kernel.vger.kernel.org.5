Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569E17660B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjG1AUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG1AUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CCBF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F8F561F91
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83997C433C8;
        Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690503620;
        bh=Bhb6/QjHl3pEpohK1LtERgTU5IfD+lbygJdn6oIMc+o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tOtpyQU288Xh5mpfKrnOyaUEIM0SCbOcQgW4qpHyNFyidsaeItk6OE29vI9yGbWmX
         96QRld2stXddj3L5G7yiAxilsfinDEBGKhMTJBzY89o90ohl/BL4zqaNzrupch5eaO
         4ROsvtuN4msPPRL4GPbH6h+zuvFq5zD70ORmWfAb3mAWDddy4E7hT+R/3SMg7AQlFk
         runwkL8o5YZjOBkyk0viLbs4sL48x4ampgqcFcIn84dzomXCA67pK3L0pBWVMSRk9Y
         CDzEHZN+4yYIZyc27GFvmh79k7N8nskDAuyh1IhpFgKYWjddxaGLU/Vfk2pOYQK0ZU
         4KsLmtEhSlJ/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BF70C41672;
        Fri, 28 Jul 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169050362043.24970.11385005356994975493.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 00:20:20 +0000
References: <20230726075314.1059224-1-linma@zju.edu.cn>
In-Reply-To: <20230726075314.1059224-1-linma@zju.edu.cn>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
        lucien.xin@gmail.com, liuhangbin@gmail.com,
        edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 26 Jul 2023 15:53:14 +0800 you wrote:
> There are totally 9 ndo_bridge_setlink handlers in the current kernel,
> which are 1) bnxt_bridge_setlink, 2) be_ndo_bridge_setlink 3)
> i40e_ndo_bridge_setlink 4) ice_bridge_setlink 5)
> ixgbe_ndo_bridge_setlink 6) mlx5e_bridge_setlink 7)
> nfp_net_bridge_setlink 8) qeth_l2_bridge_setlink 9) br_setlink.
> 
> By investigating the code, we find that 1-7 parse and use nlattr
> IFLA_BRIDGE_MODE but 3 and 4 forget to do the nla_len check. This can
> lead to an out-of-attribute read and allow a malformed nlattr (e.g.,
> length 0) to be viewed as a 2 byte integer.
> 
> [...]

Here is the summary with links:
  - [net,v3] rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
    https://git.kernel.org/netdev/net/c/d73ef2d69c0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


