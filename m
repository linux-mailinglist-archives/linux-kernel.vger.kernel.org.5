Return-Path: <linux-kernel+bounces-39711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D15283D537
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDD01F27606
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809025B20D;
	Fri, 26 Jan 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ANyoC5JM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964C5A7B8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254858; cv=none; b=e9Nwr3+tRCPBUmn5qro+Zu4mlPqRCRHCXf5RdrHHv4aeGz4gFq5efoyvZPWK+f1x2JeZSnUuMhuut9ppx3uZd8Aowd/en36nqntgI68KTleOTs4V/9t8UnsbCm40BY6PdNd3ULC/VDiWwIkZRzaIFFRjGA1rUS1D5DJIxZmIAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254858; c=relaxed/simple;
	bh=nTiYylG8tSnDEvIXmdXEq0/VCrf/jBpf1+luh66Xbf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puQLku28VEKaLZFmEkpqccU3VztWc1rmXMF/L0KwFnvTUG4lbovJIG+Fc9BOKdGknh+/CVp/mG8a+VmToG8vDqe6a2ehTbKtV3lpoDPf4DEybtdVzvYw72QyaerHH1a67636gJkqXHE1zJr+/uB+DoVffCWibTn+TIUGvYJTQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ANyoC5JM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d74678df08so390405ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 23:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706254857; x=1706859657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ+aiqCw3S91Nb4RQKLeQuvPLrZnPOTG3U+KQFNu6UY=;
        b=ANyoC5JMoebZi+vl93GO+8lyYUp/Hok2TgIPvdOMM+xLJbHlRKdsLK6tzRoSaot0lt
         qBHzgy6QEkf9hO5oCw+X5FWbQT6c2yzbB718VaYCVex0NWddmEb/DpMfTfl2SJBOH1lo
         bxgBwqKj8uSPeJZBVu9zBIxNoR0GtMxOeRkLNylqcS1JZAwPgMOFWiWkAwcHURJQaqnm
         pcnAT9a02TabW98dRBgFfzEJvLl/QBsd3JNCRJYd1/cMirwKIsZdrO0NjEMuc9tkIKMm
         Ajaj12vqUtMLKryBjR5c4Q9hARTguXXIJG1XeidWIp3xTZvK1meEY+2/KxgFU4TvT7dH
         Z7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706254857; x=1706859657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ+aiqCw3S91Nb4RQKLeQuvPLrZnPOTG3U+KQFNu6UY=;
        b=l1/A/JTd7325zsFk8GZlUPpsV4GXMiknOkuPJicAPsmlxU8hOed1q1rgrmFo8Dkmo3
         l9FIf+qduIDhSoQP3t5V4PqPMLE8qyxfFVUULNBS3JzLKj27HRTOfBo0B2c8Xdvi2VkR
         zVos6HXd1HRJq1gSQay21vZXUSH7KlyNX/5NtZEdktj/hYKep7C86IlgZF5v9NF5owYG
         zBDrag+F8btTiCboiTtIaEE6dlec7bVNG/7ulVKdJ7t/M0UgziPY6nykwCVOl1ebhj77
         V8NQmg7ETw/sR1AU2aU+4odpZPDEiWWpsDYhSUwLQH3chYSioKk1sRcLXmVMsRu+mck4
         RLGw==
X-Gm-Message-State: AOJu0YwFNPtwA90LI2ve3+HBScInsZXEbbUy9f75fA8hWrZrTTqX+Tw2
	qmvA0IGuk/pbhIPUYCBkNLJcPDj8kva7t0IXt9OMCIdSROz/4AlPggnecdLEfmw=
X-Google-Smtp-Source: AGHT+IHqTLNd6hNMspVuKkxKRoQYn887EIsVxZCUB2eyX6Bk3ZwnMVua+oVZcHYpUkjOWXYgiAkNWQ==
X-Received: by 2002:a17:902:ecc5:b0:1d7:7af5:1f7a with SMTP id a5-20020a170902ecc500b001d77af51f7amr873431plh.49.1706254856695;
        Thu, 25 Jan 2024 23:40:56 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001d4816958c2sm521066plf.166.2024.01.25.23.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 23:40:56 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de
Cc: vincent.chen@sifive.com,
	zong.li@sifive.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v8 1/3] riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's active-low properties
Date: Fri, 26 Jan 2024 15:40:43 +0800
Message-ID: <20240126074045.20159-2-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240126074045.20159-1-nylon.chen@sifive.com>
References: <20240126074045.20159-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removes the active-low properties of the PWM-controlled LEDs in
the HiFive Unmatched device tree.

The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf [1]

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 12 ++++--------
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 900a50526d77..06731b8c7bc3 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -49,32 +49,28 @@ led-controller {
 		compatible = "pwm-leds";
 
 		led-d1 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d1";
 		};
 
 		led-d2 {
-			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 1 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d2";
 		};
 
 		led-d3 {
-			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 2 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d3";
 		};
 
 		led-d4 {
-			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 3 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d4";
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 07387f9c135c..b328ee80693f 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -51,8 +51,7 @@ led-controller-1 {
 		compatible = "pwm-leds";
 
 		led-d12 {
-			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
-			active-low;
+			pwms = <&pwm0 0 7812500 0>;
 			color = <LED_COLOR_ID_GREEN>;
 			max-brightness = <255>;
 			label = "d12";
@@ -68,20 +67,17 @@ multi-led {
 			label = "d2";
 
 			led-red {
-				pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 2 7812500 0>;
 				color = <LED_COLOR_ID_RED>;
 			};
 
 			led-green {
-				pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 1 7812500 0>;
 				color = <LED_COLOR_ID_GREEN>;
 			};
 
 			led-blue {
-				pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
-				active-low;
+				pwms = <&pwm0 3 7812500 0>;
 				color = <LED_COLOR_ID_BLUE>;
 			};
 		};
-- 
2.42.0


