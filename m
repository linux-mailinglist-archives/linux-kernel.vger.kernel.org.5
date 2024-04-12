Return-Path: <linux-kernel+bounces-142194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD718A28AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D871C2218D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F3E50298;
	Fri, 12 Apr 2024 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ167ZVk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911545028D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908975; cv=none; b=YQcjT/d+naPtqumyXdtjLPtwAETS9cmrnRxT8YSaHuZWge6aC4eF7d28aDQQaPWFiCPqgjz91sbIuXsej4OqzhysMDc/sPPLw8rAaE4DpVJi6orGovJcy5QiOQMdxq3b14lEh9r0kqo6Vwd3EwjYrRByF/WA3OOCSqcMEvlO51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908975; c=relaxed/simple;
	bh=krFqUqxMYFpZh1tbkYjt3LaFLR2okMC7+AptUzC+lDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCDG0xVCBJwFVrGi0O6KZj68lEOfQS+gUKU5ufsf0/+BdrDWoEC5cYkAvxEZ3tPG23kPZN6WQTxsUhhQG/RK+t0/yE1Z/v8ecLsE9XlX3rza2Y/bzKSifmq+SHseKvFK12vyyXTzyhQT+l7OGBacje4YXSoxPHzo0hxkLFA4C70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ167ZVk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712908972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pz7sr6/1kgAHbwaR8rIkOs2x2hB/0ZeZUDnCetvC4ZQ=;
	b=IJ167ZVkyqaKTQ9RAoAajFEKVTuBRPWoOu5wHEUd/tZf1ZkYeDlg4LvDvdE7wgRzJyeOyG
	4WXfaZHycsElzKfz6rHoUTu2P2O8ideBEMovAIXxvEyORBmA9V6C1sGUx0qB15RKZAboSm
	qYkHYc1WFcXGg48M9qgmp2NGu6JuVlc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-D3uL1TMUPMOb3lXXAvKsmw-1; Fri, 12 Apr 2024 04:02:51 -0400
X-MC-Unique: D3uL1TMUPMOb3lXXAvKsmw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5dc4ffda13fso1391267a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908970; x=1713513770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz7sr6/1kgAHbwaR8rIkOs2x2hB/0ZeZUDnCetvC4ZQ=;
        b=CxeMP8e8j54Ql/qwblmaPll5nvPbhQWRFdoCAadGGcCCXRAuqYebRrzyOC2IbNTeeK
         QErV3s0CH18p1mqXMdEFSDY1a/kvWEjdWDyFPUt8UWWvLBCoR5kyTUov9cKoycl+/BR6
         5h5Uo/3nxlg2yZaOsLK8TUbU4JhEHL3ke+XythR5rfrKkaxy8t3ezpLsTz8NH8KzOqTM
         OTZ1R1u1Mf842OF/ZZD4kB8OnGRLUnO7uthvt9S8AZh0KY9IXadB7SHqYdceByL8HsbD
         jBhqLxywfK9w+n0fy727RHiuIbVjP41/m5OwxFpxDtH3p8+t4MNNQe3Gp+kMlZBN5vFg
         lxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3XRiWigUfagz/f0ty3QipXhzPuHsjqIO3Ai0TwsduO1IUWmywZWefCtncdg0/Qmm9he7VpdBMXJiFJwk3yJX3BVDDR2s8zA1pypoj
X-Gm-Message-State: AOJu0Yx5/fPPzeAvNsFbTX90yaBvsdnDNnbgzba19eI3yiw25uMNBmTz
	HdJDYieBsrl5h+GlCSDD8igzlrZmxiP4bXNTvL0oMi2KtNvricRVkis+1mwQNhPhFYF0+r/bUy7
	zJ4QWz+4Bi7NYSfFwEBfAN/mPJHV0pSc3wXqyhGPbmTfOXDQYOavIeQG+KHX74w==
X-Received: by 2002:a17:90a:4b4e:b0:2a5:6753:98e0 with SMTP id o14-20020a17090a4b4e00b002a5675398e0mr2893963pjl.0.1712908970371;
        Fri, 12 Apr 2024 01:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0opAzUeUMJ2l2tzohRqw1i5Cs00vZK25Zmn1qxqR4RzTaHhyge9+KGBE/PeqC9yl/vyn2GQ==
