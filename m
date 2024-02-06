Return-Path: <linux-kernel+bounces-55390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E984BC1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCED2844A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF71A5BA;
	Tue,  6 Feb 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNEdB704"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D017732;
	Tue,  6 Feb 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240791; cv=none; b=gPPTJ4d2Sy6uCspMyZmS5BhmvXvpwTcsqpW12cQ+QYzrWSx36g7WwNTMJNzM85QAJq9bcwTI+7dvTf11lrH0l0QeN6IyBeXPJfVeDPNHaoeRe/fD2kWeXYQNGRksmwlGl0slLEC19A/lIaD3RAi3VH9LVggI+xtYPQ5dKNOGelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240791; c=relaxed/simple;
	bh=flkeDF+JPxHobUBxumlcD1UVCicUGHIenpbz2WlOayE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hq5IfvsXYpKEgHbsvjXaktgLcRFeGMMpO2kpCNUa6kARZFzmo1+VhVQOQMB4MiDGlkZspqy/6dvYiyRclzlEZe6tF0rCJEcmo+6SnhOs0s9futEF68kFKCjmTND57sznm+pjPKVjmn7wmnNPUXJdI93JFPsJef2lrtaFycUsS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNEdB704; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ff940b456so2605165e9.2;
        Tue, 06 Feb 2024 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240788; x=1707845588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+uG+lQkYimwcDSoDF7+dFgWl6aqy23p/8S2SEBQxPM=;
        b=KNEdB704Ccr6aaCJObTjg2pJvnH+wKvGe/55boajbl+an5Q3zTsqoo5uykHZPJDXUH
         jHCGqd98BnyKQcx/4r5pfd3/dl/4W5dJCs5e/p0U5DiEVGgTOSWp7wH9lt/kqDe34Kr0
         exRYsL+GKK2UrI1RdyLxbjEYU6khQHYitNFHOZb3VOj7409aDOxwOZPm3iT27XoihkLB
         4UEup2hwHI1GA1vE+Q3VhSqhf864LtDjh/TbLgaleVnxG5RVMY57GvoeqiYSAx+riBIw
         Miy0HGmOz8LB5wo2ikjLosykjwJVbjIzwY7NT0EQ7JQQWKQWkW1qIEUJKg7Z8XjIN8Fg
         MDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240788; x=1707845588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+uG+lQkYimwcDSoDF7+dFgWl6aqy23p/8S2SEBQxPM=;
        b=XCgGa9JZxTg0veIeTfqkAiehVzPvPkLgGwRnUCc3391gR7NJoxvbyxwGTEe4FG6yqv
         kmPO+yf0o9dqlCjpFNgpxp7OJm2lflGUknDTtQoPvq0cCLIolY/wHNsBDJFXUpZFywbl
         91OhiTBE9bCDn4uTcqjgDnqKWK7z59CpODqA0xVXh09z7LgYndFp8WkrncPOMApxvMmM
         TXNbJUotzGcsGad2hgJCWV4R6ZH0+Npjq369O/9DhvTjs6Jeg7ZcqcaKI2uDVPArU0Cn
         Y8hY2HJrUHVZf04FUBMB3SFNRHQVUnBdgUdJh0wdF22NgjcAr26EP8e1tYZaX9r6cQ/C
         FgpQ==
X-Gm-Message-State: AOJu0YzZ8rAGs/HK23xmBIpnuMq9IL5zpaRro3mDwlAyMArJ2dnCugUf
	YzwGC6afpiRruFuxGAseU1SQPMgGT+271vlRGMV7nPO7P72kVM/b
