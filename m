Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7AD7CB70F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjJPXc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJPXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:32:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 434339F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3AB4920B74C5;
        Mon, 16 Oct 2023 16:32:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AB4920B74C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697499159;
        bh=SfHUHeC+bsZlpMjAFeDGrDjrFJ/Saq7zYvmmmQIZG2o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JBDgiG0Iw0V/I83sKz/7TLqCH1WGNHbaqiN/L1djBYTo9C+2lSnwInQ+rPUbadLrK
         bfb/8Qfc1IRoTuk6K7U+UDcnHXhAQtM1nxDLrlcYMUkQBuvdcgG+KaRapIhBAl0hqB
         2GotHRQuOMWqC7nGeuz9y1TDF2EDEuFvRaRAj9tU=
From:   madvenka@linux.microsoft.com
To:     gregkh@linuxfoundation.org, pbonzini@redhat.com, rppt@kernel.org,
        jgowans@amazon.com, graf@amazon.de, arnd@arndb.de,
        keescook@chromium.org, stanislav.kinsburskii@gmail.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        jamorris@linux.microsoft.com
Subject: [RFC PATCH v1 07/10] mm/prmem: Implement named Persistent Instances.
Date:   Mon, 16 Oct 2023 18:32:12 -0500
Message-Id: <20231016233215.13090-8-madvenka@linux.microsoft.com>
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

To persist any data, a consumer needs to do the following:

	- create a persistent instance for it. The instance gets recorded
	  in the metadata.

	- Name the instance.

	- Record the instance data in the instance.

	- Retrieve the instance by name after kexec.

	- Retrieve instance data.

Implement the following API for consumers:

prmem_get(subsystem, name, create)

	Get/Create a persistent instance. The consumer provides the name
	of the subsystem and the name of the instance within the subsystem.
	E.g., for a persistent ramdisk block device:
		subsystem = "ramdisk"
		instance  = "pram0"

prmem_set_data()

	Record a data pointer and a size for the instance. An instance may
	contain many data structures connected to each other using pointers,
	etc. A consumer is expected to record the top level data structure
	in the instance. All other data structures must be reachable from
	the top level data structure.

prmem_get_data()

	Retrieve the data pointer and the size for the instance.

prmem_put()

	Destroy a persistent instance. The instance data must be NULL at
	this point. So, the consumer is responsible for freeing the
	instance data and setting it to NULL in the instance prior to
	destroying.

prmem_list()

	Walk the instances of a subsystem and call a callback for each.
	This allows a consumer to enumerate all of the instances associated
	with a subsystem.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
---
 include/linux/prmem.h         |  36 +++++++++
 kernel/prmem/Makefile         |   2 +-
 kernel/prmem/prmem_init.c     |   1 +
 kernel/prmem/prmem_instance.c | 139 ++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 kernel/prmem/prmem_instance.c

diff --git a/include/linux/prmem.h b/include/linux/prmem.h
index 1cb4660cf35e..c7034690f7cb 100644
--- a/include/linux/prmem.h
+++ b/include/linux/prmem.h
@@ -50,6 +50,28 @@ struct prmem_region {
 	struct gen_pool_chunk	*chunk;
 };
 
+#define PRMEM_MAX_NAME		32
+
+/*
+ * To persist any data, a persistent instance is created for it and the data is
+ * "remembered" in the instance.
+ *
+ * node		List node
+ * subsystem	Subsystem/driver/module that created the instance. E.g.,
+ *		"ramdisk" for the ramdisk driver.
+ * name		Instance name within the subsystem/driver/module. E.g., "pram0"
+ *		for a persistent ramdisk instance.
+ * data		Pointer to data. E.g., the radix tree of pages in a ram disk.
+ * size		Size of data.
+ */
+struct prmem_instance {
+	struct list_head	node;
+	char			subsystem[PRMEM_MAX_NAME];
+	char			name[PRMEM_MAX_NAME];
+	void			*data;
+	size_t			size;
+};
+
 #define PRMEM_MAX_CACHES	14
 
 /*
@@ -63,6 +85,8 @@ struct prmem_region {
  *
  * regions	List of memory regions.
  *
+ * instances	Persistent instances.
+ *
  * caches	Caches for different object sizes. For allocations smaller than
  *		PAGE_SIZE, these caches are used.
  */
@@ -74,6 +98,9 @@ struct prmem {
 	/* Persistent Regions. */
 	struct list_head	regions;
 
+	/* Persistent Instances. */
+	struct list_head	instances;
+
 	/* Allocation caches. */
 	void			*caches[PRMEM_MAX_CACHES];
 };
@@ -85,6 +112,8 @@ extern size_t			prmem_size;
 extern bool			prmem_inited;
 extern spinlock_t		prmem_lock;
 
+typedef int (*prmem_list_func_t)(struct prmem_instance *instance, void *arg);
+
 /* Kernel API. */
 void prmem_reserve_early(void);
 void prmem_reserve(void);
@@ -98,6 +127,13 @@ void prmem_free_pages(struct page *pages, unsigned int order);
 void *prmem_alloc(size_t size, gfp_t gfp);
 void prmem_free(void *va, size_t size);
 
+/* Persistent Instance API. */
+void *prmem_get(char *subsystem, char *name, bool create);
+void prmem_set_data(struct prmem_instance *instance, void *data, size_t size);
+void prmem_get_data(struct prmem_instance *instance, void **data, size_t *size);
+bool prmem_put(struct prmem_instance *instance);
+int prmem_list(char *subsystem, prmem_list_func_t func, void *arg);
+
 /* Internal functions. */
 struct prmem_region *prmem_add_region(unsigned long pa, size_t size);
 bool prmem_create_pool(struct prmem_region *region, bool new_region);
