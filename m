Return-Path: <linux-kernel+bounces-118010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A184588B251
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C29E2C8101
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA096AFB6;
	Mon, 25 Mar 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQVPqagL"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DE60EEB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400895; cv=none; b=rkYnLljmm0qXwypAs/hawDwoRwYFKgFRIqhuiKk2SyaJjEY2+aSOagqgEuakGon3QOvi4BZIMhqX9E6oU454HYkBDrAFiTnf+gYPNJ5AkLwGo87FrGVhn+c8NfH5SuV+6UdjOaNf1AtBe7/GxkI0bvdoP4IJAtjdE8R0szy3viY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400895; c=relaxed/simple;
	bh=lniH+K6uobF32tHcdj8snosy2n/Wm+ZT7d9jUBOBkIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQaCQDseUEB0qIMprHKmWaFCfw1wJI5ss9ryePcLd4Xnl3bER4DCOYlsbSeGjMsXOfDk1KkmLUSIN02AdMuolcRp/z+ZYG76QLKQ+w5Jpw8l+ihAY+yVsStSvgMOmRds+YIWfwU7FNCyausUeCVcB5BD4xG4QXwDLsgU/5xGjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DQVPqagL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so1805939b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711400893; x=1712005693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOw6fcswQwxOvYHww+pfzlL0zz/FCwx/qV0ISLCzS6k=;
        b=DQVPqagLnY5YLX7LfPp1gAEJzf5UnUSoy5UASsi3mXrRxzhUpiBZvsdxw94MK92Pnr
         uZIUh0pcacrNkTpTJp39fTSQSswvTIQqJsDlHPOumED4u8s8RtEknTc+hDLWduBq6H91
         f5VMWxi3bG0DhZpszI7Z82xa7bDanWZG4I0lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400893; x=1712005693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOw6fcswQwxOvYHww+pfzlL0zz/FCwx/qV0ISLCzS6k=;
        b=QXCqbhyUDRrRtfB8X3CuBLJwF4AjuSLLXRcvlkQOEJTaYbtrPCJLp0z+Zf175hNZ7l
         y1kc3wJLZ4HEWa77TUkj2HqwM5OOOlI3Ch3waDROaZO+9kz8hSW3R1EODPRAgutTBOjF
         FfbsZtVP5xIv77sRhUF5/z66hfRh62k6Ppi4rgqCvYUhuO2SuG/js2y03FuDglIYTR9t
         YWnKF0m/+F+78W+slGmgNmI+tIT8VN2TeHrm8lLKv55KQilbztzjXcBNxgQEuYAT+iMD
         mQq8OOOBIhvAWQFXHsxGMjKywH8jiM9FNsNchB+PT0AyZXulyvNlGW32VQC8ZOgoXcOC
         Orow==
X-Gm-Message-State: AOJu0YxGjGEaZ97h2hPfQxRA812VXd/nozYDtdYBwRcoFLQ0sRQVlHn5
	C/crS8COl0Di6Cmh2ICewFxFs+5DIICGj4M2runmjlgfPBdTFH8n0ho7H1Wrhw==
X-Google-Smtp-Source: AGHT+IFNMzzlQS+M2WzYTzH5qd5yGumfrSL44l9e2y2KmdW8eGoSNDQ4K0XzusabfDNfOaNLkU2CdA==
X-Received: by 2002:a05:6a20:12d2:b0:1a3:4671:2285 with SMTP id v18-20020a056a2012d200b001a346712285mr7841746pzg.44.1711400893255;
        Mon, 25 Mar 2024 14:08:13 -0700 (PDT)
Received: from localhost (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with UTF8SMTPSA id fn18-20020a056a002fd200b006e4e93f4f17sm4584180pfb.117.2024.03.25.14.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:08:12 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm: Add newlines to some debug prints
Date: Mon, 25 Mar 2024 14:08:09 -0700
Message-ID: <20240325210810.1340820-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These debug prints are missing newlines, leading to multiple messages
being printed on one line and hard to read logs. Add newlines to have
the debug prints on separate lines. The DBG macro used to add a newline,
but I missed that while migrating to drm_dbg wrappers.

Fixes: 7cb017db1896 ("drm/msm: Move FB debug prints to drm_dbg_state()")
Fixes: 721c6e0c6aed ("drm/msm: Move vblank debug prints to drm_dbg_vbl()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/msm_fb.c  | 6 +++---
 drivers/gpu/drm/msm/msm_kms.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index e3f61c39df69..80166f702a0d 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -89,7 +89,7 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb,
 
 	for (i = 0; i < n; i++) {
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], aspace, &msm_fb->iova[i]);
-		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)",
+		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
 		if (ret)
 			return ret;
@@ -176,7 +176,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 	const struct msm_format *format;
 	int ret, i, n;
 
-	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)",
+	drm_dbg_state(dev, "create framebuffer: mode_cmd=%p (%dx%d@%4.4s)\n",
 			mode_cmd, mode_cmd->width, mode_cmd->height,
 			(char *)&mode_cmd->pixel_format);
 
@@ -232,7 +232,7 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 
 	refcount_set(&msm_fb->dirtyfb, 1);
 
-	drm_dbg_state(dev, "create: FB ID: %d (%p)", fb->base.id, fb);
+	drm_dbg_state(dev, "create: FB ID: %d (%p)\n", fb->base.id, fb);
 
 	return fb;
 
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 84c21ec2ceea..af6a6fcb1173 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -149,7 +149,7 @@ int msm_crtc_enable_vblank(struct drm_crtc *crtc)
 	struct msm_kms *kms = priv->kms;
 	if (!kms)
 		return -ENXIO;
-	drm_dbg_vbl(dev, "crtc=%u", crtc->base.id);
+	drm_dbg_vbl(dev, "crtc=%u\n", crtc->base.id);
 	return vblank_ctrl_queue_work(priv, crtc, true);
 }
 
@@ -160,7 +160,7 @@ void msm_crtc_disable_vblank(struct drm_crtc *crtc)
 	struct msm_kms *kms = priv->kms;
 	if (!kms)
 		return;
-	drm_dbg_vbl(dev, "crtc=%u", crtc->base.id);
+	drm_dbg_vbl(dev, "crtc=%u\n", crtc->base.id);
 	vblank_ctrl_queue_work(priv, crtc, false);
 }
 

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
https://chromeos.dev


