Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8467AC892
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjIXNSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIXNRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:17:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD01736;
        Sun, 24 Sep 2023 06:16:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD1C433CD;
        Sun, 24 Sep 2023 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561415;
        bh=FF8e3C7Xs/OSrgjQHSuwKFgdVE7dLpEjPZz+RiAm6cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3rNIbIOf//acwBjwDm9N3IvISMqzlrDvXbp53NME7YtZnPtvlex34m6SxTCeDCKj
         rZBYQw1kKixGPh98nGnHVcCX9A6oAGA0yueveCf7dJ6z8J549weynpC40ukhhF6z1B
         IKjUofw2OJeRw4B3rLnUX9dBWZMYcKi1ohlexaNOiP56833819FoPPxWAYhxuenHUm
         2dfCjhyMkA0qvsJgltsNhyqsKXsnxy/KfXJdZP2VH8KCSdkWcpnUBDru+R2Yp9RGEH
         jrp5n3NNg+JWoLsGpHxNNt6cROLJNLSJPmaqDGIaXPR5aLDYjutlmlUEVZvjn3ixuh
         /Y+9dpLniOVwg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mukul Joshi <mukul.joshi@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 25/41] drm/amdkfd: Update cache info reporting for GFX v9.4.3
Date:   Sun, 24 Sep 2023 09:15:13 -0400
Message-Id: <20230924131529.1275335-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TVD_PH_SUBJ_META1
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit 0752e66e91fa86fa5481b04b22053363833ffb85 ]

Update cache info reporting in sysfs to report the correct
number of CUs and associated cache information based on
different spatial partitioning modes.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  4 ++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 82 +++++++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  2 +-
 3 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index fc719389b5d65..4684711aa695a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -79,6 +79,10 @@ struct crat_header {
 #define CRAT_SUBTYPE_IOLINK_AFFINITY		5
 #define CRAT_SUBTYPE_MAX			6
 
+/*
+ * Do not change the value of CRAT_SIBLINGMAP_SIZE from 32
+ * as it breaks the ABI.
+ */
 #define CRAT_SIBLINGMAP_SIZE	32
 
 /*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ea67a353beb00..5582191022106 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1650,14 +1650,17 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
 static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				struct kfd_gpu_cache_info *pcache_info,
 				struct kfd_cu_info *cu_info,
-				int cache_type, unsigned int cu_processor_id)
+				int cache_type, unsigned int cu_processor_id,
+				struct kfd_node *knode)
 {
 	unsigned int cu_sibling_map_mask;
 	int first_active_cu;
-	int i, j, k;
+	int i, j, k, xcc, start, end;
 	struct kfd_cache_properties *pcache = NULL;
 
-	cu_sibling_map_mask = cu_info->cu_bitmap[0][0][0];
+	start = ffs(knode->xcc_mask) - 1;
+	end = start + NUM_XCC(knode->xcc_mask);
+	cu_sibling_map_mask = cu_info->cu_bitmap[start][0][0];
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
@@ -1692,16 +1695,18 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		cu_sibling_map_mask = cu_sibling_map_mask >> (first_active_cu - 1);
 		k = 0;
 
-		for (i = 0; i < cu_info->num_shader_engines; i++) {
-			for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
-				pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
-				pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
-				pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
-				pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
-				k += 4;
-
-				cu_sibling_map_mask = cu_info->cu_bitmap[0][i % 4][j + i / 4];
-				cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
+		for (xcc = start; xcc < end; xcc++) {
+			for (i = 0; i < cu_info->num_shader_engines; i++) {
+				for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
+					pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
+					pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
+					pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
+					pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
+					k += 4;
+
+					cu_sibling_map_mask = cu_info->cu_bitmap[xcc][i % 4][j + i / 4];
+					cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
+				}
 			}
 		}
 		pcache->sibling_map_size = k;
@@ -1719,7 +1724,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct kfd_node *kdev)
 {
 	struct kfd_gpu_cache_info *pcache_info = NULL;
-	int i, j, k;
+	int i, j, k, xcc, start, end;
 	int ct = 0;
 	unsigned int cu_processor_id;
 	int ret;
@@ -1753,37 +1758,42 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 	 *			then it will consider only one CU from
 	 *			the shared unit
 	 */
+	start = ffs(kdev->xcc_mask) - 1;
+	end = start + NUM_XCC(kdev->xcc_mask);
+
 	for (ct = 0; ct < num_of_cache_types; ct++) {
 		cu_processor_id = gpu_processor_id;
 		if (pcache_info[ct].cache_level == 1) {
-			for (i = 0; i < pcu_info->num_shader_engines; i++) {
-				for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
-					for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
-
-						ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
-									pcu_info->cu_bitmap[0][i % 4][j + i / 4], ct,
-									cu_processor_id, k);
-
-						if (ret < 0)
-							break;
-
-						if (!ret) {
-							num_of_entries++;
-							list_add_tail(&props_ext->list, &dev->cache_props);
+			for (xcc = start; xcc < end; xcc++) {
+				for (i = 0; i < pcu_info->num_shader_engines; i++) {
+					for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
+						for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
+
+							ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
+										pcu_info->cu_bitmap[xcc][i % 4][j + i / 4], ct,
+										cu_processor_id, k);
+
+							if (ret < 0)
+								break;
+
+							if (!ret) {
+								num_of_entries++;
+								list_add_tail(&props_ext->list, &dev->cache_props);
+							}
+
+							/* Move to next CU block */
+							num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
+								pcu_info->num_cu_per_sh) ?
+								pcache_info[ct].num_cu_shared :
+								(pcu_info->num_cu_per_sh - k);
+							cu_processor_id += num_cu_shared;
 						}
-
-						/* Move to next CU block */
-						num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
-							pcu_info->num_cu_per_sh) ?
-							pcache_info[ct].num_cu_shared :
-							(pcu_info->num_cu_per_sh - k);
-						cu_processor_id += num_cu_shared;
 					}
 				}
 			}
 		} else {
 			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
-								pcu_info, ct, cu_processor_id);
+					pcu_info, ct, cu_processor_id, kdev);
 
 			if (ret < 0)
 				break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index cba2cd5ed9d19..46927263e014d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -86,7 +86,7 @@ struct kfd_mem_properties {
 	struct attribute	attr;
 };
 
-#define CACHE_SIBLINGMAP_SIZE 64
+#define CACHE_SIBLINGMAP_SIZE 128
 
 struct kfd_cache_properties {
 	struct list_head	list;
-- 
2.40.1

