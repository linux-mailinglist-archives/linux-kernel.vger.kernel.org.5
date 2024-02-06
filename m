Return-Path: <linux-kernel+bounces-54331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6CE84ADBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A456283793
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287877F2A;
	Tue,  6 Feb 2024 04:57:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F877F19
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707195464; cv=none; b=d/ODRF7Ral9Zwe2xx4e4pKRay8ep/lyiK09Oiv3tILjuGRCG8fzc9iW3l3+zHgnUzTGyzdICQzuraOufMUfBSzS6qmF+ZItnvmd1EGCG2YaFvDB8aRMYNwItvKQgf6/oRtmxWF/Kp0h4yCxScTXcjV4LclYhj5Nee67iewC94Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707195464; c=relaxed/simple;
	bh=C7dEciQXByHTE3Dmv/L9UCYEwE6MR5xRJb9k0LLOyYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d9CHyX+Z6burNoBrYAA0RQBuKM+k19RJazXMVpQCO3wSlVIfStbVbz/VqB9PqeO2L6x7XpElKN6X4OWltHKILPszaMqCGXJqfTdvWfzoflLyA1brUxKg8znGwx2f7kjnZrgklaDuv2zOsMV2D5FgoQLlpCmjAjKV40TEpNtXOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A5AE12FC;
	Mon,  5 Feb 2024 20:58:23 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.42.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A26283F641;
	Mon,  5 Feb 2024 20:57:38 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: alexandru.elisei@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/cma: Add sysfs file 'release_pages_success'
Date: Tue,  6 Feb 2024 10:27:31 +0530
Message-Id: <20240206045731.472759-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the following new sysfs file tracking the number of successfully
released pages from a given CMA heap area. Also like before - this will be
available via CONFIG_CMA_SYSFS, and help in determining active CMA pages
available on the system.

/sys/kernel/mm/cma/<cma-heap-area>/release_pages_success

It adds an element 'nr_pages_released' (with CONFIG_CMA_SYSFS config) into
'struct cma' which gets updated during cma_release().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.8-rc3

Some earlier relevant discussions regarding arm64 MTE dynamic tag storage
in this regard can be found here.

https://lore.kernel.org/all/ZbpKyNVHfhf1-AAv@raptor/

 Documentation/ABI/testing/sysfs-kernel-mm-cma |  6 ++++++
 mm/cma.c                                      |  1 +
 mm/cma.h                                      |  5 +++++
 mm/cma_sysfs.c                                | 15 +++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
index 02b2bb60c296..dfd755201142 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-cma
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
@@ -23,3 +23,9 @@ Date:		Feb 2021
 Contact:	Minchan Kim <minchan@kernel.org>
 Description:
 		the number of pages CMA API failed to allocate
+
+What:		/sys/kernel/mm/cma/<cma-heap-name>/release_pages_success
+Date:		Feb 2024
+Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
+Description:
+		the number of pages CMA API succeeded to release
diff --git a/mm/cma.c b/mm/cma.c
index 2627f4ba481f..4f95266eba1d 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -559,6 +559,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
 
 	free_contig_range(pfn, count);
 	cma_clear_bitmap(cma, pfn, count);
+	cma_sysfs_account_release_pages(cma, count);
 	trace_cma_release(cma->name, pfn, pages, count);
 
 	return true;
diff --git a/mm/cma.h b/mm/cma.h
index 88a0595670b7..ad61cc6dd439 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -27,6 +27,8 @@ struct cma {
 	atomic64_t nr_pages_succeeded;
 	/* the number of CMA page allocation failures */
 	atomic64_t nr_pages_failed;
+	/* the number of CMA page released */
+	atomic64_t nr_pages_released;
 	/* kobject requires dynamic object */
 	struct cma_kobject *cma_kobj;
 #endif
@@ -44,10 +46,13 @@ static inline unsigned long cma_bitmap_maxno(struct cma *cma)
 #ifdef CONFIG_CMA_SYSFS
 void cma_sysfs_account_success_pages(struct cma *cma, unsigned long nr_pages);
 void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages);
+void cma_sysfs_account_release_pages(struct cma *cma, unsigned long nr_pages);
 #else
 static inline void cma_sysfs_account_success_pages(struct cma *cma,
 						   unsigned long nr_pages) {};
 static inline void cma_sysfs_account_fail_pages(struct cma *cma,
 						unsigned long nr_pages) {};
+static inline void cma_sysfs_account_release_pages(struct cma *cma,
+						   unsigned long nr_pages) {};
 #endif
 #endif
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index 56347d15b7e8..f50db3973171 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -24,6 +24,11 @@ void cma_sysfs_account_fail_pages(struct cma *cma, unsigned long nr_pages)
 	atomic64_add(nr_pages, &cma->nr_pages_failed);
 }
 
+void cma_sysfs_account_release_pages(struct cma *cma, unsigned long nr_pages)
+{
+	atomic64_add(nr_pages, &cma->nr_pages_released);
+}
+
 static inline struct cma *cma_from_kobj(struct kobject *kobj)
 {
 	return container_of(kobj, struct cma_kobject, kobj)->cma;
@@ -48,6 +53,15 @@ static ssize_t alloc_pages_fail_show(struct kobject *kobj,
 }
 CMA_ATTR_RO(alloc_pages_fail);
 
+static ssize_t release_pages_success_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%llu\n", atomic64_read(&cma->nr_pages_released));
+}
+CMA_ATTR_RO(release_pages_success);
+
 static void cma_kobj_release(struct kobject *kobj)
 {
 	struct cma *cma = cma_from_kobj(kobj);
@@ -60,6 +74,7 @@ static void cma_kobj_release(struct kobject *kobj)
 static struct attribute *cma_attrs[] = {
 	&alloc_pages_success_attr.attr,
 	&alloc_pages_fail_attr.attr,
+	&release_pages_success_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cma);
-- 
2.25.1


