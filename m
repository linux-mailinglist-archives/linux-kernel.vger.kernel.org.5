Return-Path: <linux-kernel+bounces-74330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5A85D2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76C01F238F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F43D0A8;
	Wed, 21 Feb 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY13FSri"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149E3C6AC;
	Wed, 21 Feb 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505759; cv=none; b=i8zkhNh/HPbUS2Uknl6ChaNkmqPDp4VVF08derbcVZhR6Cn0rcU3FfB8hEDEAon2Vpr2UF1aW7PuogGpvizNoFp+3CKFAl/Dwx4qKZokBrFbv2LZA9cGMuzsq0GwHSRpDUbAICjBO87V2bHLiYjFBXDKCEkkUtE1tq+9bNxjY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505759; c=relaxed/simple;
	bh=4IJYkhebf/F5ri1CLsJ5vB3R5jmFJ8lLNIShqjZVjTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pWEdmdYLiIWA6bRznhDgj8a5ysuuhc1jhHYs9T1snZXojiCZGml6Ka8Zs1roRsmYYERcfRZ6NMQkilZdEa7W7MQBkJaHg4IpCrzR5ubJLMkmPDFprjz2QyMvOQWE7NQSvA4UZOPibMJOX/UiE2lQ8CRIWmJnGTM6QMbBEsT+m90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY13FSri; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512b42b6697so3694133e87.1;
        Wed, 21 Feb 2024 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708505756; x=1709110556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWgzr9qm2ixV3STt2Qq+/qGSNGS+7XQCw88w5N997QU=;
        b=mY13FSrijrMtwrg4Jr8VeFuD6pJpHHreWpFhu+w2d/QNAgCBb59o3MqFPsKxT/fuTM
         Pps13HjvelKSjfXhnxQYchvrDd3TLkHW0pHmaZop4Ht8s8PgLhq7+gqGihgxenxthLsv
         zeaf6ZM/LzGqmwf3KCB8quHd2cVe1DuDLwIqo+0b6EqncW11TRT6bqfypVFlmzH+0uQu
         fpXY3T9kE+xPkIAPP2AP8PkFNMmmZ2hHkZKhyDDBtt+ytPshCw0h1kC4Xq1vk9wU03HW
         7tShIwNGljKxlGZS9qU/vBjCCTm9MOyXvXeb4uZujd0Ep1+BRjPuS8pV4dnxMihdUKdG
         XNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708505756; x=1709110556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWgzr9qm2ixV3STt2Qq+/qGSNGS+7XQCw88w5N997QU=;
        b=edJvkQ0ZT7bla9J4nylyWpxq9AG3YE5Il87y2mDijK8tTYEQcEyY180UsHf9CNPYji
         9Rdwb2tPEHqDLP1cgheUGjDCZGFuj99QVcV82q1Qxpc5ZkLWeDpTKAR7YiC+SH68EzOF
         jdgS/Rx/DBVB9LDOZdXAPxhRFiGLMQKTOnsHjF6wQrD4qCf2mXsSjt+XMZztbKM9JnkH
         IPIU6TwlZ9u8VPWd7gM6NDWSRYcVl0I3etXOg+DYfJjZGhFUtan1xXr6tBiVw+0cC/f6
         5rGbQu/TjLecNn2+my0eK1JKV6SGe+cLJxjn7AF4A3JvkA0piNVbEZGSzY2DEGAHcxT+
         FLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwYkU0zCaQOTa1R1ZHB8QTVPyKSAoCmsZxJlnXWJaf1DelM3jCK2yrbqbybyWYDNDQnuWHGZXWj8XYZBuXVSsogNO/3X+wHGD0ZlwK
X-Gm-Message-State: AOJu0YwfHNAyz6YOjaNJ5TJX0wyXwpDdYn/WqeTlAj3kMzQJbHevYOWR
	cjE5GFttM3XoqjS/3QmkqDkQGcyHtmkJiOOSW20gG27/fvs7LHCy
X-Google-Smtp-Source: AGHT+IEsgZ5ECXJwsdJ2M1bEqD60lRnejSLvsJzQJfvw5APeIUFuGL5UdWpxBrtnmYuAEfEJSWsKHg==
X-Received: by 2002:ac2:593b:0:b0:512:b366:6c42 with SMTP id v27-20020ac2593b000000b00512b3666c42mr5168372lfi.32.1708505755809;
        Wed, 21 Feb 2024 00:55:55 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id p13-20020ac246cd000000b00511570772f1sm1578415lfo.303.2024.02.21.00.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 00:55:55 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] arm64: dts: mediatek: mt7981: add watchdog & WiFi controllers
Date: Wed, 21 Feb 2024 09:55:47 +0100
Message-Id: <20240221085547.27840-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981 (Filogic 820) is a low cost version of MT7986 (Filogic 830) with
the same watchdog controller. It also comes with on-SoC 802.11ax
wireless.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 26 ++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 2f89b18bab17..0dc49c47dfc2 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/clock/mediatek,mt7981-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/mt7986-resets.h>
 
 / {
 	compatible = "mediatek,mt7981b";
@@ -62,12 +63,19 @@ infracfg: clock-controller@10001000 {
 			#clock-cells = <1>;
 		};
 
-		clock-controller@1001b000 {
+		topckgen: clock-controller@1001b000 {
 			compatible = "mediatek,mt7981-topckgen", "syscon";
 			reg = <0 0x1001b000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		watchdog: watchdog@1001c000 {
+			compatible = "mediatek,mt7986-wdt";
+			reg = <0 0x1001c000 0 0x1000>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			#reset-cells = <1>;
+		};
+
 		clock-controller@1001e000 {
 			compatible = "mediatek,mt7981-apmixedsys";
 			reg = <0 0x1001e000 0 0x1000>;
@@ -142,6 +150,22 @@ clock-controller@15000000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		wifi@18000000 {
+			compatible = "mediatek,mt7981-wmac";
+			reg = <0 0x18000000 0 0x1000000>,
+			      <0 0x10003000 0 0x1000>,
+			      <0 0x11d10000 0 0x1000>;
+			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_NETSYS_MCU_SEL>,
+				 <&topckgen CLK_TOP_AP2CNN_HOST_SEL>;
+			clock-names = "mcu", "ap2conn";
+			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
+			reset-names = "consys";
+		};
 	};
 
 	timer {
-- 
2.35.3


