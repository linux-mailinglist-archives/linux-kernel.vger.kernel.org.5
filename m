Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E66778DE41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbjH3TAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244647AbjH3Nid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:38:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2E1B0;
        Wed, 30 Aug 2023 06:38:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401ceda85cdso27415555e9.1;
        Wed, 30 Aug 2023 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402708; x=1694007508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5g221ge6JqMTWTGX03yPTFswnlhrFAyzkz/jRpc4xU=;
        b=UvSnINdAFhtS4PyTeeYYHb1/X2XFuX7W2Nu7la80pK4Pgv3EiyfP9x6fFO32XjqnSO
         +Qh08ewAhaSJ4xosYS7xTN7/9+Xo5CFmUzfHRZHIgts/QvQfUoU3RDg8MsxD6KukeGJZ
         zqOPNoreGq4MHX64MeHWcrTIaqeB94eF+ytl2wbhTQagA9LpnczMXUPf75hwaZ4Lz/gY
         TNgyIUi4v+/TPpYyXW6wimvuU8DWQISvYjRKJzmwv1wUEQ+7kANx7RHul1iUloXWO3mZ
         qHdKDdOxIeN1W1Bp3q2yRudPnwb/ne5SgiUh79uQsYPWS4wSOUYluiXY5q3H83xLv6AD
         DqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402708; x=1694007508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5g221ge6JqMTWTGX03yPTFswnlhrFAyzkz/jRpc4xU=;
        b=IaSq+BnKsWCaIob+A/pF1RbKPqyIO/PBfaJ+f7juYUvlb2y9jSBbjWjEOjOhr43D9D
         kPxvHryIdRv2oc03ru3ZnXl8xaIwnUIR8i3b3wU8N40T6EoeSczJuwllU0XIUMq6wOs6
         vEb/TGwwUtww3MXUxT8sG3nmCe9TO9OcGdEa26Rg145GlJ4Eg59HYfZmNH0U7CPhM2Hs
         RirfSMhim2qohgLXwCCl6iTaCzN/e3zXJCcfDRCcEl31/2rKaDLsbzrEE+nnbFRgEbm0
         wC9nN/4lNa9bbLTXnvrT/jJeOZ9foDpiNsZR8cOaZBYD4IywPZxqJ+1Jpyb4QdVIWOiZ
         rgNA==
X-Gm-Message-State: AOJu0YzQEX1Rpc6jBqlinRvfYTLoPERQEoegPFSJbztv8gNw+oVAh2wY
        X5XN+zlfoD2LtCQHJyALTw==
X-Google-Smtp-Source: AGHT+IEz+WHucNwiMNPJ9Xjok1GP87HrpJlu0CzCUEiQhDrNO2Zdq1zsySrNspwd/7GvBifanEnygw==
X-Received: by 2002:a05:600c:2041:b0:401:d803:6250 with SMTP id p1-20020a05600c204100b00401d8036250mr1753064wmg.5.1693402707395;
        Wed, 30 Aug 2023 06:38:27 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:17bb:6f65:50d0:b82b])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c2a4e00b003fed70fb09dsm2326343wme.26.2023.08.30.06.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:38:27 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 1/5] phy: rockchip-inno-usb2: Split ID interrupt phy registers
Date:   Wed, 30 Aug 2023 15:36:21 +0200
Message-ID: <20230830133623.83075-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230830133623.83075-2-knaerzche@gmail.com>
References: <20230830133623.83075-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ") added ID
detection interrupt registers. However the current implementation assumes
that falling and rising edge interrupt are always enabled in registers
spanning over subsequent bits.
That is not the case for RK3128's version of the phy and this
implementation can't be used as-is, since there are bits with different
purpose in between.

