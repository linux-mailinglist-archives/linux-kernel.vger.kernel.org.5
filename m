Return-Path: <linux-kernel+bounces-6659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A33819BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777531F2415E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12FE1F95D;
	Wed, 20 Dec 2023 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Trv9tXZv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B251F61C;
	Wed, 20 Dec 2023 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id 497C140F1DC3;
	Wed, 20 Dec 2023 09:53:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 497C140F1DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1703066011;
	bh=fkPlk9QOXBUg/k3FjQRsnSKdPa0KJL00WGVvsE/i3dA=;
	h=From:To:Cc:Subject:Date:From;
	b=Trv9tXZvm1wV7BQ/LrnJvbCYWoYO0k0HXzowr4ubM0O8M5L8LT4Ev/elpRfApKN1m
	 78ovhPmblZ/1x0Q3PfftlloLqq9yUHBqoiIaQr3Lg7f4op3EQj8kHfJAcATotP4Fey
	 C4HbYjfVMw6ywINCYilDngwxaX8BXMaD8OzCOpeY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Inki Dae <inki.dae@samsung.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume
Date: Wed, 20 Dec 2023 12:53:15 +0300
Message-ID: <20231220095316.23098-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not forget to call clk_disable_unprepare() on the first element of
ctx->clocks array.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 8b7d3ec83aba ("drm/exynos: gsc: Convert driver to IPP v2 core API")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 34cdabc30b4f..5302bebbe38c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1342,7 +1342,7 @@ static int __maybe_unused gsc_runtime_resume(struct device *dev)
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ret = clk_prepare_enable(ctx->clocks[i]);
 		if (ret) {
-			while (--i > 0)
+			while (--i >= 0)
 				clk_disable_unprepare(ctx->clocks[i]);
 			return ret;
 		}
-- 
2.43.0


