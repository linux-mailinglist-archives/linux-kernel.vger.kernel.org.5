Return-Path: <linux-kernel+bounces-108126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD388065A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8B4282EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C4A3FBB3;
	Tue, 19 Mar 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LrPMDPN7"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807E3EA77
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881934; cv=none; b=W4q5eeE9PrGvENSTXuLdphzzvcrpcWsdOEbyFnRRNrQdQNSO/i/5ys0gXFagHWZb3OOt+vak4aXz2d2A+ZPt88tN06HyG79XO1NZ72uaVh3j3Y0rt0TkXiDnGPwzicS6CKdukxYUWKicZ9ppOTovANBgkkLbzup/r1h6g/yF00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881934; c=relaxed/simple;
	bh=1zsj+M/d9chbnwHl1CpZYf7kzFLbX8aqGDVZhE8fT8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=teOv6helOhoP3ZJsK5PTU3Z9eCAMG5eF3uev2tZq0BCJ/kyLRBbg3D8dQCZ/vBxC7xNsptO09ZySJlqomkZ2LSW+poOYA3wYV8MRRc5s2IM0txsS2YDFz5dUA5hCiCwkcSlMfU/1Eg7vTb4UBUc31SwTu0XEheafx9hUr/MqOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LrPMDPN7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b22af648so216154b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710881932; x=1711486732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvO6Pb0Q30VcXTFiNcwxiPMuBmsILWnZccwRus/VuqA=;
        b=LrPMDPN7DIHXep07bfHUFLuHf1xZ97oc+2uTzmanCYnIsFfF8xq1jgMAbC0/EsKYv0
         FOoAfBba067OrayLKyJoYuuj1uVMOMf8igxUSLkcKZq1i6u+88ON58gU4j++AUdwBhnQ
         9A6XcIyl8Q3NdayUvP+pqBnfOMLT/xOMFrXwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881932; x=1711486732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvO6Pb0Q30VcXTFiNcwxiPMuBmsILWnZccwRus/VuqA=;
        b=HbnjRWPWzpKlR4nKVf7Y1F3Sdyx4we/H8ooPb4k2VhCfDzHtgpmfSBRcgjfXOIiu+1
         ghtl4obaCx4M5UFtlBRxEhoUVqNfsuyK8sLqcdTJtZjI4s8Rz/1IOrCeELBS6MccyoPI
         X2nO3Z08yxjPmLXj8T9Zvv6MhkQVIAtSjRC7sLue9Cyuv0nAixDGcJx+X/7jURq/GyC6
         nVeci3jhBEWFu2F5H5RErHp7bvirUIve4ZKzeHsp67QuS2xlxGpZhw157sB190Z6sUjR
         1LMxXE4Ve5K9c3uHJmGrvXl3pbvolVUXo2QMvXE4YXPC2h/Q8QloKJscnT23CeH85Q8O
         AIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/2ZXtPxDLGh8rgZHbwYftwNmkqErhZa86aX6o2rt8unZDbhZ1tPXi+rnWYMGjd5xHchg7SXA0Jlodve9eqq+kw73gkrhNIy5fgrkB
X-Gm-Message-State: AOJu0YypS2H+1+rVSByFhZi+nQBbsuWgMUYrPi3Psa8W85qNbP/EG3AC
	RQrNqcNKhVCYZXbBLGRlL1zpq37QRWGUADzArzhSeXrMh9E5adoAzxqDUYffcQ==
X-Google-Smtp-Source: AGHT+IGaxQlsWiVI/mJV/nB+Mp2IICAlnHIViegR1Fkm5V0vh3BgrBRwfRrC08WiUB3qWRSrGBNuQA==
X-Received: by 2002:a17:903:234f:b0:1df:f818:8936 with SMTP id c15-20020a170903234f00b001dff8188936mr836476plh.21.1710881932430;
        Tue, 19 Mar 2024 13:58:52 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f4b6:c22b:c130:6c79])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001dde2c3fea5sm11800110plg.50.2024.03.19.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:58:51 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-tegra@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/dp: Clarify that wait_hpd_asserted() is not optional for panels
Date: Tue, 19 Mar 2024 13:58:39 -0700
Message-ID: <20240319135836.v2.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In response to my patch removing the "wait for HPD" logic at the
beginning of the MSM DP transfer() callback [1], we had some debate
about what the "This is an optional function" meant in the
documentation of the wait_hpd_asserted() callback. Let's clarify.

As talked about in the MSM DP patch [1], before wait_hpd_asserted()
was introduced there was no great way for panel drivers to wait for
HPD in the case that the "built-in" HPD signal was used. Panel drivers
could only wait for HPD if a GPIO was used. At the time, we ended up
just saying that if we were using the "built-in" HPD signal that DP
AUX controllers needed to wait for HPD themselves at the beginning of
their transfer() callback. The fact that the wait for HPD at the
beginning of transfer() was awkward/problematic was the whole reason
wait_hpd_asserted() was added.

Let's make it obvious that if a DP AUX controller implements
wait_hpd_asserted() that they don't need a loop waiting for HPD at the
start of their transfer() function. We'll still allow DP controllers
to work the old way but mark it as deprecated.

[1] https://lore.kernel.org/r/20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I would consider changing the docs to say that implementing
wait_hpd_asserted() is actually _required_ for any DP controllers that
want to support eDP panels parented on the DP AUX bus. The issue is
that one DP controller (tegra/dpaux.c, found by looking for those that
include display/drm_dp_aux_bus.h) does populate the DP AUX bus but
doesn't implement wait_hpd_asserted(). I'm actually not sure how/if
this work on tegra since I also don't see any delay loop for HPD in
tegra's transfer() callback. For now, I've left wait_hpd_asserted() as
optional and described the old/deprecated way things used to work
before wait_hpd_asserted().

Changes in v2:
- Make it clear that panels don't need to call if HPD is a GPIO.

 include/drm/display/drm_dp_helper.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index a62fcd051d4d..6c6a96496df6 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -422,7 +422,18 @@ struct drm_dp_aux {
 	 * @wait_hpd_asserted: wait for HPD to be asserted
 	 *
 	 * This is mainly useful for eDP panels drivers to wait for an eDP
-	 * panel to finish powering on. This is an optional function.
+	 * panel to finish powering on. It is optional for DP AUX controllers
+	 * to implement this function. It is required for DP AUX endpoints
+	 * (panel drivers) to call this function after powering up but before
+	 * doing AUX transfers unless the DP AUX endpoint driver knows that
+	 * we're not using the AUX controller's HPD. One example of the panel
+	 * driver not needing to call this is if HPD is hooked up to a GPIO
+	 * that the panel driver can read directly.
+	 *
+	 * If a DP AUX controller does not implement this function then it
+	 * may still support eDP panels that use the AUX controller's built-in
+	 * HPD signal by implementing a long wait for HPD in the transfer()
+	 * callback, though this is deprecated.
 	 *
 	 * This function will efficiently wait for the HPD signal to be
 	 * asserted. The `wait_us` parameter that is passed in says that we
-- 
2.44.0.291.gc1ea87d7ee-goog


