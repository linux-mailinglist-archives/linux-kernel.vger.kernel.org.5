Return-Path: <linux-kernel+bounces-77166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2BB8601CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113B21F28D32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B312D215;
	Thu, 22 Feb 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAqOVzGt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794A73F3C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627185; cv=none; b=lnQ3ZPBnYR2RpXLBNATqzD+4pNxObM2soATyInsBCyojF8YloI4l+K0SeFBgK8rReqJdEHf8wkFqITwsV0rXNSj1+kihnc3WXCBSFJl9+VN5GhugQSSY5Z3KhmQeilovy0l/46GpoDL6Bo0/xjrU7pkSXv1WW8wtxrsdZzpvBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627185; c=relaxed/simple;
	bh=NH8Lr4ZEp+LyLCUOWjofEDWwYXC0tbCz8QJ2z7udv3U=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=tcMTAyF8soO31/ZJpyO6pNQRxLz8LOXACn04cb3BNLqZ52eXPiB1xN1zD5YCZqZHVMeiUf03l4sYAgI8khHn+DLTKMUaYvJ+BN16NmsT3p7LmxVpoao9YpJYMAhRupOa/M5LWbblVllL7CLVeMBtVc4kOSJjNHbcFO9TdVDRV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAqOVzGt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627184; x=1740163184;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=NH8Lr4ZEp+LyLCUOWjofEDWwYXC0tbCz8QJ2z7udv3U=;
  b=HAqOVzGt0q7bY+FM0ixHEfzeUWWvDh075m1sFdIf+Ay4ZOgRIaQJQqez
   6SY/fovWJToKhYYeAlmOe6fWiQyajQoXw2zox0e4c+L5IptgYcKvqlzEZ
   3kNRSSznld9cznk9MryrTIPNFcgkajDoV4svxBhZUzyBMm9EZ74LyYP0G
   x2Xv2WuyN7XFHFAybviadUS1oNZMaE18SlJbZjcTIeY8JLQsKpK4h+AY6
   HNJLoYnuOO7pFIKPUZEOlzMzXtzntTx5goEc2x1Ueh/e9Y34G0f3+rhDk
   gWhLOYSroPrTj02O/UwY+aAA0w+ZykL6nPrsJC0BkRnnK7Z7uN895/HB3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031777"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975494"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:43 -0800
Subject: [RFC][PATCH 12/34] x86/cpu/intel: Actually use "address configuration" infrastructure for MKTME
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:42 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183942.601EE2E5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Now that the TME detection is only called once at boot, stop twiddling
'boot_cpu_data' directly and move over to 'bsp_addr_config'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/intel.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff -puN arch/x86/kernel/cpu/intel.c~intel-addr-reduce arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~intel-addr-reduce	2024-02-22 10:08:54.296682462 -0800
+++ b/arch/x86/kernel/cpu/intel.c	2024-02-22 10:08:54.296682462 -0800
@@ -401,11 +401,8 @@ detect_keyid_bits:
 		mktme_status = MKTME_ENABLED;
 	}
 
-	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
-	 */
-	c->x86_phys_bits -= keyid_bits;
+	/* KeyID bits effectively lower the number of physical address bits */
+	bsp_addr_config.phys_addr_reduction_bits = keyid_bits;
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
_

