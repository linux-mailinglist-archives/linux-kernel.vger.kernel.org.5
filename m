Return-Path: <linux-kernel+bounces-118633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09188BD8A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5311C379D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50D548FA;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGcr//8f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C07482FE;
	Tue, 26 Mar 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444840; cv=none; b=X1CnFEbwlhvTUE65VgCzepCRHrSMq8IHnxbd6xa9/9Lgg77/ZyhiVaOfZRKt2wxe34q+pa0jA4ZjSRzTME8CTKSlHU9WNH+uyTtTccmlAae9ih6DZAXdCdjRXFVpdu9tzy1w/O4GacBskNamblIjNWcHqNk1Wo6huWtfYMD9PTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444840; c=relaxed/simple;
	bh=WiRSAn42/ezrkipYNOyyOGrQPGEGFtC64bdKfjRQmaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2J97ak9lG05Het39rSdIXQP6/6sQpgi5/HbL3HI9GF8FfbmBd0kXJZVD7nZ/gUfPTAvZONzvHu6bC9wmZGzZyIheqFnTPVbHKucWYbnljP/lsBEWrutBwyDcV+Xf8x9cS3HHEllyiSrVcYsfwf7maMARYhlS4iBqCo20GgTIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGcr//8f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444840; x=1742980840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WiRSAn42/ezrkipYNOyyOGrQPGEGFtC64bdKfjRQmaM=;
  b=hGcr//8f9yRcPlHDN0T/OA275aE3SIYLZ2rRYY6mIBIsSc+ay73bciBr
   SwLbkwMI6L0FWR5cEb0poMkOa+QqFxJz5fMBtMcUf6NqUoOYIfqt8ffMi
   kLTJ21PE+JJZtyoYOGP5AxXGW45Q1i9huVBxJ/FVjdWW7ox5ynCqjbZfT
   d2DkFlQ3GtOmUuzy09Lj2LHdUsYRHUo5lXZTMl0P4ooeCZWvKAh3V51uM
   lGzAgBE+rFDnAzzj8qtc0Rn9gce8/2YZgNObQxIpEP8iNOftXzfxdozxG
   GyisYxNZn7m8aTW+7XjvtlUyKGN6m3yu64+lvgQ6bxGkKY/7QltYjUXg8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350336"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350336"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293260"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 1/7] soundwire: cadence: show the bus frequency and frame shape
Date: Tue, 26 Mar 2024 09:20:24 +0000
Message-Id: <20240326092030.1062802-2-yung-chuan.liao@linux.intel.com>
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

This log is useful when trying different configurations, specifically
to make sure ACPI initrd overrides have been taken into account.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index c2c1463a5c53..74da99034dab 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1319,6 +1319,12 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 	u32 ssp_interval;
 	int divider;
 
+	dev_dbg(cdns->dev, "mclk %d max %d row %d col %d\n",
+		prop->mclk_freq,
+		prop->max_clk_freq,
+		prop->default_row,
+		prop->default_col);
+
 	/* Set clock divider */
 	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
 
-- 
2.34.1


