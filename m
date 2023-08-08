Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1439774C4D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHHVE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbjHHVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:04:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B644267FE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:03:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so930226e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691528595; x=1692133395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8zHT0Zsqj0DMiFej1WNo9eVzZZclVqVsx7269nV/OQ=;
        b=pqR6K3CgsFQcjWft6t18Ysccvsoskmce1p14E9WnFNA41dxkcLK8Io49JTfkjHk7o5
         TbUBqMP3ZperyK3G2YGX+khvtOhISg59nw1U4Yaoj3JLLr9hF0fMdOrGsWd2XK4go4Ap
         /QhTJEhJ1CvPINBUPFIj+rySRnthLLEN0UeggyvwBZBg7YrA9p7ovInlg75GaT9D4Drt
         5XEQAHC5UKF7O4WDTCBDjfXbZ7zcoAJBJXGkMMIBtRbzpoxF8JGFL8IUp7hOHDlNaZTw
         OJEigzLKz0wqn76RtuzvibmWYKvRsRqaqePsOOjs0VSWKUH2zSVp83dVZd6TyxYOAl5o
         bW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528595; x=1692133395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8zHT0Zsqj0DMiFej1WNo9eVzZZclVqVsx7269nV/OQ=;
        b=hiXSePP7PHVXmLVAXnXkODJKT2lwwQQpSS5ZfkO+UNZjNLjwxEe05xxwAz/EAZCAr7
         6MQXCoXLZ+r5KKcVVSdQ+3gJkTZE8PbM0gcIGtJ5Nr6/Qk49s55KaAfyoRoDkJr0r3BW
         fIibxa1pl25tb352DEJ04ykLpxApy3ubFA59aGOD9cTKzV+DHxiMkKLlVlMtJ8MPn90U
         Sk74ouLyQ/DW04G6yrOzvJccyPZHuHEmEXjXw5XlzxLAt1r3poG3QyWLwHm3et0RbK8a
         eJGQplk/Ll0DT591ViHZ53RHeWiWia3X/CEStUjdyaLUN5UAq8GW60GSElpl09+K984P
         TevQ==
X-Gm-Message-State: AOJu0YwMBo9hLGx6ZydG0DhLBpLeCpOVNyfygmgZWAXb6l50AO86zdyj
        prc9MdIAvBx/HGdQu/vHST+GuA==
X-Google-Smtp-Source: AGHT+IHEk5xv0mOBDNw2eWsuftaz3iiVhy7A62TD88UdcHsAnsRdnmxXvi3j2UDwm7XRbKulViS/Ig==
X-Received: by 2002:a2e:3c10:0:b0:2b6:b6c4:6e79 with SMTP id j16-20020a2e3c10000000b002b6b6c46e79mr466475lja.1.1691528595593;
        Tue, 08 Aug 2023 14:03:15 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id h11-20020a2eb0eb000000b002b6cc17add3sm2431483ljl.25.2023.08.08.14.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:03:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 23:02:51 +0200
Subject: [PATCH v2 13/14] drm/msm/a6xx: Vastly increase HFI timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v2-13-1439e1b2343f@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691528566; l=1002;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QgEQhQstPekw5tfzihDoKDYHTujiIQxnO5xLgEm4zT8=;
 b=+RtC6tfWJbx8pi3yWGD9Tybj7ws14q5BakBfIVJOPco0LbYKpv9r+tu8rXNfWunG2iFFW9Vqa
 imn604AJMwSC6s98nG1DE/rv1xVICybZjdZwSf5TWaxdTiXXA06tHZL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A7xx GMUs can be slow as molasses at times.
Increase the timeout to 1 second to match the vendor driver.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index cdb3f6e74d3e..e25ddb82a087 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -108,7 +108,7 @@ static int a6xx_hfi_wait_for_ack(struct a6xx_gmu *gmu, u32 id, u32 seqnum,
 
 	/* Wait for a response */
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_GMU2HOST_INTR_INFO, val,
-		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 5000);
+		val & A6XX_GMU_GMU2HOST_INTR_INFO_MSGQ, 100, 1000000);
 
 	if (ret) {
 		DRM_DEV_ERROR(gmu->dev,

-- 
2.41.0

