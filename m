Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E3D7F0DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjKTIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjKTIk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:40:58 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F07F0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:40:54 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c875207626so20347431fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700469652; x=1701074452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uja6WpBlyTBG5jgby6fiOGTUsSLknCmEeqWb3eouYXA=;
        b=c2m91qd37sKAC7md1tLXGmis4c0PJQszj8lhdgWHUtHGsgDEc3sFYCmIlFTIIHKz1s
         nfmG4JAJnqJy1p1WefOcvlbbYOyb37UkTX/NCevuc6I6oq8t6NCSQ3M6UGVBx/OLErcQ
         AHvVmByTss7pWvIqaqzcBXfdDkUOPbtrpUdM27p12o+8kPcuywFjsbPAmojVRxHW2uNr
         UGsU3B6sQXUPWuIvFm2xFFoTiUFccJI2gKSc+AOQc1Wp8e9b9UkyKm+3yMI6P+lCSDaD
         O8SKgcSK42PTCin9jQPNCUgGQQjaODTJxGJLHNEbKoibEPuzbZT4hxwB3AuZraBtC80D
         Tmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469652; x=1701074452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uja6WpBlyTBG5jgby6fiOGTUsSLknCmEeqWb3eouYXA=;
        b=EkW7LB0JSIuasKEE64pzKNSgmnwRpfCdjK7rby4I0QA+36UyEn0TnU/16IsLUx6Yup
         i5rrPH4IpH6SeSGoC3OPIsJHKWNuSwk7GEPsaxDF/XzqZSGXc9cm16vxgPYvrzmNqEio
         fcvBGnyYMTtRacmXzGo/gQE63HTHn/poKG8g+3A4s1Gc4Vf7TI27KJUdeH5zhcK7CwOd
         H3Pt63usvOc3yd7uFux4DpyxYEvgXSYFQzJvRN6gDKFc+Zcrm8nQGBCKdE8A+TkKPSV5
         jTtPkbeTzV7dGDjsRN+0xmpEWFKEeOTp98aBSCas3meC6xJQWXbbvephkA7Mm3rlGbTO
         qFig==
X-Gm-Message-State: AOJu0YzZzq3RcteIxIhANVlhlobTi+1A/ELmxsnatgrHgarnEtoCGkpN
        Ksdd5yZCQLKdhHH5k9FPsePbFg==
X-Google-Smtp-Source: AGHT+IF2z2UJKmxACAGYnsgCuyDmhU5DSNYyJ8jl3UYFsf5HLqN43Rt4pV8YyXHZTojYeH5cxbBtXA==
X-Received: by 2002:a2e:bc0f:0:b0:2c6:eccb:344d with SMTP id b15-20020a2ebc0f000000b002c6eccb344dmr6049660ljf.40.1700469652204;
        Mon, 20 Nov 2023 00:40:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0040772138bb7sm17248340wmq.2.2023.11.20.00.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:40:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
Date:   Mon, 20 Nov 2023 09:40:44 +0100
Message-Id: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document preferred coding style for Devicetree sources (DTS and DTSI),
to bring consistency among all (sub)architectures and ease in reviews.

Cc: Andrew Davis <afd@ti.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Merging idea: Rob/DT bindings

