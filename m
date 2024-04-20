Return-Path: <linux-kernel+bounces-152142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BAF8AB9CA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B6281700
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE4FC0A;
	Sat, 20 Apr 2024 05:16:46 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31FD502;
	Sat, 20 Apr 2024 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590206; cv=none; b=sLFcIAiQLpNZb9mIRr88WynPPFA4ADGvqWSdCvusGdDQ+6tCRds12YWqAaL1N0QUg3fyxf230+/QvK2S99zV5abjM/Dp40z250Lf4oiKxidZysVgrf319WUvYK8xLa4hM/IMf02MEZA/Fnmz87JqqYEGYAjeGm/a7XQOh+H+EPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590206; c=relaxed/simple;
	bh=JGe2c7EleFIo3V/q444ZXbmbASsFH7KJPdST/F19raQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrXlH4i+VZLuGPq03yZz+IjkvrpMYp8N8TeMUYrNi2oSp4VRx6T3eahmhyIchwo9eNXlUeBoPJThKEnMzi15glOaiWSUTaMciwwmF8BilYybpJug8ZMSUmtTbQFNB4qqF2DDrSNj51oCY8AIIyOAfZTMRPR9goqzXjvY7YKYHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1713590168tnzg3hq9
X-QQ-Originating-IP: 7t3tP/fE+7jFt0UehO+VmUbKEQtfVTHezW4H9IIyYjw=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Apr 2024 13:16:07 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: znfcQSa1hKadBZA75WUfKi7xxQVaADA9PWEDD6aBu+qV6q5ooibxQmrW7ULBB
	It5C/q7o1oJnz7vHm/03SCI1OdRg47vJPxBVOBC/UrpjQaJJAta2tJ48uJWuCp5P3BXg+Y4
	K0UjAhLWTu1NqhaZd2HViWi4xJwNPDqGV+KHWjoFh1nLN7a9dwMASC0NC0MtIZbazUpYygX
	dz5/SbvC0+if+VVJZEmaJTgb+O5P6behwbAIb/YUWsV1WHxLYKU3+2uZhk6JQX+TA/3I+q1
	hr+Eq6n6np2x6hMIeIu5jYZODIGBeg65lYbmtEoVdlAGNb+nH1htNX9awxz43xqwgVdtrgN
	FrgFbNwrfFXAzyph3erKBif6DzSGJ5QkjVkBs7sWXqT8kKJVLjlS5EbeH9glUT0Gy6M+1C/
	8M5kR8JYJ7Skdzg4OPzkng==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 18303500478085537175
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 2/7] sparc/irq: Remove on-stack cpumask var
Date: Sat, 20 Apr 2024 13:15:42 +0800
Message-Id: <20240420051547.3681642-3-dawei.li@shingroup.cn>
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

- Both 2 arguments of cpumask_equal() is constant and free of change, no
  need to allocate extra cpumask variables.

- Merge cpumask_and(), cpumask_first() and cpumask_empty() into
  cpumask_first_and().

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


