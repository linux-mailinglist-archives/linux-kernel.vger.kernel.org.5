Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7671076E91B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjHCNDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjHCNDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:03:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2235A8;
        Thu,  3 Aug 2023 06:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ABE861D85;
        Thu,  3 Aug 2023 13:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37721C433C7;
        Thu,  3 Aug 2023 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067804;
        bh=EM39itBcbN7Mjgyn0t1kV7w4owOpAntw0KP1b1TLh4o=;
        h=From:To:Cc:Subject:Date:From;
        b=QBdn5p711H9F06/aTeC6MyfO1S9DU2slkYUbUsY/ELHurAJ+cJ/BILBUgDVbilh5R
         6+LsYkKrENWqX5NOAQViGs8zzn/1sLqsndB95AB/kTqfs3Gjxf42B9bvpiSQju560f
         lFtZQV0kEE1/52uXdcXWehAZWjY/JTMhdye3TmBJkwM50UhASeXg/e1XLsLiMrRAPx
         F5eK9Tj2vPlDxklBjilV4Zp7UbPemftVUGy1TYq7f5+fK+KxTY0feTNkKPOVslU5Yf
         soIbHVGZ12OgS6AA5LvTrXu8HJs+LbIiKYK3/Impko8/8xqoKlztn+ULtOLn7EjbGK
         49Xwr0yFlbb4g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH AUTOSEL 6.4 1/7] drm/sched: Make sure we wait for all dependencies in kill_jobs_cb()
Date:   Thu,  3 Aug 2023 09:03:14 -0400
Message-Id: <20230803130321.641516-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

[ Upstream commit e30cb0599799aac099209e3b045379613c80730e ]

drm_sched_entity_kill_jobs_cb() logic is omitting the last fence popped
from the dependency array that was waited upon before
drm_sched_entity_kill() was called (drm_sched_entity::dependency field),
so we're basically waiting for all dependencies except one.

In theory, this wait shouldn't be needed because resources should have
their users registered to the dma_resv object, thus guaranteeing that
future jobs wanting to access these resources wait on all the previous
users (depending on the access type, of course). But we want to keep
these explicit waits in the kill entity path just in case.

Let's make sure we keep all dependencies in the array in
drm_sched_job_dependency(), so we can iterate over the array and wait
in drm_sched_entity_kill_jobs_cb().

We also make sure we wait on drm_sched_fence::finished if we were
originally asked to wait on drm_sched_fence::scheduled. In that case,
we assume the intent was to delegate the wait to the firmware/GPU or
rely on the pipelining done at the entity/scheduler level, but when
killing jobs, we really want to wait for completion not just scheduling.

v2:
- Don't evict deps in drm_sched_job_dependency()

v3:
- Always wait for drm_sched_fence::finished fences in
  drm_sched_entity_kill_jobs_cb() when we see a sched_fence

v4:
- Fix commit message
- Fix a use-after-free bug

v5:
- Flag deps on which we should only wait for the scheduled event
  at insertion time

v6:
- Back to v4 implementation
- Add Christian's R-b

Cc: Frank Binns <frank.binns@imgtec.com>
Cc: Sarah Walker <sarah.walker@imgtec.com>
Cc: Donald Robson <donald.robson@imgtec.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Suggested-by: "Christian König" <christian.koenig@amd.com>
Reviewed-by: "Christian König" <christian.koenig@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230619071921.3465992-1-boris.brezillon@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 41 +++++++++++++++++++-----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e0a8890a62e23..42021d1f7e016 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -155,16 +155,32 @@ static void drm_sched_entity_kill_jobs_cb(struct dma_fence *f,
 {
 	struct drm_sched_job *job = container_of(cb, struct drm_sched_job,
 						 finish_cb);
-	int r;
+	unsigned long index;
 
 	dma_fence_put(f);
 
 	/* Wait for all dependencies to avoid data corruptions */
-	while (!xa_empty(&job->dependencies)) {
-		f = xa_erase(&job->dependencies, job->last_dependency++);
-		r = dma_fence_add_callback(f, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb);
-		if (!r)
+	xa_for_each(&job->dependencies, index, f) {
+		struct drm_sched_fence *s_fence = to_drm_sched_fence(f);
+
+		if (s_fence && f == &s_fence->scheduled) {
+			/* The dependencies array had a reference on the scheduled
+			 * fence, and the finished fence refcount might have
+			 * dropped to zero. Use dma_fence_get_rcu() so we get
+			 * a NULL fence in that case.
+			 */
+			f = dma_fence_get_rcu(&s_fence->finished);
+
+			/* Now that we have a reference on the finished fence,
+			 * we can release the reference the dependencies array
+			 * had on the scheduled fence.
+			 */
+			dma_fence_put(&s_fence->scheduled);
+		}
+
+		xa_erase(&job->dependencies, index);
+		if (f && !dma_fence_add_callback(f, &job->finish_cb,
+						 drm_sched_entity_kill_jobs_cb))
 			return;
 
 		dma_fence_put(f);
@@ -394,8 +410,17 @@ static struct dma_fence *
 drm_sched_job_dependency(struct drm_sched_job *job,
 			 struct drm_sched_entity *entity)
 {
-	if (!xa_empty(&job->dependencies))
-		return xa_erase(&job->dependencies, job->last_dependency++);
+	struct dma_fence *f;
+
+	/* We keep the fence around, so we can iterate over all dependencies
+	 * in drm_sched_entity_kill_jobs_cb() to ensure all deps are signaled
+	 * before killing the job.
+	 */
+	f = xa_load(&job->dependencies, job->last_dependency);
+	if (f) {
+		job->last_dependency++;
+		return dma_fence_get(f);
+	}
 
 	if (job->sched->ops->prepare_job)
 		return job->sched->ops->prepare_job(job, entity);
-- 
2.40.1

