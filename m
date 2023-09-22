Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A997A7AB7B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjIVRdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjIVRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B87CC7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c465d59719so20699515ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403947; x=1696008747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDHDeV42Frwj7XYTpJqGl5ND8N8KbUFLGf1moqK0weE=;
        b=ba1nxS/RqQHudZO4/x3fannYl8NGDAPfxRiqZFu3wSv2oJcnNc9A/3yciGOdP3JbwZ
         v4WVBTBbRBwcsS0i16jxBNbjUAsLJigQwnBtmwlklDwOVaz1dW3l875ih6BrEIj3GH50
         LSlMP23XgZd3+7BZDEjx/cnfCqOV14b7g59NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403947; x=1696008747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDHDeV42Frwj7XYTpJqGl5ND8N8KbUFLGf1moqK0weE=;
        b=oOPgpEKR7YYCeii+npI0LkAzimVBFGKgTBXjhDZ6TfNMqtFWLYEwsOWaTA+0DPjqSx
         YNNYOtu2fPVsCFvqvoYjMsCAhmNOs2eRXsOnaDVKaF4++LQ2yrrjJia1YM12CMUr6SKG
         XEziiIV2bznCUH4mS5hCqEV7DSs/cXuDr9KFchgsdZOLCcxJ8uveoXSR7LKIPOQUdBDC
         dsmFO17F/bsRqSAl8eZs+1uPt/XPUhtfFYrbPDxt1Ke0hiH15Xv3l7eDmPcQxSZRK9Kv
         UrfJzmNva9FlvRHozAMOCTgQGMpE2ZFlvdzjP5ICTTFJSXKt26xgQPojI4kmsMeBoR4R
         CY8A==
X-Gm-Message-State: AOJu0YwgEHVcvTzSxsLF6IkyGhjojfIOua++/rWMhEVqi7OauvOkaojC
        1TgPuI2YLEr4nPryvguZyVG4uw==
X-Google-Smtp-Source: AGHT+IEC3lNqd6k67JPujYxNrx9QHnlj6kWd/En5u8yIwMg5BjeP/3s86llo86YUSFuXOu6sjLAyYg==
X-Received: by 2002:a17:902:e802:b0:1c5:efd1:82b6 with SMTP id u2-20020a170902e80200b001c5efd182b6mr188724plg.30.1695403947353;
        Fri, 22 Sep 2023 10:32:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001c5f62a639asm67076plg.196.2023.09.22.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:32:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Airlie <airlied@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Emma Anholt <emma@anholt.net>,
        Melissa Wen <mwen@igalia.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Evan Quan <evan.quan@amd.com>,
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
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
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
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 9/9] drm/v3d: Annotate struct v3d_perfmon with __counted_by
Date:   Fri, 22 Sep 2023 10:32:14 -0700
Message-Id: <20230922173216.3823169-9-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922173110.work.084-kees@kernel.org>
References: <20230922173110.work.084-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=keescook@chromium.org;
 h=from:subject; bh=SnNIrp1FHi4lB0nFNYirvVw5/7/jvEw6i/lP/RJRA6A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+e3L4G5PZF7SaBMxHwj62ZCFc4FzMHTqhT9
 tfDr8MgF6uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PngAKCRCJcvTf3G3A
 JnkWEACXtjUq16fS873Hx8yyB8djpvoH6XVS+/OuSPCo2t7GIoIpy1zBkPiH2Ei14JMNlHdMGGy
 8yOKrl1rGoQOP3jjY04cxJWy1h5uFFHAxW6VGYIBsbbFRIqAXuVC4UKEN+qYZ97MTJmwc0eHVdX
 Z441sTRctCLNHoMhSAQn6O3TWU2+/QOV8cz2Ls8cuKVLErRruCIa6OzHgGSnhC5Rq1OWXZyJNiQ
 1aWVoVn67WL0VqIe3RW1cZvMnlWNTbgZP1DUee1eLb7MmfT7XMLkW6Jz/8rTfAeSUSsLhxKbIcO
 ZpXIWrrfcefYP4Dz3BMU6z9OLUAHdpdLEnnvQyDviUPLmbRyS5mdJpKrC9XT7FTANcayQSTonRu
 M12CaA8ASNf3ak1iu7o4DhTMZeHyb2Wpz2kwj4Nyg6YzYpRNC2gtRkBRdxIJn60r90kd27Yxl7Y
 Hb+w/DnzIvunJlaIiKWIEE9lJfyZWF2fgi9gcXtI26HlMj/Jn9jmdHnLwh96IqxloMmooRdvULL
 NK01ICP7mB/XJ36KSBZv5ss3B5LUV9OwyC4T2xpvqKmG/iSr65/EUsg0AYInGQ5v0STKkN7TYFV
 abYOWvuq0o/pltuNX+Gpbsn9+VvBaxhF2CeSHtOP8ARhgkctRhQJ2+OhqQ35i3SIQBBSkeCOxlL 2y59f7fhlJo6LCg==
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

As found with Coccinelle[1], add __counted_by for struct v3d_perfmon.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Emma Anholt <emma@anholt.net>
Cc: Melissa Wen <mwen@igalia.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/v3d/v3d_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 7f664a4b2a75..106454f28956 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -59,7 +59,7 @@ struct v3d_perfmon {
 	 * values can't be reset, but you can fake a reset by
 	 * destroying the perfmon and creating a new one.
 	 */
-	u64 values[];
+	u64 values[] __counted_by(ncounters);
 };
 
 struct v3d_dev {
-- 
2.34.1

