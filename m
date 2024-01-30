Return-Path: <linux-kernel+bounces-45386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BEA842F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D91F25AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9D678699;
	Tue, 30 Jan 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpwyNST5"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6146F08E;
	Tue, 30 Jan 2024 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653248; cv=none; b=VHUmYWgHma8UjlO4fb38nqpvXLTOz9uITTqjB2wLre8W1ZIbLD2bUWWAMiWdxvoTlBcxNk4fO96G4RpoG5CDCHCMb+rlx4kGze2k3dg3NSlnItkZ3b4a/JtDdsUYp9DS3q6hZnhUBWc/Bys1XGdxveC9MMnE++aNytfwNyGyn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653248; c=relaxed/simple;
	bh=4+Sl+NwFbXMo1a6gRDqTKEVyh7WFVjJ+Uv+TU1KbyG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXAUvkktI2uypnrRUgt1ByoanZEvkZ1d+SKDvwGG9kmyt1HvR7ybywgAQ5zOeFymLzzuCW4RmOJ7fRs+6Rssvbzs3wYEjVB6FUh0tZW3n09dxbPr1T+l93Mr5U8SeeONkvaKA5+qvhvWWdv5Ga6Z5P49jmUbeW8cAYV/1vH7xiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpwyNST5; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706653246; x=1738189246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4+Sl+NwFbXMo1a6gRDqTKEVyh7WFVjJ+Uv+TU1KbyG8=;
  b=bpwyNST5RPE33+tfIJuKHNSwe9DFzAjfhV3Qpi26TiNWpLZNvDMJHOfr
   NM0lsThtKBG5pEQA0ex7mQzU3fSvSDOosBA51u2/ku6q6xGJnVitAnA6u
   HQDqmo/q/rHbynPIC8UjAaTkU7wADKd6q0grkkF9DTTywFZVnxFfuEBj5
   21M7FBYa6U0JHaNOoM5+7qucv1ygdkWExO5raxX4VaQa4luXDtbopViau
   AkB7cm8gf9kMnIR6LaQ4InA92OKWF0hhHdtaiy6Gtj/ElRI7wi+AKP1Gg
   6x3o/RaJ/o/q+DoYUOqVTGXF5UckA0CToBfX3X+sfi2gvmXHIRVQK5oJ8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403041757"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="403041757"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119412847"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="1119412847"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:42 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v15-RFC 4/8] x86/resctrl: Add helper function to look up domain_id from scope
Date: Tue, 30 Jan 2024 14:20:30 -0800
Message-ID: <20240130222034.37181-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130222034.37181-1-tony.luck@intel.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for more options for scope of resources. Add some diagnostic
messages if lookup fails.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d89dce63397b..59e6aa7abef5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -499,6 +499,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 	return 0;
 }
 
+static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
+{
+	switch (scope) {
+	case RESCTRL_L2_CACHE:
+	case RESCTRL_L3_CACHE:
+		return get_cpu_cacheinfo_id(cpu, scope);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 /*
  * domain_add_cpu - Add a cpu to a resource's domain list.
  *
@@ -514,12 +527,18 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
  */
 static void domain_add_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->scope);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct list_head *add_pos = NULL;
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 	int err;
 
+	if (id < 0) {
+		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->scope, r->name);
+		return;
+	}
+
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
@@ -564,10 +583,16 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 {
-	int id = get_cpu_cacheinfo_id(cpu, r->scope);
+	int id = get_domain_id_from_scope(cpu, r->scope);
 	struct rdt_hw_domain *hw_dom;
 	struct rdt_domain *d;
 
+	if (id < 0) {
+		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
+			     cpu, r->scope, r->name);
+		return;
+	}
+
 	d = rdt_find_domain(r, id, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
-- 
2.43.0


