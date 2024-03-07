Return-Path: <linux-kernel+bounces-95511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF39874E93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E8CB257BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD312A167;
	Thu,  7 Mar 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRWhr3gS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FCB129A8A;
	Thu,  7 Mar 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813139; cv=none; b=W4QnR/YrwdjKe8qTKIeK4YWflhskLyEcjc1NvuVqAYM42j1c1NldKzK9rrUYOBU4zLlq94DOIsXCt55UwAu5JFroFmecJCmJQNWCATXVJKkrlc2P3HNsuO3abOPEezV8VuoDpL+VF2UwzVKYTgEGEHvLqtrFkpxfB2VUrJB0qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813139; c=relaxed/simple;
	bh=pRGlR9S8GseTKbNcXNNeULK9Vo1gx3e9SYmVGHthJho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZhaQjqtmZbcK/moRPUcmKFo7Mn8olTwsFobEBYDflIRK+Ij0eny1Wu2HGd18upG+ztT8r3tkj78PvmgjFuS5rRUQno6w6mo3B4Odx133c+KCckl5xepmmUp2bu7y6tNUOTNe7n2jEJ72t1dUWlAWdnKiWVxvyLJjrMim7OvZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRWhr3gS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4130ff11782so4406585e9.2;
        Thu, 07 Mar 2024 04:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709813136; x=1710417936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9fEJLLm0v2I5BjGN6oWEtE7MbEteGlm2M/I0q1BDxg=;
        b=mRWhr3gSPP5dwevVFTzyupysCp+i/I8CAIfv6oSt5A5W185GHBSQWUj/Ec9MWZZcV8
         Cibo4qzKtcTqvIiTED1uge/0eoawnfv4s14rg3Ja5HOGDxo1O9qD3GeYKnPVkLCje4vs
         zMC5OmuxlU43LnxBbuEWWJd1o0iBcJNHkZiMlubgrdQ8R3g3ZWrj5Tgf1XseuFTxKF0x
         4NjaASpu24vxpQ9Bm1Y5wUQ3BNSBg7HttCNHFJ+9oHt3cbza8NRNpEe7B8SSNhE0LJcC
         BtGuc6VKLY0/UsAjDVkWCpg8/kToE5LBOXdcIOOPOT+rEsiuhfJ7PzgERAn5nu8Foc/a
         1bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813136; x=1710417936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9fEJLLm0v2I5BjGN6oWEtE7MbEteGlm2M/I0q1BDxg=;
        b=dZgvcepdc2qyVV/kTP1CW+J0HwsQ3VrkNLplE5rwNowa4g4Z36ezBF9ZDTzj3LbzfL
         fSySvZfE5tuNU9uCgX1M3NJWm5WNW0cmlWcMkyHbGGjfzsNmrdXfKiPU/psBW5vUUGOw
         yDKSD+bWkFEW8xwY5556v0Txv9lZSLlWKJEyXIqpnZcuXU1+2vUhGjuwAkHFgS05ZvXF
         Gr5ViAIRqX5AxTQkOZCp91ANnCaCUQo5Olf3cIeQ3kYM8mjxLyC6o49z+Q50bJN5SG6L
         CaSNLjFIs8GUlGYWaZUBa7kkXpE85MnYcyB5jdHU0FdgNh+mYhDkTh+Da7jJKkQ+HI6K
         Yf1w==
X-Forwarded-Encrypted: i=1; AJvYcCWh13SJAkMylhVYWbOt+tAto+WX7TKRXjx8iHO5lzjqI5yB6Yg6WMHi0gdBi8nuVUDeW9obqNw5Bz09TExUz/sTM6dlEpXWWC/Ne4cpqe3LKOJOtLMQJwDkUKasXksRzGzGnUhM
X-Gm-Message-State: AOJu0YyAeCWBpChZpiNqNrm4FEuCeEklc+YdWmq8H4vCcAeS39Z4rnn3
	3MZZBBc5Q3PF8kx2GnHT1u5fwHevwtdymU8/9PqA0mak8pfFzO32HBDfYbHLYfU=
X-Google-Smtp-Source: AGHT+IEn0ZkjIiOXoABUFYJeq/o21joJb7qmlpflmbLPxEJts8WTpE855VFt+K+VLbSzisGYl1mVmQ==
X-Received: by 2002:a05:600c:500a:b0:413:678:5482 with SMTP id n10-20020a05600c500a00b0041306785482mr1901251wmr.36.1709813136257;
        Thu, 07 Mar 2024 04:05:36 -0800 (PST)
Received: from vitor-nb.. ([2001:8a0:e60f:3100:7ed0:94c4:aa7c:4b29])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b00412a31d2e2asm2489810wmb.32.2024.03.07.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:05:35 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: mkl@pengutronix.de,
	manivannan.sadhasivam@linaro.org,
	thomas.kopp@microchip.com
Cc: wg@grandegger.com,
	linux-can@vger.kernel,
	linux-kernel@vger.kernel.org,
	vitor.soares@toradex.com,
	stable@vger.kernel.org
Subject: [PATCH] can: mcp251xfd: fix infinite loop when xmit fails
Date: Thu,  7 Mar 2024 12:04:42 +0000
Message-Id: <20240307120442.12262-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

When the mcp251xfd_start_xmit() function fails, the driver stops
processing messages, and the interrupt routine does not return,
running indefinitely even after killing the running application.

Error messages:
[  441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmit: -16
[  441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer not empty. (seq=0x000017c7, tef_tail=0x000017cf, tef_head=0x000017d0, tx_head=0x000017d3).
.. and repeat forever.

The issue can be triggered when multiple devices share the same
SPI interface. And there is concurrent access to the bus.

The problem occurs because tx_ring->head increments even if
mcp251xfd_start_xmit() fails. Consequently, the driver skips one
TX package while still expecting a response in
mcp251xfd_handle_tefif_one().

This patch resolves the issue by decreasing tx_ring->head if
mcp251xfd_start_xmit() fails. With the fix, if we attempt to trigger
the issue again, the driver prints an error and discard the message.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 27 ++++++++++----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..a8eb941c1b95 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -181,25 +181,26 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	tx_obj = mcp251xfd_get_tx_obj_next(tx_ring);
 	mcp251xfd_tx_obj_from_skb(priv, tx_obj, skb, tx_ring->head);
 
-	/* Stop queue if we occupy the complete TX FIFO */
 	tx_head = mcp251xfd_get_tx_head(tx_ring);
-	tx_ring->head++;
-	if (mcp251xfd_get_tx_free(tx_ring) == 0)
-		netif_stop_queue(ndev);
-
 	frame_len = can_skb_get_frame_len(skb);
-	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
-	if (!err)
-		netdev_sent_queue(priv->ndev, frame_len);
+	can_put_echo_skb(skb, ndev, tx_head, frame_len);
+
+	tx_ring->head++;
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
-	if (err)
-		goto out_err;
+	if (err) {
+		can_free_echo_skb(ndev, tx_head, NULL);
 
-	return NETDEV_TX_OK;
+		tx_ring->head--;
+
+		netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+	} else {
+		/* Stop queue if we occupy the complete TX FIFO */
+		if (mcp251xfd_get_tx_free(tx_ring) == 0)
+			netif_stop_queue(ndev);
 
- out_err:
-	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+		netdev_sent_queue(priv->ndev, frame_len);
+	}
 
 	return NETDEV_TX_OK;
 }
-- 
2.34.1


