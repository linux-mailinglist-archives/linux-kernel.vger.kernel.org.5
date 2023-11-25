Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6058E7F8D31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjKYSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:44:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63BFF7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:44:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a011e9bf336so408636066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700937872; x=1701542672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MXUstR7Xy9tnBrtksEQd/hbu5+ugdxqEwGT2RmAkAxQ=;
        b=iZoL/0xvp4k+7Uh7sblPV1v6Q3+BwGwRYWwkIafVI9F4YpH7f8Se8vnn5SbW3pILR4
         lkDri02G/gZyNVE5r2C6rKdt2VdCQWQIJ4kI+Hz+ndwCB91+M9UNPoVFMFUiIMuqEKq8
         kVRRkgnsC6JQC2ryEiFoMFWzLQC/PB4Fx9+na5o56B2eiCE75KB9vDYNfDP7m0ri/2fw
         6GonobRFwnu9MvzXW7bUAsPNvC/ZTpDcWt3PSqPwNogolD9693lcYRAZxT2/5xHCAXNa
         ye1GnKietUZ1ZlgaBDEUWOE33Q0ibpnXxMctykXuxGA5aWh0ro9sxH7Zx07Re+zlKg9f
         5SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700937872; x=1701542672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXUstR7Xy9tnBrtksEQd/hbu5+ugdxqEwGT2RmAkAxQ=;
        b=YLET7Ju+BtHWJyIEPo5q7/cVyK4Y865ocM7lZhqykpADaNWA5r09S706u3eCg5xuOs
         jkSEjljRgosRnyUjPNCN+NHEw0vAyAtj4k5ULDKP087hsjwCBblJjsXDWgYP0DWpf9kG
         bJmKdxZhPKYpS5N1qXBOwcnz2j5/RyvnXCHjlU+sDaqcbvrxUfcX6lnBorFbfsnr3t9I
         Q+9GC9R37kJq8GhWm3I9mb+fYq2DsYpSeX3bzNdhoE1z873iMYgKR0Fg7J6kz7vxIkHo
         /s+12xfxiZX8QjmgZpvpbi5dYLTaR9slwyJSkklTuVS7cL8K6wdnNc2G2cX9bSJjiY1N
         55og==
X-Gm-Message-State: AOJu0YwPGzJ9QCbCchZhtFhitZGYQJh/sMrsO4ubx5QldrCQjbq3GZ4F
        CXJIu/pDoNLYnmaTw3ZlIMXHGg==
X-Google-Smtp-Source: AGHT+IG0p1cN7S1e73FovrjNTWznxSs1Y/JTDOV400UkrX1ND/mMHN/cl9JI2N6LHUlMmRph94th7Q==
X-Received: by 2002:a17:907:9250:b0:9ae:420e:739b with SMTP id kb16-20020a170907925000b009ae420e739bmr4008521ejb.46.1700937872326;
        Sat, 25 Nov 2023 10:44:32 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090632cd00b009ca522853ecsm3776610ejk.58.2023.11.25.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 10:44:31 -0800 (PST)
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
        Andrew Davis <afd@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Date:   Sat, 25 Nov 2023 19:44:22 +0100
Message-Id: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document preferred coding style for Devicetree sources (DTS and DTSI),
to bring consistency among all (sub)architectures and ease in reviews.

Cc: Andrew Davis <afd@ti.com>
cc: Andrew Lunn <andrew@lunn.ch>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Rafał Miłecki <zajec5@gmail.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Merging idea: Rob/DT bindings

Changes in v3
=============
1. should->shall (Angelo)
2. Comments // -> /* (Angelo, Michal)
3. Use imaginary example in "Order of Properties in Device Node"
   (Angelo)
4. Added paragraphs for three sections with justifications of chosen
   style.
5. Allow two style of ordering overrides in board DTS: alphabetically or
   by order of DTSI (Rob).
6. I did not incorporate feedback about, due to lack of consensus and my
   disagreement:
   a. SoM being DTS without DTSI in "Organizing DTSI and DTS"

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
Cc: workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 .../devicetree/bindings/dts-coding-style.rst  | 194 ++++++++++++++++++
 Documentation/devicetree/bindings/index.rst   |   1 +
 2 files changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
new file mode 100644
index 000000000000..e374bec0f555
--- /dev/null
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -0,0 +1,194 @@
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
+Devicetree specification allows broader range of characters in node and
+property names, but for code readability the choice shall be narrowed.
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
+3. Unit addresses shall use lowercase hex, without leading zeros (padding).
+
+4. Hex values in properties, e.g. "reg", shall use lowercase hex.  The address
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
+2. Nodes without unit addresses shall be ordered alpha-numerically by the node
+   name.  For a few types of nodes, they can be ordered by the main property
+   (e.g. pin configuration states ordered by value of "pins" property).
+
+3. When extending nodes in the board DTS via &label, the entries shall be
+   ordered either alpha-numerically or by keeping the order from DTSI (choice
+   depending on sub-architecture).
+
+Above ordering rules are easy to enforce during review, reduce chances of
+conflicts for simultaneous additions (new nodes) to a file and help in
+navigating through the DTS source.
+
+Example::
+
+	/* SoC DTSI */
+
+	/ {
+		cpus {
+			/* ... */
+		};
+
+		psci {
+			/* ... */
+		};
+
+		soc@ {
+			dma: dma-controller@10000 {
+				/* ... */
+			};
+
+			clk: clock-controller@80000 {
+				/* ... */
+			};
+		};
+	};
+
+	/* Board DTS - alphabetical order */
+
+	&clk {
+		/* ... */
+	};
+
+	&dma {
+		/* ... */
+	};
+
+	/* Board DTS - alternative order, keep as DTSI */
+
+	&dma {
+		/* ... */
+	};
+
+	&clk {
+		/* ... */
+	};
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
+Above order follows approach:
+
+1. Most important properties start the node: compatible then bus addressing to
+   match unit address.
+2. Each node will have common properties in similar place.
+3. Status is the last information to annotate that device node is or is not
+   finished (board resources are needed).
+
+Example::
+
+	/* SoC DTSI */
+
+	device_node: device-class@6789abc {
+		compatible = "vendor,device";
+		reg = <0x0 0x06789abc 0x0 0xa123>;
+		ranges = <0x0 0x0 0x06789abc 0x1000>;
+		#dma-cells = <1>;
+		clocks = <&clock_controller 0>, <&clock_controller 1>;
+		clock-names = "bus", "host";
+		vendor,custom-property = <2>;
+		status = "disabled";
+
+		child_node: child-class@100 {
+			reg = <0x100 0x200>;
+			/* ... */
+		};
+	};
+
+	/* Board DTS */
+
+	&device_node {
+		vdd-supply = <&board_vreg1>;
+		status = "okay";
+	}
+
+Indentation
+-----------
+
+1. Use indentation according to :ref:`codingstyle`.
+2. For arrays spanning across lines, it is preferred to align the continued
+   entries with opening < from the first line.
+3. Each entry in arrays with multiple cells (e.g. "reg" with two IO addresses)
+   shall be enclosed in <>.
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
+The DTSI and DTS files shall be organized in a way representing the common
+(and re-usable) parts of the hardware.  Typically this means organizing DTSI
+and DTS files into several files:
+
+1. DTSI with contents of the entire SoC (without nodes for hardware not present
+   on the SoC).
+2. If applicable: DTSI with common or re-usable parts of the hardware (e.g.
+   entire System-on-Module).
+3. DTS representing the board.
+
+Hardware components which are present on the board shall be placed in the
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

