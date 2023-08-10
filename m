Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A977723B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjHJIJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjHJIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4A2130
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so3306185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654958; x=1692259758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZfHcD5iKH92nMGOtJsjwO8F6ScspW6SHo1XJSm0hk0=;
        b=GnussyPTIou8eprNZioYl3UmyJGVZQP8PfyJOLOPBK1CNKetnRc0vmVqo5N0gamois
         mDlyOKYcXpldli1Uf0D+1d6QD1Bjkvn+t29P7/IKGJ5ETzI9dkVfatfMJOps9XPx0jFn
         ufMMCcxwL6cyG5Y5/4YEBlV3p+OMOxSUoYvboqVTi8r8pYTZT7mQ3aY8B0bzTAbZNYLF
         Sr6yp7zjNz83J09XXwaAp7Yvu60uZHInHTD8H7p8+rcwtLwhX0n+xvsqnq3tRxvfGGGV
         cIATdwKoJP0CyLQTkmM3WrCBWEpFGFYMz7yGqYCxAdF9d5deCSgf7oZCn7n9x03K8Fu5
         WGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654958; x=1692259758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZfHcD5iKH92nMGOtJsjwO8F6ScspW6SHo1XJSm0hk0=;
        b=PydGWM09Vsky9rjUeBwXWTVo/X28nPEWsP+t5UEcaEiQGNiCIhUyrX2uaEcrFf0Eiw
         R2isKHITB29Ecl/FWt20okaQa6eZjXF2n79hyBtDOr75f+pEW0/IS09yjYxQ+7Obc02/
         +SdNHXB7JF27bqYxV7Z4Y8Xb+vp6TV12DSQO0S1xA4SOlp2gfezcFSsYq3mF/kUYGYUt
         bnCOvdFSRWxehy//gzIYh8dADmY//JnVYo17jqAT01obZk8lS0kMXik4jKCRP2Kag8oI
         En+e60qVcbmoY3G83VJHZBUNeQ4Prg1qtcZrkahSN7xMOkItwSWrYBzJcMyf5oipI070
         Q2pA==
X-Gm-Message-State: AOJu0YzDU+ADV6VeFZBa2xtj/CKuEBLsXhb0lHyCI53Np2c64UkUfL02
        xjk342g900aBsYwWb+m1ofL9TA==
X-Google-Smtp-Source: AGHT+IGIa8oSvb3iGBVIroJMvJcCqmcdtRG4qeQaivBsqa9/Ce15p1oaQ2VrL0P69NEdqF95toUoaQ==
X-Received: by 2002:a05:600c:285:b0:3fb:af9a:bf30 with SMTP id 5-20020a05600c028500b003fbaf9abf30mr968467wmk.2.1691654957797;
        Thu, 10 Aug 2023 01:09:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:17 -0700 (PDT)
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
Subject: [PATCH v3 4/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the PHY
Date:   Thu, 10 Aug 2023 10:09:04 +0200
Message-Id: <20230810080909.6259-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
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

