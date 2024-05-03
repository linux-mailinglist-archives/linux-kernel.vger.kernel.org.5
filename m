Return-Path: <linux-kernel+bounces-167380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0D8BA8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE9E283183
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129441494AC;
	Fri,  3 May 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVDTMsEF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7E148853
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724847; cv=none; b=gNYKeYsfUxtBQTGVU4Bxos0238OmpINpLsWZJxFwZYS4G7pMX9KLwND6wy5DRAaJbzBLdmLmILwD9ODtkxC82pnh3wh56uxmjOS2r2pKlBQtwGPIviPCh1XdZ9GKqGsjjDq51CaImVtOhwhzcDZBYWs++62mONpN+NK9ZCF9moY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724847; c=relaxed/simple;
	bh=IEfn+rA7KWKKyDU/jxXAsX8WmECqMPMDg0OqlVECxMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMatS+1zpU+wXPmLer83qMPF54HluF76aeJej+qhZoa65VbiYsDbOGXniTQ1m+2SrTU3i8iaZ4NtWZaQoMS/lE7LpFpKhwbmaBUfLH4BniI21VSy2PFzsePoai4uwGmHM4hSMZvU00qlukl8E4S+igzo5yMrv7VY8x3Oi5wqUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JVDTMsEF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41bab13ca4eso47649455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714724843; x=1715329643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6a6lUh+GY188jtaldul0p+3R0GTrct1Qv8MGiWgRPU=;
        b=JVDTMsEFBPBEPLgHDzzuvQQNIXehnnl4nf/bvl0JHtaEAkfzoleCVcIUSVUHXYhKDe
         oUmP9dveq+rEAS2tWqDRs0R0bYUPMJrUkke+DJD9GtlqbNqg/ZeBz+fkyr4on6uP4nz/
         5ZYlfICLbCQxH8N4HjgRC2q2NTKP/Q7T/Nu/Dl9EQnURPaoMAbmNwnKC4o+q03k9QxA1
         wRZMRB/mCco4rzJE/5ytImAyrA0nj6ldhHRCSdpJ0mkwd1Cj/jGVKGu6Jvv28xgShZU8
         CyubNM0KpV9ZVApDUGxcNGju1xYX9n98/g3gFKecfHjsyvD7FIsb86M/WbvVdYXiHNPZ
         vTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714724843; x=1715329643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6a6lUh+GY188jtaldul0p+3R0GTrct1Qv8MGiWgRPU=;
        b=ijGsGJRq2pYg7iWpyT9L2yk5QT5qHRovRxUcBoydl3W35nPCYgDqv2d3pLCa4xkC3y
         gTbhtqTPDTinXIascAcwM/y/pAMBge3v3dxjD0O0VCBk34okuNWAsWe4KgfM5Uhq+KxR
         fR9HCz3/vRf0z+4nWF2VBqzz+FYDwKr7A7uCd6pfCIM4JFx9KibuBGeeSxFh+URU1L8Y
         9Co0COgGwEf1FvdRjLoZgzlpM/V+8yT82XnKJYwdJHFVz/xuA7Jzr59B11ZU84BeOPyC
         Ijmh895Im9SPRMDM5+x0wNxRzNsR2GH/zmQJ0QtXQrR8RzPq2H/PeICdxDKMxCAeBR1G
         qugA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6ZxU4zg6E2bwkYC9B3J+3CtEnNuLeUADE7hSilANMZBXw/j1J8BBMQoHKNRAU9a1bhV7709UjLGc1VfoQ4F8UzL3GFZpHyWheUfE
X-Gm-Message-State: AOJu0Yx4EXgGrRvrEIldBx1Vo2zX137EFmjUGY7P0CQJNZXYNjrQyMPx
	51TUXLzFAwbr+djyILX+yuFmf9gmGbQiYgjuygN4Vz4SJo9l+faTwgr2r7SsIjg=
X-Google-Smtp-Source: AGHT+IH+dWf8de6Y0dzA0LihElBWCS6qe1eDpqaJVWGQWI7rqiM4itGea69KiJ4DSak/Q8qdGVJp/Q==
X-Received: by 2002:a05:600c:4505:b0:41a:a08f:2696 with SMTP id t5-20020a05600c450500b0041aa08f2696mr1673113wmo.12.1714724843540;
        Fri, 03 May 2024 01:27:23 -0700 (PDT)
Received: from ta2.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0041bfa349cadsm8488050wmq.16.2024.05.03.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 01:27:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: m.szyprowski@samsung.com,
	joro@8bytes.org
Cc: will@kernel.org,
	robin.murphy@arm.com,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] iommu/exynos: trivial use of local dev variable
Date: Fri,  3 May 2024 08:27:20 +0000
Message-ID: <20240503082720.966423-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

exynos_sysmmu_probe() defines:
	struct device *dev = &pdev->dev;
then initializes:
	data->sysmmu = dev;

Replace further &pdev->dev and data->sysmmu use with dev.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d98c9161948a..447cf0d07625 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -774,8 +774,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__sysmmu_get_version(data);
 
-	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
-				     dev_name(data->sysmmu));
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL, dev_name(dev));
 	if (ret)
 		return ret;
 
@@ -806,7 +805,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	 * dma mapping operations on iommu page tables (cpu cache flush)
 	 */
 	if (!dma_dev)
-		dma_dev = &pdev->dev;
+		dma_dev = dev;
 
 	pm_runtime_enable(dev);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


