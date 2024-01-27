Return-Path: <linux-kernel+bounces-41154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B6683ECB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653B81F2387C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C431F16B;
	Sat, 27 Jan 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhHElZAt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982A71EB20;
	Sat, 27 Jan 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350838; cv=none; b=PhMP/BOMqXlLsB+6t69nX2n0WpRZUS99AcmMgsz6gacOuF3L9Si+JTKrDrYZPbgjsU+S9atBtrfFjSIzW3iPcxeecNQT7Vx4TVmu6khqI7Qflwb8k9FzMao2Unf+xg4uJ9qB+cpTUKh3ZxlInh+xrKzvzT6J3ADZ1qO2AZ8Xbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350838; c=relaxed/simple;
	bh=ZIp07KLSbtqTKgIrZCzbzRih7jTMG+18gPMPyej+kaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+8T3lR1Dq4/7cGKphb20E7QZiBdjewN8QdkFA3jyIkJl3ZK01qhjHcf6tYW5S5EFnRTH1+xlxrnhcc7Motv/9hjGnDLjXnPoAcL90FW0ZZokWoZ1gKW/rmPh8khqmC1QeC9cd9VH61/47fa4OkEdmM9Tktx8rbjYXIH5Wbo7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhHElZAt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706350837; x=1737886837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZIp07KLSbtqTKgIrZCzbzRih7jTMG+18gPMPyej+kaA=;
  b=dhHElZAt9WdR/hy6R6svHYbhImQFm8t9rZDK2YknJW0TAjDUcxl9vv0z
   GKlUJOm9UrBxvzaXuZ7hGeSO6Q5QTHp3ZVN1+h75jLD0Stl0MAn1ONu09
   QkvNpW1kpANWegWafVnIzUIvHpHpYDSknlAioElSc9EVA5NuAOGC+s/Y/
   gpb/B32x7NTFURZgW/mTwkZnNChlYM+6e3yN2jQDY7k29fGcELnCaRCx4
   yXIK3US6/9EQhkQ0dqJohaR2kJPHivam5mjRJZb6eu+An1qK/VcVYZNMp
   tTPwMhBWnQ6Tg41o+E2AZ9hxVYMslYwWXKhAlWxKfM7N/+gIfAiSv9c6a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2539942"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2539942"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 02:20:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787359545"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="787359545"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2024 02:20:35 -0800
From: Xin Li <xin3.li@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ravi.v.shankar@intel.com,
	andrew.cooper3@citrix.com
Subject: [PATCH] x86/fred: Let command line option "fred" accept multiple options
Date: Sat, 27 Jan 2024 01:49:12 -0800
Message-ID: <20240127094912.1489-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let command line option "fred" accept multiple options to make it
easier to tweak its behavior.

Currently two options 'on' and 'off' are allowed, and the default
behavior is to disable FRED. To enable FRED, append "fred=on" to
the kernel command line.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++--
 arch/x86/kernel/cpu/common.c                  |  3 ---
 arch/x86/kernel/traps.c                       | 26 +++++++++++++++++++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c6c1a2c79835..bca252946e5e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1539,8 +1539,11 @@
 			Warning: use of this parameter will taint the kernel
 			and may cause unknown problems.
 
-	fred		[X86-64]
-			Enable flexible return and event delivery
+	fred=		[X86-64]
+			Enable/disable Flexible Return and Event Delivery.
+			Format: { on | off }
+			on: enable FRED when it's present.
+			off: disable FRED, the default option in early stage.
 
 	ftrace=[tracer]
 			[FTRACE] will set and start the specified tracer
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5ed968c0f9c5..cf82e3181f7a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1484,9 +1484,6 @@ static void __init cpu_parse_early_param(void)
 	char *argptr = arg, *opt;
 	int arglen, taint = 0;
 
-	if (!cmdline_find_option_bool(boot_command_line, "fred"))
-		setup_clear_cpu_cap(X86_FEATURE_FRED);
-
 #ifdef CONFIG_X86_32
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
 #ifdef CONFIG_MATH_EMULATION
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index cf198d9e98b2..1993e3bba1d1 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1402,8 +1402,34 @@ DEFINE_IDTENTRY_SW(iret_error)
 }
 #endif
 
+/* Do not enable FRED by default in its early stage. */
+static bool enable_fred __ro_after_init = false;
+
+#ifdef CONFIG_X86_FRED
+static int __init fred_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has(X86_FEATURE_FRED))
+		return 0;
+
+	if (!strcmp(str, "on"))
+		enable_fred = true;
+	else if (!strcmp(str, "off"))
+		enable_fred = false;
+	else
+		pr_warn("invalid FRED option: 'fred=%s'\n", str);
+	return 0;
+}
+early_param("fred", fred_setup);
+#endif
+
 void __init trap_init(void)
 {
+	if (boot_cpu_has(X86_FEATURE_FRED) && !enable_fred)
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
 

base-commit: a9f26154bf5478fc155309fc69128415f3a1be08
-- 
2.43.0


