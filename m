Return-Path: <linux-kernel+bounces-154687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497218ADFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29431F22068
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1519556451;
	Tue, 23 Apr 2024 08:31:46 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8B55C29;
	Tue, 23 Apr 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861105; cv=none; b=FNohrKDjxqxYf6GiZEe90RjCYEcqQ/G1nsHuvd41R4W08jYTNu0tVKtEjF4Lvz8iS/wvgu20lS97ZZ4IhXnF8pGw/Mx569NNMbTSmpRgnOBhktRI2T9lcl6KfYTMNV/iMk1SrjjbzM+anErEJv6KKsshwJ6EprU6L5Jed7dq26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861105; c=relaxed/simple;
	bh=N6XTfdxhJpxdxT4fVSZa/iMWuusbHZ+zYGBsuw2wehU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2kdD1oZZjpuG9hn/bG9Z1DEnd/Z2of/4KrDTYdSoIU8n7pDadhE+kQALDEpU6kSxJ9gkhY/z1/oLyEvFy5ukCeDLaL19F2FOVpaFNCAGYqQwozSOJYhyyVOP8AeKA02IbFrJhsvTg9bGdmicJqw51IlYQuQZdIUjn1IaTEk0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1713861072tkyi525
X-QQ-Originating-IP: fGT2JpDpkETB9GS/V58vu3/bYUIW5c4lzZ4qzFlnZTY=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Apr 2024 16:31:11 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: +ynUkgUhZJmV6ir1LCfaBLTxrWfpQKuO3gs5cDJVDOKYEFq3lIG2Jn74P36cc
	RhOHMWGc+DzOw6s8ljXZHqWPeVLy2MOYRnKI7pdP5/v2VIJbeOhYgjt7S8ZvBI4zHRWX+Of
	GMMHS74/FZZcTUGxaUXez/GyOw4uRlIfO2PW7w8KgDol1rhkGS7BGp9rUhsFVq2Nb2Dawr9
	wIjSDrgATISh0AX6I8y44XMamA1TEptpYc3O1Ik5ryhMkWnLTtkr99tPxThx0xt7265oa4J
	zFqoHfyc9cjNN6vWWvj/qHWhITAdQgOl4u7SbDB3rBeXL47r86eDAggKnr8Or7nGiRsI2Zr
	u0924ugv14lrZPD2pazOh7XYs2KQRUPwPgkcHw0BJMNihI1qTAB69R1dsLhZTj/uNFnkons
	62GkfIH/xsvrN+b7wVJav0rMn3YzY9GV
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4099338334242054873
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 2/6] sparc/irq: Remove on-stack cpumask var
Date: Tue, 23 Apr 2024 16:30:39 +0800
Message-Id: <20240423083043.3735921-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240423083043.3735921-1-dawei.li@shingroup.cn>
References: <20240423083043.3735921-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

- Both 2 arguments of cpumask_equal() is constant and free of change, no
  need to allocate extra cpumask variables.

- Merge cpumask_and(), cpumask_first() and cpumask_empty() into
  cpumask_first_and().

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/irq_64.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 5280e325d4d6..01ee800efde3 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -349,17 +349,13 @@ static unsigned int sun4u_compute_tid(unsigned long imap, unsigned long cpuid)
 #ifdef CONFIG_SMP
 static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
 {
-	cpumask_t mask;
 	int cpuid;
 
-	cpumask_copy(&mask, affinity);
-	if (cpumask_equal(&mask, cpu_online_mask)) {
+	if (cpumask_equal(affinity, cpu_online_mask)) {
 		cpuid = map_to_cpu(irq);
 	} else {
-		cpumask_t tmp;
-
-		cpumask_and(&tmp, cpu_online_mask, &mask);
-		cpuid = cpumask_empty(&tmp) ? map_to_cpu(irq) : cpumask_first(&tmp);
+		cpuid = cpumask_first_and(affinity, cpu_online_mask);
+		cpuid = cpuid < nr_cpu_ids ? cpuid : map_to_cpu(irq);
 	}
 
 	return cpuid;
-- 
2.27.0


