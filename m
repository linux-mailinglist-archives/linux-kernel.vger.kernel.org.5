Return-Path: <linux-kernel+bounces-5336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBFC818984
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D483287912
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55911BDD4;
	Tue, 19 Dec 2023 14:13:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7B1C694;
	Tue, 19 Dec 2023 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Svdtt6gDSzsS7v;
	Tue, 19 Dec 2023 22:12:38 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id D28BF140390;
	Tue, 19 Dec 2023 22:12:54 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 19 Dec 2023 22:12:53 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Hui Wang
	<hw.huiwang@huawei.com>, Changbin Du <changbin.du@huawei.com>, Xiaoyi Su
	<suxiaoyi@huawei.com>
Subject: [PATCH] modules: wait do_free_init correctly
Date: Tue, 19 Dec 2023 22:12:31 +0800
Message-ID: <20231219141231.2218215-1-changbin.du@huawei.com>
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

The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
do_free_init() into a global workqueue instead of call_rcu(). So now
we should wait it via flush_work().

Fixes: 1a7b7d922081 ("modules: Use vmalloc special flag")
Signed-off-by: Changbin Du <changbin.du@huawei.com>
Cc: Xiaoyi Su <suxiaoyi@huawei.com>
---
 include/linux/moduleloader.h | 2 ++
 init/main.c                  | 5 +++--
 kernel/module/main.c         | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 001b2ce83832..f3d445d8ccd0 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -115,6 +115,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
+void flush_module_init_free_work(void);
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
index 98fedfdb8db5..1943ccb7414f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2486,6 +2486,11 @@ static void do_free_init(struct work_struct *w)
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
-- 
2.25.1


