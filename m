Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE457CBD0C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjJQIGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjJQIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:06:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A457093;
        Tue, 17 Oct 2023 01:06:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4065f29e933so57303055e9.1;
        Tue, 17 Oct 2023 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697529979; x=1698134779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StdO7xGyH3UvCyXhFtXv4psWFKvp1DucCdvwZVAgPBA=;
        b=CcEq5js2mZ7nbHJoXQLzMjMIA6yG5y9cE5UahQTp1WNVBm8ivxykBJnAZO3MoW2nJh
         DGzaUsm62X2YIadIA8w//hWP+uwalPtLyxj4nE7oViztse7pF2XG0WhBEhMngY2btQef
         KGl/3XSfa3c20wHf7js/DGE1kqbJce4jN/MRI0ayIv49VuFPJQW5giu7bterRv2ALAzZ
         uf0J5mKfM7mglL/OZkeSlBjBQN0SjvSCZsY2IMR86br9OIdLNvAxe+7EnntOMZ4dqr2k
         kms9+NaM52J6mx8fJa3wAsrFqPLzrHy7JDidLjNORcbJ1pglkn4qocnR40HYrrpWIZFk
         vkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529979; x=1698134779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StdO7xGyH3UvCyXhFtXv4psWFKvp1DucCdvwZVAgPBA=;
        b=AH48LbKJLj3bnO3hFqAZfDunyMHk130dpYlEw0y2f4YkcMYTvoHblG1BeghiKyeQ7H
         rHMhM1IEv2gjfnIIiKFYZJtrpMc4Oc5IO4lYl849hHb1LQU2otpegqwzLwGmZiGqBA3C
         u0jL5FdNIg+kqwbXlaKsk7JYpQ7/r//UiJsH/B8JP+8x6Mh2KPfS+rAhZ54Ug3j3qjes
         H1h/uXuZFjyi+R8KwCjrJOhTkfbM3MrFvyBrXPra2pD7suKU7kucRrqPC6xKqsTBfYlN
         nsevtAwKv6WqsVKkq8hqhYeW5/6xXUagXXzYW8KK7RruzOOI3G1tl56Vvgs385E0xQS3
         4cwg==
X-Gm-Message-State: AOJu0YxklmdsjI/lrW3oLV1JLbjPXsdJAIRSBOQFwmk0cCpGJkKeeZ4U
        48k5StnB83B5/2fzUBxoHHg=
X-Google-Smtp-Source: AGHT+IFR4L3IZmU8EMr8i/pPBeWSbK4wVJmXm3XWNz2lDoOIdQiZh9xearr+dexY2Zc4QIiTdnjeqA==
X-Received: by 2002:a05:6000:1104:b0:32d:96e0:8048 with SMTP id z4-20020a056000110400b0032d96e08048mr1417525wrw.9.1697529978826;
        Tue, 17 Oct 2023 01:06:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i5-20020adffc05000000b0032dab20e773sm1072053wrr.69.2023.10.17.01.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:06:17 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix a handful of spelling mistakes in dml_print output
Date:   Tue, 17 Oct 2023 09:06:16 +0100
Message-Id: <20231017080616.18970-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few spelling mistakes and an minor grammatical issue in
some dml_print messages. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 851db026f251..218c355a97a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -1507,7 +1507,7 @@ static dml_bool_t CalculatePrefetchSchedule(struct display_mode_lib_scratch_st *
 		dml_print("DML: Tvm: %fus - time to fetch page tables for meta surface\n", s->TimeForFetchingMetaPTE);
 		dml_print("DML: Tr0: %fus - time to fetch first row of data pagetables and first row of meta data (done in parallel)\n", s->TimeForFetchingRowInVBlank);
 		dml_print("DML: Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (dml_float_t)s->LinesToRequestPrefetchPixelData * s->LineTime);
-		dml_print("DML: To: %fus - time for propogation from scaler to optc\n", (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXAfterScaler) / (dml_float_t)p->myPipe->HTotal)) * s->LineTime);
+		dml_print("DML: To: %fus - time for propagation from scaler to optc\n", (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXAfterScaler) / (dml_float_t)p->myPipe->HTotal)) * s->LineTime);
 		dml_print("DML: Tvstartup - TSetup - Tcalc - Twait - Tpre - To > 0\n");
 		dml_print("DML: Tslack(pre): %fus - time left over in schedule\n", p->VStartup * s->LineTime - s->TimeForFetchingMetaPTE - 2 * s->TimeForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXAfterScaler) / (dml_float_t)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->TSetup);
 		dml_print("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %u\n", p->PixelPTEBytesPerRow);
@@ -9323,7 +9323,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 				if (mode_lib->ms.policy.ImmediateFlipRequirement[k] != dml_immediate_flip_not_required && locals->ImmediateFlipSupportedForPipe[k] == false) {
 					locals->ImmediateFlipSupported = false;
 #ifdef __DML_VBA_DEBUG__
-					dml_print("DML::%s: Pipe %0d not supporing iflip\n", __func__, k);
+					dml_print("DML::%s: Pipe %0d not supporting iflip\n", __func__, k);
 #endif
 				}
 			}
@@ -9376,7 +9376,7 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 	if (locals->PrefetchAndImmediateFlipSupported) {
 		dml_print("DML::%s: Good, Prefetch and flip scheduling solution found at VStartupLines=%u (MaxVStartupAllPlanes=%u)\n", __func__, s->VStartupLines-1, s->MaxVStartupAllPlanes);
 	} else {
-		dml_print("DML::%s: Bad, Prefetch and flip scheduling soluation NOT found solution! (MaxVStartupAllPlanes=%u)\n", __func__, s->MaxVStartupAllPlanes);
+		dml_print("DML::%s: Bad, Prefetch and flip scheduling solution did NOT find solution! (MaxVStartupAllPlanes=%u)\n", __func__, s->MaxVStartupAllPlanes);
 	}
 
 	//Watermarks and NB P-State/DRAM Clock Change Support
-- 
2.39.2

