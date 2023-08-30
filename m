Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA378DE32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjH3S7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244649AbjH3Ni6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:38:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADA1B0;
        Wed, 30 Aug 2023 06:38:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so17034245e9.1;
        Wed, 30 Aug 2023 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402734; x=1694007534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keE4f6mexSCLXM3y1/CVIDHktCoAT49bvVYyDIq2rlk=;
        b=lcBYyHO36eHVvlPS7rreWF9KHs4XhmDbZZVqpuPnDBnj+QkjJtA1jq0TIAfYH0+WG/
         0lW4vnCqngd4l/d8D6kjXTNccTo0N52jdJNJfKddO1GEv0br2hCOBnzdLu3R76xf9y/X
         zsqkevGnt+U2fh++S/KUYBb+IVTxsjizjvB+DqJ/cMHoAGr+71oaYQyOrN1Rl1A/1qrp
         vHsoccjtA5zAp7GLIRfZKK5UH5eEGvcxgUEllmaisFUFGWuzvMhac010B9eqO2vqEL3a
         /Ba9n9WB1iU7a4kb2REDNPgnWqwt7RQRiFe11/kPyUl0A/UeVnAxp3zPATQn3iY6nFfX
         Cx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402734; x=1694007534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keE4f6mexSCLXM3y1/CVIDHktCoAT49bvVYyDIq2rlk=;
        b=e3VA5wxvvuwdqxYqj+lAwv/jQW6l5dpxa8pvxaCfutzPGRUF9XA9+iDIBlegbpV4RP
         mlIDLmaWJXijihPgv2la5aZE5bQRSqB1qW63cuvWQkwHvwq8AOAouiDN6loF18uUQRIa
         ZCvSY4olHSxrQ+OClldfla2W9kzjGqMiJ7+gXfBaQn0K2DmFwvj4dHgE6DZimKToubE+
         atXDPlg2EJVinCD8Sxkro+2S9PgMTOBb4jh7j8XcnjZDRi8UO2p6NWcUWBMnE8qUp1mW
         N+oKqSPN2LJhcE4dv0lcy/BRiZ7H/uysB8hBkX7gQTez1/KuKD+u7RfyioXN391iyVo6
         N2pg==
X-Gm-Message-State: AOJu0YwAILQ8Gn6Q989FxxiE1fNQfUIBz6d01lu9brXzfLw/v7qTxpJd
        A5oc8NJw9tkuKHpQ98x5xw==
X-Google-Smtp-Source: AGHT+IG+zDL2Fad/PcYWzK8AWbmBY6SajXktKNR9JFgpXu9PXUdpkMssQC419M+Fo44nVjAKZAIyug==
X-Received: by 2002:a05:600c:446:b0:401:bbeb:97c4 with SMTP id s6-20020a05600c044600b00401bbeb97c4mr2026162wmb.37.1693402733905;
        Wed, 30 Aug 2023 06:38:53 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b963:7410:17bb:6f65:50d0:b82b])
        by smtp.gmail.com with ESMTPSA id x14-20020a05600c2a4e00b003fed70fb09dsm2326343wme.26.2023.08.30.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:38:53 -0700 (PDT)
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
Subject: [PATCH v2 3/5] ARM: dts: rockchip: Add USB host clocks for RK3128
Date:   Wed, 30 Aug 2023 15:36:25 +0200
Message-ID: <20230830133623.83075-8-knaerzche@gmail.com>
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

Add the required AHB clocks for both the ehci and ohci controller.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index b63bd4ad3143..ffe99db0eeb7 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -109,6 +109,7 @@ usb_host_ehci: usb@101c0000 {
 		compatible = "generic-ehci";
 		reg = <0x101c0000 0x20000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST2>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -118,6 +119,7 @@ usb_host_ohci: usb@101e0000 {
 		compatible = "generic-ohci";
 		reg = <0x101e0000 0x20000>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_HOST2>;
 		phys = <&usb2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.42.0

