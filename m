Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A517DEC8A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjKBFvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKBFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB29111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:51:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98888C433C7;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698904287;
        bh=ePuA2E+M2ze3bneVSj4fEfaXiR+gheT10c1MUna1k4k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I1DKipOT1JFtqHxqXbq3hVkslk5vbz/9pJfoOuzKmxVLlccrKBvfLuObysTiouFVm
         hiCXQLWVxAR2GSY4olMQOqGpbcWaWNJMOjP3hBQh0zHyHpPtFvQsV8t6s9nm9gGuxg
         nmTr7P5s+3fSz0sFa55XClg0mJ65sEOSewN93IS4v4K588gkMhC/H+RiVT7OZRKwpJ
         m9FHjm/As3cwNGt//LPjJastWPKKgpdY4pl56H8gJg9VLtSkWvtQY5+0IVYlXA4hrs
         xW6LMzyc2sUm5EmImTgrMYZKfUGfUoQgDLSteRIRV0D06+9G5LqHSRpSiVSRWIr4LC
         n1QptOxRqDGNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76491C43168;
        Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tipc: Change nla_policy for bearer-related names to
 NLA_NUL_STRING
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169890428747.30377.3228874789339352115.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 05:51:27 +0000
References: <20231030075540.3784537-1-syoshida@redhat.com>
In-Reply-To: <20231030075540.3784537-1-syoshida@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5138ca807af9d2b42574@syzkaller.appspotmail.com,
        syzbot+9425c47dccbcb4c17d51@syzkaller.appspotmail.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Mon, 30 Oct 2023 16:55:40 +0900 you wrote:
> syzbot reported the following uninit-value access issue [1]:
> 
> =====================================================
> BUG: KMSAN: uninit-value in strlen lib/string.c:418 [inline]
> BUG: KMSAN: uninit-value in strstr+0xb8/0x2f0 lib/string.c:756
>  strlen lib/string.c:418 [inline]
>  strstr+0xb8/0x2f0 lib/string.c:756
>  tipc_nl_node_reset_link_stats+0x3ea/0xb50 net/tipc/node.c:2595
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:971 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1051 [inline]
>  genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1066
>  netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1075
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  sock_sendmsg net/socket.c:753 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2541
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2595
>  __sys_sendmsg net/socket.c:2624 [inline]
>  __do_sys_sendmsg net/socket.c:2633 [inline]
>  __se_sys_sendmsg net/socket.c:2631 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2631
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Here is the summary with links:
  - [net,v3] tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
    https://git.kernel.org/netdev/net/c/19b3f72a41a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


