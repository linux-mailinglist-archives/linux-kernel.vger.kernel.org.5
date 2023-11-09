Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74547E755E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345367AbjKIX4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIX4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:56:53 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BED44A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:56:50 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77a453eb01cso91604785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1699574210; x=1700179010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOGnrwGuPglkUh0+Fj19u8kSBzGFAbbmPxBOgbMVl8k=;
        b=J0p519Rt8Ua3wXuRjkUln7egoTJqPVxUaP5G0UQL3yCZQWHi7PYrWPIiafvqqzmjLJ
         tl8PrcOsxMmKPZbrtNIiqyr9LTn8urLLpyld/AAQ5XxauiA8IB8IOqpSlnBYZd8371na
         KCYemOqnh4NugGZTtwN1WzckYoY6XeMXOUVQ3Rucu+F8sURvar7t+Zr0CMZquFf4Tm6k
         5Mnc2IlL+xubCps0iXc5osf8unoCs8geVlIgmIr4J/h9oS3LwDeOJ4AVRuYv7VIhBe14
         tp0zlz520slZNj5fLn0KTXKwB+oJ09EIxkm6AfL2q/BYTIQysCwaBW+D1mYg7hqGYbDu
         cFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574210; x=1700179010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOGnrwGuPglkUh0+Fj19u8kSBzGFAbbmPxBOgbMVl8k=;
        b=OTZ8pLcAlXB5x0gaL4qu5BbISIj78mcA0QLuQsM/mFxfqKQClIDwCkb7svwStXYeVJ
         vx42YicdV2v4tM4yNwn130yUMiVV+KktMyWqeunDPgJURU1XOVNQ8eXGJDN2OPtF4PC0
         zwJf/Z1MjQmkeVnpWbHquW7+q7YwioccxV8GtqT8SwlFlZ0CNrE8UMC0SaPOm22zPPWQ
         oWm7wdyypecxvxEy4LT8z/MGuSPjj5USvriGjQ8w2ECJe2VYplyDIMlxYaXztTsCVuvv
         BCnSjpY0/dT1PWI68QhEAgUyCh0/fHPGIsXoY+G4Hik1/cPv2TqbLVPmYsTvt/Dw30L7
         r+Iw==
X-Gm-Message-State: AOJu0YxDaEisxvHkeUqRgC6wPOxVBcYC3LqxUA+ZL1i1SqUimu/MQeU8
        YaSLE4nHbK4+ye/Yvxl6oI5yjg==
X-Google-Smtp-Source: AGHT+IGCEs76KiGmSEnDezMN2gqFvgJH8aqukcTT1Et69lNkzS+DPn40neuscPII0MMkpYwp9e1tCQ==
X-Received: by 2002:a05:620a:29c9:b0:778:91f0:e541 with SMTP id s9-20020a05620a29c900b0077891f0e541mr7487802qkp.23.1699574210077;
        Thu, 09 Nov 2023 15:56:50 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id bl1-20020a05620a1a8100b00777063b89casm299211qkb.5.2023.11.09.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:56:49 -0800 (PST)
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
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/dsi: use the correct VREG_CTRL_1 value for 4nm cphy
Date:   Thu,  9 Nov 2023 18:54:10 -0500
Message-Id: <20231109235412.29343-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same value as the downstream driver. This change is needed for CPHY
mode to work correctly.

Fixes: 93f0ca6fd61c ("drm/msm/dsi: fix VREG_CTRL_1 value for 4nm cphy")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
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