X-Google-Smtp-Source: AGHT+IFbCZv69DwUpO6qHOUHgRexl8jEpdoXQLUYOqVAEI71O7CQcuLfBwltjTQgrvwRdaC84ZPztQ==
X-Received: by 2002:a05:600c:4688:b0:40f:d1e4:6074 with SMTP id p8-20020a05600c468800b0040fd1e46074mr2242189wmo.8.1707240787879;
        Tue, 06 Feb 2024 09:33:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHyAcLL2ixuJVTpL+nIbjE2McS9pDDJMfhKKcn6mrAQn1ZTLIAPIbd6rpWkRmd6MH+b14aF4HSI0I5pVAYbYGYra1YJdgkxP3hiQUMS24SV7AD6eVT6FZJNdYhHcOkivBrREdMCk/KxdTzUoqDLHjyrxK6xMGbKdesNIT2J4wRykvs0zEW6HYcpagp93iIR/CB61tYHhIL+vjSJ+2gPk5/uQRNMElArMGXILoGfkfYR5LDTrkrPaN5wgEUxZjPQVA5VEdsGk6aCZQ71w0J4CUGuSf51Bb3TpQyuzbjCn8/DLtKzBe/n15U+1nqtV0HC90tF9iUt2Iu5c5H3XnMlShBEm8KAvSn9gCrN7luv1ChiJx/2T0VNa++FkOui6cxQgy37Z9nYq8UMoQAdk4z0pTKfbqfb56echUmgfeKi6LR/W5sD98NBUJ91ExEvx4iemw8oy5dYvOYVpXIRk4QnsbkUG2lp4OE8FOx6/G3uN3bs3ls3OuDZ9E3FhPCD8ZF/8HJJBjTJzUpRRj8Fao/3BoFB1FP0fYJWgIhe+alOu44VBWaufLiO0tCu0IIBY6FMvnlkZhyaHkARd604ZTYDCQ05fs9Pgli+ZzOoVQWKAfOP63Yet7D/KiWG5RiOtK9mBiUpT8uXb6gjg7PPFOIaT5FjXoFJOXOwUfcQh4WYSmvNmaIRTkcBw==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:33:06 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 08/10] net: phy: qcom: move common qca808x LED define to shared header
Date: Tue,  6 Feb 2024 18:31:11 +0100
Message-ID: <20240206173115.7654-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED implementation of qca808x and qca807x is the same but qca807x
supports also Fiber port and have different hw control bits for Fiber
port.

In preparation for qca807x introduction, move all the common define to
shared header.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 65 ----------------------------------
 drivers/net/phy/qcom/qcom.h    | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8377325f157e..f1edff6b6bfc 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -62,29 +62,6 @@
 #define QCA808X_DBG_AN_TEST			0xb
 #define QCA808X_HIBERNATION_EN			BIT(15)
 
-#define QCA808X_MMD7_LED_GLOBAL			0x8073
-#define QCA808X_LED_BLINK_1			GENMASK(11, 6)
-#define QCA808X_LED_BLINK_2			GENMASK(5, 0)
-/* Values are the same for both BLINK_1 and BLINK_2 */
-#define QCA808X_LED_BLINK_FREQ_MASK		GENMASK(5, 3)
-#define QCA808X_LED_BLINK_FREQ_2HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x0)
-#define QCA808X_LED_BLINK_FREQ_4HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x1)
-#define QCA808X_LED_BLINK_FREQ_8HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x2)
-#define QCA808X_LED_BLINK_FREQ_16HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x3)
-#define QCA808X_LED_BLINK_FREQ_32HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x4)
-#define QCA808X_LED_BLINK_FREQ_64HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x5)
-#define QCA808X_LED_BLINK_FREQ_128HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x6)
-#define QCA808X_LED_BLINK_FREQ_256HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x7)
-#define QCA808X_LED_BLINK_DUTY_MASK		GENMASK(2, 0)
-#define QCA808X_LED_BLINK_DUTY_50_50		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x0)
-#define QCA808X_LED_BLINK_DUTY_75_25		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x1)
-#define QCA808X_LED_BLINK_DUTY_25_75		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x2)
-#define QCA808X_LED_BLINK_DUTY_33_67		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x3)
-#define QCA808X_LED_BLINK_DUTY_67_33		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x4)
-#define QCA808X_LED_BLINK_DUTY_17_83		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x5)
-#define QCA808X_LED_BLINK_DUTY_83_17		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x6)
-#define QCA808X_LED_BLINK_DUTY_8_92		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x7)
-
 #define QCA808X_MMD7_LED2_CTRL			0x8074
 #define QCA808X_MMD7_LED2_FORCE_CTRL		0x8075
 #define QCA808X_MMD7_LED1_CTRL			0x8076
