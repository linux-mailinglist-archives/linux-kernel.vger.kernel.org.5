Return-Path: <linux-kernel+bounces-118664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CB88BDDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36B02E5928
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E300712BF03;
	Tue, 26 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaBQAlI+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1355787D;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444843; cv=none; b=RgAg7I9NmpjoV+96dhx6VnRjMK6nLnadyceB3Ol/1T1gkTXNznmTFoLgooN31w4w0g9ZgXolUDNlXz59y+gB8DeKe1zZMcfPWhSe4UTal6aKCBWCKDjsIXvW39M3fkc9X/6KFUeJvBnTHb7/TyqzaCNpQqsugneUaXHONI+ZDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444843; c=relaxed/simple;
	bh=UcBRdyJoV3HQmcqcxz4QCVsNvKgyu4qgE3ILvcUwU0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhrIMPEKV6BcCb1+Y+Pzy1mpENPEYVDXnGb7xvJM1798q3b0wcxa6zoxYUDlKz76SNZ/+S7ZPRRTCesthOS9PcLe0Bb3oKmdcfXje1IuvinRvG2NBOokXIr4qgsywjv+2FXycDy/nO3z4F8U8QHQfaYeJdHehEs+c+E1fBhtg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaBQAlI+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444842; x=1742980842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcBRdyJoV3HQmcqcxz4QCVsNvKgyu4qgE3ILvcUwU0k=;
  b=VaBQAlI+UUQymwO3oFKEBzKVwWHueGMhrWcHlAu7zNBODxPy31RNnBH4
   uDdD0FM2MXfzX8PjbbsF6+oJEbBF4KjOPJ6ZH3KOhpNYxcqo6zg4FanGN
   FanPCN9w3obB1DZUi+G/4EaxDl9Z46LvgXAFma5oYbIjuSHS8EgYAQh7x
   /Wb0mJNS+lssvEDuTrdHN33UWrmgPYp2HX09DRJCYO9eho5c+hx1a1HSF
   1zf4OJEjW1tSb4400uWGz2De4Ruyed62xtNreiLdB9Vnu3rS8rqwa8dsx
   X09HS3gNdT/3dUalfHpqj1CCdzhi8XMDo2nD0C+2sK0ZT6UAYsf8Z61uF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350349"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350349"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293273"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 5/7] soundwire: intel_ace2x: move and extend clock selection
Date: Tue, 26 Mar 2024 09:20:28 +0000
Message-Id: <20240326092030.1062802-6-yung-chuan.liao@linux.intel.com>
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

The input clock to the SoundWire IP can be
38.4 MHz (xtal clock source)
24.576 MHz (audio cardinal clock)
96 MHz (internal Audio PLL)

This patch moves the clock selection outside the mutex and add the new
choices for 24.576 and 96 MHz, but doesn't add any functionality.
Follow-up patches will add support for clock selection.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index 8280baa3254b..abdd651a185c 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -74,20 +74,29 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 	struct sdw_master_prop *prop = &bus->prop;
 	u32 *shim_mask = sdw->link_res->shim_mask;
 	unsigned int link_id = sdw->instance;
+	u32 clock_source;
 	u32 syncprd;
 	int ret;
 
+	if (prop->mclk_freq % 6000000) {
+		if (prop->mclk_freq % 2400000) {
+			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24_576;
+			clock_source = SDW_SHIM2_MLCS_CARDINAL_CLK;
+		} else {
+			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_38_4;
+			clock_source = SDW_SHIM2_MLCS_XTAL_CLK;
+		}
+	} else {
+		syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_96;
+		clock_source = SDW_SHIM2_MLCS_AUDIO_PLL_CLK;
+	}
+
 	mutex_lock(sdw->link_res->shim_lock);
 
 	if (!*shim_mask) {
 		/* we first need to program the SyncPRD/CPU registers */
 		dev_dbg(sdw->cdns.dev, "first link up, programming SYNCPRD\n");
 
-		if (prop->mclk_freq % 6000000)
-			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_38_4;
-		else
-			syncprd = SDW_SHIM_SYNC_SYNCPRD_VAL_24;
-
 		ret =  hdac_bus_eml_sdw_set_syncprd_unlocked(sdw->link_res->hbus, syncprd);
 		if (ret < 0) {
 			dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_set_syncprd failed: %d\n",
-- 
2.34.1


