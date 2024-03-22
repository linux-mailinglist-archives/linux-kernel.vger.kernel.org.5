Return-Path: <linux-kernel+bounces-111643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2A886EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16622865D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47757305;
	Fri, 22 Mar 2024 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJXvxTBN"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B8524C4;
	Fri, 22 Mar 2024 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118709; cv=none; b=KLZwQHcK+LjDnGCGrUpHJAS0oPKcID2+QqQ7oHKKHtRB0j7g3UDi6gEpwTlBKUiTp37DwlHgskSl9fdRp0UCrTzaM1Qz1w4Gtw1JZ5Px0TUSTrsqghxTyiaIPwKBx3UcCq6L20q4hLvp7lVqwAGsv2ThpfqhhQkRrHW3qr805Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118709; c=relaxed/simple;
	bh=g+RQD8J0qS3SytRNhm+UmAr7htbucfmWhB9EAuKMhvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iwstUXvzK20peIU3G81FjWNv0v9rgdSxYj2qFIv9myL9khRLXuTRbInZaMnCasrRYBtGBLTV6XvrMNj72yWYT8PtuyVxrS2bHVPeZgr/bsJCvvYBXZiu6J4ORR9g2EXg8ZuXVKEcWvDZZAxTSnOMwAdfJZmypsGwQUihXB59BTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJXvxTBN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4147e283c4cso2675185e9.1;
        Fri, 22 Mar 2024 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118706; x=1711723506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLns8RKM6yyrwkzL4avpb8ODJ5XJkQjW3psT8hjt2To=;
        b=LJXvxTBNzdGJyVD7s4pwlW51b5jCFHVyiFSPzt89EpyWEi7rj/f4l0B3WZr2b0MdkU
         oaL8/xMgpH+z8u/mNaoBo5on91Z+8BWqOAv/vSlrViKICGeScuS3Pfc7w1Bbngmd/ixN
         4hfDpmXTutmex3eDv9OMAsW8WInUMlq5wULs5gPVAkAPzzPTKxp9/maakzIOraBkxk78
         yRV/V7DlYW0JdiiGVsGaEXczwPm+dLT7Ukpds8mcudWyvvpiMQzUEGrzhfu+xnWLuLqy
         oPXtrY+ALrIqnlBRaD9+vXy1AtKuSkr1jXY6Af6WVeGnevsal6igK5BHUCP8j/L9izlL
         zT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118706; x=1711723506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLns8RKM6yyrwkzL4avpb8ODJ5XJkQjW3psT8hjt2To=;
        b=WUvqsEpIQInbpMbHanjHYUXA5yIiDLz4Ih+UHYtW4IrwoCJoExPijyVU4Hp8NW9/Q+
         FgAm8+TxbgY3LXOrvAdO/iMqwgirA05sR4Y0XDd0MFqlrBGwH4FcoHfyErfiPYaMOAhC
         OrdV6NyGDix80UYzEe4NZY5GZ9bqBDEv2g5y5vpHKViztr+gxKiSdLsdPjzTWHg+UffB
         20RIh0ALDf+eSEZ8HV21EBMMGV91z5/PpI8uaLVm4dl6313wwHqZkVdlEq5w4tf+hEA8
         ey8pm/pXk+P0UWoXrgFWyPpcKh+e1U2UwlAdlPaYkDYGZ0S0ARdOvUYGes2UVEHTn3/3
         fMRg==
X-Forwarded-Encrypted: i=1; AJvYcCUv/K/5uV5mT488VweajDk3uxm2135DiSe08EHPTE6UtN+l/kwxIshBPh/DgjZKHwoMyvJh9SicsO0c6ckvb0Kis1hEXbfj1J9HMvBqqaJ8IT/msWCE0BhitooSGrEbJpCuHH687Dw8Yz1XN7pPr1Snv1PGh71pfrah0g4O1cv1NuMWGfvLgT1wjQbu
X-Gm-Message-State: AOJu0Yyxo5qlauWEsf/GNbwXJ2+5sGqsVUH93iCnocqFizdZs4BvJRe7
	P0gtRpWBRL82n13JNozr4RqemB6oUZZgRrRhsAJ0gm6zsd/pN0lv
X-Google-Smtp-Source: AGHT+IGTZPV12v//RdDHBXpoYNpVGnnaOFZ8Z5wA7EFDWWyCOePwwkT3bh6ponH+9B0fEMDg/9o9Hw==
X-Received: by 2002:a05:600c:5190:b0:414:7e94:b33b with SMTP id fa16-20020a05600c519000b004147e94b33bmr668860wmb.17.1711118706397;
        Fri, 22 Mar 2024 07:45:06 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:7b89:721b:d6b0:d7e8])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041466e03e55sm3911117wmo.0.2024.03.22.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:45:05 -0700 (PDT)
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
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 4/5] dt-bindings: serial: Add documentation for Renesas RZ/V2H(P) (R9A09G057) SCIF support
Date: Fri, 22 Mar 2024 14:43:54 +0000
Message-Id: <20240322144355.878930-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document support for the Serial Communication Interface with FIFO (SCIF)
available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
(R9A07G044) SoC, with the following differences:

- RZ/V2H(P) SoC has three additional interrupts: one for Tx end/Rx ready
  and two for Rx and Tx buffer full, all of which are edge-triggered.
- RZ/V2H(P) supports asynchronous mode, whereas RZ/G2L supports both
  synchronous and asynchronous modes.
- There are differences in the configuration of certain registers such
  as SCSMR, SCFCR, and SCSPTR between the two SoCs.

To handle these differences in the driver, a new SoC-specific compatible
string is added, ensuring proper handling of the unique features and
register configurations of the RZ/V2H(P) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4
- Appended the interrupts instead of adding SoC specific
- Added restriction for clocks and reset

v2->v3
- Added SoC specific compat string
---
 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index c13b31c28049..93fc7b75e2e5 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -79,6 +79,8 @@ properties:
               - renesas,scif-r9a08g045      # RZ/G3S
           - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
 
+      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
+
   reg:
     maxItems: 1
 
@@ -93,6 +95,9 @@ properties:
           - description: Break interrupt
           - description: Data Ready interrupt
           - description: Transmit End interrupt
+          - description: Transmit End/Data Ready interrupt
+          - description: Receive buffer full interrupt (EDGE trigger)
+          - description: Transmit buffer empty interrupt (EDGE trigger)
         minItems: 4
 
   interrupt-names:
@@ -104,6 +109,9 @@ properties:
       - const: bri
       - const: dri
       - const: tei
+      - const: tei-dri
+      - const: rxi-edge
+      - const: txi-edge
 
   clocks:
     minItems: 1
@@ -160,6 +168,7 @@ allOf:
               - renesas,rcar-gen3-scif
               - renesas,rcar-gen4-scif
               - renesas,scif-r9a07g044
+              - renesas,scif-r9a09g057
     then:
       required:
         - resets
@@ -209,9 +218,30 @@ allOf:
       properties:
         interrupts:
           minItems: 6
+          maxItems: 6
 
         interrupt-names:
           minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,scif-r9a09g057
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+        interrupts:
+          minItems: 9
+
+        interrupt-names:
+          minItems: 9
 
 unevaluatedProperties: false
 
-- 
2.34.1


