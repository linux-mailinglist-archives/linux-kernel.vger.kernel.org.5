Return-Path: <linux-kernel+bounces-37026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714FC83AA62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121FCB2A4B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12877F17;
	Wed, 24 Jan 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pc8TIJ31"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BF7764D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101010; cv=none; b=UkyNz8dQl74V2+DvIjnQAH65qaNdF7KxvsZJX0vxNBvHLEuwvFPuHItxC8sf+iKv56hI0e6kSZGxRZiFMCMRN2ow03EGO8yX0ais/g6Cg3cIGUS57UBbTzwNKbck3Kzq0QD1JGAXbAN7448Nb5Eo2m1jCM81DEvHjN74mc5GBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101010; c=relaxed/simple;
	bh=9DcFlB+EMYNkp2N6OZv2c5TmDu3Stsj7JMO1CUBiP2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWWLcs1Uqlbv/n5NprB0IrV2xhy7IXUU5OzpfLlGIkjZUlM971zWCGj+9WMmuUl9nm+Pk+gmfN7X/7TKAPVYgX/sepLw85RefQhTugerPdayE6drZkjpNSaMrvRZWrNjns82xYP4v4RVlRgv/yOrt4rv9XeAOeyRDret7fkxDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pc8TIJ31; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101009; x=1737637009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9DcFlB+EMYNkp2N6OZv2c5TmDu3Stsj7JMO1CUBiP2Q=;
  b=Pc8TIJ31qVbah25xFEwGy7iqcsZ8H+iRL3HJ5ywgFdVZn8CMadZJtypS
   RPDuhLL+35OBcnNuGUGBfCiPTbgVkU9oMPhx4q7hN9yPNKVThCVlPar27
   f0IRQn85wvTuMMpjj93AFID6y4Y74rilNJT7+3HXqps/NHfEjH+/+ENpj
   sIVzSDyDwsM6RKdRJAM8i8x9mGlswxmbB1W1rDbAYf/+Af5pnZHUA+V7K
   rLqJxCcE9R8T00Jg6XT4bJR1CgwuFATq2hxn3MH13gjxT6oguZMo5R1Eg
   ngGFuNtd/RHyM7qlp9TuKKZoLh40pcdhfC1preXWqsjBlGASpxPc3pdhc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466110045"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466110045"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735924057"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735924057"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 04:56:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A7DA89EF; Wed, 24 Jan 2024 14:56:02 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 11/16] x86/mm: Make e820_end_ram_pfn() cover E820_TYPE_ACPI ranges
Date: Wed, 24 Jan 2024 14:55:52 +0200
Message-ID: <20240124125557.493675-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e820__end_of_ram_pfn() is used to calculate max_pfn which, among other
things, guides where direct mapping ends. Any memory above max_pfn is
not going to be present in the direct mapping.

e820__end_of_ram_pfn() finds the end of the ram based on the highest
E820_TYPE_RAM range. But it doesn't includes E820_TYPE_ACPI ranges into
calculation.

Despite the name, E820_TYPE_ACPI covers not only ACPI data, but also EFI
tables and might be required by kernel to function properly.

Usually the problem is hidden because there is some E820_TYPE_RAM memory
above E820_TYPE_ACPI. But crashkernel only presents pre-allocated crash
memory as E820_TYPE_RAM on boot. If the preallocated range is small, it
can fit under the last E820_TYPE_ACPI range.

Modify e820__end_of_ram_pfn() and e820__end_of_low_ram_pfn() to cover
E820_TYPE_ACPI memory.

The problem was discovered during debugging kexec for TDX guest. TDX
guest uses E820_TYPE_ACPI to store the unaccepted memory bitmap and pass
it between the kernels on kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/e820.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf953380d..99c80680dc9e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -827,7 +827,7 @@ u64 __init e820__memblock_alloc_reserved(u64 size, u64 align)
 /*
  * Find the highest page frame number we have available
  */
-static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type type)
+static unsigned long __init e820_end_ram_pfn(unsigned long limit_pfn)
 {
 	int i;
 	unsigned long last_pfn = 0;
@@ -838,7 +838,8 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 
-		if (entry->type != type)
+		if (entry->type != E820_TYPE_RAM &&
+		    entry->type != E820_TYPE_ACPI)
 			continue;
 
 		start_pfn = entry->addr >> PAGE_SHIFT;
@@ -864,12 +865,12 @@ static unsigned long __init e820_end_pfn(unsigned long limit_pfn, enum e820_type
 
 unsigned long __init e820__end_of_ram_pfn(void)
 {
-	return e820_end_pfn(MAX_ARCH_PFN, E820_TYPE_RAM);
+	return e820_end_ram_pfn(MAX_ARCH_PFN);
 }
 
 unsigned long __init e820__end_of_low_ram_pfn(void)
 {
-	return e820_end_pfn(1UL << (32 - PAGE_SHIFT), E820_TYPE_RAM);
+	return e820_end_ram_pfn(1UL << (32 - PAGE_SHIFT));
 }
 
 static void __init early_panic(char *msg)
-- 
2.43.0


