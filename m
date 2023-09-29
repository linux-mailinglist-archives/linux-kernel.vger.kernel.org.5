Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C67B3486
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjI2ONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjI2ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC0CC2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so108443625e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996798; x=1696601598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHWXcPt8CLFE4Grfzc8XZlmrz9AJKUqi/14pD9LRVmk=;
        b=c7lGh5WVM2ASu/EHMTBoSnlK9ZBFlhnMlbKtxYZ9GNfzZQ5ZCh1B/pyNnD4h1W/1HB
         7k1hY0q+68gpjkAJ4mzM07dIkwf7TrIywpk/AUcGjjg5fPVq0xw4o6KWnPMoswbj7phI
         oXxRqoWz2kBtafOF9WaSZb9GooWEa58n6CdIS0dW4/X+YqswCk0dE6NJFKnlICMlgPW8
         th7vasWev933Hy/lHM4POEPhDqGGgvZHjjeKp41R8T3gHmPPJWFLkstLw2px066pkZln
         qkUmuILzE27/yiNi/vpSOXU1dIO6/lWsj/Lmen5SxfFzds7zcLgHhzT6O/rb3rUM/fMc
         sHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996798; x=1696601598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHWXcPt8CLFE4Grfzc8XZlmrz9AJKUqi/14pD9LRVmk=;
        b=q1A0YRv0HCwyV2VAQYoXiH1JOfJYOT9RL57bUrtMz3rre2N52fukURLHZ7rgaVaZB7
         6l5HWnPp4qQilBKXBiIehw2bA6+mCMVSVwEheE1pImwbW3uWSd1utuadRG2wBDPWO8UC
         CrAQVtLD4W5bTXrAb/834+uPJyeGnv1k119Y1A2NfIup/x5VS2xyAePSN8pfC8oDvrAG
         Rrzv+p1CH5dTW5TGCMLLCRPFk4UESWJV2vSj4zFmf+A4Dwmz4yBXqpZBFWzqpQkHafmH
         maJZa1wVXjpZLRxu4nRQme705GFAdP391x581RXqoiBxfB0izHfiJU4CE74KnAIh+C7z
         wTEg==
X-Gm-Message-State: AOJu0YxWrTNo0+RKxkKRhaSunX2rDTg+ez7Xfl4ayyrXgxGuUCVTTBbj
        qWWxxlmdhRFblF0KDZ1ulazufQ==
X-Google-Smtp-Source: AGHT+IEdGnLSLZqW01C1jw5dQYyVWD30KEFa8nNeZ2tBfP8adQ2H0UJdQsTpEo4n5Ig8zwt9XS+n5A==
X-Received: by 2002:a05:600c:1e18:b0:406:599f:f92c with SMTP id ay24-20020a05600c1e1800b00406599ff92cmr2274668wmb.20.1695996798348;
        Fri, 29 Sep 2023 07:13:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:17 -0700 (PDT)
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
Subject: [PATCH v6 07/14] can: m_can: Add tx coalescing ethtool support
Date:   Fri, 29 Sep 2023 16:12:57 +0200
Message-Id: <20230929141304.3934380-8-msp@baylibre.com>
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
index 546193ab6e0d..1c021d99bae2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1985,6 +1985,8 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
+	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
 	return 0;
 }
@@ -2011,16 +2013,50 @@ static int m_can_set_coalesce(struct net_device *dev,
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
2.40.1

