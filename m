Return-Path: <linux-kernel+bounces-97219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC826876725
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC8F281ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35401DFFD;
	Fri,  8 Mar 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUB1koLv"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367E1DDF5;
	Fri,  8 Mar 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910965; cv=none; b=LHafwtYfTYcKCrT88Q6dKQ2HS63VfTtB+VCUBR2nqpZC6uNm8jG0k3Rnfohqal5iUqcl/wy2aEWHdVQOQ75k09Qmzg8NCgNjhfTZiPP7pTq9htwVkRMVlmnJnD1gcA2c45gZywPgNAPrgOGRlahU3gn2MoOHCu06oLMDVTxH6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910965; c=relaxed/simple;
	bh=UlGThBL0mype8rKMqVUNZdexbUttWPD0gQWs6oSKUJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FIelDlFA8M7iXWmXer2nNZnTY6VdxLiluWzlhXux3FWTnWwSy1+aQQLlgNmCpzqGLOASL1ydXYmvf4ymMXuakjHIqkuqqW76tsNNJxldU6kA+IxOoyI2zTyV1a5gmvqP3f+CD0HAgTyqyuf9DjfvzS22sg613J6GA1difXeoR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUB1koLv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e17342ea7so586946f8f.2;
        Fri, 08 Mar 2024 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709910961; x=1710515761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBHHEvGHLyfPz090SoS5964VXYbgui3sU4Q98yLZgC4=;
        b=CUB1koLvFYbYgHbdnuoRF/aJJJKkFWhCYpjx7nZhjuhBNy0LS5GaLLgnLDVVtF6owO
         gMvvxbNY4LPa7HwDUJqi9/l4GHC+hK0xn0alx8yFehxpMnoqfGLZWwfEh06/UG+Bwxre
         Od3I8e6L3HbhuYVMl/xWPiACqOj0n/Pldi2gG/MPq8Pm9810VyEK7suaiC81FWRUVNHn
         kbc1U4rJxgNiax1uygWze0hXudaqW7dtuZGCuxMsYJJpugJP1mPr84HpgrsqYoFDzIWI
         BhSRwVFeY/0nlXkJsFfspizfi4orFeaSlMi+U0w2oqtGgw6O5D5JJcYX3U6IynzoBv32
         ho0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709910961; x=1710515761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBHHEvGHLyfPz090SoS5964VXYbgui3sU4Q98yLZgC4=;
        b=RnH250x4QEtLmB2Xycc0kbIZ5wJG7aPPc0+nd/Eo05W61glkfXheg3Ofx1nu0hJCnq
         WXYBY2TYpI/Rmh25D6CckLNg2BqxiHe1Vnymp3biq1NnObI78AyIS4gtt0xUcS2vgifN
         yPqTQ9608TDLFo4u6oB9pJ/LXxbIgNvbLSePZOZca3QkX660JsMRwDInLA+1+s9cc6zP
         gIkNCrZ0rFI0miTILhXKO4Fvs9xpTdbOrfferRAra3yMjzNMVUmFh2VYyrBqBry67+hx
         7Qw7l2R7xYheFsUo702TEGpLRhhBZQ2XWnPtF2PFZSqmF3jmq3rJ5kDOrbu+6oA8ZBUD
         SbqA==
X-Forwarded-Encrypted: i=1; AJvYcCVLsMCBYBzonBZCc2Guig5YHTI1qXOjrgWcdysCT9oWRYzyxQV9WBZPheHtdw3DM3EYBAZQLV/5NVMRLqWkBQ07jz4aVrwIxLbHDlTZaJghxRvWdE5UlRDuS4ju5DgQzl+rdOYVTYx27h47s02/sd269+D8c6B7ooevgHf2QSTbihxeuAuk9ycanCM7ZpxiyFzGv/yxNgR/
X-Gm-Message-State: AOJu0Yw7HmZwEAzqaIC4AE5hpdJ5KyRYxBt3k9Wr2sIAhSvIhJsoBfHb
	0r/a/RTpel3nCnpIb+EszuK63Pj+1RDlYHiyH+REBomybzjSXUd+gN4lpCDfcUo=
X-Google-Smtp-Source: AGHT+IEW9ecarcYMf0OiMd2G9kSzOy6AtLX3CbznekksoC0zEyu0vBNGlgxia6oA6TfJSJGMCc4z8Q==
X-Received: by 2002:a05:6000:18af:b0:33e:78d8:34fa with SMTP id b15-20020a05600018af00b0033e78d834famr1352072wri.17.1709910961299;
        Fri, 08 Mar 2024 07:16:01 -0800 (PST)
Received: from vitor-nb.. ([2001:8a0:e60f:3100:f642:8b0a:d2f8:3e61])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b0033e5b28c97csm6282636wrr.37.2024.03.08.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 07:16:00 -0800 (PST)
From: Vitor Soares <ivitro@gmail.com>
To: mkl@pengutronix.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] can: mcp251xfd: fix infinite loop when xmit fails
Date: Fri,  8 Mar 2024 15:15:23 +0000
Message-Id: <20240308151523.191860-1-ivitro@gmail.com>
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
processing messages and the interrupt routine does not return,
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

V1->V2:
  - Return NETDEV_TX_BUSY if mcp251xfd_tx_obj_write() == -EBUSY
  - Rework the commit message to address the change above
  - Change can_put_echo_skb() to be called after mcp251xfd_tx_obj_write() succeed. Otherwise, we get Kernel NULL pointer dereference error.

 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c | 29 +++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index 160528d3cc26..0fdaececebdd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -181,25 +181,28 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
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
+		netdev_err(priv->ndev, "ERROR in %s: %d\n", __func__, err);
+	} else {
+		can_put_echo_skb(skb, ndev, tx_head, frame_len);
+
+		/* Stop queue if we occupy the complete TX FIFO */
+		if (mcp251xfd_get_tx_free(tx_ring) == 0)
+			netif_stop_queue(ndev);
+
+		netdev_sent_queue(priv->ndev, frame_len);
+	}
 
 	return NETDEV_TX_OK;
 }
-- 
2.34.1


