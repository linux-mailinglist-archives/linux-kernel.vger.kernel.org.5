Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842BB80260C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 18:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjLCRq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 12:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCRq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 12:46:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20635DB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 09:46:30 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00191363c1so523222566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 09:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701625588; x=1702230388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCpcC5jwuJ3yk3mN0wyq8cYLJUEg433CyyhoyVbqIAs=;
        b=qig25tzAXkMlzho1OJobgZuJLjXqXZx2uHniiADtfVcYNTIM7sKSFD2UmkE935AhUu
         k3Rxn5Bl4Zmz/WfkDDG4QCvSnZgbSvtBwWj9RBr0MKcEzKL7kwJQsHKV1650tm+8mGbR
         oEGdEYcJGDSHCUflWWHeB/MIvv14F4JP39B7yC9KjoPTj3T7wgg2C5WrY7JovqIfElCa
         TSwH9n1UD6RcMSBRhDJrwpf0Xb431l+m7Sdkq9prT29D8rYk9wsYhkeB4msXExEvhAYA
         TxJaQOg6PDo3QZQB93TtLrT8C5Ys+P+ZbM0X+tOuknGe/A6GsQ0wnhb6A2VnEOXvVAIA
         jSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701625588; x=1702230388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCpcC5jwuJ3yk3mN0wyq8cYLJUEg433CyyhoyVbqIAs=;
        b=jpxg5Yg56cbky7ZzFbQJDqUFcmZqtRLtVi8E0dGErBUFp6Tw6WvONf/6CjRUz7/sOg
         XCy2+EepqN7jpNkfa08JCxuJ9dVCReOasMJOdC9J5ip0yYq6WLjVh2N4oWjZVsb6bKbM
         geqjwPP+oD6SGWq2E1W7ktyWfyGgvbK1N8aLupwOWp0BVwpxBHkTPweBxIYYRxSfNryw
         Y2UZBrD4hU5Mb6f4oIolO8c9hUEX/kEPAWN2bQMAZuBCVIBGsXi5UyH8EiQKlF1VIbn/
         2kQ8gyn0ARX0RMdwnAcBgpi5SxZEBM2yrb38YglgB56zPrQEq7NNfVSUwa8CUarWBqt0
         Z1lQ==
X-Gm-Message-State: AOJu0YzEroCr38e45SVZaFZ5gi3UjXZUycYs6AgqsH+A1nCS8RsSg59F
        J8LpMFnBZPF/HxRniZkU5rMqpA==
X-Google-Smtp-Source: AGHT+IFJQoCLMn0/+EG0UAyhhYFeNH2UqEE7v3tOiGVYIzInkmctOY2h8GrRjKwEPU3d3Rn4PBKQNQ==
X-Received: by 2002:a17:906:28e:b0:a1a:60a1:7465 with SMTP id 14-20020a170906028e00b00a1a60a17465mr851180ejf.5.1701625588395;
        Sun, 03 Dec 2023 09:46:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id my18-20020a1709065a5200b009f28db2b702sm4324140ejc.209.2023.12.03.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 09:46:27 -0800 (PST)
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
        Jonathan Corbet <corbet@lwn.net>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4] docs: dt-bindings: add DTS Coding Style document
Date:   Sun,  3 Dec 2023 18:46:22 +0100
Message-Id: <20231203174622.18402-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Rafał Miłecki <zajec5@gmail.com>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Konrad Dybcio <konradybcio@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Merging idea: Rob/DT bindings

Changes in v4
=============
1. Drop label at the top (Jon)
2. Grammar fixes (Laurent, Dragan)
3. "Unless a bus defines differently, unit addresses shall ..." (Rob)
4. Use hex in example of dma-controller (Andrew)
5. Example: soc@ -> soc@0
6. Reverse points 2 and 3 in "Indentation" (Andrew)
7. Use full path to coding style doc (Conor)

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
 .../devicetree/bindings/dts-coding-style.rst  | 196 ++++++++++++++++++
 Documentation/devicetree/bindings/index.rst   |   1 +
 2 files changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dts-coding-style.rst

diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
new file mode 100644
index 000000000000..ffd7617f95fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/dts-coding-style.rst
@@ -0,0 +1,196 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Devicetree Sources (DTS) Coding Style
+=====================================
+
+When writing Devicetree Sources (DTS) please observe below guidelines.  They
+should be considered complementary to any rules expressed already in
+the Devicetree Specification and the dtc compiler (including W=1 and W=2
+builds).
+
+Individual architectures and subarchitectures can define additional rules,
+making the coding style stricter.
+
+Naming and Valid Characters
+---------------------------
+
+The Devicetree Specification allows a broad range of characters in node
+and property names, but this coding style narrows the range down to achieve
+better code readability.
+
+1. Node and property names can use only the following characters:
+
+   * Lowercase characters: [a-z]
+   * Digits: [0-9]
+   * Dash: -
+
+2. Labels can use only the following characters:
+
+   * Lowercase characters: [a-z]
+   * Digits: [0-9]
+   * Underscore: _
+
+3. Unless a bus defines differently, unit addresses shall use lowercase
+   hexadecimal digits, without leading zeros (padding).
+
+4. Hex values in properties, e.g. "reg", shall use lowercase hex.  The address
+   part can be padded with leading zeros.
+
+Example::
+
+	gpi_dma2: dma-controller@a00000 {
+		compatible = "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
+		reg = <0x0 0x00a00000 0x0 0x60000>;
+	}
+
+Order of Nodes
+--------------
+
+1. Nodes on any bus, thus using unit addresses for children, shall be
+   ordered by unit address in ascending order.
+   Alternatively for some subarchitectures, nodes of the same type can be
+   grouped together, e.g. all I2C controllers one after another even if this
+   breaks unit address ordering.
+
+2. Nodes without unit addresses shall be ordered alpha-numerically by the node
+   name.  For a few node types, they can be ordered by the main property, e.g.
+   pin configuration states ordered by value of "pins" property.
+
+3. When extending nodes in the board DTS via &label, the entries shall be
+   ordered either alpha-numerically or by keeping the order from DTSI, where
+   the choice depends on the subarchitecture.
+
+The above-described ordering rules are easy to enforce during review, reduce
+chances of conflicts for simultaneous additions of new nodes to a file and help
+in navigating through the DTS source.
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
+		soc@0 {
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
+The following order of properties in device nodes is preferred:
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
+The above-described ordering follows this approach:
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
+1. Use indentation according to Documentation/process/coding-style.rst.
+2. Each entry in arrays with multiple cells, e.g. "reg" with two IO addresses,
+   shall be enclosed in <>.
+3. For arrays spanning across lines, it is preferred to align the continued
+   entries with opening < from the first line.
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
+The DTSI and DTS files shall be organized in a way representing the common,
+reusable parts of hardware.  Typically, this means organizing DTSI and DTS files
+into several files:
+
+1. DTSI with contents of the entire SoC, without nodes for hardware not present
+   on the SoC.
+2. If applicable: DTSI with common or re-usable parts of the hardware, e.g.
+   entire System-on-Module.
+3. DTS representing the board.
+
+Hardware components that are present on the board shall be placed in the
+board DTS, not in the SoC or SoM DTSI.  A partial exception is a common
+external reference SoC input clock, which could be coded as a fixed-clock in
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

