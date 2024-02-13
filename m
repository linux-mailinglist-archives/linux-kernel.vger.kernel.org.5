Return-Path: <linux-kernel+bounces-64100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD84853A22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231541F2138B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30341118E;
	Tue, 13 Feb 2024 18:45:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420460DC3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849934; cv=none; b=IOhEl7UF1hS5RYY+BZQyNeRhlCRINnonwg1Y4/kJ1hH1o8BdFPDn1mrzEp51oSPYxBCITJtiL6BXgxwNyXy8shI+Rv5+ocV/T5dQbQbitacaqzRTPTn2jQs4wtsjf+QQXoAFUlh1KgaGHKplM0DGPJCSrK8KsD4LWWNpfz4Hj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849934; c=relaxed/simple;
	bh=SohyraE/+H1Ez4/07fPwKDGgs8I/0aYXelB5GAm+lJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTW1zPvPEcZDJKACjUBgMVmDnDKzLSRRAEb50nUgxc/ycnn6nSTMnukNMqkCeKbFw49/9GhIFrsQ/E/sCr0Epj+9F1IUKVLHmJR6SxAjXvWhNxvL0nHVhdqesgGwt1vgTEzbN7wHXbp6I2jD+iEQkSL85A+9tKPnSWfzSGKfzfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E3111480;
	Tue, 13 Feb 2024 10:46:13 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED7E73F766;
	Tue, 13 Feb 2024 10:45:28 -0800 (PST)
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
	Babu Moger <babu.moger@amd.com>
Subject: [PATCH v9 09/24] x86/resctrl: Use __set_bit()/__clear_bit() instead of open coding
Date: Tue, 13 Feb 2024 18:44:23 +0000
Message-Id: <20240213184438.16675-10-james.morse@arm.com>
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

The resctrl CLOSID allocator uses a single 32bit word to track which
CLOSID are free. The setting and clearing of bits is open coded.

Convert the existing open coded bit manipulations of closid_free_map
to use __set_bit() and friends. These don't need to be atomic as this
list is protected by the mutex.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
---
Changes since v6:
 * Use the __ inatomic helpers and add lockdep_assert_held() annotations to
   document how this is safe.
 * Fixed a resctrl_closid_is_free()/closid_allocated() rename in the commit
   message.
 * Use RESCTRL_RESERVED_CLOSID to improve readability.

Changes since v7:
 * Removed paragraph explaining why this should be done now due to badword
   'subsequent'.
 * Changed a comment to refer to RESCTRL_RESERVED_CLOSID.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index dcffd1c4a476..bc6e0f83c847 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -111,7 +111,7 @@ void rdt_staged_configs_clear(void)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static int closid_free_map;
+static unsigned long closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -130,8 +130,8 @@ static void closid_init(void)
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
-	/* CLOSID 0 is always reserved for the default group */
-	closid_free_map &= ~1;
+	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
+	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
 	closid_free_map_len = rdt_min_closid;
 }
 
@@ -139,17 +139,21 @@ static int closid_alloc(void)
 {
 	u32 closid = ffs(closid_free_map);
 
+	lockdep_assert_held(&rdtgroup_mutex);
+
 	if (closid == 0)
 		return -ENOSPC;
 	closid--;
-	closid_free_map &= ~(1 << closid);
+	__clear_bit(closid, &closid_free_map);
 
 	return closid;
 }
 
 void closid_free(int closid)
 {
-	closid_free_map |= 1 << closid;
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	__set_bit(closid, &closid_free_map);
 }
 
 /**
@@ -161,7 +165,9 @@ void closid_free(int closid)
  */
 static bool closid_allocated(unsigned int closid)
 {
-	return (closid_free_map & (1 << closid)) == 0;
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	return !test_bit(closid, &closid_free_map);
 }
 
 /**
-- 
2.39.2


