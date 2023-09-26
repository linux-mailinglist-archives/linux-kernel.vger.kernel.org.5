Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCB7AE98A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjIZJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIZJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:48:50 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEBFB3;
        Tue, 26 Sep 2023 02:48:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D60C6C0008;
        Tue, 26 Sep 2023 09:48:36 +0000 (UTC)
Date:   Tue, 26 Sep 2023 11:47:56 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: remove unneeded
 stmmac_poll_controller
Message-ID: <ZRKozLps8dmDmQgc@pilgrim>
References: <20230906091330.6817-1-repk@triplefau.lt>
 <626de62327fa25706ab1aaab32d7ba3a93ab26e4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626de62327fa25706ab1aaab32d7ba3a93ab26e4.camel@redhat.com>
X-GND-Sasl: repk@triplefau.lt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 11:23:16AM +0200, Paolo Abeni wrote:
> On Wed, 2023-09-06 at 11:13 +0200, Remi Pommarel wrote:
> > Using netconsole netpoll_poll_dev could be called from interrupt
> > context, thus using disable_irq() would cause the following kernel
> > warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:
> > 
> >   BUG: sleeping function called from invalid context at kernel/irq/manage.c:137
> >   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 10, name: ksoftirqd/0
> >   CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W         5.15.42-00075-g816b502b2298-dirty #117
> >   Hardware name: aml (r1) (DT)
> >   Call trace:
> >    dump_backtrace+0x0/0x270
> >    show_stack+0x14/0x20
> >    dump_stack_lvl+0x8c/0xac
> >    dump_stack+0x18/0x30
> >    ___might_sleep+0x150/0x194
> >    __might_sleep+0x64/0xbc
> >    synchronize_irq+0x8c/0x150
> >    disable_irq+0x2c/0x40
> >    stmmac_poll_controller+0x140/0x1a0
> >    netpoll_poll_dev+0x6c/0x220
> >    netpoll_send_skb+0x308/0x390
> >    netpoll_send_udp+0x418/0x760
> >    write_msg+0x118/0x140 [netconsole]
> >    console_unlock+0x404/0x500
> >    vprintk_emit+0x118/0x250
> >    dev_vprintk_emit+0x19c/0x1cc
> >    dev_printk_emit+0x90/0xa8
> >    __dev_printk+0x78/0x9c
> >    _dev_warn+0xa4/0xbc
> >    ath10k_warn+0xe8/0xf0 [ath10k_core]
> >    ath10k_htt_txrx_compl_task+0x790/0x7fc [ath10k_core]
> >    ath10k_pci_napi_poll+0x98/0x1f4 [ath10k_pci]
> >    __napi_poll+0x58/0x1f4
> >    net_rx_action+0x504/0x590
> >    _stext+0x1b8/0x418
> >    run_ksoftirqd+0x74/0xa4
> >    smpboot_thread_fn+0x210/0x3c0
> >    kthread+0x1fc/0x210
> >    ret_from_fork+0x10/0x20
> > 
> > Since [0] .ndo_poll_controller is only needed if driver doesn't or
> > partially use NAPI. Because stmmac does so, stmmac_poll_controller
> > can be removed fixing the above warning.
> > 
> > [0] commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> > 
> > Cc: <stable@vger.kernel.org> # 5.15.x
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> 
> I'm sorry for the incremental feedback, but we also need a suitable
> Fixes tag, thanks!

I didn't include Fixes tag because it would go back up to the initial
driver support commit [0]. I can't be sure that this commit includes
necessary NAPI implementation to be able to get rid of
.ndo_poll_controller callback back then. And I am not able to test it on
older version than 5.15.x hence I only included the 5.15.x Cc tag
version prerequisite.

But I surely can add a Fixed tag if it is ok for it to be [0].

Also sorry for the long replying delay.

[0] commit 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")

-- 
Remi
