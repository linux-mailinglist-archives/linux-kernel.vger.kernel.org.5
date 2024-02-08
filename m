Return-Path: <linux-kernel+bounces-58748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26D684EB06
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BEFB23AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169744F89F;
	Thu,  8 Feb 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsCTU2E9"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A74F5E9;
	Thu,  8 Feb 2024 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429579; cv=none; b=JhplOzxq6IRY94KO02FugFNTTgoW+kXQqbd8VMT8wb2UWgCo/IAn6SmmA0AlSxCvOJQrUDeAtLfrCkQe7HWNFxKu/qk/BZtvqxfadbFh3zLShoA3rlcYoS0ZY4w87m9hP7BkHBIjJE3pU7Jttd6JNjzPK3rv8REm0h4Ar2PTHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429579; c=relaxed/simple;
	bh=/kdmKvzDOCOhG9OdygowWW1NOM3iNCMKoPvJLJlPkho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mje4J8mO78cLAUSX9+WHSRT44Fw27WTWxfubJnZ5LZ2p0TD1v6+Rsbeq8Piiy5Q1s++JA8w24wXOt8PsyY8rJv1B6CT94lP7LoCRW3sKFNXJcYc574JXRfvwty0YAlFrWq70xEaak/F8ovKU51eAn+nCnIkrN/1nw6bH2iFmBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsCTU2E9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5610b9855a8so1976832a12.0;
        Thu, 08 Feb 2024 13:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707429576; x=1708034376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxs7yJaWEy8nVn6Vmxrh4WNd6xA3nlO71xbamclQUKI=;
        b=QsCTU2E9IRMwIjyJkyBarAPOR5Fyo09Jtof7koNpZZVZu/SJkFUZ6F+15HUv9jOmyj
         75DPS55VeP0xmVEZjEoKXPWFpvrKzTLh1l8ruEHnW8tQHH+TEXNLaSMDim7C7NHUSFEv
         RDtVNp7uEWXU/uiIv5syvpLTfN3ikJL1vVu/tIVXsGJwYQnTSjkuisXQkBm+qxDzq+av
         auV1yiYsf3ODxYH1aJPJVTZrMPC/vdUbGtMIeAofkIQUPZmNsI4ieqlzVGoh/S7Tvspo
         U5IlQcqKsZTJZc2BVovAj12h82loTYLFlm//aFeOoBABPn2WuijBkcXCMGw45BB1tcYw
         9LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429576; x=1708034376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxs7yJaWEy8nVn6Vmxrh4WNd6xA3nlO71xbamclQUKI=;
        b=KQD4J0lXIRa7fLRptcts6aLv+JpLxWNYJrec9M4BbdG90M0U/W2gt4cp98rzKbIk4G
         vmOkO6BTUC8+93o+JMlexlsc8spv76JlUH/TJM6cj3A5nXcx6EjYLE2SmHr1DyjIX2WW
         7Z+cQ3dRI8Fy4XN2hQdHDYMHF/N8VSRbBuIVi1rhAzhlKP+0b/fHOlHEPkaf1B+RhFSc
         z65jk8JhUzSQzO5lBU8ypisKjH6nNaSNJ2i8r+7q2otwgmg/BWPuqwCicjkyIaN71CrS
         Nl/psLpihzjZ26L+V05t0FGxvu/xH3WOCo18Mb9JO+1KgBh0dnyTG4Fpxnmw8ISkINCX
         xqnw==
X-Forwarded-Encrypted: i=1; AJvYcCVvXMoA3o4gK//+EsXfPoq5ItcYQD/zS9oNtR6IX9dXKoQYGcqn5tHzFrjLogLm/+cKXwWrZEC3goQEsNR1hj+kS9hVHIC374uf46u1MsLYHoK1g/9VVTEuvxmwCxTqctQgfwcdIKsPxmkgM20U2HQng4rhOqCstyFpOpiudCJFPYWCzg==
X-Gm-Message-State: AOJu0YzThAzPgRR1Ej6Xz3mDZZLxG+8igc5D+vUgz8ONi20br9OIjZe5
	sjXGnunQaQcR6VB1J8zV/KxRuRtn8+hRbV8TQSNyosIy3svm3Wy7
