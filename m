Return-Path: <linux-kernel+bounces-53955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A25684A86F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEE3291BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667614D456;
	Mon,  5 Feb 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cO5bliHZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F9149006;
	Mon,  5 Feb 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167211; cv=none; b=CSGEDOf3lgvCszfqz6bS1xbsHFDuFs5zT9hm+ey6VdQrF+4P10e78N0HCbe3WwvLFqSqneZ3VQAIuUzRD4c8yljOlQGcE2tXsYaF/RBr92gNZ1ke48wyve8Tt7VG3yQbm5FM94yZvIAz0dkE3F782bwnbf49hF6v0rdcvjGU8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167211; c=relaxed/simple;
	bh=+6Ns9oQIF1CxesoJTVyqB/7qXvihE0bprLTbvHVisAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLcemBpoCdC7a5jXcrTOqFSCNA7bs/IiqpJG8RD/Y5OujI56Rnx+qZvDJ/iN4IeS6nHXDhZRRoqyvoCPhCfsVW3btHPQCyA37EIUv613Yv7fApRexa9oKt4AZHfE4ml0C7LxEUNqVSoYdLx8RZHeYEh0gxUlTRPZQt067M54b4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cO5bliHZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707167210; x=1738703210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6Ns9oQIF1CxesoJTVyqB/7qXvihE0bprLTbvHVisAM=;
  b=cO5bliHZt3VdsQ3uivzI8IdDqktj5xHuD4frB69xI6K01HQ0wLFPJZHF
   tvKRhlK81FyrYvhYk3nEHLu8i2+OLQ9WPVQ8OgooyHc1qIKU8S/JVrPSF
   v1H56apiTcIIukJkox3Ltyh0fDCuWk+uMMhpHA2vn6UdimT1G/gwEJal/
   MASomMwGrxEJ3mFSL0ZxoTnK1r/rZPK/iASzlUixl6rsrP9wVaewyXkNk
   EyMosrWnfUUI3rOOs7Wd6Q8Ra75ZRyvtshuUAa2sA50GdxpcqNHXav+r9
   qnchHSHUlwgilfnaI9KdDOA8SQ36GZleZsz7wj/8jQBus1tY6YMeqeV/G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11960465"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11960465"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="38245648"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa001.jf.intel.com with ESMTP; 05 Feb 2024 13:06:42 -0800
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v9 12/15] x86/sgx: Expose sgx_epc_cgroup_reclaim_pages() for global reclaimer
Date: Mon,  5 Feb 2024 13:06:35 -0800
Message-Id: <20240205210638.157741-13-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205210638.157741-1-haitao.huang@linux.intel.com>
References: <20240205210638.157741-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

When cgroup is enabled, all reclaimable pages will be tracked in cgroup
LRUs. The global reclaimer needs to start reclamation from the root
cgroup. Expose the top level cgroup reclamation function so the global
reclaimer can reuse it.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
---
V8:
- Remove unneeded breaks in function declarations. (Jarkko)

V7:
- Split this out from the big patch, #10 in V6. (Dave, Kai)
---
 arch/x86/kernel/cpu/sgx/epc_cgroup.c | 2 +-
 arch/x86/kernel/cpu/sgx/epc_cgroup.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.c b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
index abf74fdb12b4..6e31f8727b8a 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -96,7 +96,7 @@ bool sgx_epc_cgroup_lru_empty(struct misc_cg *root)
  * @indirect:   In ksgxd or EPC cgroup work queue context.
  * Return:	Number of pages reclaimed.
  */
-static unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
+unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
 {
 	/*
 	 * Attempting to reclaim only a few pages will often fail and is
diff --git a/arch/x86/kernel/cpu/sgx/epc_cgroup.h b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
index d061cd807b45..5b3e8e1b8630 100644
--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.h
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.h
@@ -31,6 +31,11 @@ static inline int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool
 static inline void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg) { }
 
 static inline void sgx_epc_cgroup_init(void) { }
+
+static inline unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect)
+{
+	return 0;
+}
 #else
 struct sgx_epc_cgroup {
 	struct misc_cg *cg;
@@ -69,6 +74,8 @@ static inline void sgx_put_epc_cg(struct sgx_epc_cgroup *epc_cg)
 int sgx_epc_cgroup_try_charge(struct sgx_epc_cgroup *epc_cg, bool reclaim);
 void sgx_epc_cgroup_uncharge(struct sgx_epc_cgroup *epc_cg);
 bool sgx_epc_cgroup_lru_empty(struct misc_cg *root);
+unsigned int sgx_epc_cgroup_reclaim_pages(struct misc_cg *root, bool indirect);
+
 void sgx_epc_cgroup_init(void);
 
 #endif
-- 
2.25.1


