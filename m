Return-Path: <linux-kernel+bounces-135048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7557C89BA61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CB1289879
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD07538F96;
	Mon,  8 Apr 2024 08:33:39 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AE3A1A1;
	Mon,  8 Apr 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565219; cv=none; b=fe+JnyIVADq3Zwvrn8CiIKUHsEEv+dxhjpIvWi6dfpP74oiDLaO/hBZqk7I7qM4kkRQw8KFn2FmHdwcuXyNs0LVsBo2aIdWwlgzGEc2xq8IFTwxDH8tnFTCOapxdtRKFWMXsN1cHJwtSZ+Rq7G8RHBexOx0vnNtZxfI5HeVYSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565219; c=relaxed/simple;
	bh=L6Sp0fHnMYGR04YqKkhRgLAJKayv1a/l1+xEZOfPX4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfgB4BXKsxFIjRpwC7OUyOLGiBOX7mP80UUYGPqsaH370te90LeFGoBgkaO8agFkbMydQJnrKX0I76fudlaxpnj/AJZHDfUNgcK05lPmVWnhg/PZaySkSGiXfKekFEbsCxO6NrCnki6GAqczZBduxZ12xv6H8dKN1ci/+Z1JBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VCj3j3yVhz1ymHv;
	Mon,  8 Apr 2024 16:31:13 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id EF9DA1401E9;
	Mon,  8 Apr 2024 16:33:26 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 16:33:26 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <mhiramat@kernel.org>, <naveen.n.rao@linux.ibm.com>,
	<anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<zhengyejian1@huawei.com>
Subject: [PATCH v2] kprobes: Avoid possible warn in __arm_kprobe_ftrace()
Date: Mon, 8 Apr 2024 16:34:03 +0800
Message-ID: <20240408083403.3302274-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240407035904.2556645-1-zhengyejian1@huawei.com>
References: <20240407035904.2556645-1-zhengyejian1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)

There is once warn in __arm_kprobe_ftrace() on:

 ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
 if (WARN_ONCE(..., "Failed to arm kprobe-ftrace at %pS (error %d)\n", ...)
   return ret;

This warning is generated because 'p->addr' is detected to be not a valid
ftrace location in ftrace_set_filter_ip(). The ftrace address check is done
by check_ftrace_location() at the beginning of check_kprobe_address_safe().
At that point, ftrace_location(addr) == addr should return true if the
module is loaded. Then the module is searched twice:
  1. in is_module_text_address(), we find that 'p->addr' is in a module;
  2. in __module_text_address(), we find the module;

If the module has just been unloaded before the second search, then
'*probed_mod' is NULL and we would not go to get the module refcount,
then the return value of check_kprobe_address_safe() would be 0, but
actually we need to return -EINVAL.

To fix it, originally we can simply check 'p->addr' is out of text again,
like below. But that would check twice respectively in kernel text and
module text, so finally I reduce them to be once.

  if (!(core_kernel_text((unsigned long) p->addr) ||
      is_module_text_address((unsigned long) p->addr)) || ...) {
	ret = -EINVAL;
	goto out;
  }
  ...
  *probed_mod = __module_text_address((unsigned long) p->addr);
  if (*probed_mod) {
	...
  } else if (!core_kernel_text((unsigned long) p->addr)) { // check again!
	ret = -EINVAL;
	goto out;
  }

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/kprobes.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

v2:
 - Update commit messages and comments as suggested by Masami.
   Link: https://lore.kernel.org/all/20240408115038.b0c85767bf1f249eccc32fff@kernel.org/

v1:
 - Link: https://lore.kernel.org/all/20240407035904.2556645-1-zhengyejian1@huawei.com/

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..65adc815fc6e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1567,10 +1567,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	jump_label_lock();
 	preempt_disable();
 
-	/* Ensure it is not in reserved area nor out of text */
-	if (!(core_kernel_text((unsigned long) p->addr) ||
-	    is_module_text_address((unsigned long) p->addr)) ||
-	    in_gate_area_no_mm((unsigned long) p->addr) ||
+	/* Ensure the address is in a text area, and find a module if exists. */
+	*probed_mod = NULL;
+	if (!core_kernel_text((unsigned long) p->addr)) {
+		*probed_mod = __module_text_address((unsigned long) p->addr);
+		if (!(*probed_mod)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	/* Ensure it is not in reserved area. */
+	if (in_gate_area_no_mm((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
@@ -1580,8 +1587,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
-	/* Check if 'p' is probing a module. */
-	*probed_mod = __module_text_address((unsigned long) p->addr);
+	/* Get module refcount and reject __init functions for loaded modules. */
 	if (*probed_mod) {
 		/*
 		 * We must hold a refcount of the probed module while updating
-- 
2.25.1


