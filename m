Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2357C798673
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbjIHL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjIHL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:29:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A221BE7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 04:29:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qeZfu-0005mN-Ih; Fri, 08 Sep 2023 13:29:22 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qeZft-004roo-SJ; Fri, 08 Sep 2023 13:29:21 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qeZfs-0078i4-W9; Fri, 08 Sep 2023 13:29:21 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] net: macb: fix sleep inside spinlock
Date:   Fri,  8 Sep 2023 13:29:13 +0200
Message-Id: <20230908112913.1701766-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

macb_set_tx_clk() is called under a spinlock but itself calls clk_set_rate()
which can sleep. This results in:

| BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
| pps pps1: new PPS source ptp1
| in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 40, name: kworker/u4:3
| preempt_count: 1, expected: 0
| RCU nest depth: 0, expected: 0
| 4 locks held by kworker/u4:3/40:
|  #0: ffff000003409148
| macb ff0c0000.ethernet: gem-ptp-timer ptp clock registered.
|  ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x14c/0x51c
|  #1: ffff8000833cbdd8 ((work_completion)(&pl->resolve)){+.+.}-{0:0}, at: process_one_work+0x14c/0x51c
|  #2: ffff000004f01578 (&pl->state_mutex){+.+.}-{4:4}, at: phylink_resolve+0x44/0x4e8
|  #3: ffff000004f06f50 (&bp->lock){....}-{3:3}, at: macb_mac_link_up+0x40/0x2ac
| irq event stamp: 113998
| hardirqs last  enabled at (113997): [<ffff800080e8503c>] _raw_spin_unlock_irq+0x30/0x64
| hardirqs last disabled at (113998): [<ffff800080e84478>] _raw_spin_lock_irqsave+0xac/0xc8
| softirqs last  enabled at (113608): [<ffff800080010630>] __do_softirq+0x430/0x4e4
| softirqs last disabled at (113597): [<ffff80008001614c>] ____do_softirq+0x10/0x1c
| CPU: 0 PID: 40 Comm: kworker/u4:3 Not tainted 6.5.0-11717-g9355ce8b2f50-dirty #368
| Hardware name: ... ZynqMP ... (DT)
| Workqueue: events_power_efficient phylink_resolve
| Call trace:
|  dump_backtrace+0x98/0xf0
|  show_stack+0x18/0x24
|  dump_stack_lvl+0x60/0xac
|  dump_stack+0x18/0x24
|  __might_resched+0x144/0x24c
|  __might_sleep+0x48/0x98
|  __mutex_lock+0x58/0x7b0
|  mutex_lock_nested+0x24/0x30
|  clk_prepare_lock+0x4c/0xa8
|  clk_set_rate+0x24/0x8c
|  macb_mac_link_up+0x25c/0x2ac
|  phylink_resolve+0x178/0x4e8
|  process_one_work+0x1ec/0x51c
|  worker_thread+0x1ec/0x3e4
|  kthread+0x120/0x124
|  ret_from_fork+0x10/0x20

The obvious fix is to move the call to macb_set_tx_clk() out of the
protected area. This seems safe as rx and tx are both disabled anyway at
this point.
It is however not entirely clear what the spinlock shall protect. It
could be the read-modify-write access to the NCFGR register, but this
is accessed in macb_set_rx_mode() and macb_set_rxcsum_feature() as well
without holding the spinlock. It could also be the register accesses
done in mog_init_rings() or macb_init_buffers(), but again these
functions are called without holding the spinlock in macb_hresp_error_task().
The locking seems fishy in this driver and it might deserve another look
before this patch is applied.

Fixes: 633e98a711ac0 ("net: macb: use resolved link config in mac_link_up()")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/ethernet/cadence/macb_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 31f664ee4d778..b940dcd3ace68 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -756,8 +756,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		macb_set_tx_clk(bp, speed);
-
 		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
 		 * cleared the pipeline and control registers.
 		 */
@@ -777,6 +775,9 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	spin_unlock_irqrestore(&bp->lock, flags);
 
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+		macb_set_tx_clk(bp, speed);
+
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);
 	if (gem_has_ptp(bp))
-- 
2.39.2

