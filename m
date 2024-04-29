Return-Path: <linux-kernel+bounces-161652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40CE8B4F01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909392815F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB59470;
	Mon, 29 Apr 2024 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krpiXL16"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065C528F3;
	Mon, 29 Apr 2024 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714351446; cv=none; b=Av/JsniAaKFgZcq+NmEKG/QACIeFKjNApDDyUVnanMHWGfYdVYj6c1qbelhxAiK2fVSWQP8LzxC88XvjvmwQmC8E6UkcWn0mdSyNRzJ8FKBaaWggGn7Dj73QWvaU6Jpwt24PAu8PGPx1DEwd8pjgM7lXmXBL2JSbj8WbMpm47UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714351446; c=relaxed/simple;
	bh=CmBvxj4i2sYdd8JMUHor57gLmcthgmKvMp4PIMBm46U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qyp2SujV+e34P8aGGyINlY5K4K3d//6w4Gi4sedeG18so3jJ0VMCSsQWOzdGQnZtU1lS3XFWms0mB6Ooh/vrdR0o879lJiDOI9gNGasi03fp2xLVSFCSEoOG6OEclgZzJowHso5dLOCOLZuijdiNpcSpao+nzq90/GQuFk2xkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krpiXL16; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714351445; x=1745887445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CmBvxj4i2sYdd8JMUHor57gLmcthgmKvMp4PIMBm46U=;
  b=krpiXL16zseV5H+jpMSL+FpqYp+RjhHJNE6jsuIK9NgD0c+UdzVaY2Kh
   6wQlJykToy6qSaPHD2AtE7hxVWhyEovW7/1h1LP5qu+1I6RJJ5ZYg/jEF
   gINw6XC/ruElF9xV69SsGdleswNLYFxsETNQJk8AnMtcAepiZ1w8UNN/h
   Ih75X0X4vPfmJt30KOesVVhbQ37s0tek//xOptJB17U8O2XfA/cVwTTNd
   LO22gr4XCjDKHiQrdHqpPujt9UwCcgS+Z7tBxwkXlSGTYgDsK2nfjqgcy
   6V8K+vA5Tjr1wQtxw7zn+Glzvajl7Cr44v5AGyHEN3N/eQCNFi4VpDWKc
   A==;
X-CSE-ConnectionGUID: RD8iwX0BT6OhDIUqrfl3hg==
X-CSE-MsgGUID: HT1xVyroTdC9zwQN7sTVGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21152944"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="21152944"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:02 -0700
X-CSE-ConnectionGUID: 4mw2mqMyTzCvsvvl4Ny59w==
X-CSE-MsgGUID: 7j9KE2auRuigNavET/7gJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30423066"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 17:44:01 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 4/4] soundwire: intel_ace2.x: add support for DOAISE property
Date: Mon, 29 Apr 2024 00:43:21 +0000
Message-Id: <20240429004321.2399754-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
References: <20240429004321.2399754-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Extend previous patches with the DOAISE field and property.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.h           | 1 +
 drivers/soundwire/intel_ace2x.c     | 3 +++
 drivers/soundwire/intel_auxdevice.c | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index f58860f192f9..b68e74c294e7 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -59,6 +59,7 @@ struct sdw_intel {
 };
 
 struct sdw_intel_prop {
+	u16 doaise;
 	u16 doais;
 	u16 dodse;
 	u16 dods;
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index a07fd4a79f00..8b1b6ad420cf 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -27,17 +27,20 @@ static void intel_shim_vs_init(struct sdw_intel *sdw)
 	void __iomem *shim_vs = sdw->link_res->shim_vs;
 	struct sdw_bus *bus = &sdw->cdns.bus;
 	struct sdw_intel_prop *intel_prop;
+	u16 doaise;
 	u16 doais;
 	u16 dodse;
 	u16 dods;
 	u16 act;
 
 	intel_prop = bus->vendor_specific_prop;
+	doaise = intel_prop->doaise;
 	doais = intel_prop->doais;
 	dodse = intel_prop->dodse;
 	dods = intel_prop->dods;
 
 	act = intel_readw(shim_vs, SDW_SHIM2_INTEL_VS_ACTMCTL);
+	u16p_replace_bits(&act, doaise, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAISE);
 	u16p_replace_bits(&act, doais, SDW_SHIM2_INTEL_VS_ACTMCTL_DOAIS);
 	u16p_replace_bits(&act, dodse, SDW_SHIM2_INTEL_VS_ACTMCTL_DODSE);
 	u16p_replace_bits(&act, dods, SDW_SHIM2_INTEL_VS_ACTMCTL_DODS);
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 7310441050b1..17cf27e6ea73 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -159,10 +159,14 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 		return -ENOMEM;
 
 	/* initialize with hardware defaults, in case the properties are not found */
+	intel_prop->doaise = 0x1;
 	intel_prop->doais = 0x3;
 	intel_prop->dodse  = 0x0;
 	intel_prop->dods  = 0x1;
 
+	fwnode_property_read_u16(link,
+				 "intel-sdw-doaise",
+				 &intel_prop->doaise);
 	fwnode_property_read_u16(link,
 				 "intel-sdw-doais",
 				 &intel_prop->doais);
@@ -174,7 +178,8 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 				 &intel_prop->dods);
 	bus->vendor_specific_prop = intel_prop;
 
-	dev_dbg(bus->dev, "doais %#x dodse %#x dods %#x\n",
+	dev_dbg(bus->dev, "doaise %#x doais %#x dodse %#x dods %#x\n",
+		intel_prop->doaise,
 		intel_prop->doais,
 		intel_prop->dodse,
 		intel_prop->dods);
-- 
2.34.1


