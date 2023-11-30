Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6087FE666
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344114AbjK3BtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344040AbjK3BtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:49:08 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9E510C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:14 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf89e31773so4562355ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701308954; x=1701913754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9z+ndca3Z6Eic7YQC0/xH8FsGWWOuYgGvNFQBkZMdF4=;
        b=V8mUGUo8CR512jlrrhTm/DGhlocoGQ63/iu/7Xt2+y9mq0k/dPI1dGmsuk4QtbfUn7
         5FIFfdmlm/+1h8sdKEWoGv1P4+RA+Lwh6cB+f8X2JQAptGYCeNUg19w1mdePvQCJecjl
         OPa0paqFzA5FFojBtcuVP5BYDyBOAXQ3/4o4nibuTCse0AEpNnJu5wdPcR6H5thJVjf/
         t95SGVLsFfCBLm420ouzFWsDZxhAXklkSv8fmRF5NHZcVeBWfVwkOUEMtnOt1HeTp15K
         e2ZrlL5hj7t6OKoSYV4Ms1QAlYUQ4L/Sj8wgwTrko7lfEbt0TQ+TVL+PI2J0bHyXjmOo
         10LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308954; x=1701913754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z+ndca3Z6Eic7YQC0/xH8FsGWWOuYgGvNFQBkZMdF4=;
        b=eFHEirBq1Zmek0HcQCjBlk+hTBD/zI+9YlNpLMeAecOnjDNuoDOIOyjieIv0ytjDkn
         MZVxoIqt9Vg5HpXPjFDaSITyA9WeH+Q20H1ltFBQ6JloaALX2AnYaN3UK9yR1LLuWbJd
         d032geoOUKk9T4t1BMl4X7shE86E4HSbrWRk2rzfNZDuQyMHKdgPNxBP6/p3Ai3WT8Hg
         9GEj3qgZ/L5UWmfY4dbgL87oGKvMIrf4sah3LQH1zRjH160j/uvguYwB/z3MgvQ+uOVS
         XRbX5Jvx0ISqxijeegBaREeSoo+Ub1B9Utegw0JaH5bxS5r6ltjVR4qSKdH4iJnAkxHj
         S+vA==
X-Gm-Message-State: AOJu0YyNIyuU94L8TSJvnrkrEYNS9uhWfB9c2CUkQFWJVzvUSygsm9IQ
        AfVAj/HYZ31+q1JgSm1p+hsWHA==
X-Google-Smtp-Source: AGHT+IFBN4GbO5IVrH3STjeo4NgwmKPtI5V+pg4yKuZ08Albi8y5dApuT1MLd7SBUshAcww+J5QhPw==
X-Received: by 2002:a05:6a20:e68c:b0:18b:d344:6acd with SMTP id mz12-20020a056a20e68c00b0018bd3446acdmr20940688pzb.10.1701308954337;
        Wed, 29 Nov 2023 17:49:14 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:9707:1e8c:3166:6a23])
        by smtp.gmail.com with ESMTPSA id bc3-20020a170902930300b001d00b0bd306sm24455plb.251.2023.11.29.17.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:49:14 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Wed, 29 Nov 2023 17:48:48 -0800
Subject: [PATCH v7 2/4] riscv: dts: thead: Add TH1520 mmc controllers and
 sdhci clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-th1520_mmc_dts-v7-2-c77fc19caa6f@baylibre.com>
References: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
In-Reply-To: <20231129-th1520_mmc_dts-v7-0-c77fc19caa6f@baylibre.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701308949; l=1662;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=DQ96Tg/13kE5gI7pfVf4VVYmBoxlIyPSePCjjoqiwMQ=;
 b=lhspIc86lmUso+ZOw52u80IWEJIRiUBb3EeGUsj7g6D4elrcuxNiXt5OSkhbg/64cyN4LLewT
 ewwEkRNha6EBMg1QDE3n3HSu4WVX5oLoLE+/6/jvvss58AO4TPhEjJx
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/riscv/boot/dts/thead/th1520.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ba4d2c673ac8..af4fdcd82e0b 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -146,6 +146,13 @@ uart_sclk: uart-sclk-clock {
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
@@ -304,6 +311,24 @@ dmac0: dma-controller@ffefc00000 {
 			status = "disabled";
 		};
 
+		mmc0: mmc@ffe7080000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7080000 0x0 0x10000>;
+			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
+		mmc1: mmc@ffe7090000 {
+			compatible = "thead,th1520-dwcmshc";
+			reg = <0xff 0xe7090000 0x0 0x10000>;
+			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sdhci_clk>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;

-- 
2.34.1

