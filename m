Return-Path: <linux-kernel+bounces-131022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9089820D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DBB1C25C04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6A6D1BD;
	Thu,  4 Apr 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Dm2VgC"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D66CDD8;
	Thu,  4 Apr 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214931; cv=none; b=YBX2WY+EXH3Ekr8xdobdopOA/J7EMoyGcutBvBKOcncUdaWnNIPgq1so6VNpqQqxY0Rq1V4MA44PQUbQQnhtum5eGzezmnr1m2gIeOfK7aEMn4p5xR9u+l6aAkk3l8b3J9X+TvmwADIaiiqRDDM6Fweu7g+CZ+037ZbJQ8ccchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214931; c=relaxed/simple;
	bh=D9m1RLiyFGpECVoIEX1Hn7WeagTQyO17nLGEaIGv/pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwSFM8OI5Ij+RrSj4+kdYxiuNbA7k8Q3eLcO7dqXH5azpsE3GdbVJmgE7PlkmH4oXZCe36fIQx7HyWtd5pDUO9l5n3WyYdPVfGKXKBeKfRC12uvvv2Syv2FK3GwasLF1MJrJsp7pbeYj+X5JLf1/DTGaqyD1CkJruhKAGojpX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Dm2VgC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0878b76f3so5937615ad.0;
        Thu, 04 Apr 2024 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214929; x=1712819729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J37xgQA9uGX+wBOKJnojy8QxNGELdhvGrNPpqIWXrM4=;
        b=A5Dm2VgCNSZaMm8mZyJfRoECkTADuMibmSN85wyo1TkR2dYQbD9Kfm9mkZ0t2DE3jj
         wkQA51QSVAcr/y+xy//nM/ZGex50UCwfdDPDDB96Je46MQbY9aSOagmhhSVbDw3GScRy
         eAWSfL7H9+zYHlFZutSdieWNkYOvTc1ZICxdCQwg5aytJ7W3DDiT1bwOx2NpXf2gHNqX
         EZSFaUVWBrpZq4g1qXvMrtcF8LuE9OYeTDk1X8n58vv5Bb2SJDMvsFzYkH0784G91tm6
         uNRE3Hp1QDWOB5iv8uANhuzBIO9jI7X6NgPLrRytBqXP65HjBvCNlqiEWF/wnxnkg5t3
         5Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214929; x=1712819729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J37xgQA9uGX+wBOKJnojy8QxNGELdhvGrNPpqIWXrM4=;
        b=L9gxjaTRDi8ZMLnaue2qE5uo9hn+S8tZU7JGeYI6Y2womoxRCnFPMI4gWFC/E7qqTt
         ND3lFFkmVfi/2FN6F1IBGJE4TTA+vA0c7Modq6vAfuO5DEv+KKBPbJ3H4Fai9W7JUVkB
         M/wXjRv6cRyHavGo95FxP5VI2treou7ExKmBpyuN+QcCp/RrHVxqB3aVKSqdwS4tT6c7
         WZuJPVPWwpP0Covk2I7z26rKFmiF67JE3A8Y92va14h81A62AYnkzESy9CdupDghEfCS
         4o9ez51TVyIh3S8WKFdNaUKDcpnl09z6ljCPR14b+jLzYPA17IjJnHj4RoTH3LSl8ndI
         a4UA==
X-Forwarded-Encrypted: i=1; AJvYcCVIhsuVzN9pNiP/5h+o7ljbxSsM0rFg+uoujf4s+kj3Sl+hP1hzezSNAn31VlGQiUjDqDOPROpq2dgOI9cIHgd884gSNShyS7K9Ri+yJ8krdTDxsl04vNp5HGeVG6Sle7n0+TuMT/6ZzHKcsxjrih/bmQfTcFxx5RnJ6ZIW07fZeVuLgP+tx0hdbB0=
X-Gm-Message-State: AOJu0YzMVxibi0wf7G7Skq2z/tH9eSwEigDclZBZ8x2rcBWMrexet0zk
	asQUSqFgtntHmuOCGeBuflBP68XhYbyy4xZ5iGURzggukK6kFYzP
X-Google-Smtp-Source: AGHT+IFho3nsnGV/Vraj6b236VW0aMhIhz4R5zKUYzxQDKs11VTEws5/th4dV0E4KIv3/LNWrhSraQ==
X-Received: by 2002:a17:903:32c8:b0:1e0:b628:a752 with SMTP id i8-20020a17090332c800b001e0b628a752mr6820836plr.7.1712214928864;
        Thu, 04 Apr 2024 00:15:28 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f2d400b001e26c4823d0sm5220873plc.52.2024.04.04.00.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 00:15:28 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Subject: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Thu,  4 Apr 2024 12:43:22 +0530
Message-ID: <20240404071350.4242-7-linux.amoon@gmail.com>
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
automatically dropped by the compiler when CONFIG_PM_SLEEP are disabled,
without having to use #ifdef guards. If CONFIG_PM_SLEEP unused,
they will simply be discarded by the compiler.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM is
   disabled.
---
 drivers/usb/dwc3/dwc3-exynos.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 2d341f0e22a3..90259ad1d0d9 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -161,8 +161,7 @@ static const struct of_device_id exynos_dwc3_match[] = {
 };
 MODULE_DEVICE_TABLE(of, exynos_dwc3_match);
 
-#ifdef CONFIG_PM_SLEEP
-static int dwc3_exynos_suspend(struct device *dev)
+static int __maybe_unused dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
 	int i;
@@ -173,7 +172,7 @@ static int dwc3_exynos_suspend(struct device *dev)
 	return 0;
 }
 
-static int dwc3_exynos_resume(struct device *dev)
+static int __maybe_unused dwc3_exynos_resume(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
 	int i, ret;
@@ -194,18 +193,13 @@ static const struct dev_pm_ops dwc3_exynos_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_exynos_suspend, dwc3_exynos_resume)
 };
 
-#define DEV_PM_OPS	(&dwc3_exynos_dev_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM_SLEEP */
-
 static struct platform_driver dwc3_exynos_driver = {
 	.probe		= dwc3_exynos_probe,
 	.remove_new	= dwc3_exynos_remove,
 	.driver		= {
 		.name	= "exynos-dwc3",
 		.of_match_table = exynos_dwc3_match,
-		.pm	= DEV_PM_OPS,
+		.pm	= pm_sleep_ptr(&dwc3_exynos_dev_pm_ops),
 	},
 };
 
-- 
2.44.0


