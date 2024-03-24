Return-Path: <linux-kernel+bounces-116114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD888995E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962861F3270A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39A3AB7D7;
	Mon, 25 Mar 2024 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijZdy8z6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA97280203;
	Sun, 24 Mar 2024 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323637; cv=none; b=tfueCE3dUDNn6D5Yvj9tAVpnjXVmvzCXHyzJhPmikxRU+bR4JdPxdgi55Vp7BsJKxS7yuUYpBBn4rs/x2hgd/3Xnj9ZRle5SJHXCNEMQ/vNcPgzxFOzLntfsbnxesVa03w6KEL5XCSlXbD2h/Vy2Rjw9RA7pM5zAUggHZIgzz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323637; c=relaxed/simple;
	bh=tjjI2nsFG1aGxXNU8gC7cWP86c+GUyG67wihdRCmajA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9lbFitmdgm72nmDBtbEnj7xoorK9CawpAqFVIZmED5rj9luhLBT8MPWF7y3m3qNgdyvEsPoKBfOPE4ubctXGNzOp+wpu2/+zf+N2l4oVC8JsNQyInpuqvjhzbLmFF/RN52LM/IbuGPPPNJXrpWM8g7yaykgF9t2VP6w9es0icU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijZdy8z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF44C433F1;
	Sun, 24 Mar 2024 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323637;
	bh=tjjI2nsFG1aGxXNU8gC7cWP86c+GUyG67wihdRCmajA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijZdy8z69XJWaWgDssJFUzlKCb+rfhGEJFuZczreAxWexakfzysW0LDsO478o2Bqd
	 Sk+WkB+mKH40kXsynRAzyfmtV/VQoKWrjCAlFZ8cTtp3DgDWYUOkNvwbH3rrMup4v/
	 4jwQEqZSueTwtgrDmAIfitifqWCTitIgz0fgE6aZfv23opSTYyaSQzz0g4RENBA7Fo
	 GgZSK8urEsoDtU9ySAZMwofeEZ/sw7WXcY//Nxx7AnMigaUGq2my40WF0YgH5OitR3
	 WOw9eDuIeuuu3MI66LaRa+Z8HtZSB+krZasGo5jTXxgP0AbO4r/xVhQMCFGH0w+Ora
	 jCKTpqvBTxBQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 008/238] x86/xen: Add some null pointer checking to smp.c
Date: Sun, 24 Mar 2024 19:36:36 -0400
Message-ID: <20240324234027.1354210-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


