Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83B803FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbjLDUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjLDUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:36:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB92712
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:34:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F825C433C8;
        Mon,  4 Dec 2023 20:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722086;
        bh=kGmYZKKHc1s6cB5eQD5BL2iS9W5aMoe4n0+Po34UR8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/iSupNOxv7bi7dV4w6aEkxxc9GfsGdhfhhwAlb1ssPhx3bB1S8bBU7MhhZFGZbqt
         NEIWHnuhOO/Kzf6i3WBUjrqhqGrHL85tPSeoHaSdbeIzE7e+horYUsqJUlJhVcKYqs
         NAhstG2oBR9Pw17tSA1FYg10yk6rzhn4RfPabzh6zValHSbIo0iU9AS4otkg47ejvC
         B+DLSuCKBbwbsQjXybsaHsOBu2z+Ayu/+eIMAovNi6QQBtRaBmI6SUOEvbrToBciS3
         IBs2xQfMLFTtVg55GDCZQ1bn2Tn8hoWg600253qXCK8tiiFZ8vtD7OPETaQC4P/Eb0
         6LtIjqJPp7bZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ZhenGuo Yin <zhenguo.yin@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 27/32] drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit
Date:   Mon,  4 Dec 2023 15:32:47 -0500
Message-ID: <20231204203317.2092321-27-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
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

From: ZhenGuo Yin <zhenguo.yin@amd.com>

[ Upstream commit 72838777aa38352e20301e123b97110c456cd38e ]

[Why]
Memory leaks of gang_ctx_bo and wptr_bo.

[How]
Free gang_ctx_bo and wptr_bo in pqm_uninit.

v2: add a common function pqm_clean_queue_resource to
free queue's resources.
v3: reset pdd->pqd.num_gws when destorying GWS queue.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 54 +++++++++++--------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index adb5e4bdc0b20..7d0f887d99558 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -169,16 +169,43 @@ int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p)
 	return 0;
 }
 
+static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
+				     struct process_queue_node *pqn)
+{
+	struct kfd_node *dev;
+	struct kfd_process_device *pdd;
+
+	dev = pqn->q->device;
+
+	pdd = kfd_get_process_device_data(dev, pqm->process);
+	if (!pdd) {
+		pr_err("Process device data doesn't exist\n");
+		return;
+	}
+
+	if (pqn->q->gws) {
+		if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
+		    !dev->kfd->shared_resources.enable_mes)
+			amdgpu_amdkfd_remove_gws_from_process(
+				pqm->process->kgd_process_info, pqn->q->gws);
+		pdd->qpd.num_gws = 0;
+	}
+
+	if (dev->kfd->shared_resources.enable_mes) {
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		if (pqn->q->wptr_bo)
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+	}
+}
+
 void pqm_uninit(struct process_queue_manager *pqm)
 {
 	struct process_queue_node *pqn, *next;
 
 	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
-		if (pqn->q && pqn->q->gws &&
-		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-		    !pqn->q->device->kfd->shared_resources.enable_mes)
-			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
-				pqn->q->gws);
+		if (pqn->q)
+			pqm_clean_queue_resource(pqm, pqn);
+
 		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 		list_del(&pqn->process_queue_list);
@@ -460,22 +487,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 				goto err_destroy_queue;
 		}
 
-		if (pqn->q->gws) {
-			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
-			    !dev->kfd->shared_resources.enable_mes)
-				amdgpu_amdkfd_remove_gws_from_process(
-						pqm->process->kgd_process_info,
-						pqn->q->gws);
-			pdd->qpd.num_gws = 0;
-		}
-
-		if (dev->kfd->shared_resources.enable_mes) {
-			amdgpu_amdkfd_free_gtt_mem(dev->adev,
-						   pqn->q->gang_ctx_bo);
-			if (pqn->q->wptr_bo)
-				amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
-
-		}
+		pqm_clean_queue_resource(pqm, pqn);
 		uninit_queue(pqn->q);
 	}
 
-- 
2.42.0

