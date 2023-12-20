Return-Path: <linux-kernel+bounces-6716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B5819C83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200131F27350
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144820B3D;
	Wed, 20 Dec 2023 10:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GK8YwXgW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fmHVrzKM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40D20B03;
	Wed, 20 Dec 2023 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 10:11:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703067119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6hwmAWQKjMEl12UtoecaxvFXwVUb9+J4SBmMUc4vPU=;
	b=GK8YwXgWgW4n2bBFQZEQlJwIXmhTdQ+2/QWlHs55owmgnfP50smqY5A4EvhHmUKAeUxtsA
	+cU+eB8mkCq1lzygE46rcCJwl1CXJ7j55LdOXDYBWn+kVi18IuG010kZSGudVROxAMlJwQ
	HLy3OhQUwiF0QqducoKl916BxwodpEMfDTk/QMpJ1XCEzcDgluqCre+whGvzF/CjBdMDtf
	uNt2wStV4bUsIpjVFqXvOzUTBLy1RyvTJT5NVwhjR7LoUZ3Yu/lAsxaqPke2iLULFl18od
	4m2gS7kmRAqvZykJzsAo4tlihGP9q/wS0nCJwzz2DHGfmxQwA1Vhmwzkv6e5Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703067119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6hwmAWQKjMEl12UtoecaxvFXwVUb9+J4SBmMUc4vPU=;
	b=fmHVrzKMEr54qo/fQo97gUsJ3vkPqWxJTnEDqRQLZsI1R35FTPMYuagsAJHOQ6Ka2boFvr
	vG0uoA+9AgPR91Cw==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use existing helper functions to access
 ->avg_rt and ->avg_dl
Cc: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
References: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170306711877.398.11023074478817453654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6b5943af9198d21b4fdb1ce14ee11d11119cc709
Gitweb:        https://git.kernel.org/tip/6b5943af9198d21b4fdb1ce14ee11d11119cc709
Author:        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
AuthorDate:    Wed, 20 Dec 2023 12:25:22 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Dec 2023 11:04:05 +01:00

sched/fair: Use existing helper functions to access ->avg_rt and ->avg_dl

This is a minor code simplification. There are helper functions called
cpu_util_dl() and cpu_util_rt() which gives the average utilization of DL
and RT respectively. But there are few places in code where these
variables are open-coded.

Instead use the helper function so that code becomes simpler and easier to
maintain later on.

No change in functionality intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231220065522.351915-1-sshegde@linux.vnet.ibm.com
---
 kernel/sched/fair.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d5..0263106 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9212,19 +9212,17 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 
 static inline bool others_have_blocked(struct rq *rq)
 {
-	if (READ_ONCE(rq->avg_rt.util_avg))
+	if (cpu_util_rt(rq))
 		return true;
 
-	if (READ_ONCE(rq->avg_dl.util_avg))
+	if (cpu_util_dl(rq))
 		return true;
 
 	if (thermal_load_avg(rq))
 		return true;
 
-#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-	if (READ_ONCE(rq->avg_irq.util_avg))
+	if (cpu_util_irq(rq))
 		return true;
-#endif
 
 	return false;
 }
@@ -9481,8 +9479,8 @@ static unsigned long scale_rt_capacity(int cpu)
 	 * avg_thermal.load_avg tracks thermal pressure and the weighted
 	 * average uses the actual delta max capacity(load).
 	 */
-	used = READ_ONCE(rq->avg_rt.util_avg);
-	used += READ_ONCE(rq->avg_dl.util_avg);
+	used = cpu_util_rt(rq);
+	used += cpu_util_dl(rq);
 	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))

