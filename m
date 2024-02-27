Return-Path: <linux-kernel+bounces-82493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D6868551
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A574228603C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1984CA6B;
	Tue, 27 Feb 2024 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW1tJvIS"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781F55677;
	Tue, 27 Feb 2024 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995428; cv=none; b=dAzS92AUxyCMTDMfD8YrncOId2FrCaIK7DDU+VN8kdBjTO1XesjFdhBRX4uHKA9UpOw9IlP07xp9f46CtG+0PUtvX5Swrj3JZfHRJGwa7YsVpgKucHVxV82pI7YJfK559ISi8PVlcsmv9dPKEInhkJxhoDqAwZyr8kI24rzKYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995428; c=relaxed/simple;
	bh=ha3outr04c211WlbL7UrxuY7H5g3Tv8+gVzsMAa+d4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S30Upws6B1puqxLRSqmZ+GR8YkwKm2smq4aaxcjn2doX/L0izbDiI9PaSWY7f0lNYJbf8Pw6SpeVknPLGORFNBemu/o0cKQhV4+LZ/EzBWAOsY5EGsSet6We/puL1ZdIHsJkf7y1ax1i0SaEthZg7Ig4+jKJxcEN+88Zrtjsz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW1tJvIS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc9222b337so18925835ad.2;
        Mon, 26 Feb 2024 16:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995426; x=1709600226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXi+EZVID4E8b+CXe/Hk7KUMrKmNyfrWhdCErmZSb3c=;
        b=MW1tJvISff8V9io4KAHm7LSQetPjhRYuOebPI8JEMej6DUFKdQ/6Cwhrj15dtj6Paq
         Nc09T/SWwW1RBiA1kaoi5NI1hJak0/7n3GT7r8IhqIdWz/nTM/ipr/v3ekHzHiEvDRZi
         upl+8KdPggLT904JrtcT2yGcNVOpg01D7fW9RnHT1u/P35nBmhLmh20WLOP5l681OL5q
         pBtuU05N2wwqWmDi4XyvKNxdtXgofSvd0PWPk9IlGgM0AWkmmrHcD5pzejLad3j1eLMy
         AxPWG6gW86NxvtFCs32/ZzO7TVlpEtmvQRTVEGBOiequFZYB3iPpLfhAbMio59ntlH3/
         NJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995426; x=1709600226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXi+EZVID4E8b+CXe/Hk7KUMrKmNyfrWhdCErmZSb3c=;
        b=cgbFY2pf9B21+MYV3HH+nSAZiV/EDUuSwG5vanjERI6TAyg7DiPCYPFrf30MvQuRWE
         XC+q7rLrcBe6vpDycEDbgM50bT9H97aPtMp5d89JpindRFG8HdDICXegw9Uwu1yapy6s
         UnczAR/Mz7cH63z7UfW4v6jN+x+W3A1aKuAWF+fZX3PJoRSeJeCReJwkgsRx2ZnLm9An
         wHbA1As0IHsT2qFzRhIetDPaAWcbLBh8v837+H3zKx4vlmtD/mE3JE3rAm/UuoRByWei
         ovh9FGvPmYq2docGV/kKD9HH05iDk7zqLZeDwXoF4yLcJtTB5LK7B6qAy8L406KI07A9
         mNcg==
X-Forwarded-Encrypted: i=1; AJvYcCUzkPQxyq7FAz76oJetCNqeWRaePdc1BESswr9uHso8yEJpg4bNmj3BlrUqXbBlGYqm0I6AxdTAD2ohE4pferM6j21o6wI1BToaKLqIkU61tXkP+xvyMVq8kEBHp4D623psFEkmIecLvm3y2YqkQkqBIKd//DrWvStQE7DInHImmuWCLg==
X-Gm-Message-State: AOJu0YyfbyQijCc8lD4PcLUOj3tbM3DHLB0LAyrt286nIfC7cmb0JjgD
	ubyZwIgdbSl42WZL6iy0UYqCwpP4574S/Cimdzqhj/mfmcQodcCR
X-Google-Smtp-Source: AGHT+IHDBTU4B4bE7MuqoWsW27RTpEY/9wt/RxmXQVQMaJSAcikh2aYtV708TQUXqUm3AxWoac/KEA==
X-Received: by 2002:a17:902:7786:b0:1dc:cf0:555 with SMTP id o6-20020a170902778600b001dc0cf00555mr8453758pll.10.1708995425703;
        Mon, 26 Feb 2024 16:57:05 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001db3361bc1dsm289253plg.102.2024.02.26.16.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:57:05 -0800 (PST)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com,
	naresh.solanki@9elements.com,
	billy_tsai@aspeedtech.com,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: hwmon: Add NCT7363Y documentation
Date: Tue, 27 Feb 2024 08:56:05 +0800
Message-Id: <20240227005606.1107203-3-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

Adding bindings for the Nuvoton NCT7363Y Fan Controller

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 .../bindings/hwmon/nuvoton,nct7363.yaml       | 63 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
new file mode 100644
index 000000000000..1a9d9a5d614e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT7363Y Hardware Monitoring IC
+
+maintainers:
+  - Ban Feng <kcfeng0@nuvoton.com>
+
+description: |
+  The NCT7363Y is a Fan controller which provides up to 16 independent
+  FAN input monitors, and up to 16 independent PWM output with SMBus interface.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7363
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+patternProperties:
+  "^fan-[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    required:
+      - pwms
+      - tach-ch
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon: hwmon@22 {
+            compatible = "nuvoton,nct7363";
+            reg = <0x22>;
+            #pwm-cells = <2>;
+
+            fan-0 {
+                pwms = <&hwmon 0 50000>;
+                tach-ch = /bits/ 8 <0x00>;
+            };
+            fan-1 {
+                pwms = <&hwmon 1 50000>;
+                tach-ch = /bits/ 8 <0x01>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..7b1efefed7c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15084,6 +15084,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 F:	drivers/hwmon/nct6775-i2c.c
 
+NCT7363 HARDWARE MONITOR DRIVER
+M:	Ban Feng <kcfeng0@nuvoton.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
+
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
-- 
2.34.1


