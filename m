Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAB7E75AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjKJAIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345664AbjKJAHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:07:49 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8344F8A4C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:03:32 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d17bdabe1so9523886d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1699574611; x=1700179411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8kRvGVwwQROTbtBALdJ/O4XXBQy9n/2BNY8tadKsdI=;
        b=gAqXKhejlVb2AbVBPLcF/i8azE1Ccxh0uFs1xQSqztwamlMBAfOSxIYAlVF/pNt2Ou
         0L0KsZpttJEeeRU8Dq3nRzwZsgIVU5vDMGQ/QgGJhHR/sLzzPevtR3qyG+0PXzDqnif+
         cxo7FTCzXJNKRY0VplRn7ek08Uh1V35DTMtMRVLRJXTCP/w9TFJgrpKbAWPG9NleEq+k
         xVZOviLdPGbWcZWF7PXkL9n9O2vkpoZQL+Xu3YPgr4VqO4Bz7H/XmsvFw2Lj5/PG80aS
         MLwtcWSqOpl5UGVzSYpU2AtOAneVD1lQMWs3YtZgN7FEJLSxCpufP74ekV5JoKuDbdGP
         xXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574611; x=1700179411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8kRvGVwwQROTbtBALdJ/O4XXBQy9n/2BNY8tadKsdI=;
        b=hik779JVbR7cIjC4/16LagHumj6GsPeqVfb+yvR5v/kqvo6y8wE/dl5IYtlEiMnVeB
         51+oSyxv3dMzG7MHWLXXfJcALS4G+w6Fz7H1Z6TsxoLJeJWLktpfKCRlC0SU5/bU3pzW
         6fF+lAVCzoXqjgYtHWmCSFfEa16JrPLVmsTwuDo6V/he/rW0GFNaywZoMUfEF/DVQiDR
         oUfKmtFkLkTv+HWQszlNagqUrNjfM08b3uXOJyIdgsfWQk6SUPL9N8Ywx/cXRvlYojuk
         kVleoyKI3D0YYcn5PGQAxnZ+3u0aQKLO6i4FGLge5jQoXWwlLTWKR1kjiC6iHZRx54b0
         ILNg==
X-Gm-Message-State: AOJu0YyiRja0utVEYDc2aaK4atIo0imz+p4GRCX7hJ04kYYfsIMYAi5+
        MuGbX4byEL+r5T0D9q/h0eolWg==
X-Google-Smtp-Source: AGHT+IGYCXADfCmllu0MdkQC6KJQ2Cnx9eUW550qzPyNlADCiAziRwgvnW3qjd1nZZKBRjkl2P01xQ==
X-Received: by 2002:a05:6214:411:b0:66d:1624:2203 with SMTP id z17-20020a056214041100b0066d16242203mr7062080qvx.20.1699574611676;
        Thu, 09 Nov 2023 16:03:31 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id x4-20020a0cfe04000000b0065b0554ae78sm2455969qvr.100.2023.11.09.16.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:03:31 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm/dsi: use the correct VREG_CTRL_1 value for 4nm cphy
Date:   Thu,  9 Nov 2023 19:02:14 -0500
Message-Id: <20231110000216.29979-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same value as the downstream driver. This change is needed for CPHY
mode to work correctly.

Fixes: 8b034e6771113 ("drm/msm/dsi: add support for DSI-PHY on SM8550")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v2: fixed the Fixes: line

 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 3b1ed02f644d..89a6344bc865 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -918,7 +918,7 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
 	if ((phy->cfg->quirks & DSI_PHY_7NM_QUIRK_V5_2)) {
 		if (phy->cphy_mode) {
 			vreg_ctrl_0 = 0x45;
-			vreg_ctrl_1 = 0x45;
+			vreg_ctrl_1 = 0x41;
 			glbl_rescode_top_ctrl = 0x00;
 			glbl_rescode_bot_ctrl = 0x00;
 		} else {
-- 
2.26.1

