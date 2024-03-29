Return-Path: <linux-kernel+bounces-124424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF7B89175D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF550B21CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A467BB0F;
	Fri, 29 Mar 2024 10:59:43 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4356A8AD;
	Fri, 29 Mar 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709983; cv=none; b=QjapkStGAf2FAtJnjoh7G41TJlUX9x4uIjKhYuLXbVMcGVCqXA2E3ftIH5McHgk5n7wMLUQfGZnKAlG8kh/PsvkY3ED46buUF0euIjs0YKn9zJ2uIeUn+CXVXbKUOfRWnZojDiOYRIwmoPO6rCGAV7PIZjnYehEn1YSQjhwe1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709983; c=relaxed/simple;
	bh=BGdVHyXu2nvr+uV8Gq6vq1qthRDesSy50eK+N7uOi2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGbDGl5Hj0peVRLcdC0ZXvFd9kEW57ttwXvpDB8BkGj5zFdzciD7zL9NIGPN84nEZS7M/bLOLH4Lo/5cBZxICsnB5c5ct50w9GL9LrSSVTCFP0BHyDmIhB9PUyLqnj8HUX+d3urCzM4IKw5tOAfgeb4T6v0Ruzk8y99h/pl4T64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1711709843tv80s7ov
X-QQ-Originating-IP: 71LQnl3NJNsvgOKyfpSvsNrOkPFMxIaohKLax+fnpYk=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Mar 2024 18:57:21 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3i4lw8jCv5pReqk8XBDZo4W2Lqox8v053W7I2EUN6+uz7amykeXY
	UGZSGgJiwCVnbILlJeIBx1IXvUentjK22EK6gxsv37dyLssoRUBFH2RJWuDFQY9XyKeux0x
	UFxv+MynwpUjZ6Aw/i78cnflRKmEh2TnySUC9C0m6y69i5LVTSZ3UF40Rk10mpqdsB2qdwH
	3rVww06rDMc5xTqH+llDnXZ2yYgHlBUY3zw6PCNuVQHHIot+AbntyodfvCHjMOvxrnvkQfE
	bz+WS+INwVRfOTOONWmPMQWkqCbMtaPGXTn4GTd2K4W9y64FtzyAzbB1Ii6rOKbXHDmpIXK
	c2+2sdCJORS2jNEAs1llYOElRKG3J1SfYVgAdadpbkNwJ91qwMBY0gV70ZhPSoQFwWHkOdr
	bD7DvGsT4JI=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8489316982251753822
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ioana.ciornei@nxp.com,
	wintera@linux.ibm.com,
	twinkler@linux.ibm.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var allocation on stack
Date: Fri, 29 Mar 2024 18:56:09 +0800
Message-Id: <20240329105610.922675-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240329105610.922675-1-dawei.li@shingroup.cn>
References: <20240329105610.922675-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index a4ab615ca3e3..b51f46ec32f9 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
 	int cpu;
 
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return;
+
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
-	cpumask_copy(&cpumask, &iucv_irq_cpumask);
-	cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
-	for_each_cpu(cpu, &cpumask)
+	cpumask_copy(cpumask, &iucv_irq_cpumask);
+	cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
+	for_each_cpu(cpu, cpumask)
 		smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
+
+	free_cpumask_var(cpumask);
 }
 
 /*
@@ -628,23 +633,33 @@ static int iucv_cpu_online(unsigned int cpu)
 
 static int iucv_cpu_down_prep(unsigned int cpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
+	int ret = 0;
 
 	if (!iucv_path_table)
 		return 0;
 
-	cpumask_copy(&cpumask, &iucv_buffer_cpumask);
-	cpumask_clear_cpu(cpu, &cpumask);
-	if (cpumask_empty(&cpumask))
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpumask, &iucv_buffer_cpumask);
+	cpumask_clear_cpu(cpu, cpumask);
+	if (cpumask_empty(cpumask)) {
 		/* Can't offline last IUCV enabled cpu. */
-		return -EINVAL;
+		ret = -EINVAL;
+		goto __free_cpumask;
+	}
 
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
-		return 0;
+		goto __free_cpumask;
+
 	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
 				 iucv_allow_cpu, NULL, 1);
-	return 0;
+
+__free_cpumask:
+	free_cpumask_var(cpumask);
+	return ret;
 }
 
 /**
-- 
2.27.0


