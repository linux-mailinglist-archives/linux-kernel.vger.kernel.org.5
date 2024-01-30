Return-Path: <linux-kernel+bounces-44560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F2842436
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D43C28D53B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A0679F5;
	Tue, 30 Jan 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Ro76OJuV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C0679EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615820; cv=none; b=IlspI1NWAn0r3q1M2Zhq1retBiqTAcyob3fXw4vkgBWxHKkPHhoN5pbL38xSbstEawx+CzzhGRyxwfOZGxqZnRvzkZv/3C+nH/OnPEy39Rm+fL8w3N9eNhDWcrNaqoKn+SDEqz7N3wSwBx2g9owyOhel11Wq6W+9htcnTbKHnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615820; c=relaxed/simple;
	bh=5BNuu1x/bXsqnfMaHPtVjp+t6R/LjBZtMNHFrzbKhFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYGeNGtvoZ12aSkudJIMKbxnYYpWgRNYfihHZRyaPy7h4M3143JT99JS/uDJcmTCsQNUIuAViPy3NSqDN8SPUw4Jir5r5GX68ya6b4hEn3d+jF5OvmJizzhic3SEoX95Pk7PVIMkyq7kdvv0Lp36nCoQgixp3cUjMppTdiepplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Ro76OJuV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28fb463a28so454127166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706615817; x=1707220617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UEGIekdyazfqo3T299WapeO9DNQtaZe4LTOdPjlFiU=;
        b=Ro76OJuVzL7y/JZv3h/GVERlwMXQI2C1KqybMRAn5ru8BbOG4gLzTuWjTTtbk0YIQ3
         MDIA1BUWK3T7Ep35GxdQXvsJaYD2CL9qCvVhaPOgDpxadCLT5I3+FgV6yH3wPa2jVJqb
         WzCwAzET2UmIzyZNRfVsAs+1iyYYaYZ8yhjv+KOCY2/yPDY9QheYCk2wXIhU6IiX6Ow9
         hMfWbvY1MvyiJT+yz4tR+sQQsrTLWH/Gv8IfG6j9f9FmWGN5rY+RSdUZrufRfaFoB2Ve
         rbZASFgS2GroqggKNugTBDGrkahJHHTEW+WjK6rbWTWTh6A8cgnr3Q3AguQhMojPEAsq
         frlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706615817; x=1707220617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UEGIekdyazfqo3T299WapeO9DNQtaZe4LTOdPjlFiU=;
        b=S6dOHsStp5ahu/rQm3ZaS+z4zFpmjkgnmEGxKmHPYRcqJNuWz9E/yqwvfZmtPGSN3W
         un8Qnob4IqtyXEV9uCI2PZIFYm74MSuAPjsnvbMAjx390tYrTnZhJYdLvvS3XMRDoRHg
         pPAxmgYgsfablsHEbCJO2Je/hVfHys3sSNpP4KPFXvYc6Nwo7JM4HAt+usnSzkgiSgGI
         SMwo6jfXko07L9Mu/RdZqnwGmy3K+Qqu9wrdf/0y+bRCt1ZhKtEtEVmGn2LgSDb6N3BV
         /kO9XWNRDgKanioLFoA8gijYTlaIvhhso0vygV/Fwbo8+f6nUPYer/WIS4N8iEWRlyyZ
         /V1w==
X-Gm-Message-State: AOJu0YzhdGPGuS3k48oVqOemmQwPhP/eJwJo2UpzwRSlspX8eNvG3IPw
	eFAlX4n11BprniPzCJzsaGBfP0T9M2sfK8V6hx64axJCSIODquHBkNSqiGZ4QKAt81aitjOAuih
	xpWg=
X-Google-Smtp-Source: AGHT+IHF2XMmAPc0QFgPB00blyrr9TU3ocIhSB9hQFLA8ZZADZtmjhdD61x8+AHygkJpvsIOw+nxsA==
X-Received: by 2002:a17:906:b846:b0:a36:4cb1:da77 with SMTP id ga6-20020a170906b84600b00a364cb1da77mr6163ejb.4.1706615817020;
        Tue, 30 Jan 2024 03:56:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUcaKChEB2aRD4siN6rXcukPfd3nJzIXUuUSm9rdm9/ggYWDvMvxsLIUWlF/DDOJ0d/MIvZ72c+1A2erHOcqgmqAn9cr60DqaVsoNxayeTimhKui/aOuVODf9YXUBsS3BhlRvTuHXBAXzsxbhc0RHby98kvle7PMCcsyZGCrcC6Nqq5Yk/FAyiJ2x0v80qrm7D5ZLYr81HKhABXsjXXVT+zGd4+2h2Cncl6Ic+S9aGIHiDBJ5UuVMJVxBAAAPqR7MP2aQVwQzpZrrkmI8bnCDDYcX6RtoJpYIyzm9nYr7AWT/XQUyleXjQVBUpuplF0WxYIwJWlg7jYr9ltWpc1RnnwHENfvqP/0gxN2f9JZRgKaw==
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id tl19-20020a170907c31300b00a352a99b974sm4201641ejc.167.2024.01.30.03.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:56:56 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
Date: Tue, 30 Jan 2024 17:26:50 +0530
Message-ID: <20240130115651.457800-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

voltage-divider is always an iio consumer at the same time it is
optionally an iio provider.
Hence add #io-channel-cells
Also update example.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
index dddf97b50549..98fec8548cc3 100644
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
@@ -39,6 +39,13 @@ properties:
     description: |
       Channel node of a voltage io-channel.
 
+  '#io-channel-cells':
+    description:
+      In addition to consuming the measurement services of a voltage output
+      channel the voltage divider can act as a provider of measurement
+      services to other devices.
+    const: 1
+
   output-ohms:
     description:
       Resistance Rout over which the output voltage is measured. See full-ohms.
@@ -75,12 +82,17 @@ examples:
             spi-max-frequency = <1000000>;
         };
     };
-    sysv {
+    p12v_vd: sysv {
         compatible = "voltage-divider";
         io-channels = <&maxadc 1>;
+        #io-channel-cells = <1>;
 
         /* Scale the system voltage by 22/222 to fit the ADC range. */
         output-ohms = <22>;
         full-ohms = <222>; /* 200 + 22 */
     };
+    iio-hwmon {
+        compatible = "iio-hwmon";
+        io-channels = <&p12v_vd 0>;
+    };
 ...

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.42.0