@@ -92,51 +69,9 @@
 #define QCA808X_MMD7_LED0_CTRL			0x8078
 #define QCA808X_MMD7_LED_CTRL(x)		(0x8078 - ((x) * 2))
 
-/* LED hw control pattern is the same for every LED */
-#define QCA808X_LED_PATTERN_MASK		GENMASK(15, 0)
-#define QCA808X_LED_SPEED2500_ON		BIT(15)
-#define QCA808X_LED_SPEED2500_BLINK		BIT(14)
-/* Follow blink trigger even if duplex or speed condition doesn't match */
-#define QCA808X_LED_BLINK_CHECK_BYPASS		BIT(13)
-#define QCA808X_LED_FULL_DUPLEX_ON		BIT(12)
-#define QCA808X_LED_HALF_DUPLEX_ON		BIT(11)
-#define QCA808X_LED_TX_BLINK			BIT(10)
-#define QCA808X_LED_RX_BLINK			BIT(9)
-#define QCA808X_LED_TX_ON_10MS			BIT(8)
-#define QCA808X_LED_RX_ON_10MS			BIT(7)
-#define QCA808X_LED_SPEED1000_ON		BIT(6)
-#define QCA808X_LED_SPEED100_ON			BIT(5)
-#define QCA808X_LED_SPEED10_ON			BIT(4)
-#define QCA808X_LED_COLLISION_BLINK		BIT(3)
-#define QCA808X_LED_SPEED1000_BLINK		BIT(2)
-#define QCA808X_LED_SPEED100_BLINK		BIT(1)
-#define QCA808X_LED_SPEED10_BLINK		BIT(0)
-
 #define QCA808X_MMD7_LED0_FORCE_CTRL		0x8079
 #define QCA808X_MMD7_LED_FORCE_CTRL(x)		(0x8079 - ((x) * 2))
 
-/* LED force ctrl is the same for every LED
- * No documentation exist for this, not even internal one
- * with NDA as QCOM gives only info about configuring
- * hw control pattern rules and doesn't indicate any way
- * to force the LED to specific mode.
- * These define comes from reverse and testing and maybe
- * lack of some info or some info are not entirely correct.
- * For the basic LED control and hw control these finding
- * are enough to support LED control in all the required APIs.
- *
- * On doing some comparison with implementation with qca807x,
- * it was found that it's 1:1 equal to it and confirms all the
- * reverse done. It was also found further specification with the
- * force mode and the blink modes.
- */
-#define QCA808X_LED_FORCE_EN			BIT(15)
-#define QCA808X_LED_FORCE_MODE_MASK		GENMASK(14, 13)
-#define QCA808X_LED_FORCE_BLINK_1		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x3)
-#define QCA808X_LED_FORCE_BLINK_2		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x2)
-#define QCA808X_LED_FORCE_ON			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x1)
-#define QCA808X_LED_FORCE_OFF			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x0)
-
 #define QCA808X_MMD7_LED_POLARITY_CTRL		0x901a
 /* QSDK sets by default 0x46 to this reg that sets BIT 6 for
  * LED to active high. It's not clear what BIT 3 and BIT 4 does.
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index dc259bbf0678..9e24997c355f 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -103,6 +103,71 @@
 /* Added for reference of existence but should be handled by wait_for_completion already */
 #define QCA808X_CDT_STATUS_STAT_BUSY		(BIT(1) | BIT(3))
 
