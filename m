Return-Path: <linux-kernel+bounces-155887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33168AF889
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0752853A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0C143891;
	Tue, 23 Apr 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XD2/a67G"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1914388A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905441; cv=none; b=iY2bzZp29+9uwggArISRQWdtYuMHThllpx/OMR+dl8B4JIdUEeFK3M0k2XYmGYHrIuiNwiy9C2akcWaUQmFWhZPZfXSQIkjkRK8jhLerydSXXn4dTr6z9187kAkT4RAiW2o8RMocqtlONkJ5I+fj9bggs0LtvZLI9hom6oDFtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905441; c=relaxed/simple;
	bh=IMYKiq52emn3Dk5Vs4D46brLTo3TfZSVtNkXv8osBGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSMB/u/hghBo1GDHwlCoYVVFeaLPoN5Q1t+fQ8nQ3PfGez6lONwoM3EI9tNAl1GyeytB/nftVelfS5OTi14JaSQzjQm+9xVbuIbr7vx4F/PwyhSJ3K5COrND+c47KfoNYTQWDAb3B9ZO+Iok29L79rOnc3+9et4ULEbPSgRMrVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XD2/a67G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41ac4cd7a1cso7777675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905438; x=1714510238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InFnIY+p533KdBP4NACQo0sZ0V7hrv1Ldx+BeIELt2w=;
        b=XD2/a67GFAI35JBE+U+pYbkE+dHl31lotCNQbebR20nCvME+hdN9cBvugiVzqr5heV
         EDJLPQ4kjtNEgDUxDOokYNdeBQDC0CXsHuoIaX3p8i1r3wcW4Ih9ZmM0fmmc6J4+51ZR
         0Vd88T4wemN0kfVJ2NWp+VauOfSJahbui86ekCibbIGpDkwxJ7K/wh7RAHxyxcfMaVLa
         mJsxxPVcX/Uku5QF6hLQcpkHuyQW+2V6PHfMwwLnF4vPYDwfXEFFw57q9wmbMhMKPDc+
         lKsqf3A4mVQBuzsRGD9I3skRq4CBOn3EAKNmmJiv19b1+p7/CWSQ95T+P7Z+/GEtiWV+
         XgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905438; x=1714510238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InFnIY+p533KdBP4NACQo0sZ0V7hrv1Ldx+BeIELt2w=;
        b=uDbfHIktUlKjViAaYyJjV75FqorOwGjtMk9yrYdg1h/C2Rvc9EDEMUtqmtVLSG45wT
         iLXdGURZ9T0lPb8dUEY6oVkoaG+msE1axSdD3sGR+P8rbTbRMAMF6UARByqVxUOPVhSJ
         aba6C+UQ4uOmXTBbfI467iWI5m59400swiRhIVO3hSffKLWAdlUGd9Z3J1Y9Pr82NiLj
         Uv4uxevG+m7/ShX7o/eMHsUpXILD8mkSK21dSdsm8zZJxulUs5i0dmJqvyw6dlALsIeu
         lqKVXcaEHxGxTCg+oURSRQJNlkdO+tPxODCl3P2myKeRVjcc4YvykIhGukt/maCGvuPc
         hMZA==
X-Forwarded-Encrypted: i=1; AJvYcCVhzCE7MnslSl4y0pVo+CRtVf5SsK5XcZqMsSJd3MJuSW9Qyb7ecT6vs7KoOnGhYfXHekBP+XVpQqv0tmZqwQxYeb+RS385LLnk+/8W
X-Gm-Message-State: AOJu0YzY6EyFm2wedvXwIRUc3KWcprKcoRXSRVZWfDsaPZvjQukFKEzJ
	vl5IpL05LT4giOvCM3EOgBdYe+UketeK7so3qJNpbBfKb0vgqRzLhRxi3KJlWb9+UKKpONnCiWY
	Ri78=
X-Google-Smtp-Source: AGHT+IFwW0Qe2OJNFDAP49c6EJtw+kAQOSHqygzMmmEvDFQ3fb8+GmSzGKcIdG4RXGhib6lwlZrI8Q==
X-Received: by 2002:a05:600c:5405:b0:41a:a08f:2696 with SMTP id he5-20020a05600c540500b0041aa08f2696mr310906wmb.12.1713905438258;
        Tue, 23 Apr 2024 13:50:38 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:4269:2542:5a09:9ca1])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm13065443wmb.41.2024.04.23.13.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:50:37 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 13/14] phy: samsung-ufs: ufs: remove superfluous mfd/syscon.h header
Date: Tue, 23 Apr 2024 21:50:05 +0100
Message-ID: <20240423205006.1785138-14-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240423205006.1785138-1-peter.griffin@linaro.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mfd/syscon.h header is no longer required since the update to
exynos_get_pmu_regmap_by_phandle() api.

Fixes: f2c6d0fa197a ("phy: samsung-ufs: use exynos_get_pmu_regmap_by_phandle() to obtain PMU regmap")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 813bce47121d..ffc46c953ed6 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
-- 
2.44.0.769.g3c40516874-goog


