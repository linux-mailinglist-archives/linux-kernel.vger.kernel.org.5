Return-Path: <linux-kernel+bounces-56223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A084C796
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F6E1F29F63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200EB4597D;
	Wed,  7 Feb 2024 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XVhEHqRo"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DB3C49C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298374; cv=none; b=GfkZyD+ioobK54JKl/AIVhNZ8XJpUJP0Ow7VHfYuetQuhtcJQ2w71/FKh7M9kqqriGuviRaYtWCVRbr+u7k8RvoD6/BLL7mgn3mjYpFt0267nJkzSsnWz0NUMbp1uTVT3ZiitTTpxsrFZDAQ9eoh6ALQcMkB3M3fikRYB3Z2isY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298374; c=relaxed/simple;
	bh=Q9lUXRT+YgSevzYrqV6NxERHNWcO3poNT0QEvQN9im4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPLrtOAngiFaR8KIMJ1c25TgYtKIXykt6TMauF7JDFtmjTf9TIG8Rsmh1/f9YiH+ptPurnxaTMgXjHR7yypB0/rsg8uqCF7mAx4Wp8Kt3t2hiKCNPJkp5CY7gR8eNPYauS1Q6bZMh/pKsNFB2gMRHwr5bb/kXqnd4eonigRGISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XVhEHqRo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a385fa34c66so51426566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298370; x=1707903170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVaBe1cRQbyg0PtGOEKAuifBPU0qmKGXvSAvyPB81Co=;
        b=XVhEHqRokFGhyazZjpl8sYN3PnhS2Arz5dq40ibfcPysE5uXtFdQ1xio7KIPL+V5HT
         YhUC/0D7Xe/XEpA7NwUwniVc5ZsXJgLygWr5uBN9GhfjVbdAz+IDzaf9WfUPVPkwP/t0
         IbP+c0khhuyNSaNHIUczjo9hzWl63d2hD0f2TTtBcdSufJJQsJqUBWlAZvRZUVp/bJJA
         Uh+M81UtoaVmTa2Sfetl1t/WZGZeg0OAj0yTTY+SfLsDBqKoGFOdmp9AXHcGyoO3kMJn
         wjLhRU+cfGeZtQDoZ5uiH5fUXM9+Y0QUJ8UtTjTt3+6ev0hnsYXNTU3EMdy0LciT+3+Y
         aiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298370; x=1707903170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVaBe1cRQbyg0PtGOEKAuifBPU0qmKGXvSAvyPB81Co=;
        b=oPES1CQn0LgWQSQYTNSA3PpGHUP5LLAB6QAKjk2cX/du3wRv3hCsORjOHg9MbrQLhX
         w76vpd1XB52rrNrplBaCENdAXJXzeKgghw2M03rhPVSGGeECKAtiLR1W6VwuWaA6Oufx
         NIZlQuyuErMpY3CE4g5mQI1RV68gcKZWjkBwv/ZOt8xtT5y5R7mcuUVDnsh+pQ424ydP
         lqzhLzROnxxzTGS6TjH1/xB0gM7rd52hyg0Liz5xYcTfhm6PF9ho9jX4VpXR4IHCegVO
         f9VS8NxXTAeXX2BM2p39e8zAC6EczZ90nrywq5XKhne2QEUG84vKExHKq7TrtwBaTih6
         5nEA==
X-Gm-Message-State: AOJu0YxAboOdo7eVoTTiKKimvT4jaWd2IlatInH1cpsu5BS9zsNbgmAR
	A5jvucTBUmJ0A1JbQJnScl7l4UzxX9Mq6wLPgeYJeXmRn5KbHLWmMDY8Uja68ZQ=
X-Google-Smtp-Source: AGHT+IGy1JyOuH7oS6rgedIfObrDBJCWCY0rW7tixluP8Tc1jsjyPZE1yl/3maYdOdt39bD8rwhidQ==
X-Received: by 2002:a17:906:23e9:b0:a31:4e96:f40a with SMTP id j9-20020a17090623e900b00a314e96f40amr3507030ejg.26.1707298370257;
        Wed, 07 Feb 2024 01:32:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVONeauiJEfez5+TTvMZMiSlpAkGE4X/BdInaA2Rg4XFNQencIUAmJM9l1Xj6jpMZjbRyXouXjSK3iJzZPb4d/6HUVavCh87c7bZaoj5rH19mCxyzMM6b4ksVRhrSvaBjVyke2UxAO/M/OIP57Xj7ppTStGtAZLoMIRf3Afae5hOvkHhMs8EvOrloda+vw2QyfIldZYsStBy7kBf9zhYRfBcn4kMHJgLnccKRDSlX7Kvvcxa6Gen4vIBlutkfI1OCDOkf9PIKrc+gsTX4cPO2rgoAqGcVyZLwIXSvdM+xx3wNOTvHrVT2D1PXN6ll2DIcrs6ncTvCIF7oQfB0IAAJ4ApMdrn/RdgEvn2QRgtwkDxwndQygy4CjLzFDi5qxi0zO8FXZ59vMZ9C+5ODJWN+Aeh4TsQEoNl6iVMdmrMvcpLTRA/JWmCcJ8kzNB
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:49 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 13/14] can: m_can: Implement BQL
Date: Wed,  7 Feb 2024 10:32:19 +0100
Message-ID: <20240207093220.2681425-14-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement byte queue limiting in preparation for the use of xmit_more().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 50 +++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 20595b7141af..48968da69ae9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -489,6 +489,8 @@ static void m_can_clean(struct net_device *net)
 	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
 		can_free_echo_skb(cdev->net, i, NULL);
 