This splits up the register definitions for id_det_en, id_det_en and
id_det_clr registers in rising and falling edge variants.
It's required as preparation to support RK3128's Innosilicon usb2 phy as
well in this driver and matches pretty much to what the vendor does, so I'm
not expecting issues for other SoCs with that change.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 99 +++++++++++++------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index a0bc10aa7961..a4a1716e67bd 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -116,9 +116,12 @@ struct rockchip_chg_det_reg {
  * @bvalid_det_en: vbus valid rise detection enable register.
  * @bvalid_det_st: vbus valid rise detection status register.
  * @bvalid_det_clr: vbus valid rise detection clear register.
- * @id_det_en: id detection enable register.
- * @id_det_st: id detection state register.
- * @id_det_clr: id detection clear register.
+ * @idfall_det_en: id detection enable register, falling edge
+ * @idfall_det_st: id detection state register, falling edge
+ * @idfall_det_clr: id detection clear register, falling edge
+ * @idrise_det_en: id detection enable register, rising edge
+ * @idrise_det_st: id detection state register, rising edge
+ * @idrise_det_clr: id detection clear register, rising edge
  * @ls_det_en: linestate detection enable register.
  * @ls_det_st: linestate detection state register.
  * @ls_det_clr: linestate detection clear register.
@@ -133,9 +136,12 @@ struct rockchip_usb2phy_port_cfg {
 	struct usb2phy_reg	bvalid_det_en;
 	struct usb2phy_reg	bvalid_det_st;
 	struct usb2phy_reg	bvalid_det_clr;
-	struct usb2phy_reg	id_det_en;
-	struct usb2phy_reg	id_det_st;
-	struct usb2phy_reg	id_det_clr;
+	struct usb2phy_reg	idfall_det_en;
+	struct usb2phy_reg	idfall_det_st;
+	struct usb2phy_reg	idfall_det_clr;
+	struct usb2phy_reg	idrise_det_en;
+	struct usb2phy_reg	idrise_det_st;
+	struct usb2phy_reg	idrise_det_clr;
 	struct usb2phy_reg	ls_det_en;
 	struct usb2phy_reg	ls_det_st;
 	struct usb2phy_reg	ls_det_clr;
@@ -429,15 +435,27 @@ static int rockchip_usb2phy_init(struct phy *phy)
 			if (ret)
 				goto out;
 
-			/* clear id status and enable id detect irq */
+			/* clear id status and enable id detect irqs */
 			ret = property_enable(rphy->grf,
-					      &rport->port_cfg->id_det_clr,
+					      &rport->port_cfg->idfall_det_clr,
 					      true);
 			if (ret)
 				goto out;
 
 			ret = property_enable(rphy->grf,
-					      &rport->port_cfg->id_det_en,
+					      &rport->port_cfg->idrise_det_clr,
+					      true);
+			if (ret)
+				goto out;
+
+			ret = property_enable(rphy->grf,
+					      &rport->port_cfg->idfall_det_en,
+					      true);
+			if (ret)
+				goto out;
+
+			ret = property_enable(rphy->grf,
+					      &rport->port_cfg->idrise_det_en,
 					      true);
 			if (ret)
 				goto out;
@@ -944,11 +962,16 @@ static irqreturn_t rockchip_usb2phy_id_irq(int irq, void *data)
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
 	bool id;
 
-	if (!property_enabled(rphy->grf, &rport->port_cfg->id_det_st))
+	if (!property_enabled(rphy->grf, &rport->port_cfg->idfall_det_st) &&
+	    !property_enabled(rphy->grf, &rport->port_cfg->idrise_det_st))
 		return IRQ_NONE;
 
 	/* clear id detect irq pending status */
-	property_enable(rphy->grf, &rport->port_cfg->id_det_clr, true);
+	if (property_enabled(rphy->grf, &rport->port_cfg->idfall_det_st))
+		property_enable(rphy->grf, &rport->port_cfg->idfall_det_clr, true);
+
+	if (property_enabled(rphy->grf, &rport->port_cfg->idrise_det_st))
+		property_enable(rphy->grf, &rport->port_cfg->idrise_det_clr, true);
 
 	id = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
 	extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !id);
@@ -1362,9 +1385,12 @@ static const struct rockchip_usb2phy_cfg rk3228_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0680, 3, 3, 0, 1 },
 				.bvalid_det_st	= { 0x0690, 3, 3, 0, 1 },
 				.bvalid_det_clr	= { 0x06a0, 3, 3, 0, 1 },
-				.id_det_en	= { 0x0680, 6, 5, 0, 3 },
-				.id_det_st	= { 0x0690, 6, 5, 0, 3 },
-				.id_det_clr	= { 0x06a0, 6, 5, 0, 3 },
+				.idfall_det_en	= { 0x0680, 6, 6, 0, 1 },
+				.idfall_det_st	= { 0x0690, 6, 6, 0, 1 },
+				.idfall_det_clr	= { 0x06a0, 6, 6, 0, 1 },
+				.idrise_det_en	= { 0x0680, 5, 5, 0, 1 },
+				.idrise_det_st	= { 0x0690, 5, 5, 0, 1 },
+				.idrise_det_clr	= { 0x06a0, 5, 5, 0, 1 },
 				.ls_det_en	= { 0x0680, 2, 2, 0, 1 },
 				.ls_det_st	= { 0x0690, 2, 2, 0, 1 },
 				.ls_det_clr	= { 0x06a0, 2, 2, 0, 1 },
