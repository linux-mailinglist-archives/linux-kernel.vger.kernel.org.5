Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B317B3476
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjI2ONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjI2ONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4D1B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so40016865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996793; x=1696601593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1ceCWHuA/YvTIAM9KuiB1pW4xq7NApKmNFkwb8cZVs=;
        b=pGg4FdbIS4hmPr00Cyy3WjMkna0QGmrLI1NHgLbL/PG+YgTc6EgKPzLLHyd0GoGzj9
         OyGEOe+frtm/wi3hFZobXnY/NEYfxFgvcve0C/Vfm0X/IHn0R3SCwQHdu4nVNeNm+mCi
         dZQjXdFZ1qfrfy+HysonCsoaitUe3PQLaFN0xhLL3kutbDxSl/BKJgVDCjzk6VBHesv5
         7HP8PHQ0kroImXa8uJ9pZZieWG+IE2irgGcbHWVeiGwDfpZv34Vv/TyRjlgWEA7Ovvl6
         WZrjTl11wh/1arh31AqOSvEDl5m06v0kbT7pJxYwPjY0mnC3c1NrDwlewUsftDHaRejB
         ADZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996793; x=1696601593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1ceCWHuA/YvTIAM9KuiB1pW4xq7NApKmNFkwb8cZVs=;
        b=tFm8jFL2dAxoypI/CJ3goaHKKQkhEv9/IoA6043IV1eCPfMll/MLOx+/wjby3+icem
         lGyMaCekW2bsElyD73rZpQEWCivuRuji6GAfP7/FH6RKIBHK8eoQlnWR4xChDmNSCmRQ
         xAVgPOxpvcYqSKXpRZi5r0nrrDGkL3D4LwC/EnSFE6FWOjgApu6Qigb3FaUvviiT7ReT
         YxomU4jXqOVMikaUpV/pOTN0G+KUO5DaSYLoHDMKGN+QoahALJdao4JSQSHpnhtStMOb
         0395g40E9dI5PYRzYLBDojLEVpsenX1Tu7Lr/OADexi3kKFd37CYlJw0vSiCQkvuUfE2
         7hhg==
X-Gm-Message-State: AOJu0Yyw+FkMARndeVSyO+DzPAAfm7fnQfT/Vk/OBSX6R9DC9uQeyiH/
        m/5tWTbXOUXD00l+vk9BUXASqg==
X-Google-Smtp-Source: AGHT+IHXIXXRVfezPDJZpoexLnRqeq/3FllNEWVQAXo4PlcqEd6Vt4CADdQazRqWLkqtALCTgf05dA==
X-Received: by 2002:a7b:c7d5:0:b0:401:c338:ab96 with SMTP id z21-20020a7bc7d5000000b00401c338ab96mr4366326wmk.34.1695996793666;
        Fri, 29 Sep 2023 07:13:13 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:13 -0700 (PDT)
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
Subject: [PATCH v6 03/14] can: m_can: Write transmit header and data in one transaction
Date:   Fri, 29 Sep 2023 16:12:53 +0200
Message-Id: <20230929141304.3934380-4-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.40.1

