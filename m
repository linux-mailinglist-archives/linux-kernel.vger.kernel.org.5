Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BCD808FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443700AbjLGSUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443634AbjLGSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:20:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCD1704
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:20:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E35F0C433C9;
        Thu,  7 Dec 2023 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701973229;
        bh=0KcANSyv1sr9UhGc/vinHfJbi1QB9ETNOHuMpKsQkMk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WolHTfrnuD59oo7UIECAYiJGuyiZL+9nfNxgrnrVMoUaQt1DvlLzpFIeeXZmOXihU
         7Ins/SIsy8rBda6rEfMi5kztLjQEtxOlxLUA/6qDs42rW2CPVNSs480pWBmyWbMBCC
         TwGraVPrfqxWyWaoKTyVKw9el7oY/GnONTQ/Y9PAkNF0kA0a2zQKiVPNq4Jr/drr9W
         GeBAPNWNmf2TdBKPpH0tp7sE+9D+LEXamJuNPb5bDe7+9hMVVPW0fIzDO408bR1ctJ
         2Qu43EG3IZdqdfu5YlrDakPNMfAQb4vvKQEcPHXXr1IsP4USVTFd/vbxeGNeQCsK2/
         r6VxGwAoK6WUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC0C0C4314C;
        Thu,  7 Dec 2023 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix "comparison of distinct pointer types
 lacks a cast" warning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170197322883.20147.5857598481880040072.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Dec 2023 18:20:28 +0000
References: <20231206164143.281107-1-sgarzare@redhat.com>
In-Reply-To: <20231206164143.281107-1-sgarzare@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        virtualization@lists.linux.dev, mst@redhat.com,
        avkrasnov@salutedevices.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanha@redhat.com,
        edumazet@google.com, pabeni@redhat.com
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

On Wed,  6 Dec 2023 17:41:43 +0100 you wrote:
> After backporting commit 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY
> flag support") in CentOS Stream 9, CI reported the following error:
> 
>     In file included from ./include/linux/kernel.h:17,
>                      from ./include/linux/list.h:9,
>                      from ./include/linux/preempt.h:11,
>                      from ./include/linux/spinlock.h:56,
>                      from net/vmw_vsock/virtio_transport_common.c:9:
>     net/vmw_vsock/virtio_transport_common.c: In function ‘virtio_transport_can_zcopy‘:
>     ./include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast [-Werror]
>        20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>           |                                   ^~
>     ./include/linux/minmax.h:26:18: note: in expansion of macro ‘__typecheck‘
>        26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>           |                  ^~~~~~~~~~~
>     ./include/linux/minmax.h:36:31: note: in expansion of macro ‘__safe_cmp‘
>        36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>           |                               ^~~~~~~~~~
>     ./include/linux/minmax.h:45:25: note: in expansion of macro ‘__careful_cmp‘
>        45 | #define min(x, y)       __careful_cmp(x, y, <)
>           |                         ^~~~~~~~~~~~~
>     net/vmw_vsock/virtio_transport_common.c:63:37: note: in expansion of macro ‘min‘
>        63 |                 int pages_to_send = min(pages_in_iov, MAX_SKB_FRAGS);
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix "comparison of distinct pointer types lacks a cast" warning
    https://git.kernel.org/netdev/net/c/b0a930e8d90c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


