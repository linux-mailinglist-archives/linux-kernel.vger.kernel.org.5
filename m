Return-Path: <linux-kernel+bounces-37025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D878A83AA61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92252285834
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAF377F0E;
	Wed, 24 Jan 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVItURdv"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A477649
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101010; cv=none; b=nqMyUIRMBQTfH+okeBbZxxQQ68muvbQZgWO0US10QNEsJpMoouyXnsNRXytS3PPYe4w9Nt4Smr7qagWUkaqvLGfkSusgyMBA+qSSixKZVgYuDEhgWEfFLr9u0UJPP4tVM8UFu8pyl/W9yqsizDwLhyFZat5UD8o7c48RZunYfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101010; c=relaxed/simple;
	bh=yc+q4KsjIiSfEwY6TeHFKJsFn5r2uXtVujdyv1Did04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLXA6qv+czre+V4CViJ8kWxQU50/AfD5MwkhrC16qP014/+/1dujkC8OrhUibfAjWAwq99czvyRdnSi8Gk3Szi0WLyc0uqdaR9lLDMBhEqqAa+s7jRQ/+YUJNd3PdhmARVmEQt4xFmck5H6FcIiDJxEzCVvk09SRUjP1GGzaCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVItURdv; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101008; x=1737637008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yc+q4KsjIiSfEwY6TeHFKJsFn5r2uXtVujdyv1Did04=;
  b=YVItURdve2E95cuhiH9zU/28Pt6c0nilY958FtRe03akGuBLJlRAs4HY
   Txeqz6rOiu7J79xd+m3qibwrgDi7bnIpXHOzLMvej4RcPXkNGJos1parE
   xLeUqM/sBOsSt+ou0nWprioFeYC8rNATwmL0RhOYo/jTlEQFXPIUpwDGG
   O5Et9PIi8GIY2WbhdYmBa3pXkCKsU40aVqEcuL8zIZSZqzMWKatKUh28n
   jrp/apnZ3pkZSE377sJGF3TDE1qxfvF9D/vP494M5ACftbqsN61JoonTo
   0ASXekYk4QCsg/aGmvJmQx53JjFyAOK/p3/16Q54xoUGi6B6q33o6yRo5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466110034"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466110034"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735924055"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735924055"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 04:56:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2E8BE65B; Wed, 24 Jan 2024 14:56:02 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 03/16] cpu/hotplug: Add support for declaring CPU offlining not supported
Date: Wed, 24 Jan 2024 14:55:44 +0200
Message-ID: <20240124125557.493675-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI MADT mailbox wakeup method doesn't allow to offline CPU after
it got woke up.

Currently offlining hotplug is prevented based on the confidential
computing attribute which is set for Intel TDX. But TDX is not
the only possible user of the wake up method. The MADT wakeup can be
implemented outside of a confidential computing environment. Offline
support is a property of the wakeup method, not the CoCo implementation.

Introduce cpu_hotplug_disable_offlining() that can be called to indicate
that CPU offlining should be disabled.

This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI
MADT wakeup method.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpu.h |  2 ++
 kernel/cpu.c        | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dcb89c987164..aa89ef93a884 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -139,6 +139,7 @@ extern void cpus_read_lock(void);
 extern void cpus_read_unlock(void);
 extern int  cpus_read_trylock(void);
 extern void lockdep_assert_cpus_held(void);
+extern void cpu_hotplug_disable_offlining(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
@@ -154,6 +155,7 @@ static inline void cpus_read_lock(void) { }
 static inline void cpus_read_unlock(void) { }
 static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
+static inline void cpu_hotplug_disable_offlining(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..7c28a07afe8b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -484,6 +484,8 @@ static int cpu_hotplug_disabled;
 
 DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
 
+static bool cpu_hotplug_offline_disabled __ro_after_init;
+
 void cpus_read_lock(void)
 {
 	percpu_down_read(&cpu_hotplug_lock);
@@ -543,6 +545,14 @@ static void lockdep_release_cpus_lock(void)
 	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
 }
 
+/* Declare CPU offlining not supported */
+void cpu_hotplug_disable_offlining(void)
+{
+	cpu_maps_update_begin();
+	cpu_hotplug_offline_disabled = true;
+	cpu_maps_update_done();
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -1522,7 +1532,8 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
 	 */
-	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
+	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
+	    cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-- 
2.43.0


