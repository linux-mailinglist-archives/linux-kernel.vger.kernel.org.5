Return-Path: <linux-kernel+bounces-150753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE18AA421
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC53B24D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB5194C92;
	Thu, 18 Apr 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edvqm8zZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C953194C7E;
	Thu, 18 Apr 2024 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472702; cv=none; b=hddVEUddi3KGfj2PIL7RQKI7fqv8yxgDbUDWqL65XS2JZvczdAojXti9zchu36hyfhrtvFZ8O0GfCRmPoXzVvqhudAL+QW+6oRlQFKM8OEl2l9oc/ea5tA7GDQtvZ4iT1O+VUtbJZx6RJEBTXZYp1ZmKhbmOAZa2KlZPvDbvu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472702; c=relaxed/simple;
	bh=187YQzagItw83f6vADx4GNKdh6X9UWHJuAmasyW0jXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTpgh0h3vu4/5lt6MdmBCCAWgUA/Co5JvzEfKT9xdQqlKdheWx4bEsv4f0NT+SaWP71f6tDlOy66Cay7g/fbtNbTQGz24qWsgcvBZ2M9I9Urqo9Sw/FKHCdfUvpMzcYkgKe9dtMR3853MQdbowza/GlLsaH4UomPSs+gBHtJ4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edvqm8zZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so1634043e87.2;
        Thu, 18 Apr 2024 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713472699; x=1714077499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef1j03PzQot24D7wGKXztI5BpkUJmrRiVGjdQcRoP/A=;
        b=edvqm8zZUY0wup7vzOVm2pppQvNrUf9NyaCYnetJXs4jdwvvRvZWs9WXYmhiHLtHdC
         QzYOLf6sRcA+pFzUCTkvr+q7IfhudXy46+gvz11VGcemwry798D3KqtvavGAkUJIZToX
         +XHvziG5Nu3ombIvsXzOlso4z449j1khQfb6EiTY4jwjB3kI7O7R2B5O296QBneY3++4
         Ngr0tvPmrH/2i8C159SspmpJGsBq6e0nqOiJ2ECfnajMEz7w9UGjez/prPtESiUfzVED
         ymx9h/4SkJBhy+1za11Nz7tyOCyfgcK+xuuGp/q4fHMdA11yLUHgVUWdxl8EdMwZY2ZS
         z/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472699; x=1714077499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef1j03PzQot24D7wGKXztI5BpkUJmrRiVGjdQcRoP/A=;
        b=T/xVV6g+2PPl4bDg35MAouZI2e3hxf6VouUhRRM388bnBh21Am/yoQFg0nb+vmKEjZ
         LMVMoXjs2NHY1bY8gG78TTdP8ERQZKLaLd6FR3AeFDAtgIKisjoffaSOE4zWJ9OA7nU8
         XhV5H/3kCdU/z9Gr+owstbI949DDrnOKDUMm7UanJ8mmIZNlJhWAhLDWTKCp1et4PGpm
         90HhXPqdPShrX/e0KS2CmbORbyZXFEYkD5WWUq7Hvk8T0UBA6C/ieR2zBXwluw5s0aca
         Ac+MK42D5OwTJw38R+opK8RfrDV/H1I27R1H6JKPTBaIUPqpEJ851VoBu8zAwp6y9oAn
         3JSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtU0wjRvA/ASeaPsgz+1zUAP2aZjihdwRr3hHjvmZnkb61PxNdpkzokTs0liH/kvqxem7M4+JfX4gRnHUdXxB6hJFjpFh9ny1D+KYpi1Jo/xYGbIyXbmli5PpaMFxs5bCDdx6kRzXUGw==
X-Gm-Message-State: AOJu0Yw5iEoyrlwUuGlUi7Gzik2kq9cyAbqWmSCmzxT3nEQ/eY6S7zTV
	Ga7wJN1CXzUmFBeXMq4gbY9Zb9uDgSEbOgJfqYeHmtsa7ACCemUL
X-Google-Smtp-Source: AGHT+IFuUfTaQYJNQUWQD53YUOXbHss6h+ljXIMevbVCxM7rU+ASD0Lp3fuRW4KDMzSE3XGe604KaQ==
X-Received: by 2002:ac2:430b:0:b0:51a:a400:785e with SMTP id l11-20020ac2430b000000b0051aa400785emr68649lfh.43.1713472698372;
        Thu, 18 Apr 2024 13:38:18 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906079500b00a473774b027sm1305649ejc.207.2024.04.18.13.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:38:17 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>
Cc: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: dsp: support imx8ulp dsp clocks
Date: Thu, 18 Apr 2024 23:37:18 +0300
Message-Id: <20240418203720.8492-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

i.MX8ULP DSP node needs a MU clock, but doesn't need
a debug clock. Change "clocks" and "clock-names" properties
to allow for this case.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 51 ++++++++++++++-----
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index 9af40da5688e..4a39d57b1cc6 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -30,22 +30,12 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: ipg clock
-      - description: ocram clock
-      - description: core clock
-      - description: debug interface clock
-      - description: message unit clock
     minItems: 3
+    maxItems: 5
 
   clock-names:
-    items:
-      - const: ipg
-      - const: ocram
-      - const: core
-      - const: debug
-      - const: mu
     minItems: 3
+    maxItems: 5
 
   power-domains:
     description:
@@ -93,6 +83,43 @@ required:
   - memory-region
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8ulp-hifi4
+    then:
+      properties:
+        clocks:
+          items:
+            - description: ipg clock
+            - description: ocram clock
+            - description: core clock
+            - description: message unit clock
+        clock-names:
+          items:
+            - const: ipg
+            - const: ocram
+            - const: core
+            - const: mu
+    else:
+      properties:
+        clocks:
+          items:
+            - description: ipg clock
+            - description: ocram clock
+            - description: core clock
+            - description: debug interface clock
+            - description: message unit clock
+          minItems: 3
+        clock-names:
+          items:
+            - const: ipg
+            - const: ocram
+            - const: core
+            - const: debug
+            - const: mu
+          minItems: 3
   - if:
       properties:
         compatible:
-- 
2.34.1


