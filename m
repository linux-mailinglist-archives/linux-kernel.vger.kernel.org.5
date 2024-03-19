Return-Path: <linux-kernel+bounces-107988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311A880483
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482681F23CED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8788D2C6A4;
	Tue, 19 Mar 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwvabqTY"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAB2E64F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872108; cv=none; b=ZjQAx7EY0gRyBRG/SfRJLwUpFefW2X0VAMU2DsPNVvwF3osOAcutIhi6O1BH4ULEEC4uMMf/0Xo/HxKptbZpuUA3ZGUXRd0+dJGY86KC6/murJv8VOTVm5fps3Fh3+drEBhFzT7aA7GnxmcrYxIuq0lInC2C0vqwx4IEezIOCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872108; c=relaxed/simple;
	bh=RZ6lEH7cyONfShml37mNV7nkIh1YCuPRnlSy8js1sI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B48pomqlWkt+tI/gIkpIaCQztibBFdNNxxv3pAEmJuEVdXZ+wC7EXYkUAg2b+0PJKX4HwRhN2i/qFQTUitP5O+g/DAaYkoYV9gg1tqKXOFHzy47I25k5gy/TBx8ZXhQ1X1kCUT7wBg3KmdxAgYLdb5I2cZe/FPtZ87+ppFSP5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lwvabqTY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6aa5c5a6fso5630413b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710872105; x=1711476905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KcaIci4ngfZq5XN/VP6t9YI7Rpj+hyL5AivE9QQ6SzY=;
        b=lwvabqTYB2uGZDeXat4J1UARbEGbLbcCygKCe1JN4eJSYR9c3EDQzySbscjs8pcQp7
         k3Yzf0FzsSZ7DZfMS59Siy+IglMN/nua7OnC6WC3rj+RIATSKYNSMlnaHtonD6gORBi/
         sKmU5zDFtM0rqku4yEUhxDgjd2l3e98l1dNk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872105; x=1711476905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcaIci4ngfZq5XN/VP6t9YI7Rpj+hyL5AivE9QQ6SzY=;
        b=k5fAo1+YvS956i9fuD19elQ7oeN1Ro8jOGzGPjc7J0ywjkM7ky25kLkm5n+S6AABy9
         jp/ap1o7gK3nsgRi31PBohtKBigWcZc5Caf7L2qlepfSv9pJB/ci/8OFBgMMgwTeoXcm
         9Q4aemH2s90oarmIUEDW/HltK6OUoX8weqLgZDpIodHbH3n2dhDHyGUt2JzAuPf0YAur
         1AzBgO6GSYTKQUHnjliS3HhTbqNAN19fJVnMU7qBXhqiB6is501Kd0qWOsvx3320mQSI
         qx7doqaRx7PEJdQ8c9Tjj1uV1m7brEuQfMfd8TRF2lNA8JLUUHvoqAJTVhXklt9lK51X
         XzCg==
X-Forwarded-Encrypted: i=1; AJvYcCXen4iwDHGCnv7hVoipSsN8KGV9CTWa9g+R4MMN+jdoSxaV+JaKGP7de5EnsQ3URxIiZhhyxfhtO0WzKpvEKvkiYJwm7fAb2JNehMU/
X-Gm-Message-State: AOJu0Yxzsq2BImQFMRlrTEDwOKwcKjC4CO/yK2bZPH7je5bsH1yaS/kV
	c+wUiVLWpnKGp0LczmcGMpoXWF/eYoie5U6QGfSy/pYljZQeVWDTaXi5MMCmMw==
X-Google-Smtp-Source: AGHT+IEs6V5enK1CZTIHXPiZ4R0PlFu96HG0HOwGdMnSOtSkC4CyugyccnZjk5x2k8W9wrz8gR8SPg==
X-Received: by 2002:a05:6a20:1594:b0:1a3:6817:1b02 with SMTP id h20-20020a056a20159400b001a368171b02mr5885140pzj.55.1710872105015;
        Tue, 19 Mar 2024 11:15:05 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f4b6:c22b:c130:6c79])
        by smtp.gmail.com with ESMTPSA id by24-20020a056a02059800b005e49bf50ff9sm8176006pgb.0.2024.03.19.11.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:15:04 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-tegra@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp: Clarify that wait_hpd_asserted() is not optional for panels
Date: Tue, 19 Mar 2024 11:14:35 -0700
Message-ID: <20240319111432.1.I521dad0693cc24fe4dd14cba0c7048d94f5b6b41@changeid>
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

 include/drm/display/drm_dp_helper.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index a62fcd051d4d..b170efa1f5d2 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -422,7 +422,13 @@ struct drm_dp_aux {
 	 * @wait_hpd_asserted: wait for HPD to be asserted
 	 *
 	 * This is mainly useful for eDP panels drivers to wait for an eDP
-	 * panel to finish powering on. This is an optional function.
+	 * panel to finish powering on. It is optional for DP AUX controllers
+	 * to implement this function but required for DP AUX endpoints (panel
+	 * drivers) to call it after powering up but before doing AUX transfers.
+	 * If a DP AUX controller does not implement this function then it
+	 * may still support eDP panels that use the AUX controller's built-in
+	 * HPD signal by implementing a long wait for HPD in the transfer()
+	 * callback, though this is deprecated.
 	 *
 	 * This function will efficiently wait for the HPD signal to be
 	 * asserted. The `wait_us` parameter that is passed in says that we
-- 
2.44.0.291.gc1ea87d7ee-goog


