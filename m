Return-Path: <linux-kernel+bounces-69743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C257E858DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A92F2822E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FAC1CD3E;
	Sat, 17 Feb 2024 08:19:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12401CD17;
	Sat, 17 Feb 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708157963; cv=none; b=IKT7/arNuQHVIdqK5hQcZc2Zb+62+U93+4X4j26mm+NVSaU2Vlj8GPZiC+GHqrXEhrG94H/eb4eiCl1h3eqgp5vyFlOh3I0ZAvx1fzYMdFTKTt8/nDDFOp74OpAEnfyj0OSE+eYAJoS/kDnlEoCWELS+938FCo/ihv1nPj0iYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708157963; c=relaxed/simple;
	bh=OEujMmKsaz34R6ihVj0EBGAxb1fHPMfIT7TYuck2xHM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eEjNaFvNCmEAJtgg+gZ/KREedSVvVJkfgTe3QpgQWwJx0EpYtoUOkVe9ykDByeebhiFnQKFjRcHBOXegoJI6lijU/lp9EWKiZ9P7/bJFAmgV/6Qisck5cPmMyu93GMU0dUwuIvNXDAlI9KS2drM/ojGIOQm4//eIMLgsU+Y+lrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TcM952KLBz2Bcnr;
	Sat, 17 Feb 2024 16:17:13 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD17140485;
	Sat, 17 Feb 2024 16:19:18 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Sat, 17 Feb 2024 16:19:17 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
	<mcgrof@kernel.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>, Xiaoyi Su <suxiaoyi@huawei.com>, Eric Chanudet
	<echanude@redhat.com>
Subject: [PATCH v3] modules: wait do_free_init correctly
Date: Sat, 17 Feb 2024 16:18:10 +0800
Message-ID: <20240217081810.4155871-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100002.china.huawei.com (7.221.188.184)

The synchronization here is just to ensure the module init's been freed
before doing W+X checking. But the commit 1a7b7d922081 ("modules: Use
vmalloc special flag") moves do_free_init() into a global workqueue
instead of call_rcu(). So now rcu_barrier() can not ensure that do_free_init
has completed. We should wait it via flush_work().

Without this fix, we still could encounter false positive reports in
W+X checking, and the rcu synchronization is unnecessary which can
introduce significant delay.

Eric Chanudet reports that the rcu_barrier introduces ~0.1s delay on a
PREEMPT_RT kernel.
  [    0.291444] Freeing unused kernel memory: 5568K
  [    0.402442] Run /sbin/init as init process

With this fix, the above delay can be eliminated.

Fixes: 1a7b7d922081 ("modules: Use vmalloc special flag")
Signed-off-by: Changbin Du <changbin.du@huawei.com>
Cc: Xiaoyi Su <suxiaoyi@huawei.com>
Cc: Eric Chanudet <echanude@redhat.com>

---
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


