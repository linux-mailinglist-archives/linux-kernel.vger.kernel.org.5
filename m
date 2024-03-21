Return-Path: <linux-kernel+bounces-110438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B5885F04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80C72837C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED4140369;
	Thu, 21 Mar 2024 16:52:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986213F428
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039959; cv=none; b=lO058F8vDu6tloqe6socxXObcjiqVE5zvISkyKwJPLaxLgttkClJhOcY8rxSg+BrN+f4a6EUrNNirrpxw4BtXUmmQ752f2smHrfTpE6ceBqsMwAddZs1BfPC4mGtrHylgKSEVnWBz8Bk5hqvfJG/x9oDn5ZlRyF9HD9DoRizILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039959; c=relaxed/simple;
	bh=IwQaaf8zuJ4axtC21pDkJ4vGinVw+XU/Yp1+ON7Papw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mt9cTWvZM3CB8HXyDO0jLteyZJ61RZP7aMLLmM4WXBnkQbQbX4zjXS0nvqA0OgWj86IFbfIb4hjJw5bjLQfkf+zsIJiIJMFdJ3NL+gpmtEVvalfogr9WhdvDPyoQ2xdJq9I6sBetxYw9P9Kp5mgNJP9hrbgo84OcpSq9Od+jkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB366168F;
	Thu, 21 Mar 2024 09:53:11 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD6953F67D;
	Thu, 21 Mar 2024 09:52:34 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v1 21/31] x86/resctrl: Make prefetch_disable_bits belong to the arch code
Date: Thu, 21 Mar 2024 16:50:56 +0000
Message-Id: <20240321165106.31602-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prefetch_disable_bits is set by rdtgroup_locksetup_enter() from a
value provided by the architecture, but is largely read by other
architecture helpers.

Instead of exporting this value, make
resctrl_arch_get_prefetch_disable_bits() set it so that the other
arch-code helpers can use the cached-value.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 856beb6f668b..5a66e3b2c2ea 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -85,6 +85,8 @@ static const struct class pseudo_lock_class = {
  */
 u64 resctrl_arch_get_prefetch_disable_bits(void)
 {
+	prefetch_disable_bits = 0;
+
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86 != 6)
 		return 0;
@@ -100,7 +102,8 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
 		 * 3    DCU IP Prefetcher Disable (R/W)
 		 * 63:4 Reserved
 		 */
-		return 0xF;
+		prefetch_disable_bits = 0xF;
+		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		/*
@@ -111,10 +114,11 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
 		 * 2     DCU Hardware Prefetcher Disable (R/W)
 		 * 63:3  Reserved
 		 */
-		return 0x5;
+		prefetch_disable_bits = 0x5;
+		break;
 	}
 
-	return 0;
+	return prefetch_disable_bits;
 }
 
 /**
@@ -715,8 +719,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * Not knowing the bits to disable prefetching implies that this
 	 * platform does not support Cache Pseudo-Locking.
 	 */
-	prefetch_disable_bits = resctrl_arch_get_prefetch_disable_bits();
-	if (prefetch_disable_bits == 0) {
+	if (resctrl_arch_get_prefetch_disable_bits() == 0) {
 		rdt_last_cmd_puts("Pseudo-locking not supported\n");
 		return -EINVAL;
 	}
-- 
2.39.2


