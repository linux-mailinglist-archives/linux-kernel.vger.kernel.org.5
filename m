Return-Path: <linux-kernel+bounces-60311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FF850309
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB9DB2718E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFB38FAD;
	Sat, 10 Feb 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LMb4XSJr"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C107376ED
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548992; cv=none; b=Je3ml+XyZd28qCRNu+sSQzS+cDWD4e25KrVThjs4ZfecyXySQOMy4OmDT/VJx9i5Nso6IlQ26PzFyjFwiTJ7eCJPHuBuIDWY5JcYiyeOuSlaqcDXLobANVqAawdHArNjzxV7KYyQ2kyA7ZrcDTDfhEkhYi02n4Ib7OkARpN+aS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548992; c=relaxed/simple;
	bh=jL/gG9D8lG06mow1s8GNyHxflUWLSuC/auB5hTAdw0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhdiYKBnFqXddSR2ithbAtf2BulAqNIxe44JMqfNbJm6IIPVg9xjd7+5HXFH5itM8G6St1MBSraLpzm5ZatVHjIRUsOQcFDN58SMWa2caMIUjgArzEtE5ywahjpn7NivnVene5gDi4D3ftkZIFhaue+MetDMn70GG96PxYRGC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LMb4XSJr; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bba50cd318so1220200b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548988; x=1708153788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhcGY0pJW+kaFughUNfil3pAisJaqEi+Mlm0h6qD8C4=;
        b=LMb4XSJr/AtRiNKyFWuEIB/sbAY4X5AP2GLY2VSF/Hg/fHOUkFttnS4glVWEu0ONYe
         e8d78noShDDn7RtYcNi50/D1laeKqMeke63izqYIiwLHCSo52ZKtxcumnYHeFHE8D46a
         C9QWw/u9t9RDBBwhSjuSk03QPb4/LffulCies=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548988; x=1708153788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhcGY0pJW+kaFughUNfil3pAisJaqEi+Mlm0h6qD8C4=;
        b=NcBVYvA8AoO4aEnTrwOI3/xWfbt+L2jb86duze08X+F57/5lZZHOOrEq08Run4PdQp
         TXJLMYoHiupqNT0YWB9VuhfGuuNyQ5igGXhbyWfsAY0WKBgxDAmNKX9jirnPnLq0+3U+
         YRsyNNmAF4E402hgHGm+vjPLGaQsuxvKAp6eZw9db7bTy3Wmc5UZJ4nzljN/dwDeNYoQ
         U3O1RJR1KSXsqKdOG/Fyf6pU1+ImqHdMGfMoMpHd/YuMJIeLTm+PYvPE4hFfBGi1gUa3
         5VY8MPCHK64TB0RyXSKfPkncNeD4NC0xsG9xdvpzLYciiogUA/E9tmwZque03Y82JfEn
         Yvaw==
X-Gm-Message-State: AOJu0YxuxlVFVuVpaT5Dsr7pNdF+VJBlO/J/w6m2dOG+ejMeTo0p3IJ5
	08mGJ/C6kk6z9pPhDhZedcI3/2WGBVNl+JGJQ0lreZm1PZN0MXY1NdY8fY3jgQ==
X-Google-Smtp-Source: AGHT+IFV/sFlW8qKgy47k/Il/yfb6VFTvd6pIr0PTj8o+WR+abJvSKAIoFNUNzLDpAyLa4aVU2Wrwg==
X-Received: by 2002:a05:6808:1154:b0:3be:459a:b373 with SMTP id u20-20020a056808115400b003be459ab373mr1858284oiu.52.1707548988259;
        Fri, 09 Feb 2024 23:09:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfg+QEjW5TkMN4yEs4j/hGTro4fPsmIMv+/GkLsSyKpPXxknHnXcMzvSJZhJsl1lg7IyadrS3Kjw4OTEmQ6hIJcoRx5Qmxpxt4DU50F8HnZ3rraSeppCM5Num5mdpQ5uKGPXy9XWKjnmjnyYsNlVGJmbUsVR6bzZP0Ke6I/GxDVL6hXL8xZofWfNdddRFllmzXhxZsldGorzdP0hGlRTrugqA8prmIN69jc21X9nuzmMGau/oYxAilSWF2o6Uo8PPj+nIgy4m4+QWgIO+TSHiM2qvXy/IWHaFHfmqvWXFL8tEWy37wfxdm7t2BR8wQsWdEMjEDfwyZvo7ASqhLqnBipuFS2C7IAVhf58k4yvXcNIGifcJnNwfK9HxLzLBzM8V6GkW+zpWnaAQWGmdeiG8qwkkpQqmjHuW9amz8RCQhV/lmrOVety//gSyNNFf7LNytox5MAKvNJEfGH597G684E3DrPI9MQRlRZP/fPyTjtb4gGbThd5gZQKOepaGySvVcmL4OnqGyiyLZzjz2rw/GTkHQOam37GjCWM3he2a/Wmr6E2HDBEHmiQCZOX7Gqo8bxkpzlcdzTW0Xa3Fdo+sMZiANkkHjLmrRQkRkRBR/q2tdMi3GFPQIKK50nIwxC+3ZUAnZbTxk/TWdJaGXOnsCFlG/tZuk7EnWUaHg
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id y2-20020aa78542000000b006e096ff7c91sm1645603pfn.100.2024.02.09.23.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:09:47 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 05/22] drm/atomic-helper: Introduce lane remapping support to bridges
Date: Fri,  9 Feb 2024 23:09:16 -0800
Message-ID: <20240210070934.2549994-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210070934.2549994-1-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to the DRM atomic logic to support lane remapping between
bridges, encoders and connectors. Typically lane mapping is handled
statically in firmware, e.g. on DT we use the data-lanes property to
assign lanes when connecting display bridges. Lane assignment is dynamic
with USB-C DisplayPort altmodes, e.g. pin conf D assigns 2 lanes of DP
to pins on the USB-C connector while pin conf C assigns 4 lanes of DP to
pins on the USB-C connector. The lane assignment can't be set statically
because the DP altmode repurposes USB-C pins for the DP lanes while also
limiting the number of DP lanes or their pin assignment at runtime.

