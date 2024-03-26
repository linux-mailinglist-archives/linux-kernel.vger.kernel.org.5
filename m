Return-Path: <linux-kernel+bounces-118678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E888BDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AC4B27267
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287B12F362;
	Tue, 26 Mar 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpRINKu0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABD73500;
	Tue, 26 Mar 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444845; cv=none; b=DLh46Z/9+sDfttYXYhOXBkWwh1JC2kZzw0+bxEDXbTacVSoWTorKR0edLfTTMZgw4s1LN4KSRa8f9R80DBipVbFnSxm/gwZkPkPdsod4m1lIqslhQpEkWfy1NJ02ZI6+kjM5sLYibkHsQRNYhBpzuJNipmgULoLfDLSTlhyZCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444845; c=relaxed/simple;
	bh=ZhNVE0cVvxF6vOSto8uaF4d/Wo+PXywhYyMEAUEj+b4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAI10pg/pZatyIgdO/oi5dpcB1vq9t8gwiqv+AN19+cMcnLwmFxqLzhJQUV9hjRNVaAND1VRawWKNRtuxitSYI4chsgxs0g8SK8u60ns9J/CzA9p6qb6eYthVfK8cqkGx01o6pXIKKy+N78o0oSoaVaxs5elp1sUR/PJcFevZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpRINKu0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444844; x=1742980844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZhNVE0cVvxF6vOSto8uaF4d/Wo+PXywhYyMEAUEj+b4=;
  b=BpRINKu0VVJgHo65VqFWEZ/vQU0+uiIBhWDzDHazqOcx81GehFtGi583
   oq59uDJnzH9snWXKGHxJcCzpwKlV0HEi2+lTYMcwE4OkWYzj7uDgSgzhR
   HUhommkpaqiPMzDjonzaUrtAs5jCzOwyCoJmtHRX4NQteCdbwRSajJbSn
   A1vhNfzkPvmG9IvXdi3O7FsAMLqKVoilaZ+2smL3LZOeisNKXY7AESxBw
   xoc5eP0CQF5iWHidn1uBDBbMumXJ4vDXZTuWYIFCEEqa4gbeSzHg6aAgD
   AknyD0a3D1YYmLoFWAybFKC2V8xLDTDmSZQc/GmQAVXSJsHP8w81PxMHv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350355"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350355"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293279"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 7/7] soundwire: intel_ace2x: set the clock source
Date: Tue, 26 Mar 2024 09:20:30 +0000
Message-Id: <20240326092030.1062802-8-yung-chuan.liao@linux.intel.com>
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

Insert clock setup after power-up and before setting up the SYNCPRD,
per hardware recommendations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index d8ae05cf3d57..43a348db83bf 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -33,6 +33,20 @@ static void intel_shim_vs_init(struct sdw_intel *sdw)
 	usleep_range(10, 15);
 }
 
+static void intel_shim_vs_set_clock_source(struct sdw_intel *sdw, u32 source)
+{
+	void __iomem *shim_vs = sdw->link_res->shim_vs;
+	u32 val;
+
+	val = intel_readl(shim_vs, SDW_SHIM2_INTEL_VS_LVSCTL);
+
+	u32p_replace_bits(&val, source, SDW_SHIM2_INTEL_VS_LVSCTL_MLCS);
+
+	intel_writel(shim_vs, SDW_SHIM2_INTEL_VS_LVSCTL, val);
+
+	dev_dbg(sdw->cdns.dev, "clock source %d LVSCTL %#x\n", source, val);
+}
+
 static int intel_shim_check_wake(struct sdw_intel *sdw)
 {
 	void __iomem *shim_vs;
@@ -100,6 +114,8 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 		goto out;
 	}
 
+	intel_shim_vs_set_clock_source(sdw, clock_source);
+
 	if (!*shim_mask) {
 		/* we first need to program the SyncPRD/CPU registers */
 		dev_dbg(sdw->cdns.dev, "first link up, programming SYNCPRD\n");
-- 
2.34.1


