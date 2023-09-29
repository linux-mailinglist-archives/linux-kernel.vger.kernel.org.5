Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4E7B349C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjI2OOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjI2ONq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577110DA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso112627265e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996806; x=1696601606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYi/IXoXH4aaqSgKH1Ri6KQTSvYj+aQyOmWY2DZzpZ0=;
        b=2nNIaOEdksFW4KhNvn/TIZxwmySKvFYKZw7wJh8RUoteRhGYsPGKX/8bt/uWeFQETl
         B+MyFbIhVDHz5iqcM+XjQgPA+Invg0nmJhBIpLbjEF4NDSVOwZmEsjra2hEDcfKL0t1d
         FTH9x2Ih1e8e96OGxSSzn03r5r+O6R+5cf+DwA6RZSiTcs+JPEF2xGjROIoenj8R0Whs
         xflka9zk++IWV6aXO+pEvu4grghDkpOP9OB1s4H6kubQtF5zq37BsqgjvLuxXh7OYhD/
         A/MuTjWXOKR4PiIbJLzOg3co4TBTYzl+YGHcXg+Fff8SKF1s4X+JizPWTfJ3OoKC3dFY
         J5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996806; x=1696601606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYi/IXoXH4aaqSgKH1Ri6KQTSvYj+aQyOmWY2DZzpZ0=;
        b=ZMBRhga144gLjfUggDYVRRrmogc7dfm4F/kJ4bUusPrXFxl2YbHQYIok98TsE7Au/d
         Db13tI4OilBlshDUCMvx2ocvctpOCPP2wHpYnzsPwcXrDysSy8ci42Az20rUtzTEztZM
         5uqBdvRDM1NPw68lcwyQz4ntFMp5rPTOrXfRWDj2Z46ydgPJ3NWOBn9kZjEx+wP6QiPw
         cnEEoolEESASbdXwe7K4DrtO8wdXVC9rJfY4MOg9ix93ot63kvumgWTpY+jws3shJBXs
         1Lchd3ryRLTFBWirIHYy6FMDN1+XuGO7ohqA4b86MvXalY6oAZc+qhKYz0YDzQfkCrJd
         8mtQ==
X-Gm-Message-State: AOJu0Yyz/z7ui9MTz6BiThl81+h4yi27fLxvlYqY8Smz4nQwxcMaNQig
        hG3sB+okh4dte6MHUdVq8h3Waw==
X-Google-Smtp-Source: AGHT+IFnzi2Ap9oJRiMhAZRXHWhPqNRKmfzfdXXHyYAOtLumfvAL1EsuWlVVTjKOc1W4EIKsdWwaLA==
X-Received: by 2002:a05:600c:210e:b0:401:bdf9:c336 with SMTP id u14-20020a05600c210e00b00401bdf9c336mr3978579wml.27.1695996806180;
        Fri, 29 Sep 2023 07:13:26 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:25 -0700 (PDT)
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
Subject: [PATCH v6 14/14] can: m_can: Implement transmit submission coalescing
Date:   Fri, 29 Sep 2023 16:13:04 +0200
Message-Id: <20230929141304.3934380-15-msp@baylibre.com>
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

m_can supports submitting multiple transmits with one register write.
This is an interesting option to reduce the number of SPI transfers for
peripheral chips.

The m_can_tx_op is extended with a bool that signals if it is the last
transmission and the submit should be executed immediately.

The worker then writes the skb to the FIFO and submits it only if the
submit bool is set. If it isn't set, the worker will write the next skb
which is waiting in the workqueue to the FIFO, etc.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---

Notes:
    Notes:
    - I put this behind the tx-frames ethtool coalescing option as we do
      wait before submitting packages but it is something different than the
      tx-frames-irq option. I am not sure if this is the correct option,
      please let me know.

 drivers/net/can/m_can/m_can.c | 55 ++++++++++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  6 ++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 286c88132370..b351597f594b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1536,6 +1536,9 @@ static int m_can_start(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	netdev_queue_set_dql_min_limit(netdev_get_tx_queue(cdev->net, 0),
+				       cdev->tx_max_coalesced_frames);
+
 	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	m_can_enable_all_interrupts(cdev);
@@ -1832,8 +1835,13 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		 */
 		can_put_echo_skb(skb, dev, putidx, frame_len);
 
-		/* Enable TX FIFO element to start transfer  */
-		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		if (cdev->is_peripheral) {
+			/* Delay enabling TX FIFO element */
+			cdev->tx_peripheral_submit |= BIT(putidx);
+		} else {
+			/* Enable TX FIFO element to start transfer  */
+			m_can_write(cdev, M_CAN_TXBAR, BIT(putidx));
+		}
 		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
 					0 : cdev->tx_fifo_putidx);
 	}