Bridge drivers should point their 'struct drm_bus_cfg::lanes' pointer to
an allocated array of 'struct drm_lane_cfg' structures and indicate the
size of this allocated array with 'struct drm_bus_cfg::num_lanes' in
their atomic_check() callback. The previous bridge in the bridge chain
can look at this information by calling
drm_bridge_next_bridge_lane_cfg() in their atomic_check() callback to
figure out what lanes need to be logically assigned to the physical
output lanes to satisfy the next bridge's lane assignment.

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  2 ++
 drivers/gpu/drm/drm_bridge.c              | 34 +++++++++++++++++++++++
 include/drm/drm_atomic.h                  | 31 +++++++++++++++++++++
 include/drm/drm_bridge.h                  |  4 +++
 4 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 784e63d70a42..2e989fbeb503 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -764,6 +764,8 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_duplicate_state);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state)
 {
+	kfree(state->input_bus_cfg.lanes);
+	kfree(state->output_bus_cfg.lanes);
 	kfree(state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 30d66bee0ec6..3fce0d8d7dcb 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -843,6 +843,40 @@ void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
 
+/**
+ * drm_bridge_next_bridge_lane_cfg - get the lane configuration of the next bridge
+ * @bridge: bridge control structure
+ * @state: new atomic state
+ * @num_lanes: will contain the size of the returned array
+ *
+ * This function is typically called from &drm_bridge_funcs.atomic_check().
+ * The @bridge driver calls this function to determine what the next bridge in
+ * the bridge chain requires for the physical to logical lane assignments.
+ *
+ * Return: Lane configuration array of size @num_lanes for the next bridge
+ * after @bridge in the bridge chain, or NULL if the lane configuration is
+ * unchanged from the default.
+ */
+const struct drm_lane_cfg *
+drm_bridge_next_bridge_lane_cfg(struct drm_bridge *bridge,
+				struct drm_atomic_state *state,
+				u8 *num_lanes)
+{
+	const struct drm_bridge_state *next_bridge_state;
+	struct drm_bridge *next_bridge = drm_bridge_get_next_bridge(bridge);
+
+	next_bridge_state = drm_atomic_get_new_bridge_state(state, next_bridge);
+	if (!next_bridge_state) {
+		*num_lanes = 0;
+		return NULL;
+	}
+
+	*num_lanes = next_bridge_state->input_bus_cfg.num_lanes;
+
+	return next_bridge_state->input_bus_cfg.lanes;
+}
+EXPORT_SYMBOL(drm_bridge_next_bridge_lane_cfg);
+
 static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 				   struct drm_crtc_state *crtc_state,
 				   struct drm_connector_state *conn_state)
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index cf8e1220a4ac..b206ae2654d8 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1074,6 +1074,27 @@ drm_atomic_crtc_effectively_active(const struct drm_crtc_state *state)
 	return state->active || state->self_refresh_active;
 }
 
+/**
+ * struct drm_lane_cfg - lane configuration
+ *
+ * This structure stores the lange configuration of a physical bus between
+ * two components in an output pipeline, usually between two bridges, an
+ * encoder and a bridge, or a bridge and a connector.
+ *
+ * The lane configuration is stored in &drm_bus_cfg.
+ */
+struct drm_lane_cfg {
+	/**
+	 * @logical: Logical lane number
+	 */
+	u8 logical;
+
+	/**
+	 * @inverted: True if lane polarity is inverted, false otherwise
+	 */
+	bool inverted;
+};
+
 /**
  * struct drm_bus_cfg - bus configuration
  *
@@ -1104,6 +1125,16 @@ struct drm_bus_cfg {
 	 * @flags: DRM_BUS_* flags used on this bus
 	 */
 	u32 flags;
+
+	/**
+	 * @lanes: Lane mapping for this bus
+	 */
+	struct drm_lane_cfg *lanes;
+
+	/**
+	 * @num_lanes: Number of lanes in @lanes
+	 */
+	u8 num_lanes;
 };
 
 /**
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index cfb7dcdb66c4..5f64f6e822e1 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -884,6 +884,10 @@ drm_atomic_helper_bridge_propagate_bus_fmt(struct drm_bridge *bridge,
 					struct drm_connector_state *conn_state,
 					u32 output_fmt,
 					unsigned int *num_input_fmts);
+const struct drm_lane_cfg *
+drm_bridge_next_bridge_lane_cfg(struct drm_bridge *bridge,
+				struct drm_atomic_state *state,
+				u8 *num_lanes);
 
 enum drm_connector_status drm_bridge_detect(struct drm_bridge *bridge);
 int drm_bridge_get_modes(struct drm_bridge *bridge,
-- 
https://chromeos.dev


