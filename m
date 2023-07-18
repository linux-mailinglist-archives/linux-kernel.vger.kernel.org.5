Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595FC7575EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGRH6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:57:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422CE1994
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb7589b187so8642446e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667035; x=1690271835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tf6HciWVoiOL4HjsCBCdDTuGHzKLKbtMGWBfyFkwm4=;
        b=B6B1d9nsdxH97FVeAMZ0iXNULQ3Cyk1izYY1xuNo7KRxtsv6DIxnx+vpeJb6ytSeJk
         5acAJmhf0SXU+kVdQxfAGaN3LhnN+lNcT7tK+L8QuV1QR6Yvkykju6FMHlB5j5GNf+7R
         F2te+qzAHMK7mxql1tZ+QrpGyT/RKCYUjE0/9sLmAQVGDbcrXXsJW9kCTipPumb/tAtp
         g//T6rHcVTeGtK/piQLCDY6f+fxZwCB3/v1wqofXHsPoho6E5Kdnd08E2l4JBYTvjeJr
         3jav3OBYKQ87LtXr8+Gsph9oktB2c6l+Djn+il9Bcl4FWQ2LSxwoN8+FrRhtYGAMvv8F
         2JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667035; x=1690271835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Tf6HciWVoiOL4HjsCBCdDTuGHzKLKbtMGWBfyFkwm4=;
        b=bHzkXObYZyHc8d7E709cmxsUFQOqHhTrMn4Q8s6aCC+/4AsXAsrQpaq2uwXIIZIBlH
         7jjEWHcGByJDNJ3faJ7z2maZBia7VpLCFonFH9XcVwh5kG1XCbEsTF5C7DTwfmg/uCUJ
         yjqpkphXtUd4AOduR7wMtLw/jVUFY32DSf88rc1o6zN9wFbm7hQMnkTONcxHEFHQPQhh
         bYqKSVNrukwvwx9fibyDDUlk46OlvwSeOucbis0aO1lYl8DBnYsQiCtLxPav01E/M99I
         HQiHd26gKawW0o8oiCsS/xl7hT9MD37+7/4oBsALXgMLHJIS+bi9TERNmWQrx/0NxIBX
         JluA==
X-Gm-Message-State: ABy/qLaPJe8zZ5xLUiMEFbW4ShewX34+SI6PrKGFlKV/puK3QcwwZIzG
        eC0PG1XpJlMmR1/mjdrsmWwg4w==
X-Google-Smtp-Source: APBJJlGFNI8NrFHG48Ir6X3Cd0hWAQTegSl6CqMzx3Or5E+HsrcYr47lIIt/9Fgjrsca/gJwLH3w2w==
X-Received: by 2002:a19:2d56:0:b0:4f8:5c90:f8a4 with SMTP id t22-20020a192d56000000b004f85c90f8a4mr9266824lft.33.1689667035070;
        Tue, 18 Jul 2023 00:57:15 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:14 -0700 (PDT)
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
Subject: [PATCH v5 03/12] can: m_can: Implement transmit coalescing
Date:   Tue, 18 Jul 2023 09:56:59 +0200
Message-Id: <20230718075708.958094-4-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the coalescing implementation for transmits.

In normal mode the chip raises an interrupt for every finished transmit.
This implementation switches to coalescing mode as soon as an interrupt
handled a transmit. For coalescing the watermark level interrupt is used
to interrupt exactly after x frames were sent. It switches back into
normal mode once there was an interrupt with no finished transmit and
the timer being inactive.

