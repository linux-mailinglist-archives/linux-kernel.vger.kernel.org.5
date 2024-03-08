Return-Path: <linux-kernel+bounces-97046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B048F8764D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40DC1C213DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09344364B4;
	Fri,  8 Mar 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1ED09X2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E23FB9E;
	Fri,  8 Mar 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903757; cv=none; b=iz0iDZOQbc/qiijW2BuJPwW3lBDrxmhtaUfyHycSDREtg/X9NWQVc5/rxzoMISpX3LKQO1LFMbaGvP4vqU7SSACqwK1QNIVCF817KgjoJU5EE7lldQwm9bnQ+f78Ag8cwn3zVbjALkfBmv65tC2VYrbdSCsHiUUZWpe5Rll53+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903757; c=relaxed/simple;
	bh=xuamuB97LVfxyJSvE4i73CrmF8XOSgafgM3yHCD1nqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZ98/BnSm73aHVCqgA+pAawwtFNgkZFIxcOrr0KIqVh4ZSwlx1AJtIhGfGCsQm9VcenVLg5gozZ98NLK5v64wF0HAPzJnT0o7BonmkdD6RULZYkG/odvlR9hv5YdhUxDQQsextvm6VLh+PEP/a7uO6dubnrZdlhRT7nVYRb9Ch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1ED09X2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903756; x=1741439756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xuamuB97LVfxyJSvE4i73CrmF8XOSgafgM3yHCD1nqo=;
  b=F1ED09X29kFWjM5C5PwVaAA7y8jaeSuUbl6VD6JSNH7gRjM2r3kgk8hK
   Ef8CXuNV0kZiKQb+fUknVTpSiyl3tQRWc2dEUWAQGhpg/pcGQwegyVHuy
   kpjs7I20WWQVL2TvLQRjYzksSB0o4oxGraVK2/Ds2onCB5tFw5S/rAB9t
   6PNEIgeolPoq3SFgXmqh1mh1EcfAUy5L0baZnPlwRUMOFlnvtV60sRJJ7
   lh+EiMouTXlxXjgg8Vgdb7UDyspGLVobKmgokHOpFGgIT+PeDGGMlNjvl
   L1OLANYMTGVY052OotV53pd/5WbVlfjXDYWEvKN38UPlSsd4Wu6Z6ehwV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342483"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342483"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161379"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:48 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 04/19] math64: Tidy mul_u64_u32_shr()
Date: Fri,  8 Mar 2024 15:14:57 +0200
Message-Id: <20240308131512.44324-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308131512.44324-1-adrian.hunter@intel.com>
References: <20240308131512.44324-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Put together declaration and initialization of local variables.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/math64.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index bf74478926d4..fd13622b2056 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -179,16 +179,12 @@ static __always_inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
 #ifndef mul_u64_u32_shr
 static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
 {
-	u32 ah, al;
+	u32 ah = a >> 32, al = a;
 	u64 ret;
 
-	al = a;
-	ah = a >> 32;
-
 	ret = mul_u32_u32(al, mul) >> shift;
 	if (ah)
 		ret += mul_u32_u32(ah, mul) << (32 - shift);
-
 	return ret;
 }
 #endif /* mul_u64_u32_shr */
-- 
2.34.1


