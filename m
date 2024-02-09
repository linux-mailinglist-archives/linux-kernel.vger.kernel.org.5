Return-Path: <linux-kernel+bounces-58970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9484EF4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CA3B27A50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0866E576;
	Fri,  9 Feb 2024 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdHjXUcO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216095227;
	Fri,  9 Feb 2024 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448492; cv=none; b=Q1ryN55mU/Cb/oGgn/9aykSJg07PzKc3Yg6HOzv9zYuhhbIzuav+bnyBGS6sMnd1XTG/8Eh8X2v3AG9h89eYBpAyv9LGmxL6wCO3K7E7Z6Koua4wQZaDhu+H2DVLeQl7LgEABXxU9aVLp24Mj/u5EL8ghiAzesESSQg/NMEK/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448492; c=relaxed/simple;
	bh=UeJbm2alYHDiXSHmzWkkiSfZ2SjtcJME+Lz2npuv+/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPkWtLMis0pE+r58iIQDTTKRu/tbbY+F1HrlGH2VMgsDknBIRmkixbTDBBqvnDTrwA1xn5gP1YwzpKyViAf/iDi1lNf/aP18AtfWFKP6zvay8ynGCFZq+3cpGhBQnlNrwXYM1eAgQ8FBeD1IynEnLxnsu1YSr6q0R/ojKIkWALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdHjXUcO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448491; x=1738984491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UeJbm2alYHDiXSHmzWkkiSfZ2SjtcJME+Lz2npuv+/w=;
  b=CdHjXUcO25JYgNNUIOPM5iBL4fsjcLEYheOBaKdvLbVaWOjz+7/K0prN
   FnJod2SEPbC6xIbl2C9ocY3cQC2CzJrAJCbc6tHNzrWq/IC8HlYrxaPge
   ZvBQ7B8X9zkQcjJoj9C9xo608haZMItgzAUEjl1Nh4LXrU23q3kWpmNqv
   itOy2BhgMgesWgsDiPNrnR3xto2DLINJgXtFlpZBmrQJY3IaofMna2CHN
   MDGreMjxyFNC56gO2JaTwRlTaeHUFf3ZfGOBsKP75aMcNZFyHakjZLAJg
   20L4bu+fge7yJw+tJgTH8DSa9yBbFr8vqgxj3DDXQAAVzoaK9gG9bfMes
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257900"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257900"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631420"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:47 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v4 04/15] find_bit: add _find_last_and_bit() to support finding the most significant set bit
Date: Thu,  8 Feb 2024 19:14:30 -0800
Message-ID: <20240209031441.943012-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240209031441.943012-1-weilin.wang@intel.com>
References: <20240209031441.943012-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

This function is required for more efficient PMU counter assignment.

When we use bitmap to log available PMU counters and counters that support a
given event, we want to find a most significant set bit so that we could
starting assigning counters with larger index first. This is helpful
because counters with smaller indexes usually are more generic and
support more events.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/include/linux/find.h | 18 ++++++++++++++++++
 tools/lib/find_bit.c       | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/include/linux/find.h b/tools/include/linux/find.h
index 38c0a542b0e2..fce336ec2b96 100644
--- a/tools/include/linux/find.h
+++ b/tools/include/linux/find.h
@@ -18,6 +18,8 @@ extern unsigned long _find_first_bit(const unsigned long *addr, unsigned long si
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
+extern unsigned long _find_last_and_bit(const unsigned long *addr1,
+					 const unsigned long *addr2, unsigned long size);
 
 #ifndef find_next_bit
 /**
@@ -174,4 +176,20 @@ unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 }
 #endif
 
+#ifndef find_last_and_bit
+static inline
+unsigned long find_last_and_bit(const unsigned long *addr1,
+				const unsigned long *addr2,
+				unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
+
+		return val ? __fls(val) : size;
+	}
+
+	return _find_last_and_bit(addr1, addr2, size);
+}
+#endif
+
 #endif /*__LINUX_FIND_H_ */
diff --git a/tools/lib/find_bit.c b/tools/lib/find_bit.c
index 6a3dc167d30e..e475a7368e36 100644
--- a/tools/lib/find_bit.c
+++ b/tools/lib/find_bit.c
@@ -67,6 +67,27 @@ out:										\
 	sz;									\
 })
 
+/*
+ * Common helper for find_bit() function family
+ * @FETCH: The expression that fetches and pre-processes each word of bitmap(s)
+ * @MUNGE: The expression that post-processes a word containing found bit (may be empty)
+ * @size: The bitmap size in bits
+ */
+#define FIND_LAST_BIT(FETCH, MUNGE, size)					\
+({										\
+	unsigned long idx, val, sz = (size);					\
+										\
+	for (idx = ((size - 1) / BITS_PER_LONG); idx >= 0; idx--) {			\
+		val = (FETCH);							\
+		if (val) {							\
+			sz = min(idx * BITS_PER_LONG + __fls(MUNGE(val)), sz);	\
+			break;							\
+		}								\
+	}									\
+										\
+	sz;									\
+})
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
@@ -121,3 +142,15 @@ unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits
 	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
 }
 #endif
+
+#ifndef find_last_and_bit
+/*
+ * Find the last set bit in two memory regions.
+ */
+unsigned long _find_last_and_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_LAST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
+}
+#endif
\ No newline at end of file
-- 
2.42.0


