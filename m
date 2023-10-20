Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912177D0F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377296AbjJTMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376985AbjJTMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25DD41
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DAADC433C9;
        Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697803224;
        bh=D15z/0oXu2m7VQo8gW5F0wjdgIyPA8e7yZ0xj2+0Uyk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hoDopc0f1NLUT57g6ES2s/mq+umUbqZ/Y9WmVSY/HnUxiNIedEEBPS+Kvlijd9Vg3
         XiLydu3tu1WNn/ta40S81xTHKSI6owh1luCzUJtm913hjm+6J6KvgfaPeD/efjc/yX
         P8AvqAueblWnO8vXmrxN0VwDvgDcjSrw+LxvOsZeqj9YVPx38eEyk8n2+M+Oqz/sfq
         aYgSy+1DaN7fC3YaD1OICgWmkURBvgtvKmc6d4Y1r96eCbOIuB1lRY85p9z/IKtxFX
         uSWwMSFp/Ji+f6aNRi1ghvOUGRpkV5i5l2AS3cyx9qYzhaOj9It1ZuRCMAPvJ2yrgx
         wnSpSYkeCI9Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FDFCC595D7;
        Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169780322412.10600.10310001607168170468.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Oct 2023 12:00:24 +0000
References: <20231019163721.1333370-1-ivecera@redhat.com>
In-Reply-To: <20231019163721.1333370-1-ivecera@redhat.com>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, mateusz.palczewski@intel.com,
        horms@kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        przemyslawx.patynowski@intel.com, sylwesterx.dziedziuch@intel.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Oct 2023 18:37:20 +0200 you wrote:
> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
> 
> Move the affected flag at the end of the flags and fix its value.
> 
> Reproducer:
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close on
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning on
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off
> [ 6323.142585] i40e 0000:02:00.0: Setting link-down-on-close not supported on this port (because total-port-shutdown is enabled)
> netlink error: Operation not supported
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning off
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off
> 
> [...]

Here is the summary with links:
  - [net,v2] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
    https://git.kernel.org/netdev/net/c/665e7d83c538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


