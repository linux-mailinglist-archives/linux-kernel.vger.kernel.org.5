Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4B7525C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjGMO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjGMO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AA2D45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bk+toP/Ed4qPpAgMLWeptgvuADn7go/7Jo6jlttF96s=;
        b=gNSwROucsZMlcoBwn+p2eERWuaXeVuw+ri+Gq2TpGXSI3q7kzYg33kF9tQXZx3K5T6J9dH
        NC/cKna0b6CNW7GLFa17Rt/WRrMgnBOuXgOfSbZTPPNWhXCER+4RI5KaUX8ddsaXfqsO0i
        IBJ94gFqHvglentirGpwYhLealUd3l4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-pEnhlwaAPsitRYud8qL9ig-1; Thu, 13 Jul 2023 10:56:02 -0400
X-MC-Unique: pEnhlwaAPsitRYud8qL9ig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58A8086F122;
        Thu, 13 Jul 2023 14:56:02 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 197A0F66CB;
        Thu, 13 Jul 2023 14:56:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v1 4/4] virtio-mem: check if the config changed before fake offlining memory
Date:   Thu, 13 Jul 2023 16:55:51 +0200
Message-ID: <20230713145551.2824980-5-david@redhat.com>
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

If we repeatedly fail to fake offline memory to unplug it, we won't be
sending any unplug requests to the device. However, we only check if the
config changed when sending such (un)plug requests.

We could end up trying for a long time to unplug memory, even though
the config changed already and we're not supposed to unplug memory
anymore. For example, the hypervisor might detect a low-memory situation
while unplugging memory and decide to replug some memory. Continuing
trying to unplug memory in that case can be problematic.

So let's check on a more regular basis.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a5cf92e3e5af..fa5226c198cc 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1189,7 +1189,8 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
  * Try to allocate a range, marking pages fake-offline, effectively
  * fake-offlining them.
  */
-static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
+static int virtio_mem_fake_offline(struct virtio_mem *vm, unsigned long pfn,
+				   unsigned long nr_pages)
 {
 	const bool is_movable = is_zone_movable_page(pfn_to_page(pfn));
 	int rc, retry_count;
@@ -1202,6 +1203,14 @@ static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 	 * some guarantees.
 	 */
 	for (retry_count = 0; retry_count < 5; retry_count++) {
+		/*
+		 * If the config changed, stop immediately and go back to the
+		 * main loop: avoid trying to keep unplugging if the device
+		 * might have decided to not remove any more memory.
+		 */
+		if (atomic_read(&vm->config_changed))
+			return -EAGAIN;
+
 		rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
 					GFP_KERNEL);
 		if (rc == -ENOMEM)
@@ -1951,7 +1960,7 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->sbm.sb_size);
 
-	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
+	rc = virtio_mem_fake_offline(vm, start_pfn, nr_pages);
 	if (rc)
 		return rc;
 
@@ -2149,7 +2158,7 @@ static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
 		if (!page)
 			continue;
 
-		rc = virtio_mem_fake_offline(pfn, PAGES_PER_SECTION);
+		rc = virtio_mem_fake_offline(vm, pfn, PAGES_PER_SECTION);
 		if (rc) {
 			end_pfn = pfn;
 			goto rollback;
-- 
2.41.0

