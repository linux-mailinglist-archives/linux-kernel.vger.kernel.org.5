Return-Path: <linux-kernel+bounces-56220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7784C78A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725B9B262B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB7224CC;
	Wed,  7 Feb 2024 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aFvKLN/k"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A235280
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298371; cv=none; b=YanQAFqqG8bZrunHJwVnjoq0PX63GbctJA/vsUV3gCF2O1RTG6+9uou+wSgyb5/GiIsZ6Kqa+Ade/pjgX6yJHigV31glwJfq2MA7uU7LpCTxND7nQ/om9uJC2IZ2MT4HUJUIAeuqiK1JR5uPbKckGFf8TwNnmDEpH/jE2HRl1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298371; c=relaxed/simple;
	bh=1vAOyna1EO+SthqMMMmklPvKJ+2Y2FePYt6xRWUzh90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTV/+XQmQtTjnOFEVZekSfRkoMIlEbwZUD2R1mjQe/a4pqpPsVCt0kJbE3NEMadSdJhTfV1wzv9BvrNnU5ACk/XWMmDreeUbu44EPkga3buDlBoqOlVLEB/I/luoHw5WqHJHaYbxkZdB0ZruViuBBTgMXk7s6J1ZsrVgGFWB67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aFvKLN/k; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a36126ee41eso54047666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298368; x=1707903168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgfTbtmUbbSiqLPaZ9cB5Jd0ck+MgVbfxN1Z2T3vuQg=;
        b=aFvKLN/k8R7+1T4S8NRug8ib6meDyJ60bvA6tGBNz8/jIJ97bqSHKkqsBh3QFsSjFi
         HDKziktF43PDIy1/d2J9Pr77ZRTyOAT0wPXE887mE8s/r95b9yHf8vJbd4glcsqC27pn
         WWLZIC3MpFPg6n5ghKJWiCmKA7AFhBJVYfTdOwlRK9Fy957OjI9TKTvluXbl1vLoHZbp
         4hmwaMRZm8GoUASUO0Mj2YZ30Jc/SLgEYbJA8adwHACAO4uVoUvRct9/dZWMzUESSold
         CZZ3lLO7rV8V9ckrDM7VrdXcVlMHylkGUaYy7FReR860b5PFFKZrAQj2N3kAv07107t7
         39Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298368; x=1707903168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgfTbtmUbbSiqLPaZ9cB5Jd0ck+MgVbfxN1Z2T3vuQg=;
        b=ACTRFJL65IYsXQizRXkMRnh4KYrt8MgaNYJ81+dVBMoK8d9NaGZRT5GvjLWqQEq754
         VPIYq38I1+vy1WKx5arFXDdd5KKwyZSj9dxlLlf/CiIRps5Ych4HpwNl67FjQQPOLK9f
         QI4c2bfpqAiI6CkyRFmT/Tnh8k/85hC4TwMf7YHlOGn7DhhCO5g7ThHOvQbZSW/+XUBv
         Sk0TuoDQKRtTHKusFZn06qWKhcIcZoHrhOKZJXnsptyQeLPJkpdhki9pyNrtIz/UjJMR
         OcvzymhuX52q/G4tCVPTWUAF2NXuS6s+gmbIEbilxkCEElOK0YKVT3hzZ+GgQvg15HPW
         UbsA==
X-Gm-Message-State: AOJu0Yw6/Dy6yhowm2xQ+E7lyrfLqAwsLoDv3bqwXPSfwnUaLubDxHEB
	XpeFgOhKWZi4LgUhrra0myu2wsVOJAYQRXH0huGGfHfmw9FXyLYeklSwT4s8bp4=
