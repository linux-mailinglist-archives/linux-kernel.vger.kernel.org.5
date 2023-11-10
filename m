Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6D7E80BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjKJSRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbjKJSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D562B7B1;
        Fri, 10 Nov 2023 03:10:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 259BBC433C9;
        Fri, 10 Nov 2023 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699614626;
        bh=VANhbifJBmxX82iSvi3j5Suzpz+UxaoUuMz9KrgLM4U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SO+khfQriRtIoMUpWGYD8eeQtg8JB6eVetLxcGWqxLQIJa74GHN2Ll6Os4T1Z/rMH
         8f9Njr02z9bnw55UQWDKi35POjwdLXLuG5yuahUr078ocdzaGdMtb5kOML/emN2J7Y
         J5dXmXtcCaCuxn9Tnc8JNwni3OIHG4rHcofzam7Ox8AQBaPCzBXFYPV1qW4cUzro3+
         Zn0vOLZrb9EZlfb7qQcL0AY4Dx81CZOx2PaT2d1pbypV2KGZnQa7z7o/t99vHFhOPI
         MKc1bh5/gqbaavxe/08I1dPvZoyY/qVqFqIMLRHB+aIOCYhCdChg0Q8+vjKfttWA/S
         6hCD+xXpzhRgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D993E00084;
        Fri, 10 Nov 2023 11:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tty: Fix uninit-value access in ppp_sync_receive()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169961462605.23529.6945068344166343230.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Nov 2023 11:10:26 +0000
References: <20231108154420.1474853-1-syoshida@redhat.com>
In-Reply-To: <20231108154420.1474853-1-syoshida@redhat.com>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  9 Nov 2023 00:44:20 +0900 you wrote:
> KMSAN reported the following uninit-value access issue:
> 
> =====================================================
> BUG: KMSAN: uninit-value in ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
> BUG: KMSAN: uninit-value in ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
>  ppp_sync_input drivers/net/ppp/ppp_synctty.c:690 [inline]
>  ppp_sync_receive+0xdc9/0xe70 drivers/net/ppp/ppp_synctty.c:334
>  tiocsti+0x328/0x450 drivers/tty/tty_io.c:2295
>  tty_ioctl+0x808/0x1920 drivers/tty/tty_io.c:2694
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:871 [inline]
>  __se_sys_ioctl+0x211/0x400 fs/ioctl.c:857
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net] tty: Fix uninit-value access in ppp_sync_receive()
    https://git.kernel.org/netdev/net/c/719639853d88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


