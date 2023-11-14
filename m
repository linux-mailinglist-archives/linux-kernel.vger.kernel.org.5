Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D827EB5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjKNRoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjKNRoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:44:22 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E1193
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:44:14 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77bac408851so564714985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1699983853; x=1700588653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxJSud2bUpEWb5+zdKhsCdpc+jFCEiyn/rkkbqMyRnU=;
        b=H46kxdtM39JzFf+LiuZsCA4xkC9uXqQPJJmPtN8byJufdLblbxs8j9x84ekLl5Vd6e
         aMsG4JU+0vI8Pv/bFXzOx5UoA5+ZTlCkWfQltXAe70Spdhb3h1OetvPcn7QRjcMuhWaX
         HEQz5WszLmr6TEw6wJosYC3CUwUr8TYJ9EpZ2+WsUXzPrjkyZ2KI1RJCSuNzvs08MkQb
         CifyUDKl6k5fMz2iP9MRTIHx5Y0G7qXmNLzAW3GUozrRUCCIWCZbt7PCSSHiyUHCq9+u
         tM6F8UN11YjPbSdBEeZv1tvKToSishGG5eHPImFn7u8vMJz0RowHq4bjEOTKqLxKR7bj
         6EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983853; x=1700588653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxJSud2bUpEWb5+zdKhsCdpc+jFCEiyn/rkkbqMyRnU=;
        b=BmJhukXjbyqMqNaMP0ZOaGv8XvaqsodyMqlQyer8+WBGLFegDvAjhSu7YF0A2gjV0J
         67oASEfwUhdiOHGMNRdHaYvB0RmBzNWpHoMMkSLambt8mI09EaM2fR2yqs7McW/1WXQz
         RJRnnI3HARVyCpHprJ5kge8SNrlZCWiOhGTjBVu3taGtaP7y2KCN/TTgmJmtf4ZhiHQ0
         yK+T6lwlIlqe4QtQdPKfnytDv5ipNrsrvQXV7U7828oNgq+QwKEyTRcSQ87WR10erFXd
         I2M5X9kVs8fBqp+sMGQPITl+e++bbSE8Iuzw0Ohh11FqnwwBEOjM0ocQ+pPTHaYg8lcG
         0CqA==
X-Gm-Message-State: AOJu0Yxd5gaVo8fYuTw5UG/3eeaHhd1qjY33jVPghdVBdT9FvWFbzpVV
        CjWPLwbjzjDh/Oee6kuyrmX/uw==
X-Google-Smtp-Source: AGHT+IFQfSiyA6caJXGmA0kjldo9K1Mp143S3RfZtOQoQPR93hcHUbZgAlUeJDg/XI9hn6gk8MAd8A==
X-Received: by 2002:a05:620a:1993:b0:76c:b7f0:2bc9 with SMTP id bm19-20020a05620a199300b0076cb7f02bc9mr5333777qkb.16.1699983853651;
        Tue, 14 Nov 2023 09:44:13 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05620a318800b007671cfe8a18sm2833350qkb.13.2023.11.14.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:44:13 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] drm/msm/dsi: fix DSC for the bonded DSI case
Date:   Tue, 14 Nov 2023 12:42:16 -0500
Message-Id: <20231114174218.19765-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20231114174218.19765-1-jonathan@marek.ca>
References: <20231114174218.19765-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the bonded DSI case, DSC pic_width and timing calculations should use
the width of a single panel instead of the total combined width.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/dsi/dsi.h         |  3 ++-
 drivers/gpu/drm/msm/dsi/dsi_host.c    | 20 +++++++++++---------
 drivers/gpu/drm/msm/dsi/dsi_manager.c |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 28379b1af63f..3a641e69447c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -93,7 +93,8 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host);
 int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 				  const struct drm_display_mode *mode);
 enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
-					    const struct drm_display_mode *mode);
+					    const struct drm_display_mode *mode,
+					    bool is_bonded_dsi);
 unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
 int msm_dsi_host_register(struct mipi_dsi_host *host);
 void msm_dsi_host_unregister(struct mipi_dsi_host *host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 7284346ab787..a6286eb9d006 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -938,8 +938,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			       mode->hdisplay, mode->vdisplay);
 			return;
 		}
-
-		dsc->pic_width = mode->hdisplay;
+		dsc->pic_width = hdisplay;
 		dsc->pic_height = mode->vdisplay;
 		DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
 
@@ -950,6 +949,11 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 		if (ret)
 			return;
 
+		if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO)
+			dsi_update_dsc_timing(msm_host, false, hdisplay);
+		else
+			dsi_update_dsc_timing(msm_host, true, hdisplay);
+
 		/* Divide the display by 3 but keep back/font porch and
 		 * pulse width same
 		 */
@@ -966,9 +970,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 	}
 
 	if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
-		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
-
 		dsi_write(msm_host, REG_DSI_ACTIVE_H,
 			DSI_ACTIVE_H_START(ha_start) |
 			DSI_ACTIVE_H_END(ha_end));
@@ -987,9 +988,6 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
 			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
 	} else {		/* command mode */
-		if (msm_host->dsc)
-			dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
-
 		/* image data and 1 byte write_memory_start cmd */
 		if (!msm_host->dsc)
 			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
@@ -2487,7 +2485,8 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 }
 
 enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
-					    const struct drm_display_mode *mode)
+					    const struct drm_display_mode *mode,
+					    bool is_bonded_dsi)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	struct drm_dsc_config *dsc = msm_host->dsc;
@@ -2497,6 +2496,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
 	if (!msm_host->dsc)
 		return MODE_OK;
 
+	if (is_bonded_dsi)
+		pic_width = mode->hdisplay / 2;
+
 	if (pic_width % dsc->slice_width) {
 		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
 		       pic_width, dsc->slice_width);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 896f369fdd53..2ca1a7ca3659 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -455,7 +455,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
 			return MODE_ERROR;
 	}
 
-	return msm_dsi_host_check_dsc(host, mode);
+	return msm_dsi_host_check_dsc(host, mode, IS_BONDED_DSI());
 }
 
 static const struct drm_bridge_funcs dsi_mgr_bridge_funcs = {
-- 
2.26.1

