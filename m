Return-Path: <linux-kernel+bounces-146525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A18A668A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C0AB24762
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671595A10B;
	Tue, 16 Apr 2024 08:56:43 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269584DE4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257803; cv=none; b=X94NxjYurjNdw/J/TB7UkfVISV7DwfwkdV+h+zpsvAUXFaQbHtSIU7dBevpWfFfj+N7oSB3cpIVMPZy92+iBO5loYrtU7NVAA4yRO4j4A2FjlpDAuZn8gt9Rm1yH1bUx8ZNTj7fKlO2tU7PgkThVS3eLh4HQSR9AeiQdfw2DsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257803; c=relaxed/simple;
	bh=Uu0O2oB1LvZpH4vPXcc0Hr8FvkH73mK2S5P1tbInLN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7gf61//BzBKHXUfsTR13LEkuHWCGqm78E1o1iY5zs/1GNqkiFl9ZZOdl75sIinZ7sEnY2rRk8YsjuskQcKCL+oNWFkvDbGl9ceEjJCfDu3W79RSWNX9CXAkPXyAZVf/XYU4t4o5CobHQeaobmfJ2NuAUpV17sTHiKIp/d/4LKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp83t1713257762thmop50f
X-QQ-Originating-IP: KXlS44mzURqz5FoEu3HmSeXIGk74ORIpgFUrGitRlRA=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:56:01 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: 6/K5pWSRdGq3D/d8k1DPKz6aXXbHvVAFnd7stBnpo7k5RYurwdvwZG6Cbst5q
	gWbz1ZyXneKqbpTJ3rqe36BjmF5HPLkT3RF2EUZbWDbq6Y8Gjfk3mnCu5AOuTJ1pCPHQ+7w
	xBWqwvJEv4JgVHngtYc4wdNR/G4/gxFUw0uwEnZETOP6ZPoWm1Pu8FHV4sziB0jya0scY6C
	9YMGxDZo6wFRPaO2JkDkC54Ou0cB9ViqCah8A/4B79gxkN/vysiFyxbRFvoqfYPff/DzOgA
	r9O0jkVON5GnlkNnidC+dGfsRnZoTNX4OouPMKGZ58u1ZfeLLOvKFAlWQQwGu2M0EXk9xTL
	8A38wHxEEXqp6KFawYn6xR8/vGDw5/1MeyRovIVXX29/6FGGIaatTpSSpEuBl+lFf23bYDg
	gMZl5r9f/q2upv2BI7i4hg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1721600554740465518
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com,
	rafael@kernel.org
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 7/7] cpuidle: Avoid explicit cpumask allocation on stack
Date: Tue, 16 Apr 2024 16:54:54 +0800
Message-Id: <20240416085454.3547175-8-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240416085454.3547175-1-dawei.li@shingroup.cn>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
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

Use cpumask_first_and_and() and cpumask_weight_and() to avoid the need
for a temporary cpumask on the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/cpuidle/coupled.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 9acde71558d5..bb8761c8a42e 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -439,13 +439,8 @@ static int cpuidle_coupled_clear_pokes(int cpu)
 
 static bool cpuidle_coupled_any_pokes_pending(struct cpuidle_coupled *coupled)
 {
-	cpumask_t cpus;
-	int ret;
-
-	cpumask_and(&cpus, cpu_online_mask, &coupled->coupled_cpus);
-	ret = cpumask_and(&cpus, &cpuidle_coupled_poke_pending, &cpus);
-
-	return ret;
+	return cpumask_first_and_and(cpu_online_mask, &coupled->coupled_cpus,
+				     &cpuidle_coupled_poke_pending) < nr_cpu_ids;
 }
 
 /**
@@ -626,9 +621,7 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 
 static void cpuidle_coupled_update_online_cpus(struct cpuidle_coupled *coupled)
 {
-	cpumask_t cpus;
-	cpumask_and(&cpus, cpu_online_mask, &coupled->coupled_cpus);
-	coupled->online_count = cpumask_weight(&cpus);
+	coupled->online_count = cpumask_weight_and(cpu_online_mask, &coupled->coupled_cpus);
 }
 
 /**
-- 
2.27.0