@@ -1846,6 +1854,17 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	return NETDEV_TX_BUSY;
 }
 
+static void m_can_tx_submit(struct m_can_classdev *cdev)
+{
+	if (cdev->version == 30)
+		return;
+	if (!cdev->is_peripheral)
+		return;
+
+	m_can_write(cdev, M_CAN_TXBAR, cdev->tx_peripheral_submit);
+	cdev->tx_peripheral_submit = 0;
+}
+
 static void m_can_tx_work_queue(struct work_struct *ws)
 {
 	struct m_can_tx_op *op = container_of(ws, struct m_can_tx_op, work);
@@ -1854,11 +1873,15 @@ static void m_can_tx_work_queue(struct work_struct *ws)
 
 	op->skb = NULL;
 	m_can_tx_handler(cdev, skb);
+	if (op->submit)
+		m_can_tx_submit(cdev);
 }
 
-static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
+static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb,
+			       bool submit)
 {
 	cdev->tx_ops[cdev->next_tx_op].skb = skb;
+	cdev->tx_ops[cdev->next_tx_op].submit = submit;
 	queue_work(cdev->tx_wq, &cdev->tx_ops[cdev->next_tx_op].work);
 
 	++cdev->next_tx_op;
@@ -1870,6 +1893,7 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 					       struct sk_buff *skb)
 {
 	netdev_tx_t err;
+	bool submit;
 
 	if (cdev->can.state == CAN_STATE_BUS_OFF) {
 		m_can_clean(cdev->net);
@@ -1880,7 +1904,15 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 	if (err != NETDEV_TX_OK)
 		return err;
 
-	m_can_tx_queue_skb(cdev, skb);
+	++cdev->nr_txs_without_submit;
+	if (cdev->nr_txs_without_submit >= cdev->tx_max_coalesced_frames ||
+	    !netdev_xmit_more()) {
+		cdev->nr_txs_without_submit = 0;
+		submit = true;
+	} else {
+		submit = false;
+	}
+	m_can_tx_queue_skb(cdev, skb, submit);
 
 	return NETDEV_TX_OK;
 }
@@ -2024,6 +2056,7 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames = cdev->tx_max_coalesced_frames;
 	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
 	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
@@ -2068,6 +2101,18 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames %u greater than the TX event FIFO %u\n",
+			   ec->tx_max_coalesced_frames,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames %u greater than the TX FIFO %u\n",
+			   ec->tx_max_coalesced_frames,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
 	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
 	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
 		netdev_err(dev, "rx-usecs-irq %u needs to be equal to tx-usecs-irq %u if both are enabled\n",
@@ -2078,6 +2123,7 @@ static int m_can_set_coalesce(struct net_device *dev,
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames = ec->tx_max_coalesced_frames;
 	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
 	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
 
@@ -2095,6 +2141,7 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
 		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES |
 		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 76b1ce1b7c1b..2986c4ce0b2f 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -74,6 +74,7 @@ struct m_can_tx_op {
 	struct m_can_classdev *cdev;
 	struct work_struct work;
 	struct sk_buff *skb;
+	bool submit;
 };
 
 struct m_can_classdev {
@@ -102,6 +103,7 @@ struct m_can_classdev {
 	u32 active_interrupts;
 	u32 rx_max_coalesced_frames_irq;
 	u32 rx_coalesce_usecs_irq;
+	u32 tx_max_coalesced_frames;
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
@@ -116,6 +118,10 @@ struct m_can_classdev {
 	int tx_fifo_size;
 	int next_tx_op;
 
+	int nr_txs_without_submit;
+	/* bitfield of fifo elements that will be submitted together */
+	u32 tx_peripheral_submit;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
-- 
2.40.1

