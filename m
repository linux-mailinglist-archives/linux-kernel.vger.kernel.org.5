Return-Path: <linux-kernel+bounces-86546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09086C6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438C3284600
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79229657B2;
	Thu, 29 Feb 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JPSuK2bg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E856351F;
	Thu, 29 Feb 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202387; cv=none; b=GClIHZrqmv9AzB+lAQtv91SCrkW4sSVkEya2hN9TJi2w+oPopSUpD1Ci5+fyu+sAKeifLz1zZUW5Ogn1wafrnSCOLbyIL3n78uxVE8DJtwlDvna1HzPAfFyn3ASmvk7tPf8HXDzA676T8FcH7ClB/ge4WZP1+/kQnauW+fAW/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202387; c=relaxed/simple;
	bh=gXhCYPfBYIHkJrxh0g/yMPKvsE9GaHghoyujBMl6GD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l931poLYrkEz6sFbYwsOGJGt056sL2gHSL+SwHNgWbO0eTb4AFuXzlBoKzEJZrmKRWCuPWVBTIzwN4cfToidLRpMnp7apsXckuZAh0jbOrVb296zXZqEF8xr2UKYDqdIA+myA38bAU1HwXu2fecNZqw4HgEnpRDW86d1G0ynfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JPSuK2bg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709202384;
	bh=gXhCYPfBYIHkJrxh0g/yMPKvsE9GaHghoyujBMl6GD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPSuK2bgSXQhmuusK+php+YwnbzxpjPKdEbzk0urTBGylKHhiF0LDJAqeIq+HykFb
	 ZaJ1rN/6Voi6igYsPrYOnhRiJXF913rqk7fB1wEhhFISYAAC4WGuUizAZUdhZnJYEq
	 EwMU9g7cy2b7osjHFC6v0oQVow6Ym2QqgQLzGKRjmx84JLeH/09eo9QsQAwOD8Hc4/
	 fL/ZRKleqO+tr3IrsCv528rjPOhcFU1odWjUjGrVt4WQ5s3bMXJRaLi4GslrS9gyoU
	 thHSqW63xGJjmzvG4Cmv/EHhobjUilw3nRW1YvpHc4E3pojyI2pkNqInodGeEYsATa
	 9QfhpAj18KlbA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 00BC23780029;
	Thu, 29 Feb 2024 10:26:23 +0000 (UTC)
Date: Thu, 29 Feb 2024 11:26:23 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hverkuil-cisco@xs4all.nl,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, benjamin.gaignard@collabora.com,
	laurent.pinchart@ideasonboard.com, praneeth@ti.com, nm@ti.com,
	vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com, b-brnich@ti.com,
	detheridge@ti.com, p-mantena@ti.com, vijayp@ti.com,
	andrzej.p@collabora.com, nicolas@ndufresne.ca, afd@ti.com,
	milkfafa@gmail.com
Subject: Re: [PATCH v6 1/3] media: dt-bindings: Add Imagination E5010 JPEG
 Encoder
Message-ID: <20240229102623.ihwhbba4qwzvxzzq@basti-XPS-13-9310>
References: <20240228141140.3530612-1-devarsht@ti.com>
 <20240228141140.3530612-2-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240228141140.3530612-2-devarsht@ti.com>

Hey Devarsh,

On 28.02.2024 19:41, Devarsh Thakkar wrote:
>Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is implemented
>as stateful V4L2 M2M driver.
>
>The device supports baseline encoding with two different quantization
>tables and compression ratio as demanded.
>
>Minimum resolution supported is 64x64 and Maximum resolution supported is
>8192x8192.
>
>[1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
>Link: https://www.ti.com/lit/pdf/spruj16
>
>Co-developed-by: David Huang <d-huang@ti.com>
>Signed-off-by: David Huang <d-huang@ti.com>
>Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>Reviewed-by: Rob Herring <robh@kernel.org>

hmmm when did Rob give his reviewed by on this patch? (As this is not a
DT binding I find that odd)
And where is the Reviewed by tag from Benjamin that he provided on V5?

Greetings,
Sebastian

>---
>V2: No change
>V3:
>- Add vendor specific compatible
>- Update reg names
>- Update clocks to 1
>- Fix dts example with proper naming
>V4:
> - Use ti-specific compatible ti,am62a-jpeg-enc as secondary one
> - Update commit message and title
> - Remove clock-names as only single clock
>V5:
> - Add Reviewed-By tag
>V6:
> - No change
>
> .../bindings/media/img,e5010-jpeg-enc.yaml    | 75 +++++++++++++++++++
> MAINTAINERS                                   |  5 ++
> 2 files changed, 80 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>
>diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>new file mode 100644
>index 000000000000..085020cb9e61
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>@@ -0,0 +1,75 @@
>+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>+%YAML 1.2
>+---
>+$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>+
>+title: Imagination E5010 JPEG Encoder
>+
>+maintainers:
>+  - Devarsh Thakkar <devarsht@ti.com>
>+
>+description: |
>+  The E5010 is a JPEG encoder from Imagination Technologies implemented on
>+  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
>+  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
>+  8Kx8K resolution.
>+
>+properties:
>+  compatible:
>+    oneOf:
>+      - items:
>+          - const: ti,am62a-jpeg-enc
>+          - const: img,e5010-jpeg-enc
>+      - const: img,e5010-jpeg-enc
>+
>+  reg:
>+    items:
>+      - description: The E5010 core register region
>+      - description: The E5010 mmu register region
>+
>+  reg-names:
>+    items:
>+      - const: core
>+      - const: mmu
>+
>+  power-domains:
>+    maxItems: 1
>+
>+  resets:
>+    maxItems: 1
>+
>+  clocks:
>+    maxItems: 1
>+
>+  interrupts:
>+    maxItems: 1
>+
>+required:
>+  - compatible
>+  - reg
>+  - reg-names
>+  - interrupts
>+  - clocks
>+
>+additionalProperties: false
>+
>+examples:
>+  - |
>+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>+    #include <dt-bindings/interrupt-controller/arm-gic.h>
>+    #include <dt-bindings/interrupt-controller/irq.h>
>+
>+    soc {
>+      #address-cells = <2>;
>+      #size-cells = <2>;
>+      jpeg-encoder@fd20000 {
>+          compatible = "img,e5010-jpeg-enc";
>+          reg = <0x00 0xfd20000 0x00 0x100>,
>+                <0x00 0xfd20200 0x00 0x200>;
>+          reg-names = "core", "mmu";
>+          clocks = <&k3_clks 201 0>;
>+          power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
>+          interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>+      };
>+    };
>diff --git a/MAINTAINERS b/MAINTAINERS
>index e1475ca38ff2..6b34ee8d92b5 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -10572,6 +10572,11 @@ S:	Maintained
> F:	Documentation/devicetree/bindings/auxdisplay/img,ascii-lcd.yaml
> F:	drivers/auxdisplay/img-ascii-lcd.c
>
>+IMGTEC JPEG ENCODER DRIVER
>+M:	Devarsh Thakkar <devarsht@ti.com>
>+S:	Supported
>+F:	Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>+
> IMGTEC IR DECODER DRIVER
> S:	Orphan
> F:	drivers/media/rc/img-ir/
>-- 
>2.39.1
>

