Return-Path: <linux-kernel+bounces-12018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE581EEEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A784B1C22613
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644CB44C8C;
	Wed, 27 Dec 2023 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3xdYdjN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63444C79;
	Wed, 27 Dec 2023 12:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13075C433C9;
	Wed, 27 Dec 2023 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703680709;
	bh=X7R6F9hT6XYOO3BGfeWVV1thc/132FVHa6UnzJbO8Fg=;
	h=From:To:Cc:Subject:Date:From;
	b=s3xdYdjN0JOula1WTh6A2iY780fPuc5IgTrHuxBP2YtCgzASY8pVu5cCIY7V7869q
	 TE0fEUoZX+CYtqtqwXCsY8OYqXoe843PQhGtjEdymRcJLFja1/UF0z70P+ObGRMhcy
	 q5mHqo9TWriOWFO8r/kE4PTdfsTl5/UVNn9H+iJe8JO4oJipqon4Kv1/oyimY/7o8v
	 0TzD2/pQGXH+KeQR/7JBNOzi9SHvR2xPoYCM7SvufLJ2jw0s74kX+eqxEsTqPiypj3
	 zZySoByBOlV7buyytNoiODdK6mDu0ZQbrUqD0ZaH5FVMY98tGXBo8VMIUahi8uB1fA
	 uCC4SF5HSoqYg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix possible memory leak in ftrace_regsiter_direct()
Date: Wed, 27 Dec 2023 21:38:25 +0900
Message-Id: <170368070504.42064.8960569647118388081.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If ftrace_register_direct() called with a large number of target
functions (e.g. 65), the free_hash can be updated twice or more
in the ftrace_add_rec_direct() without freeing the previous hash
memory. Thus this can cause a memory leak.

Fix this issue by expanding the direct_hash at once before
adding the new entries.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Cc: stable@vger.kernel.org
---
 kernel/trace/ftrace.c |   49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..9269c2c3e595 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2555,28 +2555,33 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
-static struct ftrace_func_entry*
-ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
-		      struct ftrace_hash **free_hash)
+static struct ftrace_hash *ftrace_expand_direct(int inc_count)
 {
-	struct ftrace_func_entry *entry;
+	struct ftrace_hash *new_hash, *free_hash;
+	int size = ftrace_hash_empty(direct_functions) ? 0 :
+		direct_functions->count + inc_count;
 
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
+	if (!ftrace_hash_empty(direct_functions) &&
+	    size <= 2 * (1 << direct_functions->size_bits))
+		return NULL;
 
-		if (size < 32)
-			size = 32;
+	if (size < 32)
+		size = 32;
 
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			return NULL;
+	new_hash = dup_hash(direct_functions, size);
+	if (!new_hash)
+		return ERR_PTR(-ENOMEM);
 
-		*free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
+	free_hash = direct_functions;
+	direct_functions = new_hash;
+
+	return free_hash;
+}
+
+static struct ftrace_func_entry*
+ftrace_add_rec_direct(unsigned long ip, unsigned long addr)
+{
+	struct ftrace_func_entry *entry;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
@@ -5436,11 +5441,19 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
+	/* ... and prepare the insertion */
+	free_hash = ftrace_expand_direct(hash->count);
+	if (IS_ERR(free_hash)) {
+		err = PTR_ERR(free_hash);
+		free_hash = NULL;
+		goto out_unlock;
+	}
+
 	/* ... and insert them to direct_functions hash. */
 	err = -ENOMEM;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			new = ftrace_add_rec_direct(entry->ip, addr);
 			if (!new)
 				goto out_remove;
 			entry->direct = addr;


