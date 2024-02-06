Return-Path: <linux-kernel+bounces-55372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C2684BBD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E8F286F94
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB841D2E0;
	Tue,  6 Feb 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i0jM8bBH"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D968F6F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240500; cv=none; b=ApiaRGJSoyPw8KPMzVkC4g4esku/TZpn25/RbqduXTPRD6vmnKRDhe/bNesvozbsRiv0vL1U4r0jqLY2ghxFBSkur1DyqVqHmrvdYXCGKFE2PO2r8LzRbl3sjrxNDPshHCTtj4QiV985SlnG0CVyS8hNw5cJK0nuY+iyp2eius0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240500; c=relaxed/simple;
	bh=LYt6rRRAtz1tm8JjwmQJDe6JgOXcLEFYmNIyU0Zk4ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XjECk0VJ4D42UxPs2G/W7e7w/ZRlg61+HZ0MQRZ56oibiJgY0+wt1SEYhcWBXPv8rCngR+Wz9gSH8Wvjthj27DCT+V+gy0oCaeOMDD2cz8Am/Acv1n1L5MRVAk9JyDiddfpqzhWXSz+nondtGbVy3GppRQQS0MGNPgAyRg99z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i0jM8bBH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707240496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJeg+jbAcpnrVW6uuGDu8kXydhp7MfSBefIfBQvVhDk=;
	b=i0jM8bBHnaZzGn07/ZaR92j+Iu1f4A+Cgb8phFRhlfoT8PgwxmsUTchLLn6lKUrr19AHY5
	JdBUHc6dtAMo0LCObrJqRS4qFFuPhU1C69xvB4mmudD5s0YrJCAlbGN5/6pJwye5WVPsQY
	P9m2JwQ3BrypIAMlYED2dzpX4SUOX8g=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v13 1/7] drm/etnaviv: Add a helper function to get clocks
Date: Wed,  7 Feb 2024 01:27:53 +0800
Message-Id: <20240206172759.421737-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240206172759.421737-1-sui.jingfeng@linux.dev>
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because the current implementation is DT-based, this only works when the
host platform has the DT support. The problem is that some host platforms
does not provide DT-based clocks drivers, as a result, the driver rage
quit. For example, the X86-64 and LoongArch desktop platform.

Typically, PLL hardware is provided by the host platform, which is part
of the entire clock tree, the PLL hardware provide clock pulse to the GPU
core, but it's not belong to the GPU core. PLL registers can be manipulated
directly by the device driver. Hence, add a dedicated helper function to
get the various clocks, which make it possible to call this function only
on the platform where DT support is available.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 53 ++++++++++++++++-----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index ce1e970f0209..654bf2631755 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1617,6 +1617,35 @@ static irqreturn_t irq_handler(int irq, void *data)
 	return ret;
 }
 
+static int etnaviv_gpu_clk_get(struct etnaviv_gpu *gpu)
+{
+	struct device *dev = gpu->dev;
+
+	gpu->clk_reg = devm_clk_get_optional(dev, "reg");
+	DBG("clk_reg: %p", gpu->clk_reg);
+	if (IS_ERR(gpu->clk_reg))
+		return PTR_ERR(gpu->clk_reg);
+
+	gpu->clk_bus = devm_clk_get_optional(dev, "bus");
+	DBG("clk_bus: %p", gpu->clk_bus);
+	if (IS_ERR(gpu->clk_bus))
+		return PTR_ERR(gpu->clk_bus);
+
+	gpu->clk_core = devm_clk_get(dev, "core");
+	DBG("clk_core: %p", gpu->clk_core);
+	if (IS_ERR(gpu->clk_core))
+		return PTR_ERR(gpu->clk_core);
+	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
+
+	gpu->clk_shader = devm_clk_get_optional(dev, "shader");
+	DBG("clk_shader: %p", gpu->clk_shader);
+	if (IS_ERR(gpu->clk_shader))
+		return PTR_ERR(gpu->clk_shader);
+	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
+
+	return 0;
+}
+
 static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 {
 	int ret;
@@ -1892,27 +1921,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get Clocks: */
-	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
-	DBG("clk_reg: %p", gpu->clk_reg);
-	if (IS_ERR(gpu->clk_reg))
-		return PTR_ERR(gpu->clk_reg);
-
-	gpu->clk_bus = devm_clk_get_optional(&pdev->dev, "bus");
-	DBG("clk_bus: %p", gpu->clk_bus);
-	if (IS_ERR(gpu->clk_bus))
-		return PTR_ERR(gpu->clk_bus);
-
-	gpu->clk_core = devm_clk_get(&pdev->dev, "core");
-	DBG("clk_core: %p", gpu->clk_core);
-	if (IS_ERR(gpu->clk_core))
-		return PTR_ERR(gpu->clk_core);
-	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
-
-	gpu->clk_shader = devm_clk_get_optional(&pdev->dev, "shader");
-	DBG("clk_shader: %p", gpu->clk_shader);
-	if (IS_ERR(gpu->clk_shader))
-		return PTR_ERR(gpu->clk_shader);
-	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
+	err = etnaviv_gpu_clk_get(gpu);
+	if (err)
+		return err;
 
 	/* TODO: figure out max mapped size */
 	dev_set_drvdata(dev, gpu);
-- 
2.34.1


