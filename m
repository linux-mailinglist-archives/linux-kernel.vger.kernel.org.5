Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC157A86D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjITOgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbjITOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC644181;
        Wed, 20 Sep 2023 07:36:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29206C433C8;
        Wed, 20 Sep 2023 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220565;
        bh=lXMcFdXGAqAsjrhuAMWp5qAOuNTHDtYv9Cmznd6VTBU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RRSbc/RVuu/kOWipYUkfL0940suc8Ru6ctlxQdbjPSwLPw/M/2MO3eEuhl6fjOpH8
         D/7OFbfeiG9vDs1xevKSFZYYy+jecTYqS1nLdUm2LkV6mqimRvBkAQ/3Th31uENvul
         mHPa99AtHamXnDe4KCrv93/+bM3WcUBufKnO/aQ/ivr9gDkVOCB1m6N9bjxKwCDwwW
         wBjlicZc6iuK39Tgr1VkDqmnM/D3hOlF1t3z4cP+87bPYhnfefrJiKP9dJYmwiYCbJ
         KjkwzXf57qTDib2vqirZmBtvknxedueCTnRcyihucMpYn+KrJEo4SJI9R7JY5qwcQP
         EiSeGY8osM4Vg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Wed, 20 Sep 2023 16:35:23 +0200
Subject: [PATCH RFC v2 08/37] drm/connector: hdmi: Calculate TMDS character
 rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230920-kms-hdmi-connector-state-v2-8-17932daddd7d@kernel.org>
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
In-Reply-To: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lXMcFdXGAqAsjrhuAMWp5qAOuNTHDtYv9Cmznd6VTBU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKnczJYGhSJuPMq2blfzFW55s+TuW7dDn/+t/A7VkJOc5
 78+uubVUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIlkdzEybNVitXerN9fn7Xry
 NWVTYWSg6RPlZUqH0jOnzpCymhlcxfDPKOgZzwXnkxZe59KehzfOyf969/kPJZNdi/9/jnp7SSG
 QCQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most HDMI drivers have some code to calculate the TMDS character rate,
usually to adjust an internal clock to match what the mode requires.

Since the TMDS character rates mostly depends on the resolution, whether
we need to repeat pixels or not, the bpc count and the format, we can
now derive it from the HDMI connector state that stores all those infos
and remove the duplication from drivers.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c              |  1 +
 drivers/gpu/drm/drm_atomic_state_helper.c | 39 +++++++++++++++++++++++++++++++
 include/drm/drm_connector.h               |  5 ++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index a50589b88a79..4cdbd8979d8d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1149,6 +1149,7 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
 		drm_printf(p, "\toutput_bpc=%u\n", state->hdmi.output_bpc);
 		drm_printf(p, "\toutput_format=%s\n",
 			   drm_hdmi_connector_get_output_format_name(state->hdmi.output_format));
+		drm_printf(p, "\ttmds_char_rate=%llu\n", state->hdmi.tmds_char_rate);
 	}
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 3e0c10f2c456..0417d964a590 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -635,6 +635,36 @@ connector_state_get_adjusted_mode(const struct drm_connector_state *state)
 	return &crtc_state->adjusted_mode;
 }
 
+static enum drm_mode_status
+hdmi_clock_valid(const struct drm_connector *connector,
+		 const struct drm_display_mode *mode,
+		 unsigned long long clock)
+{
+	const struct drm_display_info *info = &connector->display_info;
+
+	if (info->max_tmds_clock && clock > info->max_tmds_clock * 1000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
+static int
+hdmi_compute_clock(const struct drm_connector *connector,
+		   struct drm_connector_state *state,
+		   const struct drm_display_mode *mode,
+		   unsigned int bpc, enum hdmi_colorspace fmt)
+{
+	unsigned long long clock;
+
+	clock = drm_connector_hdmi_compute_mode_clock(mode, bpc, fmt);
+	if (!hdmi_clock_valid(connector, mode, clock) != MODE_OK)
+		return -EINVAL;
+
+	state->hdmi.tmds_char_rate = clock;
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
  * @connector: DRM Connector
@@ -654,6 +684,15 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 		drm_atomic_get_old_connector_state(state, connector);
 	struct drm_connector_state *new_state =
 		drm_atomic_get_new_connector_state(state, connector);
+	const struct drm_display_mode *mode =
+		connector_state_get_adjusted_mode(new_state);
+	int ret;
+
+	ret = hdmi_compute_clock(connector, new_state, mode,
+				 new_state->hdmi.output_bpc,
+				 new_state->hdmi.output_format);
+	if (!ret)
+		return ret;
 
 	if (old_state->hdmi.broadcast_rgb != new_state->hdmi.broadcast_rgb ||
 	    old_state->hdmi.output_bpc != new_state->hdmi.output_bpc ||
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index d74e9c64ee88..025380ebd128 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1069,6 +1069,11 @@ struct drm_connector_state {
 		 * @output_format: Pixel format to output in.
 		 */
 		enum hdmi_colorspace output_format;
+
+		/**
+		 * @tmds_char_rate: TMDS Character Rate, in Hz.
+		 */
+		unsigned long long tmds_char_rate;
 	} hdmi;
 };
 

-- 
2.41.0

