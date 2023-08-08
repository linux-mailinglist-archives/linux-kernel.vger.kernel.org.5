Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C06773C21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjHHQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjHHP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:49 -0400
Received: from mail-ot1-x364.google.com (mail-ot1-x364.google.com [IPv6:2607:f8b0:4864:20::364])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E836189
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:23 -0700 (PDT)
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-6bd0a0a675dso457812a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1691509460; x=1692114260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkyQ6QEBJ5R+A4KzXauS14DJOe2NQamik93pPPAJ9ek=;
        b=kW1hXpMI+oS0W4xi2vS/augcBsN81pJ7H4T6YgBkm9izpcMbwq7spbsxOx2cgnx1cL
         YYsRTlhokZZCaLoDDA/Vp3p4xD/YAyJSopBMqjSrs/wT4Af/HCdWON38vwvUmmzbz7AT
         vC9uV60VvwUI2zkiNYYwfb5+2dg3+llNcmQht6bNQj8tzXqkB6plkIhRa57TFte6ciLe
         IqMvxnvMkHY/1uxeY7a5AEcvviROVlsKorv0hYw9t8sKHPahkCCDoTliYDvui20Wj2Df
         pTxqG0RHxQiqncUjgnr51SLVxuljgQN0m9p1X3bUHbBb1L+OdRBwWoNszV1GhU3ngh3N
         ynQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509460; x=1692114260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkyQ6QEBJ5R+A4KzXauS14DJOe2NQamik93pPPAJ9ek=;
        b=LX92vduVXBMxRJnIsXJIWkVNJIclSAG9HJEDn0tF8JUlE1x2TiksC6NkslcOSI5J6S
         OoUBek9d7rHkLHO7UVsk31uvZi6CT890nIMKm6bY/5Wg9Td7Qy+7XMsAKVcbiS/8QcQo
         Rz0xx0bLBtiKZxZpBSGszF8BIT4j2w5dNCsCh65a81xjy27KsV9Gqb9TycnNcxZRt5Y8
         N1ve6gqT6lN7pMyndA2wa6ogE0fo5UNoyDxRvXzONx3dZ++wFZGdjTe3kzVs9T4eOpi/
         D7LjIO6SlQzg9xMB3on3AOF9EUEwMw259HNEueSq2J7GzyryoeR9aZEv6Gx1b5lJ5WOH
         Cg0g==
X-Gm-Message-State: AOJu0YyGLjc9HNdAkLEhNRCqQYZ/3S7dYhyVZneWbqNN2RpgHNCiJv7k
        G3g8w7wR0ubry786YOe7IgYkKOHi79Dg1BOWKOVCrYuZHiLZ
X-Google-Smtp-Source: AGHT+IGOiebSl22GAJa1Vqszzuk5r+Le/tkscMQwKLAbyswQsnfaT24eZusPYQGYRv08JMU2SVc/f7X59f9M
X-Received: by 2002:a1f:c1d8:0:b0:487:1962:7495 with SMTP id r207-20020a1fc1d8000000b0048719627495mr6886859vkf.1.1691470841920;
        Mon, 07 Aug 2023 22:00:41 -0700 (PDT)
Received: from dxue-amd-5700g.libretech.co ([72.76.64.93])
        by smtp-relay.gmail.com with ESMTPS id c11-20020a02a40b000000b0042911ed0da5sm584619jal.11.2023.08.07.22.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:00:41 -0700 (PDT)
X-Relaying-Domain: libre.computer
From:   Da Xue <da@libre.computer>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Da Xue <da@libre.computer>, Luke Lu <luke.lu@libre.computer>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: phy: meson-gxl: implement meson_gxl_phy_resume()
Date:   Tue,  8 Aug 2023 01:00:15 -0400
Message-Id: <20230808050016.1911447-1-da@libre.computer>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After suspend and resume, the meson GXL internal PHY config needs to
be initialized again, otherwise the carrier cannot be found:

	eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
		DOWN group default qlen 1000

After the patch, resume:

	eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
		group default qlen 1000

Signed-off-by: Luke Lu <luke.lu@libre.computer>
Signed-off-by: Da Xue <da@libre.computer>
---
Changes since v2:
 - fix missing parameter of genphy_resume()

Changes since v1:
 - call generic genphy_resume()
---
 drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index bb9b33b6bce2..bbad26b7c5a1 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int meson_gxl_phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	genphy_resume(phydev);
+	ret = meson_gxl_config_init(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /* This function is provided to cope with the possible failures of this phy
  * during aneg process. When aneg fails, the PHY reports that aneg is done
  * but the value found in MII_LPA is wrong:
@@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_intr	= smsc_phy_config_intr,
 		.handle_interrupt = smsc_phy_handle_interrupt,
 		.suspend        = genphy_suspend,
-		.resume         = genphy_resume,
+		.resume         = meson_gxl_phy_resume,
 		.read_mmd	= genphy_read_mmd_unsupported,
 		.write_mmd	= genphy_write_mmd_unsupported,
 	}, {
-- 
2.40.1

