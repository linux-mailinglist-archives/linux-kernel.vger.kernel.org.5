Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D592F7AB78E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjIVRcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjIVRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA92A1B2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-274dd099cd5so1798188a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695403937; x=1696008737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maP8YXhB08F9LY5OG0jMprTbidCF0YS16nloYI5WUaA=;
        b=jPMGIykJNivSzumkyPyfRksE80LIgODcWlNzZ0+aEgWRJvP41S1k8emA8EOw8WVeR/
         cGoAG6ZpZcL54uv4D5sEFw3p8xT5zzuJcXyq5P4Cap63VExYlV4ZGUv14bkbPyHk8YG3
         Yg9hHCz4rbId2iwFvqSSLEeZnjbNd9ekxCfVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403937; x=1696008737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maP8YXhB08F9LY5OG0jMprTbidCF0YS16nloYI5WUaA=;
        b=UNXqixh73bYKdC88wpBUQdHMPXY4COrXM/hFDPxXpQeUzPv/nzN2Awvyy4uYj3Bd1v
         GdmaV01lYAhbTmBb9m4Ff90tH2lkMoMday+N2O8UCCxiNqafuaSB80eWe9MYCKqYwt9E
         PzlRfNkCPSmHPhvC3+1qBLJmkc2z48Pb1H60M5dAS9PFb7fIeM2q82BdnNGl1plXNP9F
         DfRYbuc+yKTybHbViFW92LHMoJCNfhHLtRson6PnlT5FJp4ULRFyUnJ08dYB97pyi6IY
         b4cLlq+ooqMeOYo8Zts1vAW7bmuIAVUHgQm5zF+4I4h6dTklCMdlyih7vcXC1Gi+Wts7
         gMxQ==
X-Gm-Message-State: AOJu0Yxf8nzhK+9sRK7bhlqfWUP3s9afXqVfjny+4HMwfkUFHYhnxw5T
        wpDmetQExJwqrJIbVgO77dydjA==
X-Google-Smtp-Source: AGHT+IFdP64cY2JqB1Op9MnqzV2WwwxXXjjffHjXH+LeCNFRA7JQsw/LqKfOicOzddv9F3M/BO37fg==
X-Received: by 2002:a17:90b:2247:b0:271:c314:a591 with SMTP id hk7-20020a17090b224700b00271c314a591mr349153pjb.47.1695403937438;
        Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090a929400b00274ea190852sm3464464pjo.6.2023.09.22.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:32:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Airlie <airlied@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Emma Anholt <emma@anholt.net>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/9] drm: Annotate structs with __counted_by
Date:   Fri, 22 Sep 2023 10:32:05 -0700
Message-Id: <20230922173110.work.084-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=keescook@chromium.org;
 h=from:subject:message-id; bh=YV47XR+Dr1NybdP/JWrsHmoQYKkqVQbnuP88RsqPU7s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDc+dsj3+Vh5qemjuEPg29sGFlFmzA+yi/v3Rh
 XtvZqOfqaGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3PnQAKCRCJcvTf3G3A
 JiHwEACLzTcgywMl1i+ngflg0YluRoEeJQAxOBHxuE5H6DZMdzVg2q1O7AYcZvuFgGEob07505+
 PzEtpDzTZH/46SXLgI4Sgl0XmudzghRjlp0XTK1UC22xnOBNM9k0OIJif5wStFA/0uiZLRrHII7
 A/+AqzgBiY88gBa4O+x8Vj0+JBJGnDCr0QudEO6XyIcvvmLLgiRCce78vOKBXTXq6Dktknkayr7
 GSRsmx3ZTid9GiUDFYYu7/JLETFdk3ZPoT0iX6O1OocWU9VVd8IE71u38u38X+AdokHQtuEXbCe
 GXNdGJrLV9VqJ6qvypVr3S1EhagL/Z+f7Xz/GMY6nMu+6H9YM0Nbh7PQ8fyD/y9rlT2jcsSJY3r
 eqE3X+ATIdov/4puub/Z5OUm9R4z3dXWHGfnc/vb5l24ZPzLfhFdjlnbl4LYKnZyxK/lH0OGSkH
 9Wks6MuSdRE+bNJFV0VibfzZlV0+wemFXXSlAxxVQGcZ7CWgQaV2w7wE1Y3AMJLRthOuVUU6Kts
 VfGI7p8XZRScEI6mnWSh8w9zLZOftTtdiCxcVj1gdXRTx2/K3Xfv0UkoHgdzOBqTTEPqGetCOjs
 WS30PIjoUXxpO+DRvCTjySDsnQXksC7AsjBRhvnXyIR8tgFSEAywP6FcLYaX3ltdG79BvgAkkzq
 Bs7QmlF kGRGYttQ==
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

Hi,

This is a batch of patches touching drm for preparing for the coming
implementation by GCC and Clang of the __counted_by attribute. Flexible
array members annotated with __counted_by can have their accesses
bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS (for array
indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).

As found with Coccinelle[1], add __counted_by to structs that would
benefit from the annotation.

Since the element count member must be set before accessing the annotated
flexible array member, some patches also move the member's initialization
earlier. (These are noted in the individual patches.)

-Kees

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Kees Cook (9):
  drm/amd/pm: Annotate struct smu10_voltage_dependency_table with
    __counted_by
  drm/amdgpu/discovery: Annotate struct ip_hw_instance with __counted_by
  drm/i915/selftests: Annotate struct perf_series with __counted_by
  drm/msm/dpu: Annotate struct dpu_hw_intr with __counted_by
  drm/nouveau/pm: Annotate struct nvkm_perfdom with __counted_by
  drm/vc4: Annotate struct vc4_perfmon with __counted_by
  drm/virtio: Annotate struct virtio_gpu_object_array with __counted_by
  drm/vmwgfx: Annotate struct vmw_surface_dirty with __counted_by
  drm/v3d: Annotate struct v3d_perfmon with __counted_by

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c        | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c        | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h    | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h        | 2 +-
 drivers/gpu/drm/v3d/v3d_drv.h                        | 2 +-
 drivers/gpu/drm/vc4/vc4_drv.h                        | 2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h                 | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.34.1

