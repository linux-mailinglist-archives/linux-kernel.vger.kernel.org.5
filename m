Return-Path: <linux-kernel+bounces-9106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4C981C097
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB64E1F22733
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646F7765B;
	Thu, 21 Dec 2023 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AZqJqpSl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669876DB6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35d57e88c1dso6197735ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703195777; x=1703800577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d5sCfVn0Rl/7lsdspIykh4i2JHByLubzZbSyK4Lu5I0=;
        b=AZqJqpSlkenfYLXXnwXpoaXHnIjw5Z82YofpgZobaUo7/YJQPHX/eiS+Q+TOQIF9yY
         egaqfAx4BDc7M33MC1DYIh2t0Lk4lYOoDGZIcxNBpSbHRGt7j3n3xbPCWZ9MEYz4BozV
         EpFbaj8A9Clqr/0yb92lur0VqjbLuYKreibfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703195777; x=1703800577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5sCfVn0Rl/7lsdspIykh4i2JHByLubzZbSyK4Lu5I0=;
        b=WBjVXQeQi6ikSlJAcasIQzeU0I+Zx4bW6SQrm0ETAdO/iLmdrX8VXUZ1LdCqhMe2uJ
         1QdUnfPaA5LCc5wQoU6btfPi/Q145T1Pn97+o5qK2nKgM0lfuMr48vEoNeUyG8BwTgKK
         nDAN5KJnPGvY75ONDS/UNnkDlVy9qRjkUs3uBJiH7VZ+IcCFK0Xrnmyu3UZSuYtYvj/A
         kaivX9Rhiga/CN2uIYsGYxfhEx32LbriRqxwxdcS3MQeGqEKFzjuGFcCB0vM1QIniBNC
         QcgWnYaYYL4sygZV148pa0QxqEG//VInJ0DhmYs80zmwReIzhNl49ApcAMVSRzwFVbgX
         loEg==
X-Gm-Message-State: AOJu0YzwGIdVwi3scPSLvSgDU3DhQyyTf2r/ruMAkbKnVE6s4IYAW5q4
	Ie9yQJL24wMl2GShzlMi1DQyHArn8Lkj
X-Google-Smtp-Source: AGHT+IGIcnnNfBQaowtnhHdWeRblSF1ebship4DKZXKcJsbxoGbQoeIHDP4o7Vpw5S8wufiKZVjLHA==
X-Received: by 2002:a05:6e02:2688:b0:35f:b958:29f3 with SMTP id bz8-20020a056e02268800b0035fb95829f3mr299519ilb.124.1703195777479;
        Thu, 21 Dec 2023 13:56:17 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:153:ce57:e73a:ec3a])
        by smtp.gmail.com with ESMTPSA id l30-20020a63ba5e000000b005cda2559351sm1756817pgu.88.2023.12.21.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:56:16 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: treapking@chromium.org,
	hsinyi@chromium.org,
	Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer
Date: Thu, 21 Dec 2023 13:55:48 -0800
Message-ID: <20231221135548.1.I10f326a9305d57ad32cee7f8d9c60518c8be20fb@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike what is claimed in commit f5aa7d46b0ee ("drm/bridge:
parade-ps8640: Provide wait_hpd_asserted() in struct drm_dp_aux"), if
someone manually tries to do an AUX transfer (like via `i2cdump ${bus}
0x50 i`) while the panel is off we don't just get a simple transfer
error. Instead, the whole ps8640 gets thrown for a loop and goes into
a bad state.

Let's put the function to wait for the HPD (and the magical 50 ms
after first reset) back in when we're doing an AUX transfer. This
shouldn't actually make things much slower (assuming the panel is on)
because we should immediately poll and see the HPD high. Mostly this
is just an extra i2c transfer to the bridge.

Fixes: f5aa7d46b0ee ("drm/bridge: parade-ps8640: Provide wait_hpd_asserted() in struct drm_dp_aux")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 541e4f5afc4c..fb5e9ae9ad81 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -346,6 +346,11 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	int ret;
 
 	pm_runtime_get_sync(dev);
+	ret = _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
+	if (ret) {
+		pm_runtime_put_sync_suspend(dev);
+		return ret;
+	}
 	ret = ps8640_aux_transfer_msg(aux, msg);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
-- 
2.43.0.472.g3155946c3a-goog


