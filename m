Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C3D7EBA01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjKNXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjKNXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:00:27 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B382DF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:00:23 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d190a8f87so35999266d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1700002822; x=1700607622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0WgbXh9MgeOn39Qx8ZOYsj5qd/Y25XhdC9fJIxz5E4s=;
        b=RKcBAgWzwpuaF53vyGMChIbEq5G8PjzPIKTIS25eDYG7vAvXCUnjQBz8UegkTPxbvy
         hsa8AWuvuhVz4ZY3LC0YNX5SjnDwW4+R95VCCH7VmovbWWa5e7tFSBQ4MSaD6+CgmQOd
         rGlgfzP/WoNOu7bkqcO+XtVWAoajh9LKEbNFUdBzqLVMOYVpRs7hcX43KsFvtiI8wjeu
         LyJT0vPxDNOlQSQdUS99ECKJO6vXVMjQKnM+HCGmOpV1wPvNge9Hld55Y0UMVBZz2iQ1
         5kdg3UL/YDGMe/E64Ph+7pzOFk5Fa6C9Rl0vc4U67aNQgyeM/Wi46+NSPVsbjI7Am6ZL
         AUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700002822; x=1700607622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WgbXh9MgeOn39Qx8ZOYsj5qd/Y25XhdC9fJIxz5E4s=;
        b=BsI3Tlun2juoV+Oz80SALLay/ZHfoY5lKujcAaJWOtTC8Nw/nM5SWjWuofHOT2MOfh
         3dZ+AREbf6EacdXfonAcXxHxNVWEEEBAa5hsKSrof2rehyUwHRnxhLzeGpXY/d3hb/ZH
         D88d++t2SFcdTNScMBW0BhODUKr/LRyaiOOSU21VVoVRyytWejH0Fy8+8apPHza5wuIO
         G4GQe2AkPhoEy7t61JzotQLoMSBDVJfsxGZ95C13I6q5qxDuF9EE0WtvCTvqQyk1uz2o
         qSobDJaGcnYZaDtJRJ6UQ3Q0mybzCWXh2JWpYHR2Q08JtntRM5R1UzQdUhLrVqKd+vy7
         WlLw==
X-Gm-Message-State: AOJu0YyNPniOR7OFNx6IaX0oTJz1O269lGZjRu3kIoPLbX9jt1lCrbLw
        30q/QTSqtX6zS2kLo2cM673axQ==
X-Google-Smtp-Source: AGHT+IFnjqTgSRAEEv9oTG0p8gs1SiKRgR8rwDL76VdXJfcgXZJsNySy8WBq1Lpu5ZkIr/aU+PwDZA==
X-Received: by 2002:a0c:fd81:0:b0:670:710f:203a with SMTP id p1-20020a0cfd81000000b00670710f203amr3645510qvr.59.1700002817358;
        Tue, 14 Nov 2023 15:00:17 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id u2-20020a05621411a200b00674a45499dcsm25274qvv.88.2023.11.14.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 15:00:17 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Arnaud Vrac <rawoul@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Jessica Zhang <quic_jesszhan@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vinod Koul <vkoul@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Subject: [PATCH v2 0/6] drm/msm: DSI DSC video mode fixes
Date:   Tue, 14 Nov 2023 17:58:28 -0500
Message-Id: <20231114225857.19702-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: added new patches (first two patches) to get DSC video mode running with
the upstream DPU driver (tested with the vtdr6130 panel)

Jonathan Marek (6):
  drm/msm/dpu: fix video mode DSC for DSI
  drm/msm/dsi: set video mode widebus enable bit when widebus is enabled
  drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC (fix video mode DSC)
  drm/msm/dsi: add a comment to explain pkt_per_line encoding
  drm/msm/dsi: support DSC configurations with slice_per_pkt > 1
  drm/msm/dsi: fix DSC for the bonded DSI case

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  2 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h  |  2 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  | 11 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   | 13 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h   |  1 +
 drivers/gpu/drm/msm/dsi/dsi.h                 |  3 +-
 drivers/gpu/drm/msm/dsi/dsi.xml.h             |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c            | 50 ++++++++++---------
 drivers/gpu/drm/msm/dsi/dsi_manager.c         |  2 +-
 include/drm/drm_mipi_dsi.h                    |  1 +
 10 files changed, 58 insertions(+), 28 deletions(-)

-- 
2.26.1

