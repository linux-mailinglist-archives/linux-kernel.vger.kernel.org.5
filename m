Return-Path: <linux-kernel+bounces-104943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5927787D64A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB121F217BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936856745;
	Fri, 15 Mar 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KohhdyEz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BA54911
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538663; cv=none; b=QYt6GLG+Szvq9JoK0m587tI7vR9XnvmiMPNKurxJBvCtU8JhVx9JaA4cZtXws0+yaUzBAeQKUDMvO/FPB4Pgd9PvOJNAdUCyOEE19q7JXP9mFpYB6MVcaTxxGWv1N5sJ6gUU7r3c6SvIloUX84wkMNyrF7n0zqdNwI0D1MwrwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538663; c=relaxed/simple;
	bh=liSqK4bha3G0UMa5WwMSg9FNt50L6xUCUmE3EFyB78s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iu6HHVpdhVN9bRNzzB7h+iG3meK9RX0EZjfvKTBF51WqzUdxfwmbWUlXaP/alROEid40tC+yJTHBKXHFY1Y+eTtHJ8rd/osoJIuUAYlCpOOluVcuOyUtr7V/mFCEh9oVJNBVRClfzrqHsXU8MJezRkRlskcJu1pTwRwZ113zaKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KohhdyEz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6adc557b6so2371005b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710538660; x=1711143460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3H6OXEbfvIDjIIA1tOpuyHi0Op96O49XQrGRIR14qb8=;
        b=KohhdyEzSvoGzOtlMpVfTJThhS/MJAuzfjzHLHTVIkOsRvwZZ3EPUbUUK3bBxb9rjD
         R+CZVbWuD7nJrrswJBRZgiie9vEvl1BxqQwtVdUH27O0u+4kTpj0tlQAqm/haMkichP1
         NhvrEY5DkSKJ/ckxMwI/GIEoQ3aVt5RxJ1vTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538660; x=1711143460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3H6OXEbfvIDjIIA1tOpuyHi0Op96O49XQrGRIR14qb8=;
        b=wx0ZxC0uanvECeBGUIg8DBfhYve4lmE9J7Z6L+lovxPQJYxT2dZ3fI57Xf5C5zf/4j
         woRJWGDTEPIsYx8j38KEpsGBkMvDf0pW4cX79Xj4g7h/ebDpFf1nwkWmKVuHfeJbKi9v
         Hw/gZOOF6qVqbM0oIbosrz/MN1Ov4zvP5716e2I7dNI6hfMWMQl7JI/v68j/u9egqRfv
         nUHVffpYA8lXbiJNTwjDmc3hQu/wklaUXROtrXxlbbbHVhDB7p/IuxWrHlJ6cF2z4K1A
         eRcwg/DTyjjRGBBW3Hv3k0LV6MKr2Q0yW0r/caGheS/5MRJmtjC3LGRY5R0FLPJN4wXr
         0lKg==
X-Forwarded-Encrypted: i=1; AJvYcCV2KkWJzq1xZESY/Z/MEDVooF4pGXqGDhGLWQoosH/5NkVs5vPozB/9EbdRzg+DuYjOqh5QTRUAqnwYpe3OZp8mfR5Bqmkex03H+voD
X-Gm-Message-State: AOJu0YxUEf1nD6cS8Cc4sAzOE5BplmC02QFHyv3wWKh2RziQPwh/AXCy
	qGwP4UfrITaU6k0mzFkbVgzE+WTKUpu9rc6NqBW7pLG5+Qbg69nz6ktPOkp/xg==
X-Google-Smtp-Source: AGHT+IELVx8nj+GWNrW14grfom6LFcSIwtz44rFdKRDSOfNG3DdINnqC2cuXSkNUt4NU7HimWVkT7g==
X-Received: by 2002:a05:6a20:12c6:b0:1a2:b33b:d6e0 with SMTP id v6-20020a056a2012c600b001a2b33bd6e0mr7220673pzg.59.1710538659655;
        Fri, 15 Mar 2024 14:37:39 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:b23e:e8dc:3df4:aa2a])
        by smtp.gmail.com with ESMTPSA id a26-20020aa7865a000000b006e6b5e65579sm3837142pfo.106.2024.03.15.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 14:37:38 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Guenter Roeck <groeck@chromium.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sean Paul <sean@poorly.run>,
	Stephen Boyd <swboyd@chromium.org>,
	Vara Reddy <quic_varar@quicinc.com>,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm/msm/dp: Avoid a long timeout for AUX transfer if nothing connected
