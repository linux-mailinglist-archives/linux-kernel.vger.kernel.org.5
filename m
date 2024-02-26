Return-Path: <linux-kernel+bounces-82456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076368684C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BF1287745
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C746135A58;
	Mon, 26 Feb 2024 23:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKmUSclU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AE1E894
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991557; cv=none; b=t0xJF52DaffL8nMiS257jBwGLE1Kyap0+kHL5uzfnGxdg1cGusyaviz6cIdnti0UyLpmj0sqZeUH3SHeb7i54OFtyHHjBOjkYdVbQ6hbm6V5CqDGkxB4c/ss0QJLkf98t0g1m7VDRrfLXSAGP6JC+08C+X7kLAx1PsoH0o4s2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991557; c=relaxed/simple;
	bh=XIVySJ6fBrUqstD49rkPpA3Y2psGokotiQmfXjTagF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qZ6mIpuchOR89awBO0bkhCAjSOvpjh2Swd3TYShPlZ32vs7DnXNZrrDUfEiz/KCt16VVnPRmZQxPX2OSBrt199NSSFiAOkdbYPe1IcDDrJUEHoYEVS4b8mGte07ujVgbgnDP+INF6JIG8skehWOz4aWxKX9JafyR83JLUUl26YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKmUSclU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708991555; x=1740527555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XIVySJ6fBrUqstD49rkPpA3Y2psGokotiQmfXjTagF0=;
  b=eKmUSclUeXutWPjCmdUxo/PKMYZ5zh4wDlXnrlhGoTI6fgvJVcldNW/t
   geD2asjt0yNApa9/+Jtb9JSBg9TS+yEK74KEDdPmkaE4KN5d4455UmHIz
   KKl+8Ov0GBOHEbHaDvxa1fwUP0TeIS4jtVA0xcCNM/FzZiQBW2gZfC3sM
   2bbbrV6SruGBUAfocZswn3J322Bw00I2clCUTgL6Hr2W9hwdT7eX4c+3y
   +cWaEohXImGpyYe3FawuXEhX+7KaIXBG4449/hi/HNcPUoesecslF4Aae
   o+rTeR8FvdEUnChl0Ewe5d5qhxyQJ2gnozYSUXvZWS2hFSdPDqBS9j83z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3179668"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3179668"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 15:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11511965"
Received: from jhaqq-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.170])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 15:52:35 -0800
Date: Mon, 26 Feb 2024 15:52:33 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH] x86/bugs: Use fixed addressing for VERW operand
Message-ID: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAPAj3WUC/x2MQQqAIBAAvxJ7bsEszPpKdBDbbC8WK1gg/T3pO
 AMzBRIJU4K5KSCUOfEZK3RtA/5wMRDyVhm00oPS2mAmudFJwJ0fHCfjTK+s9cMGNbmEqv53y/q
 +H0StzMheAAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Macro used for MDS mitigation executes VERW with relative addressing for
the operand. This is unnecessary and creates a problem for backports on
older kernels that don't support relocations in alternatives. Relocation
support was added by commit 270a69c4485d ("x86/alternative: Support
relocations in alternatives"). Also asm for fixed addressing is much
more cleaner than relative RIP addressing.

Simplify the asm by using fixed addressing for VERW operand.

Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Closes: https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2aa52cab1e46..ab19c7f1167b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,7 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #else /* __ASSEMBLY__ */

---
base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
change-id: 20240226-verw-arg-fix-796a63088c4d


