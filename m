Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8647F061A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjKSMNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 07:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjKSMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:13:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173CB129;
        Sun, 19 Nov 2023 04:13:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9df8d0c2505so660414766b.0;
        Sun, 19 Nov 2023 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700396024; x=1701000824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no0ZEH8MGlw8tJ6htWoDUR170bNw3QI+/YlLRVV4UwA=;
        b=X3a1egNRPUTi3TxgL2iNrT99l4WUejzdAS6uV67s8RXTAIUu0J53BR9s1q06UhPIfZ
         EbYa0EWvzQ3qvqx+j5wtlqZOjRJocCoW3xtGagzE0ijh3GIZaWXUX0pHXcQa0fxDU/mu
         zs1d/C/s/nR9OLUmKhkTW6H6XkWJZJ2nB7no4unXabV0+S1FiKCUu/zvdV+PWTKLIy+Q
         7RRxPW5wqEnqcIO4IcQV6ErF8InNecQ387PSDblr0/KBQ2t++PQOYg8V0pL9EXpWuzTZ
         CURGcfE+KadUL7+qf9n817cAkNezvhcOeYl3jwMAPJzY77UQrGH3a26yy/L0wd7bhbb3
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700396024; x=1701000824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no0ZEH8MGlw8tJ6htWoDUR170bNw3QI+/YlLRVV4UwA=;
        b=unz9v0rDyyhYgtCaeBQ/FFNjc7GRR0332AnmYBI/eIiRjYdhKEkXv7oeSkn5yvRtOl
         Oa8Zy9CfzVNdZ0WW292F1nkyCVUv6v6tudgtKHI1fQ4jNTSHzPyNjbl1lCbr3SUS5/MY
         eW1nSgqP3qvBoFOhzCI2DeokxFn8WWK4B/ukG/QfC+UEETes6kqQJNsuLSpNv82n3I1a
         Q7RYlitF1Rynfah9Icg70KDikIHwt7h2SCBkbRtiztqnO4w5YdPn6cLNgD7ZZ0SXbPr2
         ZGqnUT68VlTpPkH+r/tdXFFbYIgu3VBxkt4R+whCj+cY0IOZE8QlfOETZimyJvJu3ZUE
         /5mg==
X-Gm-Message-State: AOJu0Yxto8lMyyJdRPQpktH9xDuZ2tf4o8xwyR44LAcrsHsoW+IwsSIe
        4m81VRnAXPXpbNUcc0ERzg==
X-Google-Smtp-Source: AGHT+IE5Dvqdr2Ny9LGLGrJSKCUknctB4NV8cQ67rYxxrcFo45ijhkxFmGxHdUJx/gNi5Y0mq0frIg==
X-Received: by 2002:a17:906:f1c8:b0:9e2:b1a5:1d2 with SMTP id gx8-20020a170906f1c800b009e2b1a501d2mr9817275ejb.27.1700396024531;
        Sun, 19 Nov 2023 04:13:44 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7017:f42c:e243:8c57])
        by smtp.gmail.com with ESMTPSA id r5-20020a056402018500b0053dec545c8fsm2523634edv.3.2023.11.19.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 04:13:44 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 2/5] phy: phy-rockchip-inno-usb2: Add RK3128 support
Date:   Sun, 19 Nov 2023 13:13:37 +0100
Message-ID: <20231119121340.109025-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119121340.109025-1-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
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

Add registers to support the 2-port usb2 phy found in RK312x SoC familiy.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
Changes in v3:
 - added phy_tuning-callback for RK3128
 
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b5a1d30df83a..4f71373ae6e1 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1487,6 +1487,14 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
+{
+	/* Turn off differential receiver in suspend mode */
+	return regmap_write_bits(rphy->grf, 0x298,
+				BIT(2) << BIT_WRITEABLE_SHIFT | BIT(2),
+				BIT(2) << BIT_WRITEABLE_SHIFT | 0);
+}
+
 static int rk3588_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 {
 	int ret;
@@ -1536,6 +1544,54 @@ static int rk3588_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 	return ret;
 }
 
+static const struct rockchip_usb2phy_cfg rk3128_phy_cfgs[] = {
+	{
+		.reg = 0x17c,
+		.num_ports	= 2,
+		.phy_tuning	= rk3128_usb2phy_tuning,
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
@@ -2031,6 +2087,7 @@ static const struct rockchip_usb2phy_cfg rv1108_phy_cfgs[] = {
 
 static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,px30-usb2phy", .data = &rk3328_phy_cfgs },
+	{ .compatible = "rockchip,rk3128-usb2phy", .data = &rk3128_phy_cfgs },
 	{ .compatible = "rockchip,rk3228-usb2phy", .data = &rk3228_phy_cfgs },
 	{ .compatible = "rockchip,rk3308-usb2phy", .data = &rk3308_phy_cfgs },
 	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
-- 
2.42.0

