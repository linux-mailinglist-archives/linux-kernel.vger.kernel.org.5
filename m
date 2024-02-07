Return-Path: <linux-kernel+bounces-56214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977784C770
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857C31F27F07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88D25639;
	Wed,  7 Feb 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jRxkLwph"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73E23775
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298363; cv=none; b=Fg95kezSrXeKH6ksiwN4d0DhA71Q5bxeTFozCQlXg0NApQ4GGzNe2Rz9CXwoZ547SvDYgqokEjICcO4a78Hf1tnZeSsdnjPwVIzXYC0ZFvfNsG2p0t+EdIokf9lVbPezFD8gEKMBswo1DN+zaAh/gm06qA/V8aTod4XjxK8x7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298363; c=relaxed/simple;
	bh=Wxakw6fE1DMMi9exThr7nrt0kqXTsan4pdOnvja2w8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EePHSnDzaqO1zkYijOPOsoVxAuBWBivLx5ZZW+Q1dMN+EGqWlEjet1vWRX9unZq5o/pzPLB0NZIOiL5NTShY0iQeuSwgzddLlU37fjFL0eld0btT/wUAnZls//ySj2fVv1lpmjVUF1wjNmZzDxEp23mv3eBonrdNTw9+UzvKQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jRxkLwph; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-560037b6975so341447a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298359; x=1707903159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PJ1TfDECCRhl9e8NnkkRK2OxbkQuy+WkqaiUJY4FUE=;
        b=jRxkLwphErvBaHdBnj+XW4SC2jfRs/EHjrQzKH+yfEAwWGB84kHW+4HrG0vP6okS05
         89LWwfmWn1L9B8vhMBslNI8EUSnBFP6okWS8tZNtDbogrYOuQ9mCgUoBWhsTxZg4miya
         WbUvkGsG7N0Bl5FPpYEMUkDxT7KmrHqDfLvn6JSnD0U2Z3TKErqyDRGwibr789ScfvIs
         hhXAnRaZvkEVjsuNCpsAg4wEUaDgs/Z56dCEDSWkXVXlWnZNAHU8hUkwInjeOpd7AcOc
         TktL8iB0oZ4dB0tgQViGELA39s6HqO3bQNNeEfvmudBH5qbZF03crJSyJaCFvmEub8Kc
         P1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298359; x=1707903159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PJ1TfDECCRhl9e8NnkkRK2OxbkQuy+WkqaiUJY4FUE=;
        b=LF+hCmyVZukVIFbQtcN0rAjI9W+jd6Lgjlgt54mDvuKtlSLh+O99CJl7nTA+v1b/pX
         NLx5B5vut+d+T0KAs4sxCoJk4DhbNpgsgKwzxNF+9DqcDHKJIbTssliNOzxnEeVFehrr
         8vdPXRdJcmfm/kmmdMQWDLBqkZ1GbjjihZey47A0QdWfuiyQL0NhIdk4u1KD9saf5DO9
         qs1UXcsvtfE6tkH+Je0zU8zDao8kmIZ7UgoKiEug+QVDZPkXvUCls5IIR2h7ks6yXYHQ
         Sr5U2jV7mvqKDZ3xAYOEWhmMilf7BnasNxqaNWLO0o05YrwJMS4Lug8K2JGWctqxMmN+
         W/cw==
X-Gm-Message-State: AOJu0YyHHw5KlvkDP9I8WOGIXKgiIESY2PTNnQyUcAUCb3XB974LWa8b
	g1YoxtJN6iW0jDw4AJhFj/T0SgvHKeA4UpHXWrf/GRJptxavlwkFXOSiW1FhotE=
X-Google-Smtp-Source: AGHT+IG+yN0E/u8ZGPtyD8DAsvpuqjkGk06Ijnen0P+bYzyrJXSoe3FgzbKZtj+Q5SEQj1Lbfxc5uA==
X-Received: by 2002:a17:907:b92:b0:a38:7fe2:bc71 with SMTP id ey18-20020a1709070b9200b00a387fe2bc71mr535864ejc.1.1707298359537;
        Wed, 07 Feb 2024 01:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULePGS3+yA40vb5tJpegr7p3qAqnjVQYdvGFb9ypSVLWytfnb8WZ9lhZx35PamQBZj9GqNw+bjDHC33Hr7hEptq6sOQq2yMojFJpy4YH2KABIjwqs5IM8pwKNHgzpaMRD1weiVZkJPMNyQ9mS5gHmihTXRiwhB7Af6F0vUJ18j1QivOx/5wtgbhpKbChHXE+tvlCnxf/zQn0GaVnUbWYqrJoC2uGGk6LUmIAQqlqIG6CT403lkM0lCRSlu7JFKT9/DpG7ZCvIvc3XxaQHzgiJQtsSQnQsAThfpDReomgXbWzSIiGBAqiTSrlDMEgq3JKTSgHN4oGnPumAaZ9u6Z1TA/ztXOwBYVYmtosg9N/NTByXplVGsDALbR/d0WfQy1dL02WCbGRy4s2W/Pz+SmAKZqSA3tag6IRIDE1nubfSm8iwpqPjke0UjniBo
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:39 -0800 (PST)
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
Subject: [PATCH 04/14] can: m_can: Implement receive coalescing
Date: Wed,  7 Feb 2024 10:32:10 +0100
Message-ID: <20240207093220.2681425-5-msp@baylibre.com>
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

