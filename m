Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26687E82A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjKJTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346173AbjKJTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:20:18 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C108558D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:14:58 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a69a71cc1dso63453639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596897; x=1700201697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=3VX06VsnXFEE5pzwPlH119yZopc2TYs+/um0VBFWdtlt8LOBg77hjRcE/ZmnUvZkQj
         vOR+BoJXtOag4G4qhmBWc88betpYz6Y7hAWMu5KWhYzjHJYBS4bcCaS6ZMVST8+j5vRV
         jNCR7NBU3WP3HPyOErGO+kb4Ww7P3TUa8CCcNT5QJDU8EnTSRYKjZRZUOBEVjRY1mjm4
         sP7TAlHZlOpzpdwuqjgioKdURCigL1KD6QNfgfA+tS5EaVroMgTli2YCgQAH+GikOdCf
         3c8GNYEf//Dx9Qd2mGKeWf2Adn4cRJhXAWgbncNbfmQ4J34A8opaL1kl/K1kiSj3m+9z
         UIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596897; x=1700201697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frioRiPhaekRnCE/0ENvI5wkvdspg2jE1Z81EEiVDoc=;
        b=OheSK+HNyoOzWX3LHGFfwYxYWJDbsD3Z4CQeKSYpSjj17KmfSF1B0eKk/bem0CZXPA
         YQz9QmgSCh8rviQbrezblTxGp8PA7DjkA7IxCCkB9PU5xioElnWOmQkxnDAJTazJEU33
         /z1beubhDFAdnhzTVPtqtVXe6X32fsZn1qKN4KufDcODvIwUvc/A6B8ZgqbL9KlJDeTz
         gCNof1Gr33r5zXXHQ+bezsR3hXkaSQFyuR4GiEPyhdpDWorKmwrraqcruze0+H58O0Ux
         7GkaQIKdBSmlDtKfJkSJ4jRjj5aKO+OaDq+V84y491mqXtaw5jXcKmXyvFzk4otl8ZVX
         bVkA==
X-Gm-Message-State: AOJu0Yyrnv6PDbTqpwfNDjxksVyTY2Ts7YWO8uoFEGJsHCi4ScWU4Utl
        F7P/d+ddexi6hqtEobaej5/LZCBZG/gF/ipGcOSwLA==
X-Google-Smtp-Source: AGHT+IEPm64O/kPii92CwhwQe1YfvABcclwau/EBIc09Nos6a3An9QWe0GQ8ouZ4SdnmIGy2UbbfeA==
X-Received: by 2002:a17:903:41cd:b0:1cc:6fa6:ab62 with SMTP id u13-20020a17090341cd00b001cc6fa6ab62mr7777004ple.29.1699594954577;
        Thu, 09 Nov 2023 21:42:34 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:34 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Thu, 09 Nov 2023 21:41:15 -0800
Subject: [PATCH v5 5/7] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-th1520-mmc-v5-5-018bd039cf17@baylibre.com>
References: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
In-Reply-To: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=1608;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=118IOeI3EDHQnRGvuv5ewuNsGEAnYvxtIZdzQTMEyXk=;
 b=yeOrLz+tWTsGAfXBiTlsUCM457E2vnWs1IdM64XT3ndoS1ZsuBso99iSFBRWZAC6Hpujod2vK
 xZA5w+PGj/PAXAJNWux4UMW0MTSz3dqYn8V63Datq2uZLRYpXMPuJ8B
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the SDHCI fixed clock. Add mmc0 node for the first mmc
controller instance which is typically connected to the eMMC device.
Add mmc1 node for the second mmc controller instance which is typically
connected to microSD slot.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ff364709a6df..f5ec9326c4b8 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -134,6 +134,13 @@ uart_sclk: uart-sclk-clock {
 		#clock-cells = <0>;
 	};
 
+	sdhci_clk: sdhci-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <198000000>;
+		clock-output-names = "sdhci_clk";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -292,6 +299,22 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
+		mmc1: mmc@ffe7090000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7090000 0x0 0x10000>;
+			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

