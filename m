Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911A778C5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjH2NfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjH2Nd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313EB187;
        Tue, 29 Aug 2023 06:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 916796571F;
        Tue, 29 Aug 2023 13:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17CC433CA;
        Tue, 29 Aug 2023 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315948;
        bh=dy4c5VgYmzO+wokbgPqiCexGvmUpWCAm+FpqFxBYUKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3lKlYLjGntIDvc3AQDFcCK/q32CQw24XRaa37oW9YOmfdS/4N4XHHmkx7nytuoGx
         3ihgaS4joPIXzM5ASSQHd+K9AdU5m3UlmUU/I7O4UMvbF9tph1iIU/hA9JGDGMkvDs
         4RFekv7zWfbsCikJvgLloSO6DYv4gk9Qyw4ozTOI5WqAFXsdS2VBMDxMExkb0Bfw7+
         qbcBBSOlSootYBq+74W/NM1qUZ0vIh1PGfWOyZF34WOXuK58hKao/XC72kRZVif567
         HkCSDJwBiT88DZBbFpUqNrYszEPKAHTZYa+k20pb1xPJi2/pwJEJc/nNPVKQj6AyTM
         asCzOQd8C5XGw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.4 08/17] virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub Block Mode (SBM)
Date:   Tue, 29 Aug 2023 09:31:55 -0400
Message-Id: <20230829133211.519957-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit a31648fd4f96fbe0a4d0aeb16b57a2405c6943c0 ]

In case offline_and_remove_memory() fails in SBM, we leave a completely
unplugged Linux memory block stick around until we try plugging memory
again. We won't try removing that memory block again.

offline_and_remove_memory() may, for example, fail if we're racing with
another alloc_contig_range() user, if allocating temporary memory fails,
or if some memory notifier rejected the offlining request.

Let's handle that case better, by simple retrying to offline and remove
such memory.

Tested using CONFIG_MEMORY_NOTIFIER_ERROR_INJECT.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230713145551.2824980-4-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 92 +++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1a76ba2bc118c..a5cf92e3e5af2 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -168,6 +168,13 @@ struct virtio_mem {
 			/* The number of subblocks per Linux memory block. */
 			uint32_t sbs_per_mb;
 
+			/*
+			 * Some of the Linux memory blocks tracked as "partially
+			 * plugged" are completely unplugged and can be offlined
+			 * and removed -- which previously failed.
+			 */
+			bool have_unplugged_mb;
+
 			/* Summary of all memory block states. */
 			unsigned long mb_count[VIRTIO_MEM_SBM_MB_COUNT];
 
@@ -765,6 +772,34 @@ static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
 	return virtio_mem_offline_and_remove_memory(vm, addr, size);
 }
 
+/*
+ * Try (offlining and) removing memory from Linux in case all subblocks are
+ * unplugged. Can be called on online and offline memory blocks.
+ *
+ * May modify the state of memory blocks in virtio-mem.
+ */
+static int virtio_mem_sbm_try_remove_unplugged_mb(struct virtio_mem *vm,
+						  unsigned long mb_id)
+{
+	int rc;
+
+	/*
+	 * Once all subblocks of a memory block were unplugged, offline and
+	 * remove it.
+	 */
+	if (!virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
+		return 0;
+
+	/* offline_and_remove_memory() works for online and offline memory. */
+	mutex_unlock(&vm->hotplug_mutex);
+	rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
+	mutex_lock(&vm->hotplug_mutex);
+	if (!rc)
+		virtio_mem_sbm_set_mb_state(vm, mb_id,
+					    VIRTIO_MEM_SBM_MB_UNUSED);
+	return rc;
+}
+
 /*
  * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
  * all Linux memory blocks covered by the big block.
@@ -1988,20 +2023,10 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	}
 
 unplugged:
-	/*
-	 * Once all subblocks of a memory block were unplugged, offline and
-	 * remove it. This will usually not fail, as no memory is in use
-	 * anymore - however some other notifiers might NACK the request.
-	 */
-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
-		mutex_unlock(&vm->hotplug_mutex);
-		rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
-		mutex_lock(&vm->hotplug_mutex);
-		if (!rc)
-			virtio_mem_sbm_set_mb_state(vm, mb_id,
-						    VIRTIO_MEM_SBM_MB_UNUSED);
-	}
-
+	rc = virtio_mem_sbm_try_remove_unplugged_mb(vm, mb_id);
+	if (rc)
+		vm->sbm.have_unplugged_mb = 1;
+	/* Ignore errors, this is not critical. We'll retry later. */
 	return 0;
 }
 
@@ -2253,12 +2278,13 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 
 /*
  * Try to unplug all blocks that couldn't be unplugged before, for example,
- * because the hypervisor was busy.
+ * because the hypervisor was busy. Further, offline and remove any memory
+ * blocks where we previously failed.
  */
-static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
+static int virtio_mem_cleanup_pending_mb(struct virtio_mem *vm)
 {
 	unsigned long id;
-	int rc;
+	int rc = 0;
 
 	if (!vm->in_sbm) {
 		virtio_mem_bbm_for_each_bb(vm, id,
@@ -2280,6 +2306,27 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
 					    VIRTIO_MEM_SBM_MB_UNUSED);
 	}
 
+	if (!vm->sbm.have_unplugged_mb)
+		return 0;
+
+	/*
+	 * Let's retry (offlining and) removing completely unplugged Linux
+	 * memory blocks.
+	 */
+	vm->sbm.have_unplugged_mb = false;
+
+	mutex_lock(&vm->hotplug_mutex);
+	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_MOVABLE_PARTIAL)
+		rc |= virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
+	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_KERNEL_PARTIAL)
+		rc |= virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
+	virtio_mem_sbm_for_each_mb(vm, id, VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL)
+		rc |= virtio_mem_sbm_try_remove_unplugged_mb(vm, id);
+	mutex_unlock(&vm->hotplug_mutex);
+
+	if (rc)
+		vm->sbm.have_unplugged_mb = true;
+	/* Ignore errors, this is not critical. We'll retry later. */
 	return 0;
 }
 
@@ -2361,9 +2408,9 @@ static void virtio_mem_run_wq(struct work_struct *work)
 		virtio_mem_refresh_config(vm);
 	}
 
-	/* Unplug any leftovers from previous runs */
+	/* Cleanup any leftovers from previous runs */
 	if (!rc)
-		rc = virtio_mem_unplug_pending_mb(vm);
+		rc = virtio_mem_cleanup_pending_mb(vm);
 
 	if (!rc && vm->requested_size != vm->plugged_size) {
 		if (vm->requested_size > vm->plugged_size) {
@@ -2375,6 +2422,13 @@ static void virtio_mem_run_wq(struct work_struct *work)
 		}
 	}
 
+	/*
+	 * Keep retrying to offline and remove completely unplugged Linux
+	 * memory blocks.
+	 */
+	if (!rc && vm->in_sbm && vm->sbm.have_unplugged_mb)
+		rc = -EBUSY;
+
 	switch (rc) {
 	case 0:
 		vm->retry_timer_ms = VIRTIO_MEM_RETRY_TIMER_MIN_MS;
-- 
2.40.1

