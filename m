Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71D87BE877
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbjJIRk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377470AbjJIRkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:40:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372F0BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:40:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bffc55af02so56689741fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696873250; x=1697478050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh9ifNTYpVLHH6A3+4oZUldpkVmC8bZYgwcVo3tsh54=;
        b=q5ydQpvxLuvBFB8LqMGgPaWYQH9Z/z6UYN62uvG94EIWi3+SXY5ZS+fF2Hsgu3Hmgy
         JUsFgHUyKW8YMS+GhPx0eYkqg1xJ0wCGXC/kRQPniEnS2fttxLBYhG1Fxv2IkpBCPzyp
         MovsbZXt9B8f7DNexUcK66CuUDEs0qjb34hvKXKvWCVZ5GbAM+B01QajKBjL8YNUZBeY
         bWLblhw2J9mjtLHAqJofKHOGAQzs37//eBmcu4tB6i7yPYWNr6Aya7qDDoCcDHR0zsVs
         +fd8QLI/2UDpOG+e0bLGXb5UIjhLb/3pRZxPf+ur0fhDBg+puRH8NOLDCVNDjD256Ylt
         QZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873250; x=1697478050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh9ifNTYpVLHH6A3+4oZUldpkVmC8bZYgwcVo3tsh54=;
        b=FJJp72U8SzZfjkgy+/zOydJVXktaASA2zHuGycMCE7TEpoQOgv5oAMnpIibbQt2OOy
         bFI2Wv3AwmoPVdE/S1Xlx7SzFWnvUkI10DRGmT+Qsgm/K1QXGPw0pPLZNl6DTpEF6P8p
         sQO9d9vnoqahIZ7BadZT6qSdldnjQlJXCGsHKk1ze6Vw4lo+2S0nvlC8bYoVs+ejUD7o
         aGJ99rZUCyaA3yidgBE+F97+0uTCg786PE5S3W0hNospjN0I92s8rc+I8BLFshdnG5w8
         0FHcm1fagONwUNAAb0yj/0k/OkM2hISbJc/LLkeg+PN7IqiwvI3L2cvcPduoLMZ6Mhzf
         v76g==
X-Gm-Message-State: AOJu0YwhODjxw8dJql7Pv4hS+8aUfRciM7ZOo5N1359kJ3k7LxXf++Lg
        dD/wPTawrYDh2wYmEh6HH0PCiQ==
X-Google-Smtp-Source: AGHT+IESGfUZf/CG1Q0gtMCeRciayhpzk4c+1E7+yBe8pIblIJAHGK44vpXwm5b5ghikSsChUtjqhA==
X-Received: by 2002:a2e:3e07:0:b0:2c0:9bd:c6f with SMTP id l7-20020a2e3e07000000b002c009bd0c6fmr13780628lja.41.1696873250160;
        Mon, 09 Oct 2023 10:40:50 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z5-20020a2e3505000000b002bcbae4c21fsm2128988ljz.50.2023.10.09.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:40:49 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 1/3 RESEND] drm: Add HPD state to drm_connector_oob_hotplug_event()
Date:   Mon,  9 Oct 2023 20:40:46 +0300
Message-Id: <20231009174048.2695981-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009174048.2695981-1-dmitry.baryshkov@linaro.org>
References: <20231009174048.2695981-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

In some implementations, such as the Qualcomm platforms, the display
driver has no way to query the current HPD state and as such it's
impossible to distinguish between disconnect and attention events.

Add a parameter to drm_connector_oob_hotplug_event() to pass the HPD
state.

Also push the test for unchanged state in the displayport altmode driver
into the i915 driver, to allow other drivers to act upon each update.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/drm_connector.c                 |  6 ++++--
 .../gpu/drm/i915/display/intel_display_core.h   |  3 +++
 drivers/gpu/drm/i915/display/intel_dp.c         | 17 ++++++++++++++---
 drivers/usb/typec/altmodes/displayport.c        | 17 +++++++++--------
 include/drm/drm_connector.h                     |  6 ++++--
 5 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 9d4c7b0c5c05..c3725086f413 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3060,6 +3060,7 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
 /**
  * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to connector
  * @connector_fwnode: fwnode_handle to report the event on
+ * @status: hot plug detect logical state
  *
  * On some hardware a hotplug event notification may come from outside the display
  * driver / device. An example of this is some USB Type-C setups where the hardware
@@ -3069,7 +3070,8 @@ struct drm_connector *drm_connector_find_by_fwnode(struct fwnode_handle *fwnode)
  * This function can be used to report these out-of-band events after obtaining
  * a drm_connector reference through calling drm_connector_find_by_fwnode().
  */
-void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode)
+void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
+				     enum drm_connector_status status)
 {
 	struct drm_connector *connector;
 
@@ -3078,7 +3080,7 @@ void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode)
 		return;
 
 	if (connector->funcs->oob_hotplug_event)
