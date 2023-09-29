Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28E57B3498
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjI2ON5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjI2ONm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C90CED
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40535597f01so143458375e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996804; x=1696601604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3pd0/0m47uxFGjXjjg3Or0r5yrxGeN6WtiYUDTDcr8=;
        b=PBGx85+gBaiYhyGBkBzXjlDqIyJHLnxm51H/4WPeLJ0LGMy2SO3cSvzw/LlD2Dsu+8
         U3eGIeUqlK9hSewBpT1T0UdSyKRYrMSCCxYc4vU7w1kIHph+wFDuoxtPPNs2cDIlbBan
         SjB8vcRreDmiIWNO8TVusA56A9AAUGl2vrcFUvLSEA67zeDHFR0QrkLyvJQY2mszycFp
         jtJjnuOvwMfho+7o4Ehx9rYWIBuplw2Ghs97b+yvmZr/pl/ZAQQJEN0A33CTKc+pl4wR
         2OkRI5QhxbPE3wYx8CPyvxh8bGZGftz2VfUFC5jSCPTZAOOwD7Cdt09IX+BPwYgjiW+i
         lOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996804; x=1696601604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3pd0/0m47uxFGjXjjg3Or0r5yrxGeN6WtiYUDTDcr8=;
        b=kEeOzINWpD9yt5QVgkANQ90SrtKaf8AN8xHhdousZJuALpPgddlAvSB7Msyt5+NURo
         MFkgiXsJZW4IaRe7XzOqGhN+GzAEJ9zKo/CVW60l4EGi6bLJnSG+vptDxHZRoywfWvol
         JIu6ITmzHLcd3C3H96b36gfPX6S3sQBHcPui0uspu8fcEEnAejXSQXK38JUdRR6kJiaF
         jDetzw9cz/ZntTKtq+hHNuS91eDhWYU8T/Qxsj/4ihqmuTinqVYHk1AgVWg88E1o1W1v
         VT5TbZTROLAQd4m/wNZ62QVrM0BHrw4iw/OQs8ppJh6ym71er3DXIvOsyWIERgScR/+v
         q2Ig==
X-Gm-Message-State: AOJu0YwC4xENR/112wa36kOp/dzcIxOw1TgXmX3HOUVwFqBp8yYpxxpY
        FJoDFEn+/qrzt3WL9pCxTcYq3A==
X-Google-Smtp-Source: AGHT+IFIRg/uvI8+ztWkmHfmkeMGN2eEDWd4xRTspBYWS/f7rMWDt5uMMK9Zr1FGLPJ7nNTVqlzQBw==
X-Received: by 2002:a05:600c:218f:b0:405:3a3d:6f42 with SMTP id e15-20020a05600c218f00b004053a3d6f42mr4015587wme.39.1695996803927;
        Fri, 29 Sep 2023 07:13:23 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:23 -0700 (PDT)
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
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 12/14] can: m_can: Use tx_fifo_in_flight for netif_queue control
Date:   Fri, 29 Sep 2023 16:13:02 +0200
Message-Id: <20230929141304.3934380-13-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The network queue is currently always stopped in start_xmit and
continued in the interrupt handler. This is not possible anymore if we
want to keep multiple transmits in flight in parallel.

Use the previously introduced tx_fifo_in_flight counter to control the
network queue instead. This has the benefit of not needing to ask the
hardware about fifo status.

This patch stops the network queue in start_xmit if the number of
transmits in flight reaches the size of the fifo and wakes up the queue
from the interrupt handler once the transmits in flight drops below the
fifo size. This means any skbs over the limit will be rejected
immediately in start_xmit (it shouldn't be possible at all to reach that
state anyways).

The maximum number of transmits in flight is the size of the fifo.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 85 +++++++++++------------------------
 1 file changed, 26 insertions(+), 59 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3ecd071abacb..dc8e8f133ea3 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -379,16 +379,6 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
 	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
 }
 
-static inline bool _m_can_tx_fifo_full(u32 txfqs)
-{
-	return !!(txfqs & TXFQS_TFQF);
-}
-
-static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
-{
-	return _m_can_tx_fifo_full(m_can_read(cdev, M_CAN_TXFQS));
-}
-
 static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 {
 	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
@@ -1074,17 +1064,31 @@ static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	if (cdev->tx_fifo_in_flight >= cdev->tx_fifo_size && transmitted > 0)
+		netif_wake_queue(cdev->net);
 	cdev->tx_fifo_in_flight -= transmitted;
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
 }
 
