Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD77D753511
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjGNIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGNIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:31:39 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B4212B;
        Fri, 14 Jul 2023 01:31:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0184C5BC38;
        Fri, 14 Jul 2023 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689322899;
        bh=SiuL//u01cpp5eowFbvlhLlowHgzfDnh6OXKL8CX6Qo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=jTbM8iICekJjMQkS8TPm+lGxRLkRWT0/LnMFix4yI5i9aW2W8kIC4DZfAIW3ftLAt
         VeHeIq0qSPMn0ajIYWJL/jWVmvCL3GajvWpOvcbiAXBfT3f85HmmPMD4SW/fIL8h/C
         s5RYchWzcSOH8IQzSJ5Px/0rsjQn2RnSP8Kt0d+SsD/NwC2PhBOMcR3cxg1aTOYDvV
         Ei7SoK9VjbbNk5Sli2mLSr7WToHp8/EQ3mPvdTujFcB39SO2gCK868iIsuiXC2DcXr
         99DTSYsBHjww36hV2i+IfIO+dZCpihCiJz0aMsM5HMpstYVad7TJ/4QiN3z9hOJhei
         E+WjBqvgJKZQQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 17:21:29 +0900
Subject: [PATCH 1/3] drm/scheduler: Add more documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-drm-sched-fixes-v1-1-c567249709f7@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689322891; l=3946;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=SiuL//u01cpp5eowFbvlhLlowHgzfDnh6OXKL8CX6Qo=;
 b=W7DZprDVToONdsfgSG5/Md25GSR994KvtI3Fa+/4LBSTFzarcsYcFhySWLme0A2jAZXVl+3n/
 uLmvTuHCmrXCSYDjQ6pa1slmUz9KlJCVgWpqYdmzcqk73XPqRuk6KKj
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

Document the implied lifetime rules of the scheduler (or at least the
intended ones), as well as the expectations of how resource acquisition
should be handled.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 drivers/gpu/drm/scheduler/sched_main.c | 58 ++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7b2bfc10c1a5..1f3bc3606239 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -43,9 +43,61 @@
  *
  * The jobs in a entity are always scheduled in the order that they were pushed.
  *
- * Note that once a job was taken from the entities queue and pushed to the
- * hardware, i.e. the pending queue, the entity must not be referenced anymore
- * through the jobs entity pointer.
+ * Lifetime rules
+ * --------------
+ *
+ * Getting object lifetimes right across the stack is critical to avoid UAF
+ * issues. The DRM scheduler has the following lifetime rules:
+ *
+ * - The scheduler must outlive all of its entities.
+ * - Jobs pushed to the scheduler are owned by it, and must only be freed
+ *   after the free_job() callback is called.
+ * - Scheduler fences are reference-counted and may outlive the scheduler.
+ * - The scheduler *may* be destroyed while jobs are still in flight.
+ * - There is no guarantee that all jobs have been freed when all entities
+ *   and the scheduled have been destroyed. Jobs may be freed asynchronously
+ *   after this point.
+ * - Once a job is taken from the entity's queue and pushed to the hardware,
+ *   i.e. the pending queue, the entity must not be referenced any more
+ *   through the job's entity pointer. In other words, entities are not
+ *   required to outlive job execution.
+ *
+ * If the scheduler is destroyed with jobs in flight, the following
+ * happens:
+ *
+ * - Jobs that were pushed but have not yet run will be destroyed as part
+ *   of the entity cleanup (which must happen before the scheduler itself
+ *   is destroyed, per the first rule above). This signals the job
+ *   finished fence with an error flag. This process runs asynchronously
+ *   after drm_sched_entity_destroy() returns.
+ * - Jobs that are in-flight on the hardware are "detached" from their
+ *   driver fence (the fence returned from the run_job() callback). In
+ *   this case, it is up to the driver to ensure that any bookkeeping or
+ *   internal data structures have separately managed lifetimes and that
+ *   the hardware either cancels the jobs or runs them to completion.
+ *   The DRM scheduler itself will immediately signal the job complete
+ *   fence (with an error flag) and then call free_job() as part of the
+ *   cleanup process.
+ *
+ * After the scheduler is destroyed, drivers *may* (but are not required to)
+ * skip signaling their remaining driver fences, as long as they have only ever
+ * been returned to the scheduler being destroyed as the return value from
+ * run_job() and not passed anywhere else. If these fences are used in any other
+ * context, then the driver *must* signal them, per the usual fence signaling
+ * rules.
+ *
+ * Resource management
+ * -------------------
+ *
+ * Drivers may need to acquire certain hardware resources (e.g. VM IDs) in order
+ * to run a job. This process must happen during the job's prepare() callback,
+ * not in the run() callback. If any resource is unavailable at job prepare time,
+ * the driver must return a suitable fence that can be waited on to wait for the
+ * resource to (potentially) become available.
+ *
+ * In order to avoid deadlocks, drivers must always acquire resources in the
+ * same order, and release them in opposite order when a job completes or if
+ * resource acquisition fails.
  */
 
 #include <linux/kthread.h>

-- 
2.40.1

