Return-Path: <linux-kernel+bounces-130152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805C8974B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD1028BD13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B93314AD1D;
	Wed,  3 Apr 2024 16:00:59 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE014A60B;
	Wed,  3 Apr 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160058; cv=none; b=JFBWM7c3nmklLOHq0h6rrTBS7Nb2I8VYQMDq8P4qzWMYCheX23R4r/KsWN6MayoiwFf79AaU1dDmdJ/8Zyhs2lbvVXNqpZTi4rPfHVo6VTnn0MLfXviKKPZICSCPlloFbHQ6+XzHhlaS/PGJBwdqYV6c7jIba+w/t1ndnxHyD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160058; c=relaxed/simple;
	bh=Re5TwhQ0QoFy44j2poIlImy55nEU9kHehFfmXVKdsDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jf6QP8V39iUIKmmVfYR/PaVEEBx0esEOh3fVmQaSZ21D54isIpXz8Z4Fr5F/Cxa5vLa8Q4yrsWzJLrjwzZvis6mux8YxDw2GxnyGF2Iq61NWy9L3UAgXLe3KuqGrvPaT4zWoESpoY6zUFVNMmneQNhdNqfepjxMgU//F+6ZYXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp77t1712160023t7n4x2zy
X-QQ-Originating-IP: NTtCm7ktjbZulINOAFz6JghguX6D2QjGo7ZDoGhqPtU=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Apr 2024 00:00:21 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: PsQCk6chbj6H0R2JyVeosBvbfWGGmUV0DIlqOAOud3eD3r83QAu+mqAt4k3eq
	87D4aIBW4SGST5Lh5/PMmW6bOU9m5TALOHl/WFrBYFJWqAaA/CHtPsy3+Oa0+tYH5M91e6C
	wWCOwvDrp2Qa2d/jagAdrICWq4eLuTmdviD+63HmJWRFShpXGwpaLJe9xeeEzuBwsZxRuYC
	n8RRjsPBBwJqNVYA2Hzx1e2coww2GOtuSZZMfRpiKDp9RMmCN7JemJHx+ulZ4hqgVU0lkgN
	XKlnP2AJCLC6rhJmve3ZSj+DSl7KXTb1nWNULeHhbarqUiFN6UOteUH6Fqu7Lc5WywP+mAF
	N+8VzmmO6Ij2A1uh8sdyA136HVDJSYcOSrTVjmD90trpfH2Nb8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16982553282535320549
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v3 01/10] cpumask: add cpumask_any_and_but()
Date: Wed,  3 Apr 2024 23:59:41 +0800
Message-Id: <20240403155950.2068109-2-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240403155950.2068109-1-dawei.li@shingroup.cn>
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

From: Mark Rutland <mark.rutland@arm.com>

In some cases, it's useful to be able to select a random cpu from the
intersection of two masks, excluding a particular CPU.

For example, in some systems an uncore PMU is shared by a subset of
CPUs, and management of this PMU is assigned to some arbitrary CPU in
this set. Whenever the management CPU is hotplugged out, we wish to
migrate responsibility to another arbitrary CPU which is both in this
set and online.

Today we can use cpumask_any_and() to select an arbitrary CPU in the
intersection of two masks. We can also use cpumask_any_but() to select
any arbitrary cpu in a mask excluding, a particular CPU.

To do both, we either need to use a temporary cpumask, which is
wasteful, or use some lower-level cpumask helpers, which can be unclear.

This patch adds a new cpumask_any_and_but() to cater for these cases.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 include/linux/cpumask.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..121f3ac757ff 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -388,6 +388,29 @@ unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 	return i;
 }
 
+/**
+ * cpumask_any_and_but - pick a "random" cpu from *mask1 & *mask2, but not this one.
+ * @mask1: the first input cpumask
+ * @mask2: the second input cpumask
+ * @cpu: the cpu to ignore
+ *
+ * Returns >= nr_cpu_ids if no cpus set.
+ */
+static inline
+unsigned int cpumask_any_and_but(const struct cpumask *mask1,
+				 const struct cpumask *mask2,
+				 unsigned int cpu)
+{
+	unsigned int i;
+
+	cpumask_check(cpu);
+	i = cpumask_first_and(mask1, mask2);
+	if (i != cpu)
+		return i;
+
+	return cpumask_next_and(cpu, mask1, mask2);
+}
+
 /**
  * cpumask_nth - get the Nth cpu in a cpumask
  * @srcp: the cpumask pointer
-- 
2.27.0


