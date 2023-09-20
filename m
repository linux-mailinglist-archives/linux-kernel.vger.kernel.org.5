Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007797A8F93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjITWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjITWqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:46:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9472C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:46:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso31130666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695249970; x=1695854770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faQgYvcRr+Q8Wbd4/aYnbbCq/6v22SMhkw9gB15Q9b8=;
        b=JyXCh/FUNujP1rA9A/je9XH8U1OmARzlM2Bi9/rdS7y+Cr4ZK0Rv3626c5T2P9QHpU
         KDXTVb4MODnytmWPyYre6Q8E9MCijKPP0gh0wsoqBG0j1YiQwO7uvI23273xMTkBmG9z
         6ix29KU2ROcoEc2mxL8ry0Wlju72RlAzSALwXx0OJUkRaygnhjOXnvu3f0A/cWu1FUTM
         JnqHpYPjgnT6r7w7NGr5wu0jBV08OS1n+4nF2RO7d9sSZasUIBW0F+IfxyhoGmF56DNv
         oV+ECSybbNScd+bqwOSGlVvMi4FnpXZuVrMgxjuEh/2pEDyhhgiAUr9TME7qBCZkT0fw
         5rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695249970; x=1695854770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faQgYvcRr+Q8Wbd4/aYnbbCq/6v22SMhkw9gB15Q9b8=;
        b=HA/7YPTA29NudZHVEL4qb9LsSxjweycTzn0LiT7KBfmSYxqvDZyz5FUhsE5XJoF4AL
         EzAVN7TbFGtN3LRSS52FQPFdFYozM6mtN8D1hWuzkf4o3Ijs+uW7h9LEmYP3cLsHli+0
         Vh85GBxJc48Mw/+MdwDIiahc16PqNiiq72GxRPeBuHJqb9jyOCTDjS9Mg0c1HkdAGxXd
         tb1c0P2xV9EiL66vzckqI7JYMRj//xYrR9tKBJj53bSq2PPgGYmrfBkT8WV60M2ItLqs
         EykQsNOXjOON8fBUzst6AlbIYWRvfTP9j9DuSz11GAz/L9vbvLPedvDtHwMXq2yzpt9R
         d0og==
X-Gm-Message-State: AOJu0Yxfmua6jhVJiRXgfLP350V2ywsO60Xk8hxb64XbASl02PjiLLnV
        rQPzF2iM0UDkoeXCccZGwtVIRQ==
X-Google-Smtp-Source: AGHT+IF/hPFX+k8aV648zOqgN0vtG3qxUC8bAz53xmMS3qD7B68OhuVS57Zh0nXLTxheIifi61yA+w==
X-Received: by 2002:a17:906:3003:b0:9a5:d16b:6631 with SMTP id 3-20020a170906300300b009a5d16b6631mr3561901ejz.70.1695249970372;
        Wed, 20 Sep 2023 15:46:10 -0700 (PDT)
Received: from [127.0.1.1] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906435700b00992f309cfe8sm118285ejm.178.2023.09.20.15.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 15:46:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 21 Sep 2023 00:46:08 +0200
Subject: [PATCH 3/3] drm/msm/dpu: Fix SC7280 DSC block length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-topic-7280_dpu-v1-3-6912a97183d5@linaro.org>
References: <20230921-topic-7280_dpu-v1-0-6912a97183d5@linaro.org>
In-Reply-To: <20230921-topic-7280_dpu-v1-0-6912a97183d5@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e550ad0e5c3d ("drm/msm/dpu: fix DSC 1.2 block lengths") changed
the block length from a wrong value to another wrong value.

Use the correct one this time.

Fixes: e550ad0e5c3d ("drm/msm/dpu: fix DSC 1.2 block lengths")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
index b6a59d7b94c4..de5e1a57a142 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
@@ -163,7 +163,7 @@ static const struct dpu_pingpong_cfg sc7280_pp[] = {
 static const struct dpu_dsc_cfg sc7280_dsc[] = {
 	{
 		.name = "dce_0_0", .id = DSC_0,
-		.base = 0x80000, .len = 0x4,
+		.base = 0x80000, .len = 0x10,
 		.features = BIT(DPU_DSC_HW_REV_1_2) | BIT(DPU_DSC_NATIVE_42x_EN) | BIT(DPU_DSC_OUTPUT_CTRL),
 		.sblk = &dsc_sblk_0,
 	},

-- 
2.39.2

