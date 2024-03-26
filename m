Return-Path: <linux-kernel+bounces-118671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3140C88BDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393401C2E88C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAC312EBCE;
	Tue, 26 Mar 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MR2UFTBe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67805B1FB;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=qAg7mm3TJP3WuVA3u1za0BmBouekmuDrUJI6kRO+PqqmzqWK6+V8oWZmMym6VCtvtsfKGIzVMH38hmQjQGTWRwxwqLXhuxtkcaV1xBsIzT3LDtYmLKTZNXPz8AkOquZBFLjcdetJU4EVyyBmGDSqPlbM7/M/otq4AqrWcw1+L7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=7mgL40AjEE0M+EUMGGkohJuAfYZB2b06SxnfYpnrnD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJEl+1MRgCV1WAyA0BT2GxXHe9FvthtmAlSkH90mwCnCTeRkb0MNCK28OqGgUgKO2qQNGLxhRf6YuEX3KZsoUDaLJK+33ehEYBGykZuO8oGjoGpx7x4WpWTtg2IIKvt5f4DkuaRM+TS7BWDDgBsyF5yO4S3kofBPUTBq7LqRbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MR2UFTBe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444842; x=1742980842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mgL40AjEE0M+EUMGGkohJuAfYZB2b06SxnfYpnrnD4=;
  b=MR2UFTBesaPN8FlkHLJN0VSuY3e4b8OJIPIt+UK3wnOhYvM++95bkfQu
   56u3Gh7T9TawQi5aQlAzGps2MzkIvpZN47ho+ZiWPszxcgr4l8X/Q8yxd
   nFaw+XSUuO9d0pw/6ay17evS9+qcDhpLCIFMpFft1cj7d0f+NkyRWNVpU
   3e7GxuCjdmsbhiVRt3CyKcTGlcxfdF4pymRn4kCryKNEorMKMNgRb3APN
   bMa6wkjK1Wttp78zOL3TLaFOgchpKavGiaXgXxy52Itr2UJ3O9gb94g3Q
   s1de6tjXFlwE/txAyIBsz6NRRVJnubp+L8kq960xjBPTRl2n0LMvrld9k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350347"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350347"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293270"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 4/7] soundwire: intel: add support for MeteorLake additional clocks
Date: Tue, 26 Mar 2024 09:20:27 +0000
Message-Id: <20240326092030.1062802-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
References: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In the MeteorLake hardware, the SoundWire link clock can be selected
from the Xtal, audio cardinal clock (24.576 MHz) or the 96 MHz audio
PLL.

This patches add the clock selection in a backwards-compatible manner,
using the ACPI firmware as the source of information and checking its
compatibility with hardware capabilities.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c           | 43 +++++++++++++++++++++++++----
 include/linux/soundwire/sdw_intel.h |  5 ++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 1287a325c435..e15666962fe4 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -345,8 +345,10 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	u32 spa_mask, cpa_mask;
 	u32 link_control;
 	int ret = 0;
+	u32 clock_source;
 	u32 syncprd;
 	u32 sync_reg;
+	bool lcap_mlcs;
 
 	mutex_lock(sdw->link_res->shim_lock);
 
@@ -358,12 +360,35 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	 * is only dependent on the oscillator clock provided to
 	 * the IP, so adjust based on _DSD properties reported in DSDT
 	 * tables. The values reported are based on either 24MHz
-	 * (CNL/CML) or 38.4 MHz (ICL/TGL+).
+	 * (CNL/CML) or 38.4 MHz (ICL/TGL+). On MeteorLake additional
+	 * frequencies are available with the MLCS clock source selection.
 	 */
-	if (prop->mclk_freq % 6000000)
-		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_38_4;
-	else
-		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
+	lcap_mlcs = intel_readl(shim, SDW_SHIM_LCAP) & SDW_SHIM_LCAP_MLCS_MASK;
+
+	if (prop->mclk_freq % 6000000) {
+		if (prop->mclk_freq % 2400000) {
+			if (lcap_mlcs) {
+				syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24_576;
+				clock_source = SDW_SHIM_MLCS_CARDINAL_CLK;
+			} else {
+				dev_err(sdw->cdns.dev, "%s: invalid clock configuration, mclk %d lcap_mlcs %d\n",
+					__func__, prop->mclk_freq, lcap_mlcs);
+				ret = -EINVAL;
+				goto out;
+			}
+		} else {
+			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_38_4;
+			clock_source = SDW_SHIM_MLCS_XTAL_CLK;
+		}
+	} else {
+		if (lcap_mlcs) {
+			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_96;
+			clock_source = SDW_SHIM_MLCS_AUDIO_PLL_CLK;
+		} else {
+			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
+			clock_source = SDW_SHIM_MLCS_XTAL_CLK;
+		}
+	}
 
 	if (!*shim_mask) {
 		dev_dbg(sdw->cdns.dev, "powering up all links\n");
@@ -403,6 +428,13 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 				"Failed to set SHIM_SYNC: %d\n", ret);
 			goto out;
 		}
+
+		/* update link clock if needed */
+		if (lcap_mlcs) {
+			link_control = intel_readl(shim, SDW_SHIM_LCTL);
+			u32p_replace_bits(&link_control, clock_source, SDW_SHIM_LCTL_MLCS_MASK);
+			intel_writel(shim, SDW_SHIM_LCTL, link_control);
+		}
 	}
 
 	*shim_mask |= BIT(link_id);
@@ -1062,4 +1094,3 @@ const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops = {
 	.sync_check_cmdsync_unlocked = intel_check_cmdsync_unlocked,
 };
 EXPORT_SYMBOL_NS(sdw_intel_cnl_hw_ops, SOUNDWIRE_INTEL);
-
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index fa40b85d5019..8e78417156e3 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -22,6 +22,7 @@
 /* LCAP */
 #define SDW_SHIM_LCAP			0x0
 #define SDW_SHIM_LCAP_LCOUNT_MASK	GENMASK(2, 0)
+#define SDW_SHIM_LCAP_MLCS_MASK		BIT(8)
 
 /* LCTL */
 #define SDW_SHIM_LCTL			0x4
@@ -30,6 +31,10 @@
 #define SDW_SHIM_LCTL_SPA_MASK		GENMASK(3, 0)
 #define SDW_SHIM_LCTL_CPA		BIT(8)
 #define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
+#define SDW_SHIM_LCTL_MLCS_MASK		GENMASK(29, 27)
+#define SDW_SHIM_MLCS_XTAL_CLK		0x0
+#define SDW_SHIM_MLCS_CARDINAL_CLK	0x1
+#define SDW_SHIM_MLCS_AUDIO_PLL_CLK	0x2
 
 /* SYNC */
 #define SDW_SHIM_SYNC			0xC
-- 
2.34.1


