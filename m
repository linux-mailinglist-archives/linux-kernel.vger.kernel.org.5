Return-Path: <linux-kernel+bounces-21745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC7A8293AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BBB289799
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334332C7D;
	Wed, 10 Jan 2024 06:22:50 +0000 (UTC)
Received: from smtp238.sjtu.edu.cn (smtp238.sjtu.edu.cn [202.120.2.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95A2E623
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from mta90.sjtu.edu.cn (unknown [10.118.0.90])
	by smtp238.sjtu.edu.cn (Postfix) with ESMTPS id 96E9AFD3;
	Wed, 10 Jan 2024 14:22:43 +0800 (CST)
Received: from mstore135.sjtu.edu.cn (unknown [10.118.0.135])
	by mta90.sjtu.edu.cn (Postfix) with ESMTP id 1B5C537C878;
	Wed, 10 Jan 2024 14:22:43 +0800 (CST)
Date: Wed, 10 Jan 2024 14:22:42 +0800 (CST)
From: Zheyun Shen <szy0127@sjtu.edu.cn>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Cc: mst <mst@redhat.com>, david <david@redhat.com>, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com
Message-ID: <2035137075.1083380.1704867762955.JavaMail.zimbra@sjtu.edu.cn>
Subject: [PATCH] driver/virtio: Add Memory Balloon Support for SEV/SEV-ES
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.0.5_GA_4574 (ZimbraWebClient - GC120 (Win)/10.0.5_GA_4574)
Thread-Index: nRAlPVyQalrgrDDzaMwssMGu/GR6fw==
Thread-Topic: driver/virtio: Add Memory Balloon Support for SEV/SEV-ES

For now, SEV pins guest's memory to avoid swapping or
moving ciphertext, but leading to the inhibition of
Memory Ballooning.

In Memory Ballooning, only guest's free pages will be relocated
in balloon inflation and deflation, so the difference of plaintext
doesn't matter to guest.

Memory Ballooning is a nice memory overcommitment technology can
be used in CVM based on SEV and SEV-ES, so userspace tools can
provide an option to allow SEV not to pin memory and enable 
Memory Ballooning. Guest kernel may not inhibit Balloon and 
should set shared memory for Balloon decrypted.

Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
---
 drivers/virtio/virtio_balloon.c | 18 ++++++++++++++++++
 drivers/virtio/virtio_ring.c    |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fe93e93f..aca4c8a58 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -18,6 +18,9 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#include <linux/set_memory.h>
+#endif
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -870,6 +873,9 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 static int virtballoon_probe(struct virtio_device *vdev)
 {
         struct virtio_balloon *vb;
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+        size_t vb_size = PAGE_ALIGN(sizeof(*vb));
+#endif
         int err;
 
         if (!vdev->config->get) {
@@ -878,11 +884,19 @@ static int virtballoon_probe(struct virtio_device *vdev)
                 return -EINVAL;
         }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+        vdev->priv = vb = kzalloc(vb_size, GFP_KERNEL);
+#else
         vdev->priv = vb = kzalloc(sizeof(*vb), GFP_KERNEL);
+#endif
         if (!vb) {
                 err = -ENOMEM;
                 goto out;
         }
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+        set_memory_decrypted((unsigned long)vb, vb_size / PAGE_SIZE);
+        memset(vb, 0, vb_size);
+#endif
 
         INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
         INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
@@ -1101,7 +1115,11 @@ static int virtballoon_validate(struct virtio_device *vdev)
         else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
                 __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+        __virtio_set_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
+#else
         __virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
+#endif
         return 0;
 }
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49299b1f9..875612a2e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -14,6 +14,9 @@
 #include <linux/kmsan.h>
 #include <linux/spinlock.h>
 #include <xen/xen.h>
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+#include <linux/set_memory.h>
+#endif
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
@@ -321,6 +324,10 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
                 if (queue) {
                         phys_addr_t phys_addr = virt_to_phys(queue);
                         *dma_handle = (dma_addr_t)phys_addr;
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+                        set_memory_decrypted((unsigned long)queue, PAGE_ALIGN(size) / PAGE_SIZE);
+                        memset(queue, 0, PAGE_ALIGN(size));
+#endif
 
                         /*
                          * Sanity check: make sure we dind't truncate
--
2.34.1

