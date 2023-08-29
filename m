Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2CB78CB08
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjH2RTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbjH2RS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:18:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F519F;
        Tue, 29 Aug 2023 10:18:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bcfe28909so599854066b.3;
        Tue, 29 Aug 2023 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693329472; x=1693934272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkvURmq2cbKlpQEevUHV3n2DL6VzUfl6w6/QUHqY58A=;
        b=mh8CjGx2AHkgqd0uSoIKqeT9Tx6k2Ul0GOWg1kjbkiddzhSqVBM1nD4aYXZydED6H+
         kWK+uS1baw/rCdfglAdVxz+J7v7YlDKV0ueFoYNvYQZ/07I8e34HSGQRfE5Pn4X9nzZp
         IG/sINaLFwKvTfuxWfyfmNaQNcQ/tiVUFJdycaBVaRRyoOlUB0nbZpFAkDUwkmUAprwH
         kdBDs78wbMXS2p6rqK+rwKDETklEowDB0LPP6XtEtCx5sTvze9IlfS2B9HFExdu2ZDQz
         aE2Wba9Fb0V5phmR9SwmII3cBtdclPmYCGSX+M0CWij4M4ICfmFqNvoGeH+pWTWKGM5P
         kyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693329472; x=1693934272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkvURmq2cbKlpQEevUHV3n2DL6VzUfl6w6/QUHqY58A=;
        b=gzsJACRUCWUowgjn1s4bez3/+sCe0HvLa0bsj7youd0amO/xi50m4CWVty/ciPEtRH
         s4PexgMEKhNrU6dja5kjBCY6ledQ2mZ5xL8PbmD9PW00EoFR4wCdurCP4YDH4/dGfPQN
         UCQseQ4vIrv+DPegtfChiASCyFUIttMaJ6GcGnmlTOSNMlHKPLVFhWZfZyb9mtg3mSPq
         YZKiP9Xwp2MfXaRrOPEJE4qF1lMYrQpL8YqcuMO/bK15aBTU7SOjqJ/mRZBiUkUE3zfh
         ZUKvS2icZKOiXCyXi+6PgOHJo4Tly1ViTDRUbY8mzWB50v8nuFBQLdPxGX/meSw3VJED
         B/Gw==
X-Gm-Message-State: AOJu0YwogVJRuEKRk2QeMsbtQv+9w0Wx6Cpf4Qq4AQv9ptFgWUbR/z2y
        TGg20JkzYGbTk/61W+KhCQ==
X-Google-Smtp-Source: AGHT+IF8xlfihuxSv7bVK1cLtxo53LQXa5+OykLNbJpUofa4RUl/ax3u6GyAuJkTQpRKAMBEGM1X+Q==
X-Received: by 2002:a17:906:220f:b0:9a5:aece:13b0 with SMTP id s15-20020a170906220f00b009a5aece13b0mr5390216ejs.36.1693329472292;
        Tue, 29 Aug 2023 10:17:52 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709062b1500b00993cc1242d4sm6115834ejg.151.2023.08.29.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:17:51 -0700 (PDT)
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
Subject: [PATCH 28/31] ARM: dts: rockchip: Add USB host clocks for RK312x
Date:   Tue, 29 Aug 2023 19:16:44 +0200
Message-ID: <20230829171647.187787-29-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829171647.187787-1-knaerzche@gmail.com>
References: <20230829171647.187787-1-knaerzche@gmail.com>
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

Add the AHB clocks for both the ehci and ohci controller.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk312x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk312x.dtsi b/arch/arm/boot/dts/rockchip/rk312x.dtsi
index 019aa92c0cfa..b13957d55500 100644
--- a/arch/arm/boot/dts/rockchip/rk312x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk312x.dtsi
@@ -292,6 +292,7 @@ usb_host_ehci: usb@101c0000 {
 		compatible = "generic-ehci";
 		reg = <0x101c0000 0x20000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST2>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -301,6 +302,7 @@ usb_host_ohci: usb@101e0000 {
 		compatible = "generic-ohci";
 		reg = <0x101e0000 0x20000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST2>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.42.0