X-Google-Smtp-Source: AGHT+IGPsZeHNB8r4fMWoVT95fkP1nA+CcvmyXpOh+PpzxhK4rM2J/gQL61+rynSUXTxgpFpay6f7Q==
X-Received: by 2002:a17:906:b7d8:b0:a23:7633:59ae with SMTP id fy24-20020a170906b7d800b00a23763359aemr744793ejb.9.1707429575727;
        Thu, 08 Feb 2024 13:59:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsHteBGFr4f+wVfaR4K3Y7cO52t+YzohayYtb1UWIeOqdULNH69dRGaLDWHuP7Wf2k8sHqTznLvMe0Ts/NJKWFqiADpfgy7fLJJtSpaHFZqnQLaPSyvi/8n+Gz2EnbK43svHPryAuZwLfKEMy4GZy8ubC/SOsmuFqadzLamANYl4CnBRlvG5s+LbdvvDtW03LMKendex5kV8PlgLjfv4m1cu1J/9ykSm+habVUbMQBADE538ctE4QiaKLUNJDWRvm0s/rvHYrnN9S8lq9jhfUKmQ5rZNxSvpQUAslUZddUTJGMSjIFHQp5fQb11GZYoFldf1EntxEiXBcIPHWGxWM9hEsUVk4JDA/xisNn0kuVrSoIyBWrIROANrizLhUY6Og0Rv/NE5beafDV4DDKE9eXmePPVsc6V00LvJ8si4NW/rjpV761z0wcwR9XkhplVOcmdJOgwQYHoWjWVQeZeXDbiPR5q5hpOZJuXqPUW9+zcwAbjW62dGUlVjXDYYYt3r2wlcE=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a3743142429sm108255ejc.39.2024.02.08.13.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:59:35 -0800 (PST)
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
Subject: [PATCH V2 1/3] dt-bindings: arm: mediatek: convert hifsys to the json-schema clock
Date: Thu,  8 Feb 2024 22:59:24 +0100
Message-Id: <20240208215926.10085-2-zajec5@gmail.com>
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
2. Documented "#reset-cells" property
3. Dropped "syscon" as it was incorrectly used
4. Adjusted "compatible" and "reg" in example

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
 .../clock/mediatek,mt2701-hifsys.yaml         | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
deleted file mode 100644
index 323905af82c3..000000000000
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Mediatek hifsys controller
-============================
-
-The Mediatek hifsys controller provides various clocks and reset
-outputs to the system.
-
-Required Properties:
-
-- compatible: Should be:
-	- "mediatek,mt2701-hifsys", "syscon"
-	- "mediatek,mt7622-hifsys", "syscon"
-	- "mediatek,mt7623-hifsys", "mediatek,mt2701-hifsys", "syscon"
-- #clock-cells: Must be 1
-
-The hifsys controller uses the common clk binding from
-Documentation/devicetree/bindings/clock/clock-bindings.txt
-The available clocks are defined in dt-bindings/clock/mt*-clk.h.
-
-Example:
-
-hifsys: clock-controller@1a000000 {
-	compatible = "mediatek,mt2701-hifsys", "syscon";
-	reg = <0 0x1a000000 0 0x1000>;
-	#clock-cells = <1>;
-	#reset-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
new file mode 100644
index 000000000000..eb429337cdf4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/mediatek,mt2701-hifsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek hifsys controller
+
+description:
+  The Mediatek hifsys controller provides various clocks and reset outputs to
+  the system.
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt2701-hifsys
+              - mediatek,mt7622-hifsys
+      - items:
+          - enum:
+              - mediatek,mt7623-hifsys
+          - const: mediatek,mt2701-hifsys
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
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@1a000000 {
+        compatible = "mediatek,mt2701-hifsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
-- 
2.35.3