The timer is shared with receive coalescing. The time for receive and
transmit coalescing timers have to be the same for that to work. The
benefit is to have only a single running timer.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 33 ++++++++++++++++++++-------------
 drivers/net/can/m_can/m_can.h |  3 +++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index dd0fa58660d7..e979aeb2ef13 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -255,6 +255,7 @@ enum m_can_reg {
 #define TXESC_TBDS_64B		0x7
 
 /* Tx Event FIFO Configuration (TXEFC) */
+#define TXEFC_EFWM_MASK		GENMASK(29, 24)
 #define TXEFC_EFS_MASK		GENMASK(21, 16)
 
 /* Tx Event FIFO Status (TXEFS) */
@@ -429,7 +430,7 @@ static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
 
 static void m_can_coalescing_disable(struct m_can_classdev *cdev)
 {
-	u32 new_interrupts = cdev->active_interrupts | IR_RF0N;
+	u32 new_interrupts = cdev->active_interrupts | IR_RF0N | IR_TEFN;
 
 	hrtimer_cancel(&cdev->irq_timer);
 	m_can_interrupt_enable(cdev, new_interrupts);
@@ -1096,21 +1097,26 @@ static int m_can_echo_tx_event(struct net_device *dev)
 static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 {
 	u32 new_interrupts = cdev->active_interrupts;
-	bool enable_timer = false;
+	bool enable_rx_timer = false;
+	bool enable_tx_timer = false;
 
 	if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0W))) {
-		enable_timer = true;
+		enable_rx_timer = true;
 		new_interrupts &= ~IR_RF0N;
-	} else if (!hrtimer_active(&cdev->irq_timer)) {
-		new_interrupts |= IR_RF0N;
 	}
+	if (cdev->tx_coalesce_usecs_irq > 0 && (ir & (IR_TEFN | IR_TEFW))) {
+		enable_tx_timer = true;
+		new_interrupts &= ~IR_TEFN;
+	}
+	if (!enable_rx_timer && !hrtimer_active(&cdev->irq_timer))
+		new_interrupts |= IR_RF0N;
+	if (!enable_tx_timer && !hrtimer_active(&cdev->irq_timer))
+		new_interrupts |= IR_TEFN;
 
 	m_can_interrupt_enable(cdev, new_interrupts);
-	if (enable_timer) {
-		hrtimer_start(&cdev->irq_timer,
-			      ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC),
+	if (enable_rx_timer | enable_tx_timer)
+		hrtimer_start(&cdev->irq_timer, cdev->irq_timer_wait,
 			      HRTIMER_MODE_REL);
-	}
 }
 
 static irqreturn_t m_can_isr(int irq, void *dev_id)
@@ -1165,7 +1171,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			netif_wake_queue(dev);
 		}
 	} else  {
-		if (ir & IR_TEFN) {
+		if (ir & (IR_TEFN | IR_TEFW)) {
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
@@ -1333,9 +1339,8 @@ static int m_can_chip_config(struct net_device *dev)
 	}
 
 	/* Disable unused interrupts */
-	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
-			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
-			IR_RF0F);
+	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
 
 	m_can_config_endisable(cdev, true);
 
@@ -1372,6 +1377,8 @@ static int m_can_chip_config(struct net_device *dev)
 	} else {
 		/* Full TX Event FIFO is used */
 		m_can_write(cdev, M_CAN_TXEFC,
+			    FIELD_PREP(TXEFC_EFWM_MASK,
+				       cdev->tx_max_coalesced_frames_irq) |
 			    FIELD_PREP(TXEFC_EFS_MASK,
 				       cdev->mcfg[MRAM_TXE].num) |
 			    cdev->mcfg[MRAM_TXE].off);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index c59099d3f5b9..d0c21eddb6ec 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -85,6 +85,7 @@ struct m_can_classdev {
 	struct phy *transceiver;
 
 	struct hrtimer irq_timer;
+	ktime_t irq_timer_wait;
 
 	struct m_can_ops *ops;
 
@@ -98,6 +99,8 @@ struct m_can_classdev {
 	u32 active_interrupts;
 	u32 rx_max_coalesced_frames_irq;
 	u32 rx_coalesce_usecs_irq;
+	u32 tx_max_coalesced_frames_irq;
+	u32 tx_coalesce_usecs_irq;
 
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
-- 
2.40.1

