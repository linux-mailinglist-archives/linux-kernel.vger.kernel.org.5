Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5944078C5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjH2NeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbjH2Nd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95261E4A;
        Tue, 29 Aug 2023 06:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF9165707;
        Tue, 29 Aug 2023 13:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FBFC433C8;
        Tue, 29 Aug 2023 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315949;
        bh=ms2FDB3jNM4pkoafxxmkuXKTvTc4QVtI/Rqaf/6iA4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=simEZLPuHoHZ4yF/ICZzdb4EzgcHdS/VroLHjdtVDsDR6RN3uIXNJNvs32ObFWzFA
         KEZI9lS9T4MgPgsYxBHU6kCCcGcjKH3D2t7uTi0okdrHiT1b3a81WrkyRKKObrmkbB
         1iJNEB9Xhbyp7aAIqWhm63Yg2h+82LjQyhbN+T4cL1joj1P9hinn1i6qR2vAKGzwGA
         wIW2p7oL52bj8J444rHa61qgtHmRRrpxCIdZoYMmooBqCgnM/aCTnOwC3qv4Z5Gm8z
         j4CWwcXuM3u96Y18hPXKNEE//5e8e0rtyzzve2uDZclJ8XpYxIiRZUb+BnaI0bmhH0
         q9c0JBZsweSNQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.4 09/17] virtio-mem: check if the config changed before fake offlining memory
Date:   Tue, 29 Aug 2023 09:31:56 -0400
Message-Id: <20230829133211.519957-9-sashal@kernel.org>
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

[ Upstream commit f55484fd7be923b740e8e1fc304070ba53675cb4 ]

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
Message-Id: <20230713145551.2824980-5-david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mem.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a5cf92e3e5af2..fa5226c198cc6 100644
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
2.40.1

