Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6707AF2A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjIZSYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjIZSYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:24:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF0E120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so23173214a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695752682; x=1696357482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fImG1LGJjUdtZmi9fIr7EL8KTwVEILvKptZJzrzzi84=;
        b=XEKunLDPZUw2yXzXlMvXOrrJSmkA+OHZwr0JP2ug1tnLQ1G5tExU6lZaMExlbHxOqY
         p2GIyTm8eUmaQHSpx2KleUjYW4DrCYqv+ORR0uLZ3qx7HZVMkW1ycRaTBhHVtwvrE15E
         x6Ry/oTAxJ+NvRLQhPAGRxyF4pxTOxTRjOyTQDDXWnNJaDsPKY1oshtKCadkpoWKgCVT
         GUI3tuvwbdXyPsh7e5cFUMPlFxGsY7H/fC5OFbXCSRDv+eP/fLG4mnqrPRYwlvtfWca2
         8DXkdiBM2Allfcc5osumm+JaPUJ9z/CHidHYhnwkVbeqYgrYDNemkGM2UyjxUqlusCo+
         Socw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752682; x=1696357482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fImG1LGJjUdtZmi9fIr7EL8KTwVEILvKptZJzrzzi84=;
        b=IJtR8dE6z6PuJebP99Y9ebf6jiY4uWVvixhaPsTcy09oBMM7oSOXi+aDwXoUXYs5j4
         aFtlSfZBttwPOR/n62oS5A4gPJdqjljbTR6wwX8xGCtmETzK3BqxNC2UKu1FxcYlKD7e
         HOoz8K5yJgwEpQan6nj5uT9jBFD+5jgdJqn/UIFqWdrCe/RYZX5D088NLJ1ywxQlMfye
         qewJXSq2FKmN2EmEfZQ5iImb0lyEe5wgcDfcnpLX3Zw7W2nTMP8zhnS3O3stbGbFfZPa
         xfDKc1sH1C+ffLNuyrdVAevwBWOyynvjjT/IGnjAUQ8HKeGaoe5f+zIJIObNOV1M8uYf
         +vcg==
X-Gm-Message-State: AOJu0YyIKHekJCM078Iqs9Uvs0kqIJfLUoqk2q6x0/2fu0jrkQeXvax6
        5oZFjSAkxfdxvqewUZRxSb8fww==
X-Google-Smtp-Source: AGHT+IGyhzCX7pVh+DA0+lbZn90DwBp8MEe1mDcGOaXhO5brGM7FQnNVnsw4ZES8ExBZftUUH8qOhw==
X-Received: by 2002:a05:6402:35d5:b0:51d:b184:efd with SMTP id z21-20020a05640235d500b0051db1840efdmr5471808edc.20.1695752682485;
        Tue, 26 Sep 2023 11:24:42 -0700 (PDT)
Received: from [10.167.154.1] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402151300b0053090e2afafsm7020643edw.22.2023.09.26.11.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:24:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 26 Sep 2023 20:24:36 +0200
Subject: [PATCH 1/7] drm/msm/a6xx: Fix unknown speedbin case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-topic-a643-v1-1-7af6937ac0a3@linaro.org>
References: <20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org>
In-Reply-To: <20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695752677; l=1465;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3B0yIPSygi0wMpl7xpS+ZhhsZWi7J9UA34HRlycQuyk=;
 b=Iu9f1ructFVGASge8ugqNeXgxQC0RA2BFUwle16+fVrgAArXS0bQ1QC4HXS8kP4G+m1Yn6duX
 ykCLE1FvC4ZB+qXAkv5ObgAqFPAY+KWSMuSl/qkqVw74fcluxKFF3Oe
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When opp-supported-hw is present under an OPP node, but no form of
opp_set_supported_hw() has been called, that OPP is ignored by the API
and marked as unsupported.

Before Commit c928a05e4415 ("drm/msm/adreno: Move speedbin mapping to
device table"), an unknown speedbin would result in marking all OPPs
as available, but it's better to avoid potentially overclocking the
silicon - the GMU will simply refuse to power up the chip.

Currently, the Adreno speedbin code does just that (AND returns an
invalid error, (int)UINT_MAX). Fix that by defaulting to speedbin 0
(which is conveniently always bound to fuseval == 0).

Fixes: c928a05e4415 ("drm/msm/adreno: Move speedbin mapping to device table")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d4e85e24002f..522ca7fe6762 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2237,7 +2237,7 @@ static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *i
 		DRM_DEV_ERROR(dev,
 			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
 			speedbin);
-		return UINT_MAX;
+		supp_hw = BIT(0); /* Default */
 	}
 
 	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);

-- 
2.42.0

