Return-Path: <linux-kernel+bounces-102018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D787ADA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF261C20B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF55651BA;
	Wed, 13 Mar 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiTMbvmK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1647A6F;
	Wed, 13 Mar 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348252; cv=none; b=Iqu82Q2eCXHyrXRisiPBhJaPn6i2rNRNUhbvgdgU9o9vqLoyQuvMTO9ZoKIc7PGnmf+I0qStIMnmPvWba2QZFQimzdJHKwvv6WKNa5SeX6PPoWk/C+yblgzhZyRBbUJRZcCITwCD8IE30VS+rvbkiM4jvr/Y1Qo4LTCdcOYYJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348252; c=relaxed/simple;
	bh=hu6DpvE5WrtXLVtktC2RDOr1HzwCQFEFXKkD6CCXoEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZjXL3R9HVEB2Yk6eAjudE1DWM3d/9xlexLl4oCSfJaOpGwJRjf+akh9ksPDIjbiwPXdlbJD4Mo1j3lLO7g5WYcugrAL82P6cA+AJbAsn+eKmR3nMPsRfYYzxPZCX2Lam53unXNeLzNJR4tv7NOCb6AMqqUhMxpinJqdJtiT5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiTMbvmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0640C433F1;
	Wed, 13 Mar 2024 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348252;
	bh=hu6DpvE5WrtXLVtktC2RDOr1HzwCQFEFXKkD6CCXoEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiTMbvmKsyx73w93QN46IBb2DHWPyCDhJne0/OXUI93WUuu8GYWMh4rALJ94WrhDP
	 2WgG2A221GyBBoNi2aWVhvfTtJLxvqVAIN6wdoGd4u+FccgB772Kh8gVWQjYo/HSN8
	 obGqFzUrEBNJVdvsPdJUkHpK9feCq7n9kYwo7VUC8fdL96HvKpVbbCA++qr782BkUl
	 RRAo71ipEk7P3TxmY5bn7KcWAWhcxtrqlZo6k6IsV7/kwZldlzlNd8Ec79ScfBZDOI
	 cSHmgkHo+ClUz4L9C7HDxiG+2+P+wUB996/Sz/xLhANkWP2ynLBlL2LWIw4d5fWdd0
	 ZTt79M+XF0wJg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rkRiG-0000000062D-0QH9;
	Wed, 13 Mar 2024 17:44:20 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/msm/dp: fix runtime PM leak on connect failure
Date: Wed, 13 Mar 2024 17:43:06 +0100
Message-ID: <20240313164306.23133-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313164306.23133-1-johan+linaro@kernel.org>
References: <20240313164306.23133-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to balance the runtime PM usage counter (and suspend) before
returning on connect failures (e.g. DPCD read failures after a spurious
connect event or if link training fails).

Fixes: 5814b8bf086a ("drm/msm/dp: incorporate pm_runtime framework into DP driver")
Cc: stable@vger.kernel.org      # 6.8
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8e8cf531da45..78464c395c3d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -598,6 +598,7 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 	ret = dp_display_usbpd_configure_cb(&pdev->dev);
 	if (ret) {	/* link train failed */
 		dp->hpd_state = ST_DISCONNECTED;
+		pm_runtime_put_sync(&pdev->dev);
 	} else {
 		dp->hpd_state = ST_MAINLINK_READY;
 	}
-- 
2.43.2