@@ -1425,9 +1451,12 @@ static const struct rockchip_usb2phy_cfg rk3308_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x3020, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x3024, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x3028, 3, 2, 0, 3 },
-				.id_det_en	= { 0x3020, 5, 4, 0, 3 },
-				.id_det_st	= { 0x3024, 5, 4, 0, 3 },
-				.id_det_clr	= { 0x3028, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0x3020, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0x3024, 5, 5, 0, 1 },
+				.idfall_det_clr = { 0x3028, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0x3020, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0x3024, 4, 4, 0, 1 },
+				.idrise_det_clr = { 0x3028, 4, 4, 0, 1 },
 				.ls_det_en	= { 0x3020, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x3024, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x3028, 0, 0, 0, 1 },
@@ -1472,9 +1501,12 @@ static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0110, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x0114, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x0118, 3, 2, 0, 3 },
-				.id_det_en	= { 0x0110, 5, 4, 0, 3 },
-				.id_det_st	= { 0x0114, 5, 4, 0, 3 },
-				.id_det_clr	= { 0x0118, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0x0110, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0x0114, 5, 5, 0, 1 },
+				.idfall_det_clr = { 0x0118, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0x0110, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0x0114, 4, 4, 0, 1 },
+				.idrise_det_clr = { 0x0118, 4, 4, 0, 1 },
 				.ls_det_en	= { 0x0110, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x0114, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x0118, 0, 0, 0, 1 },
@@ -1538,9 +1570,12 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en	= { 0xe3c0, 3, 3, 0, 1 },
 				.bvalid_det_st	= { 0xe3e0, 3, 3, 0, 1 },
 				.bvalid_det_clr	= { 0xe3d0, 3, 3, 0, 1 },
-				.id_det_en	= { 0xe3c0, 5, 4, 0, 3 },
-				.id_det_st	= { 0xe3e0, 5, 4, 0, 3 },
-				.id_det_clr	= { 0xe3d0, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0xe3c0, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0xe3e0, 5, 5, 0, 1 },
+				.idfall_det_clr	= { 0xe3d0, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0xe3c0, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0xe3e0, 4, 4, 0, 1 },
+				.idrise_det_clr	= { 0xe3d0, 4, 4, 0, 1 },
 				.utmi_avalid	= { 0xe2ac, 7, 7, 0, 1 },
 				.utmi_bvalid	= { 0xe2ac, 12, 12, 0, 1 },
 				.utmi_id	= { 0xe2ac, 8, 8, 0, 1 },
@@ -1577,9 +1612,12 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en  = { 0xe3c0, 8, 8, 0, 1 },
 				.bvalid_det_st  = { 0xe3e0, 8, 8, 0, 1 },
 				.bvalid_det_clr = { 0xe3d0, 8, 8, 0, 1 },
-				.id_det_en	= { 0xe3c0, 10, 9, 0, 3 },
-				.id_det_st	= { 0xe3e0, 10, 9, 0, 3 },
-				.id_det_clr	= { 0xe3d0, 10, 9, 0, 3 },
+				.idfall_det_en	= { 0xe3c0, 10, 10, 0, 1 },
+				.idfall_det_st	= { 0xe3e0, 10, 10, 0, 1 },
+				.idfall_det_clr	= { 0xe3d0, 10, 10, 0, 1 },
+				.idrise_det_en	= { 0xe3c0, 9, 9, 0, 1 },
+				.idrise_det_st	= { 0xe3e0, 9, 9, 0, 1 },
+				.idrise_det_clr	= { 0xe3d0, 9, 9, 0, 1 },
 				.utmi_avalid	= { 0xe2ac, 10, 10, 0, 1 },
 				.utmi_bvalid    = { 0xe2ac, 16, 16, 0, 1 },
 				.utmi_id	= { 0xe2ac, 11, 11, 0, 1 },
@@ -1608,9 +1646,12 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0080, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x0084, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x0088, 3, 2, 0, 3 },
-				.id_det_en	= { 0x0080, 5, 4, 0, 3 },
-				.id_det_st	= { 0x0084, 5, 4, 0, 3 },
-				.id_det_clr	= { 0x0088, 5, 4, 0, 3 },
+				.idfall_det_en	= { 0x0080, 5, 5, 0, 1 },
+				.idfall_det_st	= { 0x0084, 5, 5, 0, 1 },
+				.idfall_det_clr	= { 0x0088, 5, 5, 0, 1 },
+				.idrise_det_en	= { 0x0080, 4, 4, 0, 1 },
+				.idrise_det_st	= { 0x0084, 4, 4, 0, 1 },
+				.idrise_det_clr	= { 0x0088, 4, 4, 0, 1 },
 				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
 				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
 				.utmi_id	= { 0x00c0, 6, 6, 0, 1 },
-- 
2.42.0

