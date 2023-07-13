Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511F27525C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjGMO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjGMO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6262735
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/51NS5IdbGhAF1WTe4etoP/bWkQWV6fSApbrFXQZ0Fk=;
        b=MWobhaLhcyFJUy2mHqAAjzdH6YBZ3caMU9yGIKHnLWufmHz61b7aW9klbl21GeDQ7qBGQQ
        i9ZNdDtXR2M6IOLbT3AcmJ3It6oRmFG6KQ0kAkS9/0WRbvVxq0XDV80Euflh42uUuYHfrF
        TdCI9JhVQQPYLmoGv9jNfPQQHJsDgU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-Cnd2LY13MK-Zy4GC5ZFc9w-1; Thu, 13 Jul 2023 10:56:01 -0400
X-MC-Unique: Cnd2LY13MK-Zy4GC5ZFc9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7FA283FC20;
        Thu, 13 Jul 2023 14:56:00 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F036F66D1;
        Thu, 13 Jul 2023 14:55:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 3/4] virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub Block Mode (SBM)
Date:   Thu, 13 Jul 2023 16:55:50 +0200
Message-ID: <20230713145551.2824980-4-david@redhat.com>
In-Reply-To: <20230713145551.2824980-1-david@redhat.com>
References: <20230713145551.2824980-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/virtio/virtio_mem.c | 92 +++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 1a76ba2bc118..a5cf92e3e5af 100644
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
2.41.0

