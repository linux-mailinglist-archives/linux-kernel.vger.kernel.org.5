Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F115780EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378011AbjHRPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378006AbjHRPKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:10:54 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F96FE5F;
        Fri, 18 Aug 2023 08:10:53 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76d84238f01so63882385a.2;
        Fri, 18 Aug 2023 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371452; x=1692976252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bArMg3pWRFuQXJwECjeBn7psgnBpJoxWz+Fn+NBhMDY=;
        b=DzcHASW60vyltqv9kr0kQPHk4Bsak0E2AIysRxVCx3aRD35A5IkYnzmQHzbOj+HJXj
         KmD6g5j0dnJ1BJbEcod2h+7nAiM0m6JHGjLk0VmGKyiDXilDuhEq5h/aUVHkUlu3W5WH
         v1joelEJc8m0+G80T0XJ2HueUE0vXRkfv58CJYELMgQcUtjesI1v+9VH5Dxcc17FBcZC
         P8CVixxzSK1JD//BKXl3dX46d3kdAZZdrj6gYbV9GhpnHLPRKd1Cge7XaR/TQSV1q2Re
         Hrn3CbKpLWIWjVof3YKF8JtsCqr5xxzDdiFNBpInViwd1F/xPeNryE6gCU/3sfCaYvAz
         ZXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371452; x=1692976252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bArMg3pWRFuQXJwECjeBn7psgnBpJoxWz+Fn+NBhMDY=;
        b=AuikQvqc2+3zoRTOLtodadZpzhC/zTHVmqAycSRh4x+lvdiF7Hp8ZazCHXzRIuyj5h
         6cFcCurzru4xdKCISmTu7CBWDmAWgs7vgYJZfIzBn5nEqLfwmk7+zpTEBuaVXXK+IhXf
         TaIJjqoiE3cWuSDP/daXKK+PjmcVz15iRWeDTqiEW9bMrXDY1gk3s1eLAod6SoHOdkl/
         WtpIgb9jE0gh5zo97dJyBeSvkUsIidntTgZSgafwBcDbSfkFx5NUHZ4hH6nf0wnP0MlI
         Ku76S6O9VikD+JLozoOiJcpnH2jms+RhODO+HhEzjYGsaGKQdoft6eMSzw6DI/4r7TEQ
         vgFg==
X-Gm-Message-State: AOJu0YxSXT51oEKF03JKASFWZfEXdLonzM9ZIzN5IOYtzR8vGMhtb73v
        IFk2JgIElH7wnMWBFGTmW9yjp4R0ydE=
X-Google-Smtp-Source: AGHT+IGPnn/O3RXYq3Iyv0ZiSRLwxYjzhBZfo8UAzn8PikmJGHGuqN/7pt5DAurYOTGcKs+ybHhTqw==
X-Received: by 2002:a37:ad04:0:b0:76d:2764:f3b3 with SMTP id f4-20020a37ad04000000b0076d2764f3b3mr2916869qkm.56.1692371452681;
        Fri, 18 Aug 2023 08:10:52 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b0076cbcf8ad3bsm576239qkj.55.2023.08.18.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:10:51 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: am335x-pocketbeagle: add missing GPIO mux
Date:   Fri, 18 Aug 2023 11:10:37 -0400
Message-ID: <20230818151039.40566-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230818151039.40566-1-twoerner@gmail.com>
References: <20230818151039.40566-1-twoerner@gmail.com>
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

Add the default MODE setting of a GPIO pin that was missing from the device
tree (i.e. P2.20/gpio2_00). This is to ensure the GPIO pins match the
pocketbeagle wiring expectations.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
index fe4a1dbd8d88..051c8f04be21 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -267,6 +267,16 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE7)
 		pinctrl-single,bias-pulldown   = < 0x10  0x00  0x10  0x18>;
 	};
 
+	/* P2_20 (ZCZ ball T13) gpio2_00 0x888 */
+	P2_20_gpio: P2-20-gpio-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE7)
+		>;
+		pinctrl-single,bias-pullup   =   < 0x10  0x10  0x00  0x18>;
+		pinctrl-single,bias-pulldown   = < 0x10  0x00  0x10  0x18>;
+	};
+
+
 	/* P2_10 (ZCZ ball R14) gpio1_20 0x850 PIN 20 */
 	P2_10_gpio: P2-10-gpio-pins {
 		pinctrl-single,pins = <
-- 
2.41.0.327.gaa9166bcc0ba

