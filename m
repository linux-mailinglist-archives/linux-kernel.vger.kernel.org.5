Return-Path: <linux-kernel+bounces-163585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B364F8B6D56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52DB1C2275E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B71199E8C;
	Tue, 30 Apr 2024 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ncvnNbKg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65E1836D1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466996; cv=none; b=trpzaci28DBtz+3S2PXRE57KlcmO4yg2SdQYV6Ig2mpgaDfvn4KnvuhkLnSHdvCJfCTfxHhb8dnYmbQ1xBEMNmnqDTcqaWPmITzGqND/RQ2+PN1vH9tbKis+7/LK2Ir9iexpeIuXp/GEYsgBfLEoZ3YZWZ3eqqPoWQ5N9d7tid4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466996; c=relaxed/simple;
	bh=iXPUW+LMiLWKSkHuVzYEAwqx5NsEndDBUymwE5N4n08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NeQZ90G1A82qv8z7dGcoGwtBzOyvsXTKnsJyMyeOWCoTQLtmEJchkpzVQZOz57zAGABAwrprnDAdB3sIEp7JEUFP2Gvm8LpsRe/NIpVYDyIcOzx1YYlLqlpT6peCPy35wm/Qv1dMOhXCGGrG/rBonsFn+NDd0zxKlhl8YryIx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ncvnNbKg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so36537415e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466993; x=1715071793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7ToIquEsTKSJQB0TYH115XKJn8YP40pUtTUrKsmnKY=;
        b=ncvnNbKgO/43LTHr2tYqGeZXS/6ynzW5XyjrSiNaDU+AOhZ50C+v9YR8ErtJuqyYto
         FK6a8sc0VZeEJO9Tywer3wS8Iv37Zni+x2tFOIB8j5TkajaHqab+OfafnYE3gK1k5zG2
         zSAK/PjsnirxJ9pjiInkQo6oyxH8R6jkj5J6kwDWOzJQVA880C5JW9JvDTmw6FCCr1wF
         ny3WnEJJjPktWO7nJEua0CXRqWaiCM6Da03j+HXituROxcb317v0AlwM6ZQtZNUObqaC
         Fhs0XQ1fmD8BJhuzmh3U1bIfRBV/IzgTvt6botqdfPLwqX8WwkNFopgPXzB5vuMKRg75
         US4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466993; x=1715071793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7ToIquEsTKSJQB0TYH115XKJn8YP40pUtTUrKsmnKY=;
        b=VVxU+j/SajPktBMtxQ3pAa1Rd1gcO6Y5Zra2s15zn2tGI/tza3urmnOj7vDMsThKCk
         SrOfKbsE3a45nFzxJN9MG+1vL3V/kAoXpQ4ERZ7TnN88vROVwbYWb48JgkxCZR4K4BaN
         SoOKmBHqGTPBBrQtrunf+uerkn1SrfhwDV06zcc9iXgV1OcQOQ3lqbHwoornWtF5o7mA
         dHiqyxeZGX8MzNHvzS2LB5KT1wifggeNSGpSC2yvbc2cHDWKI+RXQWJjQXCQyVjJgxYR
         jaadQAtpglufagBXjmZI/QPuFJBL/uw5o4CAKyeK6xwecDWPW1Lmi/H2jKssVDB9B0xk
         uUgg==
X-Gm-Message-State: AOJu0YyCBdgUDsWDTCNyg5EIq4FjzjNZzHFTeCRy+lw1doKa+c/nT8pq
	NaguQLJ70xCx17d8X5o4t76ygmEf5h57wYiRbz5Y3Zar9dDoeUwFymqQveo0u2Y=
X-Google-Smtp-Source: AGHT+IE/G9jHVpNKkX+xMjhnNJjtEs4wHMuVc9/z3VooWi1NXVi0YQzDd+4olv+39n4lPeEMeLnUwA==
X-Received: by 2002:a05:600c:1554:b0:41b:8041:53c2 with SMTP id f20-20020a05600c155400b0041b804153c2mr2088941wmg.15.1714466993103;
        Tue, 30 Apr 2024 01:49:53 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:52 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/11] nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct
Date: Tue, 30 Apr 2024 09:49:21 +0100
Message-Id: <20240430084921.33387-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=0sR9ujGCEP+6Q0XKApMGsZsmdsHiiV/V+Z/2e6aEhpc=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCNKCMkbHUBRwf5ImR7XHR18A89cIeREtD37 dx3VQZJe0mJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjQAKCRB6of1ZxzRV NzNHB/kBEGsuxmofyFVCAEgiIBxYZmfkwh9G3Pt4H7y1Trn454v1JLoFqaCPFArsp5b4wRIDTqO Id2wcbQRfWYtnhc0DbfjiJFnUO7Ch3NddwKuMotGB4bDTxbcLVpVFKIDFM1uqfSM03WuPZ9UWqm 0qaMw50/3PTHXnnvsmCY/vqmxwphtEP9tzu8Q9cQ3FxLwaw3V8ywqBEBTSJYIKSZySxje5E/u+N 5bSipP8dnRzPt2/I9qG+0Aj3xV0qfdGxGQPYU/pi7EStcI4YPHjuhat6cIULGj30r2FK3rqM9q8 fsHCZ7vON+E1wa6rL2co5XaSEZZz+CZrCME2qwiaGgvli61h
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <quic_mojha@quicinc.com>

nvmem_device is used at one place while registering nvmem
device and it is not required to be present in efuse struct
for just this purpose.

Drop nvmem_device and manage with nvmem device stack variable.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-mx-efuse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 3ff04d5ca8f8..8a16f5f02657 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -43,7 +43,6 @@ struct meson_mx_efuse_platform_data {
 struct meson_mx_efuse {
 	void __iomem *base;
 	struct clk *core_clk;
-	struct nvmem_device *nvmem;
 	struct nvmem_config config;
 };
 
@@ -193,6 +192,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 {
 	const struct meson_mx_efuse_platform_data *drvdata;
 	struct meson_mx_efuse *efuse;
+	struct nvmem_device *nvmem;
 
 	drvdata = of_device_get_match_data(&pdev->dev);
 	if (!drvdata)
@@ -223,9 +223,9 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(efuse->core_clk);
 	}
 
-	efuse->nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
+	nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
 
-	return PTR_ERR_OR_ZERO(efuse->nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver meson_mx_efuse_driver = {
-- 
2.25.1


