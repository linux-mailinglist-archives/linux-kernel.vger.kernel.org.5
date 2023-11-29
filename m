Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8C7FCCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376761AbjK2CMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376750AbjK2CM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10519AE;
        Tue, 28 Nov 2023 18:12:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b397793aaso2298335e9.0;
        Tue, 28 Nov 2023 18:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223951; x=1701828751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt4PyFm7vz4PSs/CMN+Td9iZ3kGYAxZdlYsWr/1duKY=;
        b=myTKw3P9yLweJySHRcUsNdISUyaqcUFm1Wws7m20QUkiQ67XLXjysYKARUkRACMtpj
         WcUO+2FM/2e2IHfZQIM9WnHz2IJKBXX9Oh1CDTIg2cFJH77Y1pqV+oDl3ArdAeJjEilp
         4tTsoQ7mQtWUqJXK99lQNdjDWbgwmzLjKlTpmEHxU7x9SkXwotkFixkJN4Bo6ushriAt
         DLTI1X79kut7M4L6qbBBjbjbHrSHAkq13BPK15VnxxZykIwz/XdkMawiLgdZTA/Kzrq3
         DqRDyfGuNdbzaZY+TrWEvSbVxxPt1dNBq97g8yGWJjg9egsBR5szThkbn4hJq2Vpww0i
         1+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223951; x=1701828751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt4PyFm7vz4PSs/CMN+Td9iZ3kGYAxZdlYsWr/1duKY=;
        b=lA+QNNWri/QblZ8Cb7nwcEjjJCgL0Tte9AyTsawWSgAPp3dUvt50X/yV5oTC4CxK2D
         2s7wMZQcnlYSxIvb82Z6S96rxaFYJuFqRTO9OYcqhj9toCq09KkkjUSfKtjStonQPyvs
         tXiLJX7/1/Rs5bVBNuy7DcaxCRidHE3m6in3Mxb0uWjZtFKqNODF5jCywRSmV6hj8jVD
         RnkV1Rmr8zQ7n2RNQc5D4fEQbKWfLwhKDT2+PijTijfvgKH2bwu4ZEcb3Eaiwtl+UwID
         REZHPTlmFhZis20V197ccpVbY9yMaHjhgwQ0MXDh30qO8PGrmhuot7iPl0G3ReS6ETNa
         d0dQ==
X-Gm-Message-State: AOJu0Ywg7cmopcYjE++CqJfIQixOeyMBJQfG1qkVpPEkeLZdZSqSTQ11
        oT/tDw3AGYkU57oSYxQ/M0sY4/uSOUI=
X-Google-Smtp-Source: AGHT+IEB+EE62ZxZ6YnKc/wRURf8O/aC2YQ2mvgKi7hDtLh/cSIMB8bMSwMZeV+Goocx5Ff3aZOQzw==
X-Received: by 2002:a05:600c:1d08:b0:40b:2a62:a2b6 with SMTP id l8-20020a05600c1d0800b0040b2a62a2b6mr14429504wms.1.1701223950657;
        Tue, 28 Nov 2023 18:12:30 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:30 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 02/14] net: phy: at803x: move disable WOL for 8031 from probe to config
Date:   Wed, 29 Nov 2023 03:12:07 +0100
Message-Id: <20231129021219.20914-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129021219.20914-1-ansuelsmth@gmail.com>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe should be used only for DT parsing and allocate required priv, it
shouldn't touch regs, there is config_init for that.

Move the WOL disable call from probe to config_init to follow this rule
and keep code tidy.

No behaviour is done as the mode was disabled only if phy_read succeeded
in probe and this is translated as the first action done in config_init
(called only if probe returns 0)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index ef203b0807e5..b32ff82240dc 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -886,15 +886,6 @@ static int at803x_probe(struct phy_device *phydev)
 			priv->is_fiber = true;
 			break;
 		}
-
-		/* Disable WoL in 1588 register which is enabled
-		 * by default
-		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     AT803X_PHY_MMD3_WOL_CTRL,
-				     AT803X_WOL_EN, 0);
-		if (ret)
-			return ret;
 	}
 
 	return 0;
@@ -1008,6 +999,15 @@ static int at803x_config_init(struct phy_device *phydev)
 	int ret;
 
 	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
+		/* Disable WoL in 1588 register which is enabled
+		 * by default
+		 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     AT803X_WOL_EN, 0);
+		if (ret)
+			return ret;
+
 		/* Some bootloaders leave the fiber page selected.
 		 * Switch to the appropriate page (fiber or copper), as otherwise we
 		 * read the PHY capabilities from the wrong page.
-- 
2.40.1

