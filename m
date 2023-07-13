Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDB7525C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjGMO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGMO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185082713
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOmThcBQ38XDQnqrguekPpebm9LB32j86WbUbdRAymk=;
        b=Dq9u35H0Y80xdKoMwM5mEbpOy45hGuldQ51rqEuKOBgxyAQw61udwklvkdvcrHmjYNnEnQ
        NWl6EbFJg8EwTU+cF0hLqnobwdQ00widS4dafjim7941kdCHeNBtcSMszG5DNt9b6RDtHT
        6/lyNO+9dGlQ/emsLgHqnhxToJjIh9Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-j4H8HIhJMpCZyM7rsWcs1g-1; Thu, 13 Jul 2023 10:55:57 -0400
X-MC-Unique: j4H8HIhJMpCZyM7rsWcs1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FD7A29A9D36;
        Thu, 13 Jul 2023 14:55:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4780F66D1;
        Thu, 13 Jul 2023 14:55:55 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 1/4] virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
Date:   Thu, 13 Jul 2023 16:55:48 +0200
Message-ID: <20230713145551.2824980-2-david@redhat.com>
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

When "unsafe unplug" is enabled, we don't fake-offline all memory ahead of
actual memory offlining using alloc_contig_range(). Instead, we rely on
offline_pages() to also perform actual page migration, which might fail
or take a very long time.

In that case, it's possible to easily run into endless loops that cannot be
aborted anymore (as offlining is triggered by a workqueue then): For
example, a single (accidentally) permanently unmovable page in
ZONE_MOVABLE results in an endless loop. For ZONE_NORMAL, races between
isolating the pageblock (and checking for unmovable pages) and
concurrent page allocation are possible and similarly result in endless
loops.

The idea of the unsafe unplug mode was to make it possible to more
reliably unplug large memory blocks. However, (a) we really should be
tackling that differently, by extending the alloc_contig_range()-based
mechanism; and (b) this mode is not the default and as far as I know,
it's unused either way.

So let's simply get rid of it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 51 +++++++++++++++----------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 835f6cc2fb66..ed15d2a4bd96 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -38,11 +38,6 @@ module_param(bbm_block_size, ulong, 0444);
 MODULE_PARM_DESC(bbm_block_size,
 		 "Big Block size in bytes. Default is 0 (auto-detection).");
 
-static bool bbm_safe_unplug = true;
-module_param(bbm_safe_unplug, bool, 0444);
-MODULE_PARM_DESC(bbm_safe_unplug,
-	     "Use a safe unplug mechanism in BBM, avoiding long/endless loops");
-
 /*
  * virtio-mem currently supports the following modes of operation:
  *
@@ -2111,38 +2106,32 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 			 VIRTIO_MEM_BBM_BB_ADDED))
 		return -EINVAL;
 
-	if (bbm_safe_unplug) {
-		/*
-		 * Start by fake-offlining all memory. Once we marked the device
-		 * block as fake-offline, all newly onlined memory will
-		 * automatically be kept fake-offline. Protect from concurrent
-		 * onlining/offlining until we have a consistent state.
-		 */
-		mutex_lock(&vm->hotplug_mutex);
-		virtio_mem_bbm_set_bb_state(vm, bb_id,
-					    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
+	/*
+	 * Start by fake-offlining all memory. Once we marked the device
+	 * block as fake-offline, all newly onlined memory will
+	 * automatically be kept fake-offline. Protect from concurrent
+	 * onlining/offlining until we have a consistent state.
+	 */
+	mutex_lock(&vm->hotplug_mutex);
+	virtio_mem_bbm_set_bb_state(vm, bb_id, VIRTIO_MEM_BBM_BB_FAKE_OFFLINE);
 
-		for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-			page = pfn_to_online_page(pfn);
-			if (!page)
-				continue;
+	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		page = pfn_to_online_page(pfn);
+		if (!page)
+			continue;
 
-			rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
-			if (rc) {
-				end_pfn = pfn;
-				goto rollback_safe_unplug;
-			}
+		rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
+		if (rc) {
+			end_pfn = pfn;
+			goto rollback;
 		}
-		mutex_unlock(&vm->hotplug_mutex);
 	}
+	mutex_unlock(&vm->hotplug_mutex);
 
 	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
 	if (rc) {
-		if (bbm_safe_unplug) {
-			mutex_lock(&vm->hotplug_mutex);
-			goto rollback_safe_unplug;
-		}
-		return rc;
+		mutex_lock(&vm->hotplug_mutex);
+		goto rollback;
 	}
 
 	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
@@ -2154,7 +2143,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 					    VIRTIO_MEM_BBM_BB_UNUSED);
 	return rc;
 
-rollback_safe_unplug:
+rollback:
 	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
 		page = pfn_to_online_page(pfn);
 		if (!page)
-- 
2.41.0

