Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFA7575F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGRH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjGRH5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:57:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CDA19B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso49246175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667039; x=1690271839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48czNncddDn85hCm9Dic+NwS2CosoFz1usOAYX9qu5Y=;
        b=yNhT86LhYt+7HJqWZvG+gnce9M8HBLuoF+vF4JKLEe374JSHaWRED9Gfo5jHa4l0XI
         jHLuVZdm65yYxKk0VQk45MHH0qT51VOWV/I0RGeXop1T8rQPPkXHCFOPHaGwig6ByudU
         hrRuTOHMdeGqJQrezrJyd+HNIhDQYvw5gcTfm+lRdTe3ta2pbJiw+jX7FmKwT8LrBuP5
         fqGea4mhEfolfuyXyPKkr4xOZglPAXis0qj1sbu4AgbYMJXjPUy8tyshrJeETCZ5hNcy
         P2Onf4RinFHHhCD0nZ0SBWx1G2GRhKf9w0DQMZJw/42dFm6pN+NmFzqB7hfx3hCL11Ng
         9zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667039; x=1690271839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48czNncddDn85hCm9Dic+NwS2CosoFz1usOAYX9qu5Y=;
        b=FEdbw31OxylZybz2xbfY6tIiDkkNn39b3of/Nq8USAm3370Gc7nxM82A/F8UaF5Rma
         weHqWKNuKA6dAaAJu0h4ixM05gJvt2O1zo6eD5EwxUrkoTN1OdS6cf0ngQjJwXAolC8U
         XoFsNyGJ8n+Wc4VUfjUyKPLrWGQ6Qmak70AMXTXeHaejQUvINoRxLOUqITczaT2DYqmR
         tO52uLn7A14AFd5vRY3S+X7pPpxLXHOq3kAiZsoQNk7ups6HkcLSZtRn0W2g1nXgLDay
         FpSBYkdaB5wzeDFEkidMZTIF1YwBqJOMCp3dRVUg5v9kw8wVmwJQqxkoye7dtBu0k7A2
         c/cQ==
X-Gm-Message-State: ABy/qLZPOIgFWHedXheGyB9bRw1hV55QXKF+NaHHtJxsF7iv9YCoxUBo
        FFmv76h4T4xp5qhJLRxOVXZG5Q==
X-Google-Smtp-Source: APBJJlFpQEGqMC+c8lkLbcx+6Qe627jKMzU4jXDnlrq4vvOPFafdg5SusB/oVKgotE2qGHBDEibq4g==
X-Received: by 2002:adf:f309:0:b0:316:efb9:ffa with SMTP id i9-20020adff309000000b00316efb90ffamr8565619wro.35.1689667039686;
        Tue, 18 Jul 2023 00:57:19 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:19 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 08/12] can: m_can: Use the workqueue as queue
Date:   Tue, 18 Jul 2023 09:57:04 +0200
Message-Id: <20230718075708.958094-9-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation uses the workqueue for peripheral chips to
submit work. Only a single work item is queued and used at any time.

To be able to keep more than one transmit in flight at a time, prepare
the workqueue to support multiple transmits at the same time.

Each work item now has a separate storage for a skb and a pointer to
cdev. This assures that each workitem can be processed individually.

The workqueue is replaced by an ordered workqueue which makes sure that
only a single worker processes the items queued on the workqueue. Also
items are ordered by the order they were enqueued. This removes most of
the concurrency the workqueue normally offers. It is not necessary for
this driver.

