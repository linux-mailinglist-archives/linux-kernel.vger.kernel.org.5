Return-Path: <linux-kernel+bounces-121523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA988E931
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA9629829F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB616149012;
	Wed, 27 Mar 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mP+eJYhB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F0148FEC;
	Wed, 27 Mar 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553117; cv=none; b=XboVQQuOuCwQEY+QOEqSKuws7k9GoTF7F+0n6PFUztDluduL01QJM+IcVTYGFtGG4xgSFThm2l948sWtcSXgDQ7O1eDCbzoQaUI6Y1eiAz99auOUQV71nBT66ruReKaxpk/ucGn5sTicYtrweQiNVtu+ye8G0EuS42+U1PAdiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553117; c=relaxed/simple;
	bh=80gHSv14ycbNEh+nz/ScxH6nJSUPMtmoBB7wIdLIgH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzCoSj3JQ8o1jKHZ5UcQFUbYH4VJ4U8NBKvueRGZOv1ycWvDdwtgKHacZCSv6z0zKz68yP2SUuXc7V+dbJRUKBoEbMfcW6ivUGFng/Pw6nYe/mha1YbF5gYMH/SCDuaIqo+qfhQ22DOsoXMNExRtcv1hj8IoxdEV9ZRhCM95tb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mP+eJYhB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553115; x=1743089115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80gHSv14ycbNEh+nz/ScxH6nJSUPMtmoBB7wIdLIgH4=;
  b=mP+eJYhBE8xumeOjq0WzVhODhwMpXEggy2ha/o5v4/HT+RgfZWAiEZ8G
   k2D2XkLCHCAKumCSXpILaDnbHY1eZlC1DAO+9SW+geKwUNTTnaO0VuKN+
   KqTu7QJc4LB9bVoRN569yd+ZMIH2KQdge3n5aNWbxvXQN3UqjjbN89Glq
   QtVHksB1eDwSzoHKlC+P3eJXl1tx9tdNDhwZtZYs9rCu+LMdFHzOSgasg
   WbbUK7uIrn5A7M42r5KuBxqi7bWmppab2Ov4Ob+i3e+Lz6FDbPG/b3R7c
   8uKolhCid8AhZXHt/fB7TqjnthP784TL9Y+vz8SUePbUfzTNWbMhVhzUM
   A==;
X-CSE-ConnectionGUID: zR0sw+UAQV2JdwyQPSGb6w==
X-CSE-MsgGUID: cdpc70C+SyKplDmcqjw1Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518227"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518227"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414312"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:25:12 -0700
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 13/21] bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
Date: Wed, 27 Mar 2024 16:23:50 +0100
Message-ID: <20240327152358.2368467-14-aleksander.lobakin@intel.com>
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

Now that we have generic bitmap_read() and bitmap_write(), which are
inline and try to take care of non-bound-crossing and aligned cases
to keep them optimized, collapse bitmap_{get,set}_value8() into
simple wrappers around the former ones.
bloat-o-meter shows no difference in vmlinux and -2 bytes for
gpio-pca953x.ko, which says the optimization didn't suffer due to
that change. The converted helpers have the value width embedded
and always compile-time constant and that helps a lot.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitmap.h | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 363e0b184a45..8c4768c44a01 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -727,39 +727,6 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
 	bitmap_from_arr64(dst, &mask, 64);
 }
 
-/**
- * bitmap_get_value8 - get an 8-bit value within a memory region
- * @map: address to the bitmap memory region
- * @start: bit offset of the 8-bit value; must be a multiple of 8
- *
- * Returns the 8-bit value located at the @start bit offset within the @src
- * memory region.
- */
-static inline unsigned long bitmap_get_value8(const unsigned long *map,
-					      unsigned long start)
-{
-	const size_t index = BIT_WORD(start);
-	const unsigned long offset = start % BITS_PER_LONG;
-
-	return (map[index] >> offset) & 0xFF;
-}
-
-/**
- * bitmap_set_value8 - set an 8-bit value within a memory region
- * @map: address to the bitmap memory region
- * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
- * @start: bit offset of the 8-bit value; must be a multiple of 8
- */
-static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
-				     unsigned long start)
-{
-	const size_t index = BIT_WORD(start);
-	const unsigned long offset = start % BITS_PER_LONG;
-
-	map[index] &= ~(0xFFUL << offset);
-	map[index] |= value << offset;
-}
-
 /**
  * bitmap_read - read a value of n-bits from the memory region
  * @map: address to the bitmap memory region
@@ -833,6 +800,11 @@ static inline void bitmap_write(unsigned long *map, unsigned long value,
 	map[index + 1] |= (value >> space);
 }
 
+#define bitmap_get_value8(map, start)			\
+	bitmap_read(map, start, BITS_PER_BYTE)
+#define bitmap_set_value8(map, value, start)		\
+	bitmap_write(map, value, start, BITS_PER_BYTE)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.44.0


