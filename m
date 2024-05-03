Return-Path: <linux-kernel+bounces-168169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB38BB4AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD901C22F87
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430F158DBE;
	Fri,  3 May 2024 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B2oPjzU9"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F27158D74
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767539; cv=none; b=WW0cCEy+1onv8LSFY5/VzmZAmfi1LwWPfEobYLKnbrWy2qO537brv4s8ELiHy6dN0E/CjLM+DoZPAGkqLNC7V7Dni/DtVog/awYv1Rfg+bIY/T2R+etIA3KHgiCsDWlUiWKpb8lmv7rtmwbH01/IG078mxvm4DtqdIKBmqbWVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767539; c=relaxed/simple;
	bh=MQR0rIfawIXJM7eucGfnmVHVg0NlJDeQJKgT4M3yfRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d09q6ouSEvJGA+ZZ+om4LFJe9UJ5zDZ1GVeAqzZad4zCsL75qv7ctydhjNEQWdQhYfW76tlnwmyv95Yzx5Z+uCbyxT8RhgkSdzBxcyFsUSyYtbeCPRAJIX2r4ZZgBjip8MHPMATk+s0moHAbuYxk5LvLUzoxr/zmFMc6yH/ZM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B2oPjzU9; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714767535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTvZ377kNqv2XbQCXUI4tQpUioDWvN7zLM46NIQ/7Hg=;
	b=B2oPjzU9Co7oIA51VgN2Vn9qPMVnYaUG48jUStEsB4ezr6E384yme/8haiVwlKHRFmVHqL
	eZQCi5M59YnLrGYVSjR5Ni91l+z5cLpSL5UHDrqKZvZvyPunVy+cVr5Ru+d/LA77i8eIhO
	em00inEpTVP7pZVvy7bF44+S3CMYPHQ=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Frank van der Linden <fvdl@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 1/4] mm: memcg: convert enum res_type to mem_counter_type
Date: Fri,  3 May 2024 13:18:32 -0700
Message-ID: <20240503201835.2969707-2-roman.gushchin@linux.dev>
In-Reply-To: <20240503201835.2969707-1-roman.gushchin@linux.dev>
References: <20240503201835.2969707-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The res_type enum is listing all types of memory tracked by memory
cgroups: generic memory, swap, kernel memory, tcp etc; and it's
currently used only for dealing with corresponding sysfs files.

To prepare for tracking of various types of memory by a single
page_counter structure, a similar enumeration is needed. Instead
of introducing a completely new enumeration, let's re-purpose
the existing one: rename it into mem_counter_type, change items
names to be more meaningful and move to page_counter.h. The latter
is needed to have the total number of different memory types
available.

This change doesn't bring any functional difference, it's a pure
refactoring.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/page_counter.h |  8 ++++
 mm/memcontrol.c              | 91 +++++++++++++++++-------------------
 2 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 8cd858d912c4..2486f98a0c71 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -7,6 +7,14 @@
 #include <linux/limits.h>
 #include <asm/page.h>
 
+enum mem_counter_type {
+	MCT_MEMORY,		/* cgroup v1 and v2 */
+	MCT_SWAP,		/* cgroup v2 only */
+	MCT_MEMSW = MCT_SWAP,	/* cgroup v1 only */
+	MCT_KMEM,		/* cgroup v1 only */
+	MCT_TCPMEM,		/* cgroup v1 only */
+};
+
 struct page_counter {
 	/*
 	 * Make sure 'usage' does not share cacheline with any other field. The
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a13d16cde372..894e5b6fe468 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -206,14 +206,6 @@ static struct move_charge_struct {
 #define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
 #define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
 
-/* for encoding cft->private value on file */
-enum res_type {
-	_MEM,
-	_MEMSWAP,
-	_KMEM,
-	_TCP,
-};
-
 #define MEMFILE_PRIVATE(x, val)	((x) << 16 | (val))
 #define MEMFILE_TYPE(val)	((val) >> 16 & 0xffff)
 #define MEMFILE_ATTR(val)	((val) & 0xffff)
@@ -4108,16 +4100,16 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	struct page_counter *counter;
 
 	switch (MEMFILE_TYPE(cft->private)) {
-	case _MEM:
+	case MCT_MEMORY:
 		counter = &memcg->memory;
 		break;
-	case _MEMSWAP:
+	case MCT_MEMSW:
 		counter = &memcg->memsw;
 		break;
-	case _KMEM:
+	case MCT_KMEM:
 		counter = &memcg->kmem;
 		break;
-	case _TCP:
+	case MCT_TCPMEM:
 		counter = &memcg->tcpmem;
 		break;
 	default:
@@ -4273,20 +4265,20 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 			break;
 		}
 		switch (MEMFILE_TYPE(of_cft(of)->private)) {
-		case _MEM:
+		case MCT_MEMORY:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, false);
 			break;
-		case _MEMSWAP:
+		case MCT_MEMSW:
 			ret = mem_cgroup_resize_max(memcg, nr_pages, true);
 			break;
-		case _KMEM:
+		case MCT_KMEM:
 			pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
 				     "Writing any value to this file has no effect. "
 				     "Please report your usecase to linux-mm@kvack.org if you "
 				     "depend on this functionality.\n");
 			ret = 0;
 			break;
