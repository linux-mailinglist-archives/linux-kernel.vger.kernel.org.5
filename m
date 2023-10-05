Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276C77BA1AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjJEOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbjJEOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82922AD14;
        Thu,  5 Oct 2023 07:12:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1559C3278F;
        Thu,  5 Oct 2023 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696506241;
        bh=9S3XPaei5Hs4cBIZ21emTSZSs610PV4eDaKI5Q00L8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lrd+4GNYq6JYWhNiUPWJFO2CMFBR3kkJkrV24vDshQ2pi2sCFehGj90t00bX2kgOl
         duguPsgCc1M7yC/UFYzpoXpc8voUQi0/GqCr2Eo2MatQ84CpUH2QhKTAlQhcLdilry
         wejIeQCmTy5zXzs90zAEKXRw6ljLr4DvsvSifKBbsdddDOIkTFM/wMmkzlWBJsh3of
         Kx6wu6OF4FIT3i9PiFdRFHznTLCLbSq9jq4PZM3dDq2Vro2TRyKVuiVs0ijiIaQcVz
         WOKxRT1OIKo4OJIOWEamVVhDHiHTz4DzHFhMnCUq9yzY4jVXXaBbO1VFssgci6hy7Y
         JKEbE7J7kkIDw==
Date:   Thu, 5 Oct 2023 13:43:56 +0200
From:   Simon Horman <horms@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: stmmac: remove unneeded
 stmmac_poll_controller
Message-ID: <ZR6hfMSSbMvHozaM@kernel.org>
References: <1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 04:33:56PM +0200, Remi Pommarel wrote:
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
> Since [0] .ndo_poll_controller is only needed if driver doesn't or
> partially use NAPI. Because stmmac does so, stmmac_poll_controller
> can be removed fixing the above warning.
> 
> [0] commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> 
> Cc: <stable@vger.kernel.org> # 5.15.x
> Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Simon Horman <horms@kernel.org>

