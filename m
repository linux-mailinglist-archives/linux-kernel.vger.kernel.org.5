Return-Path: <linux-kernel+bounces-134159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF789AE60
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01DB1C21C40
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3311879;
	Sun,  7 Apr 2024 03:58:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EE184D;
	Sun,  7 Apr 2024 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712462321; cv=none; b=g/t5JEof8FLKtf37iQJYsWwOF6aYkxEjl6gRg+uSqFhBLkomui3lLjzQBwkPwRzVEwExeJrQV/hytcVUevPNQybNGAlOh8u1VBpT3h1ahZoaar6x6yYIgAFEeMqPU3EY0hXnH6k2DWUSM+EDMQUB1fsu4mdZG0vZlp/pTrUhnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712462321; c=relaxed/simple;
	bh=8WX6VDhmnug8ZWvQbGWuEMUJC49IPOTEDT8XfqFKf60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RMzIZwTUno8S3i9AiUPyhmrjTujQHjydfGXNiApgBZwfivPMgfRxPMgHEc7F3iIXJ6Lvlzp68rZVvn1XB7yjOIhhvoyk9jM4lpUKgCuD9wjbEfu76uu9JvLkb0q1VADa14L6fNQGpnCi2xTHlaNReVHPv2Hx2Nn61d9ykeppbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VByzz02FmzXkv8;
	Sun,  7 Apr 2024 11:55:27 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A3E214068B;
	Sun,  7 Apr 2024 11:58:30 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 11:58:30 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<zhengyejian1@huawei.com>
Subject: [PATCH] kprobes: Fix possible warn in __arm_kprobe_ftrace()
Date: Sun, 7 Apr 2024 11:59:04 +0800
Message-ID: <20240407035904.2556645-1-zhengyejian1@huawei.com>
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
 dggpeml500012.china.huawei.com (7.185.36.15)

There is once warn in __arm_kprobe_ftrace() on:

 ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
 if (WARN_ONCE(..., "Failed to arm kprobe-ftrace at %pS (error %d)\n", ...)
   return ret;

This warning is due to 'p->addr' is not a valid ftrace_location and
that invalid 'p->addr' was bypassed in check_kprobe_address_safe():
   check_kprobe_address_safe() {
     ...
     // 1. p->addr is in some module, this check passed
     is_module_text_address((unsigned long) p->addr)
     ...
     // 2. If the moudle is removed, the *probed_mod is NULL, but then
     //    the return value would still be 0 !!!
     *probed_mod = __module_text_address((unsigned long) p->addr);
     ...
   }

So adjust the module text check to fix it.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/kprobes.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..e0612cc3e2a3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1567,10 +1567,16 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	jump_label_lock();
 	preempt_disable();
 
+	*probed_mod = NULL;
+	if (!core_kernel_text((unsigned long) p->addr)) {
+		*probed_mod = __module_text_address((unsigned long) p->addr);
+		if (!(*probed_mod)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
 	/* Ensure it is not in reserved area nor out of text */
-	if (!(core_kernel_text((unsigned long) p->addr) ||
-	    is_module_text_address((unsigned long) p->addr)) ||
-	    in_gate_area_no_mm((unsigned long) p->addr) ||
+	if (in_gate_area_no_mm((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
@@ -1581,7 +1587,6 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	}
 
 	/* Check if 'p' is probing a module. */
-	*probed_mod = __module_text_address((unsigned long) p->addr);
 	if (*probed_mod) {
 		/*
 		 * We must hold a refcount of the probed module while updating
-- 
2.25.1


