Return-Path: <linux-kernel+bounces-56640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1C84CD19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6023C1F26792
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62937F477;
	Wed,  7 Feb 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXvKNZp9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F07D3E6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317046; cv=none; b=naIXfuk9QvfbY9IrqJ+m5u0Z8rbwpecrl+77dnojaZWoXBVudwNXQCpISJ/BOmjpA4oaYMjT2mHIQ4Du1kXLjyU9HgoBqaRZsHJnWcHoqTDI1P/jSvQ1uHb8zKrloretcwpKNf6pVj9MC1U4Fm6boSk3VFpnqtPJcAOc8E6QT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317046; c=relaxed/simple;
	bh=yu3kruoJPnY3VnyFFiTKqHdjvyDwreXWFSWpG6/xubI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emnNTXRXtK6GEHRCMXQqfrOYd50JlLNFWeDYbKEn/UQRe09A9Wg5LunUH8VJEgSHlp+55l29qEYYmp7AQEBQ3p+1wwzYD9mrhwH+aNn1hOznjqZnezgDN+LFl7lVM07gGllEU3apeclSf7fCvL52Msulh3EenUp61kN7JGQDfC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXvKNZp9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707317044; x=1738853044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yu3kruoJPnY3VnyFFiTKqHdjvyDwreXWFSWpG6/xubI=;
  b=FXvKNZp9j/E7Jy/FY7ctTDwuMl3MmxxUvK+Y8oRDobBZ3L/ltKSm2npU
   SMU+bDGgb1KpA+xwsRp3shjB/+oPIr/YZlrp8jS6GsGWaqNtjsQhP3LPI
   N3ObftyyK34ZsJUE/VI06x/1JxHN3K9NueVMj7gbl10UGhS/lh5d+QG4A
   YkbOI03TjfOiyPMfln3HV0OJYaLQz/4K9ZchKpIm4LGtsKve6/GaD5fp/
   DLIiLlyd+kNwDY75bfnQ6Un10sHeiKhl+B4aJjafoa2ylGlO/fbXMbnp1
   JuBKjwdwIfPme4neGGD43pxUc1RRlKE317QkWowo+bssF4rfTf66vFaiz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1135003"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1135003"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="38788916"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa001.jf.intel.com with ESMTP; 07 Feb 2024 06:43:50 -0800
From: Feng Tang <feng.tang@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] sched/debug: Dump end of stack when detected corrupted
Date: Wed,  7 Feb 2024 22:35:23 +0800
Message-Id: <20240207143523.438816-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When debugging a kernel hang during suspend/resume [1], there were random
memory corruptions in different places like being reported by
slub_debug+KASAN, or detected by scheduler with error message:

  "Kernel panic - not syncing: corrupted stack end detected inside scheduler"

So dump the corrupted memory around the stack end to give more direct
hints about how the memory is corrupted:

 "
 Corrupted Stack: ff11000122770000: ff ff ff ff ff ff 14 91 82 3b 78 e8 08 00 45 00  .........;x...E.
 Corrupted Stack: ff11000122770010: 00 1d 2a ff 40 00 40 11 98 c8 0a ef 30 2c 0a ef  ..*.@.@.....0,..
 Corrupted Stack: ff11000122770020: 30 ff a2 00 22 3d 00 09 9a 95 2a 00 00 00 00 00  0..."=....*.....
 ...
 Kernel panic - not syncing: corrupted stack end detected inside scheduler
 "

And with it, the culprit was quickly identified to be ethernet driver
that it frees RX related memory back to kernel in suspend hook, but
its HW is not really stopped, and still send RX data to those old
buffer through DMA.

[1]. https://bugzilla.kernel.org/show_bug.cgi?id=217854

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
Changlog:

  since v1:
    * Refine the commit log with more info, and rebase againt 6.8-rc3

 kernel/sched/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..1344ac42e6d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5950,8 +5950,18 @@ static noinline void __schedule_bug(struct task_struct *prev)
 static inline void schedule_debug(struct task_struct *prev, bool preempt)
 {
 #ifdef CONFIG_SCHED_STACK_END_CHECK
-	if (task_stack_end_corrupted(prev))
+	if (task_stack_end_corrupted(prev)) {
+		unsigned long *ptr = end_of_stack(prev);
+
+		/* Dump 16 ulong words around the corruption point */
+#ifdef CONFIG_STACK_GROWSUP
+		ptr -= 15;
+#endif
+		print_hex_dump(KERN_ERR, "Corrupted Stack: ",
+			DUMP_PREFIX_ADDRESS, 16, 1, ptr, 16 * sizeof(*ptr), 1);
+
 		panic("corrupted stack end detected inside scheduler\n");
+	}
 
 	if (task_scs_end_corrupted(prev))
 		panic("corrupted shadow stack detected inside scheduler\n");
-- 
2.34.1


