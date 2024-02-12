Return-Path: <linux-kernel+bounces-62404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8C4851FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097731C2256E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C754CE06;
	Mon, 12 Feb 2024 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdU4dDrF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697546453;
	Mon, 12 Feb 2024 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773833; cv=none; b=FH0JNM82O9PTiKLE0I1mU0aKhABXegKrv6irHpfFx5Mnno9h8yAanv5B8fE2+0/OIK/fmzpHOy5Y/8omtqfYpPwBfNqIYlJg/ugfIOuKJxTkKmNeC+lCT/hr9nzkyAYOV2nH0vR7+FXizgKG91yKlTDx1R0anvTTGHafDQlt9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773833; c=relaxed/simple;
	bh=nbPBW+LVdPgWVpFKe00QQCTZhOf+yrh6eERXbHsxeCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3464Y2NiMMjrlIMDSF/raklcOkNPEPjXOVf1ynxY0n/bxavqcGbOn8Cp7v2nrWdyNEmuFW2ley5dnwQ8bzIB3XN0MW/a7yvEzB9c0N80z6xz+6XOZ4l/lNr+80RUX9767h3ViUWwNPwzBphD8LqPIaQVlbuSaeIiQ6j6fop3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdU4dDrF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707773832; x=1739309832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbPBW+LVdPgWVpFKe00QQCTZhOf+yrh6eERXbHsxeCQ=;
  b=fdU4dDrF9CWnKt0wsyhsO1bDZAg2NyntRL2Yu0kcIAU0a5MCz6jIbovZ
   Q/9qq9hNerarnQ2FYe3ZII6ryf6/tDdSYmx7Na+St9aJKeUDrZdAxAnUf
   eYN4SmzMXckQyAmQKdCbJnm+YXnJEpyY37Eh41lt/YOG+OERXMomXvJtw
   pThQghwDK81Xv5vRpPMza9gIpayQGHCb5NEy58upfvsDG69qH/4eEMIXn
   aul89eHAIQgJHk7WU4Bc0l/I7v/AsAP620KM//YbzpKhbyRCHGToI3Heb
   dhvBctsvlUTmVidNE8AzYYvFdinCDlFQnn2+mdIaHcNPTHmxdlyV95kf4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1895537"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1895537"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:37:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7329489"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:37:10 -0800
Date: Mon, 12 Feb 2024 13:37:09 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <ZcqPhVO_DtD2x5N7@agluck-desk3>
References: <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Feb 12, 2024 at 07:41:03PM +0000, Luck, Tony wrote:
> > It needs a proper explanation why that's ok rather than an empirical
> > test only.
> 
> start_kernel()
>    ... setup_arch()
>        .... acpi stuff parses MADT and sets bits in possible map
> 
>    ... arch_cpu_finalize_init()
>        ... calls mce_gen_pool_init()

This made me question the "we don't have an allocator in
mce_gen_pool_init()". Because if we got through all the
ACPI stuff, we surely have an allocator.

Below patch doesn't explode at runtime.

-Tony

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index fbe8b61c3413..81de877f2a51 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -16,14 +16,12 @@
  * used to save error information organized in a lock-less list.
  *
  * This memory pool is only to be used to save MCE records in MCE context.
- * MCE events are rare, so a fixed size memory pool should be enough. Use
- * 2 pages to save MCE events for now (~80 MCE records at most).
+ * MCE events are rare, so a fixed size memory pool should be enough.
+ * Allocate on a sliding scale based on number of CPUs.
  */
-#define MCE_POOLSZ	(2 * PAGE_SIZE)
 
 static struct gen_pool *mce_evt_pool;
 static LLIST_HEAD(mce_event_llist);
-static char gen_pool_buf[MCE_POOLSZ];
 
 /*
  * Compare the record "t" with each of the records on list "l" to see if
@@ -118,14 +116,23 @@ int mce_gen_pool_add(struct mce *mce)
 
 static int mce_gen_pool_create(void)
 {
+	int mce_numrecords, mce_poolsz;
 	struct gen_pool *tmpp;
 	int ret = -ENOMEM;
+	void *mce_pool;
 
 	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
 	if (!tmpp)
 		goto out;
 
-	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
+	mce_numrecords = max(80, num_possible_cpus() * 8);
+	mce_poolsz = mce_numrecords * ilog2(sizeof(struct mce_evt_llist));
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


