Return-Path: <linux-kernel+bounces-22395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C903A829D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9A91C21B07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A04BA9C;
	Wed, 10 Jan 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hk/G1Yyg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A94BA85
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704899296; x=1736435296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sHwp7FLzZIlG5HFYdgHfqqle8SLGS8mrA0XxzJMtOUU=;
  b=Hk/G1YygGc3Lw1kYm84PJIaJNGJ2OJUSjaHeF/FP6Ba2r0B/8P2dU3WW
   NeJouDLUU52C2wYM9qxX01hWnvSnfoEB9Nt67K4JJpRuygLyw4OSWw2eR
   B7eHFQQzP4CAveEgLcyAmdPJXdYn39pWXUyDGUdlZXGeqj++2DMwUvgaM
   LdKqoApcXK6KU25v/VgGxj9XS0U+F2XvEPWwfYF9CFlV0+rgvgEIB+hTj
   AEKElmaN5Gv5HGntuL96JMrsv2p49WpKF6JyEi8LX4jb54vQ9z9hOL9/Z
   /+XBSNBBqPIXcbF2n01R+NpRoYMp8z6GaPzOV/7cxGfUHOTMWq+/ohE1h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="5904720"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5904720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="872673036"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872673036"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:08:14 -0800
From: Andi Kleen <ak@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] x86/mtrr: Check if fixed MTRRs exist before saving them
Date: Wed, 10 Jan 2024 07:08:06 -0800
Message-ID: <20240110150806.22531-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This one place forgot to check the fixed capability. Otherwise there
will a harmless but ugly WARN_ON for the failed WRMSR when the MSR
doesn't exist. Noticed when testing X86S support.

Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before")
Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Add Fixes tag and expand description.
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 767bf1c71aad..2a2fc14955cd 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -609,7 +609,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
-- 
2.43.0


