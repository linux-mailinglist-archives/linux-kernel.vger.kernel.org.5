Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23A77366F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjHHCUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHHCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49BC198D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38BDE62358
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 02:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 886B7C433C9;
        Tue,  8 Aug 2023 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691461221;
        bh=kIyAQMukGXX9hkfOIlUbx01Y94cwkm21Uaczx4ozoPo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R4+Ff2oWweI6Pxzul5oURhFvP7LdJM1JFZBYoGuJL+we1MR4sM+t+WlNoG+wW2ZPw
         9SLsUtp4Jj+ZnHDT1LNtt3nud3r5ifP8IcUaHQwODJSzb0qIY9tFMSXmU4ZFmgyI5g
         ke2yztGbfb2aJglQPCwUB71T1bbUcO5PN05NZVX98wykp/Ovkx39SyKhdNCQSWJlga
         E1JOrcuBeMZjwmfFaPKxhLcY4dCTGrHTHMxArIY6PqE1+QKs1WA6RqIocVEiAZCS9T
         rZPlqmkaUEZRJ9eMI4nA+jblkgXqCTyoHGcL3uYb0MNB2gab1M4Sz4+3IYwJ2Ys1t/
         x1f4XgwtO8WJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DBA3E505D4;
        Tue,  8 Aug 2023 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 1/2] drivers: net: prevent tun_build_skb() to
 exceed the packet size limit
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169146122144.9822.6352423513613934358.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 02:20:21 +0000
References: <20230803185947.2379988-1-andrew.kanner@gmail.com>
In-Reply-To: <20230803185947.2379988-1-andrew.kanner@gmail.com>
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        hawk@kernel.org, jbrouer@redhat.com, dsahern@gmail.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 20:59:48 +0200 you wrote:
> Using the syzkaller repro with reduced packet size it was discovered
> that XDP_PACKET_HEADROOM is not checked in tun_can_build_skb(),
> although pad may be incremented in tun_build_skb(). This may end up
> with exceeding the PAGE_SIZE limit in tun_build_skb().
> 
> Jason Wang <jasowang@redhat.com> proposed to count XDP_PACKET_HEADROOM
> always (e.g. without rcu_access_pointer(tun->xdp_prog)) in
> tun_can_build_skb() since there's a window during which XDP program
> might be attached between tun_can_build_skb() and tun_build_skb().
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] drivers: net: prevent tun_build_skb() to exceed the packet size limit
    https://git.kernel.org/netdev/net/c/59eeb2329405
  - [net-next,v5,2/2] net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
    https://git.kernel.org/netdev/net/c/d14eea09edf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


