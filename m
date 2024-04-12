Return-Path: <linux-kernel+bounces-141817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4638A23D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DA11C231FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240F10A3C;
	Fri, 12 Apr 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhBMlhuV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBC134B2;
	Fri, 12 Apr 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889702; cv=none; b=t5f7wl4Rx2u1kktDMj1BDtUiR08JeXUD4PHrWGrX71kBH7ohCo/wQfcuzwvK5KsMgTSHnSVzO54AIciEgzXYVup0Nmpu/Q7ehcYWts1WqEPdOCOJKMSj2A+3WhoffsucMY3qlwZVTm6ig9+hp8KLJ9jcY1tomneHbzvnnRUqMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889702; c=relaxed/simple;
	bh=gyAmQHiRYV+HIpaJgNo9yjZlDqDiDb0tmnZMSirOQh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UZU5LrAIadRcU2ZaM3qEcHMF7vPoAJfT1iD6w5oWm056w47tyGkG9qK3pVO/r79EkHGfbFb16Hk6zHHZ1De6tee0IclarWjCGCHz68NeoSO0IBQo8CGrGCvkMB+B0n6hn/M+dC241D3F4WDLJRktAKImL3e2VE2IWV1iirta/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhBMlhuV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712889701; x=1744425701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gyAmQHiRYV+HIpaJgNo9yjZlDqDiDb0tmnZMSirOQh0=;
  b=LhBMlhuVuahbYOrMk/GykIhNaTc0nJsUu47eU9W4QC/H2SLfVixEoKOq
   KWgF7yvGfE1/cjE7qr4aTV79rmd4YdGm/t6YA1xvE8Bi62/Kyz7wqa0hD
   ybf/sQNIZPeNBm5qx3jBWL89kxv11H2UqlIavUW8kP0qKlnU3maGpGRow
   Iso75RLWa2ybmtTlhmoAHq4HEUzwyWWbi8C37/JrvJLfFFFK/bsE4M8wR
   hSSIqnieGTyxR+sCWbT3gCEleBETxvxJ86f5cgFoW+Z8S8jrmvfGoKkH/
   nn8SnS4Q0MuF0203Fl8bhHJLRy5ixF8r/FR7Z0DAqojf1CSxzo7OuW0OM
   A==;
X-CSE-ConnectionGUID: kYqiYsJ/TRiZN+8smgdQ/Q==
X-CSE-MsgGUID: q3zwEHCITUqy1RVTjXEe0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8509241"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="8509241"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 19:41:40 -0700
X-CSE-ConnectionGUID: 43qFm/8HR5Sq62vjVjcUgA==
X-CSE-MsgGUID: FneYL0rOQdyFIsDuyE84vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="58519954"
Received: from qzhang4-desk.sh.intel.com (HELO localhost) ([10.239.147.49])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 19:41:38 -0700
From: qiang4.zhang@linux.intel.com
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Qiang Zhang <qiang4.zhang@intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH RESEND] bootconfig: use memblock_free_late to free xbc memory to buddy
Date: Fri, 12 Apr 2024 10:41:04 +0800
Message-Id: <20240412024103.3078378-1-qiang4.zhang@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiang Zhang <qiang4.zhang@intel.com>

On the time to free xbc memory, memblock has handed over memory to buddy
allocator. So it doesn't make sense to free memory back to memblock.
memblock_free() called by xbc_exit() even causes UAF bugs on architectures
with CONFIG_ARCH_KEEP_MEMBLOCK disabled like x86. Following KASAN logs
shows this case.

[    9.410890] ==================================================================
[    9.418962] BUG: KASAN: use-after-free in memblock_isolate_range+0x12d/0x260
[    9.426850] Read of size 8 at addr ffff88845dd30000 by task swapper/0/1

[    9.435901] CPU: 9 PID: 1 Comm: swapper/0 Tainted: G     U             6.9.0-rc3-00208-g586b5dfb51b9 #5
[    9.446403] Hardware name: Intel Corporation RPLP LP5 (CPU:RaptorLake)/RPLP LP5 (ID:13), BIOS IRPPN02.01.01.00.00.19.015.D-00000000 Dec 28 2023
[    9.460789] Call Trace:
[    9.463518]  <TASK>
[    9.465859]  dump_stack_lvl+0x53/0x70
[    9.469949]  print_report+0xce/0x610
[    9.473944]  ? __virt_addr_valid+0xf5/0x1b0
[    9.478619]  ? memblock_isolate_range+0x12d/0x260
[    9.483877]  kasan_report+0xc6/0x100
[    9.487870]  ? memblock_isolate_range+0x12d/0x260
[    9.493125]  memblock_isolate_range+0x12d/0x260
[    9.498187]  memblock_phys_free+0xb4/0x160
[    9.502762]  ? __pfx_memblock_phys_free+0x10/0x10
[    9.508021]  ? mutex_unlock+0x7e/0xd0
[    9.512111]  ? __pfx_mutex_unlock+0x10/0x10
[    9.516786]  ? kernel_init_freeable+0x2d4/0x430
[    9.521850]  ? __pfx_kernel_init+0x10/0x10
[    9.526426]  xbc_exit+0x17/0x70
[    9.529935]  kernel_init+0x38/0x1e0
[    9.533829]  ? _raw_spin_unlock_irq+0xd/0x30
[    9.538601]  ret_from_fork+0x2c/0x50
[    9.542596]  ? __pfx_kernel_init+0x10/0x10
[    9.547170]  ret_from_fork_asm+0x1a/0x30
[    9.551552]  </TASK>

[    9.555649] The buggy address belongs to the physical page:
[    9.561875] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x45dd30
[    9.570821] flags: 0x200000000000000(node=0|zone=2)
[    9.576271] page_type: 0xffffffff()
[    9.580167] raw: 0200000000000000 ffffea0011774c48 ffffea0012ba1848 0000000000000000
[    9.588823] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[    9.597476] page dumped because: kasan: bad access detected

[    9.605362] Memory state around the buggy address:
[    9.610714]  ffff88845dd2ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.618786]  ffff88845dd2ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.626857] >ffff88845dd30000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.634930]                    ^
[    9.638534]  ffff88845dd30080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.646605]  ffff88845dd30100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[    9.654675] ==================================================================

Cc: Stable@vger.kernel.org
Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index c59d26068a64..4524ee944df0 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -63,7 +63,7 @@ static inline void * __init xbc_alloc_mem(size_t size)
 
 static inline void __init xbc_free_mem(void *addr, size_t size)
 {
-	memblock_free(addr, size);
+	memblock_free_late(__pa(addr), size);
 }
 
 #else /* !__KERNEL__ */
-- 
2.39.2


