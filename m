Return-Path: <linux-kernel+bounces-85835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E1486BC02
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5E92851DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250513D303;
	Wed, 28 Feb 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th4ZCR6T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A913D2F2;
	Wed, 28 Feb 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162049; cv=none; b=lBj7KDD0Wt02n1Kzg+A0n/uRtHxZB2QEcqWrrhMyS07OydD6GqcNHTBOUiI3ViwFT3tEvceKxABrtcQTTI/VUy+8imz8qEJAFWXUGVLkT+0aRc3SXSzCURrmG5iRXr8p6SLsBetsLW/0IT6KKyA6VhCb5LeN9Psvrr/ppxAp0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162049; c=relaxed/simple;
	bh=9zjdHyxAIafTdj9D6iu5/FFeCEFFi2NSkV3RY2SOaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4pEwLHpy5S9HOoX/b4FpKi++Y+EX1sue77gMVJLc1EJk42ae1lvX82Yo3NwPC5LeUPZy3T7Iv2MFEjAj8LGKW17Bn8tnFYJ5ufaBOua3LkB6K9kZuu6yYO2mLDcY5VTw/FN45uCXDClYzDCeznkSAnapWvzhEcPuH3GpW1znsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Th4ZCR6T; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709162048; x=1740698048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9zjdHyxAIafTdj9D6iu5/FFeCEFFi2NSkV3RY2SOaCA=;
  b=Th4ZCR6T4FiM2pDtSWE8CyfaAIYktZlDCyMruYz4v2u1Q0cAZZiGq/zD
   KY1F4wQ0p6yftG+mdIF5xLu6fnEuHOMXSmSGdjmidv03cUhAgCHHZlhUx
   x6g8+/4UIwfS7seNOv2Q4p0DgCyHTnt84oH16+vLD0mH7PAvHVxpWLauU
   OQmKofHKzTMyJF/cahPF1GfEUaXn7VD1irC/zFX/Uf6GjDgftIliw1ciY
   vZancQeG9VgtW2EGNMsmlB5suEQBCOgOK4rJ0BY9hhwPTOh92DiNjOgzN
   Y3fnJw7H1ZGIMqSXU5p4ADqUuNAjE6MB52tmD/yVs1gAU768jX//Y1zKB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="26066302"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="26066302"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:14:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="30773949"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 15:14:05 -0800
Date: Wed, 28 Feb 2024 15:14:04 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: [PATCH] x86/mce: Dynamically size space for machine check records
Message-ID: <Zd--PJp-NbXGrb39@agluck-desk3>
References: <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>

Systems with a large number of CPUs may generate a large
number of machine check records when things go seriously
wrong. But Linux has a fixed buffer that can only capture
a few dozen errors.

Allocate space based on the number of CPUs (with a minimum
value based on the historical fixed buffer that could store
80 records).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Discussion earlier concluded with the realization that it is
safe to dynamically allocate the mce_evt_pool at boot time.
So here's a patch to do that. Scaling algorithm here is a
simple linear "4 records per possible CPU" with a minimum
of 80 to match the legacy behavior. I'm open to other
suggestions.

Note that I threw in a "+1" to the return from ilog2() when
calling gen_pool_create(). From reading code, and running
some tests, it appears that the min_alloc_order argument
needs to be large enough to allocate one of the mce_evt_llist
structures.

Some other gen_pool users in Linux may also need this "+1".

 arch/x86/kernel/cpu/mce/genpool.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index fbe8b61c3413..a1f0a8f29cf5 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -16,14 +16,13 @@
  * used to save error information organized in a lock-less list.
  *
  * This memory pool is only to be used to save MCE records in MCE context.
- * MCE events are rare, so a fixed size memory pool should be enough. Use
- * 2 pages to save MCE events for now (~80 MCE records at most).
+ * MCE events are rare, so a fixed size memory pool should be enough.
+ * Allocate on a sliding scale based on number of CPUs.
  */
-#define MCE_POOLSZ	(2 * PAGE_SIZE)
+#define MCE_MIN_ENTRIES	80
 
 static struct gen_pool *mce_evt_pool;
 static LLIST_HEAD(mce_event_llist);
-static char gen_pool_buf[MCE_POOLSZ];
 
 /*
  * Compare the record "t" with each of the records on list "l" to see if
@@ -118,14 +117,25 @@ int mce_gen_pool_add(struct mce *mce)
 
 static int mce_gen_pool_create(void)
 {
+	int mce_numrecords, mce_poolsz;
 	struct gen_pool *tmpp;
 	int ret = -ENOMEM;
+	void *mce_pool;
+	int order;
 
-	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
+	order = ilog2(sizeof(struct mce_evt_llist)) + 1;
+	tmpp = gen_pool_create(order, -1);
 	if (!tmpp)
 		goto out;
 
-	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
+	mce_numrecords = max(80, num_possible_cpus() * 4);
+	mce_poolsz = mce_numrecords * (1 << order);
+	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
+	if (!mce_pool) {
+		gen_pool_destroy(tmpp);
+		goto out;
+	}
+	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
 	if (ret) {
 		gen_pool_destroy(tmpp);
 		goto out;
-- 
2.43.0


