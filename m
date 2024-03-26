Return-Path: <linux-kernel+bounces-118601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E988BD22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7736C1C2F86F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3383A1D7;
	Tue, 26 Mar 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liaQo0FI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A674524A5;
	Tue, 26 Mar 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443693; cv=none; b=gq0+RPa5MepPH/wrxZffjTYKEoIhTAOFfHKS/RIbCXEx/voPC21JLF4gJ2NOVsafB9N0mKc8Mgb8TvzkhZS7ejxnpfDYgrQ54Px87MbimCyVdf1ExwiwObhfTgHzupBpDvB16HOXmHX4JRM2unsrlFyaj0cSvGTihq2RVz71p4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443693; c=relaxed/simple;
	bh=+HYUy5zkci8d84C5QaD786xmBY7+54jdPAtZC+V/Dcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYiLrFjcda5a2JRcUwrUjIIOt0tbliLk1Agi4kmiXG5Tg0iD89foKkrHIZdfISeDFwwsfgdifl1Xfvhbe6DA3Ex+lU5aHpg9U9MpVV/B8fqJR5Xdnx1pSWkNCqFIhPT9rOxueyAIudXLmbov21gsP+DYdPLgwsy1zwZYtpJWByk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liaQo0FI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443691; x=1742979691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HYUy5zkci8d84C5QaD786xmBY7+54jdPAtZC+V/Dcs=;
  b=liaQo0FIw53TTj5k1DGoBQ2dGYvOfwCBQKAMXjpK7mVU6QTannVASCB9
   xpHtF7teak4xV0mPMiLNGJtdBw3Rb3tc3aZYIcfoYYbKMEYNbmjxq32Hk
   U4yejA0DqP+45yV9Q3WN0nUYRaEHlDsGPQl2o+uxDQsigg6Zei1iC2cVP
   5L8rWONodIUvVi9a5aEVISz01tzvMsnAimE8VxilzYF8z8IWFfS50xOcR
   +0mgdq23yNx42Tp4mYFU06LDMHoeaAYdsJzWiWw+urC5fE1och+SODAxK
   IKArb03Xblfpgz4h6qAp4ykR7xAizEdVFYNnSBNNmfODpaKUJAGMcrQsF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343345"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343345"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614505"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 1/7] soundwire: cadence: fix invalid PDI offset
Date: Tue, 26 Mar 2024 09:01:16 +0000
Message-Id: <20240326090122.1051806-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

For some reason, we add an offset to the PDI, presumably to skip the
PDI0 and PDI1 which are reserved for BPT.

This code is however completely wrong and leads to an out-of-bounds
access. We were just lucky so far since we used only a couple of PDIs
and remained within the PDI array bounds.

A Fixes: tag is not provided since there are no known platforms where
the out-of-bounds would be accessed, and the initial code had problems
as well.

A follow-up patch completely removes this useless offset.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 0efc1c3bee5f..3e7cf04aaf2a 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1880,7 +1880,7 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd,
+		pdi = cdns_find_pdi(cdns, 0, stream->num_bd, stream->bd,
 				    dai_id);
 
 	if (pdi) {
-- 
2.34.1


