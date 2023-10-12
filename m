Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0377C68CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjJLJBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjJLJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:01:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A8D9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:01:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso11563655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697101293; x=1697706093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+pO3IusB6Bw/Hr5HARw2srJIw0uRRAbPFroWEjy80w=;
        b=zw14G+JqMvfegXKnGVYIu0Oobmo2vv57lqNBvjJ+D8E7GSK1naqhx+92anT1RBu0Ur
         qFrCfr87BKUzGnpRz5C4041WBa/MLTwE3wGdV3pjyUojRiXzom8lKiQoAk9JBoQEoo2h
         ITpacjPqNbrXxh+9us0qHJmWNnGGJgvLkHQ8K7AVLINaQK8NGLnu91Dqr83z9sokLw+s
         I2SR20LOD3D9TwwA/2PYsZftN3urrg2ZP4B5SQpuRMqJlNK4p3EcBFUrW/hkk/bqZHle
         FtKqQyjwHYXiQ7ARjXXXxApJTqcYoK2Z9sh7+yzNrNMpfe9KM9z8s2I6skYzHO7nHH4N
         VOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697101293; x=1697706093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+pO3IusB6Bw/Hr5HARw2srJIw0uRRAbPFroWEjy80w=;
        b=gNY8Jxn4hsqpTkcKkqwsb5vp/su1ruJYgBQTvolPp/imcEqfP10pAsALrGbcbdwwHX
         CqFx9KOOQSc2HH0mban3xjk9sW+EFBn74t3USyDQ6C13dXsVEgVcDy+pWN54VKRKJ30b
         dk6+B4oZYpbsicoamBjdSHl3suWXnsyDXWjQPk4d8OeGSqME5ZPt6RlMAZ6LPRbCMRGV
         hWnmQZn3q+fwj85U8GeIsqOHVeBAJBGI9rQeTSgip1e5/9ThvJggNkVWa+Pwtf6tg8Aw
         zgLOhpGfJ0lQy3FqYsNMK8rxmfe2xZtSv8lAnjAF69t+bvh8/zwD1QWSk+v5vVaT1HWb
         Ngjg==
X-Gm-Message-State: AOJu0YxUM3EXMSlPOlpuR1MpOye68xss6D3Ds0AlSxGRKSYsGhZ6n0P2
        7lL15UDLNc5hh6XVLX4d23XhIpXpmpfV1EViPlMczzNP
X-Google-Smtp-Source: AGHT+IG8WccrRyCK/XDBM3PYDRcZNDL+ubfoPWuWJiH8G0N7gX1v/lDr8/+ydN3sEm7izyd6Uuqd+w==
X-Received: by 2002:a5d:595d:0:b0:31a:cca0:2f3a with SMTP id e29-20020a5d595d000000b0031acca02f3amr17203729wri.0.1697101293480;
        Thu, 12 Oct 2023 02:01:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4f10000000b00324ae863ac1sm17811176wru.35.2023.10.12.02.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:01:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/5] drm/msm/dpu: correctly implement SSPP & WB Clock
 Control Split
Date:   Thu, 12 Oct 2023 11:01:26 +0200
Message-Id: <20231012-topic-sm8550-graphics-sspp-split-clk-v3-0-4bcad69812d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOa1J2UC/5XNyw6CMBCF4VchXTumF0Bw5XsYF7UMMBFp0yFEY
 3h3Cyvd6fKcxfe/BGMkZHHMXiLiTEx+TMPsMuF6O3YI1KQttNRGSVnD5AM54HtVFBK6aENPjoE
 5BOAw0ARuuEFunNFoDtfSWpGoELGlx5Y5X9LuiScfn1t1Vuv7Z2BWIKGSpZMNYo65OQ002uj3P
 nZiLcz6Q1XqR1Un9apV7eq8aNriW12W5Q2NO5sCLwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2419;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xVwF2wCj+2epUmlO4jNCKz0K0MhWs+/80Nc2sJa8Kag=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJ7XpV569dzspU8hJgWuEwo8SdZzrDYfclZRso/u9
 HRViSGSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSe16QAKCRB33NvayMhJ0UDbD/
 0QQDRn+gUqbImdHyKol03IJh2u4YzK23wPoHQOWPjfG6OhkeER00qDRIWAwKhqj0pJq8vqhVCw1wRe
 3fRz1eb8RMkBhvUCaD343d+g2nr84RsynsilUmFn34YdnzK6wpKT9UV0OH2hfIRPP+IGXg/jA0WCvS
 yFLhkAgIwIDSCn80B5CWROwTr+Wx/AGO4OpqQB41vyZJX31KSGj861L0QxfaGJdEoMaR2vL+I3yfdp
 mvp4u8GWMA88UzN8c437LNRlXFGe4jhi4rQQQ062Tmz7V/aefh09I/6sR/2IH36pIfRyVexX6QUarW
 p8ZFe+sZJ9Ri3bLhyYUrAlF7HkHuUUveXpV3+rG07pEDLzmVle0wxb0bxChWMEAID66ZP0SGcWRHuO
 zOxNwcLQV7sI4R4u6lNslUTHqhRzMw72QIj583mzydiKLvyZGv1R7oS2/R+VqdtD7ztxc2BdGYYwLU
 z68/7DQmGwsrLb2N0AJPuzmiGjf7aXNKoJbiN2EnUKcKGziC+mNNJHfSmjb6eEpkt64+j0eEYd/+iC
 bFGn/w+UCkFNhZ9aZAZBWYXV/caCb22epHtqvkADhycxSBuZers26TaaQuadrr0ofRAJ+DHhxhRYe5
 O8jhfFFrNGixOOr/Gey7+cI90uub+2ncUtkXKs2o3hTG3l1lW1jx+l7j7ANA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with the SM8550 platform, the SSPP & WB Clock Controls are
no more in the MDP TOP registers, but in the SSPP & WB register space.

Add the corresponding SSPP & WB ops and use them before/after calling the
QoS and OT limit setup functions.

WB tested with:
$ modetest -M msm -a -s 40@103:1024x768 -o test.d -P 47@103:1024x768

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Collected reviews
- Add static const to clk_ctrl struct in sspp/wb
- Link to v2: https://lore.kernel.org/r/20231011-topic-sm8550-graphics-sspp-split-clk-v2-0-b219c945df53@linaro.org

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

