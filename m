Return-Path: <linux-kernel+bounces-45387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B46842F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A8828790C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB878B76;
	Tue, 30 Jan 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvikW4Vn"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49FD762DD;
	Tue, 30 Jan 2024 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653248; cv=none; b=VRnHvl3c7XInZj6ZjYvTy2rE3KmXMhz2oStQLdssPAGiALoNGTA/HGvFKY7LCxRpM+FpMiWAMQDr4yrzvZ/dOscV5cRO4Zv/LFSXUyjrNoVqpNYIJ6oL/fYbem7e0eBYuwLU7Djlom3a53sHazLSbm0RHrM0ZmMaewMTHyOa0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653248; c=relaxed/simple;
	bh=e1U36HnQRGJev5PeIToOOlwXKxHkepDX5Nu7sz6o/IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USmDrHpkYSl7TG8i0PPFWpyFpIbSX0bItAleM3bmutU4t1zVT0GBN0QBr32uQCAmGn4PqXUat+FpLUB+e+f5+mtVVQrWxcw878BLx14MpG15NNWXPGVE7n4OcVpWE89Nqo1rPeNK66wjhEpYpNzANSZMn02KatfwJDydxV0CWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvikW4Vn; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706653246; x=1738189246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e1U36HnQRGJev5PeIToOOlwXKxHkepDX5Nu7sz6o/IU=;
  b=fvikW4Vnk036nODM9ERbvF4Ovr4oz0omwKo3QQzYMIDVqHcm5l/FTwC0
   f/m8U2mZggWS3ydP5DdBGrpBtwnwfHuawRVokehA3ieVQ00+/5wjAyh6W
   BBoANwsFFL0FopJZinC9o2Ull1mTrNm7L0H5jYTSZIXJiabAytXa+2zx2
   Nj/YsWsQnfdrPFVqyPSwOE/eO/sixKQzHozc+3pimooQBBHJkq3D9KBTL
   C8dlaovg04izVXZXh2ySkwQsNX+XxgYBh0RKII88Fbl/bHkHBCXqSMKZS
   EdHirtWrVGSHZ4ouvNTbvsgDx2SAzgsCh+enptKbetrtAU3q9ji7ENG14
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403041769"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="403041769"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119412850"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="1119412850"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 14:20:43 -0800
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
Subject: [PATCH v15-RFC 5/8] x86/resctrl: Add "NODE" as an option for resource scope
Date: Tue, 30 Jan 2024 14:20:31 -0800
Message-ID: <20240130222034.37181-6-tony.luck@intel.com>
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

Add RESCTRL_NODE to the enum, and to the helper function that looks
up a domain id from a scope.

There are a couple of places where the scope must be a cache scope.
Add some defensive WARN_ON checks to those.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/resctrl.h                   | 1 +
 arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2155dc15e636..e3cddf3f07f8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -147,6 +147,7 @@ struct resctrl_schema;
 enum resctrl_scope {
 	RESCTRL_L2_CACHE = 2,
 	RESCTRL_L3_CACHE = 3,
+	RESCTRL_NODE,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 59e6aa7abef5..b741cbf61843 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -505,6 +505,9 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
 	case RESCTRL_L2_CACHE:
 	case RESCTRL_L3_CACHE:
 		return get_cpu_cacheinfo_id(cpu, scope);
+	case RESCTRL_NODE:
+		return cpu_to_node(cpu);
+
 	default:
 		break;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 6a72fb627aa5..2bafc73b51e2 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -292,10 +292,14 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
  */
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
+	enum resctrl_scope scope = plr->s->res->scope;
 	struct cpu_cacheinfo *ci;
 	int ret;
 	int i;
 
+	if (WARN_ON_ONCE(scope != RESCTRL_L2_CACHE && scope != RESCTRL_L3_CACHE))
+		return -ENODEV;
+
 	/* Pick the first cpu we find that is associated with the cache. */
 	plr->cpu = cpumask_first(&plr->d->cpu_mask);
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index eff9d87547c9..770f2bf98462 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1413,6 +1413,9 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
 	unsigned int size = 0;
 	int num_b, i;
 
+	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
+		return size;
+
 	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
 	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
 	for (i = 0; i < ci->num_leaves; i++) {
-- 
2.43.0


