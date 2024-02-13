Return-Path: <linux-kernel+bounces-64092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B4853A16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D471F24CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA81286B3;
	Tue, 13 Feb 2024 18:45:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8A71F618
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849907; cv=none; b=rfsQBsAwNMu7ct4x4dFy/Fux/3NH8L0zWyGEmOGD7Jlt9/UCJrCfsWavHkXbofGM1dN/VZ77iJyLduFzW8eyFMgxetl3DgbNwEGyd36OAsV6rJvxdkxZByzqDIw0lYQl4/+quQLkPF3uCOeO9Y7s2oDposddtis8V6vfrCFkyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849907; c=relaxed/simple;
	bh=N9LgQW81xVaWBAUrrbwt8I6fqkUZ41bThuldzq3VtBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8vQELYdFmqkFfRm+xTKgec1C1qPqgZYFwD/WnCLC4pmvXQ+/6yL4+OfK0JbLdHYBlmHeWbgTiK+YaOsZBxk9Fuw/KzGtziKn/KSJGURrYNfNbIXwQeeSnkYIu1qXbLUWTUJKOcqgjMOqIokZ405HoipPOE98T5Yt3GoZAI3aiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B2F6DA7;
	Tue, 13 Feb 2024 10:45:46 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECE6F3F766;
	Tue, 13 Feb 2024 10:45:01 -0800 (PST)
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
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v9 01/24] tick/nohz: Move tick_nohz_full_mask declaration outside the #ifdef
Date: Tue, 13 Feb 2024 18:44:15 +0000
Message-Id: <20240213184438.16675-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>
References: <20240213184438.16675-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
a specific CPU to be tested against the mask, and evaluates to false
when CONFIG_NO_HZ_FULL is not defined.

The resctrl code needs to pick a CPU to run some work on, a new helper
prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
be behind an ifdef too.

Move the tick_nohz_full_mask declaration, this lets callers drop the
ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
something like tick_nohz_full_cpu().

The definition does not need to be moved as any callers should be
removed at compile time unless CONFIG_NO_HZ_FULL is defined.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com> # for resctrl dependency
CC: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 716d17f31c45..0fb903838dfb 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -164,9 +164,16 @@ static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
+/*
+ * Mask of CPUs that are nohz_full.
+ *
+ * Users should be guarded by CONFIG_NO_HZ_FULL or a tick_nohz_full_cpu()
+ * check.
+ */
+extern cpumask_var_t tick_nohz_full_mask;
+
 #ifdef CONFIG_NO_HZ_FULL
 extern bool tick_nohz_full_running;
-extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
 {
-- 
2.39.2


