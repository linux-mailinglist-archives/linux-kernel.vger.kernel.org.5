Return-Path: <linux-kernel+bounces-115387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C21889B47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDF61F38E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E2C84047;
	Mon, 25 Mar 2024 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWYV6E38"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B114430B;
	Sun, 24 Mar 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320662; cv=none; b=btRuP9ABgZKZNQT70H81pPPlW23RLp57VSpfUGh35k08ZeExZPDG2lW5nTK9sPCbr4DwtrqTvVAnvOli08UvXQmvw1Gc7OnywvV4+r6kPT1IWcHSYb38Omdi7RaUp/xzLWv6phIst8Y/0tgEr+0F1JPQdnhhOkvjI98Njrg0VQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320662; c=relaxed/simple;
	bh=lrV3hF7pREKUALqHJGjU2QWD2BAkZOc4EaJoGgQ0cV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHYSPV4M+/cNQJyBfr1B50lP41faZPgygg2B94ITa2VQsnzMS3qWLxlS+5E3u/dPW5tcLa6Oj95SubKgt4VdI7FQl0y/bcl6LnWsvPpW5jv7/yD6UoB+81M8j0B8Jxk/9wOq6g0pVb2Ycqv5b/QKQmRhKfIeN0grOY+sCfMIEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWYV6E38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36147C433F1;
	Sun, 24 Mar 2024 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320661;
	bh=lrV3hF7pREKUALqHJGjU2QWD2BAkZOc4EaJoGgQ0cV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWYV6E38Xy9iUH+8TAS4RPTp0w4W0+Ooz/tTLnc+huR6Ns1eS5YYEKuVQpTBwPUJz
	 XjzmZFLActV0J0IpAwaBIWU39kKel334zWFq3v3EGPrzfRilzdr4u4JrX0waByHLLd
	 rrx9Q2lbjcdgVnRkWYoNtrwrhCXmDF9aT9XIstVvtxkgl0nQ6/wo9UK4Ui6aEaoJEp
	 oOxWJPxxjWDkA31Zp/b8s8G8h5iUEQysELd1Y1BCzGgLvPQ6qIBr5Kl+ILZEYGHzQL
	 s0rFzH3LHcY7Nw1/+S5ZieF0RPjWnB7d0OO4zLIHvzieVqTrzUiOYxGCavu83jOyx5
	 bBbX/p5VIfRWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 224/713] tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
Date: Sun, 24 Mar 2024 18:39:10 -0400
Message-ID: <20240324224720.1345309-225-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Viktor Malik <vmalik@redhat.com>

[ Upstream commit 9707ac4fe2f5bac6406d2403f8b8a64d7b3d8e43 ]

Instead of using magic offsets to access BTF ID set data, leverage types
from btf_ids.h (btf_id_set and btf_id_set8) which define the actual
layout of the data. Thanks to this change, set sorting should also
continue working if the layout changes.

This requires to sync the definition of 'struct btf_id_set8' from
include/linux/btf_ids.h to tools/include/linux/btf_ids.h. We don't sync
the rest of the file at the moment, b/c that would require to also sync
multiple dependent headers and we don't need any other defs from
btf_ids.h.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Daniel Xu <dxu@dxuuu.xyz>
Link: https://lore.kernel.org/bpf/ff7f062ddf6a00815fda3087957c4ce667f50532.1707223196.git.vmalik@redhat.com
Stable-dep-of: 903fad439466 ("tools/resolve_btfids: Fix cross-compilation to non-host endianness")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/resolve_btfids/main.c | 35 ++++++++++++++++++++-------------
 tools/include/linux/btf_ids.h   |  9 +++++++++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 27a23196d58e1..32634f00abba4 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -70,6 +70,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <linux/btf_ids.h>
 #include <linux/rbtree.h>
 #include <linux/zalloc.h>
 #include <linux/err.h>
@@ -78,7 +79,7 @@
 #include <subcmd/parse-options.h>
 
 #define BTF_IDS_SECTION	".BTF_ids"
-#define BTF_ID		"__BTF_ID__"
+#define BTF_ID_PREFIX	"__BTF_ID__"
 
 #define BTF_STRUCT	"struct"
 #define BTF_UNION	"union"
@@ -161,7 +162,7 @@ static int eprintf(int level, int var, const char *fmt, ...)
 
 static bool is_btf_id(const char *name)
 {
-	return name && !strncmp(name, BTF_ID, sizeof(BTF_ID) - 1);
+	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
 }
 
 static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
@@ -441,7 +442,7 @@ static int symbols_collect(struct object *obj)
 		 * __BTF_ID__TYPE__vfs_truncate__0
 		 * prefix =  ^
 		 */
-		prefix = name + sizeof(BTF_ID) - 1;
+		prefix = name + sizeof(BTF_ID_PREFIX) - 1;
 
 		/* struct */
 		if (!strncmp(prefix, BTF_STRUCT, sizeof(BTF_STRUCT) - 1)) {
@@ -649,19 +650,18 @@ static int cmp_id(const void *pa, const void *pb)
 static int sets_patch(struct object *obj)
 {
 	Elf_Data *data = obj->efile.idlist;
-	int *ptr = data->d_buf;
 	struct rb_node *next;
 
 	next = rb_first(&obj->sets);
 	while (next) {
-		unsigned long addr, idx;
+		struct btf_id_set8 *set8;
+		struct btf_id_set *set;
+		unsigned long addr, off;
 		struct btf_id *id;
-		int *base;
-		int cnt;
 
 		id   = rb_entry(next, struct btf_id, rb_node);
 		addr = id->addr[0];
-		idx  = addr - obj->efile.idlist_addr;
+		off = addr - obj->efile.idlist_addr;
 
 		/* sets are unique */
 		if (id->addr_cnt != 1) {
@@ -670,14 +670,21 @@ static int sets_patch(struct object *obj)
 			return -1;
 		}
 
-		idx = idx / sizeof(int);
-		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
-		cnt = ptr[idx];
+		if (id->is_set) {
+			set = data->d_buf + off;
+			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
+		} else {
+			set8 = data->d_buf + off;
+			/*
+			 * Make sure id is at the beginning of the pairs
+			 * struct, otherwise the below qsort would not work.
+			 */
+			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
+			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
+		}
 
 		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
-			 (idx + 1) * sizeof(int), cnt, id->name);
-
-		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
+			 off, id->is_set ? set->cnt : set8->cnt, id->name);
 
 		next = rb_next(next);
 	}
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 2f882d5cb30f5..72535f00572f6 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -8,6 +8,15 @@ struct btf_id_set {
 	u32 ids[];
 };
 
+struct btf_id_set8 {
+	u32 cnt;
+	u32 flags;
+	struct {
+		u32 id;
+		u32 flags;
+	} pairs[];
+};
+
 #ifdef CONFIG_DEBUG_INFO_BTF
 
 #include <linux/compiler.h> /* for __PASTE */
-- 
2.43.0


