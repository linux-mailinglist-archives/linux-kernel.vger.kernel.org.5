Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF97E9ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjKMLKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjKMLK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:10:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6810E3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:10:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96D49C433CA;
        Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699873824;
        bh=Z3fpOI3dRNpV1WEWVhwQpK14RGQjDZBGTALBjV5IbJk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a5F5WHujSBrpNhOgle5/MwCMN9SlHdGh3aiNufQufzLHW3hSlxjdQfA+1dN0kYk5Q
         OdjXLg2WIgheskWYISr4JDcO85EIwIQ191Y//UiG01C20NWzmZDdpkMsQ4Wd8TlWTY
         +6+ez14DvZVbx/mtjagRe4OUCFzmTcbgbM/4CC8xoIHdT1VrSaf+37I00+AUshxxJi
         9uDJn7RqeQ8E5sB4VUih+B2mn2eF0gf/M9Uu3KNaPt9MyE13/tNQyB6IzmuvBrb+//
         atVFYqv6UFEUALtHG+w0YBw8PaPwHW19Gv/KArpOkd2CYEpOzQE/wMIsjMy6F7Dp2A
         XpKS9/Lt9JwiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72243E32713;
        Mon, 13 Nov 2023 11:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: Fix kernel-infoleak due to uninitialized TLV value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169987382446.356.7864924511741538484.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 11:10:24 +0000
References: <20231110163947.1605168-1-syoshida@redhat.com>
In-Reply-To: <20231110163947.1605168-1-syoshida@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Sat, 11 Nov 2023 01:39:47 +0900 you wrote:
> KMSAN reported the following kernel-infoleak issue:
> 
> =====================================================
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
> BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  copy_to_user_iter lib/iov_iter.c:24 [inline]
>  iterate_ubuf include/linux/iov_iter.h:29 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
>  iterate_and_advance include/linux/iov_iter.h:271 [inline]
>  _copy_to_iter+0x4ec/0x2bc0 lib/iov_iter.c:186
>  copy_to_iter include/linux/uio.h:197 [inline]
>  simple_copy_to_iter net/core/datagram.c:532 [inline]
>  __skb_datagram_iter.5+0x148/0xe30 net/core/datagram.c:420
>  skb_copy_datagram_iter+0x52/0x210 net/core/datagram.c:546
>  skb_copy_datagram_msg include/linux/skbuff.h:3960 [inline]
>  netlink_recvmsg+0x43d/0x1630 net/netlink/af_netlink.c:1967
>  sock_recvmsg_nosec net/socket.c:1044 [inline]
>  sock_recvmsg net/socket.c:1066 [inline]
>  __sys_recvfrom+0x476/0x860 net/socket.c:2246
>  __do_sys_recvfrom net/socket.c:2264 [inline]
>  __se_sys_recvfrom net/socket.c:2260 [inline]
>  __x64_sys_recvfrom+0x130/0x200 net/socket.c:2260
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net] tipc: Fix kernel-infoleak due to uninitialized TLV value
    https://git.kernel.org/netdev/net/c/fb317eb23b5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


