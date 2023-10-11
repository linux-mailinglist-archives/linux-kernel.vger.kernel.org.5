Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59CA7C52B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbjJKL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJKL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:59:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E961D94
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:59:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32c9f2ce71aso1558177f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697025572; x=1697630372; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ot7f93Hp27r8qDVUnK9M/4a8sldkjXGML24/ocHHa0=;
        b=Dbxz/ZDlhrtqmH4n8qnMtuIuwe2zzNvrf6guLMxTqziIuAOiuiBt1Ub5jF0SUIZJ82
         /brRLhIurUDr/Jk7yDkZpWb+HR5mjiEMaS1Lz3uhAA7lzFAJzcngh0UquUYodseF7M/F
         ms8QfiIsrdPqaiJZ4nBulVBETSsp3HxZe1PN+83zt/iedTrqD6cdGhKed3d0dJcmJ3UM
         untq/PJjH5S3Ty8ohSER+RetydMDXa3ss9cXSaF9GGsq9x8SBBQQfqDxGLXcbjTvl3Ab
         G8L/jU6iVcPLLyIcRADzZNfFJNRKsE5NhhJsO8dt/bkbs34+kXdVO5nrCMQjDOWAtjhG
         /Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697025572; x=1697630372;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ot7f93Hp27r8qDVUnK9M/4a8sldkjXGML24/ocHHa0=;
        b=rlywk7nT4jybKiQfLQH4Llq+sNlBLEHdaOLP6nAVUKX3S7w/IjbGAMwuPobeX7HyGh
         irE5u6ZTvQ0FVwVDQjjCiCsiui28leVoZZR2u0Yk8bp6+LT16Bl/iGQVLrbFhvw5Vq0F
         DW5qO8ZWV9+B3BtEdvNmoNeHz3GS0reocHxK78ydl51O44LwtH6LX++WS0Qpj1HYUe7X
         oYwT9RpzEDeMX9zb1Fovu4mFp80sjKaMikTNgSdUGfkX1FW41/Z1TEN0nGfLvenbJukX
         M+QYq7u8GELNaNX3AWrXhc+t0vzui/SkwpSU+Da8hOUEbY6Ry8D3xU9QtyyACOKQZQH7
         iP5A==
X-Gm-Message-State: AOJu0YxFovb7JmoSiwJbh8I6eIqD8M377TPLpEe2SK2Ysa8unuHklEi+
        HN8irZlAT6hM2Xw39eypPNnzUg==
X-Google-Smtp-Source: AGHT+IFvb4wQ7UoKHHqPU5Z1zSsGTL3s+VszjaFbAitgWa03jJE1oir8cPoJz9cdsQrlfvSOMExq6w==
X-Received: by 2002:a5d:456f:0:b0:31a:e744:1297 with SMTP id a15-20020a5d456f000000b0031ae7441297mr18257419wrc.50.1697025572317;
        Wed, 11 Oct 2023 04:59:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b00323293bd023sm15447805wro.6.2023.10.11.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:59:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/5] drm/msm/dpu: correctly implement SSPP & WB Clock
 Control Split
Date:   Wed, 11 Oct 2023 13:59:20 +0200
Message-Id: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-0-b219c945df53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABiOJmUC/5XNQQ6CMBCF4auQrh0ztIDoynsYFrWMMBHbpkOIh
 nB3Kzdw+b/F+1YllJhEXYpVJVpYOPgc+lAoN1o/EHCfW2nUpkQ8wxwiO5BXW9cIQ7JxZCcgEiN
 InHgGNz2hMs5oMqd7Y63KVzHRg987c+tyjyxzSJ9dXcrf+iewlIDQYuOwJ6qoMteJvU3hGNKgu
 m3bvr8cjavZAAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=joBcCYvrr2YjxuEEXxOdU1twtKRFCTePE37s1QUybRI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJo4g2CKQ7ubfvzj0hhrQwGQnuVMtuiepqig177fs
 ofm/zTqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSaOIAAKCRB33NvayMhJ0bM7EA
 DHv7nTNQ1a57fU//Fy6d2Uw9rd/ryhaKQTzT/j9Za2XG2zyrMGgW76JxShYe4Euy1nL2U9ATL4vPkg
 PtTL9315D6Of2aoG0BRxGeW1jLi8ekmJ2kz6tI6rgUZffXIaC8xn/m62ftvlyMKL86dWg4dc4WiICm
 79bR7hHRZxa7STbVgumFtU3OT+ctrNeuukEA2VQgA3/EkLrO7lWL2dp1UZP0eNZOOnNjahKx39XpHP
 podQbv62AncujQEkp9gh2aOmZ+omfOkCTiKNwMWCWpuhCE1XVNGV475xQxLFidB/TRoG6cMnGdNEhK
 /7b80QP7PMLMGSxBcGbzeMd+YqNUdoT9P6kYSEzD+DcN0CMGWp8bJcE9BQgbOBtIxTSLA03kiZ9fq7
 gM6fv6kfIvXtI+rpckps4hFGbvT3DyyRnG2x7rV+JL8hdacIBnTB3LNlte2qCHTYVauK/hGGZxZfwe
 kS/PrJXZ2BciNIpuRfSWv2Z0uAcBatz5SMiD8CwxsIF2FuaOmfRO9nsMO1BNxm1tHG5IA4jtS1BdBF
 z1x1qF8GAoMTxzVVkOgU2FCun6l6lRqge08QWpKaZCqj6Zx9LBf4r8/9s4xACDYomuOVmZysvfJZkP
 oHGszs0ah8hBX9HxEf5SZYR+Pceo3wjY6pliIo/DUVBKW4F6nkyV0yjtBxyg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with the SM8550 platform, the SSPP & WB Clock Controls are
no more in the MDP TOP registers, but in the SSPP & WB register space.

Add the corresponding SSPP & WB ops and use them before/after calling the
QoS and OT limit setup functions.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- moved all force_clk_ctrl code out of vbif
- use major ver test to add force_clk_ctrl op
- do not add clk_ctrl reg into sspp/wb cap struct
- add WB2 on sm8550
- Link to v1: https://lore.kernel.org/r/20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org

---
Neil Armstrong (5):
      drm/msm/dpu: create a dpu_hw_clk_force_ctrl() helper
      drm/msm/dpu: add setup_clk_force_ctrl() op to sspp & wb
      drm/msm/dpu: move setup_force_clk_ctrl handling into plane and wb
      drm/msm/dpu: sm8550: remove unused VIG and DMA clock controls entries
      drm/msm/dpu: enable writeback on SM8550

 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 36 +++++++++----------
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    | 37 +++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        | 21 +++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        | 12 ++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c         | 23 +-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        | 21 +++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |  4 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          | 20 +++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h          |  7 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          | 42 +++++++++++++++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  4 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           | 30 +++-------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           |  4 ---
 13 files changed, 173 insertions(+), 88 deletions(-)
---
base-commit: 9119cf579b4432b36be9d33a92f4331922067d92
change-id: 20231009-topic-sm8550-graphics-sspp-split-clk-43c32e37b6aa

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

