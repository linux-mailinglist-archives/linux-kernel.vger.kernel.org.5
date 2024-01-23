Return-Path: <linux-kernel+bounces-36108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC5839BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D47282AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2414F21E;
	Tue, 23 Jan 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qbVAC2vD"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B404643B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047529; cv=none; b=CfSUwUtM6q4hwQDIUlyKPfxRgRgfsCqZ94Tyd1l6hzM6T83lyfbt71unyvsDJ6qGssi+To+lFIFB15wj4ALRB0MqJ78FUd1NhZwOSFzx47OdsM9byNDNyw9CF1J9cgM3kFQcTMx41G1SH+9SmDs0sVlBPU0E8U050A6Tl8DaXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047529; c=relaxed/simple;
	bh=anPJRLvgFfoVKonfrqY+CAfoMBnCL4+TiwFr4Nj5IWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxzf/cJWNfZj42Dur9rtLTs+fME54cXBX4pioE0mcDI8d9nTuyuxdtmX22hxJOiJMP6oI0pmPbx7lLduXAbZEcO0Y/qAfc12Cd0ioVhCam7XBZekg/zMqeRM8riu2RXDsqg9Po6g4Y2ufvg/mnITN5pUNvzyDQm+nKcHyEws88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qbVAC2vD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7834a91b086so375841685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706047526; x=1706652326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3E9jUO/PvaC+94R5jes7948yznQ06BHfDuuwd4Z3Mzs=;
        b=qbVAC2vDxAacoZ0w2VjXY4XQa1MbVGHQKzlN1nHaXzsCguIcg4MgJYmUb+KyXxrOcp
         twaRZlVwHcMMSVgvQCTrqndbt8vhqe/yRn0F7tAKVDgrwTL7nlLHPpBILQ1WhEU1NAxw
         80yVLRi6NIMx/2gbr8jqPHvAHsxj4pVhxQ3Vt/FU9J4pMD140ZhJrTxTB7lvNK5H6o7e
         Mlk7Nze2UQzy4zso4BsZenTfAfTF7APj01Py5Ru2W2ttJtZiZta3XWoli/xa3hjc3CN5
         OnkpcJvAGwgziXEDayMhcCbtTvKWbDT/Fq3/ALVeK5eV9W8tyKR5Prdae28+L3QdX+CK
         q6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047526; x=1706652326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E9jUO/PvaC+94R5jes7948yznQ06BHfDuuwd4Z3Mzs=;
        b=AG8JtWZY99xiU0nX+3ynijxE6w5r1nLj8ljMt8jvM+PqAUcvwlbfLt/wgnqPFjHVBK
         rIJZYzbsTERWOS4Hut10OKc1ZSBnZLyImEKrLb2kMeUlXrQr3BZwEFL8Y5XEgii0xwJq
         2rxnzDzthQc7Mcy4vID4JO6daDGCJQOWd1tH8rtjg0dRalsMSons7npSWC+B+iHbl214
         +GAZ+uR+pSafoLSPpGCWreV2yY62uy/RaV2b/7EmCxxamkuDaFz58sJfRBF2TOy0qJYd
         1b5Bt5n4G5fiwSR6y5TuieOGrVrJ5RWeuJdl5n2KaQJmiSTQDa6DeRjX2I4mz1mDoysB
         5ihA==
X-Gm-Message-State: AOJu0YzWiGjNPxVgu2M4gY9zzy+4eOkHoaOLCTBGyAe8m60E5B2DfDrm
	rwQ7fIKzoKoYpzyPmjMRCVe8vKNSEfHFdYgQ2+W2HFPCUBNqJjmN/c8aEfJCBW8=
X-Google-Smtp-Source: AGHT+IGNBWALoN8Sbo50AoIaWBKTVjaovPRpAwlxEUdSGzKKXO0xqE90mgpIQFOKaOHPTlD6VCPqdQ==
X-Received: by 2002:a05:620a:1276:b0:781:e4cd:785a with SMTP id b22-20020a05620a127600b00781e4cd785amr397331qkl.21.1706047526304;
        Tue, 23 Jan 2024 14:05:26 -0800 (PST)
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id y26-20020a05620a09da00b007834bfeb0e8sm3425402qky.51.2024.01.23.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:05:26 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Drew Fustini <dfustini@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 1/2 v2] dt-bindings: pwm: Add AXI PWM generator
Date: Tue, 23 Jan 2024 17:05:13 -0500
Message-ID: <20240123220515.279439-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123220515.279439-1-tgamblin@baylibre.com>
References: <20240123220515.279439-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Drew Fustini <dfustini@baylibre.com>

Add Analog Devices AXI PWM generator.

Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

---
v2 changes:
* Address feedback for driver and device tree in v1:
  * Relocate "unevaluatedProperties" in device tree binding
  * Remove redundant "bindings for" in description

---
 .../bindings/pwm/adi,axi-pwmgen.yaml          | 48 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
new file mode 100644
index 000000000000..63461920a362
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/adi,axi-pwmgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI PWM generator
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description:
+  The Analog Devices AXI PWM generator can generate PWM signals
+  with variable pulse width and period.
+
+  https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: adi,axi-pwmgen-1.00.a
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+required:
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@44b00000 {
+       compatible = "adi,axi-pwmgen-1.00.a";
+       reg = <0x44b00000 0x1000>;
+       clocks = <&spi_clk>;
+       #pwm-cells = <2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..8a4ed5545680 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3431,6 +3431,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
 F:	drivers/spi/spi-axi-spi-engine.c
 
+AXI PWM GENERATOR
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+L:	linux-pwm@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.43.0


