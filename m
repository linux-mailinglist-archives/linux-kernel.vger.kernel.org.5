Return-Path: <linux-kernel+bounces-82614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C7868746
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47EB6B25573
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7714007;
	Tue, 27 Feb 2024 02:36:50 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA236C;
	Tue, 27 Feb 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001410; cv=none; b=eeknyjFHSdCLgiX7QHs8blC3714ISZi8Lc5vhnQJ93R/vTA03LTWHQ2k0y2S3R4i84MbccZ3FOMvMvLOBy0j6ee0CDlXh8i4LjdqRJ6h1sSaqMX0wvmssbUkv4O4m14Ti7xM1KfAHt/nQOxabO66vhQq748UyRbVzyjBVwUhB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001410; c=relaxed/simple;
	bh=ZomoVMlhkyvEyE01FSrF2sqSUEnt8WowYC/LgMLqUAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPx4UjJ99Q5dYRl1hKxKxWkrakhaZGQKBWEQT2kZ5Ej5QvhI63nzvoNOSxh+DA83ofA3tPQSOen8D/LV2wIacYAYhIZRWnuRh1wNK1YS0keGTl0YKARFZrxvKaTGGBsqu+bdsnhG6giDnPBk/uDVwTbBWZFZKI6Smt0GKtSQsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TkM4x5fVjz1h0jg;
	Tue, 27 Feb 2024 10:34:25 +0800 (CST)
Received: from kwepemd100003.china.huawei.com (unknown [7.221.188.180])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AB5F1A016B;
	Tue, 27 Feb 2024 10:36:39 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 10:36:39 +0800
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 10:36:38 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
	<mcgrof@kernel.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Changbin
 Du" <changbin.du@huawei.com>, Xiaoyi Su <suxiaoyi@huawei.com>, Eric Chanudet
	<echanude@redhat.com>, Luis Chamberlain <mcgrof@infradead.org>
Subject: [PATCH v4] modules: wait do_free_init correctly
Date: Tue, 27 Feb 2024 10:35:46 +0800
Message-ID: <20240227023546.2490667-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The synchronization here is to ensure the ordering of freeing of a module
init so that it happens before W+X checking. It is worth noting it is not
that the freeing was not happening, it is just that our sanity checkers
raced against the permission checkers which assume init memory is already
gone.

Commit 1a7b7d922081 ("modules: Use vmalloc special flag") moved
calling do_free_init() into a global workqueue instead of relying on it
being called through call_rcu(..., do_free_init), which used to allowed us
call do_free_init() asynchronously after the end of a subsequent grace
period. The move to a global workqueue broke the gaurantees for code which
needed to be sure the do_free_init() would complete with rcu_barrier().
To fix this callers which used to rely on rcu_barrier() must now instead
use flush_work(&init_free_wq).

Without this fix, we still could encounter false positive reports in W+X
checking since the rcu_barrier() here can not ensure the ordering now.

Even worse, the rcu_barrier() can introduce significant delay. Eric Chanudet
reported that the rcu_barrier introduces ~0.1s delay on a PREEMPT_RT kernel.

  [    0.291444] Freeing unused kernel memory: 5568K
  [    0.402442] Run /sbin/init as init process

With this fix, the above delay can be eliminated.

Fixes: 1a7b7d922081 ("modules: Use vmalloc special flag")
Signed-off-by: Changbin Du <changbin.du@huawei.com>
Cc: Xiaoyi Su <suxiaoyi@huawei.com>
Cc: Eric Chanudet <echanude@redhat.com>
Cc: Luis Chamberlain <mcgrof@infradead.org>
Tested-by: Eric Chanudet <echanude@redhat.com>

---
v4:
  - polish commit msg. (Luis Chamberlain)
v3:
  - amend comment in do_init_module() and update commit msg.
v2:
  - fix compilation issue for no CONFIG_MODULES found by 0-DAY.
---
 include/linux/moduleloader.h | 8 ++++++++
 init/main.c                  | 5 +++--
 kernel/module/main.c         | 9 +++++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 001b2ce83832..89b1e0ed9811 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -115,6 +115,14 @@ int module_finalize(const Elf_Ehdr *hdr,
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
index e24b0780fdff..f0b7e21ac67f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/moduleloader.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1402,11 +1403,11 @@ static void mark_readonly(void)
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
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 36681911c05a..b0b99348e1a8 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2489,6 +2489,11 @@ static void do_free_init(struct work_struct *w)
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
@@ -2593,8 +2598,8 @@ static noinline int do_init_module(struct module *mod)
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
2.25.1


