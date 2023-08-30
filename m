Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1677A78DF92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbjH3TcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbjH3Njn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:39:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D01B0;
        Wed, 30 Aug 2023 06:39:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fee5ddc23eso52508305e9.1;
        Wed, 30 Aug 2023 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402779; x=1694007579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL4AHGqRwUAH2UbRxdk/07qkcSparuw8rJPg7HDVZLk=;
        b=fiPKj1qHsPPAn3Hnz19vDw+kMjhjPoxYh69l4pIL41vMR3q5GjZOTOAyPi9oUFN0ce
         8u7xT8cylnF619LcYbP39H5KkBEvX09TkuwK7BbGxVlj55Ld6lOy5kvMRfg02PZLT+Gs
         75Av1YNleEDKtQVKX6gz8boDP0iyL2kv08vMwPkz2eXovVa/FmF9ejcx2GZ1WJkYP9wM
         sTlnjO2Cvgi/O55+Hzz4lcjOU7nE8wMSrVhVxzkq9eC/ekoZ47hOztAWaDhOpbO4up85
         E9aJSDWCzet8V4D54JM9Tt6vuGFqTUScLIwtoDAwnR1hCvRhl6yfXt3pzWNIyYbC3sMy
         d3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402779; x=1694007579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pL4AHGqRwUAH2UbRxdk/07qkcSparuw8rJPg7HDVZLk=;
        b=CGx7Mdvs+YIVUbK4jrNr1Dp4s7yLmJB4OWSm4LhbK8JTzPm23dHYl6gF2+VkgFIvTK
         CLsp1ScRdlgfkOKm3de87gehk3/370tWA8fwxmymbzYW7WDuqy9pZDG6PF8+yKoGLneC
         cmKPOeWFY4Ahdn5Eh7SXmVjfx/LUjhvadqx/3Fv1NnRduNnHq0bhcipMPGkIIgZe7mTl
         ku5WfdepepAUkeJkeJPNf0pMWfg7g6EtLqCgasGHZT06mcWGx0b25TVBki+7hlprsxeQ
         rOYSO/7KWmy1GbFSHgTEC4yWFVb/ye8FxngzL5mZL0k/gakSm+xqadT8TwMQbfFH9CAa
         iZsA==
X-Gm-Message-State: AOJu0Yycq5pnpFbJZgylCvZ4ZCy/HFFspui0Nrym7Lqi2i29ko+hiUXD
        q3O7cgc2KE+gVFsLf8FfZsfH+5+UFA==
X-Google-Smtp-Source: AGHT+IFmTJWYc2nF+k9N43mdYv3DixoSSezT3uaOMI8tivzPwvZJqspYDXCwnJy0/2KKR2+BqsD65w==
X-Received: by 2002:a1c:7307:0:b0:3fc:9e:eead with SMTP id d7-20020a1c7307000000b003fc009eeeadmr1931954wmb.20.1693402779110;
        Wed, 30 Aug 2023 06:39:39 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:17bb:6f65:50d0:b82b])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c2a4e00b003fed70fb09dsm2326343wme.26.2023.08.30.06.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:39:38 -0700 (PDT)
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
Subject: [PATCH v2 5/5] ARM: dts: rockchip: Make usbphy the parent of SCLK_USB480M for RK3128
Date:   Wed, 30 Aug 2023 15:36:29 +0200
Message-ID: <20230830133623.83075-12-knaerzche@gmail.com>
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

Without setting the parent for SCLK_USB480M the clock will use xin24m as
it's default parent.
While this is generally not an issue for the usb blocks to work, it becomes
an issue for RK3128 since SCLK_USB480M can be a parent for other HW blocks
(GPU, VPU, VIO). They never will choose this clock as their parent, because
it currently always runs at OSC frequency.

This sets usb480m_phy as SCLK_USB480M's parent, which now runs and outputs
the expected frequency of 480 MHz and the other blocks can choose
SCLK_USB480M as their parent if needed.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 119e89fef2a2..5590af6f42ad 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -113,6 +113,8 @@ usb_host_ehci: usb@101c0000 {
 		reg = <0x101c0000 0x20000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST2>;
+		assigned-clocks = <&cru SCLK_USB480M>;
+		assigned-clock-parents = <&usb2phy>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -123,6 +125,8 @@ usb_host_ohci: usb@101e0000 {
 		reg = <0x101e0000 0x20000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST2>;
+		assigned-clocks = <&cru SCLK_USB480M>;
+		assigned-clock-parents = <&usb2phy>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.42.0

