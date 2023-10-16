Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D27CB710
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjJPXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbjJPXco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62414F0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 157B920B74C2;
        Mon, 16 Oct 2023 16:32:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 157B920B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499161;
        bh=jdahwvucpOV4HlU+VMir0deFqTNbGFSK5yumW26pSKk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hwWrpHDqsY/2Vc+kA26DX4AIcUqm9xfrrtFP6iNdt65sOgThXhvGUFVGRtjVyVMbc
         i9pcqWdkXmXOfByFXjbedYuNDtoZxt7dtYjpDjpGLDLbnu3UYy6RDhfQ5eKpv6S6ay
         7KM//RnndVIjbifxyWzsM+TLr8msP/bETMWpn14Y=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 10/10] mm/prmem: Implement dynamic expansion of prmem.
Date:   Mon, 16 Oct 2023 18:32:15 -0500
Message-Id: <20231016233215.13090-11-madvenka@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016233215.13090-1-madvenka@linux.microsoft.com>
References: <1b1bc25eb87355b91fcde1de7c2f93f38abb2bf9>
 <20231016233215.13090-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

For some use cases, it is hard to predict how much actual memory is
needed to store persistent data. This will depend on the workload. Either
we would have to overcommit memory for persistent data. Or, we could
allow dynamic expansion of prmem memory.

Implement dynamic expansion of prmem. When the allocator runs out of memory
it calls alloc_pages(MAX_ORDER) to allocate a max order page. It creates a
region for that memory and adds it to the list of regions. Then, the
allocator can allocate from that region.

To allow this, extend the command line parameter:

	prmem=size[KMG][,max_size[KMG]]

Size is allocated upfront as mentioned before. Between size and max_size,
prmem is expanded dynamically as mentioned above.

Choosing a max order page means that no fragmentation is created for
transparent huge pages and kmem slabs. But fragmentation may be created
for 1GB pages. This is not a problem for 1GB pages that are reserved
up front. This could be a problem for 1GB pages that are allocated at
run time dynamically.

If max_size is omitted from the command line parameter, no dynamic
expansion will happen.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 include/linux/prmem.h          |  8 +++++++
 kernel/prmem/prmem_allocator.c | 38 ++++++++++++++++++++++++++++++++++
 kernel/prmem/prmem_init.c      |  1 +
 kernel/prmem/prmem_misc.c      |  3 ++-
 kernel/prmem/prmem_parse.c     | 20 +++++++++++++++++-
 kernel/prmem/prmem_region.c    |  1 +
 kernel/prmem/prmem_reserve.c   |  1 +
 7 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/include/linux/prmem.h b/include/linux/prmem.h
