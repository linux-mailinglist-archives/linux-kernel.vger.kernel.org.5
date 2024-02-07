Return-Path: <linux-kernel+bounces-56217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580284C77A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F0A28530A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0392E847;
	Wed,  7 Feb 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElNcL92z"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589128DCA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298367; cv=none; b=hr2f4/kee3+zKyEfTLSBN+D7195CYY8q33FsxCJXNlFfKlM5RcuAerl9OX3SzrBUvuOf8r9aJr39hVuQUdRQY21au8qKPbfc5vvPmdEy/30bw1G1TPAROmOTyYBJcN8BvDSxIeJh8chDSkrVqLNPjffqin9koCkbg1opRml0k4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298367; c=relaxed/simple;
	bh=seS2mYXKgOsaStLXlO6Hn49jlysXxgYFKeFnkw5vJfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtKjLcE1xELcGMGXZloM3ydn6BmCwzmt4wDLMv8RH9nRXDtmaNKtpeRLgFrb2IjBL+f6HC/WlUCHUQo43FNbtxSPzYZclsDwSFO0sDDWZ5cKrJ/k/Ta0yzfG7opMIgRILj9TEJIhqukztg3H0wI8bfx0cGxyvwk6KNbtSmjVROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ElNcL92z; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3864258438so85013166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298363; x=1707903163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6gvVLaAJJ5SpKKyjtFK2dGPARZlV56P68Im7wENaso=;
        b=ElNcL92zZytcCLqFP1+TVlCj8Yovx4+m24BMXj1d58bgaxq0Qc0OezZ045zKoSb07g
         OnvXQoL1ENdLa4OVtGc2bwtpqYqnJ6mqDWAaJimF/e9xvmTmbFhDbC+SDCcaHX7vClT2
         V2bbHR8XU0M4faxIbli7xslXLz9dU2WbdhjzUZxb/mgrEc138v1x8PS1AnUoOJW3z6TV
         hbLruAJ7Fpw0yeEhWe0R/KC9QCCSvu/7Qu6hl2eJlgeEcN92JHYaazweJfp7/3cWlzfQ
         3qGTb7TOKYLKyVHKwAZBgx0UJ9xwnlKm3yy1M1zShowbQfCl88MuFnvBlzKxHMhrUhCS
         hSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298363; x=1707903163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6gvVLaAJJ5SpKKyjtFK2dGPARZlV56P68Im7wENaso=;
        b=SKT9cX9h0WIKmaITKgqlO7jmNGFBwsw258HwewfifX+5l7T9m7YjdoxdxY9C5gv+4e
         qU3VRKRzyInyALLRGohWYVehOG+77rNqA2lozxQTVf/NLPRq9+j8XzBfIcEfm16h5zEu
         w5NHV1/VK3l/ZN4BATVtrWuP8GVVaieiG4EwEBtAo1wWhRKiqanKbTbBmRTwx3YU6u9p
         6A9nftVREvGTPFCbiXfOppiaTgl7YZ+y7gVhHbG6w38PtfGBBk4sLLlctteTxpGvxngI
         IKbok/zYdTuOy8CXzIYdTZu1v8FHV2vugyXkT8GSD0LQxU+aY0c0kS4qYGstGRon+H86
         Y6hg==
X-Gm-Message-State: AOJu0YzkAWLYek82R00yuYQR0m8tzqsovvydixzGimP0XtrNprw/3shJ
	lQX3YwKr9Q5VBJjWHfPaQQ+uxrVV90NWXuI59Sv+KeZ1UXlDDZYYUTgXoePzktE=
X-Google-Smtp-Source: AGHT+IF4HNyoCZO55se0l0BPy/4YtphyGqsi+TwNxxDdF9HYXHyHZIaQGsoQ99lmVCm7Vcvr+x611A==
X-Received: by 2002:a17:906:44:b0:a38:3e90:e1ed with SMTP id 4-20020a170906004400b00a383e90e1edmr3509955ejg.7.1707298363662;
        Wed, 07 Feb 2024 01:32:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7xANWpOEcVoy0cWd1FA3d7ebTG317SnEhRB7lk6E7hkiAm5/6uwcW/39kazc+PLqt/PycVuIndwdXlbvHklivYovFU0XLCRZolNboHaIrA+inwYWFahk3rhFF814b/f/FfsQcecFwhKMQqNpTvs0ElMJRwYC18K3nh+0NwRJOLby27hHiIHAwIKn3jTppClv9Kt8buQhwqyu+N7NhRIjKk46jsnlv5eDDrkh5H3a7F6oKNqpcSzUPwu3Zt6qx28AKc1kW7nd8tdwL0hBxPNbY/5TQOvvQqf5tBjHDTwrr7U+OoXS/Up3rNS2evgdY/iSLZtAIM6NYSg92Yr13AZvtyQ4f+t2JgzH6gIe33oitODQbP1vqNvONyuk9pI8N/8H51lk156oIVFqEaK9vdivsuKZWL02jVWzYuG6qWUCFC5V/tkQH2k5FCDBR
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:43 -0800 (PST)
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
Subject: [PATCH 07/14] can: m_can: Add tx coalescing ethtool support
Date: Wed,  7 Feb 2024 10:32:13 +0100
Message-ID: <20240207093220.2681425-8-msp@baylibre.com>
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

Add TX support to get/set functions for ethtool coalescing.
tx-frames-irq and tx-usecs-irq can only be set/unset together.
tx-frames-irq needs to be less than TXE and TXB.

As rx and tx share the same timer, rx-usecs-irq and tx-usecs-irq can be
enabled/disabled individually but they need to have the same value if
enabled.

Polling is excluded from TX irq coalescing.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6dad1f569f82..b31df3e3ceeb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1986,6 +1986,8 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
+	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
 	return 0;
 }
@@ -2012,16 +2014,50 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX event FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
+	if ((ec->tx_max_coalesced_frames_irq == 0) != (ec->tx_coalesce_usecs_irq == 0)) {
+		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
+	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
+		netdev_err(dev, "rx-usecs-irq %u needs to be equal to tx-usecs-irq %u if both are enabled\n",
+			   ec->rx_coalesce_usecs_irq,
+			   ec->tx_coalesce_usecs_irq);
+		return -EINVAL;
+	}
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
+	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
+
+	if (cdev->rx_coalesce_usecs_irq)
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
+	else
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
 
 	return 0;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
-		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
+		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
-- 
2.43.0


