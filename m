Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6E784449
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjHVObQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbjHVObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:31:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394ACEF;
        Tue, 22 Aug 2023 07:31:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bd0afbd616so3473519a34.0;
        Tue, 22 Aug 2023 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692714671; x=1693319471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsWTJD3ltCClAmobbJQJ83gWipLBvL+hCSH7zY5DAw0=;
        b=FGpERl3S29e/bMc0Evs9EXKtLpXJkhPL17eTEY8vjDSBGlEpjhMPbQXJa8HonxWbHx
         ZkZtl0OttvucnkRybhs7OZ1KUvERmhU2vxWT8y2t4iwSu4w85E6jNBtqSkuifFcXkp9Y
         nSUPfgH3PaNNeH6uMdVOqerZ1zZxUj9pFRJ7PegGtyvoGhHOj8o0tHh5Gxgw6ohqShqT
         Is019LylG4qzpweLvKLBr+Rs295wnm1+e+lV4ZxIEd7krHcOb5dOfW4ep+QCcLgzevaO
         DwmcnT/V3qwI9rH5c6ybVKxni5govs22kZCvwCv1NoBviUPZQy9wkPcwPmblwO21Iqb1
         3cZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714671; x=1693319471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsWTJD3ltCClAmobbJQJ83gWipLBvL+hCSH7zY5DAw0=;
        b=iozwuWqviil/A8MqNQ0qnFdxF63SZMqWRs5fpAwP16s0Dx48x5GHbZDZ8ZA7Whbf3+
         sVjv/YWsGcJE1hxRXxZyaAndCj3KZLrRA2VdWqJr76DOtmGmSWCKuZCT5n6flHtBKfnR
         VS4YcZVNXf7p1XiIDeBp+PQNNjV182G5SNMKrUpu2+h3rXBVmEoVudduAFEU0ESzeaY6
         z56gucb3K9IdQHUzreU+QL/lDLdgcnGCBgcIczuedJfxDRMCQA9T1g3IpO2aQ363uLaK
         MjyDLV24KConSMil7Q2BaLw+MTYafpopIZvpJU3V4CZwMG1+KqXaJ8E+ZKv08N5nPynU
         Qf+w==
X-Gm-Message-State: AOJu0YxX+jfyeq1xai5F6TgIO1DndySgGZ2au5jyWD9WFqZuxCT8bJbA
        DBRRZCZPPO5TZ8QoREf04zs=
X-Google-Smtp-Source: AGHT+IHSFh63MdCPpGxWkF/lZI81GdaD2eXwZ8LmoJnR6RYpsOUSDC213iUcpofdTNJf3y7AxLmhKQ==
X-Received: by 2002:a9d:7f01:0:b0:6b7:206e:edf7 with SMTP id j1-20020a9d7f01000000b006b7206eedf7mr11025126otq.1.1692714670905;
        Tue, 22 Aug 2023 07:31:10 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e19-20020ac86713000000b00407ffb2c24dsm3055750qtp.63.2023.08.22.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:31:10 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     robertcnelson@gmail.com, drew@beagleboard.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: am335x-pocketbeagle: add missing GPIO mux
Date:   Tue, 22 Aug 2023 10:30:50 -0400
Message-ID: <20230822143051.7640-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230822143051.7640-1-twoerner@gmail.com>
References: <20230822143051.7640-1-twoerner@gmail.com>
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
index e35d84ca5706..8042917b3b3b 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-pocketbeagle.dts
@@ -271,6 +271,16 @@ AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE7)
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

