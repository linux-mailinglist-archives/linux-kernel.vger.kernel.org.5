Return-Path: <linux-kernel+bounces-121524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C188E933
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D472A49FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889111494CA;
	Wed, 27 Mar 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9R7pl3t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8621494A4;
	Wed, 27 Mar 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553119; cv=none; b=C6/fxUyLZ3hKVAWhYoDBy0y1Dc7c7HhjNZySd2IuE0wcduQ1CtOzFadgrTUYqXucj4B8l4NCG80voh9+Zl2otFGt1G1VySea9BcDklaVR7cFlfU4m+Hq0m57aHZLQt0O3/iv1eImQqJAGwuZdpJ9a1xIyEF6ajrXder5enWEpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553119; c=relaxed/simple;
	bh=Jo3SS7pOBr6YTSNduTI90cZyGI5oQuDzhLIxEvLUPuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzFtfpDyQSPt54KciHZJ3o9zSnXrJATL+6URf02hNGcALsMyt1uu2sI1j7/CPoHjopRHtHQWN7uAjmttq2zh9mzh/cTae7DcnxGqFUYcUk+/VafIvuWanA/xVq2iwyMfpzSie5LqtqK9Yc4Hi8XXAtQnXfsS177EIz/y+KW2fkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9R7pl3t; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553118; x=1743089118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jo3SS7pOBr6YTSNduTI90cZyGI5oQuDzhLIxEvLUPuo=;
  b=H9R7pl3tPY63cNBkfIAihPbwlU4dOffYvyB3Y0QXy/nZ9slOUbHmNzsL
   HgOQU4WWUr8aCvdJxRPP2KCChlX4KN8cVFJf/qqIe0ptJy1eEy8dDht5g
   E2aPteZRjqH+HgQXh5WzVMP8j+eoCeyy+X+Cwc7gjL0imGI4dz2bysdpi
   v6jhOZ11bcDq4sUvMUPEE7wK0+3syvtHEHjL/mDZDVz5FNFhziQVXoeFI
   Tz7beWU5JhGbe9YiDkcWsPMPVrOkRytEDSC7/uuWPYWktx7W2h5uSbYpK
   e9J4cR6E26l5Ue8JFb/LQGN3MRiNVKV6SV/Dsd2SbpZB8UxaHuj5Q9Al6
   A==;
X-CSE-ConnectionGUID: 651gR3fITcOoSGUX0zhBig==
X-CSE-MsgGUID: JQ78DpJjRS+UxXndtwV3fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518235"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518235"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414328"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:25:15 -0700
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v6 14/21] lib/bitmap: add compile-time test for __assign_bit() optimization
Date: Wed, 27 Mar 2024 16:23:51 +0100
Message-ID: <20240327152358.2368467-15-aleksander.lobakin@intel.com>
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

Commit dc34d5036692 ("lib: test_bitmap: add compile-time
optimization/evaluations assertions") initially missed __assign_bit(),
which led to that quite a time passed before I realized it doesn't get
optimized at compilation time. Now that it does, add test for that just
to make sure nothing will break one day.
To make things more interesting, use bitmap_complement() and
bitmap_full(), thus checking their compile-time evaluation as well. And
remove the misleading comment mentioning the workaround removed recently
in favor of adding the whole file to GCov exceptions.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 2870373d94d0..83019beabce4 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -1245,14 +1245,7 @@ static void __init test_bitmap_const_eval(void)
 	 * in runtime.
 	 */
 
-	/*
-	 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
-	 * Clang on s390 optimizes bitops at compile-time as intended, but at
-	 * the same time stops treating @bitmap and @bitopvar as compile-time
-	 * constants after regular test_bit() is executed, thus triggering the
-	 * build bugs below. So, call const_test_bit() there directly until
-	 * the compiler is fixed.
-	 */
+	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
 	bitmap_clear(bitmap, 0, BITS_PER_LONG);
 	if (!test_bit(7, bitmap))
 		bitmap_set(bitmap, 5, 2);
@@ -1284,6 +1277,15 @@ static void __init test_bitmap_const_eval(void)
 	/* ~BIT(25) */
 	BUILD_BUG_ON(!__builtin_constant_p(~var));
 	BUILD_BUG_ON(~var != ~BIT(25));
+
+	/* ~BIT(25) | BIT(25) == ~0UL */
+	bitmap_complement(&var, &var, BITS_PER_LONG);
+	__assign_bit(25, &var, true);
+
+	/* !(~(~0UL)) == 1 */
+	res = bitmap_full(&var, BITS_PER_LONG);
+	BUILD_BUG_ON(!__builtin_constant_p(res));
+	BUILD_BUG_ON(!res);
 }
 
 /*
-- 
2.44.0


