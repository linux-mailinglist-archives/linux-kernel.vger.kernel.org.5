Return-Path: <linux-kernel+bounces-152499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8588ABF5F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580F21F20D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3317C6A;
	Sun, 21 Apr 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvfU1Scv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9E18E3F;
	Sun, 21 Apr 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707320; cv=none; b=IyAiGY/OMFqTpDqU/xvz/VFlxUGvaFxfy4yuzd8TJN1ssgOv4j0T+aJ++eNO5ZqVfSvNPbcUdHKTR4syMxI9biZFnKcPqpNq3RVXxOzGWyUIHZ50XJaQS9OkN2NEPRVO40Q/0zcaDO17Bm7qMDsZ2JuFJhKXlo7eH0jAmlswK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707320; c=relaxed/simple;
	bh=A4OPctYYUH7PuBa9PxvK7F68AY0rYnDxN+Q+bX9qxmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPka2W1cLJ84edcTtImGHLg5ljqQnpOTzVTZSSmKxouLeEgWq9gJNqsDPtlZ1XHU1dw6CxQsbYO5XFA9fiFwmYRZbhSTLyRSpsIx749ezZYo7LrAZ7pcG1ZhEJcyyXpJimYWV5SVWnAdNqJzGUbe/JSIQrURVuz4JN6hnEsH+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvfU1Scv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso2753554b3a.1;
        Sun, 21 Apr 2024 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713707318; x=1714312118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciAsjHwxYvDFWKrK0+bRI8F1DZJnqhJJG3f0Ywfv28Q=;
        b=TvfU1Scv5GFSW+3Y5S6668UXl6IHEQr6kwaUrIYdZgQxK/uP9rO6PI4Gs5bqYds34i
         iBPEit7t29x/LuHUhksnokz36i9x4Wizzea70aXGKMry6fhrOli5QVCbwB2j+dnRB1J3
         L0V1N+VZNaDTGR69Wz+4ey+ggefhCMoxdPwEfhsze5AHRZLBARK/rb3bcL30TEKQFjX/
         lwDqJiAJ3u34XJS+AKiJjzHFvACFHeroe0O3A4Zn624iHSOR7hPrBfpKSL83rmpIqzPD
         HFf7jneVSsJyukRFO1PzqgCzgRSpeVV2OqGzVIiXfuuSUeukUaI/nr2ckPGhemJr5qqA
         fqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713707318; x=1714312118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciAsjHwxYvDFWKrK0+bRI8F1DZJnqhJJG3f0Ywfv28Q=;
        b=AE3vrJyQ7PGICkof0WsRx9Af8N0PDbjG+rb6arXG7k3PtWOVEKUgvztVllwcD+dQ7P
         4duduw5bdBT6dhB8xqQEFbCxeC1eFD0Z9vU71Wcph4AurI2WLCNs502DBKFmaRqtBgaW
         VN79oa/qBDvcMrUr3mRyrODwmaqV0g05HM0YseoK4TXoSMevohneV9QCwqfdrHRgHtp7
         7GulcACXfXyNfBpr1+EeoD1ko47Fx7YgJFUUnc7mvpjYib0f2DIcN3iWBcl1EgFN6dK8
         t+DHUOs9M5cN3apAZh28JG3Jxx2ustFlmweu3AxyLxCe7BjaV2g15NYm0NT+6Ij4OO6c
         7dVA==
X-Forwarded-Encrypted: i=1; AJvYcCVdjqBvb6NAfomk87oCX8P3Ebq1Bj6ijukTNt95oslmtBbl9zHUHGYp3GnDR9vHWN5/WsdrtBK4cAqhqFJ8WhMMsK6PouBNMgnn5cPO5W+u70oKe/uk96Xsfrv6nHZmEd6xhKbqtGNDVXFhPjkACmROFHbzqGCFn/nBJPNg1fifwuClelF7eYeud2w=
X-Gm-Message-State: AOJu0YxR/OQzyUqtxZ+j1OxvCaXQoGma0xTpFQpqEM9XkTydTUgVxbNF
	26jDsjQISXB6NQpOqzSayBT4+iNBZn2WhMTDPsFWurgeH04XYerY
X-Google-Smtp-Source: AGHT+IHfvthUjm2iFzaL1LUjJwU52v8bgHPixb0cyYfYA4lJ9nZLxMwMuG3dGxRPm+KDk4l3Veo7wQ==
X-Received: by 2002:a05:6a00:1390:b0:6ec:f9d3:d0c6 with SMTP id t16-20020a056a00139000b006ecf9d3d0c6mr10380392pfg.16.1713707317822;
        Sun, 21 Apr 2024 06:48:37 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id o13-20020a056a001b4d00b006e6c733bde9sm6175043pfv.155.2024.04.21.06.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 06:48:37 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] usb: ehci-exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date: Sun, 21 Apr 2024 19:17:31 +0530
Message-ID: <20240421134752.2652-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421134752.2652-1-linux.amoon@gmail.com>
References: <20240421134752.2652-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use DEFINE_SIMPLE_DEV_PM_OPS macro to progressively switch from a code
model where PM callbacks are all protected behind CONFIG_PM guards,
to a code model where the PM callbacks are always seen by the compiler,
but discarded if not used.

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v4: rephrase commit message
    add reviewed by RB Alan Stern

v3: fix using new DEFINE_SIMPLE_DEV_PM_OPS PM macro hence
    change the $subject and the commit message

v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM
        is disabled.
---
 drivers/usb/host/ehci-exynos.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index e2303757bc0f..f40bc2a7a124 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -237,7 +237,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
 	usb_put_hcd(hcd);
 }
 
-#ifdef CONFIG_PM
 static int exynos_ehci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -280,15 +279,9 @@ static int exynos_ehci_resume(struct device *dev)
 	ehci_resume(hcd, false);
 	return 0;
 }
-#else
-#define exynos_ehci_suspend	NULL
-#define exynos_ehci_resume	NULL
-#endif
 
-static const struct dev_pm_ops exynos_ehci_pm_ops = {
-	.suspend	= exynos_ehci_suspend,
-	.resume		= exynos_ehci_resume,
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(exynos_ehci_pm_ops,
+				exynos_ehci_suspend, exynos_ehci_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id exynos_ehci_match[] = {
@@ -304,7 +297,7 @@ static struct platform_driver exynos_ehci_driver = {
 	.shutdown	= usb_hcd_platform_shutdown,
 	.driver = {
 		.name	= "exynos-ehci",
-		.pm	= &exynos_ehci_pm_ops,
+		.pm	= pm_ptr(&exynos_ehci_pm_ops),
 		.of_match_table = of_match_ptr(exynos_ehci_match),
 	}
 };
-- 
2.44.0