index c7034690f7cb..bb552946cb5b 100644
--- a/include/linux/prmem.h
+++ b/include/linux/prmem.h
@@ -83,6 +83,9 @@ struct prmem_instance {
  * metadata	Physical address of the metadata page.
  * size		Size of initial memory allocated to prmem.
  *
+ * cur_size	Current amount of memory allocated to prmem.
+ * max_size	Maximum amount of memory that can be allocated to prmem.
+ *
  * regions	List of memory regions.
  *
  * instances	Persistent instances.
@@ -95,6 +98,10 @@ struct prmem {
 	unsigned long		metadata;
 	size_t			size;
 
+	/* Dynamic expansion. */
+	size_t			cur_size;
+	size_t			max_size;
+
 	/* Persistent Regions. */
 	struct list_head	regions;
 
@@ -109,6 +116,7 @@ extern struct prmem		*prmem;
 extern unsigned long		prmem_metadata;
 extern unsigned long		prmem_pa;
 extern size_t			prmem_size;
+extern size_t			prmem_max_size;
 extern bool			prmem_inited;
 extern spinlock_t		prmem_lock;
 
diff --git a/kernel/prmem/prmem_allocator.c b/kernel/prmem/prmem_allocator.c
index f12975bc6777..1cb3eae8a3e7 100644
--- a/kernel/prmem/prmem_allocator.c
+++ b/kernel/prmem/prmem_allocator.c
@@ -9,17 +9,55 @@
 
 /* Page Allocation functions. */
 
+static void prmem_expand(void)
+{
+	struct prmem_region	*region;
+	struct page		*pages;
+	unsigned int		order = MAX_ORDER;
+	size_t			size = (1UL << order) << PAGE_SHIFT;
+
+	if (prmem->cur_size + size > prmem->max_size)
+		return;
+
+	spin_unlock(&prmem_lock);
+	pages = alloc_pages(GFP_NOWAIT, order);
+	spin_lock(&prmem_lock);
+
+	if (!pages)
+		return;
+
+	/* cur_size may have changed. Recheck. */
+	if (prmem->cur_size + size > prmem->max_size)
+		goto free;
+
+	region = prmem_add_region(page_to_phys(pages), size);
+	if (!region)
+		goto free;
+
+	pr_warn("%s: prmem expanded by %ld\n", __func__, size);
+	return;
+free:
+	__free_pages(pages, order);
+}
+
 void *prmem_alloc_pages_locked(unsigned int order)
 {
 	struct prmem_region	*region;
 	void			*va;
 	size_t			size = (1UL << order) << PAGE_SHIFT;
+	bool			expand = true;
 
+retry:
 	list_for_each_entry(region, &prmem->regions, node) {
 		va = prmem_alloc_pool(region, size, size);
 		if (va)
 			return va;
 	}
+	if (expand) {
+		expand = false;
+		prmem_expand();
+		goto retry;
+	}
 	return NULL;
 }
 
diff --git a/kernel/prmem/prmem_init.c b/kernel/prmem/prmem_init.c
index 166fca688ab3..f4814cc88508 100644
--- a/kernel/prmem/prmem_init.c
+++ b/kernel/prmem/prmem_init.c
@@ -20,6 +20,7 @@ void __init prmem_init(void)
 		/* Cold boot. */
 		prmem->metadata = prmem_metadata;
 		prmem->size = prmem_size;
+		prmem->max_size = prmem_max_size;
 		INIT_LIST_HEAD(&prmem->regions);
 		INIT_LIST_HEAD(&prmem->instances);
 
diff --git a/kernel/prmem/prmem_misc.c b/kernel/prmem/prmem_misc.c
index 49b6a7232c1a..3100662d2cbe 100644
--- a/kernel/prmem/prmem_misc.c
+++ b/kernel/prmem/prmem_misc.c
@@ -68,7 +68,8 @@ bool __init prmem_validate(void)
 	unsigned long		checksum;
 
 	/* Sanity check the boot parameter. */
-	if (prmem_metadata != prmem->metadata || prmem_size != prmem->size) {
+	if (prmem_metadata != prmem->metadata || prmem_size != prmem->size ||
+	    prmem_max_size != prmem->max_size) {
 		pr_warn("%s: Boot parameter mismatch\n", __func__);
 		return false;
 	}
diff --git a/kernel/prmem/prmem_parse.c b/kernel/prmem/prmem_parse.c
index 6c1a23c6b84e..3a57b37fa191 100644
--- a/kernel/prmem/prmem_parse.c
+++ b/kernel/prmem/prmem_parse.c
@@ -8,9 +8,11 @@
 #include <linux/prmem.h>
 
 /*
- * Syntax: prmem=size[KMG]
+ * Syntax: prmem=size[KMG][,max_size[KMG]]
  *
  *	Specifies the size of the initial memory to be allocated to prmem.
+ *	Optionally, specifies the maximum amount of memory to be allocated to
+ *	prmem. prmem will expand dynamically between size and max_size.
  */
 static int __init prmem_size_parse(char *cmdline)
 {
@@ -28,6 +30,22 @@ static int __init prmem_size_parse(char *cmdline)
 	}
 
 	prmem_size = size;
+	prmem_max_size = size;
+
+	cur = tmp;
+	if (*cur++ == ',') {
+		/* Get max size. */
+		size = memparse(cur, &tmp);
+		if (cur == tmp || !size || size & (PAGE_SIZE - 1) ||
+		    size <= prmem_size) {
+			prmem_size = 0;
+			prmem_max_size = 0;
+			pr_warn("%s: Incorrect max size %lx\n", __func__, size);
+			return -EINVAL;
+		}
+		prmem_max_size = size;
+	}
+
 	return 0;
 }
 early_param("prmem", prmem_size_parse);
diff --git a/kernel/prmem/prmem_region.c b/kernel/prmem/prmem_region.c
index 6dc88c74d9c8..390329a34b74 100644
--- a/kernel/prmem/prmem_region.c
+++ b/kernel/prmem/prmem_region.c
@@ -82,5 +82,6 @@ struct prmem_region *prmem_add_region(unsigned long pa, size_t size)
 		return NULL;
 
 	list_add_tail(&region->node, &prmem->regions);
+	prmem->cur_size += size;
 	return region;
 }
diff --git a/kernel/prmem/prmem_reserve.c b/kernel/prmem/prmem_reserve.c
index 8000fff05402..c5ae5d7d8f0a 100644
--- a/kernel/prmem/prmem_reserve.c
+++ b/kernel/prmem/prmem_reserve.c
@@ -11,6 +11,7 @@ struct prmem		*prmem;
 unsigned long		prmem_metadata;
 unsigned long		prmem_pa;
 unsigned long		prmem_size;
+unsigned long		prmem_max_size;
 
 void __init prmem_reserve_early(void)
 {
-- 
2.25.1

