Return-Path: <linux-kernel+bounces-131018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81698898200
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E7287A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB15C8FF;
	Thu,  4 Apr 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEtu3kxa"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDC5CDC0;
	Thu,  4 Apr 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214915; cv=none; b=KT2zFCwX+AB1PDh8KLnh44HGgmR9vyRIkPTFu5paKDfDCg/nadIFzECCFuPWMoP+a9ZyNk7Rq5sZywc8NRIxr0GlSDl3yZ3+DIBeYg5j88pSpWq6nmXQmc/rtGkBsPe5HtXeCQPoCe7ZvrhZhJvp82ehiSE/OVpc0/Ui2Y+2xP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214915; c=relaxed/simple;
	bh=XQ53YgJ+KiTfINBFq/O6Z48P14zbeZM01KRRTndoD/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXljbkhr5cO77igl1wcVh/Mht8uS++eZF3BixBrQ8bhUSdIkuft+5Bo8or5fXLDUbastnab5NEjdNbX2z7ka67jcpPsSUAeBy9Y4+CrBH+GXGlXi6i1XC+9qiN2PuJxNqCm31yV5GN4gJghkTWni5KhyB/bdcwRfp6MKhavqpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEtu3kxa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1def89f0cfdso13774335ad.0;
        Thu, 04 Apr 2024 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214914; x=1712819714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXppvwNAhzN97k5Naw+YEyw1OS4lAQ4l14Ygn5h0IzM=;
        b=CEtu3kxaeUGSbXfcb+b/Z0z8AEGg2nbyhEZAv/s+Y0hEIhmAVJosmNFX0CHtVldU4J
         +8UBbQBAjP+zxIz5DE9OlUMk+JwtiEIOSFDTiatUBF1MjtgoB9hHpBB0qot97YMl2OrZ
         nMqCr/IwT6CoGnbLyJfMXpRhQodRH+ZRmL/h2m33MXH5BkJZ779fiEukUDUw6Wi8ikPs
         8uSbrW5ouSh0aN8hRtqoxTeNED9U8dPBRZLGZYFIBdKM1WJnI5g9wKw6L67/3xzR8/Hv
         as+PTNFPP2c4fe1qHNmhJ19onGG6hV457QpY1NvYtLYmkyUqQv1Vk+JqMdTU25mf+P1E
         K7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214914; x=1712819714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXppvwNAhzN97k5Naw+YEyw1OS4lAQ4l14Ygn5h0IzM=;
        b=E/mBYLFvDOEcKihi2BSJsVFDBi1vRJVdDYBdzDfPrh8qBD111rDqZrO9TU+DdRIof6
         QkMu9vR6txPbSPHAKvbAcvxRqctv0MCFzQS3WP83HedX5BWF/9C2fDJO4RVPNkegrv6g
         O3rlQ4NE2wJ35t7Doyt5BrjL6/ZC5ZmaXfYr/cVJj0U0VeOMAPMBHNonuTRpmMO7W4Lm
         b1fbVVKL3DVX3FRL5BclsjCJ7/dsRjwWbnaw2FoR2jO8AUel5SPifyDqZZlewMUJLOFT
         eokM5ZmZngDFV0dnq8BmT4g1NZRYZnsgkJLOQUEvYTXLhWTqF+2r+58Sq4Iy6s5vlmha
         LDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1h/NVeG+5n8XqEij4/6MPw5+4pZx3VL8IwALrx+Qjq9nSwQbMLLXySLjlF4eShqMJ8MYZTno/FBP5WBsK1zrG9KahrO18fblEnp9lzgGOXv6kNHeyWT0D7MAOOYrtGcaJyL9WyNTufAWriXw1v861UiZFdvKGwSMQRdhdVB7ApQlGDujcL2sGgXA=
X-Gm-Message-State: AOJu0YzN5qFTE3PIfEkxTx0sfIVyYhxdaGoEUWrTwAaWEs6RSxrtWnSH
	6W7RDqUMFCWwqy0bb0ruSQsDcYOqswg9SCC1YAgGe1+LRF/dMJIs
X-Google-Smtp-Source: AGHT+IG026jtHHMrN+DwLrmD2VL2UxEvIawtAyzH9cBcIzRtMNoZHVr0l8h2fdo3y1I/kj5sABCjBA==
X-Received: by 2002:a17:903:2350:b0:1e2:908f:5d6c with SMTP id c16-20020a170903235000b001e2908f5d6cmr2692549plh.10.1712214913748;
        Thu, 04 Apr 2024 00:15:13 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f2d400b001e26c4823d0sm5220873plc.52.2024.04.04.00.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:15:13 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] usb: ohci-exynos: Switch from CONFIG_PM guards to pm_ptr()
Date: Thu,  4 Apr 2024 12:43:20 +0530
Message-ID: <20240404071350.4242-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404071350.4242-1-linux.amoon@gmail.com>
References: <20240404071350.4242-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM are disabled,
without having to use #ifdef guards. If CONFIG_PM unused,
they will simply be discarded by the compiler.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: new changes in this series.
---
 drivers/usb/host/ohci-exynos.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 85d04ae0ae40..3e647e0b341d 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -212,8 +212,7 @@ static void exynos_ohci_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
-#ifdef CONFIG_PM
-static int exynos_ohci_suspend(struct device *dev)
+static int __maybe_unused exynos_ohci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
@@ -230,7 +229,7 @@ static int exynos_ohci_suspend(struct device *dev)
 	return 0;
 }
 
-static int exynos_ohci_resume(struct device *dev)
+static int __maybe_unused exynos_ohci_resume(struct device *dev)
 {
 	struct usb_hcd *hcd			= dev_get_drvdata(dev);
 	struct exynos_ohci_hcd *exynos_ohci	= to_exynos_ohci(hcd);
@@ -249,10 +248,6 @@ static int exynos_ohci_resume(struct device *dev)
 
 	return 0;
 }
-#else
-#define exynos_ohci_suspend	NULL
-#define exynos_ohci_resume	NULL
-#endif
 
 static const struct ohci_driver_overrides exynos_overrides __initconst = {
 	.extra_priv_size =	sizeof(struct exynos_ohci_hcd),
@@ -277,7 +272,7 @@ static struct platform_driver exynos_ohci_driver = {
 	.shutdown	= exynos_ohci_shutdown,
 	.driver = {
 		.name	= "exynos-ohci",
-		.pm	= &exynos_ohci_pm_ops,
+		.pm	= pm_ptr(&exynos_ohci_pm_ops),
 		.of_match_table	= of_match_ptr(exynos_ohci_match),
 	}
 };
-- 
2.44.0


