Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE4777315
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjHJIge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjHJIgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:36:33 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247EC1BFA;
        Thu, 10 Aug 2023 01:36:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3484240003;
        Thu, 10 Aug 2023 08:36:27 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        stable@vger.kernel.org
Subject: [PATCH net] net: stmmac: remove disable_irq() from ->ndo_poll_controller()
Date:   Thu, 10 Aug 2023 10:37:16 +0200
Message-Id: <20230810083716.29653-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using netconsole netpoll_poll_dev could be called from interrupt
context, thus using disable_irq() would cause the following kernel
warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:

  BUG: sleeping function called from invalid context at kernel/irq/manage.c:137
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 10, name: ksoftirqd/0
  CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W         5.15.42-00075-g816b502b2298-dirty #117
  Hardware name: aml (r1) (DT)
  Call trace:
   dump_backtrace+0x0/0x270
   show_stack+0x14/0x20
   dump_stack_lvl+0x8c/0xac
   dump_stack+0x18/0x30
   ___might_sleep+0x150/0x194
   __might_sleep+0x64/0xbc
   synchronize_irq+0x8c/0x150
   disable_irq+0x2c/0x40
   stmmac_poll_controller+0x140/0x1a0
   netpoll_poll_dev+0x6c/0x220
   netpoll_send_skb+0x308/0x390
   netpoll_send_udp+0x418/0x760
   write_msg+0x118/0x140 [netconsole]
   console_unlock+0x404/0x500
   vprintk_emit+0x118/0x250
   dev_vprintk_emit+0x19c/0x1cc
   dev_printk_emit+0x90/0xa8
   __dev_printk+0x78/0x9c
   _dev_warn+0xa4/0xbc
   ath10k_warn+0xe8/0xf0 [ath10k_core]
   ath10k_htt_txrx_compl_task+0x790/0x7fc [ath10k_core]
   ath10k_pci_napi_poll+0x98/0x1f4 [ath10k_pci]
   __napi_poll+0x58/0x1f4
   net_rx_action+0x504/0x590
   _stext+0x1b8/0x418
   run_ksoftirqd+0x74/0xa4
   smpboot_thread_fn+0x210/0x3c0
   kthread+0x1fc/0x210
   ret_from_fork+0x10/0x20

Commit [0] introcuded disable_hardirq() to address this situation, so
use it here to avoid above warning.

[0] 02cea395866 ("genirq: Provide disable_hardirq()")

Cc: <stable@vger.kernel.org>
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4727f7be4f86..bbe509abc5dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5958,8 +5958,8 @@ static void stmmac_poll_controller(struct net_device *dev)
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
 			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
 	} else {
-		disable_irq(dev->irq);
-		stmmac_interrupt(dev->irq, dev);
+		if (disable_hardirq(dev->irq))
+			stmmac_interrupt(dev->irq, dev);
 		enable_irq(dev->irq);
 	}
 }
-- 
2.40.0

