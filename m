Return-Path: <linux-kernel+bounces-58751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9299184EB0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0011F27DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8984F60C;
	Thu,  8 Feb 2024 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVmfoHOW"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895B50A64;
	Thu,  8 Feb 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429584; cv=none; b=lGiKjeBwlP0XPgFzIxl0hp0kJvdKTIR1ZBBCzflD/HINWscAtaTWNvuCGzZ6ZL1iik4asWQ5rBKCC7vs51HYtrlJPzDBinwHFOrUHo6aQTSzRimmCAcwm8XyBWpn7gX1H4mFEblEUopHJ1wvzltqB9KAwW2AYQF+pzVKX6oFlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429584; c=relaxed/simple;
	bh=8f35FdJ/pQY+mhck7+IAQi4vxCn4gr2UiZgQP2iv6T4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUYl8jZSU9F+N82K079jIPyWCpixHWWot101amMyqTn26Ht0Osj9hxAzXBR6X+VGNLrvnNhudGLJztKuMOp7rvT3NqkqIe+q/Px/I7gShfhwVev0FSoewy4GmcVKns9PbB6sT97gJ+8E8F+QVg2EnsD+6gZHxu1tXWpW4uxrF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVmfoHOW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a388c5542e9so254686266b.1;
        Thu, 08 Feb 2024 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707429581; x=1708034381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpgVj5cIJYfsEe4k8tOMDseJ01hUY/30ToLsNTzKrj0=;
        b=SVmfoHOWuY2SnmMM7Tk4IwF729lltn8G8DbU7ssHqWOAAeC2c9QEMbGD+JGrrz2mFa
         yVRHDGnRUoqAWzDScTen6UObg9TSzQ4ItFJMJiGtFMhjkAq2dz42vovKhKOhQQbIRwkR
         GCnzfq3h187EhDdiMISdLzAcne9gfAcylNIOldq/n2w1roqO2HawjUVFYYSbI5DVMSqS
         sPB2gjnD1NqOiHF3BqGN6BWsWuMuXwAB6+JkRqAGAI1o3uxrso6iK7TBzTHaacAeWIt5
         eC5bPzb3zQC0FOJ3rEqsyE3zN+cT7u7SkUz7hxgqwdM97mskILOw+I63chrkLyAZx4TB
         3anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429581; x=1708034381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpgVj5cIJYfsEe4k8tOMDseJ01hUY/30ToLsNTzKrj0=;
        b=IafNcKVA5ayGifwl1icbdpbEBJ7SXLsZ1NHLFrIpa/v1lIX+Ix53ghcYBmAnNi/s/j
         Zfjw+P0XpLoNFFBxw/LbReQKhoj6OC9EiFXJ1JPEWRLlUrkdezX35geIGIfFvtdBbSFY
         tWE0x5HD6Cx4vu45e7SCVSsUGHc5tKMuKsIxHiqf7YkkQhIa6paTkaZzb/8Je5THuC85
         NCB7uuAQs5zvDgQI8bIKuJcC1b693aK7bUxEuPYL+qFJIvGEibUdVRDZebIvuIiXqQxp
         tCwXF3+IyvRTzQfoMmUUTvv6ooE6RLc7/SR4be5mvogvEgk9pnfNQcfubfRZVgE6yQvL
         U3Kg==
X-Gm-Message-State: AOJu0YxdqBnpp98FmiRpxHh3oVJFl0x/n01etm0m1WtZauJkG6bEEQGX
	JwfRr3CKUs0pXVHtzC1INQGHkzEpa4kePZZyumU53jg5Bwkth5bhqFWLY4k7
X-Google-Smtp-Source: AGHT+IFNxvM9cY+GaiQyQtPUyUX5PIfavKE10/ptk4BXmXj9FVhWmxsdHmeT4N0bGqDsEKu83NTBLw==
X-Received: by 2002:a17:906:f753:b0:a36:5c45:1e09 with SMTP id jp19-20020a170906f75300b00a365c451e09mr628743ejb.31.1707429581490;
        Thu, 08 Feb 2024 13:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXltFUHHXN3QJVpFmKZaCHkdH8PMvNfBhL99ytOY454pqiQKr2FFutKWFoWShjCCMTwLN2sgcRcefp+CfhhFBcdRzvld0rnW/jtVj30JvFzNrZ3Q6qrvYpCsRAd/VBSDViKWcNHWQQz1xJtKoCPjrLo1aPy1TwbAVwebS/VqbfRtXPeu8QgMP3xIB3/V/dIzyQhb03FnQuAzbLpOplvi8/ltLffe89S1oaeq3zP6Wz9ekzVfJwPKM2Pr9S98EH/55v5/L9tk4KlbT6RkBpRMgkY2LLeHf6B/9CnOUzA1IRb3RMX0KwILY1g6Z9qYqSEJSj1Wm7jnNhTXJfCZKE6rNNl8qYGpGSdG8/wWehReYwAzFl2jvDwx3msi9Uvp/fC2WBTMwc0X8r0Zc5c0K1gN/uGzHHloLc+WFb63Ht1JFtsFL4Z8UXj7PSB48Kk13tBQ2rkrcakd5XMDmESB6J85Uc8ypzzM1DVJspwHDloamzfdBbU8q1WRr31fxRikE3HCrJycO0=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a3743142429sm108255ejc.39.2024.02.08.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:59:41 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/3] dt-bindings: arm: mediatek: convert SSUSBSYS to the json-schema clock
Date: Thu,  8 Feb 2024 22:59:26 +0100
Message-Id: <20240208215926.10085-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208215926.10085-1-zajec5@gmail.com>
References: <20240208215926.10085-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files. Introduced changes:
1. Documented "reg" property
2. Dropped "syscon" as it was incorrectly used
3. Adjusted nodename, "compatible" and "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../arm/mediatek/mediatek,ssusbsys.txt        | 25 -----------
 .../clock/mediatek,mt7622-ssusbsys.yaml       | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
deleted file mode 100644
index 7cb02c930613..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-MediaTek SSUSBSYS controller
-============================
-
-The MediaTek SSUSBSYS controller provides various clocks to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt7622-ssusbsys", "syscon"
-	- "mediatek,mt7629-ssusbsys", "syscon"
-- #clock-cells: Must be 1
-- #reset-cells: Must be 1
-
-The SSUSBSYS controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-ssusbsys: ssusbsys@1a000000 {
-	compatible = "mediatek,mt7622-ssusbsys", "syscon";
-	reg = <0 0x1a000000 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml
new file mode 100644
index 000000000000..5e48c2d3ff11
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt7622-ssusbsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SSUSBSYS controller
+
+description:
+  The MediaTek SSUSBSYS controller provides various clocks to the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7622-ssusbsys
+      - mediatek,mt7629-ssusbsys
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+    description: The available clocks are defined in dt-bindings/clock/mt*-clk.h
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@1a000000 {
+        compatible = "mediatek,mt7622-ssusbsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


