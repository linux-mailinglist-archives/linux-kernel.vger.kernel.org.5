Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E3F7F8DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjKYTL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjKYTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:11:55 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3857DF7;
        Sat, 25 Nov 2023 11:12:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cbe7386263so1960912b3a.2;
        Sat, 25 Nov 2023 11:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700939521; x=1701544321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xk3ugOVnpI2pTDfmgiF4q+i5xA4WKTzHI6DOtI3zDs=;
        b=mlAB4vMy4xTyrA3pmxnwQoCLVqy02baGFi6C19j/y+WoQWS5GuXgfWJv3NiVHVrBRX
         wRa02zTLJJPLaIax15XT7jp67BJa93qUzmELq3zWzDotupAA1GSoTZg1fuVGWep6ZL79
         WRyEXFGCkfO8gGgA4aj2MLFXyywukY+fSYkXprLvitt+rVAUIfRquZ0f5pJXBxUidlok
         WfspgZo+AO6432qjcJTA51A0kjlJBZnFBtjg2O67oDiwzs6FvHkxsLGlmbTH49KU7PLM
         8CnTLHXwWBhYkW3KPq39QPszUBDJR6MUYHREFhtF+jRJ9wEVcpQRH3eMDtMPr0n6s5+2
         XGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700939521; x=1701544321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xk3ugOVnpI2pTDfmgiF4q+i5xA4WKTzHI6DOtI3zDs=;
        b=vtstnL8n12UmopgW1hKBRwnzwyAABiTxWKgzuupVADBAznx0Lt3BapAk5d3NEypU8d
         WP8vLPjA4nzgQNpUmid3tIA9J7tGRREMY3LQ2oi38oQkXHHBkUnS6APgBpAqNqIjAjUT
         OeVOw7YttmVKBcWt3loRciC+EoWVTlmYat9WHAjN2Fdb3CQbNwsiv7C0U609RhZPB0ru
         LknDj23YMVqdLUSmcI25Zb7kTHDZtFbSi9hriJIU8yrq2LJ94l7ilMnxzvoIA94d4cU5
         94673gVp7X2MKz4p2GZD+mJExlUE5hn2gGlNNovCoALe7Kpd/Lq0sNx7JFFR6RyvTf5U
         q1ag==
X-Gm-Message-State: AOJu0YzGRWDEm7nJAlchu7Cmpau5knq0BUG0ySkJ/m91nUyQyvi0n+Bs
        wjYqixQDuqTKstBZFKgzoNeo0kj1p8M=
X-Google-Smtp-Source: AGHT+IGD8naTfDUiWPBeJnR+Yo4y/9rpaGtpvxIBDO0LHhCEXLzfOPt6fvX7M1GGBFGomBPiRZcStg==
X-Received: by 2002:a05:6a21:a59f:b0:18b:558e:9ec7 with SMTP id gd31-20020a056a21a59f00b0018b558e9ec7mr7674598pzc.11.1700939521548;
        Sat, 25 Nov 2023 11:12:01 -0800 (PST)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a0026db00b006bd26bdc909sm4713314pfw.72.2023.11.25.11.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 11:12:00 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm/msm/a6xx: Add missing BIT(7) to REG_A6XX_UCHE_CLIENT_PF
Date:   Sat, 25 Nov 2023 11:11:50 -0800
Message-ID: <20231125191155.5375-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121162137.60488-1-robdclark@gmail.com>
References: <20231121162137.60488-1-robdclark@gmail.com>
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

From: Danylo Piliaiev <dpiliaiev@igalia.com>

Downstream always set BIT(7)

Signed-off-by: Danylo Piliaiev <dpiliaiev@igalia.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8176ea8da7a7..d10b22eeda74 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1782,7 +1782,7 @@ static int hw_init(struct msm_gpu *gpu)
 	else
 		gpu_write(gpu, REG_A6XX_RBBM_INTERFACE_HANG_INT_CNTL, (1 << 30) | 0x1fffff);
 
-	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, 1);
+	gpu_write(gpu, REG_A6XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
 	/* Set weights for bicubic filtering */
 	if (adreno_is_a650_family(adreno_gpu)) {
-- 
2.42.0

