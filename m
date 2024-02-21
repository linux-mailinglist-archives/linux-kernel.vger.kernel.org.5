Return-Path: <linux-kernel+bounces-75071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB3A85E28E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CBE1C247FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5069F8528B;
	Wed, 21 Feb 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Riuf3B+4"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FA84FDF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531372; cv=none; b=j4xTzW2ioE6VwX5Rsb3T/SaBAiSMz0XMaNduLwWT7iFtl56rWoXq7/YTGeFiP1D+6LT4Szpu35E9yJEWDEonfOqi394NAQATwZpsKnq+n/DAj5nKY57UZjRigpBhMt0H3jdyX0Jk62LDJAmZfymsxlhB+8arl3CSQGIojB6w4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531372; c=relaxed/simple;
	bh=fWYaejhZnKdcmqr+oOjmexoKsVVg8E2AtDrI2rkeAoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U7DA8yLArLH46jOMXYXNN38fGXGeV3sQdll+hMiwfZeSRFFEJ/Aqszy8YeoEajvYZBi/rzp0A0DdKDc+SCHMfOI/wFM2xB9wdM+dBhLmxpn3Q0S17RGKqBdQWhUmFLdbZzz8cjVkAVttCD8Mono/jwcQGE1WXMiT6UqWdHX6l6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Riuf3B+4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-410422e8cd1so28523405e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708531368; x=1709136168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QG+lYn+WRJAXK2sPNs+WXBXseOQ/XIK++bgwEo6870E=;
        b=Riuf3B+4taQ76UllgzJGzlkPOHcvIxsN4QV2bwEPUV08vDXdY5Zs9Ffrl4Co3iaVFe
         Pd4gfRyiuIQBznDlOuKn8ADCMMZkMUaaMxAizFqm1Zk+u5/eIWYr4NMUx1c28jDB+dwE
         ZDOUcTPU32FuL9fzzBKVLCZTYf7IWTTqF8PZwfsMg/m1xqa8kHFJNifvmrEINEirLRVe
         rxplWp7W3pGtROjGYMfopFwPFW6fRT+4kochBcDfO3NXhSIlZ6HQJB/bAIBeAUx5z9UH
         sbQe9I4K7aV0JevxYvs7F6ie1KKiwKhA7YOGIXIJRbhb+EIJdAoAuKiVTC7i0U63Du3O
         alaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531368; x=1709136168;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QG+lYn+WRJAXK2sPNs+WXBXseOQ/XIK++bgwEo6870E=;
        b=gsMD9V/8zrwlxS2RET/19FrwfZSeVLhIlXTLKKl9JZdRjjTxw/1EuIA3cR1zCTVMwN
         pTyBs8AYJPodH8vkzAQgGVZiBunL23/S0/LdG/Hn4rBPig+WytYghvytxFMvbjFLUjc5
         lXgE0mtcWdIrGtzRaTDmXKsxlLJFjWN8tCf9g3QiyO8s8UlUaJwwuDWTQIU8HbM7EKCv
         uKlONNmLT8FbgznhsoevCP2ZT5VmY+Rkrn48vPBSz+CKx0DI0gKUi/8F/9pxa+HH5Z56
         nWOnf5xu+WfQirsCZ0Ec8J49GUQbMhZDlJA2YxhPJBfLodVdIPXV5kSIOkxDrowXMhEq
         T7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVT73ZjGWandF1MlZKnBhy5KH9WSDNwzRq++nS7OXwOElbC2ZP7KqtePFqVs89c1JlvQW2MpWEojqyOAwkbXhfr7FGkJ3x/fuAp/l4Z
X-Gm-Message-State: AOJu0YxQPNgbXmA3te8m9noWi5mh8cv9tpM8ibuhnPB1ml00b4M2wfK2
	OTRnjAo4/W/iYYL/i5luabjbep612JNV6rChQYQvlfFHKHPJ8GHUrjPfndJTZybikpJ4A988nbA
	F5Z86c/WavA==
