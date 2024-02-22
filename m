Return-Path: <linux-kernel+bounces-77164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3718601CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631FD1F28BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128FC73F36;
	Thu, 22 Feb 2024 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TK4MxH1A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66373F00
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627182; cv=none; b=Hn7MzfpHvTmPpWOdcabnRACtTpoXMWAtYhdIn1h+WmKGGRJyVeMozIGLDuyvQEXyZSnz6ozg7P7fSn7iU+xjzB2t7wI65bNMt5u/x8mXa+YHi1cXLW+SdTfZPdUd9sI/LVzlf8DPgGAx03HizRail7cmHgpcwktnNajs3TF7pSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627182; c=relaxed/simple;
	bh=QA4nL+IB5LTiCN1WiRhJJReXahalUQ3SRSOkHWOGUt8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Dcp1cUC5P4IARULEctqMd1bJVXFug561eo/5XuFBjw3eRgiaHdxEqql785mym/fZq4DQTVfSUZKwNoZmtteM9sh4mNLFZEEsK3lI0NZQWKRvJAVigGHEim+KRMhItepwHUqyHosY9j2AJwZkG59zAplJ0Ty3q3F/U+ScOwXGY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TK4MxH1A; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627181; x=1740163181;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=QA4nL+IB5LTiCN1WiRhJJReXahalUQ3SRSOkHWOGUt8=;
  b=TK4MxH1ACISlPqEmR1W6iiTwv/3nrkrtpcK3fiNCXXm/khZ3+SXn2Egz
   FdUl4jhieZv1V7FiyjSgUjxu7Xz0bWp//AlhZTeH0tnVhV/pLoPCpZlVo
   5IS3XMzPR2VfyCQ9qalSMlxFmQNDz7q5T6G8Xq0MGY11K1qvjOqONzzIy
   NciDktEfrGVQeWHSrVbAAdBPveG/uxMQ+tQT+SE58wCVqNuAN11FNiOcI
   ikklbMILa6+DFrefswLiRO6S2Kq4xxRSI/nC+IVdPQKvHprL/A5Cl20J9
   IJdvi0+VhlH+Aopo9gOnbrCrv1RX0vaBAx6ZLgeto2jPr/eRFdicMKy6m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031759"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031759"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975474"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:41 -0800
Subject: [RFC][PATCH 10/34] x86/cpu/amd: Use new "address configuration" infrastructure
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:40 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183940.4F44A1FF@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The AMD memory encryption code is currently one of the 'boot_cpu_data'
field twiddlers.  This has led to all kinds of interesting ordering
bugs at boot.

Move it away from random fiddling and over to 'bsp_addr_config'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/amd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/amd.c~amd-phys_addr_reduction_bits arch/x86/kernel/cpu/amd.c
--- a/arch/x86/kernel/cpu/amd.c~amd-phys_addr_reduction_bits	2024-02-22 10:08:53.340644930 -0800
+++ b/arch/x86/kernel/cpu/amd.c	2024-02-22 10:08:53.344645087 -0800
@@ -622,7 +622,8 @@ static void early_detect_mem_encrypt(str
 		 * will be a value above 32-bits this is still done for
 		 * CONFIG_X86_32 so that accurate values are reported.
 		 */
-		c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
+		bsp_addr_config.phys_addr_reduction_bits =
+			(cpuid_ebx(0x8000001f) >> 6) & 0x3f;
 
 		if (IS_ENABLED(CONFIG_X86_32))
 			goto clear_all;
_

