Return-Path: <linux-kernel+bounces-56216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7D84C779
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0E01F28877
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7097E2D61B;
	Wed,  7 Feb 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sCHo6hr4"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1525772
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298366; cv=none; b=i4DY8oO/TuYOSB4WoA3Lmnoq44zBWgmaUe6H7QxAMvT07QlryKTaoi4aMFnhn9h9qM10wWAA0pCdZ4MGs/DJNMBVSaOvadY9UKt9UMIid4OKkB+hfeIvikcxYVQGExE1qxZccY54BEf+ojio3UOqBqY6T/7qyT2Ymn+RcigId8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298366; c=relaxed/simple;
	bh=JRTeU/WQ3xKHyIzAInVb+YB994geyTmL8GEhny2GOLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKoO36VgK5t/GMyTQVLQevyaucUaCc9FUELOi0KZpVhKXMmMnKLLN/Y+I+HWsflWLzrYX8Nzfu7k91wUQ7BhQl4LI70JvqFLO0l4DQgmH8BOcClGzJSiMw6GO8gA6br9PmZFmp11LyjCXukK4OetiF7L0cAIM/7aABS5K+x7/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sCHo6hr4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511234430a4so759546e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298362; x=1707903162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecHvachtVAv6sW84z8AsSsUI9BS/8T7kEDPcbDUA3lM=;
        b=sCHo6hr4gpfyvdu6NAPW/86TDVtWjC3OvdBvwHZ5gIQZ40omJLYxlP76kc4hRgT2BS
         cBNBKaQdCsNcicm69t1PgOzNB92ax1OJMtowTRKH1TwCxLQ7Qa+TI//X4t3tOPiddj1D
         72EWN8VtdjiDFnmPSTrm55XRezSGInSg9EdnkQl70/olZllxEOdDO+CMgnb69ZQdJK0u
         SqvwfgRsDqrv7l24tWDjiwrVjK7FW9+XQrzZSxmRSx3Ja2JbtiDKUzmU75Yf4/29gMO5
         KpRzNzWxDeOikR7TyM9lm2XE3L0nIB6oYwKgmAUc2W2+xpzU1wyf7hsnssbHDoAk+Kfe
         F4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298362; x=1707903162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecHvachtVAv6sW84z8AsSsUI9BS/8T7kEDPcbDUA3lM=;
        b=jh9aRKM+uI4ikMPz5SpYxeoHCIWhUhQdJk/Hxqn0VJjbbwNrDWathQLQwC6IgB6XM3
         jzkTnD3GRGRYtezmEMJmXGVRlnmFUTGCYsORP7PYuDclr/spg+RojWFUNurWtsJDKUbY
         pByZAe6rgldWy1NlvjRbbrWvXp5gOkv0oSe8oCuW5Yi/rPWnj5S0af7Uln9s9XgSzv0R
         jDcc3wIDHPAnzptHb/V4xCTVDYV58NlevOKq1vyaAWcNqCGio4d7FjHHg5B5stC/qPzA
         lltipdPRt7FzGks88rDt39Aw/CiRAc2byPfE5YGMtwy0z7C8RZLZOldhcpeW0M8yeaY3
         g6VA==
X-Gm-Message-State: AOJu0Yyiamoq5knY9d2F8+ebrUunCs099kTxr/7A02OKvJBGy7YS5vni
	IZ8sC5tcIGXVrgI+z6MIyGl/E0rcD6JKWipRSTOcW6pu+17GPKhgdQyRch7VGpY=
X-Google-Smtp-Source: AGHT+IG4xCnOjsLrRUcNuGS7caw38M+9njqUmb40A1WXpFOFy1FQWE4KoM39FRiymyeeDPpJDhbtsA==
X-Received: by 2002:a2e:a273:0:b0:2d0:9322:8d0f with SMTP id k19-20020a2ea273000000b002d093228d0fmr2829069ljm.26.1707298362563;
        Wed, 07 Feb 2024 01:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe/gF7sBIbzhAK8HMgggca/Dyc7ERgBXVfAucw/KnZW92CbTCvyUBIm/Rpa0lEveRXoBszuehhJqGLz31rjS4qu/qhN6XpUlgw/pNE8QfPeG7eA+lwHAA1wWmS3A9f8ug8HSQ6DKF2EJ0jcjj/xBTAUEkWwCMRAmLow4eElvKkwUnztU0ialSBVhTsfK71umwzASMR33wTiZgN/ClKbPskxxVuzdbRzWA19pX6X0wT9fmxsLcjaN9S/fZzxUB6SdCpsugyRZFlnaWqJgDildZXwc5XbcllM4KlPqVDi9WhRBiMn0ohFneW4AWY8hG0etb5GQ0KpIrYQ9oLwN5OfvLF3T2WnDQSHdy92v1uyb8LfpXu8EslEIe+78s/WNclItuAS/SYkIpjgGzK0w4rA5YzuwIV4ICx+bPvj2RLTg8myyuDJgYPAJRcP17U
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:41 -0800 (PST)
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
Subject: [PATCH 06/14] can: m_can: Add rx coalescing ethtool support
Date: Wed,  7 Feb 2024 10:32:12 +0100
Message-ID: <20240207093220.2681425-7-msp@baylibre.com>
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

Add the possibility to set coalescing parameters with ethtool.

rx-frames-irq and rx-usecs-irq can only be set and unset together as the
implemented mechanism would not work otherwise. rx-frames-irq can't be
greater than the RX FIFO size.

Also all values can only be changed if the chip is not active.

Polling is excluded from irq coalescing support.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 55 ++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9b3e8e09f3aa..6dad1f569f82 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1977,7 +1977,57 @@ static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int m_can_get_coalesce(struct net_device *dev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kec,
+			      struct netlink_ext_ack *ext_ack)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
+	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+
+	return 0;
+}
+
+static int m_can_set_coalesce(struct net_device *dev,
+			      struct ethtool_coalesce *ec,
+			      struct kernel_ethtool_coalesce *kec,
+			      struct netlink_ext_ack *ext_ack)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	if (cdev->can.state != CAN_STATE_STOPPED) {
+		netdev_err(dev, "Device is in use, please shut it down first\n");
+		return -EBUSY;
+	}
+
+	if (ec->rx_max_coalesced_frames_irq > cdev->mcfg[MRAM_RXF0].num) {
+		netdev_err(dev, "rx-frames-irq %u greater than the RX FIFO %u\n",
+			   ec->rx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_RXF0].num);
+		return -EINVAL;
+	}
+	if ((ec->rx_max_coalesced_frames_irq == 0) != (ec->rx_coalesce_usecs_irq == 0)) {
+		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+
+	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
+	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+	.get_ts_info = ethtool_op_get_ts_info,
+	.get_coalesce = m_can_get_coalesce,
+	.set_coalesce = m_can_set_coalesce,
+};
+
+static const struct ethtool_ops m_can_ethtool_ops_polling = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
@@ -1985,7 +2035,10 @@ static int register_m_can_dev(struct net_device *dev)
 {
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
-	dev->ethtool_ops = &m_can_ethtool_ops;
+	if (dev->irq)
+		dev->ethtool_ops = &m_can_ethtool_ops;
+	else
+		dev->ethtool_ops = &m_can_ethtool_ops_polling;
 
 	return register_candev(dev);
 }
-- 
2.43.0


