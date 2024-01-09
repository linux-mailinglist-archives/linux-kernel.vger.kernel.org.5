Return-Path: <linux-kernel+bounces-20414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD9827E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B595C1F2444C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647015A4;
	Tue,  9 Jan 2024 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGP+knpB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD78F48
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704779232; x=1736315232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0jk4H4zTEKceAubMlnxoOuNCCA0OuhbNOC9tdrpj7ig=;
  b=LGP+knpBFMvEpf/3ffGvLO5apGUzAkiXdQikt2b8odFCs+y1MP8dhwkt
   FYS7/04lWfFoAywjhGmI8RPzloW3qtgAcea1Cx3NNo4gyaWXpqIjqeyIZ
   UBjvDA9g0IqmBWq98XTxTazDWYmm+p4Fvbj+o5Sh6d/MVXQkXdSeYAg2Z
   0+LaHh5FsvjlIiPPMpBvlkBoE+fovw3FHz1KY9pIn23HG5gMbLdqi7Mhx
   vs5Tuq6pK5Qc75NifhtXDGFMnxgkdZ8dc9JOYVzMCmErwCxc19Eha80t/
   MqQydhIrWySR3NGd3xUB3MzVuMGCwTJTTe3FH0peOuysdmSk4ZCKxA+sx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19591419"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="19591419"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 21:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1028638035"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="1028638035"
Received: from ubuntu.bj.intel.com ([10.238.156.105])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2024 21:47:08 -0800
From: Jun Miao <jun.miao@intel.com>
To: kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com
Cc: jun.miao@intel.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tdx: Optimize try_accept_memory() to reduce 1GB page accepted failed times
Date: Tue,  9 Jan 2024 13:48:24 +0800
Message-Id: <20240109054824.9023-1-jun.miao@intel.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the current TDX module ABI spec TDG.MEM.PAGE.ACCEPT Leaf show:
"Level of the Secure EPT leaf entry that maps the private page to be
accepted: either 0 (4KB) or 1 (2MB)".

There is not 1G page accept dynamically, if every time try to accept 1G
size but always fail, then cost more time from two cases:
	- When size < 1G, judge failed return 0
	- Really TDCALL<ACCEPT_PAGE> 1G failed when size >= 1G
So skip the 1G and optimize it to 2M directly to save time.

Run the eatmemory with different memories to get the cost time as follow:
	[root@td-guest ~]# ./eatmemory 8G
	Currently total memory: 100169027584
	Currently avail memory: 99901911040
	Eating 8589934592 bytes in chunks of 1024...

	  Start time：1704699207487 ms
	  End time：1704699222966 ms
	  Cost time: 15479 ms
  #
  # Compare with/without this optimization
  #
  # Hardware: ArcherCity Sapphire Rapids 128cores
  # Test eatmemory: https://github.com/jmiao2018/eatmemory.git
  # Detail test log link: https://github.com/jmiao2018/eatmemory/blob/master/log-tdx.txt
  #
  # Accept Memeory Sizes      Before(ms)       After(ms)      Trigger 1G Failed Times      Reduce Time%
  # ....................      ..........       .........      .......................	   .............
  #
		  1G                3414         3402                        751824        -12(-0.035%)
		  2G                3853         3804                       1015126       -349(-0.128%)
		  4G                7773         7561                       1557834       -212(-0.281%)
		  8G               15479        15173                       2633686       -306(-0.201%)
  		 16G               31527        30379                       4785649      -1148(-0.378%)
  		 32G               65058        63723                       9087686      -1335(-0.209%)
		 64G              133379       128354                      17693366      -5025(-0.391%)

Co-developed-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Jun Miao <jun.miao@intel.com>
---
 arch/x86/coco/tdx/tdx-shared.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx-shared.c b/arch/x86/coco/tdx/tdx-shared.c
index 1655aa56a0a5..1694b7eba93b 100644
--- a/arch/x86/coco/tdx/tdx-shared.c
+++ b/arch/x86/coco/tdx/tdx-shared.c
@@ -18,7 +18,7 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	 * Pass the page physical address to the TDX module to accept the
 	 * pending, private page.
 	 *
-	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
+	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M.
 	 */
 	switch (pg_level) {
 	case PG_LEVEL_4K:
@@ -27,9 +27,6 @@ static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
 	case PG_LEVEL_2M:
 		page_size = TDX_PS_2M;
 		break;
-	case PG_LEVEL_1G:
-		page_size = TDX_PS_1G;
-		break;
 	default:
 		return 0;
 	}
@@ -55,11 +52,14 @@ bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
 		 * Try larger accepts first. It gives chance to VMM to keep
 		 * 1G/2M Secure EPT entries where possible and speeds up
 		 * process by cutting number of hypercalls (if successful).
-		 */
+		 * Since per current TDX spec, only support for adding 4KB or
+		 * 2MB page dynamically.
+		 * /
 
-		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
-		if (!accept_size)
+		if (IS_ALIGNED(start, PMD_SIZE) && len >= PMD_SIZE)
 			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
+
+		/* The 4KB page case or accept 2MB page failed case. */
 		if (!accept_size)
 			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
 		if (!accept_size)
-- 
2.32.0


