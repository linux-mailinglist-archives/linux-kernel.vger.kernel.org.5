Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3658767FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjG2NpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjG2NpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B03C04;
        Sat, 29 Jul 2023 06:44:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68706d67ed9so1644709b3a.2;
        Sat, 29 Jul 2023 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638254; x=1691243054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpr63tUB9bl7NCtcSC/cknTWVMMZqD7akwFhnm/mca4=;
        b=nzrmwsC/bqoPJk8triPLF/OkHJR5KSKI7f+cD4xuH2VdJmSw86hwPKf+4nX5ZbmLA0
         GS1Czc1rP0JIGitD5+ylfT0gBihh24nkYjO0D95qGAoYFc5ahESWxF8FWy76dLzmmu/w
         InDx/ZkeobUpOcR2cwJrLGx5xAAJtHqHrPVLRFYRgl3mauOMj8hgm6R82QcsLPT6Lz/U
         fey6AFhbJm2h2NL9j/cobtlMs8iWMfLaMmfEtjWsfail2JN5ghhiEbttaiF+j0vOCSfc
         ShCiJBm/IXUefPrc0ROezsWpmjdwKY2QNi+nvx8YUTbs9i4VcTVGDe9esr3VSXTKYrj5
         zWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638254; x=1691243054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpr63tUB9bl7NCtcSC/cknTWVMMZqD7akwFhnm/mca4=;
        b=XOvLTgmPCLGO7HTlk3zuxc9hri6xAvoCS4kusQAdrclPMgYtyeaqZ+yWDI7Qy7xgnX
         yJPhpz3cbs/1/zPkEaPTiiQVOSyGuv0Mx4a57ml4uXV/aS2Y1D1mH4oSPqjpD4+toTRK
         m9TDcLjz2Qa0CixiM9awxBOcQB8W0LjR+et7i1QSdKDta4xKHjuuQnrvLvcz4ObyLmo8
         8E+LpLEpNKnE8vcbAld6p9dzvIPD9XfJLtQxXWxc6aDDDIktQOyoJHlDquNyVWwL26+M
         YVhjUtSqDhu7/buRv7n0HplgVhOI5JqMibm4HyV2aCaMR5cvcGCXQwn6kGpl2++xhT/c
         eFpQ==
X-Gm-Message-State: ABy/qLbGxgM+9UmfhSAybphmtU0Ghu0Vqsc3rvK+3Q6AILtqYN3AFfmX
        hvCeZqyNEO1MXkNqe3Z+hxlB2b0vFLou8w==
X-Google-Smtp-Source: APBJJlHm0ujbR4/4yw9PHkCKjiUpyoSkwnuNl6WT7jwD5avUSblqCzxaCvjlKdcPva5VLtBsQtqcIw==
X-Received: by 2002:a05:6a00:189d:b0:64a:2dd6:4f18 with SMTP id x29-20020a056a00189d00b0064a2dd64f18mr6675489pfh.13.1690638253856;
        Sat, 29 Jul 2023 06:44:13 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:13 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 12/17] MIPS: loongson32: Convert RTC platform device to DT
Date:   Sat, 29 Jul 2023 21:43:13 +0800
Message-Id: <20230729134318.1694467-13-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RTC device node for Loongson-1 boards,
and drop the legacy platform device and data accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1b.dtsi   | 12 ++++++++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi   |  9 +++++++++
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |  4 ++++
 arch/mips/boot/dts/loongson/smartloong_1c.dts |  4 ++++
 arch/mips/loongson32/common/platform.c        |  6 ------
 arch/mips/loongson32/ls1b/board.c             |  1 -
 arch/mips/loongson32/ls1c/board.c             |  1 -
 7 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
index 7b4914c358df..935e559016d6 100644
--- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -132,6 +132,18 @@ phy1: ethernet-phy@0 {
 	};
 };
 
+&apb {
+	rtc: rtc@1fe64000 {
+		compatible = "loongson,ls1b-rtc";
+		reg = <0x1fe64000 0x78>;
+
+		interrupt-parent = <&intc0>;
+		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+
+		status = "disabled";
+	};
+};
+
 &gpio0 {
 	ngpios = <31>;
 };
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
index 7204b829c801..f68bef1f65d3 100644
--- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -88,6 +88,15 @@ ohci0: usb@1fe28000 {
 	};
 };
 
+&apb {
+	rtc: rtc@1fe64000 {
+		compatible = "loongson,ls1c-rtc";
+		reg = <0x1fe64000 0x78>;
+
+		status = "disabled";
+	};
+};
+
 &gpio0 {
 	ngpios = <32>;
 };
diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
index 71838f867f8c..d3988d789c0f 100644
--- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
+++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
@@ -63,6 +63,10 @@ &ohci0 {
 	status = "okay";
 };
 
+&rtc {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
index 3277770c33fe..1b7741dcb87f 100644
--- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
+++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
@@ -59,6 +59,10 @@ &ohci0 {
 	status = "okay";
 };
 
+&rtc {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 3b984c805eb0..7d0120fe9a5b 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -16,12 +16,6 @@
 #include <nand.h>
 #include <irq.h>
 
-/* Real Time Clock */
-struct platform_device ls1x_rtc_pdev = {
-	.name		= "ls1x-rtc",
-	.id		= -1,
-};
-
 /* Watchdog */
 static struct resource ls1x_wdt_resources[] = {
 	{
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index ecc405aa9016..59c70c7ffe1a 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -13,7 +13,6 @@
 #include <platform.h>
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
-	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
 };
 
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index 29bc467fd149..4c2d44f9f6f2 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -6,7 +6,6 @@
 #include <platform.h>
 
 static struct platform_device *ls1c_platform_devices[] __initdata = {
-	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
 };
 
-- 
2.39.2

