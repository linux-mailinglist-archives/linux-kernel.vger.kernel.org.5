Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1002772C39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjHGRMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHGRL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D17B1;
        Mon,  7 Aug 2023 10:11:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68730bafa6bso3812718b3a.1;
        Mon, 07 Aug 2023 10:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428317; x=1692033117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xmThBOQghVhbetZ+RuMUQ7mhOuoC9ntSXPMFZlv36o=;
        b=YXNOMssECeLOpfbis1zESYawo1JLA+e0U3sScxNp+ibyECWC3IPwBtaCBGBxXbvHE3
         ysSaHVMvqBr6NS9HixnXNqL1/+6D13TjMXIFpjAVqeABHJ6N4VsRMNr6yTTWGJmy1ziU
         IhgIESrbpwDxSMnm/TuIgYr2RP9vIdjzZcszLUXP921lD6Hy3s4ZTyqlTj0TUWX6QKyB
         3YS/c6ERPGjznXNXDOHGMp4zC1H/njGrRGBb7AdgMifpkg7fPowQ/FugqtuVJov5QA8q
         tqgF6VRKHufaAEAPqylWASRIHz9/D/w+yKQ3vEUR0xe57rd7xm5HGuX6Em1yE/d14The
         6l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428317; x=1692033117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xmThBOQghVhbetZ+RuMUQ7mhOuoC9ntSXPMFZlv36o=;
        b=aeXaMIHVmA5WFTx7jNidNQ10qIYCYB6mkjjTEPik11N2DmJDFY+VfjSZ6TzpGX1tXl
         wFO0CxebZ0Xv6BxfLxklndjStH856Ky56PvyP2o0WuXkYJzS41JJme5/5pk7i7m5sqon
         kTyARjd5n866aKgDWvpeyZO8W4OTAipv3QuXEnCz+jC4O6gYb8j0p38UgGtg+ZNNuYN6
         Gw5A++XaLZClRg1SDgyMQ8N961qBDGsAAwLcQCAUsdOgpWItQ/xBAmbi8TiLGhW0cANX
         SLmkLHYVATvtNzi4N77CnMHyo1CL9Tv9wsRy3vIGg0cqN7jbhyEferVRv72MTv3cOQqu
         v2jw==
X-Gm-Message-State: AOJu0YyH7AOsSzIsTKPb75i6O3NXfGU9T1qm7c2GgWTcyedaHyL1+Ljw
        RMQVMdefsCzG6X6x9eygjru179rmIqU=
X-Google-Smtp-Source: AGHT+IFJtMhLWzhwOady0DEB0SqERx+ZPYfUS6iAtpx+6SkUjY1IV+Co7VFZBM04Ki/+KvQrmTzukA==
X-Received: by 2002:a05:6a20:7fa3:b0:12f:d350:8a12 with SMTP id d35-20020a056a207fa300b0012fd3508a12mr9927817pzj.21.1691428316891;
        Mon, 07 Aug 2023 10:11:56 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id t7-20020aa79387000000b00687087d3647sm6618797pfe.142.2023.08.07.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:56 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        Marijn Suijten <marijn.suijten@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH v4 0/9] drm/msm+PM+icc: Make job_run() reclaim-safe
Date:   Mon,  7 Aug 2023 10:11:34 -0700
Message-ID: <20230807171148.210181-1-robdclark@gmail.com>
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

Inspired by https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ffwll.ch/
it seemed like a good idea to get rid of memory allocation in job_run()
fence signaling path, and use lockdep annotations to yell at us about
anything that could deadlock against shrinker/reclaim.  Anything that
can trigger reclaim, or block on any other thread that has triggered
reclaim, can block the GPU shrinker from releasing memory if it is
waiting the job to complete, causing deadlock.

The first two patches decouple allocation from devfreq->lock, and teach
lockdep that devfreq->lock can be acquired in paths that the shrinker
indirectly depends on.

The next three patches do the same for PM QoS.  And the next two do a
similar thing for interconnect.

And then finally the last two patches enable the lockdep fence-
signalling annotations.


v2: Switch from embedding hw_fence in submit/job object to preallocating
    the hw_fence.  Rework "fenced unpin" locking to drop obj lock from
    fence signaling path (ie. the part that was still WIP in the first
    iteration of the patchset).  Adds the final patch to enable fence
    signaling annotations now that job_run() and job_free() are safe.
    The PM devfreq/QoS and interconnect patches are unchanged.

v3: Mostly unchanged, but series is much smaller now that drm changes
    have landed, mostly consisting of the remaining devfreq/qos/
    interconnect fixes.

v4: Re-work PM / QoS patch based on Rafael's suggestion

Rob Clark (9):
  PM / devfreq: Drop unneed locking to appease lockdep
  PM / devfreq: Teach lockdep about locking order
  PM / QoS: Fix constraints alloc vs reclaim locking
  PM / QoS: Decouple request alloc from dev_pm_qos_mtx
  PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
  interconnect: Fix locking for runpm vs reclaim
  interconnect: Teach lockdep about icc_bw_lock order
  drm/sched: Add (optional) fence signaling annotation
  drm/msm: Enable fence signalling annotations

 drivers/base/power/qos.c               | 98 +++++++++++++++++++-------
 drivers/devfreq/devfreq.c              | 52 +++++++-------
 drivers/gpu/drm/msm/msm_ringbuffer.c   |  1 +
 drivers/gpu/drm/scheduler/sched_main.c |  9 +++
 drivers/interconnect/core.c            | 18 ++++-
 include/drm/gpu_scheduler.h            |  2 +
 6 files changed, 127 insertions(+), 53 deletions(-)

-- 
2.41.0

