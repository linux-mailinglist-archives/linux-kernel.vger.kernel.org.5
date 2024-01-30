Return-Path: <linux-kernel+bounces-44137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70996841DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B22B260AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47D756B70;
	Tue, 30 Jan 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNME18jA"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE633CE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603458; cv=none; b=CUbG8FLsGRSTTkSBbK/UHLmFao4/hsKRbT6Y9/6GKhsumN2dp980qa7UNt5wUn8doY/YIfkxyrDOgZFN1/UguUqCg+o1BTKeHOJhDZ8jDmg1482moV/17HI/XUXLe1RH021nUoIlOpdHTT9f/+/uukl2rsXXLwKJnEcBjfShGCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603458; c=relaxed/simple;
	bh=AwZwJ5cYVLV4jd8F8avXy7jN4r8TxDP5NN7KpZbNqJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrNikCBxuNuNg9x+qU57TAi9ShvJeFeuzIQzpCn6zRcaWcHO1dhkUApnLUVqIsUoI07T86U2S2dGNaBq2cBD1e9m3I0RUjsKbp15TgShcZJbkJlwID8lXf9ElGvSUfpzU2UspKSEVF0gYydJXfz3Le/x+3cPFYM8sIFkTgPEySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNME18jA; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706603455; x=1738139455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AwZwJ5cYVLV4jd8F8avXy7jN4r8TxDP5NN7KpZbNqJY=;
  b=TNME18jATKnZBMKyxYHwkR7Y/H06oinPcSuEtyjCzxYuScMTBO1cEQfQ
   AnLBb/JGfqas6gAMN0DCjkfnR+dbRSiyLkaB3TRtdthL87NgCPXICG4e1
   YE2dxl1gwOXsetIKTlYkTY/eIXucdOeqHHYnctpu/CLOhgkP2pXCBubR/
   /N9ERVF9Q+HOm1n9fy2/rmQpHiz+1LY0GH3+M3QYgAFpKAt/6Z8ZS3ODC
   F5cI4LLIWqj93nAEjT+TVMlVDdpw5wMGNTClauYcFb+Qxpq1aTwcBCgFW
   KkuHEhVYi7SgAqACIs8awSP34+QeIi8uwAy72Ed4ITvGLi81LMjZYJl8U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="467464334"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="467464334"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822120353"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822120353"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Jan 2024 00:30:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 81FFBB8; Tue, 30 Jan 2024 10:30:12 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Date: Tue, 30 Jan 2024 10:30:07 +0200
Message-ID: <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RDRAND and RDSEED instructions rarely fail. Ten retries should be
sufficient to account for occasional failures.

If the instruction fails more than ten times, it is likely that the
hardware is broken or someone is attempting to exceed the rate at which
the random number generator hardware can provide random numbers.

Issue a warning if ten retries were not enough.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/archrandom.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 918c5880de9e..fc8d837fb3b9 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -13,6 +13,12 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
+#ifdef KASLR_COMPRESSED_BOOT
+#define rd_warn(msg) warn(msg)
+#else
+#define rd_warn(msg) WARN_ONCE(1, msg)
+#endif
+
 #define RDRAND_RETRY_LOOPS	10
 
 /* Unconditional execution of RDRAND and RDSEED */
@@ -28,6 +34,9 @@ static inline bool __must_check rdrand_long(unsigned long *v)
 		if (ok)
 			return true;
 	} while (--retry);
+
+	rd_warn("RDRAND failed\n");
+
 	return false;
 }
 
@@ -45,6 +54,8 @@ static inline bool __must_check rdseed_long(unsigned long *v)
 			return true;
 	} while (--retry);
 
+	rd_warn("RDSEED failed\n");
+
 	return false;
 }
 
-- 
2.43.0


