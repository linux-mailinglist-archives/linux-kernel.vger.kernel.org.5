Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A1B7B3481
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjI2ONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjI2ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DF61B5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so4554421f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996797; x=1696601597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCQIoaJbLKII1l0AGqTW1Bk8v3XX8EQRXCDvUWkrfVU=;
        b=kNEfY/mpmmx/3obmfSoRPyK3d64FG/6uJcQXiLahkoFX8I+rCp/5/PBvmNart2NZId
         Cl/vWIJp+vgATxo94YNdCPeXZzZVTMa9K3Sjy3N72SmgjkfE/MUt2kODFucYWTtnt0Km
         jmzkiUcjQlFVU01C1QyPdJoZAxSMX/sP5aYa5wn18v2pMNfxfQP58hSBD1jqEhqu/OU5
         ZtxvVzClhhUpZ+76T7vUny3w3ihXdTCvrRd4TPP1xJog2msJpdcV4vbWxkVsHCykbl9J
         s3TreMi3yUJc6LROg4zGChL/miZ4dqxrG+NaCyqcjWEULkVfY37KeGNLkbIq/J95Xagk
         1NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996797; x=1696601597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCQIoaJbLKII1l0AGqTW1Bk8v3XX8EQRXCDvUWkrfVU=;
        b=p4qsVHjpCU31ThSGNMh/KeVKhNkVMggRATOqS0edPaejVKV7SG3cTahKe5NSAQKQkv
         d4QbwqeU3HZNS79Z+A3XxJ8KWNy912bBZpKIs7y9PCNyZ0nWy8J1sI4hpXOJ6NzlnVLp
         OGT9jIgrdXqztNLA9wmGgTHfQtXvn5a+HT1zk4lEDJmjOir8jiKGa2FjBzP3nyzOK749
         eUcAaRY5sBuV8KemefPI4pApLZh5HINgP3Wn/WYLdsgjroNQ38GngpnJAzzhAXbMvLIm
         9t+XBQw6Q3ELhk9iqk116QfK98+3GY5MK8KJDbIaR3UfpizXSAmax0whuDERiTR+Lglg
         NMTQ==
X-Gm-Message-State: AOJu0YxdkNfFjZFeMXHKhei5Bs9+EbmoXfb9xUnOu71A5WP+KcmJG8Y1
        Mqd9ukx8R6n3LzBGTfLueqXJCg==
X-Google-Smtp-Source: AGHT+IH0COH0xd0nQOPP0KuLaTXAjsN1EjNLRJnC6bT/YKQXLScCS47tM4A3SLjQUbxugFAHmXINnw==
X-Received: by 2002:adf:de0a:0:b0:31f:fb5d:96da with SMTP id b10-20020adfde0a000000b0031ffb5d96damr3728023wrm.64.1695996797063;
        Fri, 29 Sep 2023 07:13:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:16 -0700 (PDT)
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
Subject: [PATCH v6 06/14] can: m_can: Add rx coalescing ethtool support
Date:   Fri, 29 Sep 2023 16:12:56 +0200
Message-Id: <20230929141304.3934380-7-msp@baylibre.com>
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
index b20edd64bb7e..546193ab6e0d 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1976,7 +1976,57 @@ static const struct net_device_ops m_can_netdev_ops = {
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
 
@@ -1984,7 +2034,10 @@ static int register_m_can_dev(struct net_device *dev)
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
2.40.1

