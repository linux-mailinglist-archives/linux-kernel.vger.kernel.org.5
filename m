Return-Path: <linux-kernel+bounces-50651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BCF847C19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913D22839B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E183B83A1F;
	Fri,  2 Feb 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0s9b+uK"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97283A10
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911919; cv=none; b=HgHl8sS1Lq9OEYUGbYD1PhKopFdcFbImj1WjtpG5BRuOlBMUA0r1sOVuDP2i9EpC9ipXp0KbjdVHltgczilW1r9IGnBiFnIcowkjD5FXhhqY4qyytxgSYMa0LQkBgtgkvPYcuH0lfLbc7v+eihcxm9B04egZixAjALisccDVl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911919; c=relaxed/simple;
	bh=XqlfOzLysFex/INvu6F24xh72tTnG24snQSPq3khjbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqdKM/+9twgRzqWT0BE6MTIMXvN9UK5oomJDdhynJZgRAfTIXhIlZGY+fzZa1dgTnYPuVFUsNFZfsXicYAicw3/KNfYriCH5Ocx09QNeuLqt37GS6x55ejI6p3c+lc2gwbdKGZqULodya6r8jBB/Y4+IoqeqM7GvQI3w1rDrh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I0s9b+uK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddcfda697cso2041556b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706911916; x=1707516716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qrtNF7zN0cbAGg10uK/fD5kkglvLb3T2mDK8a3sGkI4=;
        b=I0s9b+uKW3l8WlAcUbC37GtJoQLqy/SpuI7a52ZHnIEL8wvrkxdGOvOhR/p5KrKyGj
         evW9Nh8tiIDI+FO+BrFRmmEemoLyirPiLSpjVvzpzfE+WQfsz66epjd568271i+9L+dA
         QSKGVc0NBgLw/h8mV1WOoYOoRrUaBk4CKrGl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911916; x=1707516716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrtNF7zN0cbAGg10uK/fD5kkglvLb3T2mDK8a3sGkI4=;
        b=ACOHvOu0dzOVQ7EFvkjzkOcwnyzN2WDKXQ/IpAWS+21GNtsh2J+v0+o4tDvF5awN6o
         oQZ+CT5a9pvFDhzc/wCC5VRsOH4j2NuNG+bp1DpMgJMpD53LDZFnQFyLI1H0vjuVj90y
         V7O/DzKM+ANaeQU6IuzZKNauUX5j90RTWh/qN3jCIKQFIvlVm8s3BBVxZ6tWU9A7yh3p
         5dYCJWv1/edBKUVI37HtCXkEluXBIlTi8tFgHNt9g+hg/cZi7St3fdvWOFok3Hk3KMGt
         /N4qmOH42vqqy5jF9rvEQqnIdb+F4uu5yCWBElSd6mGdp9XvXX+7wsE2PB4dcCBmVrqY
         eaig==
X-Gm-Message-State: AOJu0YwF5MTLd94bsrYH/ThMUgCeUyAu6mpg0i3CwScWBLgu8QteL+KF
	28QS9sfucBXGFGX/ThWcISTUZcm1B8ZBi089lFH/obAemD3r0KBnSUZ570VCUA==
X-Google-Smtp-Source: AGHT+IFNhcR8p0qiBJqe6s9UFVC4u+lq8FuGlBBAK1hnfoU3kxfbMEvijpL2VuS8BCZhuA+4lD1vWA==
X-Received: by 2002:a05:6a00:70d:b0:6df:bb23:b8f8 with SMTP id 13-20020a056a00070d00b006dfbb23b8f8mr9587455pfl.7.1706911916615;
        Fri, 02 Feb 2024 14:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWNN/AK0bq+0lXHTKvZgLiNNJE7GjhDt8sCPFEo1aNSHRDN+eNM16rNSWZ1PhW715ie62xL3HNPWNXWBvyEVEnmDZ87HNW0EjyWFsvymFQZYcn0EHtPzInRHW19GjID/AO22g7ovLM1bsaDY1cEZRp8sPlUrnvUpj3iD77GH3j4wMKxApQqbsmrHbjnfwgio/NpDRhq5IOGpmXzLMFfKJfrKC9kHnrBXk+hJNVYkLibiVhR6uOe1c75X5uVqF/8jUTM1V73MQWeAQJr2ezazQaCo+oc089Tsw2+/Rkhj8hmoluQnR7yrUzubdYfAhjW4Iax0NYeAhwYNW7vZqc6G23psx5OplUBG2MOF0pFpdi97Lxl0QYoEcpg5wv/IHDkmOcZtzO5KCDi3sG4acrEPvy84Bc55QJVC/B/KGz+4BvGJF7XbVmYZfeZ8Ait0rGt5XMLsACdnMyhWiwvNuHQ/023Oto3w4ThJovZEc81FjF012dcrrM0LFjFaYsbC8JhCOUlx8NcR7GdrbLy9frRBLtR4mT0vBXcaR8=
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:21f9:cc1f:82ca:58b7])
        by smtp.gmail.com with ESMTPSA id s17-20020a632151000000b005cd8044c6fesm2268364pgm.23.2024.02.02.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:11:56 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: eizan@chromium.org,
	Douglas Anderson <dianders@chromium.org>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are not powered
