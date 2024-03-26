Return-Path: <linux-kernel+bounces-118677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4888BDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A9B1F61B89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F79F12F367;
	Tue, 26 Mar 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DalBRawg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F76EB5D;
	Tue, 26 Mar 2024 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444844; cv=none; b=cYvLYXUeA/IeuFQcCahnhleGzoI2Tfz3g5SYKHF6y0rXjd1v9ib+6Gnz+CWdOt1mQBWj7l7PJdBlvwSX9i5MhfEGWKG37i1tWXA3+taTYd0nF3hzO9MMp6+Qa43sP5TYEPcrv0ajMgHJFOD8EG+4s2SWCbIvwQyehUEM4IW+C9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444844; c=relaxed/simple;
	bh=mdY+qN4GAR+ss2nS6CPajyAVe6IOMmz4Ot6WdWDjdGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TY+ZVcqAeixeloZZEUprlFfAZqmY6bGy8PKS9chfup39WMTTkAVeOCNkZz/+SCeiQh17fInDenyjpm5Dv/Od8BIKy/G1qXj0gHTzzGgre2IM2YbRA9CF30agjjx6NcxGceLldnilVvt/uM3zyYUkiUGPQ1qlTG1ewmTXTLLvyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DalBRawg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444843; x=1742980843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mdY+qN4GAR+ss2nS6CPajyAVe6IOMmz4Ot6WdWDjdGs=;
  b=DalBRawg+6tDiRN1HG+efHFB5bbJRcQ0PAZyDnTSmLE1xM7EZi4QUj9l
   X+GpNMeGK52F97ynonwN9yWZLsJIT62lcF+JzW7ocCbBFYYFZVCHBYXAM
   qMq1Hz8ald6/VQmEfcvfdCxhO09XcvkAokMIwIRsjFM0IYnbFxWvollbS
   UfHdq4x06xz9ULBkEKEGm/GvPmMPSje5XVLMDvO+I7OSPizMBoVQ1tLPF
   AjM/Kl6jeDlnbt1g5RCyZv8mQDcvJtilgWqHUVHREjLJBohWmsO0t6k2p
   XsG5NPKedKGfEEPwTWG4XpO46L8VbfhMDAGFw1+WJpn56KGIviDTodtYB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350353"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350353"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293276"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 6/7] soundwire: intel_ace2.x: power-up first before setting SYNCPRD
Date: Tue, 26 Mar 2024 09:20:29 +0000
Message-Id: <20240326092030.1062802-7-yung-chuan.liao@linux.intel.com>
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

The existing sequence is fine if we want to only use the xtal
clock. However if we want to select the clock, we first need to
power-up, then select the clock and last set the SYNCPRD.

This patch first modifies the order, we will add the clock selection
as a follow-up.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index abdd651a185c..d8ae05cf3d57 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -93,6 +93,13 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 
 	mutex_lock(sdw->link_res->shim_lock);
 
+	ret = hdac_bus_eml_sdw_power_up_unlocked(sdw->link_res->hbus, link_id);
+	if (ret < 0) {
+		dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_power_up failed: %d\n",
+			__func__, ret);
+		goto out;
+	}
+
 	if (!*shim_mask) {
 		/* we first need to program the SyncPRD/CPU registers */
 		dev_dbg(sdw->cdns.dev, "first link up, programming SYNCPRD\n");
@@ -103,16 +110,7 @@ static int intel_link_power_up(struct sdw_intel *sdw)
 				__func__, ret);
 			goto out;
 		}
-	}
 
-	ret = hdac_bus_eml_sdw_power_up_unlocked(sdw->link_res->hbus, link_id);
-	if (ret < 0) {
-		dev_err(sdw->cdns.dev, "%s: hdac_bus_eml_sdw_power_up failed: %d\n",
-			__func__, ret);
-		goto out;
-	}
-
-	if (!*shim_mask) {
 		/* SYNCPU will change once link is active */
 		ret =  hdac_bus_eml_sdw_wait_syncpu_unlocked(sdw->link_res->hbus);
 		if (ret < 0) {
-- 
2.34.1


