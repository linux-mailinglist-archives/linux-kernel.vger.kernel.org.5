Return-Path: <linux-kernel+bounces-38336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E167583BDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9243128B5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890B1CABB;
	Thu, 25 Jan 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xcld3nvy"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F61CA81
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176378; cv=none; b=sB1RzuY/Z1Keu9URDH3Vs8aML/9vzW8DoiCFSCKykKzP6sQKGkEXIFdsYHi2vuo+XMFSkENUJqJ7fbZOpOp986jOSdfAwL2t5iidhf25bcX1Cw5FX87R48m1iZuLSfP5u4TK9O6544YvFw6FUyYd2HXHSh8OeyqBW9yqR38hcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176378; c=relaxed/simple;
	bh=PefNmkCfcSVC4S0CUVrYlmPMrAYPLQBq6k2kvGzezPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBkwH/EChgobI3zF+bChHor8zWS4sQlVmwo0Yj3FqQKdeKvb0kwSAIpUyYdUvBQ7Izcro8ExipaUJQh6Hnw8+SWnxbQfrLljAjbWtmhp3u06BvDeT9q5HKWUPUvsNE61wR0HtSliXK7NOHlwdubDpgqA/9roqsXpVVrdz37A2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xcld3nvy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso4670817b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706176376; x=1706781176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7JPZ3FlmXtrPMvqbv7p+KV2yBKsdrHhwCB9rIMVdmU=;
        b=Xcld3nvy05xIEOxmLcZwG44XywG9RpZIZslznb+iXcOevlHPHtEi0E7WJ/LOdUET5v
         LdjD5j2iaXLb4YwQG8bEad3h3pqvzkbExz3lo41ewIM5d6fkE70LotfKLhJcJM1dnLFS
         5MLmD03kRt6jRX9xrHnUHpjBn26f+rahYwG8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176376; x=1706781176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7JPZ3FlmXtrPMvqbv7p+KV2yBKsdrHhwCB9rIMVdmU=;
        b=du8ViAX6u+IsVYOLlMUcrHr5IRl7do1l2BFTyyAcuiRD54Wg3GBcBLxbin3Pqp0tvN
         bMqoq6A6TPayBCJg6Qx/K1BWg17EHC46NKK18Q7UhPnB2xPBilEmni+Z9mzf8DQMHPnl
         dTm+bxbDFecYMcPJJJV8S6Tai+sjcaFm2PhpUoGh1GrpukfQj8xbUaPM0ZYddDzT5uht
         vNajZZdjN+AE34KK6oTID8W3TBZNxctqjtbBHBiiPH60AkhvVHJdYRrPxgCKlmK7Euhj
         Q4iTYq1y59sSzW03O+p3fe+CzeV/QyWR2PMAGCOOT2I7qgxLJyMzyCPI4ogSat8gPT3d
         CiSQ==
X-Gm-Message-State: AOJu0Yxl2Sz9ex6THH046EELHsKUKK5LERwt5cRAINAjnU5HuVRdIhnJ
	UIhqnBmFER1AariERtt7yyGmhGIom/KsmTTYmOaGuCxRzHXQwk7bD+pmIFXE5Q==
X-Google-Smtp-Source: AGHT+IEetX9gohXpDSKXt8dCp+m9IbL4e2u1dfNizaAo86YunKve6EwV6wkGQJbqZzkz7JS3K+JigQ==
X-Received: by 2002:a62:c702:0:b0:6db:d17a:e3ca with SMTP id w2-20020a62c702000000b006dbd17ae3camr283889pfg.63.1706176376292;
        Thu, 25 Jan 2024 01:52:56 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7fb6:ed02:1c59:9f9c])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006dd8a4bbbc7sm3228275pfb.101.2024.01.25.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:55 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
Date: Thu, 25 Jan 2024 17:52:37 +0800
Message-ID: <20240125095240.2308340-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125095240.2308340-1-wenst@chromium.org>
References: <20240125095240.2308340-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
SDIO. While the Bluetooth function is fully discoverable, the chip
has a pin that can reset just the Bluetooth side, as opposed to the
full chip. This needs to be described in the device tree.

Add a device tree binding for MT7921S Bluetooth over SDIO specifically
ot document the reset line.

Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
new file mode 100644
index 000000000000..bbe240e7cc40
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7921S Bluetooth
+
+description:
+  This binding describes the Bluetooth side of the SDIO-attached MT7921S
+  WiFi+Bluetooth combo chips. These chips are dual-radio chips supporting
+  WiFi and Bluetooth. Bluetooth works over SDIO just like WiFi. Bluetooth
+  has its own reset line, separate from WiFi, which can be used to reset
+  the Bluetooth core.
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7921s-bluetooth
+  reg:
+    const: 2
+
+  reset-gpios:
+    maxItems: 1
+    description: A GPIO line connected to the Bluetooth subsystem reset line.
+      Typically the W_DISABLE2# pin on M.2 E-key modules. If present this
+      shall be flagged as active low.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bluetooth@2 {
+            compatible = "mediatek,mt7921s-bluetooth";
+            reg = <2>;
+            reset-gpios = <&pio 8 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b64a64ca7916..662957146852 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13657,6 +13657,7 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-bluetooth@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
 F:	Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
 F:	drivers/bluetooth/btmtkuart.c
 
-- 
2.43.0.429.g432eaa2c6b-goog


