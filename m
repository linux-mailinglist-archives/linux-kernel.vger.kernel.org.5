Return-Path: <linux-kernel+bounces-18070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8E825851
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE79A1C233AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE85328D7;
	Fri,  5 Jan 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPcTdpyM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77A328B3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704472638; x=1736008638;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nNShzR6tVlt8MP2GEm4twbSrn0rdHKZew4twsigGRgc=;
  b=iPcTdpyM5oDb3a9mJ9Wwa7KTc9/1yj5pV+pzMgzW2X6E+3IUPYTJrcqW
   ZAGGKgjKRTX40rZ0c5Lul7JTyZcvgRL7V8NrLKLPDdoRAtHbH/99CUs4U
   BdS0R+BdozZhC/vzcbwQ5QBmcSSCtKEQjL1zso621RXTzxMDjTGiCO3EQ
   uzuaOw5lgITxrYQ5oiYeGuj9mzWch7CNYRNVn9qU4AH5VbHL45nW6adZf
   WToPgcFgfeVtUy3ui4jDre2zfMBtwv60DUsYiWNL+qtL6pmx0slwbthja
   ZzmSlgbneg4J8DHcSRjMHH5tjoUehdh+97z1AeuYYHWzfVeAtQAhycdgJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="463931765"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="463931765"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 08:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="953991189"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="953991189"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 08:37:18 -0800
From: Andi Kleen <ak@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86/mtrr: Check if fixed MTRRs exist before saving them
Date: Fri,  5 Jan 2024 08:37:11 -0800
Message-ID: <20240105163711.9278-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This one place forgot to check the fixed capability.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
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


