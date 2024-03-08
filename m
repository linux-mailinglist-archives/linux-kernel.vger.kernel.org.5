Return-Path: <linux-kernel+bounces-97047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7088764DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386001F24243
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B5381C1;
	Fri,  8 Mar 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKkQwqht"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4033FBA3;
	Fri,  8 Mar 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903764; cv=none; b=WfWSIZ5dpi8OKYGkJgzSPiF63WHf1LXwGoCL3NOezfYyJ/XqGshlO9Pym7uEdYvSNLoCy1I4j+0R7drD6aTME7igm7T9Y/QM0+wAS55THd/+tnr+x92tfveRxTkRwirStAGUjeJmdbDblhccLD3PihbOhbL2BQ4JCy9hAa/ikKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903764; c=relaxed/simple;
	bh=LAWkJDgSOoQXttIOaNX5OjXrKNZqw1gNI6g5JMXltWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CmHZqrJBBNKdBY3oKfVqvq9dqSurSlE4dXvez/7FRZ7P44PbGpvKjTb7OCWaW31rzJzA/xJxBfAScdEwOSJIHUkdXgJOPy9oOoRFuYKJsW0n0Y/dzWEXQs6xse5ZNiFVWJ2aoaX4XJZvn0kBQdjTNewiWmBIsbQKlxhm49uNkOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKkQwqht; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903763; x=1741439763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LAWkJDgSOoQXttIOaNX5OjXrKNZqw1gNI6g5JMXltWY=;
  b=dKkQwqhtq7hi+RivoAFGfQlxov+s7gDXrTtI3l1nemA7D7hPSZ7OoAug
   9lcVHg2rHWicohP6AbvPe5yaKsYiXJ8D64XJsaHn7Vn2CLY+DPtZsGGee
   F3umKTMckNOIyU0x2F18q3d2QL8ZUFbI+jIpxTg2TWZRXRrwR6b09YkT5
   VixNKbJb3qgmGpxD0xPlvaLR6GtsT3eFOIvDyEbC+yNsTcvhZaJPBin79
   7PfiK0WUOCOlVYcyQW0+WmRSb4gQ1R9wYmHVS1zhZb4DCajF+eMk3Iec3
   PHgNieXTm5Z37U6gk3cR0AnF2uEFi6t2DnFBs0xUYN3bm0g+JlI8cStPH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342493"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342493"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161388"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:55 -0800
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
Subject: [PATCH 05/19] vdso: math64: Provide mul_u64_u32_add_u64_shr()
Date: Fri,  8 Mar 2024 15:14:58 +0200
Message-Id: <20240308131512.44324-6-adrian.hunter@intel.com>
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

Provide mul_u64_u32_add_u64_shr() which is a calculation that will be used
by timekeeping and VDSO.

Place #include <vdso/math64.h> after #include <asm/div64.h> to allow
architecture-specific overrides, at least for the kernel.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/math64.h |  2 +-
 include/vdso/math64.h  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index fd13622b2056..d34def7f9a8c 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -4,8 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/math.h>
-#include <vdso/math64.h>
 #include <asm/div64.h>
+#include <vdso/math64.h>
 
 #if BITS_PER_LONG == 64
 
diff --git a/include/vdso/math64.h b/include/vdso/math64.h
index 7da703ee5561..22ae212f8b28 100644
--- a/include/vdso/math64.h
+++ b/include/vdso/math64.h
@@ -21,4 +21,42 @@ __iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 	return ret;
 }
 
+#if defined(CONFIG_ARCH_SUPPORTS_INT128) && defined(__SIZEOF_INT128__)
+
+#ifndef mul_u64_u32_add_u64_shr
+static __always_inline u64 mul_u64_u32_add_u64_shr(u64 a, u32 mul, u64 b, unsigned int shift)
+{
+	return (u64)((((unsigned __int128)a * mul) + b) >> shift);
+}
+#endif /* mul_u64_u32_add_u64_shr */
+
+#else
+
+#ifndef mul_u64_u32_add_u64_shr
+#ifndef mul_u32_u32
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	return (u64)a * b;
+}
+#define mul_u32_u32 mul_u32_u32
+#endif
+static __always_inline u64 mul_u64_u32_add_u64_shr(u64 a, u32 mul, u64 b, unsigned int shift)
+{
+	u32 ah = a >> 32, al = a;
+	bool ovf;
+	u64 ret;
+
+	ovf = __builtin_add_overflow(mul_u32_u32(al, mul), b, &ret);
+	ret >>= shift;
+	if (ovf && shift)
+		ret += 1ULL << (64 - shift);
+	if (ah)
+		ret += mul_u32_u32(ah, mul) << (32 - shift);
+
+	return ret;
+}
+#endif /* mul_u64_u32_add_u64_shr */
+
+#endif
+
 #endif /* __VDSO_MATH64_H */
-- 
2.34.1