+#define QCA808X_MMD7_LED_GLOBAL			0x8073
+#define QCA808X_LED_BLINK_1			GENMASK(11, 6)
+#define QCA808X_LED_BLINK_2			GENMASK(5, 0)
+/* Values are the same for both BLINK_1 and BLINK_2 */
+#define QCA808X_LED_BLINK_FREQ_MASK		GENMASK(5, 3)
+#define QCA808X_LED_BLINK_FREQ_2HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x0)
+#define QCA808X_LED_BLINK_FREQ_4HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x1)
+#define QCA808X_LED_BLINK_FREQ_8HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x2)
+#define QCA808X_LED_BLINK_FREQ_16HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x3)
+#define QCA808X_LED_BLINK_FREQ_32HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x4)
+#define QCA808X_LED_BLINK_FREQ_64HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x5)
+#define QCA808X_LED_BLINK_FREQ_128HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x6)
+#define QCA808X_LED_BLINK_FREQ_256HZ		FIELD_PREP(QCA808X_LED_BLINK_FREQ_MASK, 0x7)
+#define QCA808X_LED_BLINK_DUTY_MASK		GENMASK(2, 0)
+#define QCA808X_LED_BLINK_DUTY_50_50		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x0)
+#define QCA808X_LED_BLINK_DUTY_75_25		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x1)
+#define QCA808X_LED_BLINK_DUTY_25_75		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x2)
+#define QCA808X_LED_BLINK_DUTY_33_67		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x3)
+#define QCA808X_LED_BLINK_DUTY_67_33		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x4)
+#define QCA808X_LED_BLINK_DUTY_17_83		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x5)
+#define QCA808X_LED_BLINK_DUTY_83_17		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x6)
+#define QCA808X_LED_BLINK_DUTY_8_92		FIELD_PREP(QCA808X_LED_BLINK_DUTY_MASK, 0x7)
+
+/* LED hw control pattern is the same for every LED */
+#define QCA808X_LED_PATTERN_MASK		GENMASK(15, 0)
+#define QCA808X_LED_SPEED2500_ON		BIT(15)
+#define QCA808X_LED_SPEED2500_BLINK		BIT(14)
+/* Follow blink trigger even if duplex or speed condition doesn't match */
+#define QCA808X_LED_BLINK_CHECK_BYPASS		BIT(13)
+#define QCA808X_LED_FULL_DUPLEX_ON		BIT(12)
+#define QCA808X_LED_HALF_DUPLEX_ON		BIT(11)
+#define QCA808X_LED_TX_BLINK			BIT(10)
+#define QCA808X_LED_RX_BLINK			BIT(9)
+#define QCA808X_LED_TX_ON_10MS			BIT(8)
+#define QCA808X_LED_RX_ON_10MS			BIT(7)
+#define QCA808X_LED_SPEED1000_ON		BIT(6)
+#define QCA808X_LED_SPEED100_ON			BIT(5)
+#define QCA808X_LED_SPEED10_ON			BIT(4)
+#define QCA808X_LED_COLLISION_BLINK		BIT(3)
+#define QCA808X_LED_SPEED1000_BLINK		BIT(2)
+#define QCA808X_LED_SPEED100_BLINK		BIT(1)
+#define QCA808X_LED_SPEED10_BLINK		BIT(0)
+
+/* LED force ctrl is the same for every LED
+ * No documentation exist for this, not even internal one
+ * with NDA as QCOM gives only info about configuring
+ * hw control pattern rules and doesn't indicate any way
+ * to force the LED to specific mode.
+ * These define comes from reverse and testing and maybe
+ * lack of some info or some info are not entirely correct.
+ * For the basic LED control and hw control these finding
+ * are enough to support LED control in all the required APIs.
+ *
+ * On doing some comparison with implementation with qca807x,
+ * it was found that it's 1:1 equal to it and confirms all the
+ * reverse done. It was also found further specification with the
+ * force mode and the blink modes.
+ */
+#define QCA808X_LED_FORCE_EN			BIT(15)
+#define QCA808X_LED_FORCE_MODE_MASK		GENMASK(14, 13)
+#define QCA808X_LED_FORCE_BLINK_1		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x3)
+#define QCA808X_LED_FORCE_BLINK_2		FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x2)
+#define QCA808X_LED_FORCE_ON			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x1)
+#define QCA808X_LED_FORCE_OFF			FIELD_PREP(QCA808X_LED_FORCE_MODE_MASK, 0x0)
+
 #define AT803X_LOC_MAC_ADDR_0_15_OFFSET		0x804C
 #define AT803X_LOC_MAC_ADDR_16_31_OFFSET	0x804B
 #define AT803X_LOC_MAC_ADDR_32_47_OFFSET	0x804A
-- 
2.43.0


