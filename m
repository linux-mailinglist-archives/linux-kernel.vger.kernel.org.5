Return-Path: <linux-kernel+bounces-52504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A2849914
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274E91C21DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6E19474;
	Mon,  5 Feb 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DOc0akqc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD918E0C;
	Mon,  5 Feb 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133374; cv=none; b=t5cNTxGP1KJMxQYFVaQXDYufdxxysuvrE+p9lP4BSlnDjmaYQLvyOa6IDSqyYEoj5O0oH2CaYPjw1b/6RDU3i32I2echJjLSctWQhcLpCH23dcOHT3z+yDIk+tj8l28CAgNkz5RELCY4QMPpTN+j1to0IyU8m9jb99MrE2UA8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133374; c=relaxed/simple;
	bh=CeH0nsqPTxjlqfAeufqblOpvfevW9AGTt595RWNHldw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1t4JI9rNQlRmoJEM+8eYDOZeYaHdcZJN9t9lluKGx2E8RvZm+n5JyEwk8WhD28tju2W0LGdAd4+f6zmAWzJvgv9sNUEkKvgFsnbecdmRxWXakZnAzmhTlaHuzwluGtj5hXD89f7OvSG7D+hxQOEIRFqgl6eQOZ6pcpBD5cLoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DOc0akqc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Bgg4d011230;
	Mon, 5 Feb 2024 05:42:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707133362;
	bh=mT03cZEWpF6NnLTUDtaiwDlZi33fvqcO0Fz9E4JdzYs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DOc0akqceDZa+JWl7Gn6JgWWRuMncZmRrFMHxT99kE9T/gNyFk62pyeHzSuFqsXSz
	 9xqnRTuZW7+emkDODorSR3QHB2yu9KlzJmR5FFXiH7nH5+i62v5ltM3d8mU9cpk8Lj
	 ZDh1yCabblZLDgU5Srvk3lfJNmb11NUsIGwks92Q=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Bggfq065802
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 05:42:42 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 05:42:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 05:42:42 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415BgfjD095169;
	Mon, 5 Feb 2024 05:42:42 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <laurent.pinchart@ideasonboard.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>, <andrzej.p@collabora.com>,
        <nicolas@ndufresne.ca>
Subject: [PATCH v4 1/3] media: dt-bindings: Add Imagination E5010 JPEG Encoder
Date: Mon, 5 Feb 2024 17:12:37 +0530
Message-ID: <20240205114239.924697-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205114239.924697-1-devarsht@ti.com>
References: <20240205114239.924697-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is implemented
as stateful V4L2 M2M driver.

The device supports baseline encoding with two different quantization
tables and compression ratio as demanded.

Minimum resolution supported is 64x64 and Maximum resolution supported is
8192x8192.

[1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
Link: https://www.ti.com/lit/pdf/spruj16

Co-developed-by: David Huang <d-huang@ti.com>
Signed-off-by: David Huang <d-huang@ti.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: No change
V3:
- Add vendor specific compatible
- Update reg names
- Update clocks to 1
- Fix dts example with proper naming
V4:
 - Use ti-specific compatible ti,am62a-jpeg-enc as secondary one
 - Update commit message and title
 - Remove clock-names as only single clock

Link to previous commit:
https://lore.kernel.org/all/20230816152210.4080779-2-devarsht@ti.com/
---
 .../bindings/media/img,e5010-jpeg-enc.yaml    | 75 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml

diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
new file mode 100644
index 000000000000..085020cb9e61
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagination E5010 JPEG Encoder
+
+maintainers:
+  - Devarsh Thakkar <devarsht@ti.com>
+
+description: |
+  The E5010 is a JPEG encoder from Imagination Technologies implemented on
+  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
+  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
+  8Kx8K resolution.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: ti,am62a-jpeg-enc
+          - const: img,e5010-jpeg-enc
+      - const: img,e5010-jpeg-enc
+
+  reg:
+    items:
+      - description: The E5010 core register region
+      - description: The E5010 mmu register region
+
+  reg-names:
+    items:
+      - const: core
+      - const: mmu
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      jpeg-encoder@fd20000 {
+          compatible = "img,e5010-jpeg-enc";
+          reg = <0x00 0xfd20000 0x00 0x100>,
+                <0x00 0xfd20200 0x00 0x200>;
+          reg-names = "core", "mmu";
+          clocks = <&k3_clks 201 0>;
+          power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
+          interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8999497011a2..d0f8c46d3ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10461,6 +10461,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/auxdisplay/img,ascii-lcd.yaml
 F:	drivers/auxdisplay/img-ascii-lcd.c
 
+IMGTEC JPEG ENCODER DRIVER
+M:	Devarsh Thakkar <devarsht@ti.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
+
 IMGTEC IR DECODER DRIVER
 S:	Orphan
 F:	drivers/media/rc/img-ir/
-- 
2.34.1


