Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCCF777F76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjHJRpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjHJRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:45:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A362705
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:45:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso1822750e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691689513; x=1692294313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0GKjPDyvoAuP+M91ApLudBjH9CMGM8uGu6N/SkZfpM=;
        b=nzOkxJGTHk3Y/1sv/1gGEQXInYDnS0JfvQH0NpK/YttN7ATaXNU9tEhBJyXNI4Ha18
         XVWVZoURO07TIGzyeE1Yf5L6a4qgUZ5Y3Pz66w+aD/yrC9VuCwsUvF4hCnPYHtrUIo9x
         HyZkDOrGV3NSW/0AQWvjW98Rw+UBrGnY1rZpfsvbadJeAupaOtPjpLMlfg4mB7N8bH+g
         XQSHc5/ogAA7Rv0ekm7rzVUGU8NK19RgjSFi4HJioOgufEnSbJ4rYpAHk8fSRcdVrPlg
         3heYqMDYneo6/jQxc8Iya04yY/u1IDgsmShHAC0eNyYM/ysMAuRiEQb7/GFcaX5q0e7Y
         m7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689513; x=1692294313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0GKjPDyvoAuP+M91ApLudBjH9CMGM8uGu6N/SkZfpM=;
        b=LwfCEE9389RHta2Ljm16sNLVnK8xxMuulaR7wZi1KUZyMW4HMuR6nHExEQ+UGZlB4B
         GZOyJ1fyj/hK4dDRHnFNkcf0uy6KsEl4n9ftxt1HQyQ8jpel/sL38UMXIZm7b4g39r9h
         Lad2qERpJR4uuJZyA8xz+0qANW+wOdP33PF0HZOMVaesHBdp123VF/BVepSTCfdKCX0r
         TKkarjZJP3MBdwyIE7FihdXKkGOMo/8MVMfvxxxqZ1O9kiPOYfsBbjPlKiTyaFXP/bp/
         t0hzc0iLCcoS2xgu77iZKDjbKlJ+Vcw14FsLGyCSo/UxVyjwLajyOpwpOJINGR3baAJs
         A61w==
X-Gm-Message-State: AOJu0YzI5Ajm/UeSb0tUH1gfL4Tz+Z88ovkSCLHqEgv0eeFBXWnYhYHv
        4LpT0FEdz75vlEH/qfTxQgdrFQ==
X-Google-Smtp-Source: AGHT+IHrHDWWRhuLgKu7ea/IPjMYC4fPCs9kEh7OU2MUv8A2V7V0dAKGD/apDzrAfbANT74bxmxZtA==
X-Received: by 2002:a05:6512:69:b0:4fe:1e69:c37b with SMTP id i9-20020a056512006900b004fe1e69c37bmr2437514lfo.10.1691689512948;
        Thu, 10 Aug 2023 10:45:12 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm364173lfg.39.2023.08.10.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:45:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 10 Aug 2023 19:45:06 +0200
Subject: [PATCH 3/4] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-topic-lost_smmu_compats-v1-3-64a0d8749404@linaro.org>
References: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
In-Reply-To: <20230810-topic-lost_smmu_compats-v1-0-64a0d8749404@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691689508; l=1014;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Y7bYhGu0ASVzGb9G7odf3tduVcYO2D8/4BIOQJwrqcE=;
 b=MIYsLRtU5HUGW0mAHSXrQis/HcCiBkog6h0S8MKq2Hv2tnYu1kMBKBExmI2pRXUMnEH6dzl9q
 XaqJsyk3FKuA/WHQOlr53QrCjzqHmM77KKbrkBzp9gwUCLK5lpcugQw
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the SM6350 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index cc574928c707..bdeb587552c0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },

-- 
2.41.0

