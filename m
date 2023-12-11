Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2BE80DD3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345153AbjLKVbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjLKVbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE70CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702330307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3m2lRSq/x6O1AvE2D5Tmo4LBWE3DJjeKHdxsqLlOX9k=;
        b=XSq9T5819UXeCy2oCcVbcqkO/PEl5Xy3hWna1/qq4FdejdYPoNVKW98uZ5ksKSscY8kCuB
        vfSMMXVFtIZCjRfXRqN4MfFACaEHeLp5KzIUWQKTPjCm9n6dIBCo4tGpiqCAePaDLpG5KO
        G3i5untxB/se+NGqsAnMHJ/MUFV1aHE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-OgT3NVCfNTqrN1w6xMuSAg-1; Mon, 11 Dec 2023 16:31:40 -0500
X-MC-Unique: OgT3NVCfNTqrN1w6xMuSAg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67aa2707000so70442456d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330299; x=1702935099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m2lRSq/x6O1AvE2D5Tmo4LBWE3DJjeKHdxsqLlOX9k=;
        b=mp9Ged/8CS1pXsRMWZ7i4um4+vpQzU9LAFwiMzHEzT7VfRfV0O7hKzSkN898PqMuE5
         9nrn8D2SW99A9dSuLoGUPPAUwSBw+AVkJkserZeXy+Ezaz4yS6hd9wDLMCdaRTNBs2ot
         yJfuSfYx6zCJABut+QaOIbr0N6lCox3vQRnxwXKVV0VY+H+VOU0Qq4+BxuQ7Vg8I4QiG
         Yopqm+lKGNChQq/WvE2C6Ws8Rh+jw2umyLLhg0W9xgt1X5HZvoRd0f/oFv/yjUL2d+FA
         /9zVOSBHqhN30LM2l9wyoMLUxUzsHbmp66hG+h7BbDN4whOXlo2HllEu5MGf747U+07a
         o9XQ==
X-Gm-Message-State: AOJu0YyNXGgh/NRabNvV6Pd8id4BZI2lM5Tm8rVS2nEHC4Z6+2tHXY6r
        xVyPlTlVtcvtjzVn9oRTbf587WJbbBDM5W7/9h29sPoRaWgs8jBbd2nomaO+3LPpWGh2PNdXbW1
        k68dhP4uoPsYPXGrngT4rYTY8
X-Received: by 2002:a0c:fb42:0:b0:67a:98bc:4b45 with SMTP id b2-20020a0cfb42000000b0067a98bc4b45mr6325899qvq.25.1702330299795;
        Mon, 11 Dec 2023 13:31:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfOr5Qchzr/j+FGRg3RKaC+dHzH5m7JUsZDA1GvPXcQq/y9SyQGFh3KmV3W0rrIbwNAaai2g==
X-Received: by 2002:a0c:fb42:0:b0:67a:98bc:4b45 with SMTP id b2-20020a0cfb42000000b0067a98bc4b45mr6325895qvq.25.1702330299614;
        Mon, 11 Dec 2023 13:31:39 -0800 (PST)
Received: from [192.168.1.164] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id t18-20020a05621405d200b00677a12f11bcsm3579945qvz.24.2023.12.11.13.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:31:39 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Mon, 11 Dec 2023 15:31:17 -0600
Subject: [PATCH net] net: stmmac: Handle disabled MDIO busses from
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com>
X-B4-Tracking: v=1; b=H4sIAKR/d2UC/x3MQQrCMBBG4auUWTvgxBKCVxEXMfOrAyaRpJRC6
 d0NLj8evJ06mqHTddqpYbVutQzIaaL0juUFNh0md3YXcSL8mLkvOcfEI+sHnNUqo1TFysGJDwo
 fko80Ft+Gp23//Y0KFrofxw8QHoykcwAAAA==
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many hardware configurations have the MDIO bus disabled, and are instead
using some other MDIO bus to talk to the MAC's phy.

of_mdiobus_register() returns -ENODEV in this case. Let's handle it
gracefully instead of failing to probe the MAC.

Fixes: 47dd7a540b8a (net: add support for STMicroelectronics Ethernet controllers.")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index fa9e7e7040b9..a39be15d41a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -591,7 +591,13 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
+	if (err) {
+		if (err == -ENODEV) {
+			/* The bus is disabled in the devicetree, that's ok */
+			mdiobus_free(new_bus);
+			return 0;
+		}
+
 		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}

---
base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