X-Google-Smtp-Source: AGHT+IHgSZuuXODaXeLgpbGpMrCW+NRrwJR+xZw6406GF98FjFfH93ed/DPPS6TjVKCJixTMUEj9rA==
X-Received: by 2002:a17:906:63d1:b0:a38:107a:94f2 with SMTP id u17-20020a17090663d100b00a38107a94f2mr3595455ejk.6.1707298368037;
        Wed, 07 Feb 2024 01:32:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUybHMDI6k2TSZskJ9jJiusRBOrylhZEhUgnPMOqXaODknCH4bHlQZ92JnbKVif6A0ySqbnujdbSE62kiSau4iw+gYi68wUO7zdQZgJhiKioSiZPTakhvzWRcBsowzWxIgw0+/g/DIGjV1VZNXtSnvaKH04hdOkVlC7p20s8+7QJgGw/GBHQ+ld3ac0rV+q3d90lhuGuEeNbCS8MJd6l+4/S+NQs78xfsecU4i7J6Wpzi7SsyQuwCSVa+AXBXmh+SUYlLOcUnYL/8AbrtVbO0w0MByuWU09erynOue+25XsFfghjGXTPHqBSEFUwRxAcHB1U7LOwh4AG1lE6+YAC4urP5C3Qwc/GzlEpVX9Aa99QZEsei6ROk1WmD0O7SMaKyiNYQAVcb+4JmiqmrGnQ409efkLZDhoAnk/jlab4nDRQVndIqynvx1Lz9U8
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:47 -0800 (PST)
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
Subject: [PATCH 11/14] can: m_can: Introduce a tx_fifo_in_flight counter
Date: Wed,  7 Feb 2024 10:32:17 +0100
Message-ID: <20240207093220.2681425-12-msp@baylibre.com>
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

Keep track of the number of transmits in flight.

This patch prepares the driver to control the network interface queue
based on this counter. By itself this counter be
implemented with an atomic, but as we need to do other things in the
critical sections later I am using a spinlock instead.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 30 ++++++++++++++++++++++++++++++
 drivers/net/can/m_can/m_can.h |  4 ++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8d7dbf2eb46c..2c68b1a60887 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -484,6 +484,7 @@ static u32 m_can_get_timestamp(struct m_can_classdev *cdev)
 static void m_can_clean(struct net_device *net)
 {
 	struct m_can_classdev *cdev = netdev_priv(net);
+	unsigned long irqflags;
 
 	if (cdev->tx_ops) {
 		for (int i = 0; i != cdev->tx_fifo_size; ++i) {
@@ -497,6 +498,10 @@ static void m_can_clean(struct net_device *net)
 
 	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
 		can_free_echo_skb(cdev->net, i, NULL);
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	cdev->tx_fifo_in_flight = 0;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
 }
 
 /* For peripherals, pass skb to rx-offload, which will push skb from
@@ -1067,6 +1072,24 @@ static void m_can_tx_update_stats(struct m_can_classdev *cdev,
 	stats->tx_packets++;
 }
 
+static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	cdev->tx_fifo_in_flight -= transmitted;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+}
+
+static void m_can_start_tx(struct m_can_classdev *cdev)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	++cdev->tx_fifo_in_flight;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+}
+
 static int m_can_echo_tx_event(struct net_device *dev)
 {
 	u32 txe_count = 0;
@@ -1076,6 +1099,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	int i = 0;
 	int err = 0;
 	unsigned int msg_mark;
+	int processed = 0;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
@@ -1105,12 +1129,15 @@ static int m_can_echo_tx_event(struct net_device *dev)
 
 		/* update stats */
 		m_can_tx_update_stats(cdev, msg_mark, timestamp);
+		++processed;
 	}
 
 	if (ack_fgi != -1)
 		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
 							  ack_fgi));
 
+	m_can_finish_tx(cdev, processed);
+
 	return err;
 }
 
@@ -1192,6 +1219,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 				timestamp = m_can_get_timestamp(cdev);
 			m_can_tx_update_stats(cdev, 0, timestamp);
 			netif_wake_queue(dev);
+			m_can_finish_tx(cdev, 1);
 		}
 	} else  {
 		if (ir & (IR_TEFN | IR_TEFW)) {
@@ -1890,6 +1918,8 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
+	m_can_start_tx(cdev);
+
 	if (cdev->is_peripheral)
 		return m_can_start_peripheral_xmit(cdev, skb);
 	else
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index be1d2119bd53..76b1ce1b7c1b 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -108,6 +108,10 @@ struct m_can_classdev {
 	// Store this internally to avoid fetch delays on peripheral chips
 	u32 tx_fifo_putidx;
 
+	/* Protects shared state between start_xmit and m_can_isr */
+	spinlock_t tx_handling_spinlock;
+	int tx_fifo_in_flight;
+
 	struct m_can_tx_op *tx_ops;
 	int tx_fifo_size;
 	int next_tx_op;
-- 
2.43.0


