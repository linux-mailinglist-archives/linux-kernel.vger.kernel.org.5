Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EEC7D9E45
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbjJ0Q7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0Q7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:59:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01411B;
        Fri, 27 Oct 2023 09:59:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2800ab6fa66so881705a91.3;
        Fri, 27 Oct 2023 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425954; x=1699030754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l2XOiyO7ELntzgtLuOwOBKhVQExybEKPgHk4URVDgho=;
        b=TaXdggCfuxcnoE3f7wujFBb8G5rfCzEQXCsOLdMruV4SRYxEXcbMj2mXFEfSUMKS94
         ES82gfraay+Ip729LlK8pgOjUOSmJTTlLMhI0XOJYo6m3kXjGeTQ4Fya+po6VKM+8lHA
         Lhv42BDhXWMOQaXeK3wtgdSW2Mk2hCntYfMi6oTdR52TsLfep3BNky17LU8tWBrrOBim
         6j1H9yhv7jCDq8IpzbFa7oorOQYUN2WN1pmXDsmi+pxe3lxegRE47LkLVCFphGhamhMU
         wRwmM80i1n7/sNtJUQ8dkPB7Cuy1UUydS2Cm9Ja21l04cQ4tU9+9IpE02Zt2UsQohU7f
         oGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425954; x=1699030754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2XOiyO7ELntzgtLuOwOBKhVQExybEKPgHk4URVDgho=;
        b=sfyj5tpvP/Tk+pndESDBUiDtTx4oXu3nBDODEPpF7V54MbKUaxtktueyvfqi/Uf6qU
         tdsyVqw/Q3qWI+i1331B3rRN3/L94c2R/QLKWTVVjGbd+WYAbP4EyeoHiBtVgZe+SiTo
         wWsDajLzwg0vuJp+J63HnXpKlwXFEPcsmry05hS69rZh+KUXM1F71row3XYvLHyFSCTW
         dBFN6V/277qdy4axvo3dq5KB666IxdPByCVnyPtOgey/LZge3qaAlsQP4vmbrt/sMM57
         ANbo7L3pYtktJ+sVJ8xuy4M3ZrMEgPIw7DCo/wMxXKfnvDnuDZcXPSznIYGXceuDj2ek
         MO+Q==
X-Gm-Message-State: AOJu0YxqKPNwGlZSjyPWA8mJKV+rwho6vHkl1KnCLPYOJJjoEjC2/RIX
        SbkcRjIjOk6Xg/oMc9EUCJc=
X-Google-Smtp-Source: AGHT+IGmj0N9Vkha046UwwcpchKPTTZ+UtBOMnjmz7YeYZi5yoFGRN7OlD9zVh2noyVB62tlU/Jayw==
X-Received: by 2002:a17:90a:1a0b:b0:280:1022:f00e with SMTP id 11-20020a17090a1a0b00b002801022f00emr1807988pjk.29.1698425954002;
        Fri, 27 Oct 2023 09:59:14 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id s31-20020a17090a2f2200b0028017a2a8fasm733629pjd.3.2023.10.27.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:59:13 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        Andrew Morton <akpm@linux-foundation.org>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dong Chenchen <dongchenchen2@huawei.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, James Zhu <James.Zhu@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
        Luben Tuikov <luben.tuikov@amd.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), Philip Yang <Philip.Yang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/7] drm/msm/gem: drm_exec conversion
Date:   Fri, 27 Oct 2023 09:58:34 -0700
Message-ID: <20231027165859.395638-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Simplify the exec path (removing a legacy optimization) and convert to
drm_exec.  One drm_exec patch to allow passing in the expected # of GEM
objects to avoid re-allocation.

I'd be a bit happier if I could avoid the extra objects table allocation
in drm_exec in the first place, but wasn't really happy with any of the
things I tried to get rid of that.

Rob Clark (7):
  drm/msm/gem: Remove "valid" tracking
  drm/msm/gem: Remove submit_unlock_unpin_bo()
  drm/msm/gem: Don't queue job to sched in error cases
  drm/msm/gem: Split out submit_unpin_objects() helper
  drm/msm/gem: Cleanup submit_cleanup_bo()
  drm/exec: Pass in initial # of objects
  drm/msm/gem: Convert to drm_exec

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |   4 +-
 drivers/gpu/drm/drm_exec.c              |  15 +-
 drivers/gpu/drm/msm/Kconfig             |   1 +
 drivers/gpu/drm/msm/msm_gem.h           |  13 +-
 drivers/gpu/drm/msm/msm_gem_submit.c    | 197 ++++++------------------
 drivers/gpu/drm/msm/msm_ringbuffer.c    |   3 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c  |   2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c  |   2 +-
 include/drm/drm_exec.h                  |   2 +-
 12 files changed, 79 insertions(+), 170 deletions(-)

-- 
2.41.0

