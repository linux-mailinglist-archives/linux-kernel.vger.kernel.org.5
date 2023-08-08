Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B627748A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjHHTgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjHHTgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:36:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D3E2178D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:01:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so50842265e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691521316; x=1692126116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NErAZ1+jiHK36qRuqDrSYR1o6Tx2jw6JcGAy27EXYPg=;
        b=vfFJq+w5TuOejiJncLe4a2+IEnq7wzFU4ePJqSO7nx6b+fb/O4vsCKbFHRoru3wUvi
         GZ1jFCyGMdT5CyP10iQf5oGi3HL/mEVYt/WdbCyIIRSi0W6wZQY0n4FfNvQVRKP2uFV1
         xwVIrBfPk3psX4jGhXKywfv5hkoXg8IFAZlolAAuQMoaVAtdIU0MKR7GdFh5mVelIYVv
         94FClmm9qPxSWK81RBZ8K2e3om3Lod1o5E83aU3ywmrgV8EXmGWkRPgj3R/mogCuigxM
         WL+xkYxe/5ywCGaZYz3wfMETYXoc9fPU3eWA8tZrwH7YNj4uFd3s5CJz9VXeIkSSD6Kk
         JhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521316; x=1692126116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NErAZ1+jiHK36qRuqDrSYR1o6Tx2jw6JcGAy27EXYPg=;
        b=AizZPSEOLcb87b6YYDv0MhLIaTHAhSv2cdL4kkMdxVZ+cm8qqxrk/DBAa/Aty49KT5
         l1ePLrNsGRCbh3QBOo2FiBf89F+B1FxyHOpH/2wZUdz0Dohfq3ifyNlZ1Ta6C8Letsk+
         rsfvcut8BRPsNrzRUjTzOzXedc4XbEBOD4jylzZmcpeAjL9Xw8Oe6OH6IbmipqzuNj5p
         MCIFXW/90M7MUQ+dvyYF3N+3KD+5NShvwOsXMY6dBbmYULoZU6OBFPMg9acp5JTcO7YR
         k2poD/4hI0V5uzhdLF9fQzPzng1Cv4Le/3lw5pW61mLYtmsMgJWDYiBCg1QjhZHilSV4
         Q99A==
X-Gm-Message-State: AOJu0Yxm3k+zFe0ujy2m4L1KuLnimyy7/2bS/S6MhItyHZLF1fBLre6L
        nip3Qdv/fIM1zaYdWCj66Bh2xw==
X-Google-Smtp-Source: AGHT+IHK1nSfjLQhmgz72gMIFZ2orkvarCJjeX2mHFN1UvNmOPFtHDSoMZP26Fm+oXW+HCYMKMKKDg==
X-Received: by 2002:adf:df06:0:b0:317:5ed4:d821 with SMTP id y6-20020adfdf06000000b003175ed4d821mr221121wrl.55.1691521316726;
        Tue, 08 Aug 2023 12:01:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6a08:bcc0:ae83:e1dc])
        by smtp.gmail.com with ESMTPSA id z14-20020adfe54e000000b00317e9f8f194sm7301055wrm.34.2023.08.08.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 12:01:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 4/8] arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the PHY
Date:   Tue,  8 Aug 2023 21:01:40 +0200
Message-Id: <20230808190144.19999-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808190144.19999-1-brgl@bgdev.pl>
References: <20230808190144.19999-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Device-tree bindings for MDIO define per-PHY reset-gpios as well as a
global reset-gpios property at the MDIO node level which controls all
devices on the bus. The latter is most likely a workaround for the
chicken-and-egg problem where we cannot read the ID of the PHY before
bringing it out of reset but we cannot bring it out of reset until we've
read its ID.

I have proposed a comprehensive solution for this problem in 2020 but it
never got upstream. We do however have workaround in place which allows
us to hard-code the PHY id in the compatible property, thus skipping the
ID scanning.

Let's make the device-tree for sa8775p-ride slightly more correct by
moving the reset-gpios property to the PHY node with its ID put into the
PHY node's compatible.

Link: https://lore.kernel.org/all/20200622093744.13685-1-brgl@bgdev.pl/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 09ae6e153282..a03a4c17c8f0 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -279,13 +279,13 @@ mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
-		reset-delay-us = <11000>;
-		reset-post-delay-us = <70000>;
-
 		sgmii_phy: phy@8 {
+			compatible = "ethernet-phy-id0141.0dd4";
 			reg = <0x8>;
 			device_type = "ethernet-phy";
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
 		};
 	};
 
-- 
2.39.2