-		connector->funcs->oob_hotplug_event(connector);
+		connector->funcs->oob_hotplug_event(connector, status);
 
 	drm_connector_put(connector);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index 53e5c33e08c3..ccfe27630fb6 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -175,6 +175,9 @@ struct intel_hotplug {
 	/* Whether or not to count short HPD IRQs in HPD storms */
 	u8 hpd_short_storm_enabled;
 
+	/* Last state reported by oob_hotplug_event for each encoder */
+	unsigned long oob_hotplug_last_state;
+
 	/*
 	 * if we get a HPD irq from DP and a HPD irq from non-DP
 	 * the non-DP HPD could block the workqueue on a mode config
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0ef7cb8134b6..4f6835a7578e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5723,15 +5723,26 @@ static int intel_dp_connector_atomic_check(struct drm_connector *conn,
 	return intel_modeset_synced_crtcs(state, conn);
 }
 
-static void intel_dp_oob_hotplug_event(struct drm_connector *connector)
+static void intel_dp_oob_hotplug_event(struct drm_connector *connector,
+				       enum drm_connector_status hpd_state)
 {
 	struct intel_encoder *encoder = intel_attached_encoder(to_intel_connector(connector));
 	struct drm_i915_private *i915 = to_i915(connector->dev);
+	bool hpd_high = hpd_state == connector_status_connected;
+	unsigned int hpd_pin = encoder->hpd_pin;
+	bool need_work = false;
 
 	spin_lock_irq(&i915->irq_lock);
-	i915->display.hotplug.event_bits |= BIT(encoder->hpd_pin);
+	if (hpd_high != test_bit(hpd_pin, &i915->display.hotplug.oob_hotplug_last_state)) {
+		i915->display.hotplug.event_bits |= BIT(hpd_pin);
+
+		__assign_bit(hpd_pin, &i915->display.hotplug.oob_hotplug_last_state, hpd_high);
+		need_work = true;
+	}
 	spin_unlock_irq(&i915->irq_lock);
-	queue_delayed_work(i915->unordered_wq, &i915->display.hotplug.hotplug_work, 0);
+
+	if (need_work)
+		queue_delayed_work(i915->unordered_wq, &i915->display.hotplug.hotplug_work, 0);
 }
 
 static const struct drm_connector_funcs intel_dp_connector_funcs = {
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index f503cb4cd721..c6dd35cec799 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -156,11 +156,11 @@ static int dp_altmode_status_update(struct dp_altmode *dp)
 			}
 		}
 	} else {
-		if (dp->hpd != hpd) {
-			drm_connector_oob_hotplug_event(dp->connector_fwnode);
-			dp->hpd = hpd;
-			sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
-		}
+		drm_connector_oob_hotplug_event(dp->connector_fwnode,
+						hpd ? connector_status_connected :
+						      connector_status_disconnected);
+		dp->hpd = hpd;
+		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 	}
 
 	return ret;
@@ -176,7 +176,8 @@ static int dp_altmode_configured(struct dp_altmode *dp)
 	 * configuration is complete to signal HPD.
 	 */
 	if (dp->pending_hpd) {
-		drm_connector_oob_hotplug_event(dp->connector_fwnode);
+		drm_connector_oob_hotplug_event(dp->connector_fwnode,
+						connector_status_connected);
 		sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		dp->pending_hpd = false;
 	}
@@ -621,8 +622,8 @@ void dp_altmode_remove(struct typec_altmode *alt)
 	cancel_work_sync(&dp->work);
 
 	if (dp->connector_fwnode) {
-		if (dp->hpd)
-			drm_connector_oob_hotplug_event(dp->connector_fwnode);
+		drm_connector_oob_hotplug_event(dp->connector_fwnode,
+						connector_status_disconnected);
 
 		fwnode_handle_put(dp->connector_fwnode);
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 6302caa0bd51..fe88d7fc6b8f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1336,7 +1336,8 @@ struct drm_connector_funcs {
 	 * This will get called when a hotplug-event for a drm-connector
 	 * has been received from a source outside the display driver / device.
 	 */
-	void (*oob_hotplug_event)(struct drm_connector *connector);
+	void (*oob_hotplug_event)(struct drm_connector *connector,
+				  enum drm_connector_status status);
 
 	/**
 	 * @debugfs_init:
@@ -1980,7 +1981,8 @@ drm_connector_is_unregistered(struct drm_connector *connector)
 		DRM_CONNECTOR_UNREGISTERED;
 }
 
-void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode);
+void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwnode,
+				     enum drm_connector_status status);
 const char *drm_get_connector_type_name(unsigned int connector_type);
 const char *drm_get_connector_status_name(enum drm_connector_status status);
 const char *drm_get_subpixel_order_name(enum subpixel_order order);
-- 
2.39.2

