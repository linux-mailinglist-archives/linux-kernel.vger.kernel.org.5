Return-Path: <linux-kernel+bounces-131015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F58981F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A722F1F273F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D6B56B66;
	Thu,  4 Apr 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhZo5lNE"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C09E548F1;
	Thu,  4 Apr 2024 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214893; cv=none; b=HUrYkLZjWcW9IlXHHYcZBbjIrj6Z/YoFONRBANl/dtZS9ojfkXWWk1atSB6Ru+3NxHEqWp3Vz2I6jOFKmqVFvMGsvhEELrsWgt1VMmaEmePdWqqt42z7HXUk83CpEe4BdUDZQKvOG0e19zHiesSWEOZfLaw82C2RuJTAqKws0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214893; c=relaxed/simple;
	bh=0bCffHZydn92x8yoNUXuHk+MA8fJZmpo7AjWbrkLjnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8gv5RKoPyIaN1Srp4sdOUNWD+34Y+d5YVhtd1n4n3g2b5CKijwifSfgNSL2y278CGWtH0jFb5dmkrwbADlhTo9frhEZPdLKac15Ez/xccxq5q+y5/umaA+YMhG1ZyOH88MWPJp/Gl+P97xgKbG/ZPCIWFIhTAiIxBuPxcVuhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhZo5lNE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e709e0c123so563174b3a.1;
        Thu, 04 Apr 2024 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214891; x=1712819691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPsiPELCBmPe+inzzwVVOC2M0IyyDSE04BMeZYanz5U=;
        b=EhZo5lNEZTKmNt2pPaqRzICEP3DiaZ9rJk5WLcu7RRi44ltMTerLOmZf2LmeBZMzQH
         lItpmypOvpU5k2dknF7XjHMePoxUMsdYLCKe3rJsjFtlAkgR5vDdHc1AlXVHFXMu96op
         vplcX0FQIdRSroWBrUvwkCw7td2uV1rXPBvdR6rUinTsJwSH37sJSsOOBg++KPReZNW7
         z3Qi2HvshGaYPtPgeVTXELyCk0xxQBAUN8ZMhupCBV3PZy+ZjVQxwyKui+IjWijTSABH
         ariSbNhJpglRftsQOw/L5KMd9f3O0A9yOksarUajVVGmofYpTRGYjrI20skRCWM+acfa
         f+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214891; x=1712819691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPsiPELCBmPe+inzzwVVOC2M0IyyDSE04BMeZYanz5U=;
        b=Jonw7l+KhaOUTzTC9jsYXXdDBN0rMCtVTxk3F+1Dk+OwVoeh2YYqeObi5sWhmaZpia
         qZKA9U2BDXXDY6hhQrd9+zqYSLsc2C4EE8gGBMEKX45DvaUOwS7UGfwfedRf1n4XhetV
         xSFhIFiBK5KWnFPMD+X6yPGgFpY4nNPXj2HgNZ9+FpM7/S0+mafkXesHGRcoN+QZAdi1
         jNdxbEg5a24fnBRMscb8UjBNxO95v9U3uyVP39EgGcabpOJ75uZOrLBhn9JerrIO0rHP
         sq/D6WhwpGpyDE9EroaFDh8SN/VpUu2HSAFTntdOrPkUwmlqDNUfWuh2JHY/deSAGDuu
         +AHw==
X-Forwarded-Encrypted: i=1; AJvYcCW5LOmQDOjo+Yn8qavgpywm6f116taAI7cqThSUVFP12JK5ZuxxAJX80qL7laS1rGZdgsrN5qhR6pJGvT+BufoPQhRwYBejpLAqGVIRZtSk14XlNiqpvVr9k4+IQxwzLSINDD3FKxqwN5aAFy3znQEEve8dLkYayFG9AeQr7J2VrgMqcRNiMx9zByE=
X-Gm-Message-State: AOJu0Yy0gRS5Nd+N24tX+xq8qf5OE5SA2OauxQzLlcLL32U7NNJWkeZu
	ikeEjc0GzKnr3VysaDAlSTON2EAI5AvFx2cdQ9/iLUDZtbCIx/te
X-Google-Smtp-Source: AGHT+IEOUU0nmmBZv0QGpPzeOsGA0kvWFTC8435Koof082b4jzgNWQOx1hwsm6KroWSjntyQkUqNXg==
X-Received: by 2002:a05:6a20:8407:b0:1a3:4863:f70e with SMTP id c7-20020a056a20840700b001a34863f70emr1909375pzd.46.1712214891652;
        Thu, 04 Apr 2024 00:14:51 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f2d400b001e26c4823d0sm5220873plc.52.2024.04.04.00.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:14:51 -0700 (PDT)
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
Subject: [PATCH v2 1/6] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
Date: Thu,  4 Apr 2024 12:43:17 +0530
Message-ID: <20240404071350.4242-2-linux.amoon@gmail.com>
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

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2: drop the clk_disable_unprepare in suspend/resume functions
    fix the usb_put_hcd return before the devm_clk_get_enabled
---
 drivers/usb/host/ehci-exynos.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index f644b131cc0b..f00bfd0b13dc 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -159,20 +159,15 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 
 	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
 	if (err)
-		goto fail_clk;
-
-	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
+		goto fail_io;
 
+	exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
 	if (IS_ERR(exynos_ehci->clk)) {
-		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
-		err = PTR_ERR(exynos_ehci->clk);
-		goto fail_clk;
+		usb_put_hcd(hcd);
+		return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk),
+				  "Failed to get usbhost clock\n");
 	}
 
-	err = clk_prepare_enable(exynos_ehci->clk);
-	if (err)
-		goto fail_clk;
-
 	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		err = PTR_ERR(hcd->regs);
@@ -223,8 +218,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
 	exynos_ehci_phy_disable(&pdev->dev);
 	pdev->dev.of_node = exynos_ehci->of_node;
 fail_io:
-	clk_disable_unprepare(exynos_ehci->clk);
-fail_clk:
 	usb_put_hcd(hcd);
 	return err;
 }
@@ -240,8 +233,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 
 	exynos_ehci_phy_disable(&pdev->dev);
 
-	clk_disable_unprepare(exynos_ehci->clk);
-
 	usb_put_hcd(hcd);
 }
 
-- 
2.44.0


