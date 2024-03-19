Return-Path: <linux-kernel+bounces-107513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9687FD81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE51F232F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609077F7C9;
	Tue, 19 Mar 2024 12:25:09 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49267F469
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851109; cv=none; b=LN0/Ur9Cs77aK3qVv19fEdHpKACNQrNBuo6b5oT0XPvH3MJc3oiUKJT/L8JciOzBr1+zlda+/r1/Eh7muHI+0mOAd8IhVDlOl1l/ZkUJY2TOF+CMM0hXDdVYXF31S/cRQQmw6l/+jJpnApOWJwQge3EP2ZtbHDpReEkvwuPhzKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851109; c=relaxed/simple;
	bh=3S43l8WshOp7oVe4mpvt5rgTRlCKYT8YZ1H3qFEPD9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TD9C11J8Vh02MB4P52eC+O2MhkDUU04D131pe1Ec3eeZ2qHCIPfVwodO3uo+5a6hrDqj0k9dEFeeMln0r6BvpWhMdjBMNDn6mowhje927A28bdTQKJtPoq3TJ752LJn1rpx6eg/KIZTetXFo/eGca8bxX95bEebfHv9TcJknCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp66t1710851059t9pl0b85
X-QQ-Originating-IP: v0yka5Q7VRprV9eyT8qh58URnS8uEiGwA1V2SQp0ibk=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Mar 2024 20:24:18 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: IdXhA8w8wMsiJKrl0Z6Ya1mlfI3heSr++/mH1doQ5BFbMqT15yrnjFX8ZvH8J
	MNIBdn6YnCxrQDLKwwzgcH6vy68ieOd5fpdCdSC2lgRDINADfvtcEQwDW9qe5mHzi/FmjKL
	TMXAUfRUVrHtkw6gp/vfJY+I7h+n2XQZzXXsLfe0saKxpgyujgbSxViYNQkCXKNWnrcEhtC
	hg9I4DwHm8hVL8gWwyUCz52d4FXWkZtSVCYY9iLkIWPOOMaaDtCDt3kYUJtnRoQiY3hHgFb
	q0BXfWo/uNfHl5ipbYHaWPnpCehVSLRg0TMr+ORupXOHaJ3rDevP5K8JXfNg3wF7vMdjDIz
	0BMC1eWb1ot0oT0gaLlQx2EswNttiFT8pxZcPEKbGiWnCS1Ay4x7D6fS3QStg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13395167088012256602
From: Dawei Li <dawei.li@shingroup.cn>
To: yury.norov@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH] cpumask: Create dedicated kmem cache for cpumask var
Date: Tue, 19 Mar 2024 20:24:00 +0800
Message-Id: <20240319122400.399516-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

alloc_cpumask_var_node() and friends allocate cpumask var dynamically
for CONFIG_CPUMASK_OFFSTACK=y kernel. The allocated size of cpumask var
is cpumask_size(), which is runtime constant after nr_cpu_ids is
freezed.

Create a dedicated kmem cache for dynamic allocation of cpumask var.

The window for creation of cache is somewhat narrow:
- After last update of nr_cpu_ids(via set_nr_cpu_ids())
- After kmem cache is available.
- Before any alloc_cpumask_var_node() invocations(sched_init() e.g).

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 include/linux/cpumask.h |  7 +++++++
 init/main.c             |  1 +
 lib/cpumask.c           | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..2963155f1776 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -902,6 +902,8 @@ typedef struct cpumask *cpumask_var_t;
 #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
 #define __cpumask_var_read_mostly	__read_mostly
 
+int __init cpumask_cache_init(void);
+
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
 static inline
@@ -949,6 +951,11 @@ typedef struct cpumask cpumask_var_t[1];
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
 
+static inline int cpumask_cache_init(void)
+{
+	return 0;
+}
+
 static inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
 	return true;
diff --git a/init/main.c b/init/main.c
index 2ca52474d0c3..c7a20779aba1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -931,6 +931,7 @@ void start_kernel(void)
 	sort_main_extable();
 	trap_init();
 	mm_core_init();
+	cpumask_cache_init();
 	poking_init();
 	ftrace_init();
 
diff --git a/lib/cpumask.c b/lib/cpumask.c
index e77ee9d46f71..f3f68c45caba 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -57,9 +57,20 @@ EXPORT_SYMBOL(cpumask_next_wrap);
  * CONFIG_CPUMASK_OFFSTACK=n, so does code elimination in that case
  * too.
  */
+
+static struct kmem_cache *cpumask_cache __ro_after_init;
+
+int __init cpumask_cache_init(void)
+{
+	cpumask_cache = kmem_cache_create("cpumask", cpumask_size(), sizeof(long),
+					  SLAB_HWCACHE_ALIGN, NULL);
+
+	return cpumask_cache ? 0 : -ENOMEM;
+}
+
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node)
 {
-	*mask = kmalloc_node(cpumask_size(), flags, node);
+	*mask = kmem_cache_alloc_node(cpumask_cache, flags, node);
 
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
 	if (!*mask) {
@@ -97,7 +108,7 @@ void __init alloc_bootmem_cpumask_var(cpumask_var_t *mask)
  */
 void free_cpumask_var(cpumask_var_t mask)
 {
-	kfree(mask);
+	kmem_cache_free(cpumask_cache, mask);
 }
 EXPORT_SYMBOL(free_cpumask_var);
 
-- 
2.27.0


