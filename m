Return-Path: <linux-kernel+bounces-144864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0A8A4BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB611C21D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399E59B75;
	Mon, 15 Apr 2024 09:49:00 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888059178;
	Mon, 15 Apr 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174539; cv=none; b=h1SDrksle7+Q+KCxG++z5V6ZLi54xjsbwkPpzAZvcNwcYPA5DW0yuBkD3iBQIhtI1li8Wgzez+S51fccJIoipZYDCgZ8afN+l+dkJIO8y/QPAtFPtN7Kt/gH7tSiU3Qsrai3hq+sJ/T6jD0SzON+2kNjhilh244I3AY/k+LW/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174539; c=relaxed/simple;
	bh=B1hg7pDwSLKfgIcaXOtyaNyjw7ZjJf4j7FTIwgWeOBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VmiaPAmpanpgNa8KbKv79lPUlYbHzspzKrxxtGQfVCyZGjxJlUzAy79A25A7B1Lt14HE23wiEyell+7XNNlNXLQwF7mIPm1u+Zc3WcErJr4Ow3Mly2aE7qDL95woC3FhN5GyHmebNxgyR3p5YAEruwP2gDEDQZOGG5DSjmjyeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp91t1713174505tqb1fvlq
X-QQ-Originating-IP: Mg2qhqrNmZ4DabM2cVzkXEFBLfsGGq0/bsCi8GmCGA8=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Apr 2024 17:48:23 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 5EQLibG9+Dhd65WhHLcwzoaQdGDyW3R0enkqqtQ1Ltc3ObGMGL+5hVXPVJCU/
	YqkAQCvRovbfEeki8TEO1E84nUhnEEPW724dbC47yzz+rP9NhpeZVlcpFVx10rzybAT2No/
	LIJY7OZxPUnEsS7ufuy1Kk2CA6RxuKQDFK+4lq45tvBvd00qAamsXDx6LPzLz5awqyPPcpK
	YQbycxYKmcMzCMAJEYeQ1IEO7hjhqjdCBIR+vOb+mMV/Z8D3lklHLISOqGv3O1wgt74lkKr
	A11CELi1hyoVzot4n5jQSeq5+vStcEmqHIY+23YcJpidqCn4jkLrz9X5NmbY0WSUN3dwrdv
	MvSvVywWBAbNEjvsgeUOUiKkDWY5Fa5WbHydfPBZGRCnaA0PFLJEU3lkRVYc3e8O+oQhhNY
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5948653929054549873
From: Dawei Li <dawei.li@shingroup.cn>
To: daniel.lezcano@kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH] powercap: Avoid explicit cpumask allocation on stack
Date: Mon, 15 Apr 2024 17:48:21 +0800
Message-Id: <20240415094821.3060892-1-dawei.li@shingroup.cn>
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

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_weight_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/powercap/dtpm_cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index bc90126f1b5f..6b6f51b21550 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -43,13 +43,11 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd = em_cpu_get(dtpm_cpu->cpu);
 	struct em_perf_state *table;
-	struct cpumask cpus;
 	unsigned long freq;
 	u64 power;
 	int i, nr_cpus;
 
-	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
-	nr_cpus = cpumask_weight(&cpus);
+	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(pd->cpus));
 
 	rcu_read_lock();
 	table = em_perf_state_from_pd(pd);
@@ -123,11 +121,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *em = em_cpu_get(dtpm_cpu->cpu);
 	struct em_perf_state *table;
-	struct cpumask cpus;
 	int nr_cpus;
 
-	cpumask_and(&cpus, cpu_online_mask, to_cpumask(em->cpus));
-	nr_cpus = cpumask_weight(&cpus);
+	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(em->cpus));
 
 	rcu_read_lock();
 	table = em_perf_state_from_pd(em);
-- 
2.27.0


