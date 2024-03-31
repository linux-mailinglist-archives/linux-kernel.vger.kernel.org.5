Return-Path: <linux-kernel+bounces-125959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C602892EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EBEB2164B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C536FD5;
	Sun, 31 Mar 2024 05:36:53 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9D6FA7;
	Sun, 31 Mar 2024 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863413; cv=none; b=RpVDbX2JD0/RlW8D3gN7OWsadmc/olonOAvagvgCKlgPh8iwqleFOAs1g1tsHRmtm5UUYluM5mA1wYn26M5NeINJKyIg90zg4vqzAdudbbmXgcs05AQmoZX3s7pqWOyEbC4QtOoms2WPtUhwcYKE/2gGCjzh8Ce4wGf3gL3KJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863413; c=relaxed/simple;
	bh=cRT3X+uLWIo/WDT/dysE7g0AVNehkJ5rdYqVsI+vjX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJGQalf5ygsLz6W7crwPcqJPg9D2iGQDLglH0ceLy/J91sAwjpOeLVrpyKsKv+GF3c/o5LJ9MTIYYGxWiDZdwZrtpK4DnTjYj/bwd04ljxHUXXks+AJ62V2K+q6ynlRDjwUtctZuSI/7xszZJI9mjsIOksy7n6En4OXN4lYeN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1711863353tvqruomb
X-QQ-Originating-IP: dHu89vOsfyXlaQKZF86cBB1XYRxM3aKc0t7f88USl8g=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 31 Mar 2024 13:35:52 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: rZJGTgY0+YOuhoc1+jgTQzFXybo6WpkwHmAznXexq7mNnvmJOrZ22rJCyRlxA
	yv+DUYrg83tauZiFD4e5OeolzNLxCkYZAI3ridWwMnx2JQecfKQBp6G915QB7WwOeONSCAQ
	yiiu0Z+ri/Nw7546cTU5FunYzRvLQVeaNQXN84uh1FHxLo6fpmfcrxm7/+sMZdYHa3cAaRl
	lTYuZWrjb5rQtysFSnufhD17smjbr9Zod6O8MaB8Un+YnXkUvQCTJjP7wxCo8r0n+rP7Omt
	ETATyyanGMCSnkBeXJDPkdGNQF1RQgjq6q60WhxSBKe90UnQzoh9rQ6lzMDcGqqJm5fJaTq
	T82qGnoMMUZejzj1HUiSxMd5lxp71G2bssZRY5kxGdGRmMmri9sTkshPuxG6SH3lpBNpj3e
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4506703939604469898
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
Subject: [PATCH net-next v2 1/2] net/iucv: Avoid explicit cpumask var allocation on stack
Date: Sun, 31 Mar 2024 13:34:40 +0800
Message-Id: <20240331053441.1276826-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240331053441.1276826-1-dawei.li@shingroup.cn>
References: <20240331053441.1276826-1-dawei.li@shingroup.cn>
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
 net/iucv/iucv.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index a4ab615ca3e3..5e37a8ceebcb 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -520,7 +520,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
 
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -628,23 +628,33 @@ static int iucv_cpu_online(unsigned int cpu)
 
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