+	netdev_reset_queue(cdev->net);
+
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
 	cdev->tx_fifo_in_flight = 0;
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
@@ -1043,29 +1045,34 @@ static int m_can_poll(struct napi_struct *napi, int quota)
  * echo. timestamp is used for peripherals to ensure correct ordering
  * by rx-offload, and is ignored for non-peripherals.
  */
-static void m_can_tx_update_stats(struct m_can_classdev *cdev,
-				  unsigned int msg_mark,
-				  u32 timestamp)
+static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
+					  unsigned int msg_mark, u32 timestamp)
 {
 	struct net_device *dev = cdev->net;
 	struct net_device_stats *stats = &dev->stats;
+	unsigned int frame_len;
 
 	if (cdev->is_peripheral)
 		stats->tx_bytes +=
 			can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
 								    msg_mark,
 								    timestamp,
-								    NULL);
+								    &frame_len);
 	else
-		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
+		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, &frame_len);
 
 	stats->tx_packets++;
+
+	return frame_len;
 }
 
-static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
+static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted,
+			    unsigned int transmitted_frame_len)
 {
 	unsigned long irqflags;
 
+	netdev_completed_queue(cdev->net, transmitted, transmitted_frame_len);
+
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
 	if (cdev->tx_fifo_in_flight >= cdev->tx_fifo_size && transmitted > 0)
 		netif_wake_queue(cdev->net);
@@ -1104,6 +1111,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	int err = 0;
 	unsigned int msg_mark;
 	int processed = 0;
+	unsigned int processed_frame_len = 0;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
@@ -1132,7 +1140,9 @@ static int m_can_echo_tx_event(struct net_device *dev)
 		fgi = (++fgi >= cdev->mcfg[MRAM_TXE].num ? 0 : fgi);
 
 		/* update stats */
-		m_can_tx_update_stats(cdev, msg_mark, timestamp);
+		processed_frame_len += m_can_tx_update_stats(cdev, msg_mark,
+							     timestamp);
+
 		++processed;
 	}
 
@@ -1140,7 +1150,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
 							  ack_fgi));
 
-	m_can_finish_tx(cdev, processed);
+	m_can_finish_tx(cdev, processed, processed_frame_len);
 
 	return err;
 }
@@ -1218,11 +1228,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		if (ir & IR_TC) {
 			/* Transmission Complete Interrupt*/
 			u32 timestamp = 0;
+			unsigned int frame_len;
 
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
-			m_can_tx_update_stats(cdev, 0, timestamp);
-			m_can_finish_tx(cdev, 1);
+			frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
+			m_can_finish_tx(cdev, 1, frame_len);
 		}
 	} else  {
 		if (ir & (IR_TEFN | IR_TEFW)) {
@@ -1738,6 +1749,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	u32 cccr, fdflags;
 	int err;
 	u32 putidx;
+	unsigned int frame_len = can_skb_get_frame_len(skb);
 
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
@@ -1783,7 +1795,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		}
 		m_can_write(cdev, M_CAN_TXBTIE, 0x1);
 
-		can_put_echo_skb(skb, dev, 0, 0);
+		can_put_echo_skb(skb, dev, 0, frame_len);
 
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
@@ -1821,7 +1833,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
 		 */
-		can_put_echo_skb(skb, dev, putidx, 0);
+		can_put_echo_skb(skb, dev, putidx, frame_len);
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
@@ -1869,11 +1881,14 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	unsigned int frame_len;
 	netdev_tx_t ret;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
+	frame_len = can_skb_get_frame_len(skb);
+
 	if (cdev->can.state == CAN_STATE_BUS_OFF) {
 		m_can_clean(cdev->net);
 		return NETDEV_TX_OK;
@@ -1883,10 +1898,17 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	if (ret != NETDEV_TX_OK)
 		return ret;
 
+	netdev_sent_queue(dev, frame_len);
+
 	if (cdev->is_peripheral)
-		return m_can_start_peripheral_xmit(cdev, skb);
+		ret = m_can_start_peripheral_xmit(cdev, skb);
 	else
-		return m_can_tx_handler(cdev, skb);
+		ret = m_can_tx_handler(cdev, skb);
+
+	if (ret != NETDEV_TX_OK)
+		netdev_completed_queue(dev, 1, frame_len);
+
+	return ret;
 }
 
 static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
-- 
2.43.0


