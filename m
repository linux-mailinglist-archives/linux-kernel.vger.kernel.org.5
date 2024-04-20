Return-Path: <linux-kernel+bounces-152148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E3F8AB9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D431F214F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267817C72;
	Sat, 20 Apr 2024 05:17:04 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60EE17BCB;
	Sat, 20 Apr 2024 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590224; cv=none; b=r/0K30fK6G4hNtEzZXwaq4D/WpvNKlaXq8wJCo3IpytRYv228q6yHQ/G/SpAK1NSGrgBzPbU/bsJi0Tm5Xhh/kKIRCsp01GAuSuiVeWKf3LIZbQSK4u3CpAj7iu++2la/7IYyYQKEbHxnV08w0Y/8tGQ3XoF7JtV+Rghv3ivtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590224; c=relaxed/simple;
	bh=jLfNnCBXksQdRcun7e+P6Gzbclr84PhONO9mQqHTh0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVzWwwMgp6BA2tnYYtS+7QWaXRLihhHjL5XyNgpNz92OjH0q/rv/yEoQ48JNFEPC7Dj+DY108qwvnKaV9b3iXeM6BiYqsA31/X738quKAnoKfX8dxD7RT+OR+P8I648cvJ4J0kbUt5goGFMx+hEM3d+gBzhgG3eSHMvar2t18fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1713590193tckay5hz
X-QQ-Originating-IP: YKD5jxrExFmZCeXNPd1zDEkYWQBcJUhZJZw3aGY2xlg=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Apr 2024 13:16:32 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: RLrSOnjbvYFlqV1mdTGOKnCqxqWyu0oq4qmWlQWNmG2Y1zZZLysBSSxH4ilo0
	RnHKsK7/CxOdCv1/mmM6zDJRHwYnOGSXxTwuoo3QRp8FlBkMIb57lzMh2bTxZHaY6lJEMpP
	FchEoK7g2OYvxH1I1SGY/sHS1eQ/1GlGUE1BFbl8aQ6pH/EMVg3J9bT2epRR8XkLIYZsQPw
	9tt8Sp5/q0E0rUWMdxz5mYBTmI4JmZO4/vnspF+oXe6QCK8vNRCVwGocp7TGdIShklug1Ua
	9wrjdEiyLV93fdVnTV83/30GqomX5vOWhuBsNO8cMm3+vINyiseLRC9oILcqNe39q2LEtYV
	wOxsQdJf5CQVD97aN+Jr8j6le/eyIsZKOzftovHieVsOoX9jmMVM31xXJqbppHZhTABxE/q
	XDADwWjn82fSfAgFCrWP/g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6810044621724373392
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 6/7] sparc/leon: Remove on-stack cpumask var
Date: Sat, 20 Apr 2024 13:15:46 +0800
Message-Id: <20240420051547.3681642-7-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240420051547.3681642-1-dawei.li@shingroup.cn>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_subset() and cpumask_first_and() to avoid the need for a
temporary cpumask on the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/sparc/kernel/leon_kernel.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 4c61da491fee..0070655041bb 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -106,13 +106,10 @@ unsigned long leon_get_irqmask(unsigned int irq)
 #ifdef CONFIG_SMP
 static int irq_choose_cpu(const struct cpumask *affinity)
 {
-	cpumask_t mask;
+	unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);
 
-	cpumask_and(&mask, cpu_online_mask, affinity);
-	if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
-		return boot_cpu_id;
-	else
-		return cpumask_first(&mask);
+	return cpumask_subset(cpu_online_mask, affinity) || cpu >= nr_cpu_ids ?
+	       boot_cpu_id : cpu;
 }
 #else
 #define irq_choose_cpu(affinity) boot_cpu_id
-- 
2.27.0


