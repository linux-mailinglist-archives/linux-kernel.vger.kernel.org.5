Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B978C5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjH2NeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbjH2NdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D4E73;
        Tue, 29 Aug 2023 06:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB8696182F;
        Tue, 29 Aug 2023 13:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B955C433D9;
        Tue, 29 Aug 2023 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315945;
        bh=zAfL9VjGXc4IzETDr4PebRkgD3HymZWi4GCYoJtKNN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OTplIusPkKX/Xd3Kp/aWvedEOubGHPgRlgVDJ/EUTndEVWBiouUR1Wynl90UmiSZC
         UfigdUCVH6Zr/kRkQdR9r0yCpuaLL56AzSA9nDedAHBmLdtjld8szkyjBsRfHPw95J
         nCz31Slbc2nfNSnx4CIuO03oo/5EwiaZi4F2W7EuaxnveAaUKWmJWRnKVua3MryAVx
         wbZi1/SyZXQsX8QVtEjbqUIMeeuCcf6hRPR0KJfL6T1yy2K9Ra1wHurz9n1F8gVBBI
         FPIVTwMWMq8zOr/pK4ra/TGJ9+NkfUYqa3VLO6F1HFzh9wxhJ5DLJg1JtkjVTQcnIs
         lrJmOaa/3Dq0w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.4 06/17] virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
Date:   Tue, 29 Aug 2023 09:31:53 -0400
Message-Id: <20230829133211.519957-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit f504e15b94eb4e5b47f8715da59c0207f68dffe1 ]

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
Message-Id: <20230713145551.2824980-2-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 51 +++++++++++++++----------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 835f6cc2fb664..ed15d2a4bd96b 100644
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
2.40.1

