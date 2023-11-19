Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD597F0647
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjKSNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjKSNE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:04:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1210D65;
        Sun, 19 Nov 2023 05:04:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9f27af23441so472318266b.2;
        Sun, 19 Nov 2023 05:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700399089; x=1701003889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D7FwSNbPTp8jaj1UJACdG2GoQE4etSzcaqgDznPLTY=;
        b=KYOAoj0w0I3g6VwGZAY+lJ7HASeADlWHsd+kBci6BDHhH29Yn33ObPNJOv838N5xye
         /s9EIN1MYi4oPxeNTRhyKWKgWBz/glUJPWIBNTyMivZIrNdrg3eraIzWdtBtwrfSfikZ
         GzY0XFxZZfrPhhQaK1gilDq6wunBn4f/em09W3fVcOgEuOxs5P4IpN/XuH/Xd3QT+Vi5
         jRs/wZkWTWrV9iFhnEwNIFYlLUBbSWgj8IHUO1UUnjXtO5RWbPA8UMXt0SBkjrlw3W/M
         KKCkjqCc1yfyJubtZ963JQDs3GkUku/EEZOlTas041FrTRqBAXJVPXI8WcevlF6CP0tP
         nXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399089; x=1701003889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D7FwSNbPTp8jaj1UJACdG2GoQE4etSzcaqgDznPLTY=;
        b=swASwqRrs1QznNuEH04GjKjE9DYWR5XIwI42svORmZDlNJtueBa/fkOfuzoW66bFu6
         tzCWeoC0LLb1KxJxH69laz78jyCPsRnhBVFqYWErYrwEVOsdH/5ILGPqZXBP52W1qK/G
         X7DKFkYrclHcWpLXV70HRtV7XmAqIhTrQHFXB1Iquc7J61cw5fdj73E05p0yiP9nWcwV
         sFlez+RBBl5kL9AbQIrW21xQl+kq9je22dViqRSHYe8Et0BcGWpNIwUrLpn1VW1yVdh/
         OhSh4UShoWe36Kld0V/mwvFGvAly7CiOb9fW/DPGFS7neU8myjKZt5PRuQt1fd7S7gLx
         TSQw==
X-Gm-Message-State: AOJu0YxKbtajsmIEXiZTyuq3RKiXpMLFH8LgzSx8YRXp7lO1n+OSwR4G
        gcO+S9z4h0ZBaG3O1nwdJQ==
X-Google-Smtp-Source: AGHT+IEwNDO4gimoaB9m92VdbE3A3oya64/Ue+tkhBwip4/WPt2BUK2ndGWYskgSHqJLW+J0pcgMkg==
X-Received: by 2002:a17:906:2d0:b0:9b2:b152:b0f2 with SMTP id 16-20020a17090602d000b009b2b152b0f2mr3379718ejk.10.1700399088899;
        Sun, 19 Nov 2023 05:04:48 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7017:f42c:e243:8c57])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709062bc800b009dd8473559dsm2827866ejg.110.2023.11.19.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:04:48 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/3] ARM: dts: rockchip: Add sdmmc_det pinctrl for RK3128
Date:   Sun, 19 Nov 2023 14:03:53 +0100
Message-ID: <20231119130351.112261-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119130351.112261-2-knaerzche@gmail.com>
References: <20231119130351.112261-2-knaerzche@gmail.com>
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

The pincontrol for sd card detection is currently missing.
Add it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 7bf557c99561..797906ba321d 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -843,6 +843,10 @@ sdmmc_cmd: sdmmc-cmd {
 				rockchip,pins = <1 RK_PB7 1 &pcfg_pull_default>;
 			};
 
+			sdmmc_det: sdmmc-det {
+				rockchip,pins = <1 RK_PC1 1 &pcfg_pull_default>;
+			};
+
 			sdmmc_wp: sdmmc-wp {
 				rockchip,pins = <1 RK_PA7 1 &pcfg_pull_default>;
 			};
-- 
2.42.0

