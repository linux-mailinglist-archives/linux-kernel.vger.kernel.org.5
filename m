Return-Path: <linux-kernel+bounces-106902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A6587F52E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8191F21B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673665BCD;
	Tue, 19 Mar 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfDqQdyd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBCE65BAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812951; cv=none; b=J1ApnT5Dbzmnk+wfNx7GaDEcDDdvhrgxpSME2dwRmhhMEWw945PX8x7bPQO3fhOTc2LOFuwXSaLviPYGP5sP/pYgiyboFEfbjvlbCMfvyqAXivtbD8rCRcypfqckvlao/XR7w3HCap3cLrp8ODtqOWL7BBxssquzbHoi5v7HrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812951; c=relaxed/simple;
	bh=MNoeTtcQYX9pC2/kmVoMbgA9lvpq5nltcpL+l2VqpG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvcByHMqsz+qzNGRiTCKCJf6pyg0HXCiH5otTmNn6W6MCsUVT0dqtHQU+1DAmtz2hyu0pT1MgY2y1iELNUzzJXRj2m0msbhDS+saFGLf0B7iexhJ/8KJukLc4cVlS4As5Db9/hHfctvfryxJY4pEe77yrC7VP9PkfyfgEP/J65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfDqQdyd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710812950; x=1742348950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MNoeTtcQYX9pC2/kmVoMbgA9lvpq5nltcpL+l2VqpG4=;
  b=WfDqQdydJKvVyToz/Lag8WIWrNU4jHjQ1mffOImj7NicRdYA3ze5kPOQ
   TSKYY5ZdtKZ9hoN+TqHkNU5tD3mSIfKgwWmzxdAIG/lvRAjX62O/DWJjn
   4izAApUWCrFK+FSwQW8x9rlJgj9CnwO6dU+km1idgwG1em9/uh2sb2U+R
   94Rn029WKO7oVnRzXLQ+NxuhLJIbJF1rqopDZ/vxqfrcNEYM7acb29T/l
   o2FdHl/C+b1h2oedo9N4FNAsnwdCcWiHqPW7kOzBC64SNriMBUeG2VsyT
   KzGwUqIcyqb1hi2ZGAajl3+p7jCCtXFgXdtQunsD3Nymaou015xVyjtrR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5776918"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5776918"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13697354"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:49:06 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v2 4/5] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Tue, 19 Mar 2024 01:48:47 +0000
Message-Id: <fd4ee99ea60e17ab3075f7991e9e2321d0a67196.1710811610.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710811610.git.kai.huang@intel.com>
References: <cover.1710811610.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now TDX host can work with kexec().  Remove the !KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e88f6f7b6b41..89b65e2e1115 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1970,7 +1970,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.34.1


