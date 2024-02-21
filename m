Return-Path: <linux-kernel+bounces-74691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08385D7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65921F2266D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34350248;
	Wed, 21 Feb 2024 12:23:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FA34F8A2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518226; cv=none; b=suBWxo2A6iICSYsX7gazHyznfqAHvYDQ9TGPRk7sEPWclGL5OMJCWRa3WczXno9Tg2h9i7A9juXSh5zpuElPQnYoAMtpxbJg09FXTviqdfNKG3+3pKZTtxBqAKdCDTNRdlDRrz+iDQI4Bc9L9cDzEyO3eu37gwYBWPdsW0reUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518226; c=relaxed/simple;
	bh=oX9aizoUCrRamqQe1T5d8/5QrboBphelf0aIZYAOE6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPVVU09sY7KtdIooLQbwQYe/rS70rP/F5CdpP7Vp1XRkFu4MWjbULfU6D9+izfZ7VDPyQU0bR6VV4+S5Cenmnnpa95FeXpdIy5UoKyv3Jvctl41o1/mErmoYiIDplmk2lE4TBOxj1uL5sD+0ln62rXyWb6/KSQCLFCI6CWBA/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B572FEC;
	Wed, 21 Feb 2024 04:24:22 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FCC43F762;
	Wed, 21 Feb 2024 04:23:42 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>
Subject: [PATCH] x86/resctrl: Remove lockdep annotation that triggers false positive
Date: Wed, 21 Feb 2024 12:23:06 +0000
Message-Id: <20240221122306.633273-1-james.morse@arm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_domain_from_cpu() walks a list of domains to find the one that
contains the specified CPU. This needs to be protected against races
with CPU hotplug when the list is modified. It has recently gained a
lockdep annotation to check this.

The lockdep annotation causes false positives when called via IPI
as the lock is held, but by another process. Remove it.

Reported-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/ZdUSwOM9UUNpw84Y@agluck-desk3/
Fixes: fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9f1aa555a8ea..83e40341583e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -362,15 +362,6 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 {
 	struct rdt_domain *d;
 
-	/*
-	 * Walking r->domains, ensure it can't race with cpuhp.
-	 * Because this is called via IPI by rdt_ctrl_update(), assertions
-	 * about locks this thread holds will lead to false positives. Check
-	 * someone is holding the CPUs lock.
-	 */
-	if (IS_ENABLED(CONFIG_LOCKDEP))
-		lockdep_is_cpus_held();
-
 	list_for_each_entry(d, &r->domains, list) {
 		/* Find the domain that contains this CPU */
 		if (cpumask_test_cpu(cpu, &d->cpu_mask))
-- 
2.39.2


