Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178CA78E041
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243515AbjH3TNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244648AbjH3Nis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:38:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815741B1;
        Wed, 30 Aug 2023 06:38:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401b393df02so55079695e9.1;
        Wed, 30 Aug 2023 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402723; x=1694007523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBe21p78bEGeinGOeEZ5dbYwb28pfpjkSo3Y7gdPnoA=;
        b=S97wPEASr2Xy94umC548KggN8JMp/Wx8RBV2dCr552Ic4zvqT2/4+Ia5o8cNtLaIsF
         X+3YSlUx8QCLt0ThrAqxPYlemxx+lY4TQHPL9yIgNqQvwtJkPPeMnO7/tbbgMKo2PDIW
         +hjjGxNdA4cQD4j1m4eaZVDSfobL1TUKVJ06e8FiuG4W8Xryf4xiq6PjLv/dQcOLtXIy
         /kbYLUQv4g9ZQSBbMgbuxeEA8uOa/haUIDmtoZ95akymILgp5hc6fih1cIo/QQxQej1u
         k1RPvOLBaX8sdoZn681KxMmTB8WDFpFn49eCNAiVF6ZkJUbuTf7egRpBQMYNP6yGLRzN
         0uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402723; x=1694007523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBe21p78bEGeinGOeEZ5dbYwb28pfpjkSo3Y7gdPnoA=;
        b=JXZmO6Hq8/3GzLsFioqr9FYJ6MRzizTEOqTDWwqrJ7WGiAN5Bv+n0OoOZeosNPmSWl
         xBr8YmWZa2Mu1RhE3fYjwa/3FhGDWcWteGWcMKPxwsRTrAeqU2CFQDN8d3Tq03UP/YaV
         rhxXaatBHOsg20+qj50AVv1Ik36h87QluDHH7r9MjMH4EyVKclAX84n70Dyw75cQcdn1
         D06DFnfIguOIrWSUymEd7LmbHZih9XTMr1NDiHLgoGtYPRR8pf2BulxOLzCzLhlioGIr
         O4OqPUBRy8enQj+k83ytLNXIUQpVL2XQ2fEGpJCA5bC52NA0cVr/5EfY1Tqv54IX1QcE
         mQlQ==
X-Gm-Message-State: AOJu0Ywu7dHn8Y6QKl/khyfudk+vo20vpi0vSxXHsKB7oEVxlum+DIeW
        zdgY1qOX20KsI3C0ZI0V6A==
X-Google-Smtp-Source: AGHT+IEpDe6p2bk26/qpet9gXv/RWnuOE+JScc/Osk+9IK0/HLUMMbVMFqo56cM5drEZGpVyQ+6BZQ==
X-Received: by 2002:a05:600c:21c5:b0:3f8:f382:8e1f with SMTP id x5-20020a05600c21c500b003f8f3828e1fmr2026172wmj.24.1693402722599;
        Wed, 30 Aug 2023 06:38:42 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:17bb:6f65:50d0:b82b])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c2a4e00b003fed70fb09dsm2326343wme.26.2023.08.30.06.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:38:42 -0700 (PDT)
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
Subject: [PATCH v2 2/5] phy: phy-rockchip-inno-usb2: Add RK3128 support
Date:   Wed, 30 Aug 2023 15:36:23 +0200
Message-ID: <20230830133623.83075-6-knaerzche@gmail.com>
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

Add registers to support the 2-port usb2 phy found in RK312x SoC familiy.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index a4a1716e67bd..9ea08be533cc 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1374,6 +1374,53 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct rockchip_usb2phy_cfg rk3128_phy_cfgs[] = {
+	{
+		.reg = 0x17c,
+		.num_ports	= 2,
+		.clkout_ctl	= { 0x0190, 15, 15, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x017c, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x017c, 14, 14, 0, 1 },
+				.bvalid_det_st	= { 0x017c, 15, 15, 0, 1 },
+				.bvalid_det_clr	= { 0x017c, 15, 15, 0, 1 },
+				.idfall_det_en  = { 0x01a0, 2, 2, 0, 1 },
+				.idfall_det_st  = { 0x01a0, 3, 3, 0, 1 },
+				.idfall_det_clr = { 0x01a0, 3, 3, 0, 1 },
+				.idrise_det_en  = { 0x01a0, 0, 0, 0, 1 },
+				.idrise_det_st  = { 0x01a0, 1, 1, 0, 1 },
+				.idrise_det_clr = { 0x01a0, 1, 1, 0, 1 },
+				.ls_det_en	= { 0x017c, 12, 12, 0, 1 },
+				.ls_det_st	= { 0x017c, 13, 13, 0, 1 },
+				.ls_det_clr	= { 0x017c, 13, 13, 0, 1 },
+				.utmi_bvalid	= { 0x014c, 5, 5, 0, 1 },
+				.utmi_id	= { 0x014c, 8, 8, 0, 1 },
+				.utmi_ls	= { 0x014c, 7, 6, 0, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x0194, 8, 0, 0, 0x1d1 },
+				.ls_det_en	= { 0x0194, 14, 14, 0, 1 },
+				.ls_det_st	= { 0x0194, 15, 15, 0, 1 },
+				.ls_det_clr	= { 0x0194, 15, 15, 0, 1 }
+			}
+		},
+		.chg_det = {
+			.opmode		= { 0x017c, 3, 0, 5, 1 },
+			.cp_det		= { 0x02c0, 6, 6, 0, 1 },
+			.dcp_det	= { 0x02c0, 5, 5, 0, 1 },
+			.dp_det		= { 0x02c0, 7, 7, 0, 1 },
+			.idm_sink_en	= { 0x0184, 8, 8, 0, 1 },
+			.idp_sink_en	= { 0x0184, 7, 7, 0, 1 },
+			.idp_src_en	= { 0x0184, 9, 9, 0, 1 },
+			.rdm_pdwn_en	= { 0x0184, 10, 10, 0, 1 },
+			.vdm_src_en	= { 0x0184, 12, 12, 0, 1 },
+			.vdp_src_en	= { 0x0184, 11, 11, 0, 1 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3228_phy_cfgs[] = {
 	{
 		.reg = 0x760,
@@ -1749,6 +1796,7 @@ static const struct rockchip_usb2phy_cfg rv1108_phy_cfgs[] = {
 
 static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,px30-usb2phy", .data = &rk3328_phy_cfgs },
+	{ .compatible = "rockchip,rk3128-usb2phy", .data = &rk3128_phy_cfgs },
 	{ .compatible = "rockchip,rk3228-usb2phy", .data = &rk3228_phy_cfgs },
 	{ .compatible = "rockchip,rk3308-usb2phy", .data = &rk3308_phy_cfgs },
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
-- 
2.42.0