diff --git a/kernel/prmem/Makefile b/kernel/prmem/Makefile
index 99bb19f0afd3..0ed7976580d6 100644
--- a/kernel/prmem/Makefile
+++ b/kernel/prmem/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y += prmem_parse.o prmem_reserve.o prmem_init.o prmem_region.o prmem_misc.o
-obj-y += prmem_allocator.o
+obj-y += prmem_allocator.o prmem_instance.o
diff --git a/kernel/prmem/prmem_init.c b/kernel/prmem/prmem_init.c
index d23833d296fe..166fca688ab3 100644
--- a/kernel/prmem/prmem_init.c
+++ b/kernel/prmem/prmem_init.c
@@ -21,6 +21,7 @@ void __init prmem_init(void)
 		prmem->metadata = prmem_metadata;
 		prmem->size = prmem_size;
 		INIT_LIST_HEAD(&prmem->regions);
+		INIT_LIST_HEAD(&prmem->instances);
 
 		if (!prmem_add_region(prmem_pa, prmem_size))
 			return;
diff --git a/kernel/prmem/prmem_instance.c b/kernel/prmem/prmem_instance.c
new file mode 100644
index 000000000000..ee3554d0ab8b
--- /dev/null
+++ b/kernel/prmem/prmem_instance.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Persistent-Across-Kexec memory (prmem) - Persistent instances.
+ *
+ * Copyright (C) 2023 Microsoft Corporation
+ * Author: Madhavan T. Venkataraman (madvenka@linux.microsoft.com)
+ */
+#include <linux/prmem.h>
+
+static struct prmem_instance *prmem_find(char *subsystem, char *name)
+{
+	struct prmem_instance	*instance;
+
+	list_for_each_entry(instance, &prmem->instances, node) {
+		if (!strcmp(instance->subsystem, subsystem) &&
+		    !strcmp(instance->name, name)) {
+			return instance;
+		}
+	}
+	return NULL;
+}
+
+void *prmem_get(char *subsystem, char *name, bool create)
+{
+	int			subsystem_len = strlen(subsystem);
+	int			name_len = strlen(name);
+	struct prmem_instance	*instance;
+
+	/*
+	 * In early boot, you are allowed to get an existing instance. But
+	 * you are not allowed to create one until prmem is fully initialized.
+	 */
+	if (!prmem || (!prmem_inited && create))
+		return NULL;
+
+	if (!subsystem_len || subsystem_len >= PRMEM_MAX_NAME ||
+	    !name_len || name_len >= PRMEM_MAX_NAME) {
+		return NULL;
+	}
+
+	spin_lock(&prmem_lock);
+
+	/* Check if it already exists. */
+	instance = prmem_find(subsystem, name);
+	if (instance || !create)
+		goto unlock;
+
+	instance = prmem_alloc_locked(sizeof(*instance));
+	if (!instance)
+		goto unlock;
+
+	strcpy(instance->subsystem, subsystem);
+	strcpy(instance->name, name);
+	instance->data = NULL;
+	instance->size = 0;
+
+	list_add_tail(&instance->node, &prmem->instances);
+unlock:
+	spin_unlock(&prmem_lock);
+	return instance;
+}
+EXPORT_SYMBOL_GPL(prmem_get);
+
+void prmem_set_data(struct prmem_instance *instance, void *data, size_t size)
+{
+	if (!prmem_inited)
+		return;
+
+	spin_lock(&prmem_lock);
+	instance->data = data;
+	instance->size = size;
+	spin_unlock(&prmem_lock);
+}
+EXPORT_SYMBOL_GPL(prmem_set_data);
+
+void prmem_get_data(struct prmem_instance *instance, void **data, size_t *size)
+{
+	if (!prmem)
+		return;
+
+	spin_lock(&prmem_lock);
+	*data = instance->data;
+	*size = instance->size;
+	spin_unlock(&prmem_lock);
+}
+EXPORT_SYMBOL_GPL(prmem_get_data);
+
+bool prmem_put(struct prmem_instance *instance)
+{
+	if (!prmem_inited)
+		return true;
+
+	spin_lock(&prmem_lock);
+
+	if (instance->data) {
+		/*
+		 * Caller is responsible for freeing instance data and setting
+		 * it to NULL.
+		 */
+		spin_unlock(&prmem_lock);
+		return false;
+	}
+
+	/* Free instance. */
+	list_del(&instance->node);
+	prmem_free_locked(instance, sizeof(*instance));
+
+	spin_unlock(&prmem_lock);
+	return true;
+}
+EXPORT_SYMBOL_GPL(prmem_put);
+
+int prmem_list(char *subsystem, prmem_list_func_t func, void *arg)
+{
+	int			subsystem_len = strlen(subsystem);
+	struct prmem_instance	*instance;
+	int			ret;
+
+	if (!prmem)
+		return 0;
+
+	if (!subsystem_len || subsystem_len >= PRMEM_MAX_NAME)
+		return -EINVAL;
+
+	spin_lock(&prmem_lock);
+
+	list_for_each_entry(instance, &prmem->instances, node) {
+		if (strcmp(instance->subsystem, subsystem))
+			continue;
+
+		ret = func(instance, arg);
+		if (ret)
+			break;
+	}
+
+	spin_unlock(&prmem_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(prmem_list);
-- 
2.25.1

