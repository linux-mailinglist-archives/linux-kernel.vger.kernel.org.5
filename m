Return-Path: <linux-kernel+bounces-111991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B48873D8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364571C22C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB52779DCD;
	Fri, 22 Mar 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL6G75kg"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274679B97;
	Fri, 22 Mar 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135490; cv=none; b=kqcjEQExuUo/45CW2hdfniRMvzF7ghUY7Y++mfXf8sIZM2U6ZG/6KiNDYHsQgc7qFdeAgqclIR/Yd/hJ7JkFLrL+sAVnme8Z/ZwJ+GfZsCImsPZtOR4o4//s3Q3izUuf4UfBz6SKKMmKW/aMy+Io5GPsOhYfstOjgLtU2ZkgXjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135490; c=relaxed/simple;
	bh=O6ZF8AixVLf2eRm+20VlkeyMfauGenKZYfdBbtHsutY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McpMevjIH7BFj/z+7b3ViSPNMYDL/G0t5NBK09GvzhiIMYXlUG0CjB6HA+gobPx5paYWLugEmmEqGbs54YcsQG8z4aJL7neFaAn7c6BUjDTLR2FM0LJ4MKL4ZdiL8lELdGqrALx4k0JHsK1zl/TK+1S48Vc/tWSxD0RSjE9Mbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL6G75kg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513e6777af4so4634591e87.2;
        Fri, 22 Mar 2024 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711135487; x=1711740287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZnGroDIqCF/lMVS0ApuLGPQdgg2yOe6mXFPk44TpZc=;
        b=fL6G75kgTv2rsF3PNHmEwLjA1X5s9G8c5F4LKzPcb95O6pHVa4eHgFRzGSY4zpljIr
         xnOSmBZ+GOr2cACWIb0zvh7Py48ABnXELPodTdIO1MAxvIHeXuNpK4q0fyWkLK/WQ23k
         oUOKsIP2YH/d/Nyog0l8cKLz1bP8ACpc4ppL8xVK/ktHhJEoxXtP9DRvIzbtljPlNZBF
         L9bOuHpYgmJmdDPMuZUpsBsQo1M+4pY5Jup17k0BYzgNjCMqgUiMrhSpkeAs/gxNhWmr
         VIxJt1xU4Wf43ipqfEyjzxLHtYFcu7DVo31UW2kqmm25ZDGBrqLOf99oBZ1c7MU46W/j
         ShFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711135487; x=1711740287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZnGroDIqCF/lMVS0ApuLGPQdgg2yOe6mXFPk44TpZc=;
        b=BvEF4/SwBiHOJaS2KpkqQ+lnX1noeyrOMYO0bskdiJEmiNWYY27MGmCIsHpgGsPVN5
         43UrDXaoallAzzwuzsApqKI5R57a+cYBw9KmWb1YMyU//83Y7KiaAn8mhVTpkWu+b00y
         492+YHkvgOQzfP4R1EhmMpaRlX2v5sX3slhDT/qUeQBlwjt1/mQs52rvHr4gsvTAzzkK
         JrSea/EFhpiC53iqHbudXnCyiU4lBu0z+YOpVHA8rn4hSrX5+t1INSfW0zdS2xlIYwry
         5g2m4ffurVjitbOnvfa/sBwxtuEkzcZ0wtDqAcgR0HF2F4t+QA1cWtnataLtzbpEuycq
         U62g==
X-Forwarded-Encrypted: i=1; AJvYcCW2OgKiLS7q9YxerHXjLzFPPRkSSuDG3fs1UmaaWIt9LAF8slwjI1VwIWMYbTJK9KkpNYJdm/OQgoOtA8x+iHIvMpFUn7HOEJhKBi0Fgh6+gfU0ztqe1OaUumdjceejcGvAHDECL1oTgQ==
X-Gm-Message-State: AOJu0YwuWXK94KU8KU8S9F/4BDCG4NB9zprKZQ+1TP4pOFjITy4OFGaJ
	eYfyS7tYg40ppBDjR5VfSEotcqiXVEQ4xYWJhWsxzMdnNFUiznT8
X-Google-Smtp-Source: AGHT+IGGyVKkxeA1Y0HyiM85CqmDIq34jH74s4IHJuZKr9P3A15+SZzTvwvPnoi9mUIq67umtHs1TQ==
X-Received: by 2002:a19:4344:0:b0:513:e14d:15e1 with SMTP id m4-20020a194344000000b00513e14d15e1mr312698lfj.57.1711135487059;
        Fri, 22 Mar 2024 12:24:47 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7fa-7d92-6b28-0504.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7fa:7d92:6b28:504])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b00a46b87c32besm138572ejc.39.2024.03.22.12.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 12:24:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 22 Mar 2024 20:24:36 +0100
Subject: [PATCH v3 2/5] dt-bindings: hwmon: ibmpowernv: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240322-hwmon_dtschema-v3-2-6697de2a8228@gmail.com>
References: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
In-Reply-To: <20240322-hwmon_dtschema-v3-0-6697de2a8228@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711135482; l=2606;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=O6ZF8AixVLf2eRm+20VlkeyMfauGenKZYfdBbtHsutY=;
 b=0k3y3yB8td836Vv0vjh5jj1vLP7hRXi8mtoE4bgIlJu48ClDtv2TlLskejv4mugvbWVAsoSym
 8fJI9TnfeZsBcncWzvR/6JvN1F+4wJpDnSGIc76J95Uw/RNE6fKayFL
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to support validation.

The binding has been renamed to match its compatible strings, with no
further additions.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/hwmon/ibm,opal-sensor.yaml | 37 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 --------------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,opal-sensor.yaml b/Documentation/devicetree/bindings/hwmon/ibm,opal-sensor.yaml
new file mode 100644
index 000000000000..376ee7f1cdb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ibm,opal-sensor.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ibm,opal-sensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM POWERNV platform sensors
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ibm,opal-sensor-cooling-fan
+      - ibm,opal-sensor-amb-temp
+      - ibm,opal-sensor-power-supply
+      - ibm,opal-sensor-power
+
+  sensor-id:
+    description:
+      An opaque id provided by the firmware to the kernel, identifies a
+      given sensor and its attribute data.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - sensor-id
+
+additionalProperties: false
+
+examples:
+  - |
+    sensor {
+        compatible = "ibm,opal-sensor-cooling-fan";
+        sensor-id = <0x7052107>;
+    };
diff --git a/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt b/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
deleted file mode 100644
index f93242be60a1..000000000000
--- a/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-IBM POWERNV platform sensors
-----------------------------
-
-Required node properties:
-- compatible: must be one of
-		"ibm,opal-sensor-cooling-fan"
-		"ibm,opal-sensor-amb-temp"
-		"ibm,opal-sensor-power-supply"
-		"ibm,opal-sensor-power"
-- sensor-id: an opaque id provided by the firmware to the kernel, identifies a
-	     given sensor and its attribute data
-
-Example sensors node:
-
-cooling-fan#8-data {
-	sensor-id = <0x7052107>;
-	compatible = "ibm,opal-sensor-cooling-fan";
-};
-
-amb-temp#1-thrs {
-	sensor-id = <0x5096000>;
-	compatible = "ibm,opal-sensor-amb-temp";
-};

-- 
2.40.1