X-Received: by 2002:a17:90a:4b4e:b0:2a5:6753:98e0 with SMTP id o14-20020a17090a4b4e00b002a5675398e0mr2893945pjl.0.1712908970064;
        Fri, 12 Apr 2024 01:02:50 -0700 (PDT)
Received: from Samantha.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm2601514pjs.6.2024.04.12.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:02:49 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	guoren@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 1/5] drivers/rtc/rtc-xgene: Add prescaler support in APM X-Gene RTC driver
Date: Fri, 12 Apr 2024 16:01:43 +0800
Message-ID: <20240412080238.134191-2-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412080238.134191-1-wefu@redhat.com>
References: <20240412080238.134191-1-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

This patch add Counter Prescaler support in APM X-Gene RTC driver by
getting prescaler (Optional) property value from dtb.

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 drivers/rtc/Kconfig     | 10 ++++++++++
 drivers/rtc/rtc-xgene.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index c63e32d012f2..3a89f1e6095d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1888,6 +1888,16 @@ config RTC_DRV_XGENE
 	  This driver can also be built as a module, if so, the module
 	  will be called "rtc-xgene".
 
+config RTC_DRV_XGENE_PRESCALER
+	bool "Pre-scaler Counter support for APM X-Gene RTC driver"
+	depends on RTC_DRV_XGENE
+	depends on ARCH_THEAD
+	default y
+	help
+	  Say Y here if your Soc has Pre-scaler Counter support on rtc-xgene.
+
+	  This hardware support can only be found in DW_apb_rtc after v2.06a.
+
 config RTC_DRV_PIC32
 	tristate "Microchip PIC32 RTC"
 	depends on MACH_PIC32
diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index f78efc9760c0..4d6f1629b973 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -26,11 +26,13 @@
 #define  RTC_CCR_MASK		BIT(1)
 #define  RTC_CCR_EN		BIT(2)
 #define  RTC_CCR_WEN		BIT(3)
+#define  RTC_CCR_PSCLR_EN	BIT(4)
 #define RTC_STAT		0x10
 #define  RTC_STAT_BIT		BIT(0)
 #define RTC_RSTAT		0x14
 #define RTC_EOI			0x18
 #define RTC_VER			0x1C
+#define RTC_CPSR		0x20
 
 struct xgene_rtc_dev {
 	struct rtc_device *rtc;
@@ -40,6 +42,33 @@ struct xgene_rtc_dev {
 	unsigned int irq_enabled;
 };
 
+static void xgene_rtc_set_prescaler(struct device *dev)
+{
+#ifdef CONFIG_RTC_DRV_XGENE_PRESCALER
+	u32 ccr;
+	u32 prescaler;
+	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
+
+	if (device_property_read_u32(dev, "prescaler", &prescaler)) {
+		dev_warn(dev, "Missing the pre-scaler config for RTC.\n");
+		dev_warn(dev, "The current pre-scaler config is 0x%x.\n",
+			 readl(pdata->csr_base + RTC_CPSR));
+		return;
+	}
+
+	/* The clock source on some platform to RTC is NOT 1HZ,
+	 * so we need to prescale the clock to make the input clock become 1HZ,
+	 * like (clock_source/prescaler) = 1HZ
+	 */
+	writel(prescaler, pdata->csr_base + RTC_CPSR);
+
+	/* enable RTC Prescaler feature in CCR register */
+	ccr = readl(pdata->csr_base + RTC_CCR);
+	ccr |= RTC_CCR_PSCLR_EN;
+	writel(ccr, pdata->csr_base + RTC_CCR);
+#endif /* CONFIG_RTC_DRV_XGENE_PRESCALER */
+}
+
 static int xgene_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct xgene_rtc_dev *pdata = dev_get_drvdata(dev);
@@ -174,6 +203,8 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 	/* Turn on the clock and the crystal */
 	writel(RTC_CCR_EN, pdata->csr_base + RTC_CCR);
 
+	xgene_rtc_set_prescaler(&pdev->dev);
+
 	ret = device_init_wakeup(&pdev->dev, 1);
 	if (ret) {
 		clk_disable_unprepare(pdata->clk);
-- 
2.44.0


