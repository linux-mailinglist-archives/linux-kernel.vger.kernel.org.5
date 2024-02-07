Return-Path: <linux-kernel+bounces-56213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027DB84C76B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816C31F27B7C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF225619;
	Wed,  7 Feb 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="STwuEo/g"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E21B21107
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298362; cv=none; b=XEoETOP542u8z6WpCVOWjSsEUVlWUvwpTtL3d5baDzZMGq73vdBbkjPt8oEm+voHagUpmrPLqLTqoAywLfQ4CKN1/QIteLP/dIW0gmNTz1a6B6LP2Daa1d+nH6MC4y19RvjCEmcURqx6jz3KlngsqxXE9uLJM1yMqqm6bW7rp2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298362; c=relaxed/simple;
	bh=7bSdXgQdUcY0VNdr3J/s8h/nUNIriTpRiX0a0S7PH1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyAynuE2vjBLFTZQEE+AipRImuZwL4RcUhw2Yu8cNBawIVJ+0qAQRNQsmvXE9x7k5OBD7ztpdxj2cgihNQVpiSfIucLFdpbgPzUMupdmEe9Jvsncc7O4ux2mmtE+qPTRzGnbBdVaFrDPBFstf+l8aCn+W9ccvA0fsSmNsuyqty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=STwuEo/g; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5114c05806eso604055e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298358; x=1707903158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqIx4YPebbDa42PI5lR3HpT5nBD0XB/qzFpDRiRKWz4=;
        b=STwuEo/grSQuSHWuzhkPooX5IL9eq/y+39QuZcgyKbJ+N7Y4qWh7Ahw5O0nJYpa8JX
         X/zuomR98iFCU+acS/+EG37WEwSNvBdsMFNCvMkGSNZJWNLt61hWjsGrwiPLQ4QmwjTz
         hn9JN5Mz1afRnRy1ObI71KAhFPltQ+lwSExrif2RJOjOjC6paPZuOno0MH7zWiw+ZjXK
         3Ssd0F0r3ewOr9rffFtY+SsXc0C0kq7Dmv2ilbCtNTxeih46XLcs+BIVAAymqHwXYrnp
         kerhcINjG2jR3DGzlMF2q1P9hHiyO6uCgIq2l9xW/nhYbgMfYClEij0VwrriEEh/psRW
         rsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298358; x=1707903158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqIx4YPebbDa42PI5lR3HpT5nBD0XB/qzFpDRiRKWz4=;
        b=SGxp/7XYc+/HhpaFZRYkxHCgEzZC08Wm0V8tTBjLB3mJWtwZkGd+oJH2MVOShgfMsp
         R44zLSofOYyD3PJLPS3kyh9CkhyyQND3TeYkuthqYCU9/pOAfWdiTm/vtzkatXbu5oHh
         CnpS26hup+mw1jOGNOs2rWvFhX91DWYN+g7gbZRQQMFt/Oi0icqt4UEI8/Myt4ah8V56
         f0EulpW7afriTSeG61+fW7WRV+0VDG532z5JXxYD8/da0heNwJ/kfOOK600JwkNayhBh
         BGwh5hTFGrCMaiOjOYoVtDU7WHjG9AGNBxxEAuZM/t12FSeRSp66cqH3yv2z1fDCY+EW
         w82g==
X-Gm-Message-State: AOJu0YzbQiWrias9uHpN7bjAV9aF5mbYIUN7j/NJVBKgXO+tAcF22xg7
	Uqf1TgbFqo5gCNaetKWT9HdbPR1YhmRDriJg8RiT2JwpOnDcQD5YFxUR55sRZNg=
