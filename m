Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BEF7BA70C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjJEQr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjJEQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:46:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4037F2707;
        Thu,  5 Oct 2023 09:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95214C433CA;
        Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524025;
        bh=o7kiTe0OXPEOLZf74e9pOzyCSg3hSTh4aw0DUkNUZK8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Rw9sF5G5dpA34C4+BwnzaHUbjEuNXTaFeNYAgR4b0/NERJITwSmOUoCiK8GkFKpt9
         wNNjkxKkE/snQEGCnuLKYQ8TX6xH2K+zeV5uBliupFN1Q2047ym5laAJlfADte69Xi
         tLnpXb8E0k+7+hAW2Kx6LtGH1tv5s2ahMcT+4KOUu/Z4EONGeHGdvCiGvIXmRdesB6
         qHm+61eb3b7eVVmxPAR4FxUoo+pXMkcYOd+ekY3Ts0vAm89hgX2k0dsAhKrG6RnQSj
         W+rGrnqyKXuVqU2pY9FGfb+Wc1ySbb7aMpErR7qn4S0Ond3pU+dO6ApMfOa5V2fiLR
         ioWa40CXbrVvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73685E632D7;
        Thu,  5 Oct 2023 16:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: remove unneeded stmmac_poll_controller
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169652402546.29548.6404027864255533481.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 16:40:25 +0000
References: <1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt>
In-Reply-To: <1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Oct 2023 16:33:56 +0200 you wrote:
> Using netconsole netpoll_poll_dev could be called from interrupt
> context, thus using disable_irq() would cause the following kernel
> warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:
> 
>   BUG: sleeping function called from invalid context at kernel/irq/manage.c:137
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 10, name: ksoftirqd/0
>   CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W         5.15.42-00075-g816b502b2298-dirty #117
>   Hardware name: aml (r1) (DT)
>   Call trace:
>    dump_backtrace+0x0/0x270
>    show_stack+0x14/0x20
>    dump_stack_lvl+0x8c/0xac
>    dump_stack+0x18/0x30
>    ___might_sleep+0x150/0x194
>    __might_sleep+0x64/0xbc
>    synchronize_irq+0x8c/0x150
>    disable_irq+0x2c/0x40
>    stmmac_poll_controller+0x140/0x1a0
>    netpoll_poll_dev+0x6c/0x220
>    netpoll_send_skb+0x308/0x390
>    netpoll_send_udp+0x418/0x760
>    write_msg+0x118/0x140 [netconsole]
>    console_unlock+0x404/0x500
>    vprintk_emit+0x118/0x250
>    dev_vprintk_emit+0x19c/0x1cc
>    dev_printk_emit+0x90/0xa8
>    __dev_printk+0x78/0x9c
>    _dev_warn+0xa4/0xbc
>    ath10k_warn+0xe8/0xf0 [ath10k_core]
>    ath10k_htt_txrx_compl_task+0x790/0x7fc [ath10k_core]
>    ath10k_pci_napi_poll+0x98/0x1f4 [ath10k_pci]
>    __napi_poll+0x58/0x1f4
>    net_rx_action+0x504/0x590
>    _stext+0x1b8/0x418
>    run_ksoftirqd+0x74/0xa4
>    smpboot_thread_fn+0x210/0x3c0
>    kthread+0x1fc/0x210
>    ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: remove unneeded stmmac_poll_controller
    https://git.kernel.org/netdev/net/c/3eef85558910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


