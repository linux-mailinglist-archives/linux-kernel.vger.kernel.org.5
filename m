Return-Path: <linux-kernel+bounces-44136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC344841DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88186283D10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15595477C;
	Tue, 30 Jan 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/e4fGrO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF41E52C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603457; cv=none; b=TWnaD69fo2seLR77TK1FfGMVq8nsxJhI3WIFY2Ayf3DYgvIa0ZN/3sZVw7lkypkFZx1IZCXGUdBPKc41tSasXB4T6JrD4HsIZYPAh0fZx2xKUtoiEk3fbj4sJFLpKPnlUqjHUfv0c1Xv6BokHQapI6Bmuw/m+EtwXpruUtkVyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603457; c=relaxed/simple;
	bh=bboqiXpspNty+IUr75AIb5o8t24UN3eTB7gE/wxTugU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVyfO9DK+tFLFMt1QRtp5QIO3Zdoa6v70vxakR+bTRBorhixEaoxWL2VopVuLOFhUW50fj2+U7lh7UeabAOnEh34Rhulv0P/pmrpUYnf0yhCC0pncQdzb68B0yXCv9s1i/Cmm9ib1Rph8askSF0EPidIEyPHmsvi9Etuqb9fTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/e4fGrO; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706603455; x=1738139455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bboqiXpspNty+IUr75AIb5o8t24UN3eTB7gE/wxTugU=;
  b=W/e4fGrOycPonf5ZB6fkIRXhcv4JHn4gKUHXqvzVih9cnrDoSp/zrr9F
   O7deKy+fFG0GtAH5mCl5VI9n0NnlRMuXW8QBf5dJylzJd3NQ5UJGtOcU8
   PVH84BJ245h6jqMIOm9OSYdWpL0D0Sb0yol61x3iVd2+pxqgc1xiFFCIJ
   QAo6+0dpS2hOIXKaW5drqlmo81gbrLY0y8kzRxLmoCYlJPsmtztQnK0bi
   66Ik8utqNG8za/qZv0UBGt5+5WEZHeM06viCsqkTk8/51kewlDBF8bxLi
   xocIwiae3fZDJxpjp0R7UO6e5UYVdkRsE9heH6OzyXatZIgKRH4FviVc3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="467464323"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="467464323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="822120351"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="822120351"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Jan 2024 00:30:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 751D5DE; Tue, 30 Jan 2024 10:30:12 +0200 (EET)
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
Subject: [PATCH 1/2] x86/random: Retry on RDSEED failure
Date: Tue, 30 Jan 2024 10:30:06 +0200
Message-ID: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rdrand_long() retries 10 times before returning failure to
the caller. On the other hand, rdseed_long() gives up on the first
failure.

According to the Intel SDM, both instructions should follow the same
retry approach. This information can be found in the section titled
"Random Number Generator Instructions".

To align the behavior of rdseed_long() with rdrand_long(), it should be
modified to retry 10 times before giving up.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/archrandom.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
index 02bae8e0758b..918c5880de9e 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -33,11 +33,19 @@ static inline bool __must_check rdrand_long(unsigned long *v)
 
 static inline bool __must_check rdseed_long(unsigned long *v)
 {
+	unsigned int retry = RDRAND_RETRY_LOOPS;
 	bool ok;
-	asm volatile("rdseed %[out]"
-		     CC_SET(c)
-		     : CC_OUT(c) (ok), [out] "=r" (*v));
-	return ok;
+
+	do {
+		asm volatile("rdseed %[out]"
+			     CC_SET(c)
+			     : CC_OUT(c) (ok), [out] "=r" (*v));
+
+		if (ok)
+			return true;
+	} while (--retry);
+
+	return false;
 }
 
 /*
-- 
2.43.0


