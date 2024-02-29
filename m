Return-Path: <linux-kernel+bounces-85914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF9286BCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CACB1C221CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFCF107A8;
	Thu, 29 Feb 2024 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsa10gvd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123C7FE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166007; cv=none; b=d4d7KMXFtNAM1CWqMXyjp4O+kfP0InOAQeDU1hsk1UIPlDqDIa0fttY2c3aSNk6P9X+Hh/p/Wjx0w2VqpBZK5R+qefVVZC0z2VnF89Z6QZrW/D512E40cwsvf5fDI5dqhdqImlb4nvCTf51P0asuHsihDSjR04eMO9R8/yKlc8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166007; c=relaxed/simple;
	bh=WP9vvbV2njaVQ8t02r3r/YNcGX7SRKU79ihqdWRNDkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6ci/PfTrviFVtKKgNMUULvCvGDrWriZj9I+qA+I3DqW5XrEhJuVOPH8y+OCP4Jb2JWkTMCnxx7Y+e5DiVDFlRkHeUZDvcPOb8j31X5o8LYpl9PdooyG8q++d12knwkL7VazoSKBD7rhw8uIn1wCO0P272JBOWdbkkRPtURC8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsa10gvd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709166005; x=1740702005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WP9vvbV2njaVQ8t02r3r/YNcGX7SRKU79ihqdWRNDkM=;
  b=nsa10gvdVvnxt8tj8NKhW+QJSqYy0EtqpkOF38hRhm+h3XgEIPvETLV9
   WUyKaJU6kKPliZer7oI6fJqHFfpo9ESIL2ZN+EiGn1m7Hi2AlgnCldVmC
   KAnmttBgG1Si0l+kUyE2RlxLDXtFQwKDH/we4AbPLvOpiuSfalmx0Fj+m
   ZCk7eA/St614gg7yW23xP8l9zPeGVq+VavbayvsHmkoQtRdTA7W2o2xhi
   FAnPUyTOyLtRgSjgMtUFesoOPQUnk+Xcy9oqQbuFjMZt+y0NIjuofsm3n
   S1fmE/lZ1pDsRhzFO1Q2yKmohTzmOTfcY36WwNNciEwiySIRiKCHbkkTz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14245922"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14245922"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:20:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12275188"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:20:05 -0800
From: Andi Kleen <ak@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3] x86/mtrr: Check if fixed MTRRs exist before saving them
Date: Wed, 28 Feb 2024 16:19:52 -0800
Message-ID: <20240229001952.325275-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTRRs have a obsolete fixed variant for fine grained
caching control of the 640K-1MB region. This fixed variant has a
separate capability bit in the MTRR capability MSR. The MTRR code
checks this capability bit before trying to access the fixed MTRR MSRs,
except in one place. This patch fixes this place to also
check the capability.

Otherwise there will be a WARN_ON when the respective MSRS don't exist.

Fixes: 2b1f6278d77c ("[PATCH] x86: Save the MTRRs of the BSP before booting an AP")
Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Add Fixes tag and expand description.
v3: Expand description
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


