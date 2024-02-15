Return-Path: <linux-kernel+bounces-67220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C556F856851
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F893B2AE19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD239133995;
	Thu, 15 Feb 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtlnUwjB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563F12C548;
	Thu, 15 Feb 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011705; cv=none; b=S9Gxr1tQ3kSdtx88js+7zcHdu73Eu2GDu9tNxJzJysqtdV6iBdXxkRV+ZRs2lJ5FhupHygZIW/B5xusTmDdSMLhEKk7xpb7rMt/9Oj8u2wzOfrfQuPxnb5GxH3a2HNegRs4a+sG/qG7wzey2QJ7DDAmLiymAjTQrouGD2y4g+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011705; c=relaxed/simple;
	bh=Pgd5J6Uby1Zyd/C1wyBnm9ePGiFzIsnkC58Bl/jyjRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0Fg4Ww3BqvVSzCocNrvI6N8/iuCS0qDDFMxayNoSBw4M1OP6FXlAvti09RMbiO5aO4EDp1oCJM32uMewsw4maeKidYTRCD2Dmr+V+tCygZyuSImO1YYrlYK3ZcZr/iSOQLTKoGU2lMr9+5L3f4I/20oC7D4lTETCDCqTcNEhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtlnUwjB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708011703; x=1739547703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pgd5J6Uby1Zyd/C1wyBnm9ePGiFzIsnkC58Bl/jyjRE=;
  b=VtlnUwjB9oH4wtbAK9eJ9lbg3AmBfsaYryM5f8oAsH8z6R4NtEW91Ssp
   1cinY5rg96Km0fe17mqRO6mh5pkQd9rX+dZs1T3miXlNSTuVnGESqPoBe
   riOXqhWDmbrfHkzGBaiuYgbp8muTtM1G6edSDGL0KMDomhxURAVnuLXKy
   X0l8CWv5gLMQeyKvUMUwahZD5LvewgHDT5h+vqvMG55O1kN8fz6HZ4bWT
   1LWqalsvQviAtPlqrcujah3tfNfqthsDc1GSrPtJlu39mIxSxeqIXjeSz
   WoGGs51XPhU4EZj8uUtm7QnDLpHBXlfakemCQJgw0SSFbJyiC+Pk4V2dn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5888083"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5888083"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 07:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935682308"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="935682308"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2024 07:41:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B54E2204; Thu, 15 Feb 2024 17:41:38 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/1] wireless: Add KHZ_PER_GHZ to units.h and reuse
Date: Thu, 15 Feb 2024 17:41:36 +0200
Message-ID: <20240215154136.630029-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KHZ_PER_GHZ might be used by others (with the name aligned
with similar constants). Define it in units.h and convert
wireless to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/units.h | 5 ++++-
 net/wireless/reg.c    | 7 +++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/units.h b/include/linux/units.h
index 45110daaf8d3..00e15de33eca 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -24,10 +24,13 @@
 #define NANOHZ_PER_HZ		1000000000UL
 #define MICROHZ_PER_HZ		1000000UL
 #define MILLIHZ_PER_HZ		1000UL
+
 #define HZ_PER_KHZ		1000UL
-#define KHZ_PER_MHZ		1000UL
 #define HZ_PER_MHZ		1000000UL
 
+#define KHZ_PER_MHZ		1000UL
+#define KHZ_PER_GHZ		1000000UL
+
 #define MILLIWATT_PER_WATT	1000UL
 #define MICROWATT_PER_MILLIWATT	1000UL
 #define MICROWATT_PER_WATT	1000000UL
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 50cadbad485f..753f8e9aa4b1 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -57,6 +57,8 @@
 #include <linux/verification.h>
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
+#include <linux/units.h>
+
 #include <net/cfg80211.h>
 #include "core.h"
 #include "reg.h"
@@ -1289,20 +1291,17 @@ static bool is_valid_rd(const struct ieee80211_regdomain *rd)
 static bool freq_in_rule_band(const struct ieee80211_freq_range *freq_range,
 			      u32 freq_khz)
 {
-#define ONE_GHZ_IN_KHZ	1000000
 	/*
 	 * From 802.11ad: directional multi-gigabit (DMG):
 	 * Pertaining to operation in a frequency band containing a channel
 	 * with the Channel starting frequency above 45 GHz.
 	 */
-	u32 limit = freq_khz > 45 * ONE_GHZ_IN_KHZ ?
-			20 * ONE_GHZ_IN_KHZ : 2 * ONE_GHZ_IN_KHZ;
+	u32 limit = freq_khz > 45 * KHZ_PER_GHZ ? 20 * KHZ_PER_GHZ : 2 * KHZ_PER_GHZ;
 	if (abs(freq_khz - freq_range->start_freq_khz) <= limit)
 		return true;
 	if (abs(freq_khz - freq_range->end_freq_khz) <= limit)
 		return true;
 	return false;
-#undef ONE_GHZ_IN_KHZ
 }
 
 /*
-- 
2.43.0.rc1.1.gbec44491f096


