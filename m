Return-Path: <linux-kernel+bounces-98808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4D7877FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5CF1F21994
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C53C493;
	Mon, 11 Mar 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhU1XjN6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B23B7AC;
	Mon, 11 Mar 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159149; cv=none; b=SYjaMslZv01ig1P+HTdZB1KtR0+F1LJ+IWqE+bFu93F95IcZ6lDWq6elS0MNjnPDaAMAiWb5I7DUHxomxMqQ1I0q8FBBe02D0+aEk0EiY3otq5+n//3TV6quC0iZH4cNEmmEHpxiJ2jSPOHFf2nyKs4BswKkOL0WV/k+G1vHILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159149; c=relaxed/simple;
	bh=Xww2rG6IPqeBhdEBP4tj86oP6xhbOOQM6z+2Z8fryGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umFeysuV/BCuao8WCgX7Hn/tRH99op4XrGp/0r+dEWd6fcXsUd5lm9ML/bxNBFw5c3ww3/ch0M8+iA/XEv5UpcqK6DWHKMJs0jRX7FxkLZ+BIjUweouAZKveVR1NGdXHoMJBibdrRTKyOqtVsujf8buBBEDlOqKQr9+r5W0/CZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhU1XjN6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412f55695d1so30883575e9.0;
        Mon, 11 Mar 2024 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710159146; x=1710763946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNidjb7UaHC40jeV6l+KqsqSEZYYut5toBjevl2L6WA=;
        b=HhU1XjN6TmA1E8w3hj4VENnkVD+/w4vR9+ANL8dUSglFGfTVLCjeW75Lgv/aiabsfT
         S8n+B4AyrhurbZP0hRg6tsgWMxJwxHIktEzDeRFQyll3EQMqku6OANP+qKIr3bp2F1Mf
         gsgrfIyR6x9Op6sM5JeWyOhWncRZhiM+/yZaLHj3mr2aqGgHi1uv7GkG5MvlrbBAdAe4
         8TnfjhXFLHD+HKJGdALRChbohDsLbOLd5O2/eXFP+uOJH7227NNo4JTK62y3kMssMXxH
         Z1dNOp6yc7XBiOPpRR+jTmqogs2ON2C4Wlr7VVSKccfZVzltXJx/LRqFGFTLW8Hc3tws
         C8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710159146; x=1710763946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNidjb7UaHC40jeV6l+KqsqSEZYYut5toBjevl2L6WA=;
        b=aFaCWusrwaFwVDGPHKlZvRYtHakQXfs3v8NhNlCkFVzNjy/ouwmJ27lePmU+U3AO1B
         5ShrreVPAf56zlF9/zeJke7jDBa9bKY4IxkmoOH5lvHq/OiWau0xgAWxUyMkt9VI565z
         EfMIWYmzv7H73Cp+yFHQLVjaeyW+yIhiOSltWCB1vjNcK+eVFiTciraeSmxiVVyed6P8
         MpFuIsSmEzcWR8pEZdXdovlWcR1Eybc6slsOoDQvTFSPww+7MLr5kjL5W7gLxJS+8Gmy
         zMMwgUXDxiPr/XW94tMBQClOU1OVsXoFusElZ1DorasPiAhJGo5/lo986Vq8dTUhunww
         6gjg==
X-Forwarded-Encrypted: i=1; AJvYcCVVCXaPxo03VAKxE85m0SBMaYpqt67tWaP0IWjDQkZksu3ZvWNP15yQyc3/+bqCs8mxbChZSyAMEvYiDyz19OG2TjQQS2Xg6NjlL9CsqfxVWkXAAmcGV6zUqaAFo2hzObBtO39AYTjulNZnzswqKL/JH8r7/s9C0Ypzcam52p0exXoiLI7WnfYmdqqlrsnlfnRgxxE4ct8O
X-Gm-Message-State: AOJu0Yx9+jCx7Atv6VT+PGcZVYmyv//Qg6K2LA8UnzpjZL9Lz+OW6qFk
	3OvcteQzJOlDQq45uSqai+dayOReumuCAThqGkNeO1xeEwr9GXDH
X-Google-Smtp-Source: AGHT+IFFtxRTbFUgz0v8CxICWPJBT53jAcvblF92qIaUh3qdvoMOBMSefaw6ur3motg2fskcIQXJbg==
X-Received: by 2002:a05:600c:1e06:b0:413:28c1:7832 with SMTP id ay6-20020a05600c1e0600b0041328c17832mr2311008wmb.11.1710159145756;
        Mon, 11 Mar 2024 05:12:25 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e60f:3100:f272:bc42:d450:41d1])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c4fc100b00412f12f00adsm8976619wmq.10.2024.03.11.05.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:12:25 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: mkl@pengutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ivitro@gmail.com,
	Vitor Soares <vitor.soares@toradex.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] can: mcp251xfd: fix infinite loop when xmit fails
Date: Mon, 11 Mar 2024 12:11:43 +0000
Message-Id: <20240311121143.306403-1-ivitro@gmail.com>
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
mcp251xfd_start_xmit() fails. With the fix, if we trigger the issue and
the err = -EBUSY, the driver returns NETDEV_TX_BUSY. The network stack
retries to transmit the message.
Otherwise, it prints an error and discards the message.

Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---

V2->V3:
  - Add tx_dropped stats.
  - netdev_sent_queue() only if can_put_echo_skb() succeed.

V1->V2:
  - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() == -EBUSY.
  - Rework the commit message to address the change above.
  - Change can_put_echo_skb() to be called after mcp251xfd_tx_obj_write() succeed.
    Otherwise, we get Kernel NULL pointer dereference error.

 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 34 ++++++++++++--------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..146c44e47c60 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -166,6 +166,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
 	struct mcp251xfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
 	struct mcp251xfd_tx_ring *tx_ring = priv->tx;
 	struct mcp251xfd_tx_obj *tx_obj;
 	unsigned int frame_len;
@@ -181,25 +182,32 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
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
+
+	tx_ring->head++;
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
-	if (err)
-		goto out_err;
+	if (err) {
+		tx_ring->head--;
 
-	return NETDEV_TX_OK;
+		if (err == -EBUSY)
+			return NETDEV_TX_BUSY;
 
- out_err:
-	netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+		stats->tx_dropped++;
+
+		if (net_ratelimit())
+			netdev_err(priv->ndev,
+				   "ERROR in %s: %d\n", __func__, err);
+	} else {
+		err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
+		if (!err)
+			netdev_sent_queue(priv->ndev, frame_len);
+
+		/* Stop queue if we occupy the complete TX FIFO */
+		if (mcp251xfd_get_tx_free(tx_ring) == 0)
+			netif_stop_queue(ndev);
+	}
 
 	return NETDEV_TX_OK;
 }
-- 
2.34.1


