Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD27AB7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjIVRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjIVRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103A10F5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5c91bec75so20690955ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403946; x=1696008746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxN1BE4ZHdJI3Tb4/0aUqoFzscF/JkAVA7bHFE5N/Lw=;
        b=G+xjVkf1tzSjDJXOAVjx6KbdwBQzqMxl9nrx/vCYEJHW52/9DvnRkzHDDU+GMvpwYx
         HCFPHbZkFRNyjeMVz8+FZR+y7AVWphPTBICePUUmyKjKPLYeriLvZ7BmnithrpHByF8O
         lfxl8IWNcXgLVFm0HZvyPYNhYzbj2KWhO+M+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403946; x=1696008746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxN1BE4ZHdJI3Tb4/0aUqoFzscF/JkAVA7bHFE5N/Lw=;
        b=B3gb1Q6ywJgoihDjk0glz6yu3l6NKF8eyeMdOPmAxHlBvsEw2GFD56r8Bmh9psj3Jd
         5M8lA77bpu5iMu0eRRe7ZGkoBkCHfSfccwGmTE7fcTDBTDobFk5eQZChH6ktrsWNaMhV
         xrvmwiJ2xULCy7/qAvh2hQfj8sElitGFOkAsKbPZ+kCZFc4P28MvEXhO1FsduxKMUX+8
         zqF0k3okLEIntO9DgJC8w/lgbjtOvjb/L09kjlji3FzKbZXWG4edX2INJTlja9JtbRsH
         gvgWuKsaMlafzIdFnYSv/zw2yT6W/yHepiszqdTaktmhsnhtYNGbpvhcxXHVlyMx4pDs
         76Uw==
X-Gm-Message-State: AOJu0Yyc3JvvprsaoUGuKilqNMd2JK0aTpEN6n2qzEQXj7cJGV3KAPTi
        zhxFfkZ0XbonRxmlUL51jsUvcg==
X-Google-Smtp-Source: AGHT+IHpTYtMLZljw3Sh/2pMQIX0En+h4Su4SNUMi3DNa2iGY9L/q/V/+eQtx1KiOAmrYJVdnVJEjw==
X-Received: by 2002:a17:902:a40c:b0:1c3:3c91:61cc with SMTP id p12-20020a170902a40c00b001c33c9161ccmr147291plq.13.1695403945727;
        Fri, 22 Sep 2023 10:32:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001bdb0483e65sm3738592pls.265.2023.09.22.10.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:32:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Airlie <airlied@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Emma Anholt <emma@anholt.net>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        John Harrison <john.c.harrison@Intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Melissa Wen <mwen@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Le Ma <le.ma@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Prike Liang <Prike.Liang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 5/9] drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
Date:   Fri, 22 Sep 2023 10:32:10 -0700
Message-Id: <20230922173216.3823169-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=keescook@chromium.org;
 h=from:subject; bh=IPCNKuct38YwTzB2zIOXZz855pzU163uvmhflCBSQWQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+ePLJ5Y9ji0102KrPkzSXaeWKfcfISds5DF
 aJ14tx1Y4aJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JtXrD/0RXHf3wSRStY2vqlZH/um0jQPMLbKbehlFgssNmiWNKLGOpr9br8S3vwu1QvHGz1HXrqy
 ek4gD5gpWq9HZI5TJ2S0ATi0PCNLJBhXIuhc34RvAQY4zFQ3xDP1+U9nxWirglYoYpY8M62/YSo
 B0HX0gFwkDnSKjEiTZRLqLNrHJ2uDlJPrCaCz4/eG9EdAXU5odsdQXdC9MXbzm7VxjwSRLgFwVK
 GHLJXusf7Ruisahsoa0m9dY0LDoKPcUPSm6nZyyulGzjj8O7nZD5mkW5LmE3acjay9ccGO6xVQV
 CEmQ8fU5KxWIXh39kd9vqnEzf3cWZgF/XottaJZSmQfT1Ch1cecAsaQT61aXa0XgwnSoBRR1Adm
 pc0Dq6V8Dq2SSnL3qijLYnz0JJZIxQ2Vea1R0y83xCcXxYu29UWHu78xEIII3D5O3DQH7LTIFRk
 64XrJvEWliQkDVEjTU9AAQ1DmI0+XI32xp59hVd2qxbLXVzaJbyW96YRrwk0Z8tybyQKuBGbl+N
 UjYgjPXkrQlaLwdvsSB5hxsSwDYFtZYt+C8rKOWeJuWm6hWS/WNw8to6mNAPP2UcQkbXemA4N1n
 LDw+BMjjOgfNdMdxGQwv3iqnBs5Ov3VImnlMxKxr+X4ixt4v0594/VlXa7PXU40u430EsrX9Bgl 2ggHJiZsUawsmBg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct nvkm_perfdom.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
index 6ae25d3e7f45..c011227f7052 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h
@@ -82,7 +82,7 @@ struct nvkm_perfdom {
 	u8  mode;
 	u32 clk;
 	u16 signal_nr;
-	struct nvkm_perfsig signal[];
+	struct nvkm_perfsig signal[] __counted_by(signal_nr);
 };
 
 struct nvkm_funcdom {
-- 
2.34.1

