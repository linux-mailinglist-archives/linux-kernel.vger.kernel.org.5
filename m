Return-Path: <linux-kernel+bounces-121511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C501988E911
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83911C307FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7055C13A3FF;
	Wed, 27 Mar 2024 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHHBPxWl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE7135401;
	Wed, 27 Mar 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553092; cv=none; b=jYpotzcIbeQoHHNqN66w4U1malaCAAMaFS4fVIBCd50KmRo4/SEBYH+z2q+w2OgM6KlaaEPAJxSj3+5eLf/v5/KefPfrMVPh037zB5N6//2ZuNb4LOZZDcjZSQSwoylKYeTuU4L4mpzcVNRmC+McoPFs0suKjEEWlecfkvip9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553092; c=relaxed/simple;
	bh=8qODhYyvaUk14kxfdEdYZD1YkZRxZEhZyVTOUCP3lbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLhOoeMS5Q0xvgnmhgLCCb1AAE2LnjQxqbwWmapHn3Sap6EEBMGRzcSGKKOXRY4YeJ98y3lSyi2fNd6VfKyYRe0nqEOd517QUUT5qVz27g9nfIjoQdGSc6GLMsCtVA9gA8Cl4jXAygsf7KIEpo29qDykda1fF5lAAFW6SIRXieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHHBPxWl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553090; x=1743089090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8qODhYyvaUk14kxfdEdYZD1YkZRxZEhZyVTOUCP3lbk=;
  b=QHHBPxWlXsMRRaUs51SsxCCWE/aGkWnIcvOh3Kkulls4aYPq6KRxygZD
   NomBbXTTd0H8pA3YdE7yBkfD/WcKmZhBaajQ8l5USG6mJOLiqE/crsJuc
   3fFxuyw99xk5zLZu+q9JhXdP97rpMwVPROqBuWwywZL8cQb/C+ELLSwPm
   lZutvAG8REYJAAPEeeIcbpGZflf8ZOwn6YbyF5DOAXd2SUR12WKZ+QeBM
   yV8I00i6918cv1bGhopmGkx/bdY/62M3K3ohgAvEbip7ODKRNh7bhgpZH
   XL0oYWuaml4k/P3cwF3Wjln36ueY5P51Qnj8LfT+B9mL5U1yqkPEsqcaz
   w==;
X-CSE-ConnectionGUID: /rpbcGdhSQylLKx4lf8CvQ==
X-CSE-MsgGUID: GciS/9vSS/ya0zS+7YlNmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518081"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518081"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414078"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:24:36 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Syed Nayyar Waris <syednwaris@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	William Breathitt Gray <william.gray@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v6 01/21] lib/bitmap: add bitmap_{read,write}()
Date: Wed, 27 Mar 2024 16:23:38 +0100
Message-ID: <20240327152358.2368467-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Syed Nayyar Waris <syednwaris@gmail.com>

The two new functions allow reading/writing values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

The code was taken from "bitops: Introduce the for_each_set_clump macro"
by Syed Nayyar Waris with a number of changes and simplifications:
 - instead of using roundup(), which adds an unnecessary dependency
   on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
 - indentation is reduced by not using else-clauses (suggested by
   checkpatch for bitmap_get_value());
 - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
   and bitmap_write();
 - some redundant computations are omitted.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
Suggested-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitmap.h | 77 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index aa4096126553..914c23e96f26 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -83,6 +83,10 @@ struct device;
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
+ *                                              map at start
+ *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
+ *                                              map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -754,6 +758,79 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_read - read a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
+ *
+ * Returns: value of @nbits bits located at the @start bit offset within the
+ * @map memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return
+ * value is undefined.
+ */
+static inline unsigned long bitmap_read(const unsigned long *map,
+					unsigned long start,
+					unsigned long nbits)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	unsigned long space = BITS_PER_LONG - offset;
+	unsigned long value_low, value_high;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return 0;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
+
+	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+	return (value_low >> offset) | (value_high << space);
+}
+
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value to write, clamped to nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
+ *
+ * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
+ * i.e. bits beyond @nbits are ignored:
+ *
+ *   for (bit = 0; bit < nbits; bit++)
+ *           __assign_bit(start + bit, bitmap, val & BIT(bit));
+ *
+ * For @nbits == 0 and @nbits > BITS_PER_LONG no writes are performed.
+ */
+static inline void bitmap_write(unsigned long *map, unsigned long value,
+				unsigned long start, unsigned long nbits)
+{
+	size_t index;
+	unsigned long offset;
+	unsigned long space;
+	unsigned long mask;
+	bool fit;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return;
+
+	mask = BITMAP_LAST_WORD_MASK(nbits);
+	value &= mask;
+	offset = start % BITS_PER_LONG;
+	space = BITS_PER_LONG - offset;
+	fit = space >= nbits;
+	index = BIT_WORD(start);
+
+	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
+	map[index] |= value << offset;
+	if (fit)
+		return;
+
+	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
+	map[index + 1] |= (value >> space);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.44.0