-static void m_can_start_tx(struct m_can_classdev *cdev)
+static netdev_tx_t m_can_start_tx(struct m_can_classdev *cdev)
 {
 	unsigned long irqflags;
+	int tx_fifo_in_flight;
 
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
-	++cdev->tx_fifo_in_flight;
+	tx_fifo_in_flight = cdev->tx_fifo_in_flight + 1;
+	if (tx_fifo_in_flight >= cdev->tx_fifo_size) {
+		netif_stop_queue(cdev->net);
+		if (tx_fifo_in_flight > cdev->tx_fifo_size) {
+			netdev_err_once(cdev->net, "hard_xmit called while TX FIFO full\n");
+			spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+			return NETDEV_TX_BUSY;
+		}
+	}
+	cdev->tx_fifo_in_flight = tx_fifo_in_flight;
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+
+	return NETDEV_TX_OK;
 }
 
 static int m_can_echo_tx_event(struct net_device *dev)
@@ -1215,7 +1219,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
 			m_can_tx_update_stats(cdev, 0, timestamp);
-			netif_wake_queue(dev);
 			m_can_finish_tx(cdev, 1);
 		}
 	} else  {
@@ -1223,10 +1226,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
-
-			if (netif_queue_stopped(dev) &&
-			    !m_can_tx_fifo_full(cdev))
-				netif_wake_queue(dev);
 		}
 	}
 
@@ -1726,20 +1725,6 @@ static int m_can_close(struct net_device *dev)
 	return 0;
 }
 
-static int m_can_next_echo_skb_occupied(struct net_device *dev, u32 putidx)
-{
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	/*get wrap around for loopback skb index */
-	unsigned int wrap = cdev->can.echo_skb_max;
-	u32 next_idx;
-
-	/* calculate next index */
-	next_idx = (++putidx >= wrap ? 0 : putidx);
-
-	/* check if occupied */
-	return !!cdev->can.echo_skb[next_idx];
-}
-
 static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 				    struct sk_buff *skb)
 {
@@ -1748,7 +1733,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
 	u32 cccr, fdflags;
-	u32 txfqs;
 	int err;
 	u32 putidx;
 
@@ -1803,24 +1787,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	} else {
 		/* Transmit routine for version >= v3.1.x */
 
-		txfqs = m_can_read(cdev, M_CAN_TXFQS);
-
-		/* Check if FIFO full */
-		if (_m_can_tx_fifo_full(txfqs)) {
-			/* This shouldn't happen */
-			netif_stop_queue(dev);
-			netdev_warn(dev,
-				    "TX queue active although FIFO is full.");
-
-			if (cdev->is_peripheral) {
-				kfree_skb(skb);
-				dev->stats.tx_dropped++;
-				return NETDEV_TX_OK;
-			} else {
-				return NETDEV_TX_BUSY;
-			}
-		}
-
 		/* get put index for frame */
 		putidx = cdev->tx_fifo_putidx;
 
@@ -1858,11 +1824,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
 		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
 					0 : cdev->tx_fifo_putidx);
-
-		/* stop network queue if fifo full */
-		if (m_can_tx_fifo_full(cdev) ||
-		    m_can_next_echo_skb_occupied(dev, putidx))
-			netif_stop_queue(dev);
 	}
 
 	return NETDEV_TX_OK;
@@ -1896,14 +1857,16 @@ static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
 static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 					       struct sk_buff *skb)
 {
+	netdev_tx_t err;
+
 	if (cdev->can.state == CAN_STATE_BUS_OFF) {
 		m_can_clean(cdev->net);
 		return NETDEV_TX_OK;
 	}
 
-	netif_stop_queue(cdev->net);
-
-	m_can_start_tx(cdev);
+	err = m_can_start_tx(cdev);
+	if (err != NETDEV_TX_OK)
+		return err;
 
 	m_can_tx_queue_skb(cdev, skb);
 
@@ -1913,7 +1876,11 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 static netdev_tx_t m_can_start_fast_xmit(struct m_can_classdev *cdev,
 					 struct sk_buff *skb)
 {
-	m_can_start_tx(cdev);
+	netdev_tx_t err;
+
+	err = m_can_start_tx(cdev);
+	if (err != NETDEV_TX_OK)
+		return err;
 
 	return m_can_tx_handler(cdev, skb);
 }
-- 
2.40.1

