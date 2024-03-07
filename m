Return-Path: <linux-kernel+bounces-95457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2B6874DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE82F1C22088
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97512C54C;
	Thu,  7 Mar 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayC17i84"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0A12B146;
	Thu,  7 Mar 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811786; cv=none; b=sut5yD4macGmAx9oREP1/5qv7Sl37OdAeDo7zQXNASxVw4nDOQlK466hik8VT7/yZdd0L538eRA2Pxzv2pd9nFfCVQymdRU6Wse6gckQEIC2vQ/Po1W0i8J1L5kcgCjnqlONHoQnuYrRn/TBNjMMl6PAURZOQVTez0tEH3xYhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811786; c=relaxed/simple;
	bh=KvUwatnwe0tIeBh+4voAgQUNpxi9oR/OH7yerHe8wtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SA532DAPFE7vSITKNeoV+sMJaRtORFetTEaFommRI93n/vwF1oDojjNR3BGUbj0IkC0wD1tqSqaMeBHfnDvLQSXwVG8TQU7pcw44pIgXP2XCjSPZRKKbhrRx5DWZ2muELzXSGmAHJqbl7ZkDKaDBKxxKezAzmECZspYZgg7woWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayC17i84; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e1878e357so466439f8f.3;
        Thu, 07 Mar 2024 03:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709811783; x=1710416583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OveC7bIL2BTuZpDk8Lj9zkJQ+QM59MACb3HeWYWAygw=;
        b=ayC17i84RX/Dbt8GO6xKj0oVPOXrjYvEs/G2EZmZi0yZbRgYslPYOxuIoVjTLoYNNK
         hazijlv3adxhW6qur5FBtRE1Fdu1ypL2aRpwLyDf3Nv55Uz3I1R6fvNZq13vDMFxE3Ki
         EdNFiAxcLyhhGWaX5aNBT2+LqCqQDgr+0pXenRyMov8IPSdcyYsIT86uujnJio8Wf2NF
         sm/FAvlVSoi7Ge9SATfWrV3wkOhRFoopr3CEZnhCDPK0DSOgVaVB7i5jmvspd4J2DfNQ
         100ZDPMI9b+5oTiWBOyNERLA90j5bSwcKAus08d73v8lHbrkfTzKOv8/+CfdtFH/d6kc
         hsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811783; x=1710416583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OveC7bIL2BTuZpDk8Lj9zkJQ+QM59MACb3HeWYWAygw=;
        b=IHQOLsKJ9cmmLvWJgZEWJ50E8sDXyCX3S6fjD1dltDTPRjVl5P8zN+uZutTPM2iudR
         DbFqNkufIrEZwMBirCAQCN8Iu/aVZbThxAiLabOXEDppvtylKwuOMjIKbp8vNkXwDBBE
         B6uYXbYc+0HTyZP73eWBbk7Q7mtdDqTd93tVgCojLWnQBGze7YfeUd8gH5VxeHyTt6KM
         Qmxyl5Ko5IrimS3ZLrvpnHa981Pg41fCmKh2yjmS42n9A2EsZ3qtubWpzkYepbvR5TMX
         l3orC4w847cLuNRN22K6Wmpge9ov7j2P71qintgIgt/7DCCpO6ds6R4o/Gv41by9gHxN
         UzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyTL8Z2ADi57VGQC0Fm+FWb1N6bkSG3unFisXj60vKnqazU8FxfJKHu51+LWlTASyviQMtwRbittsouGlI/muwPAlIAHNlH3fCI9gIx1BseP3p5h6l5ut+cHupXiK56bliw2zdyag18fDYZxU29C11F5RBT3sNDaKbQhH1RmbJtWXQYSdRXOkczSdz
X-Gm-Message-State: AOJu0YzfnvfMmdvn41vT6Oh0ofl+6oRw+fH+74rgIL6D8kIyotP2x65G
	jrSz5k3nhS9+Y2Z9+DVflsqbd0YGBHb1CmCOJLcAjvIVDaPJA61s
X-Google-Smtp-Source: AGHT+IEQqw2CF+xQhon9mUhvmCzJ1zzTdt6CwX7w/RKMnDEU/iGNK2A8v91+iHtJCLHYysH/m445Jw==
X-Received: by 2002:adf:e711:0:b0:33e:69a5:68f9 with SMTP id c17-20020adfe711000000b0033e69a568f9mr593952wrm.17.1709811782970;
        Thu, 07 Mar 2024 03:43:02 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:fef2:3c1d:a816:65f7])
        by smtp.gmail.com with ESMTPSA id h5-20020adf9cc5000000b0033dd9b050f9sm19858722wre.14.2024.03.07.03.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:43:02 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Thu,  7 Mar 2024 11:42:17 +0000
Message-Id: <20240307114217.34784-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This commit adds support to validate the 'interrupts' and 'interrupt-names'
properties for every supported SoC. This ensures proper handling and
configuration of interrupt-related properties across supported platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Defined the properties in top-level block instead of moving into
  if/else block for each SoC.
* Used Gen specific callback strings instead of each SoC variant
---
 .../bindings/serial/renesas,scif.yaml         | 90 +++++++++++++------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index af72c3420453..6ba6b6d52208 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -83,36 +83,24 @@ properties:
     maxItems: 1
 
   interrupts:
-    oneOf:
-      - items:
-          - description: A combined interrupt
-      - items:
-          - description: Error interrupt
-          - description: Receive buffer full interrupt
-          - description: Transmit buffer empty interrupt
-          - description: Break interrupt
-      - items:
-          - description: Error interrupt
-          - description: Receive buffer full interrupt
-          - description: Transmit buffer empty interrupt
-          - description: Break interrupt
-          - description: Data Ready interrupt
-          - description: Transmit End interrupt
+    minItems: 1
+    items:
+      - description: Error interrupt or single combined interrupt
+      - description: Receive buffer full interrupt
+      - description: Transmit buffer empty interrupt
+      - description: Break interrupt
+      - description: Data Ready interrupt
+      - description: Transmit End interrupt
 
   interrupt-names:
-    oneOf:
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-          - const: dri
-          - const: tei
+    minItems: 4
+    items:
+      - const: eri
+      - const: rxi
+      - const: txi
+      - const: bri
+      - const: dri
+      - const: tei
 
   clocks:
     minItems: 1
@@ -173,6 +161,52 @@ allOf:
       required:
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen1-scif
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
+        interrupt-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s72100
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+
+        interrupt-names:
+          maxItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s9210
+              - renesas,scif-r9a07g044
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


