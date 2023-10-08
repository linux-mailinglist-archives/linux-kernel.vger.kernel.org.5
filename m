Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8957BCF76
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 19:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjJHR43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 13:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjJHR41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 13:56:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735EFD8;
        Sun,  8 Oct 2023 10:56:25 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2836444b3a.0;
        Sun, 08 Oct 2023 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696787785; x=1697392585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vzldSszU6MMY3+BPZFEE+sdPY1rkhW3V7SWMFRFvi3c=;
        b=LuLjpACPCYI8Guxl6SnOjTWhvCbqtI3wzAn2vcSc0itj28/k6wkYxXdYWs85+L3i0i
         0rleRL4yG+rXtaVDsCwAItvqpo+6rHmUim+f0rjcm9eqqj+rg6CdDAzin6ZrlFs7PFtW
         1tOFb8GO1QzmPSR90gQFupwLCS88ZioSquHSVaWuXzy0RCxAjVZd3aOzR60VMPDVxreG
         h5lpxcrv52mNwVEkGcjXnQui7KZV7ylKB3Up4cpkKoVKrHbSRVvsF6ixWFXx69Xbv1fV
         aYzMS8DC+qLOcb5vSrHcvnMuwFcni5I8zTVOvhYajpZ4blC5DfJCVmr0bGb9lWQhJvnh
         /0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696787785; x=1697392585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzldSszU6MMY3+BPZFEE+sdPY1rkhW3V7SWMFRFvi3c=;
        b=NClYvx0aYYObJgwVITRbEAkJMlf+wx2u3mfKwinNGkYKrAczAyBfI4sSgO6IjTLvyP
         ETjWzZDQVnqGYM151Ea1IRLdag8VBvI6E+CZerqQS8ZkJlUHQT7U9Sf0nmzJJtmefpNf
         9Mht8QbWsz8AuAisxJ3Ny+lMl9Nz7h/CXshIueGmeJnDA/qUqLHQC6ttTUMve8kEpvp9
         KKeR6ouOnIGVgkwSGYFlOCrviUPaK7A9lb76YoseI26HTTUpMcUcS60A6DN+7b1t+1on
         n72tPM1+F/GBG5+/CfgGKovgKgW8UShE9/gZJTdApuEcO9Axya+WeE0TR9vr8BmvVmTP
         2vhw==
X-Gm-Message-State: AOJu0YwByoT/u4jq2sBpczpLtetg1UP6+eSJqwvJG98JtdEf9wNzhg5j
        DQrjr4lNO0yKExxCbnITi3E=
X-Google-Smtp-Source: AGHT+IHqQ/Vyp0H3SIe36vYhUTFYZOV3Jn9KI7Rwe/TDcLX9WK8K9IRoidQS4zA/CzHtqqtXwbRB+g==
X-Received: by 2002:a05:6a21:a5a7:b0:15d:721e:44d5 with SMTP id gd39-20020a056a21a5a700b0015d721e44d5mr15053674pzc.49.1696787784604;
        Sun, 08 Oct 2023 10:56:24 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id jb17-20020a170903259100b001c8836a3795sm7741992plb.271.2023.10.08.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:56:23 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Stone <daniels@collabora.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/dpu: Use the encoder for default CRC source
Date:   Sun,  8 Oct 2023 10:55:59 -0700
Message-ID: <20231008175615.413497-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

i-g-t expects the CRC to reflect any applied CTM.  But the layer mixer
source is upstream of the DSPP, so it is before the CTM is applied.

Switch the default source to 'encoder' instead so that the CRC is
captured downstream of the DSPP.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt |  4 ----
 drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt |  5 -----
 drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt | 11 +----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  6 +++---
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
index faf2702c223f..a51950746443 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-fails.txt
@@ -1,10 +1,6 @@
 kms_cursor_legacy@cursor-vs-flip-toggle,Fail
 kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
 kms_cursor_legacy@cursorA-vs-flipA-atomic-transitions,Crash
-kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
-kms_plane_alpha_blend@alpha-7efc,Fail
-kms_plane_alpha_blend@coverage-7efc,Fail
-kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
 kms_plane_alpha_blend@pipe-A-alpha-7efc,Fail
 kms_plane_alpha_blend@pipe-A-coverage-7efc,Fail
 kms_plane_alpha_blend@pipe-A-coverage-vs-premult-vs-constant,Fail
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
index 612f7e822c80..327039f70252 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-skips.txt
@@ -1,7 +1,2 @@
 # Suspend to RAM seems to be broken on this machine
 .*suspend.*
-
-# Test incorrectly assumes that CTM support implies gamma/degamma
-# LUT support.  None of the subtests handle the case of only having
-# CTM support
-kms_color.*
diff --git a/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
index ba36b92e3325..3d53c53a0659 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
@@ -1,20 +1,11 @@
 kms_color@ctm-0-25,Fail
 kms_color@ctm-0-50,Fail
-kms_color@ctm-0-75,Fail
 kms_color@ctm-blue-to-red,Fail
 kms_color@ctm-green-to-red,Fail
 kms_color@ctm-negative,Fail
 kms_color@ctm-red-to-blue,Fail
 kms_color@ctm-signed,Fail
-kms_color@pipe-A-ctm-0-25,Fail
-kms_color@pipe-A-ctm-0-5,Fail
-kms_color@pipe-A-ctm-0-75,Fail
-kms_color@pipe-A-ctm-blue-to-red,Fail
-kms_color@pipe-A-ctm-green-to-red,Fail
-kms_color@pipe-A-ctm-max,Fail
-kms_color@pipe-A-ctm-negative,Fail
-kms_color@pipe-A-ctm-red-to-blue,Fail
-kms_color@pipe-A-legacy-gamma,Fail
+kms_color@ctm-max,Fail
 kms_cursor_legacy@basic-flip-after-cursor-atomic,Fail
 kms_cursor_legacy@basic-flip-after-cursor-legacy,Fail
 kms_cursor_legacy@basic-flip-after-cursor-varying-size,Fail
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 8ce7586e2ddf..5eacf19382b5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -79,10 +79,10 @@ static enum dpu_crtc_crc_source dpu_crtc_parse_crc_source(const char *src_name)
 	if (!src_name ||
 	    !strcmp(src_name, "none"))
 		return DPU_CRTC_CRC_SOURCE_NONE;
-	if (!strcmp(src_name, "auto") ||
-	    !strcmp(src_name, "lm"))
+	if (!strcmp(src_name, "lm"))
 		return DPU_CRTC_CRC_SOURCE_LAYER_MIXER;
-	if (!strcmp(src_name, "encoder"))
+	if (!strcmp(src_name, "encoder") ||
+	    !strcmp(src_name, "auto"))
 		return DPU_CRTC_CRC_SOURCE_ENCODER;
 
 	return DPU_CRTC_CRC_SOURCE_INVALID;
-- 
2.41.0