Date: Fri,  2 Feb 2024 14:11:16 -0800
Message-ID: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an eDP panel is not powered on then any attempts to talk to it over
the DP AUX channel will timeout. Unfortunately these attempts may be
quite slow. Userspace can initiate these attempts either via a
/dev/drm_dp_auxN device or via the created i2c device.

Making the DP AUX drivers timeout faster is a difficult proposition.
In theory we could just poll the panel's HPD line in the AUX transfer
function and immediately return an error there. However, this is
easier said than done. For one thing, there's no hard requirement to
hook the HPD line up for eDP panels and it's OK to just delay a fixed
amount. For another thing, the HPD line may not be fast to probe. On
parade-ps8640 we need to wait for the bridge chip's firmware to boot
before we can get the HPD line and this is a slow process.

The fact that the transfers are taking so long to timeout is causing
real problems. The open source fwupd daemon sometimes scans DP busses
looking for devices whose firmware need updating. If it happens to
scan while a panel is turned off this scan can take a long time. The
fwupd daemon could try to be smarter and only scan when eDP panels are
turned on, but we can also improve the behavior in the kernel.

Let's let eDP panels drivers specify that a panel is turned off and
then modify the common AUX transfer code not to attempt a transfer in
this case.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/display/drm_dp_helper.c       | 35 +++++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c             |  3 ++
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  |  2 ++
 include/drm/display/drm_dp_helper.h           |  6 ++++
 4 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index b1ca3a1100da..6fa705d82c8f 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -532,6 +532,15 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
 
 	mutex_lock(&aux->hw_mutex);
 
+	/*
+	 * If the device attached to the aux bus is powered down then there's
+	 * no reason to attempt a transfer. Error out immediately.
+	 */
+	if (aux->powered_down) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
 	/*
 	 * The specification doesn't give any recommendation on how often to
 	 * retry native transactions. We used to retry 7 times like for
@@ -599,6 +608,29 @@ int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset)
 }
 EXPORT_SYMBOL(drm_dp_dpcd_probe);
 
+/**
+ * drm_dp_dpcd_set_powered() - Set whether the DP device is powered
+ * @aux: DisplayPort AUX channel; for convenience it's OK to pass NULL here
+ *       and the function will be a no-op.
+ * @powered: true if powered; false if not
+ *
+ * If the endpoint device on the DP AUX bus is known to be powered down
+ * then this function can be called to make future transfers fail immediately
+ * instead of needing to time out.
+ *
+ * If this function is never called then a device defaults to being powered.
+ */
+void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered)
+{
+	if (!aux)
+		return;
+
+	mutex_lock(&aux->hw_mutex);
+	aux->powered_down = !powered;
+	mutex_unlock(&aux->hw_mutex);
+}
+EXPORT_SYMBOL(drm_dp_dpcd_set_powered);
+
 /**
  * drm_dp_dpcd_read() - read a series of bytes from the DPCD
  * @aux: DisplayPort AUX channel (SST or MST)
@@ -1858,6 +1890,9 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	struct drm_dp_aux_msg msg;
 	int err = 0;
 
+	if (aux->powered_down)
+		return -EBUSY;
+
 	dp_aux_i2c_transfer_size = clamp(dp_aux_i2c_transfer_size, 1, DP_AUX_MAX_PAYLOAD_BYTES);
 
 	memset(&msg, 0, sizeof(msg));
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 7d556b1bfa82..d2a4e514d8fd 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -413,6 +413,7 @@ static int panel_edp_suspend(struct device *dev)
 {
 	struct panel_edp *p = dev_get_drvdata(dev);
 
+	drm_dp_dpcd_set_powered(p->aux, false);
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get_boottime();
@@ -469,6 +470,7 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 	}
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
+	drm_dp_dpcd_set_powered(p->aux, true);
 
 	p->powered_on_time = ktime_get_boottime();
 
@@ -507,6 +509,7 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 	return 0;
 
 error:
+	drm_dp_dpcd_set_powered(p->aux, false);
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get_boottime();
diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 5703f4712d96..76c2a8f6718c 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -72,6 +72,7 @@ static int atana33xc20_suspend(struct device *dev)
 	if (p->el3_was_on)
 		atana33xc20_wait(p->el_on3_off_time, 150);
 
+	drm_dp_dpcd_set_powered(p->aux, false);
 	ret = regulator_disable(p->supply);
 	if (ret)
 		return ret;
@@ -93,6 +94,7 @@ static int atana33xc20_resume(struct device *dev)
 	ret = regulator_enable(p->supply);
 	if (ret)
 		return ret;
+	drm_dp_dpcd_set_powered(p->aux, true);
 	p->powered_on_time = ktime_get_boottime();
 
 	if (p->no_hpd) {
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 863b2e7add29..472359a9d675 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -463,9 +463,15 @@ struct drm_dp_aux {
 	 * @is_remote: Is this AUX CH actually using sideband messaging.
 	 */
 	bool is_remote;
+
+	/**
+	 * @powered_down: If true then the remote endpoint is powered down.
+	 */
+	bool powered_down;
 };
 
 int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset);
+void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered);
 ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 			 void *buffer, size_t size);
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
-- 
2.43.0.594.gd9cf4e227d-goog


