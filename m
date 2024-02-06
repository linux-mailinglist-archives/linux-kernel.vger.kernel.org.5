Return-Path: <linux-kernel+bounces-55128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C443884B823
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86BD1B2A531
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A211332A7;
	Tue,  6 Feb 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F5HaZh7r"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809238DFE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230283; cv=none; b=VBqBANGFpnwRscMdQ1ppPBbZGfN2OYCgTuzLnNvjIe5e1gGeMtnaRWg/MEjhIg3p4NNBDR2RGa8/fP0H4WWsicXj1TSiUR2fPfiCS02Uj1Yz+4Id6d6UwtMELBjbHy5CHZW5UD/zVbXg7tADOFxzTAKRXRqLGwuXTksm0sc+2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230283; c=relaxed/simple;
	bh=HO6KVEaHf/T7d9XWP5w/68iUgcAaz0HDcz/jMuokJ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hypwvVRJ0xAKqweRK9zqKSgsXEMhGiJX+aglMeMNC0qM63DgQ9KKsgkGTnZ7S4tnJ1tMP+Re4Az1khMelDarVzT7nHpYoNHF8VuN2efFybKQv8aCJ/TYHA+HS6iUGhHDirD8hqMqpCfhVjMAZ0M33mxd2t7Kt52OHqUPidnxMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F5HaZh7r; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a36126ee41eso719925166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707230280; x=1707835080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGo2FC7WYDd1/me+URO9ZglcapL0YwY+tHoSxOqlK5Q=;
        b=F5HaZh7rV77AxY79Qfo2D4Cf+bc6TPNq5udZI5pfaXFRgILHCQYQJgsAeHVJPWy/dY
         xw2XKilNBUxKGHR47MF/X5y0IVk7uNStKVcFfQ1YqXnJy4n8wCvTO3u7EZm+PNGQl8Al
         yH3CC3DdZuEMes2/r++1evXf2xPlAoGibe81SGBmk/Wiw3pbIG6QhPlz1rITx7BdrqXr
         Kaovwzif94lhOZTaVzqDrSqMdppNwcsP4P8IRQFDSuN2fM2EXjruBHKLilENcPw4E/30
         QxiuQn1SAg1IKH0M6s3Rhyoqucg5i41iFFYIjiD/Ece9e4QaiIbApjyEPKoZbXjW0h3j
         DvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230280; x=1707835080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGo2FC7WYDd1/me+URO9ZglcapL0YwY+tHoSxOqlK5Q=;
        b=Xafj58wsZPDIFn2SfTV8LWbnApgvEYPPafvXcQ7H9E9dOR/fgjqrm/jeHkhJ4gMu+t
         sloSejb+B83qt87iqS/3rL1gq3fcC2TzMOgnQLGPmFp6M7t8QYd+LLIPixo5RYG4yZEJ
         VJg/b6j+hOOGpP7fwYyUGoHq+EbEQyFcOxl8F0iUYIUMBNoDcQs2bhUd/1qrJb0jH7q5
         /LlM1IQgMSBEP0Q5vd+Gc12WtYlAYoXiwrMAP8XLdnylfoIT2NvDyo/kvRfH4yTijkNG
         7zz8X7lmCaNhkpl2gUF5t/kAUNbaUyB+OUPzHjAF57uRfjfzeSsBxZTZpNvLTa5P0y+9
         86zg==
X-Gm-Message-State: AOJu0Yx7DxQ8/GgLd5SqikHjg1ixc3prWKBktR6VgkpmdnAP79r9hlf9
	OGeQt4yMk4uMSmuYCfpgNaJofWE9yKr3T1W4EKvvehlq0JTOGX0FdPCWWRXelic=
X-Google-Smtp-Source: AGHT+IF7ec8YioOi3EaMdtpeBC/tpUFWxSwkWotQEzkbOgfiI46OKfwCr9u0v04m/mJCpsTEhBAYMw==
X-Received: by 2002:a17:907:785a:b0:a37:ee9c:273e with SMTP id lb26-20020a170907785a00b00a37ee9c273emr1653077ejc.53.1707230279829;
        Tue, 06 Feb 2024 06:37:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXWFMbNZogEPZ1ITtLgkoEB7IkPokqz7J5Zt/rg5GPnr0bIPNBNVMhc624wKDa5A4GCh+nu2y+4j91OIUDKBeYcPb763wn0zCzf+F+1dxkqRWMQuIiOsT+HjZQs2XzqnT/RtRe+fROtFviI8I5XsL1+TjoUyZX1Ppr+qEdbCTSHS51JvSSxdjpXj5b35O5pDmDdi9DBxL7bhAAhkTvQKLUWyAO+yxWzXa/uW+zRaPkRF2YYxXrEELv120fyFcSmARQQaWi/zJF5vUEqpqp+uiX8oGPqWNflVriBNezI0dGq6mIKRnXla7t2QQBQRANso9sMHj4/QHnXaKpSAZrLJmtjmY23JuV0kUOihwPSezjpdYHvOL5aQqw8GNNSXb6KfvypgWmTeVTpl0srxEFQPZzIrLq/PvdamOx/FZyRlDVzlMgfUla
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709062c1600b00a37585d5dcesm1224418ejh.51.2024.02.06.06.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:37:59 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Date: Tue,  6 Feb 2024 15:37:09 +0100
Message-ID: <20240206143711.2410135-3-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206143711.2410135-1-msp@baylibre.com>
References: <20240206143711.2410135-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The information k3-socinfo requires is stored in an efuse area. This
area is required by other devices/drivers as well, so using nvmem-cells
can be a cleaner way to describe which information are used.

If nvmem-cells are supplied, the address range is not required.
Cells chipvariant, chippartno and chipmanufacturer are introduced to
cover all required information.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
 .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
index dada28b47ea0..f085b7275b7d 100644
--- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
@@ -26,9 +26,24 @@ properties:
   reg:
     maxItems: 1
 
+  nvmem-cells:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  nvmem-cell-names:
+    items:
+      - const: chipvariant
+      - const: chippartno
+      - const: chipmanufacturer
+
 required:
   - compatible
-  - reg
+
+oneOf:
+  - required:
+      - reg
+  - required:
+      - nvmem-cells
+      - nvmem-cell-names
 
 additionalProperties: false
 
@@ -38,3 +53,9 @@ examples:
         compatible = "ti,am654-chipid";
         reg = <0x43000014 0x4>;
     };
+  - |
+    chipid: chipid@14 {
+        compatible = "ti,am654-chipid";
+        nvmem-cells = <&chip_variant>, <&chip_partno>, <&chip_manufacturer>;
+        nvmem-cell-names = "chipvariant", "chippartno", "chipmanufacturer";
+    };
-- 
2.43.0


