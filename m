Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E807FD34F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjK2JyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjK2Jxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:53:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE319BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:53:39 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E628721995;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59C0B13A9D;
        Wed, 29 Nov 2023 09:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id yN2eFSEKZ2UrfQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 29 Nov 2023 09:53:37 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Wed, 29 Nov 2023 10:53:31 +0100
Subject: [PATCH RFC v3 6/9] tools: Add SLUB percpu array functions for
 testing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-slub-percpu-caches-v3-6-6bcf536772bc@suse.cz>
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
In-Reply-To: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        kasan-dev@googlegroups.com, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Queue-Id: E628721995
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         TAGGED_RCPT(0.00)[];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Support new percpu array functions to the test code so they can be used
in the maple tree testing.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/include/linux/slab.h              |  4 ++++
 tools/testing/radix-tree/linux.c        | 14 ++++++++++++++
 tools/testing/radix-tree/linux/kernel.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 311759ea25e9..1043f9c5ef4e 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -7,6 +7,7 @@
 
 #define SLAB_PANIC 2
 #define SLAB_RECLAIM_ACCOUNT    0x00020000UL            /* Objects are reclaimable */
+#define SLAB_NO_MERGE		0x01000000UL		/* Prevent merging with compatible kmem caches */
 
 #define kzalloc_node(size, flags, node) kmalloc(size, flags)
 
@@ -45,4 +46,7 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **list);
 int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 			  void **list);
 
+int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int count);
+int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int count,
+		gfp_t gfp);
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 61fe2601cb3a..3c9372afe9bc 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -187,6 +187,20 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	return size;
 }
 
+int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int count)
+{
+	return 0;
+}
+
+int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int count,
+		gfp_t gfp)
+{
+	if (count > s->non_kernel)
+		return s->non_kernel;
+
+	return count;
+}
+
 struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		unsigned int flags, void (*ctor)(void *))
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
index c5c9d05f29da..fc75018974de 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -15,6 +15,7 @@
 
 #define printk printf
 #define pr_err printk
+#define pr_warn printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk

-- 
2.43.0

