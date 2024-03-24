Return-Path: <linux-kernel+bounces-114881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9325A8892E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D38AB23BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2702CCB8C;
	Mon, 25 Mar 2024 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWx3QVK4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613D17821B;
	Sun, 24 Mar 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323533; cv=none; b=uYhwcYRWNMvZbbIzdEVe/jyVENE2m5nGxn4srlz6UU8weEb7RuhajZqBJoviRaH+mSLDnxL3nPDs9E1MjPsSA7gwASxIU4LJpK6qc23BGOFxIGsQ+d6HmX6sO6se8SABizvMfa5+Rdz+G/2g0aUvTp0cVeJiN6d1CGBQcIp6oV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323533; c=relaxed/simple;
	bh=V0UUyMHE5TQCG/GBCG5dV1hF/oCbsYo2IWVzo3KDYjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JACT54SWigSFUEAOIVh8n0UFTc1Wa65thW8XRnFPpxAb5IpZQVUdeVH2mwz+UT2/7u1UFjvsm8dpkIc6GiC/UO1kWd5xqcJ9NcOkjJAZxWWH4tfnP4kXCNqXSzHNrFDlXTQ5qSQymJGbwXTeEe53t6VJq3oxHM3oQKa/BhKX6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWx3QVK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01133C43394;
	Sun, 24 Mar 2024 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323531;
	bh=V0UUyMHE5TQCG/GBCG5dV1hF/oCbsYo2IWVzo3KDYjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWx3QVK4wuc87GslXlMlrOu2rJQvm/7u7nhmvGFUbFXkoMZwrm5jvggmj+RNzRXTs
	 43Psl5cQ0UkjenajDzsr7tk/XMLRQEV8QEq8jM6fBFeALt8Mup4ipI1muN5epyVHci
	 gHe21xznqME0Xpc5xfMFXLg6OBNa0mMhzMcagk49Mor+sePqsvFxtp6zPSrABTA1UA
	 B3UCA+60uUYVd6ntoqB77Akve44BX4LiQuBgdCrAPBUO3UeBan9iVeL6cyPlwptHVE
	 HBcSvKmLwFZZPJ0ti1cMv+fZrVvQzcPE/53YejTD0UEOBJgrc+ZbpK9qYD5tIMU9Er
	 zEa7KtP8ExL8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Changbin Du <changbin.du@huawei.com>,
	Eric Chanudet <echanude@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Xiaoyi Su <suxiaoyi@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 239/317] modules: wait do_free_init correctly
Date: Sun, 24 Mar 2024 19:33:39 -0400
Message-ID: <20240324233458.1352854-240-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Changbin Du <changbin.du@huawei.com>

[ Upstream commit 8f8cd6c0a43ed637e620bbe45a8d0e0c2f4d5130 ]

The synchronization here is to ensure the ordering of freeing of a module
init so that it happens before W+X checking.  It is worth noting it is not
that the freeing was not happening, it is just that our sanity checkers
raced against the permission checkers which assume init memory is already
gone.

Commit 1a7b7d922081 ("modules: Use vmalloc special flag") moved calling
do_free_init() into a global workqueue instead of relying on it being
called through call_rcu(..., do_free_init), which used to allowed us call
do_free_init() asynchronously after the end of a subsequent grace period.
The move to a global workqueue broke the gaurantees for code which needed
to be sure the do_free_init() would complete with rcu_barrier().  To fix
this callers which used to rely on rcu_barrier() must now instead use
flush_work(&init_free_wq).

Without this fix, we still could encounter false positive reports in W+X
checking since the rcu_barrier() here can not ensure the ordering now.

Even worse, the rcu_barrier() can introduce significant delay.  Eric
Chanudet reported that the rcu_barrier introduces ~0.1s delay on a
PREEMPT_RT kernel.

  [    0.291444] Freeing unused kernel memory: 5568K
  [    0.402442] Run /sbin/init as init process

With this fix, the above delay can be eliminated.

Link: https://lkml.kernel.org/r/20240227023546.2490667-1-changbin.du@huawei.com
Fixes: 1a7b7d922081 ("modules: Use vmalloc special flag")
Signed-off-by: Changbin Du <changbin.du@huawei.com>
Tested-by: Eric Chanudet <echanude@redhat.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Xiaoyi Su <suxiaoyi@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/moduleloader.h | 8 ++++++++
 init/main.c                  | 5 +++--
 kernel/module.c              | 9 +++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 1322652a9d0d9..7dc186ec52a29 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -95,6 +95,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
+#ifdef CONFIG_MODULES
+void flush_module_init_free_work(void);
+#else
+static inline void flush_module_init_free_work(void)
+{
+}
+#endif
+
 /* Any cleanup needed when module leaves. */
 void module_arch_cleanup(struct module *mod);
 
diff --git a/init/main.c b/init/main.c
index 5c81d7fb2fe9c..f27e8510b1554 100644
--- a/init/main.c
+++ b/init/main.c
@@ -89,6 +89,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/context_tracking.h>
 #include <linux/random.h>
+#include <linux/moduleloader.h>
 #include <linux/list.h>
 #include <linux/integrity.h>
 #include <linux/proc_ns.h>
@@ -1464,11 +1465,11 @@ static void mark_readonly(void)
 	if (rodata_enabled) {
 		/*
 		 * load_module() results in W+X mappings, which are cleaned
-		 * up with call_rcu().  Let's make sure that queued work is
+		 * up with init_free_wq. Let's make sure that queued work is
 		 * flushed so that we don't hit false positives looking for
 		 * insecure pages which are W+X.
 		 */
-		rcu_barrier();
+		flush_module_init_free_work();
 		mark_rodata_ro();
 		rodata_test();
 	} else
diff --git a/kernel/module.c b/kernel/module.c
index d8d677f01adb5..4d49c32af570c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3713,6 +3713,11 @@ static void do_free_init(struct work_struct *w)
 	}
 }
 
+void flush_module_init_free_work(void)
+{
+	flush_work(&init_free_wq);
+}
+
 #undef MODULE_PARAM_PREFIX
 #define MODULE_PARAM_PREFIX "module."
 /* Default value for module->async_probe_requested */
@@ -3803,8 +3808,8 @@ static noinline int do_init_module(struct module *mod)
 	 * Note that module_alloc() on most architectures creates W+X page
 	 * mappings which won't be cleaned up until do_free_init() runs.  Any
 	 * code such as mark_rodata_ro() which depends on those mappings to
-	 * be cleaned up needs to sync with the queued work - ie
-	 * rcu_barrier()
+	 * be cleaned up needs to sync with the queued work by invoking
+	 * flush_module_init_free_work().
 	 */
 	if (llist_add(&freeinit->node, &init_free_list))
 		schedule_work(&init_free_wq);
-- 
2.43.0