-		case _TCP:
+		case MCT_TCPMEM:
 			ret = memcg_update_tcp_max(memcg, nr_pages);
 			break;
 		}
@@ -4310,16 +4302,16 @@ static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
 	struct page_counter *counter;
 
 	switch (MEMFILE_TYPE(of_cft(of)->private)) {
-	case _MEM:
+	case MCT_MEMORY:
 		counter = &memcg->memory;
 		break;
-	case _MEMSWAP:
+	case MCT_MEMSW:
 		counter = &memcg->memsw;
 		break;
-	case _KMEM:
+	case MCT_KMEM:
 		counter = &memcg->kmem;
 		break;
-	case _TCP:
+	case MCT_TCPMEM:
 		counter = &memcg->tcpmem;
 		break;
 	default:
@@ -4706,7 +4698,8 @@ static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
 }
 
 static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
+	struct eventfd_ctx *eventfd, const char *args,
+	enum mem_counter_type type)
 {
 	struct mem_cgroup_thresholds *thresholds;
 	struct mem_cgroup_threshold_ary *new;
@@ -4720,10 +4713,10 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 
 	mutex_lock(&memcg->thresholds_lock);
 
-	if (type == _MEM) {
+	if (type == MCT_MEMORY) {
 		thresholds = &memcg->thresholds;
 		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
+	} else if (type == MCT_MEMSW) {
 		thresholds = &memcg->memsw_thresholds;
 		usage = mem_cgroup_usage(memcg, true);
 	} else
@@ -4731,7 +4724,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 
 	/* Check if a threshold crossed before adding a new one */
 	if (thresholds->primary)
-		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+		__mem_cgroup_threshold(memcg, type == MCT_MEMSW);
 
 	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
 
@@ -4788,17 +4781,17 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd, const char *args)
 {
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, MCT_MEMORY);
 }
 
 static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd, const char *args)
 {
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, MCT_MEMSW);
 }
 
 static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, enum res_type type)
+	struct eventfd_ctx *eventfd, enum mem_counter_type type)
 {
 	struct mem_cgroup_thresholds *thresholds;
 	struct mem_cgroup_threshold_ary *new;
@@ -4807,10 +4800,10 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 
 	mutex_lock(&memcg->thresholds_lock);
 
-	if (type == _MEM) {
+	if (type == MCT_MEMORY) {
 		thresholds = &memcg->thresholds;
 		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
+	} else if (type == MCT_MEMSW) {
 		thresholds = &memcg->memsw_thresholds;
 		usage = mem_cgroup_usage(memcg, true);
 	} else
@@ -4820,7 +4813,7 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 		goto unlock;
 
 	/* Check if a threshold crossed before removing */
-	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+	__mem_cgroup_threshold(memcg, type == MCT_MEMSW);
 
 	/* Calculate new number of threshold */
 	size = entries = 0;
@@ -4885,13 +4878,13 @@ static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd)
 {
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, MCT_MEMORY);
 }
 
 static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
 	struct eventfd_ctx *eventfd)
 {
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, MCT_MEMSW);
 }
 
 static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
@@ -5426,30 +5419,30 @@ static int memory_stat_show(struct seq_file *m, void *v);
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEMORY, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEMORY, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_MEMORY, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "soft_limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEM, RES_SOFT_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_MEMORY, RES_SOFT_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "failcnt",
-		.private = MEMFILE_PRIVATE(_MEM, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_MEMORY, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
@@ -5498,24 +5491,24 @@ static struct cftype mem_cgroup_legacy_files[] = {
 #endif
 	{
 		.name = "kmem.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.failcnt",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_KMEM, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_KMEM, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
@@ -5527,24 +5520,24 @@ static struct cftype mem_cgroup_legacy_files[] = {
 #endif
 	{
 		.name = "kmem.tcp.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.tcp.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.tcp.failcnt",
-		.private = MEMFILE_PRIVATE(_TCP, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "kmem.tcp.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_TCP, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_TCPMEM, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
@@ -8394,24 +8387,24 @@ static struct cftype swap_files[] = {
 static struct cftype memsw_files[] = {
 	{
 		.name = "memsw.usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_USAGE),
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "memsw.max_usage_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_MAX_USAGE),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_MAX_USAGE),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "memsw.limit_in_bytes",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_LIMIT),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_LIMIT),
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
 	{
 		.name = "memsw.failcnt",
-		.private = MEMFILE_PRIVATE(_MEMSWAP, RES_FAILCNT),
+		.private = MEMFILE_PRIVATE(MCT_MEMSW, RES_FAILCNT),
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
-- 
2.43.2


