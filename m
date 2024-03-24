Return-Path: <linux-kernel+bounces-114725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5FD888BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0778A297A44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8CD19F535;
	Mon, 25 Mar 2024 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TchJPrfi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA608217DE7;
	Sun, 24 Mar 2024 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323309; cv=none; b=ZLQRaEIJzNOqqNMcMOYHbqNC7hKIViuPGFjdJRWOi6q6cIO5OmgTEeM+g4tfocUxdRaIT2F2JEpllmwVKGwhLzdMk0Yxv9ZUX2oBMUX5C0sAx22cmF7xOusW221UT2MO+lUDMAKy9kLQp8JGae5GTsgavjfi/tIzdpENmdYP4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323309; c=relaxed/simple;
	bh=tjjI2nsFG1aGxXNU8gC7cWP86c+GUyG67wihdRCmajA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BizfRKNemhy+e/+9kmJOEn0Zf/u0ij5MP9vvhPqkS4Oih1mMrjyaC6kQJBEyzOaomqHjEHzhV3qyizOrJwiCUZZ0hSqj6QcmsieMHGaPEff7D+h5I19KmH4h4euG5PlVudBZCU1g3/903lscMblkmEeXt9TkgRN8t359GjsIWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TchJPrfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D372C433C7;
	Sun, 24 Mar 2024 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323308;
	bh=tjjI2nsFG1aGxXNU8gC7cWP86c+GUyG67wihdRCmajA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TchJPrfi46vveoItzDzuorHazSCyztX+qm7hE+CWmaoeVt3ttkkSUM5a23DE/6tWm
	 WhlDZs7rx/3pbpwNsKT5Zd3+HlFRR3d7G/1ga5yBKg0LZF/PNO8vNoHKpzWvztwjLy
	 SlUKCMUm3Eg0qnImdpBfexBrQij+qVCDV0cE8Ytbn15xuJLAnHsY50AB6O0Lu1tPxw
	 O0BK9w+jn5QAAoDWdkzYUHc1KOj6G2dyBv6nuYvBLzy+iwBVG+psmnn7Kg5BWOxAkN
	 P04+NbQkrrWK+K/7B3TZkmnJ8Ko4mc4IjohugnfURGl3KPe+Ye8f2j8gx31djHi739
	 Ea+htwuOukrxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 008/317] x86/xen: Add some null pointer checking to smp.c
Date: Sun, 24 Mar 2024 19:29:48 -0400
Message-ID: <20240324233458.1352854-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 3693bb4465e6e32a204a5b86d3ec7e6b9f7e67c2 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401161119.iof6BQsf-lkp@intel.com/
Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20240119094948.275390-1-chentao@kylinos.cn
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/smp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index cdec892b28e2e..a641e0d452194 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -65,6 +65,8 @@ int xen_smp_intr_init(unsigned int cpu)
 	char *resched_name, *callfunc_name, *debug_name;
 
 	resched_name = kasprintf(GFP_KERNEL, "resched%d", cpu);
+	if (!resched_name)
+		goto fail_mem;
 	per_cpu(xen_resched_irq, cpu).name = resched_name;
 	rc = bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
 				    cpu,
@@ -77,6 +79,8 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_resched_irq, cpu).irq = rc;
 
 	callfunc_name = kasprintf(GFP_KERNEL, "callfunc%d", cpu);
+	if (!callfunc_name)
+		goto fail_mem;
 	per_cpu(xen_callfunc_irq, cpu).name = callfunc_name;
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_VECTOR,
 				    cpu,
@@ -90,6 +94,9 @@ int xen_smp_intr_init(unsigned int cpu)
 
 	if (!xen_fifo_events) {
 		debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
+		if (!debug_name)
+			goto fail_mem;
+
 		per_cpu(xen_debug_irq, cpu).name = debug_name;
 		rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu,
 					     xen_debug_interrupt,
@@ -101,6 +108,9 @@ int xen_smp_intr_init(unsigned int cpu)
 	}
 
 	callfunc_name = kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
+	if (!callfunc_name)
+		goto fail_mem;
+
 	per_cpu(xen_callfuncsingle_irq, cpu).name = callfunc_name;
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
 				    cpu,
@@ -114,6 +124,8 @@ int xen_smp_intr_init(unsigned int cpu)
 
 	return 0;
 
+ fail_mem:
+	rc = -ENOMEM;
  fail:
 	xen_smp_intr_free(cpu);
 	return rc;
-- 
2.43.0


