Return-Path: <linux-kernel+bounces-42075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F283FBFB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F661C21440
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB76DF44;
	Mon, 29 Jan 2024 02:03:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4330DF4E;
	Mon, 29 Jan 2024 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706493804; cv=none; b=YZduD7Eg9/binPGq2KBjNMn5ogZ2gARoaYqvvLKksiWpmqIb+DdCekUPub1c/jiS5jhcp99e6v/u7TL5EXuqFi2t0MebH+VKPmLpsr0DalPPQV9D9Ig8vwsGQIei4EPCFbITZ5gBHKiF9BoG5DXnJIFMl1tcRJd2/GQ/qDlJ88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706493804; c=relaxed/simple;
	bh=IEpmCe8PdULcIZ1iTvoEQFIwogYTVs/aT/6x5pefwHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6qc4G2bP7lA+HSSKefgR0ObO9OFSjgujXJ4Tl6CxXcT1wkLEubId+pfmClTWtS3wHqhNJ0Bt3NdWQeM8h9jUqQasLIlj2P2If2bAH8HuzK1GJrLorJJHubKkRfp+Ae+nANfntmg6v8RfCzb5sQoefMsIpCcFY/4ec9uV1jzB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TNWlC6xhSzNllm;
	Mon, 29 Jan 2024 10:02:15 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id CA3491400CD;
	Mon, 29 Jan 2024 10:03:13 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 29 Jan 2024 10:03:12 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
	<mcgrof@kernel.org>
CC: <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Changbin
 Du <changbin.du@huawei.com>, Xiaoyi Su <suxiaoyi@huawei.com>
Subject: [RESEND PATCH v2] modules: wait do_free_init correctly
Date: Mon, 29 Jan 2024 10:03:04 +0800
Message-ID: <20240129020304.1981372-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100002.china.huawei.com (7.221.188.184)

The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
do_free_init() into a global workqueue instead of call_rcu(). So now
rcu_barrier() can not ensure that do_free_init has completed. We should
wait it via flush_work().

Without this fix, we still could encounter false positive reports in
W+X checking, and rcu synchronization is unnecessary.

Fixes: 1a7b7d922081 ("modules: Use vmalloc special flag")
Signed-off-by: Changbin Du <changbin.du@huawei.com>
Cc: Xiaoyi Su <suxiaoyi@huawei.com>

---
v2: fix compilation issue for no CONFIG_MODULES found by 0-DAY.
---
 include/linux/moduleloader.h | 8 ++++++++
 init/main.c                  | 5 +++--
 kernel/module/main.c         | 5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

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
index 36681911c05a..ea66b5c2a2a1 100644
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
-- 
2.25.1


