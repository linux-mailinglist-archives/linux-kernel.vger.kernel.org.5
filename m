Return-Path: <linux-kernel+bounces-156140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BEA8AFE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584011F2422F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76E1C69D;
	Wed, 24 Apr 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="fPrKkDrP"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85127219EB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925830; cv=none; b=Tl/1lTmjOD3NcJle0c3+vtJke/wWnf5A0PIgvWV2AWUh4bFiF3ROE3QpWfE7sGtwa9w+piJbPCEP2Yme1ZIXF3vwMF+gemz/D2VwoHZ4ukt6/+2kSYybg4cDtIn/68se8r6Y2fYNJde6+RTiDjbdKb1nxfnd6OUnHyws80oQp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925830; c=relaxed/simple;
	bh=a3gQhq82Wv/k4opj0yoUXFy/vOnluMpPoDHIgsWYTDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+NEgmP/e6tCwy1+RINU2rMS1evieH8TLfFMGevGymM2Cm7Nfr7dKPvht/+78LfCZy9vysxpJlgoWN56rQNXzZtr4PSRqwCiZuevNxhMD0k0bsn6LC8acgQF4OfFGoVVZRQShXqZ9p5K+DFBG0KwvHvB0BUQc8TaX153sQ/DBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=fPrKkDrP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb797e10ceso3730535a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713925827; x=1714530627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y0Y78SKftlvZ81BZWTG+VEX7FhHPjRnc4JVM6RX264=;
        b=fPrKkDrPLIuhh62vpcQ7jLoJlntURKDUG7VoEYKydMNTAx3fHrSuYqCx2lMo/tLqZB
         pWvzwaN5xvblFT/9yrijMWL0TmJR+0Zrfd7UMFLbcH+/eWKAtyNmoohgNCRwe9q1iJMr
         7TEsbuIVWLSSA7LHDY/WDCV1wkW4NoC3ku8SQChE0HIf02yXtdhcNCt+tiNpFaPsUzGg
         /r70UTwohGCOYmjnNMrVRqcn39Bpf5q1BPFniG8tVZmBzNfFaSsMBpML65c5xLekxiiA
         OhkczyCV2046s0fRoAd6x/6P/ZsL8JnyEaW5aaoCyj0njj+RKgPgXkMFV0zJUU0rh55w
         eyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925827; x=1714530627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y0Y78SKftlvZ81BZWTG+VEX7FhHPjRnc4JVM6RX264=;
        b=w0/tzNp7Di4cyxT3EJB1CWweMo8L+EKeOMCJ2gUGy5RHJwOp4DimHACfRfWyESq5Zc
         4Me9Xj1U9fk4PcCSMt8vLYWRjnac49dxcQ+t/WWZiaXuudrAIL28lJy2sI2SrT/K9+8i
         lqNFYzXpVvV5WVl92uEBl2ZHy9uJyw+5V/LXli41TfjOIiO+Uv/sLk/xhoX1VWLl+Zvx
         wXds+lMQZUkouHhX294w6YbanjVmDzJW0+GTDPokrakNA712H9Ph6KBsbQKbEQD66lYb
         TuRlmsPSEd8BdcPxRJtMVc2S0s/VC2PzM0/Ep6I/3YB+3KJBCSXNpupETJ8xC5VJu1QB
         2G3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyC5BidLFhZjhnKNzwM9mPeRBTckMln8MJDC1V2tvPyZV6XWjgz8GFL8mhCdFaBtW+j2kbjsNq0xGYP+W8wXYL1WRqru5oOfqfaQ2p
X-Gm-Message-State: AOJu0YxqpTY7wd8d3BUO8hMkZvkpQJzMDpHe908/S7Dsodlh7SKh9h70
	vRVGRR9KcCw1KHNut2pWUR7aeCCuof1qIBMxk7UmJmCu7vCPiWtCx7z+ZEfEeuM=
X-Google-Smtp-Source: AGHT+IGg9VxqESAKlIPBanmqlR+nhU6ph+tAa56NSnZCOgjk8WWbzy1zApm/9MtPqDGtBJi4UChKVQ==
X-Received: by 2002:a9d:6755:0:b0:6eb:be38:3848 with SMTP id w21-20020a9d6755000000b006ebbe383848mr1561310otm.29.1713925827623;
        Tue, 23 Apr 2024 19:30:27 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm10179385pgd.56.2024.04.23.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:30:26 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v3 1/7] dt-bindings: display: panel: Add himax hx83102 panel bindings
Date: Wed, 24 Apr 2024 10:30:04 +0800
Message-Id: <20240424023010.2099949-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In V1, discussed with Doug and Linus [1], we need break out as separate
driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j02"
and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
controller, they have some common CMDS. So add new documentation for
this panels.

[1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=zBQJUC4CB2wj4s1h6n6aSAZQvdMV95r3zRUw@mail.gmail.com

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V3:

- Update commit message.

V2: https://lore.kernel.org/all/20240422090310.3311429-2-yangcong5@huaqin.corp-partner.google.com

---
 .../display/panel/boe,tv101wum-nl6.yaml       |  2 -
 .../bindings/display/panel/himax,hx83102.yaml | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 906ef62709b8..53fb35f5c9de 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -32,8 +32,6 @@ properties:
       - innolux,hj110iz-01a
         # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
       - starry,2081101qfh032011-53g
-        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
-      - starry,himax83102-j02
         # STARRY ili9882t 10.51" WUXGA TFT LCD panel
       - starry,ili9882t
 
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
new file mode 100644
index 000000000000..2e0cd6998ba8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/himax,hx83102.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX83102 MIPI-DSI LCD panel controller
+
+maintainers:
+  - Cong Yang <yangcong5@huaqin.corp-partner.google.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
+      - starry,himax83102-j02
+
+  reg:
+    description: the virtual channel number of a DSI peripheral
+
+  enable-gpios:
+    description: a GPIO spec for the enable pin
+
+  pp1800-supply:
+    description: core voltage supply
+
+  avdd-supply:
+    description: phandle of the regulator that provides positive voltage
+
+  avee-supply:
+    description: phandle of the regulator that provides negative voltage
+
+  backlight:
+    description: phandle of the backlight device attached to the panel
+
+  port: true
+  rotation: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - pp1800-supply
+  - avdd-supply
+  - avee-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "starry,himax83102-j02";
+            reg = <0>;
+            enable-gpios = <&pio 45 0>;
+            avdd-supply = <&ppvarn_lcd>;
+            avee-supply = <&ppvarp_lcd>;
+            pp1800-supply = <&pp1800_lcd>;
+            backlight = <&backlight_lcd0>;
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.25.1


