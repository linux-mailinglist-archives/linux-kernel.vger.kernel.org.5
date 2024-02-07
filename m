Return-Path: <linux-kernel+bounces-56222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFC084C78E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D685828A33C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4023F9E2;
	Wed,  7 Feb 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nS3F3EZt"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCDE3C08A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298372; cv=none; b=WdIaFK1F6xFkLMyDA2ehqw029yPZRyiE8OMc8HhTgpLULOQn104GS4+TXGAtJqM3QK5Ju/ddj/TG+Yr+pwNvABSbMUqd2UqLgWm1ELwBlDJucNMybLtWgfJSkR9rxVsf5vc6uPWbs7pIfpJrJtiFCWYIO+lMYQ7Mo5O8QzKzke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298372; c=relaxed/simple;
	bh=NRByXN9LnRS5cAdFV4z6JTwvY5Y0C/+5VK35Zq9oZ80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC9lH1ditRgnV4Uh8yWvfJb05BDDAQgd2xkSw7YUJpf0yGmTGycGTiUwMdizhwcknUcYqEZFPHyXCMBxEGs5M+U56GCCjAwu04BzXyhYQ1v/FxhGDKjW1yKFd6byDF7pXFEq9NIGsVCPxbSCNp1zfCFuF0qrlg0wDth2N7Lipmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nS3F3EZt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a359e6fde44so42770866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298369; x=1707903169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynzFBSzm0QvP5B3lSznm7RC+RbgARBCvd8XcXKtTV40=;
        b=nS3F3EZthrVdBv2au03f/S7RUe2YVFi1AQjkC77ZRURAER6T2SmzTGt3FvRVZTQLTE
         aVlfDFWTLJAwOL2haL9bIc4oGh8h9t7q/SaTcaD7F7RArhsSYB6xIS5tViwh6Tgc25bj
         TQXBfawoaKS7r9NM6RerUJs6qA4U/H89/sonw1Te2+NpXbTL1HFIxAY9Noi4ap2qFUS7
         WjiNt7bp2PPr+SLRUrtnOmK9rr1/PrwWjEnsibLqYcjTk690fVstt+T7/caAS1HqKfec
         mZzrkRkR7pBXWJnLwnGskRMRkE6h05NSuBu1v6eJNPqk12My5yqbIxgGa8tuoUVx7de1
         1OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298369; x=1707903169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynzFBSzm0QvP5B3lSznm7RC+RbgARBCvd8XcXKtTV40=;
        b=w5rHHwxcuRXfUax3E0VJpT6ngY6q9Gnx3NUK3GNGerEJ2Djl7OR9mQoONk+XZ7r+FG
         AszgZmr8rdy252uB3lpEyBpZuNc66q1I4nmHTIxOngEVSxbBJd8T8lWxgjsdVcV2P/wz
         XNkPAdplcbA5HgxKsEemjxxffCbHwP1WOaxXQ1CijI+J4Pc1oo5bRgihXxdzK+bWRjpe
         jvscltTAJEpFI7PouZrgXJ8oU0d8GYHMDj7D7DTewajRKd6HoPZvyHDpSvr1QrEmFvJ9
         wPUUX7gBIzeITv39hyRlJt/2S7S2AAizWWJQAS24VySBEDfvCmkmYIeqtfHaUXMSQ3Tg
         GVbg==
X-Gm-Message-State: AOJu0YwLjmj2l2T4R++NxY0qVpJ4eTxszmgXurya0tj9JzzwUS/DXaO9
	/KXXRmx4jaD3CbNIjPFdXCz/IP+a27bSdK8LjeppHCcqhmYjQlI2Ug+JJShWy48=
X-Google-Smtp-Source: AGHT+IGp7BzGeGq3Zj5uOLV6dNLruCFwFp01oBezgl+CoHj41VHRJs3FrxyJTcaCnaOgopHcntFAgA==
X-Received: by 2002:a17:907:910a:b0:a38:4abd:11de with SMTP id p10-20020a170907910a00b00a384abd11demr2055689ejq.54.1707298369107;
        Wed, 07 Feb 2024 01:32:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUilOPFwOWmkvBGlW1fZLG5e6i5sbtXa18cNTiMIXK2A6vcA4pm2LvGoFDX8jwKNEk25iTDc1jHDfev4bLZzVd/U/F0C9e5HCP1DY1QwzE5XfUwTd8SawueVBndggoYgqiG+8hsEKFQ+81bVdDmSO6JbQrhW8lRyhYxCKZHbZt4DU1lOOTHtx04Fun2AjCjMUzrILxUenfiAMoZaDVMvo+KUbUn7La3GOACLGxhZDXhETqbTgQjpXIwK+qkaP/1+irXBbwOEv8BSRXb0AmwRU0mseI18W9GV3vD0EheIPqAWIfUFNUm2FVRvMeDJk5nEPVK3ca9ctw8uRbkMdYuka1Psza0B2n7X4RPO9VhPhpQVvQ9BwsXIMMVcFqZp+fqMQGBUkG1ATutOJn1etq7HsKhhFZIK/2ytv8460hqkMBqh/CxGwX0vchPGuER
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:48 -0800 (PST)
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
Subject: [PATCH 12/14] can: m_can: Use tx_fifo_in_flight for netif_queue control
Date: Wed,  7 Feb 2024 10:32:18 +0100
Message-ID: <20240207093220.2681425-13-msp@baylibre.com>
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
---
 drivers/net/can/m_can/m_can.c | 77 +++++++++--------------------------
 1 file changed, 20 insertions(+), 57 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2c68b1a60887..20595b7141af 100644
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
@@ -1077,17 +1067,31 @@ static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
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
@@ -1218,7 +1222,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
 			m_can_tx_update_stats(cdev, 0, timestamp);
-			netif_wake_queue(dev);
 			m_can_finish_tx(cdev, 1);
 		}
 	} else  {
@@ -1226,10 +1229,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
-
-			if (netif_queue_stopped(dev) &&
-			    !m_can_tx_fifo_full(cdev))
-				netif_wake_queue(dev);
 		}
 	}
 
@@ -1729,20 +1728,6 @@ static int m_can_close(struct net_device *dev)
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
@@ -1751,7 +1736,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
 	u32 cccr, fdflags;
-	u32 txfqs;
 	int err;
 	u32 putidx;
 
@@ -1806,24 +1790,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
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
 
@@ -1861,11 +1827,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
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
@@ -1899,7 +1860,6 @@ static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
 static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 					       struct sk_buff *skb)
 {
-	netif_stop_queue(cdev->net);
 	m_can_tx_queue_skb(cdev, skb);
 
 	return NETDEV_TX_OK;
@@ -1909,6 +1869,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	netdev_tx_t ret;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -1918,7 +1879,9 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	m_can_start_tx(cdev);
+	ret = m_can_start_tx(cdev);
+	if (ret != NETDEV_TX_OK)
+		return ret;
 
 	if (cdev->is_peripheral)
 		return m_can_start_peripheral_xmit(cdev, skb);
-- 
2.43.0


