Return-Path: <linux-kernel+bounces-87019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA13A86CE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DEDB20E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD315C79C;
	Thu, 29 Feb 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNgLyCZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F215C78B;
	Thu, 29 Feb 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221880; cv=none; b=beIvckpHRFWjEiALuvPj382u5LTTI+xv6hdD3OPCTVN3QCht+gFIKmrbMAnMMTjKmFXMu2xK68Pd9xCvANNtc+aiZaXTxUdniXIcVxM2eyhSQPdPT+QV85yRYVf1qaFVtdyqRGpSYr30eOJbo2mWnbrHUQRdnzfcKJsIFNGi2Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221880; c=relaxed/simple;
	bh=tjjI2nsFG1aGxXNU8gC7cWP86c+GUyG67wihdRCmajA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgnx0xTr922OOs+Ns0hHgkoAVDhrt+lq2epKAJK75e3F/SRFHNXbXzjPPwDdg7wvFLBlJ8k8/cYRhibWynWqqDFmmAb3bE/1c1Y3W3xHdObuj+7EFVvrFuYD5/gZHf6zLATTeIcFQAaivKFi0HEEMcSfRU/bIPBKupdLV81wuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNgLyCZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164DCC433C7;
	Thu, 29 Feb 2024 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221880;
	bh=tjjI2nsFG1aGxXNU8gC7cWP86c+GUyG67wihdRCmajA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNgLyCZAP5SabKhrY69Yh/FMxMXc8w/meTe6JT/b5VvB6yoxI+RL6zcQVMZk9ad0j
	 eeODhydE1IjagsFlaWxP56CN70+igf+sa3jBiGfW+JCdm0ejtmIN4L+ACOnuG9jy+Z
	 istEkgVzmHux6sv5riDPneGTS8VgUg/2ueh4XLGxwM3Gni4+fL5AFA4V1Kgo5qXBcn
	 WeOYczAKXiJkwTo90oLOkwuJAk574qJZyNILenGIbGKZpicQ/UgkxwSap/yWcrCgM9
	 +WcIkQ5Y5Fs8DKWMRtqqhrZkIW5OR1oMTZSnMFut8BSgl47x6LGxAAu5XYUkyCOzi7
	 imGlwczYqMYPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 5.10 4/7] x86/xen: Add some null pointer checking to smp.c
Date: Thu, 29 Feb 2024 10:51:08 -0500
Message-ID: <20240229155112.2851155-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155112.2851155-1-sashal@kernel.org>
References: <20240229155112.2851155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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


