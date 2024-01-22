Return-Path: <linux-kernel+bounces-33514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432B9836B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8150B26945
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C3141993;
	Mon, 22 Jan 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjzgl7Vi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFA141980;
	Mon, 22 Jan 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936569; cv=none; b=DoetiUJFLTPil69Xh5A0uIIgFWMZ3u4kulFmKH0KJAUqmeCffdiJXPs+UG7MNizkzVMjKmMJw+DzihDnyKlaQls1bbLMmZbDL2eOladaD0cXmWWv9z8cfcj3L15Z0YY7H4b/G2JMkVqJOrZeSgHaiHe5SQYWNAzbTlOM+qo231o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936569; c=relaxed/simple;
	bh=7ymwXNGG0MIgq6ANk7aPoOI1mIBUYuqEXp/Eq48HczM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyrn3e6+JP3es9EqqsiPHYC8LO49fpPceHSlhSWUmIeS80dAqBEbn8UC4Cs98TWQqPd3PK+0vnsvsPTe5sAju4294sdNOX+TKciq6kq5gE78u8+93FMeocko3PVrMZ+LRwCueBVLGmakOwY9Hwah2RxbJSKTWXu6omcLeTudmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjzgl7Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F468C433C7;
	Mon, 22 Jan 2024 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936569;
	bh=7ymwXNGG0MIgq6ANk7aPoOI1mIBUYuqEXp/Eq48HczM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pjzgl7Viyam+E+65S8r4aibAjW0y8yz7B5JgUQmnbRlWxiFIGtK/1KAnjzc4AEcO5
	 RsnesdLaFGAnutPKTPKwSAunCM5czlGeG7xVcPQP6Zv3BDuiVrf/i6S/TXWVYlS5B3
	 63hJgGnNI8PNOkAKPLOTNN/FUqCJb7qjdB5TwIorAUTyOMPb+M4Ay3PvMcqv88OR+X
	 eiFApzXFQgIuMaOq3XqU7uwACRlj+/KO8vcSRwiQc0X1Sd1w6gaKxpDV7mvsYE7lv+
	 xNg4ndjppx429nPKay3MHQAD4XgIr5Jirx1JNSj667wN8hxRaclJ68lBJIB5Xayu5v
	 rBQPTfxFpJs3Q==
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
Subject: [PATCH AUTOSEL 5.10 19/28] drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time
Date: Mon, 22 Jan 2024 10:14:45 -0500
Message-ID: <20240122151521.996443-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index dbd80f1e4c78..7e13c1550083 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
@@ -344,6 +344,7 @@ static int exynos_drm_bind(struct device *dev)
 	drm_mode_config_cleanup(drm);
 	exynos_drm_cleanup_dma(drm);
 	kfree(private);
+	dev_set_drvdata(dev, NULL);
 err_free_drm:
 	drm_dev_put(drm);
 
@@ -358,6 +359,7 @@ static void exynos_drm_unbind(struct device *dev)
 
 	exynos_drm_fbdev_fini(drm);
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
@@ -395,9 +397,18 @@ static int exynos_drm_platform_remove(struct platform_device *pdev)
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


