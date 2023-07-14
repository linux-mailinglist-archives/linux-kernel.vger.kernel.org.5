Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2075350C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjGNIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjGNIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:31:39 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 01:31:37 PDT
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD91FCD;
        Fri, 14 Jul 2023 01:31:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9DFBF5BC3A;
        Fri, 14 Jul 2023 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689322902;
        bh=2fvwzfS8YmheCobPc2+Jok2ymjxw2dE4WFuUm89CeSo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Ul6meaIpNeuWcJCwpAYhbbiGf+LI7dxOrwbWECurU79oGo8mKIXGq/PpwntwxYhL6
         3jZjBXVRBxLBudEsjD01rpTbvNsZQqsHexszbM+UPx65RHtHxKoWh3iGQDbZhqac0c
         THw+fGYmeqS407Le8VwRRLJzQcnsrUsKmVYXvE4n13iIuHOL9OUMhyaPV+s7f27n66
         xcSXZrePdpYH2rzOqGGsDd6GDt1kdlSQxj5s+Ptu9W6UFTqHEg7NdBIB3mTJhyIwCP
         mSI2w2bgT6Q3HAovBrdpzKF/wQmls6tyfDsWUyEiInhAtHI5ue5ZUTnuLnKUKSOKyZ
         KvwjJ2D3DjJ1A==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 17:21:30 +0900
Subject: [PATCH 2/3] drm/scheduler: Fix UAF in
 drm_sched_fence_get_timeline_name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-drm-sched-fixes-v1-2-c567249709f7@asahilina.net>
References: <20230714-drm-sched-fixes-v1-0-c567249709f7@asahilina.net>
In-Reply-To: <20230714-drm-sched-fixes-v1-0-c567249709f7@asahilina.net>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Faith Ekstrand <faith.ekstrand@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689322891; l=3041;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=2fvwzfS8YmheCobPc2+Jok2ymjxw2dE4WFuUm89CeSo=;
 b=cGIqcU2xLXIEnYceEA1R5m+dM1c4K6uQypwIVQQxiA9kE8cWOkpsy03Lc3UmPGdJzzI4sez2N
 D0FF7Vk7S0VDhI+z11BCCD/UVgnFr42ZSzTeAuiFCbjqPftu2mpb7Vf
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A signaled scheduler fence can outlive its scheduler, since fences are
independencly reference counted. Therefore, we can't reference the
scheduler in the get_timeline_name() implementation.

Fixes oopses on `cat /sys/kernel/debug/dma_buf/bufinfo` when shared
dma-bufs reference fences from GPU schedulers that no longer exist.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 ++++++-
 drivers/gpu/drm/scheduler/sched_fence.c  | 4 +++-
 include/drm/gpu_scheduler.h              | 5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index b2bbc8a68b30..17f35b0b005a 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -389,7 +389,12 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 
 		/*
 		 * Fence is from the same scheduler, only need to wait for
-		 * it to be scheduled
+		 * it to be scheduled.
+		 *
+		 * Note: s_fence->sched could have been freed and reallocated
+		 * as another scheduler. This false positive case is okay, as if
+		 * the old scheduler was freed all of its jobs must have
+		 * signaled their completion fences.
 		 */
 		fence = dma_fence_get(&s_fence->scheduled);
 		dma_fence_put(entity->dependency);
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index ef120475e7c6..06a0eebcca10 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -68,7 +68,7 @@ static const char *drm_sched_fence_get_driver_name(struct dma_fence *fence)
 static const char *drm_sched_fence_get_timeline_name(struct dma_fence *f)
 {
 	struct drm_sched_fence *fence = to_drm_sched_fence(f);
-	return (const char *)fence->sched->name;
+	return (const char *)fence->sched_name;
 }
 
 static void drm_sched_fence_free_rcu(struct rcu_head *rcu)
@@ -216,6 +216,8 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 	unsigned seq;
 
 	fence->sched = entity->rq->sched;
+	strlcpy(fence->sched_name, entity->rq->sched->name,
+		sizeof(fence->sched_name));
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
 		       &fence->lock, entity->fence_context, seq);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index e95b4837e5a3..4fa9523bd47d 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -305,6 +305,11 @@ struct drm_sched_fence {
          * @lock: the lock used by the scheduled and the finished fences.
          */
 	spinlock_t			lock;
+        /**
+         * @sched_name: the name of the scheduler that owns this fence. We
+	 * keep a copy here since fences can outlive their scheduler.
+         */
+	char sched_name[16];
         /**
          * @owner: job owner for debugging
          */

-- 
2.40.1

