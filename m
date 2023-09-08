Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D87992A9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbjIHXHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbjIHXHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9B1FF0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694214416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WGIk1aHDuftDWuM242kRZNF3ZGX4IZN2ja3DENxRTe4=;
        b=a0YruaclJuHD+KgQJ02Wx9uaoXKpkdV6StvNzFvwTFAyRdMTNnYQ36uUaplhkMRTvA/yAa
        0gosLASuHgoUJ43MyQF/sd1B4p4ZXaJkdTm0QOWrw6Uxg5Y/1yeWV6X551G8gW/Rd/gxS2
        fV6/CGf2X9mHJEl3TRP1bgrYqGKJogs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-naP80jUdPpC9vJUQx9zLPg-1; Fri, 08 Sep 2023 19:06:53 -0400
X-MC-Unique: naP80jUdPpC9vJUQx9zLPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25D9D3C01BB3;
        Fri,  8 Sep 2023 23:06:53 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.22.17.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA867140E962;
        Fri,  8 Sep 2023 23:06:52 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Rafael Aquini <raquini@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] mm/slab_common: fix slab_caches list corruption after kmem_cache_destroy()
Date:   Fri,  8 Sep 2023 19:06:49 -0400
Message-ID: <20230908230649.802560-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit in Fixes:, if a module that created a slab cache does not
release all of its allocated objects before destroying the cache (at rmmod
time), we might end up releasing the kmem_cache object without removing it
from the slab_caches list thus corrupting the list as kmem_cache_destroy()
ignores the return value from shutdown_cache(), which in turn never removes
the kmem_cache object from slabs_list in case __kmem_cache_shutdown() fails
to release all of the cache's slabs.

This is easily observable on a kernel built with CONFIG_DEBUG_LIST=y
as after that ill release the system will immediately trip on list_add,
or list_del, assertions similar to the one shown below as soon as another
kmem_cache gets created, or destroyed:

  [ 1041.213632] list_del corruption. next->prev should be ffff89f596fb5768, but was 52f1e5016aeee75d. (next=ffff89f595a1b268)
  [ 1041.219165] ------------[ cut here ]------------
  [ 1041.221517] kernel BUG at lib/list_debug.c:62!
  [ 1041.223452] invalid opcode: 0000 [#1] PREEMPT SMP PTI
  [ 1041.225408] CPU: 2 PID: 1852 Comm: rmmod Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
  [ 1041.228244] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
  [ 1041.231212] RIP: 0010:__list_del_entry_valid+0xae/0xb0

Another quick way to trigger this issue, in a kernel with CONFIG_SLUB=y,
is to set slub_debug to poison the released objects and then just run
cat /proc/slabinfo after removing the module that leaks slab objects,
in which case the kernel will panic:

  [   50.954843] general protection fault, probably for non-canonical address 0xa56b6b6b6b6b6b8b: 0000 [#1] PREEMPT SMP PTI
  [   50.961545] CPU: 2 PID: 1495 Comm: cat Kdump: loaded Tainted: G    B   W  OE      6.5.0 #15
  [   50.966808] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc37 05/24/2023
  [   50.972663] RIP: 0010:get_slabinfo+0x42/0xf0

This patch fixes this issue by properly checking shutdown_cache()'s
return value before taking the kmem_cache_release() branch.

Fixes: 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock")
Signed-off-by: Rafael Aquini <aquini@redhat.com>
Cc: stable@vger.kernel.org
---
 mm/slab_common.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index cd71f9581e67..31e581dc6e85 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -479,7 +479,7 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 
 void kmem_cache_destroy(struct kmem_cache *s)
 {
-	int refcnt;
+	int err;
 	bool rcu_set;
 
 	if (unlikely(!s) || !kasan_check_byte(s))
@@ -490,17 +490,20 @@ void kmem_cache_destroy(struct kmem_cache *s)
 
 	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
 
-	refcnt = --s->refcount;
-	if (refcnt)
+	s->refcount--;
+	if (s->refcount) {
+		err = -EBUSY;
 		goto out_unlock;
+	}
 
-	WARN(shutdown_cache(s),
+	err = shutdown_cache(s);
+	WARN(err,
 	     "%s %s: Slab cache still has objects when called from %pS",
 	     __func__, s->name, (void *)_RET_IP_);
 out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
-	if (!refcnt && !rcu_set)
+	if (!err && !rcu_set)
 		kmem_cache_release(s);
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
-- 
2.41.0