X-Google-Smtp-Source: AGHT+IGzSlaHNh9nuHPSE1pDBQcoTa92tjLdirc6li9igPKl4C8OqbVJ3yIPAunVVJRd0ILLSPNzPIMzj7eA3Q==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:a383:b0:412:1500:beb4 with SMTP
 id hn3-20020a05600ca38300b004121500beb4mr159646wmb.7.1708531367605; Wed, 21
 Feb 2024 08:02:47 -0800 (PST)
Date: Wed, 21 Feb 2024 16:02:14 +0000
In-Reply-To: <20240221160215.484151-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221160215.484151-9-panikiel@google.com>
Subject: [PATCH v2 8/9] media: dt-bindings: Add Intel Displayport RX IP
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
capture and Multi-Stream Transport. The user guide can be found here:

https://www.intel.com/programmable/technical-pdfs/683273.pdf

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 .../devicetree/bindings/media/intel,dprx.yaml | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.yaml

diff --git a/Documentation/devicetree/bindings/media/intel,dprx.yaml b/Docu=
mentation/devicetree/bindings/media/intel,dprx.yaml
new file mode 100644
index 000000000000..31025f2d5dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/intel,dprx.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/intel,dprx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel DisplayPort RX IP
+
+maintainers:
+  - Pawe=C5=82 Anikiel <panikiel@google.com>
+
+description: |
+  The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
+  Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
+  capture and Multi-Stream Transport.
+
+  The IP features a large number of configuration parameters, found at:
+  https://www.intel.com/content/www/us/en/docs/programmable/683273/23-3-20=
-0-1/sink-parameters.html
+
+  The following parameters have to be enabled:
+    - Support DisplayPort sink
+    - Enable GPU control
+  The following parameters' values have to be set in the devicetree:
+    - RX maximum link rate
+    - Maximum lane count
+    - Support MST
+    - Max stream count (only if Support MST is enabled)
+
+properties:
+  compatible:
+    const: intel,dprx-20.0.1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  intel,max-link-rate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Max link rate configuration parameter
+
+  intel,max-lane-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Max lane count configuration parameter
+
+  intel,multi-stream-support:
+    type: boolean
+    description: Multi-Stream Transport support configuration parameter
+
+  intel,max-stream-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Max stream count configuration parameter
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: SST main link
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 0 or SST main link
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 1
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 2
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: MST virtual channel 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      required:
+        - intel,multi-stream-support
+    then:
+      required:
+        - intel,max-stream-count
+        - ports
+    else:
+      required:
+        - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dp-receiver@c0062000 {
+        compatible =3D "intel,dprx-20.0.1";
+        reg =3D <0xc0062000 0x800>;
+        interrupt-parent =3D <&dprx_mst_irq>;
+        interrupts =3D <0 IRQ_TYPE_EDGE_RISING>;
+        intel,max-link-rate =3D <0x1e>;
+        intel,max-lane-count =3D <4>;
+        intel,multi-stream-support;
+        intel,max-stream-count =3D <4>;
+
+        ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            port@0 {
+                reg =3D <0>;
+                dprx_mst_0: endpoint {
+                    remote-endpoint =3D <&fb_mst0_0>;
+                };
+            };
+
+            port@1 {
+                reg =3D <1>;
+                dprx_mst_1: endpoint {
+                    remote-endpoint =3D <&fb_mst1_0>;
+                };
+            };
+
+            port@2 {
+                reg =3D <2>;
+                dprx_mst_2: endpoint {
+                    remote-endpoint =3D <&fb_mst2_0>;
+                };
+            };
+
+            port@3 {
+                reg =3D <3>;
+                dprx_mst_3: endpoint {
+                    remote-endpoint =3D <&fb_mst3_0>;
+                };
+            };
+        };
+    };
+
+  - |
+    dp-receiver@c0064000 {
+        compatible =3D "intel,dprx-20.0.1";
+        reg =3D <0xc0064000 0x800>;
+        interrupt-parent =3D <&dprx_sst_irq>;
+        interrupts =3D <0 IRQ_TYPE_EDGE_RISING>;
+        intel,max-link-rate =3D <0x1e>;
+        intel,max-lane-count =3D <4>;
+
+        port {
+            dprx_sst_0: endpoint {
+                remote-endpoint =3D <&fb_sst_0>;
+            };
+        };
+    };
--=20
2.44.0.rc0.258.g7320e95886-goog