X-Google-Smtp-Source: AGHT+IE/SEcep+YYjl96mIk1b9dSvRfHe8uUA/txSmvSgMmrcoUo/rNI+3B36GkKhNOvK3KPBKkXRw==
X-Received: by 2002:a19:5f57:0:b0:511:51a9:7759 with SMTP id a23-20020a195f57000000b0051151a97759mr3912294lfj.64.1707298358354;
        Wed, 07 Feb 2024 01:32:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViyuYpZSFAh9YXyT4xbYF9rpB2bg7/qwN83vxYPI3PqTLT9mTjDBWutcVFxx25llRWCWp7eWSiimanYiJqfwKA4atnLCP4aiFHGIJ9vLYG8e20DKQf6O4goKx7sEd9FOj/LQ0xvua0CNl2Bu9Osf1BWQTY3PFJpl+IQIDjU3hanQRFyoN50k3UYismIncBA6kTWD+M8IjZt82VER0h04OwTgRUpWhM5MhnH1p73JxumCIwjAkKIsukzwmKxWwAblouOCxtDaRcMDfHUb/MYTjTNVZv2SZYJ++UF1CGUoLnvrXHwU1lhL6D1BIcy1zYrH09RzfgPuh5VZ9rt7cY9LOEB4E3OZRXlHqS/pJiys/aGVvzoljPQ4oE30bWgbCy4jQI2sz9cHOVEffVojoyo+pwc9T96lWiskNgYhFZ3MEA/saChNvW0tpRWa2A/q24PZh2YhKDIZEShyYN4I2S+Oq80zqPSi2i
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:37 -0800 (PST)
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
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH 03/14] can: m_can: Write transmit header and data in one transaction
Date: Wed,  7 Feb 2024 10:32:09 +0100
Message-ID: <20240207093220.2681425-4-msp@baylibre.com>
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

Combine header and data before writing to the transmit fifo to reduce
the overhead for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 45391492339e..a01c9261331d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -320,6 +320,12 @@ struct id_and_dlc {
 	u32 dlc;
 };
 
+struct m_can_fifo_element {
+	u32 id;
+	u32 dlc;
+	u8 data[CANFD_MAX_DLEN];
+};
+
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
 {
 	return cdev->ops->read_reg(cdev, reg);
@@ -1637,9 +1643,10 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
+	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
+	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
-	struct id_and_dlc fifo_header;
 	u32 cccr, fdflags;
 	u32 txfqs;
 	int err;
@@ -1650,27 +1657,27 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
-		fifo_header.id = cf->can_id & CAN_EFF_MASK;
-		fifo_header.id |= TX_BUF_XTD;
+		fifo_element.id = cf->can_id & CAN_EFF_MASK;
+		fifo_element.id |= TX_BUF_XTD;
 	} else {
-		fifo_header.id = ((cf->can_id & CAN_SFF_MASK) << 18);
+		fifo_element.id = ((cf->can_id & CAN_SFF_MASK) << 18);
 	}
 
 	if (cf->can_id & CAN_RTR_FLAG)
-		fifo_header.id |= TX_BUF_RTR;
+		fifo_element.id |= TX_BUF_RTR;
 
 	if (cdev->version == 30) {
 		netif_stop_queue(dev);
 
-		fifo_header.dlc = can_fd_len2dlc(cf->len) << 16;
+		fifo_element.dlc = can_fd_len2dlc(cf->len) << 16;
 
 		/* Write the frame ID, DLC, and payload to the FIFO element. */
-		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_header, 2);
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_element, 2);
 		if (err)
 			goto out_fail;
 
 		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+				       cf->data, len_padded);
 		if (err)
 			goto out_fail;
 
@@ -1732,15 +1739,15 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 				fdflags |= TX_BUF_BRS;
 		}
 
-		fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+		fifo_element.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
 			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
 			fdflags | TX_BUF_EFC;
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
-		if (err)
-			goto out_fail;
 
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+		memcpy_and_pad(fifo_element.data, CANFD_MAX_DLEN, &cf->data,
+			       cf->len, 0);
+
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID,
+				       &fifo_element, 2 + len_padded);
 		if (err)
 			goto out_fail;
 
-- 
2.43.0


