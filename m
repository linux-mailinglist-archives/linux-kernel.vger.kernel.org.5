Return-Path: <linux-kernel+bounces-137683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 402F089E5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A511C21986
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E06E158DB9;
	Tue,  9 Apr 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSRMeQoU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DA158DB0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704097; cv=none; b=bgsiGMnLbycBJ+V+U8ZnXsaMCP0vRhcYsFztxwLA/caqnnOfUTPJi8JJWPXRK/VlL+p8lijQvki0flwl9KnB1sWdVLjYbv55zncLgDEPFkP2s3X0Us9SeHQ6Ckyk8+MC86KcAN5rIPkDc1c8wBUe57KsUmm2xVsR9th2WHsf8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704097; c=relaxed/simple;
	bh=bE/hIdyAlZdQeLhR3fmMMG7I2XnJCRfk8VGKhousyJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suSUBu7oit8GkcnzttVVYQ/0ds++YhCTPHCXU6JI41HoT1MVftXCck0GkD+FeQTQZmcMG2KRWw0e0wk+8PZE3FaNMwx/fuCElqEOqp7btT78ZOr/mDunQOe6QyMTITtTjOvVGrxAQEcNSS/inRAXzsvuFvgky0S0QbRjlMQAe9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSRMeQoU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712704096; x=1744240096;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bE/hIdyAlZdQeLhR3fmMMG7I2XnJCRfk8VGKhousyJs=;
  b=kSRMeQoUrNtDEjJpdY0BFm57uWhO9CkchIr99aRqh4bV3RIFb7JNY9YH
   /IafvXjFq25g+bLS3xtLPlW7I9gAG0fWjDVVCXmRBNk4aJIrXimdcuptA
   G7U6ioyLUePN13UeOQKBGbHxvhmS6W+XVc04qp4uZ2MmsAhOP0yuLlD/p
   0f/1kaU9Kc8vC63CrI8olp5ca0ta8PQCHNfrvnNvO8SvD/enfA6AAVgMa
   2/6sHnZ1N0IKkf87wzhGRN3RR/YJ4/tm8rMwdom67ZDT/2+3MLNbusupK
   7aZp7z08bpJG12wccdkjrHHTGDME8u/P63O4p2qCcHwkDBK+9Bk2m1ulu
   w==;
X-CSE-ConnectionGUID: Ft1LuY6SQx6JTZAfePmouw==
X-CSE-MsgGUID: O7iNs5mfThayExjgJMtPAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7959626"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7959626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:08:16 -0700
X-CSE-ConnectionGUID: JN2XrYyxRSCJYvtz9sLdLw==
X-CSE-MsgGUID: 6KLXRYpxQkCBWi3qq7uD7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51345967"
Received: from kmarkley-mobl1.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.174])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:08:15 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Sean Christopherson <seanjc@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] x86/bugs: Fix return type of spectre_bhi_state()
Date: Tue,  9 Apr 2024 16:08:05 -0700
Message-Id: <20240409230806.1545822-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of spectre_bhi_state() incorrectly returns a const char
* const.  This causes the a compiler warning when building with W=1.

 warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
 2812 | static const char * const spectre_bhi_state(void)

Remove the const qualifier from the pointer.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e1775debeafe..7e4a706cad80 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2809,7 +2809,7 @@ static char *pbrsb_eibrs_state(void)
 	}
 }
 
-static const char * const spectre_bhi_state(void)
+static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";
-- 
2.25.1


