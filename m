Return-Path: <linux-kernel+bounces-118605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9610588BD26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6CAB23A22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA96BFA8;
	Tue, 26 Mar 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5zDplU9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BD5C911;
	Tue, 26 Mar 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443696; cv=none; b=bktc5+uVGcQ5Sw6AYQ7FavQWjcf4uqhcfpMkoITDb5IhLhExI2MTuw4xFKNQ5/gio6KYe1ppNq2RCF/XlvoLPX28b+p1eTTNqxg3yarZExmabIj14ESkGYT18YvAa967QVSpInrG9jvAR6aS5b268KOld+40ZCusqXce6iuIHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443696; c=relaxed/simple;
	bh=OwV2DViqKNpY+wJYMRMqIvYxqDnYa84ECaPStIbjYhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7WE6Rj10yGqtUeayggufpOZLDqCYnel1A832xW/J55LHItdkP1gXp5ufPr7LFO6hnjonAl4OAFy5zBKDHaxJibTJKnZYnIzPiYH2kvRx5P9VSaGgB1SdyUUtYNUD//W/YZlL1Xl5JSYZGbf9D8l0928WN1AFuBqxE6+IJ9St64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5zDplU9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443695; x=1742979695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OwV2DViqKNpY+wJYMRMqIvYxqDnYa84ECaPStIbjYhE=;
  b=V5zDplU9TjjbZoYddwNl6Kl2XajC3liLIYE0yzkDmyDqszjAIctzAWJw
   ZvWAKS+nVyWJ4J5ExX2+tE/BsuG0nZUakRogsK4k6b3ERtcnpkGYm62Bt
   TjqSQJaShlffO5szlPtl/Hv1U/GBXuF5odm+J6Ds9PChwUMGCSaWUoPHN
   CUD9/Nz7BSsgqmr8Ws+TJ3hv+JzB6w1RHhOh2/LgVPA86icv6o7xESx0/
   yr0hXz/iGTNA0YgWlsSqOJJrrgfU5b1k/R9WCcHEM80xF8gYXmh+hERYu
   iv+OIqDMEV9SdSVLvOERXDrBGp37T1IGBnqQTAIm7USDp72aR15cpHXIC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343359"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343359"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614518"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 5/7] soundwire: clarify maximum allowed address
Date: Tue, 26 Mar 2024 09:01:20 +0000
Message-Id: <20240326090122.1051806-6-yung-chuan.liao@linux.intel.com>
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

The existing code sets the maximum address at 0x80000000, which is not
completely accurate. The last 2 Gbytes are indeed reserved, but so are
the 896 Mbytes just before. The maximum address which can be used with
paging or BRA is 0x47FFFFFF per Table 131 of the SoundWire 1.2.1
specification.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_registers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 138bec908c40..658b10fa5b20 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -13,7 +13,7 @@
 
 #define SDW_REG_NO_PAGE				0x00008000
 #define SDW_REG_OPTIONAL_PAGE			0x00010000
-#define SDW_REG_MAX				0x80000000
+#define SDW_REG_MAX				0x48000000
 
 #define SDW_DPN_SIZE				0x100
 #define SDW_BANK1_OFFSET			0x10
-- 
2.34.1


