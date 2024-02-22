Return-Path: <linux-kernel+bounces-77183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862868601E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2650E1F2A068
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486B14DFF2;
	Thu, 22 Feb 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exeNTwdS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967B14EFC1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627207; cv=none; b=ace7s/pwIDPx9XHxTqoAaMqH5ynFMimI6ew2J6TSZB1qKxDqWVF330fEi3/Of2Rd+OrrsMZ76u+g9yGC69SGl58Qy/2MDxEzG5L3l9eHtstT7CGneqABCAl9W/jZzkoz4dDKV3deXpkJiwLSj+5QwObb1mhutueuypANC/YQVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627207; c=relaxed/simple;
	bh=7kh29fKzq0nBKTNuMbdWSslJMi85X1GnHn7bPcB2f/k=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=oNi3OSZPCL8mViqC8Y+kFEtXXDyX+PWM1gKjzzoziTAsGiFWo/MMKZe2jlzxjjhfR165HYeXwNChj53nPVY+rJKw/rKyF3Gjtr/dBVLvV2zD1GDfQGSDx0/PfHFWGaeTIHqgVYUmjCnuEGDHHanbnNSFsQsfotQ3F4mq8p+r24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exeNTwdS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627204; x=1740163204;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=7kh29fKzq0nBKTNuMbdWSslJMi85X1GnHn7bPcB2f/k=;
  b=exeNTwdS9yKPFJ9FhrrLAFu7VL6ASLvIQVkNJ0O3eNtWM0nI8+CIm/A7
   UyASqq97PmlYggpK6O2oQpQGodTGTd0sRFGEcEVN2Tzuz/9K8YuaFNpzo
   WVzTttYicNTflB68OtzKNJAfTpS0TdcOeTtqFAq0GS99NoB/Vma57ohvz
   TSE68dc7+GN2ZtteOy+DbmkDpdMj0GBlgh325+L6WUcZfIZz1iUrSypSa
   XqCgYH6IquXnxoP4BU//dh9Ae0DywbhnPQz5llvmctktp8Y85THlB5r7G
   VXRNBlzAWhUHEVMfOC4iEuBknt3Mg9ggT2MIA83nQvT3rQEiJM6h3wsfQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584574"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584574"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265258"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:04 -0800
Subject: [RFC][PATCH 28/34] x86/cpu: Return sane defaults for early x86_config reads
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:03 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184003.85CE26B6@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

*If* an unexpected user tries to read 'x86_config' before it is
C_FINALIZED and valid, it will likely get 0's or other garbage.
Those values often cause the user to crash before they can get
a nice message out to the console.

Provide some mostly random but unlikely-to-crash-the-caller
values.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |   32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff -puN arch/x86/include/asm/processor.h~x86_config-defaults arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~x86_config-defaults	2024-02-22 10:09:02.280995903 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:09:02.280995903 -0800
@@ -813,37 +813,57 @@ static inline void weak_wrmsr_fence(void
 	alternative("mfence; lfence", "", ALT_NOT(X86_FEATURE_APIC_MSRS_FENCE));
 }
 
-static inline void read_x86_config(void)
+static inline int read_x86_config(void)
 {
 	if (x86_config.conf_state == C_FINALIZED)
-		return;
+		return 0;
 
 	/* Only record the first one: */
 	if (!x86_config.early_reader)
 		x86_config.early_reader = __builtin_return_address(0);
+
+	return -EINVAL;
 }
 
+/*
+ * These _should_ not be called until x86_config is C_FINALIZED.
+ * In the case that they are, two things will happen:
+ *  1. The first caller will get the call site recorded in
+ *     'early_reader' which will trigger a warning later in
+ *     boot.
+ *  2. A moderately sane hard-coded default value will be provided.
+ *     The entire intent of this value is to let things limp along
+ *     until the warning can spit out.
+ */
 static inline u8 x86_phys_bits(void)
 {
-	read_x86_config();
+	if (read_x86_config())
+		return 52;
+
 	return x86_config.phys_bits;
 }
 
 static inline u8 x86_virt_bits(void)
 {
-	read_x86_config();
+	if (read_x86_config())
+		return IS_ENABLED(CONFIG_X86_64) ? 57 : 32;
+
 	return x86_config.virt_bits;
 }
 
 static inline u8 x86_cache_bits(void)
 {
-	read_x86_config();
+	if (read_x86_config())
+		return 52;
+
 	return x86_config.cache_bits;
 }
 
 static inline u8 x86_clflush_size(void)
 {
-	read_x86_config();
+	if (read_x86_config())
+		return 64;
+
 	return x86_config.clflush_size;
 }
 
_

