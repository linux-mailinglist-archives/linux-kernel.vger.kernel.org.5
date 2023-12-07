Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE680943A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444148AbjLGVbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444244AbjLGVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:30:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491B3AA9;
        Thu,  7 Dec 2023 13:27:07 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1132074a12.3;
        Thu, 07 Dec 2023 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701984427; x=1702589227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Px2TdaotpIYQ6sIN9yY8qaT1+HH5T+pH93w2l1LXKbY=;
        b=OZSGChIK/dU7FKvQLuwc5t3PiMcG5Aa+lpva/7j/L4uR6ZFY3459aMGruUCQHAImFt
         phW+Clv1rvlbkepWN3purRzhrVo1U0Ju2HeSVB3HbXLC/v+ZXpFUaYkUq3uM9Li9ORnL
         cZ7m3Gzn+xq8mPQydcScn4Qox9Wh0jnMTWNPznch9cVgmYYL2ZHE3mKfPVYesgsRCmMd
         O2+lPBwSLwHY1AZQU89KDdH0T2pAU3VKqfJjHN733j4vGr3pip5OyxSnZkP5+XQ3Y3Wq
         JJd9enr5lUWiIa4hniYc9NMht6VylsLpjrC8YeGaar39NsM4TRRoOMuGpZL4mkvbNiX4
         0iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984427; x=1702589227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Px2TdaotpIYQ6sIN9yY8qaT1+HH5T+pH93w2l1LXKbY=;
        b=soHuJWFsgMae5db+8tFpA30Gpur3B+1ZA5+U5SixtrgLHWEmTL3Hq31odbLtSCvwYL
         4EscDfzxIEswGw3vVQ7jP5ZiQB9eEjKFEN79wM9ZLwbzU8VEqQLikTtrEGXsh2tPRydG
         cBOYfoMi9wz6V5GwW8tCgBmWOfPcc+kytFyuyGARLVEMuwoXIE4bzpODL/544qw9N7qA
         oG/lA1Rm1ftJunOR2agOHEfBxtjff0D5HreZJMNIgduRZdkprlcNA/rzZ3LXq+9Fo7yZ
         QwhgusEkoHyMQb7Ns5gh7LZ8ak9rXtLc1m7pSEhgOt3oaxbG3lzdK0pTsvmJKK2MRZqS
         KCSA==
X-Gm-Message-State: AOJu0Yyp+W4WlKpBMpivlU3O1Ie9M7jdcgF5uxLe0Fd1Yx8p+lKHXdan
        o3VjnK/ZwgpJJdjwAmc6brE=
X-Google-Smtp-Source: AGHT+IHmgFAdaNpu9/4tm5vsxNdq2+tiP4Ccd9SFpbqI/bLYNy2EA7+7YCXFBASFrF7Nf+u/eTyJbg==
X-Received: by 2002:a05:6a20:12ca:b0:187:df72:48ef with SMTP id v10-20020a056a2012ca00b00187df7248efmr3188889pzg.0.1701984426614;
        Thu, 07 Dec 2023 13:27:06 -0800 (PST)
Received: from localhost ([100.84.200.15])
        by smtp.gmail.com with ESMTPSA id q19-20020a056a00151300b006cdcfd814e9sm241008pfu.147.2023.12.07.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:27:05 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Richard Acayan <mailingradian@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/arm-smmu-qcom: Add missing GMU entry to match table
Date:   Thu,  7 Dec 2023 13:24:39 -0800
Message-ID: <20231207212441.6199-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

We also want the default domain for the GMU to be an identy domain,
so it does not get a context bank assigned.  Without this, both
of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
allocating and configuring a context bank.  So GMU ends up attached
to both cbndx 1 and cbndx 2.  This arrangement seemingly confounds
and surprises the firmware if the GPU later triggers a translation
fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
getting wedged and the GPU stuck without memory access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..d326fa230b96 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -243,6 +243,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
-- 
2.43.0

