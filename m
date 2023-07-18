Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70FC7575F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjGRH6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGRH5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:57:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7EC1707
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3143798f542so5635724f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667036; x=1690271836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw3452bl3IVkLYCgTU07wlcs12OEKKnmFHT15uujsjI=;
        b=jb+AE0lg/ruaMMzxDMgfRqakGL8VLjLeo6Uqd5vQpe/fo4aghhp8yAogRi3gZN5Di+
         VjqGOimJnzwWl7hPJiaE2MWJSUKmZPAMM47DS926vvpjih1ch3h8fvIeY/1E6e/PGzvt
         uoH5TenqWMg+mW0R4LuG0uYfi8sLgrUiQh0hH0BpNNRzAhafkDEVQqunY2X9Qe/ZTnwj
         2Z/FyIAW/GZQSwLCNsuqAka2sIo9oVdFgR0URDWc8Y9BpQJz5JrJBzX0lW+QgDREUE/h
         ZSr+17C19j3SaRz6O3h2BvRvNcF5ppmXfBm9DV54NcuVex9xh2qhpsMglB6RzpZPw8Se
         4yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667036; x=1690271836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aw3452bl3IVkLYCgTU07wlcs12OEKKnmFHT15uujsjI=;
        b=U6Lpq1y9HOhaJ9tpLH0tbRh1FHX438tcNqvIFo4GE08hegksHMEQjEXa5oPKBjzOiZ
         4vIDm3vG0tduoTWT9h+UTM45UKuA8XYqshmZ7vk25wDoleb81nFNKZmkHyf0essiOfTq
         ILsCkT5issQk1+ACZlY6sDmMN/TgkZBZQ9sVifXfApOWYyb/S7Aad3K4hKpjzkPBVAGl
         BCWVq09mL6wcb9IzXVM7sfPOsHxR524Xw8MyovvZh7Md1HhG3J+WyFok+v5nx5y66BRW
         VKIPH2mrvE1GqBiiZJYLkc05UKqYlYuWYYUIujZcBnO5z825o1PqAJejq5EinmM3+A8k
         YPyA==
X-Gm-Message-State: ABy/qLbUY2qV6RlgopiN+ZDPRmbkQBXhjfpEkv2lnNKVz4SYmI84Sn+t
        9GeKTdXWLd6gVFpDLE9iBBv8JA==
X-Google-Smtp-Source: APBJJlG4gvJkuWZOqhO+jvg2v72AC2MPY7n1+BA4EirjRCEXV+BN3SdjTHxmOiThZLSH6zO/kwgnIA==
X-Received: by 2002:a5d:6841:0:b0:314:1ebc:6e19 with SMTP id o1-20020a5d6841000000b003141ebc6e19mr12196935wrw.64.1689667036031;
        Tue, 18 Jul 2023 00:57:16 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:15 -0700 (PDT)
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
Subject: [PATCH v5 04/12] can: m_can: Add rx coalescing ethtool support
Date:   Tue, 18 Jul 2023 09:57:00 +0200
Message-Id: <20230718075708.958094-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e979aeb2ef13..c19fc10a7645 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1943,8 +1943,54 @@ static const struct net_device_ops m_can_netdev_ops = {
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
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_coalesce = m_can_get_coalesce,
+	.set_coalesce = m_can_set_coalesce,
 };
 
 static int register_m_can_dev(struct net_device *dev)
-- 
2.40.1

