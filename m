Return-Path: <linux-kernel+bounces-33430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0683699A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9551F241FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500061272AC;
	Mon, 22 Jan 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roU1UjhS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5C3EA9B;
	Mon, 22 Jan 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936265; cv=none; b=QKF+1o0dteh6sINaFpjgPJCxDgzQpokz+nNThmV8rLv89IOTtFe26WPCQO4ps5oZB1BtDsvXfPI2dFFz3hQouAXgDhXOsXDpF5uQzsB5oeesHONwT1msosUbW6sKZ97pYzE74sq22b1eX5apLZtOlV7TFuw8wrW3yyZyIyqmZfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936265; c=relaxed/simple;
	bh=A5/8WULJogAZ2gq6MyPzXHdGezp6HyRDiKSQy0vu5wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTWRXRFnhzycdp1RK8wPs9iPiIp4MZ4M2adNXVHfh4tolo38c5Rrb9TRQMKT32GZvmlSkTSuHL8sxaSnnNZRIWoxqJRX7LQj99WXC3GowwV2O+OLbWFR7/gSjXALblqgDV2JSRj75qzf/4xMw4j/rraZob6jIbcGvc1q0lKykPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roU1UjhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D519C433A6;
	Mon, 22 Jan 2024 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936265;
	bh=A5/8WULJogAZ2gq6MyPzXHdGezp6HyRDiKSQy0vu5wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=roU1UjhSIyUixOA5DiyL6yRq7dyBVZl4kDmPmC1Ke4eM9JLtfssVxnwDoXotubwQA
	 QUAicmEPWPG56yYsAiHlV3LKDvEB1/ZQy9MbpQXEkfEIkOVm9POPTKkcHndqWI4H7g
	 ioRAD3BBRIXmQmi/USdP+fM809nT5u5ViZz5rrP0busMxcLAISSnULbJCOeZYKZcgJ
	 x1qEuZTyDzzWjgC33qf+6IW5qo4YKkJrxLcl7YOH2iiMwVYQc5+TQOqPHhgCeCQMDI
	 9CeaLMnz55KvXx9e/KIr/moiiy1UNMBKDZiLcrMYCYwddgeHX7JIYQ6jOLKYtSPFlV
	 wGsmk1zdQTX5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Inki Dae <inki.dae@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	krzysztof.kozlowski@linaro.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 30/53] drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time
Date: Mon, 22 Jan 2024 10:08:31 -0500
Message-ID: <20240122150949.994249-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 16ac5b21b31b439f03cdf44c153c5f5af94fb3eb ]

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown time
and at driver unbind time. Among other things, this means that if a
panel is in use that it won't be cleanly powered off at system
shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart and at driver remove (or unbind) time comes
straight out of the kernel doc "driver instance overview" in
drm_drv.c.

A few notes about this fix:
- When adding drm_atomic_helper_shutdown() to the unbind path, I added
  it after drm_kms_helper_poll_fini() since that's when other drivers
  seemed to have it.
- Technically with a previous patch, ("drm/atomic-helper:
  drm_atomic_helper_shutdown(NULL) should be a noop"), we don't
  actually need to check to see if our "drm" pointer is NULL before
  calling drm_atomic_helper_shutdown(). We'll leave the "if" test in,
  though, so that this patch can land without any dependencies. It
  could potentially be removed later.
- This patch also makes sure to set the drvdata to NULL in the case of
  bind errors to make sure that shutdown can't access freed data.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
index 16c539657f73..4095b0d3ac2e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -309,6 +309,7 @@ static int exynos_drm_bind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	exynos_drm_cleanup_dma(drm);
 	kfree(private);
+	dev_set_drvdata(dev, NULL);
 err_free_drm:
 	drm_dev_put(drm);
 
@@ -323,6 +324,7 @@ static void exynos_drm_unbind(struct device *dev)
 
 	exynos_drm_fbdev_fini(drm);
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
@@ -360,9 +362,18 @@ static int exynos_drm_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void exynos_drm_platform_shutdown(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+
+	if (drm)
+		drm_atomic_helper_shutdown(drm);
+}
+
 static struct platform_driver exynos_drm_platform_driver = {
 	.probe	= exynos_drm_platform_probe,
 	.remove	= exynos_drm_platform_remove,
+	.shutdown = exynos_drm_platform_shutdown,
 	.driver	= {
 		.name	= "exynos-drm",
 		.pm	= &exynos_drm_pm_ops,
-- 
2.43.0