The cleanup functions have to be adopted a bit to handle this new
mechanism.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 109 ++++++++++++++++++++--------------
 drivers/net/can/m_can/m_can.h |  14 ++++-
 2 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 45e8afb1b795..9e4dcdfda59d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -466,17 +466,16 @@ static void m_can_clean(struct net_device *net)
 {
 	struct m_can_classdev *cdev = netdev_priv(net);
 
-	if (cdev->tx_skb) {
-		u32 putidx = 0;
+	for (int i = 0; i != cdev->tx_fifo_size; ++i) {
+		if (!cdev->tx_ops[i].skb)
+			continue;
 
 		net->stats.tx_errors++;
-		if (cdev->version > 30)
-			putidx = FIELD_GET(TXFQS_TFQPI_MASK,
-					   m_can_read(cdev, M_CAN_TXFQS));
-
-		can_free_echo_skb(cdev->net, putidx, NULL);
-		cdev->tx_skb = NULL;
+		cdev->tx_ops[i].skb = NULL;
 	}
+
+	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
+		can_free_echo_skb(cdev->net, i, NULL);
 }
 
 /* For peripherals, pass skb to rx-offload, which will push skb from
@@ -1663,8 +1662,9 @@ static int m_can_close(struct net_device *dev)
 	m_can_clk_stop(cdev);
 	free_irq(dev->irq, dev);
 
+	m_can_clean(dev);
+
 	if (cdev->is_peripheral) {
-		cdev->tx_skb = NULL;
 		destroy_workqueue(cdev->tx_wq);
 		cdev->tx_wq = NULL;
 		can_rx_offload_disable(&cdev->offload);
@@ -1691,20 +1691,18 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, u32 putidx)
 	return !!cdev->can.echo_skb[next_idx];
 }
 
-static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
+static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
+				    struct sk_buff *skb)
 {
-	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
 	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
-	struct sk_buff *skb = cdev->tx_skb;
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
 	u32 putidx;
 
-	cdev->tx_skb = NULL;
-
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -1828,10 +1826,36 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 static void m_can_tx_work_queue(struct work_struct *ws)
 {
-	struct m_can_classdev *cdev = container_of(ws, struct m_can_classdev,
-						   tx_work);
+	struct m_can_tx_op *op = container_of(ws, struct m_can_tx_op, work);
+	struct m_can_classdev *cdev = op->cdev;
+	struct sk_buff *skb = op->skb;
 
-	m_can_tx_handler(cdev);
+	op->skb = NULL;
+	m_can_tx_handler(cdev, skb);
+}
+
+static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
+{
+	cdev->tx_ops[cdev->next_tx_op].skb = skb;
+	queue_work(cdev->tx_wq, &cdev->tx_ops[cdev->next_tx_op].work);
+
+	++cdev->next_tx_op;
+	if (cdev->next_tx_op >= cdev->tx_fifo_size)
+		cdev->next_tx_op = 0;
+}
+
+static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
+					       struct sk_buff *skb)
+{
+	if (cdev->can.state == CAN_STATE_BUS_OFF) {
+		m_can_clean(cdev->net);
+		return NETDEV_TX_OK;
+	}
+
+	netif_stop_queue(cdev->net);
+	m_can_tx_queue_skb(cdev, skb);
+
+	return NETDEV_TX_OK;
 }
 
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
@@ -1842,30 +1866,10 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	if (cdev->is_peripheral) {
-		if (cdev->tx_skb) {
-			netdev_err(dev, "hard_xmit called while tx busy\n");
-			return NETDEV_TX_BUSY;
-		}
-
-		if (cdev->can.state == CAN_STATE_BUS_OFF) {
-			m_can_clean(dev);
-		} else {
-			/* Need to stop the queue to avoid numerous requests
-			 * from being sent.  Suggested improvement is to create
-			 * a queueing mechanism that will queue the skbs and
-			 * process them in order.
-			 */
-			cdev->tx_skb = skb;
-			netif_stop_queue(cdev->net);
-			queue_work(cdev->tx_wq, &cdev->tx_work);
-		}
-	} else {
-		cdev->tx_skb = skb;
-		return m_can_tx_handler(cdev);
-	}
-
-	return NETDEV_TX_OK;
+	if (cdev->is_peripheral)
+		return m_can_start_peripheral_xmit(cdev, skb);
+	else
+		return m_can_tx_handler(cdev, skb);
 }
 
 static int m_can_open(struct net_device *dev)
@@ -1893,15 +1897,17 @@ static int m_can_open(struct net_device *dev)
 
 	/* register interrupt handler */
 	if (cdev->is_peripheral) {
-		cdev->tx_skb = NULL;
-		cdev->tx_wq = alloc_workqueue("mcan_wq",
-					      WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+		cdev->tx_wq = alloc_ordered_workqueue("mcan_wq",
+						      WQ_FREEZABLE | WQ_MEM_RECLAIM);
 		if (!cdev->tx_wq) {
 			err = -ENOMEM;
 			goto out_wq_fail;
 		}
 
-		INIT_WORK(&cdev->tx_work, m_can_tx_work_queue);
+		for (int i = 0; i != cdev->tx_fifo_size; ++i) {
+			cdev->tx_ops[i].cdev = cdev;
+			INIT_WORK(&cdev->tx_ops[i].work, m_can_tx_work_queue);
+		}
 
 		err = request_threaded_irq(dev->irq, NULL, m_can_isr,
 					   IRQF_ONESHOT,
@@ -2171,6 +2177,19 @@ int m_can_class_register(struct m_can_classdev *cdev)
 {
 	int ret;
 
+	cdev->tx_fifo_size = max(1, min(cdev->mcfg[MRAM_TXB].num,
+					cdev->mcfg[MRAM_TXE].num));
+	if (cdev->is_peripheral) {
+		cdev->tx_ops =
+			devm_kzalloc(cdev->dev,
+				     cdev->tx_fifo_size * sizeof(*cdev->tx_ops),
+				     GFP_KERNEL);
+		if (!cdev->tx_ops) {
+			dev_err(cdev->dev, "Failed to allocate tx_ops for workqueue\n");
+			return -ENOMEM;
+		}
+	}
+
 	if (cdev->pm_clock_support) {
 		ret = m_can_clk_start(cdev);
 		if (ret)
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 548ae908ac4e..38b154fea04b 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -70,6 +70,12 @@ struct m_can_ops {
 	int (*init)(struct m_can_classdev *cdev);
 };
 
+struct m_can_tx_op {
+	struct m_can_classdev *cdev;
+	struct work_struct work;
+	struct sk_buff *skb;
+};
+
 struct m_can_classdev {
 	struct can_priv can;
 	struct can_rx_offload offload;
@@ -80,8 +86,6 @@ struct m_can_classdev {
 	struct clk *cclk;
 
 	struct workqueue_struct *tx_wq;
-	struct work_struct tx_work;
-	struct sk_buff *tx_skb;
 	struct phy *transceiver;
 
 	struct hrtimer irq_timer;
@@ -103,7 +107,11 @@ struct m_can_classdev {
 	u32 tx_coalesce_usecs_irq;
 
 	// Store this internally to avoid fetch delays on peripheral chips
-	int tx_fifo_putidx;
+	u32 tx_fifo_putidx;
+
+	struct m_can_tx_op *tx_ops;
+	int tx_fifo_size;
+	int next_tx_op;
 
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
-- 
2.40.1