Changes in v2
=============
1. Hopefully incorporate entire feedback from comments:
a. Fix \ { => / { (Rob)
b. Name: dts-coding-style (Rob)
c. Exceptions for ordering nodes by name for Renesas and pinctrl (Geert,
   Konrad)
d. Ordering properties by common/vendor (Rob)
e. Array entries in <> (Rob)

2. New chapter: Organizing DTSI and DTS

3. Several grammar fixes (missing articles)

Cc: linux-rockchip@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
---
 .../devicetree/bindings/dts-coding-style.rst  | 163 ++++++++++++++++++
 Documentation/devicetree/bindings/index.rst   |   1 +
 2 files changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
new file mode 100644
index 000000000000..cc7e3b4d1b92
--- /dev/null
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -0,0 +1,163 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _dtscodingstyle:
+
+=====================================
+Devicetree Sources (DTS) Coding Style
+=====================================
+
+When writing Devicetree Sources (DTS) please observe below guidelines.  They
+should be considered complementary to any rules expressed already in Devicetree
+Specification and dtc compiler (including W=1 and W=2 builds).
+
+Individual architectures and sub-architectures can add additional rules, making
+the style stricter.
+
+Naming and Valid Characters
+---------------------------
+
+1. Node and property names are allowed to use only:
+
+   * lowercase characters: [a-z]
+   * digits: [0-9]
+   * dash: -
+
+2. Labels are allowed to use only:
+
+   * lowercase characters: [a-z]
+   * digits: [0-9]
+   * underscore: _
+
+3. Unit addresses should use lowercase hex, without leading zeros (padding).
+
+4. Hex values in properties, e.g. "reg", should use lowercase hex.  The address
+   part can be padded with leading zeros.
+
+Example::
+
+	gpi_dma2: dma-controller@800000 {
+		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
+		reg = <0x0 0x00800000 0x0 0x60000>;
+	}
+
+Order of Nodes
+--------------
+
+1. Nodes within any bus, thus using unit addresses for children, shall be
+   ordered incrementally by unit address.
+   Alternatively for some sub-architectures, nodes of the same type can be
+   grouped together (e.g. all I2C controllers one after another even if this
+   breaks unit address ordering).
+
+2. Nodes without unit addresses should be ordered alpha-numerically by the node
+   name.  For a few types of nodes, they can be ordered by the main property
+   (e.g. pin configuration states ordered by value of "pins" property).
+
+3. When extending nodes in the board DTS via &label, the entries should be
+   ordered alpha-numerically.
+
+Example::
+
+	// SoC DTSI
+
+	/ {
+		cpus {
+			// ...
+		};
+
+		psci {
+			// ...
+		};
+
+		soc@ {
+			dma: dma-controller@10000 {
+				// ...
+			};
+
+			clk: clock-controller@80000 {
+				// ...
+			};
+		};
+	};
+
+	// Board DTS
+
+	&clk {
+		// ...
+	};
+
+	&dma {
+		// ...
+	};
+
+
+Order of Properties in Device Node
+----------------------------------
+
+Following order of properties in device nodes is preferred:
+
+1. compatible
+2. reg
+3. ranges
+4. Standard/common properties (defined by common bindings, e.g. without
+   vendor-prefixes)
+5. Vendor-specific properties
+6. status (if applicable)
+7. Child nodes, where each node is preceded with a blank line
+
+The "status" property is by default "okay", thus it can be omitted.
+
+Example::
+
+	// SoC DTSI
+
+	usb_1_hsphy: phy@88e3000 {
+		compatible = "qcom,sm8550-snps-eusb2-phy";
+		reg = <0x0 0x088e3000 0x0 0x154>;
+		#phy-cells = <0>;
+		resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+		status = "disabled";
+	};
+
+	// Board DTS
+
+	&usb_1_hsphy {
+		clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
+		clock-names = "ref";
+		status = "okay";
+	};
+
+
+Indentation
+-----------
+
+1. Use indentation according to :ref:`codingstyle`.
+2. For arrays spanning across lines, it is preferred to align the continued
+   entries with opening < from the first line.
+3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
+   should be enclosed in <>.
+
+Example::
+
+	thermal-sensor@c271000 {
+		compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
+		reg = <0x0 0x0c271000 0x0 0x1000>,
+		      <0x0 0x0c222000 0x0 0x1000>;
+	};
+
+Organizing DTSI and DTS
+-----------------------
+
+The DTSI and DTS files should be organized in a way representing the common
+(and re-usable) parts of the hardware.  Typically this means organizing DTSI
+and DTS files into several files:
+
+1. DTSI with contents of the entire SoC (without nodes for hardware not present
+   on the SoC).
+2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
+   entire System-on-Module).
+3. DTS representing the board.
+
+Hardware components which are present on the board should be placed in the
+board DTS, not in the SoC or SoM DTSI.  A partial exception is a common
+external reference SoC-input clock, which could be coded as a fixed-clock in
+the SoC DTSI with its frequency provided by each board DTS.
diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
index d9002a3a0abb..cc1fbdc05657 100644
--- a/Documentation/devicetree/bindings/index.rst
+++ b/Documentation/devicetree/bindings/index.rst
@@ -4,6 +4,7 @@
    :maxdepth: 1
 
    ABI
+   dts-coding-style
    writing-bindings
    writing-schema
    submitting-patches
-- 
2.34.1

