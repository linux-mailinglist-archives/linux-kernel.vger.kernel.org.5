Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6C80BC85
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 19:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjLJSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 13:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 13:06:57 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D47CBA;
        Sun, 10 Dec 2023 10:07:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so3155621b3a.0;
        Sun, 10 Dec 2023 10:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702231622; x=1702836422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTV7HGPkUIAwckXy51M7re7fb1HUU7ow6BY0UtdbRw=;
        b=h3Ix7O5Zrf5MxCHP/1lsSxPl0sJJV757ZR32lHB5IQ6LRtRtdQvnzE/FSlMeSJlpIr
         9Rvn0bCWeEHMDs33nCDrAoo+aQAx9BCWDg3Koe3iWFU0Hk78spMBlO7MnAMkqMZBOsts
         AbsTUcTANcZdAuetRJY4flzaRKzvgZTFIvMZAwt/oOujR0EcbgllsFoMUe8tTTJDeAC3
         jSwfwHlJxKU03YEZ/OkCSG87MMDjRvk1yyipNGT4X+jxgoWTqH1B0acEPn/MyTwDfXnb
         /U8LNG/lWwemrPR71t/TdI9jasYQlZ85hEj3FxS35Jr+jw0cHSwh8jfNfRwVi/K0bq0s
         i7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702231622; x=1702836422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OTV7HGPkUIAwckXy51M7re7fb1HUU7ow6BY0UtdbRw=;
        b=T/4MRPYoFWxqqIL9pJxU20hDSyckyY0cs5D++1GprXF7hFSrPFSHzgkhhFuV7zOqhq
         RZvQxSsN+YoqFqGu+g5HLYK904iEb4EUp/BVIBog1TES6ke2bnQesPkClVIpeDGiXICr
         0spWn5MSbZ/2oLEs5k2X30dp/k2ldKGz+tffXF1HgP0//OPk2O+q67yiTStHx/iQ/wzZ
         5k/fdQnXqNHGDnGu2Jiufa9y9z7PL9pEJpn94pXPEK4zOXBFVdbi+yBy59R6ZsOl8lFI
         A3iKCjVhCm9hV/XVbtGoWY4LWWMeqFhzcMDtZg/DnxX37FSwlaIr/OQS70Zl4UhMceF4
         Y5GA==
X-Gm-Message-State: AOJu0Yw5aNPffI++xAfTuSrtlvlKTZnKzWdRtulkEWFTmy0TA1dlYc0Q
        IVar/Cvtmlpdr0MGLpU5UmA=
X-Google-Smtp-Source: AGHT+IGf1cjoJui1YLxDAmJIwqwz1hXkSEY0wBxCHb7JCefydWE1QX71XuqaZiGK7iUv67Arc0VJrQ==
X-Received: by 2002:a05:6a20:7f9b:b0:18f:97c:8a3b with SMTP id d27-20020a056a207f9b00b0018f097c8a3bmr5034958pzj.102.1702231621767;
        Sun, 10 Dec 2023 10:07:01 -0800 (PST)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id 11-20020a63154b000000b005b458aa0541sm4769792pgv.15.2023.12.10.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 10:07:01 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Clark <robdclark@chromium.org>, stable@vger.kernel.org,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu/arm-smmu-qcom: Add missing GMU entry to match table
Date:   Sun, 10 Dec 2023 10:06:53 -0800
Message-ID: <20231210180655.75542-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In some cases the firmware expects cbndx 1 to be assigned to the GMU,
so we also want the default domain for the GMU to be an identy domain.
This way it does not get a context bank assigned.  Without this, both
of_dma_configure() and drm/msm's iommu_domain_attach() will trigger
allocating and configuring a context bank.  So GMU ends up attached to
both cbndx 1 and later cbndx 2.  This arrangement seemingly confounds
and surprises the firmware if the GPU later triggers a translation
fault, resulting (on sc8280xp / lenovo x13s, at least) in the SMMU
getting wedged and the GPU stuck without memory access.

Cc: stable@vger.kernel.org
Signed-off-by: Rob Clark <robdclark@chromium.org>
---

I didn't add a fixes tag because really this issue has been there
all along, but either didn't matter with other firmware or we didn't 
notice the problem.

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

