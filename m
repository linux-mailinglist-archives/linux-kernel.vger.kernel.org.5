Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C145E78CAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbjH2RS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbjH2RSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270ECD1;
        Tue, 29 Aug 2023 10:17:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-997c4107d62so601373366b.0;
        Tue, 29 Aug 2023 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329453; x=1693934253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBe21p78bEGeinGOeEZ5dbYwb28pfpjkSo3Y7gdPnoA=;
        b=SUdL/xb3kpsY3Akj/aJ26o1kv2KJys+W9cQBeBkftJhsQqWtZcpM7ECdOar9ADv/Jk
         jnanflospjevW6BNesT12gqFBXaaHkeB5/Dad0SOUROZyWMFcC4+ME8Rt+tWiNBTyLGL
         VMwY7HTAQx+H8I3BXswnEOgBBn12IteAi1X/spxrBhperVxXoUCrAPC5WTzBhG3W/QiD
         pCWF4JTBniQzdk5RPjFTAk9dpoOCO8j3OClV0dicykotS4qTBR5aP//QtpVMSOsX+tdg
         X0bBbzobuYclmPOSn8aN3PQxMR/UlFydtNoqxKA/LXK49n1/jGxqCSXxPz24N7GhDtJB
         llzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329453; x=1693934253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBe21p78bEGeinGOeEZ5dbYwb28pfpjkSo3Y7gdPnoA=;
        b=KbjJmytHaZLdHza+gSzgkPIfCJ7AdLiMIqmuZks65m6ncR+ap9BK00CZm8DqaEGV5B
         MeFNjdpwzk+5mK5lWgF1NmMg1K3DYNs/b3EB6kgaoEtxoXQR+eJKut08YVQxYJAIt8FD
         y8SxurMAWhOT3qUMvfk3zE8hjQVBI3Qz60mnWQthEsxGYQiH4SE4klHz8ABMBqB8mJFm
         rUQ29xDirksFrzlcbMtCxdcJ//EfKgT8S1xlQ9kPea3WRkkq8D9HlMbvoOikHUpKmkH7
         5zuGmAOA6fScZBYYgTfn5pHw3lrRuBAonane4TkFwUg1ZwvQc/BtnYO9J6zAuj71xcFr
         +12A==
X-Gm-Message-State: AOJu0YwZROpqRKs8RQOaeek9jSRjH9WaOisiJ8ORLkcBy1WqIkg6V57c
        wjp3yKirpQRAAhOLeFCPrg==
X-Google-Smtp-Source: AGHT+IG3HeRnwjBp4DP1d8br+7ZiHAWUkr/gchOvBZ36yJgCrvVfN0JO4YkAJKyfaU26dvULxvz2mA==
X-Received: by 2002:a17:906:5346:b0:9a2:1ce5:1243 with SMTP id j6-20020a170906534600b009a21ce51243mr12594716ejo.60.1693329453236;
        Tue, 29 Aug 2023 10:17:33 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:32 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org,
        linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 09/31] phy: phy-rockchip-inno-usb2: Add RK3128 support
Date:   Tue, 29 Aug 2023 19:16:25 +0200
Message-ID: <20230829171647.187787-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

