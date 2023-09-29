Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DD27B348E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjI2ONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjI2ONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE51B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so146288285e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996800; x=1696601600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+rM/QYhS4mcPKAe3LyxGKzK/5QSlJ3sVw7EeYSM6vM=;
        b=1T2nCuHsyJA2sN+PPQ0EoFaDPUdNCO5brki7BZhNU0tSNfpxvV57AMvHdxShrT7xOX
         AUKVmopnDS9IQzgjegMNnx5Hkq7ZVS4A2pq4LvNuYdkOel773Cus9prnox3YAEAMqu61
         4pC4zaQGCFclxPwTLUHtm23N/hMv4a8XRFAgnRHoY47VxtIAnzBM+EG5ldfQCkfwM8lx
         bh7EdVoldXCJ6HEIduA4W8Aqmsxz9Yq9tmSuhMFFByOUbjBapP7Z03Oy7UiHMIB2452z
         xPoeTa1JHskE7jQGlSl4wD8bXgJSXrKSqPC7bxCjTBtQOcXEMJ0roZc14kO6Aabin5/1
         xi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996800; x=1696601600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+rM/QYhS4mcPKAe3LyxGKzK/5QSlJ3sVw7EeYSM6vM=;
        b=GEg0frsM919vM1CCxjKHr6ZdcycQlnimZIJ3xA2RtGwrbMPtgy5JMcxkFDfgG5ZC2x
         D0j6WdHJ6F4tdWeWnj4/Lkjit3tulS8XotezFnIlXJT+J5ssDr3pyfmDID4r0bnZcdck
         IpyERjEeUBL+23m1aBGJ38IDN5K88g4o6QT0gHVS10MBbGF5yxkMHVee89QqSED6dwXO
         xjtD2Ynk5IAzedkG8nRgFqh5UkazJwxNILiIAtUGpCjDWPFbWrnA5vrXF/3qN7UdAU4l
         WB7JctYpuYFkUPsgFFN1bv8+ROp347Rua5dSbW8x/ms6u63tyFbXKDvSkgJukUmwuTx9
         eElw==
X-Gm-Message-State: AOJu0YwxXJ8oX7VTX6i4Yo9fqygpzDG9Nhqv0K6qVkckU3kbAR/hnJeo
        im0VPGrXmOGJ1PeKy0hPer5C9Q==
X-Google-Smtp-Source: AGHT+IHYZ3GYrC4ypaDeWAMu+A+p+4b6o0y1MT67QwkILD3FBUYYnVdMKh2W+05xSbdsP2tRwDq5LQ==
X-Received: by 2002:a05:600c:21d1:b0:405:3ae6:2413 with SMTP id x17-20020a05600c21d100b004053ae62413mr3992345wmj.25.1695996800556;
        Fri, 29 Sep 2023 07:13:20 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:20 -0700 (PDT)
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
Subject: [PATCH v6 09/14] can: m_can: Cache tx putidx
Date:   Fri, 29 Sep 2023 16:12:59 +0200
Message-Id: <20230929141304.3934380-10-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m_can_tx_handler is the only place where data is written to the tx fifo.
We can calculate the putidx in the driver code here to avoid the
dependency on the txfqs register.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 8 +++++++-
 drivers/net/can/m_can/m_can.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4e9e5c689b19..645ce0c9fd01 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1503,6 +1503,10 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
+	if (cdev->version > 30)
+		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+						 m_can_read(cdev, M_CAN_TXFQS));
+
 	return 0;
 }
 
@@ -1792,7 +1796,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		}
 
 		/* get put index for frame */
-		putidx = FIELD_GET(TXFQS_TFQPI_MASK, txfqs);
+		putidx = cdev->tx_fifo_putidx;
 
 		/* Construct DLC Field, with CAN-FD configuration.
 		 * Use the put index of the fifo as the message marker,
@@ -1826,6 +1830,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
+					0 : cdev->tx_fifo_putidx);
 
 		/* stop network queue if fifo full */
 		if (m_can_tx_fifo_full(cdev) ||
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 1e461d305bce..0de42fc5ef1e 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -101,6 +101,9 @@ struct m_can_classdev {
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
+	// Store this internally to avoid fetch delays on peripheral chips
+	int tx_fifo_putidx;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
-- 
2.40.1

