Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1759575E602
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGXBNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGXBNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6821B4;
        Sun, 23 Jul 2023 18:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C569260F00;
        Mon, 24 Jul 2023 01:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7078BC433CD;
        Mon, 24 Jul 2023 01:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161229;
        bh=qPnaq8FRUnokyIGV/+C8uOtrOQuKopM6N67bj+Xd2/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJVH1eNhE+zE892q9BNfss/JVfaFIPHQLoe9keVyh30I3nh1662oyQ6A3AQkokxhH
         OMnVBEXvoXVnfMDu/q8KHdz+urn9p/eQD8vRaollkbUtIPDJ2UfNTgJGrq97yKwLyA
         xoPByzlM0fglKgDagTfg2AxiF0wURbSZgSS7QV9n3Ez2o/rDsrl49sJgIPQGzvsccg
         1v2D9n4j7DwqMYHWWIAE/8ufnAwFtOD1/DVdh6gyUQEMFSCft5e1kK/65eExhTcaW+
         wP3grU65w1jTRiFox1xm+aupx6gzySzuNHH4c3Yk2Adab3n711zTMj/GjeVlPU+4XK
         hYW0nKP82EBoA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Sasha Levin <sashal@kernel.org>, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 03/58] drm/scheduler: set entity to NULL in drm_sched_entity_pop_job()
Date:   Sun, 23 Jul 2023 21:12:31 -0400
Message-Id: <20230724011338.2298062-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danilo Krummrich <dakr@redhat.com>

[ Upstream commit 96c7c2f4d5bd94b15fe63448c087f01607b56f4a ]

It already happend a few times that patches slipped through which
implemented access to an entity through a job that was already removed
from the entities queue. Since jobs and entities might have different
lifecycles, this can potentially cause UAF bugs.

In order to make it obvious that a jobs entity pointer shouldn't be
accessed after drm_sched_entity_pop_job() was called successfully, set
the jobs entity pointer to NULL once the job is removed from the entity
queue.

Moreover, debugging a potential NULL pointer dereference is way easier
than potentially corrupted memory through a UAF.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://lore.kernel.org/r/20230418100453.4433-1-dakr@redhat.com
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 6 ++++++
 drivers/gpu/drm/scheduler/sched_main.c   | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e0a8890a62e23..3e2a31d8190eb 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -448,6 +448,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 			drm_sched_rq_update_fifo(entity, next->submit_ts);
 	}
 
+	/* Jobs and entities might have different lifecycles. Since we're
+	 * removing the job from the entities queue, set the jobs entity pointer
+	 * to NULL to prevent any future access of the entity through this job.
+	 */
+	sched_job->entity = NULL;
+
 	return sched_job;
 }
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index aea5a90ff98b9..cdd67676c3d1b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -42,6 +42,10 @@
  *    the hardware.
  *
  * The jobs in a entity are always scheduled in the order that they were pushed.
+ *
+ * Note that once a job was taken from the entities queue and pushed to the
+ * hardware, i.e. the pending queue, the entity must not be referenced anymore
+ * through the jobs entity pointer.
  */
 
 #include <linux/kthread.h>
-- 
2.39.2