Date: Fri, 15 Mar 2024 14:36:29 -0700
Message-ID: <20240315143621.v2.1.I16aff881c9fe82b5e0fc06ca312da017aa7b5b3e@changeid>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240315213717.1411017-1-dianders@chromium.org>
References: <20240315213717.1411017-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As documented in the description of the transfer() function of
"struct drm_dp_aux", the transfer() function can be called at any time
regardless of the state of the DP port. Specifically if the kernel has
the DP AUX character device enabled and userspace accesses
"/dev/drm_dp_auxN" directly then the AUX transfer function will be
called regardless of whether a DP device is connected.

For eDP panels we have a special rule where we wait (with a 5 second
timeout) for HPD to go high. This rule was important before all panels
drivers were converted to call wait_hpd_asserted() and actually can be
removed in a future commit.

For external DP devices we never checked for HPD. That means that
trying to access the DP AUX character device (AKA `hexdump -C
/dev/drm_dp_auxN`) would very, very slowly timeout. Specifically on my
system:
  $ time hexdump -C /dev/drm_dp_aux0
  hexdump: /dev/drm_dp_aux0: Connection timed out
  real    0m8.200s
We want access to the drm_dp_auxN character device to fail faster than
8 seconds when no DP cable is plugged in.

Let's add a test to make transfers fail right away if a device isn't
plugged in. Rather than testing the HPD line directly, we have the
dp_display module tell us when AUX transfers should be enabled so we
can handle cases where HPD is signaled out of band like with Type C.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Don't look at the HPD line directly; have dp_display call us.

 drivers/gpu/drm/msm/dp/dp_aux.c     | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_aux.h     |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 03f4951c49f4..e67a80d56948 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -35,6 +35,7 @@ struct dp_aux_private {
 	bool no_send_stop;
 	bool initted;
 	bool is_edp;
+	bool enable_xfers;
 	u32 offset;
 	u32 segment;
 
@@ -301,6 +302,17 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 		goto exit;
 	}
 
+	/*
+	 * If we're using DP and an external display isn't connected then the
+	 * transfer won't succeed. Return right away. If we don't do this we
+	 * can end up with long timeouts if someone tries to access the DP AUX
+	 * character device when no DP device is connected.
+	 */
+	if (!aux->is_edp && !aux->enable_xfers) {
+		ret = -ENXIO;
+		goto exit;
+	}
+
 	/*
 	 * For eDP it's important to give a reasonably long wait here for HPD
 	 * to be asserted. This is because the panel driver may have _just_
@@ -433,6 +445,14 @@ irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux)
 	return IRQ_HANDLED;
 }
 
+void dp_aux_enable_xfers(struct drm_dp_aux *dp_aux, bool enabled)
+{
+	struct dp_aux_private *aux;
+
+	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
+	aux->enable_xfers = enabled;
+}
+
 void dp_aux_reconfig(struct drm_dp_aux *dp_aux)
 {
 	struct dp_aux_private *aux;
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
index 511305da4f66..f3052cb43306 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.h
+++ b/drivers/gpu/drm/msm/dp/dp_aux.h
@@ -12,6 +12,7 @@
 int dp_aux_register(struct drm_dp_aux *dp_aux);
 void dp_aux_unregister(struct drm_dp_aux *dp_aux);
 irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux);
+void dp_aux_enable_xfers(struct drm_dp_aux *dp_aux, bool enabled);
 void dp_aux_init(struct drm_dp_aux *dp_aux);
 void dp_aux_deinit(struct drm_dp_aux *dp_aux);
 void dp_aux_reconfig(struct drm_dp_aux *dp_aux);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4c72124ffb5d..b0f3e2ef5a6b 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -565,6 +565,8 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 	int ret;
 	struct platform_device *pdev = dp->dp_display.pdev;
 
+	dp_aux_enable_xfers(dp->aux, true);
+
 	mutex_lock(&dp->event_mutex);
 
 	state =  dp->hpd_state;
@@ -629,6 +631,8 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	u32 state;
 	struct platform_device *pdev = dp->dp_display.pdev;
 
+	dp_aux_enable_xfers(dp->aux, false);
+
 	mutex_lock(&dp->event_mutex);
 
 	state = dp->hpd_state;
-- 
2.44.0.291.gc1ea87d7ee-goog


