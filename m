Return-Path: <linux-kernel+bounces-160217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB898B3AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE2C1F21FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66C148FF4;
	Fri, 26 Apr 2024 15:09:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB3148FE1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144157; cv=none; b=t0zP/l83mNAjKIkwUN/oyD2ACYy9XOzxCDnCw7hmyTEXH7l5ik20eKbdGq2saJrh1aXzwafTMj6vzFnSG7W+btJxPn5L8iq2BgEemCdii9RvWjYvYQOVBLHwt5VOd1zyYK/k+fwElfJ6JOg41MHeFWUDt1iVd97OXnEBHVP3u28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144157; c=relaxed/simple;
	bh=i8DtAAr+DpyLdUOjSTjC5bTWalOOizbXnAWVd2L0Q6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Le6J6H0So2f3YGSsBmeU5sW7klQJsoBeQAtXq56yzxs/d/nUR/RZznwh1KZF+Rjagmk1vyAzpJ5TTWbo+s4MYJblpuuTcJZvQmW/vYNb2LvaY4xg/fd0qp2tDjNJj3EWbCQ7Czfe8Q+7zG4XCp4yoKcnMrkS7hPZzHMn+O1FTo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 074841596;
	Fri, 26 Apr 2024 08:09:43 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 229323F73F;
	Fri, 26 Apr 2024 08:09:12 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 01/35] x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no monitors
Date: Fri, 26 Apr 2024 16:08:30 +0100
Message-Id: <20240426150904.8854-1-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150537.8094-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
searching closid_num_dirty_rmid") added logic that causes resctrl to
search for the CLOSID with the fewest dirty cache lines when creating a
new control group, if requested by the arch code. This depends on the
values read from the llc_occupancy counters. The logic is applicable to
architectures where the CLOSID effectively forms part of the monitoring
identifier and so do not allow complete freedom to choose an unused
monitoring identifier for a given CLOSID.

This support missed that some platforms may not have these counters.
This causes a NULL pointer dereference when creating a new control
group as the array was not allocated by dom_data_init().

As this feature isn't necessary on platforms that don't have cache
occupancy monitors, add this to the check that occurs when a new
control group is allocated.

The existing code is not selected by any upstream platform, it makes
no sense to backport this patch to stable.

Fixes: 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid")
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>

---

Changes in v2:

 * [Commit message only] Reword the first paragraph to make it clear
   that the issue being fixed wasn't directly associated with addition
   of a Kconfig option.  (Actually, the option is not in Kconfig yet,
   and gets added later in this series.)
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 011e17efb1a6..1767c1affa60 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -149,7 +149,8 @@ static int closid_alloc(void)
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
+	    is_llc_occupancy_enabled()) {
 		cleanest_closid = resctrl_find_cleanest_closid();
 		if (cleanest_closid < 0)
 			return cleanest_closid;
-- 
2.34.1


