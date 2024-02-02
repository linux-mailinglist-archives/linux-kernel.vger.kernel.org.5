Return-Path: <linux-kernel+bounces-49898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22E847127
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A30F1C262C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C646535;
	Fri,  2 Feb 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YM6ccpn0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB046430
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880553; cv=none; b=KemsSDFaq62xsNZiRvSgYZO10chBnwPo0Z9rtVkViFHx043hCY4SeO1jQ4rZfHHHOy2exgOqRNevHg2ewUT9OZxTWX1mPoVle+sOQjFCrEVC596yDuTX+xX1+cxhPNWHxP/c3w7alnjrIuXkL+GWW6CULGewpGAU3Y0xa/sH60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880553; c=relaxed/simple;
	bh=EOuVn7h5rBzXLjSX6vgvwOxg8VenfLXWcdGIB/LkqTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iR1GfXi6tOWpYCnoLiAxu705CPv6PjPfedkKMOAsnsnFkntXGABd1TuICF6OK/ogEF4eQCAdR0Fs2tp6jdcQHKSzdz3rKxH5JFUr/eSQ9VpQ/LtD6YkMAJDpB28wux2t8XMMarq6nMV6ycMnYn/XLoVmck7imYLE1qz0BVZdqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YM6ccpn0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706880552; x=1738416552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EOuVn7h5rBzXLjSX6vgvwOxg8VenfLXWcdGIB/LkqTA=;
  b=YM6ccpn05oQ4zXVo6+8kYvOCz8E9QtsIEPdsqwr+6LDTFVFpQXpqJF/F
   3zHVtGNnZMjVPWh4zdFkVzH9WNL7Zlnq2+dBe9HuXs4kx4ijgHbAiDWOB
   tTYz3brnARTgbPIy32PK7N46LxCF7kC7JnWXQENWbCLK8v4sp/tefuXJP
   zEg/qWn7Sab7caS57b8v5MDc6LWcppZVD9iptrwcCuB2PBrOuNSVq0p8G
   l/cuYQ6c06r8IyXGARx4xxG/HOIS9C2jCyz+ctDRgvQwoGpml7x3fwdW3
   RerbP3szGiLHKyY2DzB7EMkC/2KXQiBYqDOgCkHS8v40Ks+nSgu7B1YlH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17685033"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17685033"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 05:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="31174623"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmviesa001.fm.intel.com with ESMTP; 02 Feb 2024 05:29:09 -0800
From: Feng Tang <feng.tang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	gpiccoli@igalia.com,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH] panic: add option to dump blocked tasks in panic_print
Date: Fri,  2 Feb 2024 21:20:42 +0800
Message-Id: <20240202132042.3609657-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging kernel panic and other bugs, there is already option of
panic_print to dump all tasks' call stacks. On today's large servers
running many containers, there could be thousands of tasks or more,
and it will print out huge amount of call stacks, and take a lot of
time (for serial console which is main target user case of panic_print).

And in many cases, only those several tasks being blocked is key for
the panic, so add an option to only dump blocked tasks' call stack.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 Documentation/admin-guide/sysctl/kernel.rst     | 1 +
 kernel/panic.c                                  | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..0f2369e87175 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4182,6 +4182,7 @@
 			bit 4: print ftrace buffer
 			bit 5: print all printk messages in buffer
 			bit 6: print all CPUs backtrace (if available in the arch)
+			bit 7: print tasks in uninterruptible (blocked) state
 			*Be aware* that this option may print a _lot_ of lines,
 			so there are risks of losing older messages in the log.
 			Use this option carefully, maybe worth to setup a
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 6584a1f9bfe3..e066a16b35d5 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -850,6 +850,7 @@ bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
 bit 4  print ftrace buffer
 bit 5  print all printk messages in buffer
 bit 6  print all CPUs backtrace (if available in the arch)
+bit 7  print tasks in uninterruptible (blocked) state
 =====  ============================================
 
 So for example to print tasks and memory info on panic, user can::
diff --git a/kernel/panic.c b/kernel/panic.c
index 2807639aab51..aa17ae0897c0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -73,6 +73,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
 #define PANIC_PRINT_FTRACE_INFO		0x00000010
 #define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
 #define PANIC_PRINT_ALL_CPU_BT		0x00000040
+#define PANIC_PRINT_BLOCKED_TASKS	0x00000080
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -227,6 +228,9 @@ static void panic_print_sys_info(bool console_flush)
 
 	if (panic_print & PANIC_PRINT_FTRACE_INFO)
 		ftrace_dump(DUMP_ALL);
+
+	if (panic_print & PANIC_PRINT_BLOCKED_TASKS)
+		show_state_filter(TASK_UNINTERRUPTIBLE);
 }
 
 void check_panic_on_warn(const char *origin)
-- 
2.34.1