m_can offers the possibility to set an interrupt on reaching a watermark
level in the receive FIFO. This can be used to implement coalescing.
Unfortunately there is no hardware timeout available to trigger an
interrupt if only a few messages were received within a given time. To
solve this I am using a hrtimer to wake up the irq thread after x
microseconds.

The timer is always started if receive coalescing is enabled and new
received frames were available during an interrupt. The timer is stopped
if during a interrupt handling no new data was available.

If the timer is started the new item interrupt is disabled and the
watermark interrupt takes over. If the timer is not started again, the
new item interrupt is enabled again, notifying the handler about every
new item received.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 77 ++++++++++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  5 +++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a01c9261331d..b76fcf5f3889 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -422,6 +422,25 @@ static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 	}
 }
 
+static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
+{
+	if (cdev->active_interrupts == interrupts)
+		return;
+	cdev->ops->write_reg(cdev, M_CAN_IE, interrupts);
+	cdev->active_interrupts = interrupts;
+}
+
+static void m_can_coalescing_disable(struct m_can_classdev *cdev)
+{
+	u32 new_interrupts = cdev->active_interrupts | IR_RF0N;
+
+	if (!cdev->net->irq)
+		return;
+
+	hrtimer_cancel(&cdev->hrtimer);
+	m_can_interrupt_enable(cdev, new_interrupts);
+}
+
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 {
 	if (!cdev->net->irq) {
@@ -437,7 +456,9 @@ static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 
 static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
+	m_can_coalescing_disable(cdev);
 	m_can_write(cdev, M_CAN_ILE, 0x0);
+	cdev->active_interrupts = 0x0;
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
@@ -1091,15 +1112,42 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	return err;
 }
 
+static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
+{
+	u32 new_interrupts = cdev->active_interrupts;
+	bool enable_timer = false;
+
+	if (!cdev->net->irq)
+		return;
+
+	if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0W))) {
+		enable_timer = true;
+		new_interrupts &= ~IR_RF0N;
+	} else if (!hrtimer_active(&cdev->hrtimer)) {
+		new_interrupts |= IR_RF0N;
+	}
+
+	m_can_interrupt_enable(cdev, new_interrupts);
+	if (enable_timer) {
+		hrtimer_start(&cdev->hrtimer,
+			      ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC),
+			      HRTIMER_MODE_REL);
+	}
+}
+
 static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
 
-	if (pm_runtime_suspended(cdev->dev))
+	if (pm_runtime_suspended(cdev->dev)) {
+		m_can_coalescing_disable(cdev);
 		return IRQ_NONE;
+	}
+
 	ir = m_can_read(cdev, M_CAN_IR);
+	m_can_coalescing_update(cdev, ir);
 	if (!ir)
 		return IRQ_NONE;
 
@@ -1114,13 +1162,17 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting
 	 */
-	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
+	if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
 		cdev->irqstatus = ir;
 		if (!cdev->is_peripheral) {
 			m_can_disable_all_interrupts(cdev);
 			napi_schedule(&cdev->napi);
-		} else if (m_can_rx_peripheral(dev, ir) < 0) {
-			goto out_fail;
+		} else {
+			int pkts;
+
+			pkts = m_can_rx_peripheral(dev, ir);
+			if (pkts < 0)
+				goto out_fail;
 		}
 	}
 
@@ -1156,6 +1208,15 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static enum hrtimer_restart m_can_coalescing_timer(struct hrtimer *timer)
+{
+	struct m_can_classdev *cdev = container_of(timer, struct m_can_classdev, hrtimer);
+
+	irq_wake_thread(cdev->net->irq, cdev->net);
+
+	return HRTIMER_NORESTART;
+}
+
 static const struct can_bittiming_const m_can_bittiming_const_30X = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
@@ -1296,7 +1357,7 @@ static int m_can_chip_config(struct net_device *dev)
 	/* Disable unused interrupts */
 	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
 			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
-			IR_RF0F | IR_RF0W);
+			IR_RF0F);
 
 	m_can_config_endisable(cdev, true);
 
@@ -1340,6 +1401,7 @@ static int m_can_chip_config(struct net_device *dev)
 
 	/* rx fifo configuration, blocking mode, fifo size 1 */
 	m_can_write(cdev, M_CAN_RXF0C,
+		    FIELD_PREP(RXFC_FWM_MASK, cdev->rx_max_coalesced_frames_irq) |
 		    FIELD_PREP(RXFC_FS_MASK, cdev->mcfg[MRAM_RXF0].num) |
 		    cdev->mcfg[MRAM_RXF0].off);
 
@@ -1398,7 +1460,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
-	m_can_write(cdev, M_CAN_IE, interrupts);
+	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
 	m_can_write(cdev, M_CAN_ILS, ILS_ALL_INT0);
@@ -2082,6 +2144,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
 		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_REL_PINNED);
 		cdev->hrtimer.function = &hrtimer_callback;
+	} else {
+		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		cdev->hrtimer.function = m_can_coalescing_timer;
 	}
 
 	ret = m_can_dev_setup(cdev);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 520e14277dff..b916206199f1 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -92,6 +92,11 @@ struct m_can_classdev {
 	int pm_clock_support;
 	int is_peripheral;
 
+	// Cached M_CAN_IE register content
+	u32 active_interrupts;
+	u32 rx_max_coalesced_frames_irq;
+	u32 rx_coalesce_usecs_irq;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
-- 
2.43.0


