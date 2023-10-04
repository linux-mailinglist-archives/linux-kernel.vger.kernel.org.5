Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF67B827D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242905AbjJDOgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjJDOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:36:19 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 07:36:07 PDT
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9A114;
        Wed,  4 Oct 2023 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
        t=1696430144; bh=W5PvFP3Gw5uKhxD9CUkqsxWtpbEX48dkIbT12G1DE2A=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=YDytJxlUUeybvXrdD5LRMZ9ltQOP9sIES6Pe/CZ4fMc0gL6dYTVR+k9Sw0XNcW2Wu
         /FRKtv34kfzAAB1VVFBi5888HtKpFtpdbtw9N4ylQKgsn/rB43jRdNIYW/W8TK/p6s
         UCARbcW26LMGnQYli5fXhv4AI2Dr/SgC6h9Xcvu0=
Received: by b221-6.in.mailobj.net [192.168.90.26] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Wed,  4 Oct 2023 16:35:44 +0200 (CEST)
X-EA-Auth: g2dus1cobUlbsNVadb0mm/YbIdgQDytxLe63okReyGpdMx+oXIlNsenYyRsgRwiHak3A83Pk2kowDrLhXv0ofdhKRLPBVNjU
From:   Remi Pommarel <repk@triplefau.lt>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
Subject: [PATCH net v3] net: stmmac: remove unneeded stmmac_poll_controller
Date:   Wed,  4 Oct 2023 16:33:56 +0200
Message-Id: <1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Since [0] .ndo_poll_controller is only needed if driver doesn't or
partially use NAPI. Because stmmac does so, stmmac_poll_controller
can be removed fixing the above warning.

[0] commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")

Cc: <stable@vger.kernel.org> # 5.15.x
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 83c567a89a46..ed1a5a31a491 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6002,33 +6002,6 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/* Polling receive - used by NETCONSOLE and other diagnostic tools
- * to allow network I/O with interrupts disabled.
- */
-static void stmmac_poll_controller(struct net_device *dev)
-{
-	struct stmmac_priv *priv = netdev_priv(dev);
-	int i;
-
-	/* If adapter is down, do nothing */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return;
-
-	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
-		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
-			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
-
-		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
-			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
-	} else {
-		disable_irq(dev->irq);
-		stmmac_interrupt(dev->irq, dev);
-		enable_irq(dev->irq);
-	}
-}
-#endif
-
 /**
  *  stmmac_ioctl - Entry point for the Ioctl
  *  @dev: Device pointer.
@@ -6989,9 +6962,6 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_get_stats64 = stmmac_get_stats64,
 	.ndo_setup_tc = stmmac_setup_tc,
 	.ndo_select_queue = stmmac_select_queue,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller = stmmac_poll_controller,
-#endif
 	.ndo_set_mac_address = stmmac_set_mac_address,
 	.ndo_vlan_rx_add_vid = stmmac_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = stmmac_vlan_rx_kill_vid,
-- 
2.40.0



