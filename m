Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2E7B2960
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjI2AHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjI2AHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:07:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2B319C;
        Thu, 28 Sep 2023 17:07:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32483535e51so1447918f8f.0;
        Thu, 28 Sep 2023 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695946062; x=1696550862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8HxEWXITaOb/JDj2iD2RcKd3MGklKT/rakg7oiqV24=;
        b=iCz0GG2xVaHaFPGR1DwtawA4x3pGvbQsRhQUZVeSLE9cHU1SBBaOtYWdpfnxlbacly
         lwPavHllaKMwpR6qmYkQXxvl2921sVLqhN7rCXp44DDMnXmFWYFZ8POs2GHtoLts07b2
         0ukshVPW07hH5EOwLNrSe111oEIKKCsAXLO0IolWBTVlvqFwee1uMDSQy/3zyH7MUyYk
         EYNPPRo5tw+6Mnn81ygwgjFWoi/se5hScjn3pOjClBhgAsFuIP54SApVaw0KqRTguFXd
         3sLQ7UgOF9PQmkqrsFgNGeHxU3vCAa7RjIIpVZEeND1L1AidtxHwt5OWGaTPP+aQJG/d
         Kqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946062; x=1696550862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8HxEWXITaOb/JDj2iD2RcKd3MGklKT/rakg7oiqV24=;
        b=OiHzfRxVTjEwFigKNBzrQodfpAhsCXuEC9Ue+5hzzpJrbErF3iNXe/y7Qn9LdJJaBU
         QFBKJ/8lCS1IO1IkI00bxMhvd9yvaQwKMCQvETKbJD1LP47JuwcuEvU3Ge7o1gYP+rYY
         6Caczq2F4BZdqOtnAPOki/5HplyvHk8LJrBD8FzTY3ba0a/PKrT5461toysL3VoRHzaK
         hMMwJKML9GLbJhjhX0gHAuiF8S5uvlMVHL80pFj8NbWy60wfDJUYaM2cvF/vHSOOozpJ
         925HCwO9V1eBHcqww4ygQYxu8AiZz9erbhmfQwhR4EzhVhyxRBSS7PlfOjyDjI99CK8B
         Dqrw==
X-Gm-Message-State: AOJu0YzPWPxIfAf/AM5xo71FM4kk4LrVvkCLc7VbFEhFsBjmfRQLB2Ni
        ysF1M03SnfDewe/CXKkta5sIZtz6hz/qpnrw
X-Google-Smtp-Source: AGHT+IGnYvQpsT1nJIqqtVw96jze0gmURdXGdBK7wCDw7rx9bHLFZ6vcVVEiI0KcBP2Rarl0Ln9O8Q==
X-Received: by 2002:a5d:538f:0:b0:322:4892:17f with SMTP id d15-20020a5d538f000000b003224892017fmr2568104wrv.7.1695946061536;
        Thu, 28 Sep 2023 17:07:41 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fe98:5e2c:1821:4cb6])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b004030e8ff964sm245667wmj.34.2023.09.28.17.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:07:41 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/5] riscv: dts: renesas: rzfive-smarc: Enable the blocks which were explicitly disabled
Date:   Fri, 29 Sep 2023 01:07:02 +0100
Message-Id: <20230929000704.53217-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Now that noncoherent dma support is added for RZ/Five SoC enable
the IP blocks which were disabled on RZ/Five SMARC. Now with this
patch we get support for the below peripherals:
* DMAC
* SDHI
* USB
* RSPI
* SSI

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    | 23 --------
 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi | 56 -------------------
 2 files changed, 79 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index c62debc7ca7e..433ab5c6a626 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -7,25 +7,8 @@
 
 #include <arm64/renesas/rzg2ul-smarc-som.dtsi>
 
-/ {
-	aliases {
-		/delete-property/ ethernet0;
-		/delete-property/ ethernet1;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel";
-	};
-};
-
-&dmac {
-	status = "disabled";
-};
-
 #if (!SW_ET0_EN_N)
 &eth0 {
-	status = "disabled";
-
 	phy0: ethernet-phy@7 {
 		/delete-property/ interrupt-parent;
 		/delete-property/ interrupts;
@@ -34,14 +17,8 @@ phy0: ethernet-phy@7 {
 #endif
 
 &eth1 {
-	status = "disabled";
-
 	phy1: ethernet-phy@7 {
 		/delete-property/ interrupt-parent;
 		/delete-property/ interrupts;
 	};
 };
-
-&sdhi0 {
-	status = "disabled";
-};
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
index c07a487c4e5a..a8573fdfd8b1 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
@@ -6,59 +6,3 @@
  */
 
 #include <arm64/renesas/rzg2ul-smarc.dtsi>
-
-&ehci0 {
-	status = "disabled";
-};
-
-&ehci1 {
-	status = "disabled";
-};
-
-&hsusb {
-	status = "disabled";
-};
-
-&ohci0 {
-	status = "disabled";
-};
-
-&ohci1 {
-	status = "disabled";
-};
-
-&phyrst {
-	status = "disabled";
-};
-
-&sdhi1 {
-	status = "disabled";
-};
-
-&snd_rzg2l {
-	status = "disabled";
-};
-
-&spi1 {
-	status = "disabled";
-};
-
-&ssi1 {
-	status = "disabled";
-};
-
-&usb0_vbus_otg {
-	status = "disabled";
-};
-
-&usb2_phy0 {
-	status = "disabled";
-};
-
-&usb2_phy1 {
-	status = "disabled";
-};
-
-&vccq_sdhi1 {
-	status = "disabled";
-};
-- 
2.34.1

