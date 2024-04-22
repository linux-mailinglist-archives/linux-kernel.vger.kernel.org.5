Return-Path: <linux-kernel+bounces-153329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0A8ACCB0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5751C20C10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4933147C6C;
	Mon, 22 Apr 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYUtjvIO"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03C4F213;
	Mon, 22 Apr 2024 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788498; cv=none; b=D62nv4xaWJhBRiDFzLQcstpJgqyOqyAIBD/1wDhuhSjoPEdeSZEO1LU+6sHfghsY2KeyWmrna5VrJSEGWefmxkaH35oKrSkspZsCMGlATx9c/1RJmu4o3zH9uSSorL08s+QwtmlOgquBC32ZhClY2L1Rq1PPH1q7S+I3Yf7EcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788498; c=relaxed/simple;
	bh=6e4WeTSzc6V1+UM7MstEVWVILvZqnGppW/NAEheEo6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXxB8KYb5LXfN4Px3rVBkJqCJAt/nyvosu6DgVFLsAcgwXbibz8MIZDogmGPLfMYRs01+mpmCmprgLaRJrjDfU49WmM2LQZtu7pXsdvgjoKOTo6ro6TyzHo9m0xUyp/DDHul7OUWNwXn3wHtU7NZ32wW3o6i60XbR6BgFGben14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYUtjvIO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso3460357b3a.2;
        Mon, 22 Apr 2024 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713788496; x=1714393296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHFimgB5kEy6t7d1qdH8Mcr+f0+kBTAsDg+MeGo/6Ls=;
        b=FYUtjvIOpTIRVAn8VuVbU+tKP8PMGuox0KVnAmaWDOyfx4DtLg9/O+Q/KDdsBc+BG4
         bu1BawRO34yzRck3pQAgEsS5r7TcFOUN6mnJd7VORCIac+8SOKgZyMzaLVgyn0U7mQEt
         BMvrqrtG5HzM0KqwUXW1APuFI00wgCEe4L2OMxyJqN34qWfgXlvXhosKEIafmqfA8x9K
         +2AFFZ6bUucTlp0bdgUCT5VxUk7KDqsUaRmXizmX8sZ2vWuU1qqQWVXG5YTmbYrEb/8l
         eSxPYqdlWRRGgtCDO29AZMWI+E/cUGNOkw9XN92L2Acma0vtKVRav7hSfDpTQ6J8M1jh
         +yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713788496; x=1714393296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHFimgB5kEy6t7d1qdH8Mcr+f0+kBTAsDg+MeGo/6Ls=;
        b=g4uHLNagcK9S4gIcbLxRP8Z6Xz0laARC6h6KdmFd38NlxUOzf8upY3En41JjWDqr8C
         VqzZxD1qrzFwwH1uUNdUtjvxRjksFLUm6pifxwnojv93VcjnTWK/IWlKcyyQ791MB68I
         mKrrwcExGRUkjPwcDqma7MoRUiKYbjmn2R3ytmoE41jjth4292QHyF9i5qaacCspTQ+Z
         j8PjkvEXwVV0QwSBmWjIzrlkyRjUqH5WuLx23Tezr1uAZ5AVwDDztlsnojJg0vw1McnU
         srhd1NBWmCkmcT2kiLVUYcDWiO4Cq91qHDnrXq+jOXH26CNK+YrUpSh2J25CYpI9Y8+Z
         Q7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOvckObA4Qbqin3Bq8XWDq6unY/mmz7I+4t5yp+DFBl1sxkr/pn3SwDsxmx75zStaRPi7o7XBqLNcx0KhoW5V1JKqJBpBvw0lsnoSBH4ShbuydIVyKOfEFlT3omusEEVxgAibywe5IKa83h6J/9qaiAIlfJaYw9LewHBnGO5TRBsDfug==
X-Gm-Message-State: AOJu0Yx72Wafp9i1tM+/flMI53rYdbDVxfLlpE2lGEJ3jV2joWm63zBT
	0b3UosBg7VwBKygswe1zxgyCmFCWrutbwhTMWxzDsmj8rB+QINMMMEd5YFtWLKI=
X-Google-Smtp-Source: AGHT+IFf2lmAmdU4GdqyVIyO2RxXOcMTop445nSPeQud3cT1HcSq6iZhTqDJVb2YGz5pLihFViOAgw==
X-Received: by 2002:a05:6a20:8409:b0:1a9:6c42:77f5 with SMTP id c9-20020a056a20840900b001a96c4277f5mr15819360pzd.59.1713788495926;
        Mon, 22 Apr 2024 05:21:35 -0700 (PDT)
Received: from localhost (ec2-3-111-32-5.ap-south-1.compute.amazonaws.com. [3.111.32.5])
        by smtp.gmail.com with UTF8SMTPSA id ey3-20020a056a0038c300b006ead618c010sm7664034pfb.192.2024.04.22.05.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 05:21:35 -0700 (PDT)
From: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: usb: uhci: convert to dt schema
Date: Mon, 22 Apr 2024 17:51:23 +0530
Message-ID: <20240422122125.455781-1-sheharyaar48@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert USB UHCI bindings to DT schema. Documenting aspeed compatibles
and missing properties. Adding aspeed/generic-uhci example and fix previous
incorrect example.

Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
---
Changes 
v1->v2:
- add aspeed compatible and deprecated platform-uhci compatible
v2->v3:
- fix property declaration and if-then-else block
- add generic-uhci example and fix prev incorrect example

v2 patch : https://lore.kernel.org/all/20240422093706.324115-1-sheharyaar48@gmail.com
v1 patch : https://lore.kernel.org/all/20240420142108.76984-1-sheharyaar48@gmail.com
---
 .../devicetree/bindings/usb/usb-uhci.txt      | 18 -----
 .../devicetree/bindings/usb/usb-uhci.yaml     | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usb-uhci.yaml

diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.txt b/Documentation/devicetree/bindings/usb/usb-uhci.txt
deleted file mode 100644
index d1702eb2c8bd..000000000000
--- a/Documentation/devicetree/bindings/usb/usb-uhci.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Generic Platform UHCI Controller
------------------------------------------------------
-
-Required properties:
-- compatible : "generic-uhci" (deprecated: "platform-uhci")
-- reg : Should contain 1 register ranges(address and length)
-- interrupts : UHCI controller interrupt
-
-additionally the properties from usb-hcd.yaml (in the current directory) are
-supported.
-
-Example:
-
-	uhci@d8007b00 {
-		compatible = "generic-uhci";
-		reg = <0xd8007b00 0x200>;
-		interrupts = <43>;
-	};
diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.yaml b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
new file mode 100644
index 000000000000..fc4f0174640c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/usb-uhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Platform UHCI Controller
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: generic-uhci
+      - const: platform-uhci
+        deprecated: true
+      - items:
+          - enum:
+              - aspeed,ast2400-uhci
+              - aspeed,ast2500-uhci
+              - aspeed,ast2600-uhci
+          - const: generic-uhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#ports':
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: generic-uhci
+    then:
+      $ref: usb-hcd.yaml
+      required:
+        - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    uhci@d8007b00 {
+        compatible = "platform-uhci";
+        reg = <0xd8007b00 0x200>;
+        interrupts = <43>;
+    };
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+
+    usb@1e6b0000 {
+        compatible = "aspeed,ast2500-uhci", "generic-uhci";
+        reg = <0x1e6b0000 0x100>;
+        interrupts = <14>;
+        #ports = <2>;
+        clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
+    };
+...
-- 
2.44.0


