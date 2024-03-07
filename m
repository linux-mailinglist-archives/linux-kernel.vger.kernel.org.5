Return-Path: <linux-kernel+bounces-95568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914EF874F93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34001C21E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7A12BEB4;
	Thu,  7 Mar 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laSys69l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697D12C550
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816683; cv=none; b=JbPWxjqqHahaLSVDhiYqtX8aW5WQr66fgQ+AsF2ys2bQy5GnYUDVvhTbcUco0ebFyl+IpR0thgZxxJdxFjK7dHYEBZDav2vgdo35jY2lA7fZMZbX88SAuPuAmRCZCXyN+Ybkgy6qbynTJ4J50vl26FQTZJqJ26NqQWvnY9KUN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816683; c=relaxed/simple;
	bh=jCANyFRHGluvmBv/j72/Poax8EPScfUXe9zU4k1OyiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/8mlzEzVFzyp/tcVpuhTf8xe93CZoJGPGzS4Wi1rA0WCmrUdWw118peOC2uQAVRoWBaWJbF1eWhYzKfY8mqiw1BxkOquC0X9bQ+6dSPF6cMQI+UcUprGud0c/LPoO2TeNzJBWRur4YznlCHVgCnG9wXUzBdR8t1Umao/4bfX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laSys69l; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709816682; x=1741352682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jCANyFRHGluvmBv/j72/Poax8EPScfUXe9zU4k1OyiA=;
  b=laSys69l0QePaweQvmvydvDQaPMy4gxK7ac6UVsYOl4rP7zubh1ayP5R
   6s563sJCNPrMD6put69izfp3vopxKwM3s554Et33YyPt+/aO4zgw6GNpM
   qR9qzNzBSd5wqUkbzGV6MZjss2R6zPY1TQ3CM1dyCGllwaGOayVkaxJhE
   hg+teVVaf/8ONJoz4MK7cColuDqfrOuaipXp5UMpWNbybOKPuWnn13ylt
   r0BwBroEdoxTbL6RvK3LsTaMNZQVdcBh/+jWd8XYMxcx5ApZeQyEfumx3
   NPnKMNqrxLsgYHzK+miKFs5pKClvsLBkvd2LK0VZQJHvP8MG8gPuYb1sL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="5068069"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="5068069"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="14592328"
Received: from unknown (HELO localhost) ([10.237.72.159])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:04:39 -0800
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] mtd: core: Don't fail mtd_device_parse_register() if OTP is unsupported
Date: Thu,  7 Mar 2024 15:04:18 +0200
Message-ID: <20240307130418.3131898-3-aapo.vienamo@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the case where -EOPNOTSUPP is returned from OTP driver.

This addresses an issue that occurs with the Intel SPI flash controller,
which has a limited supported opcode set. Whilst the OTP functionality
is not available due to this restriction, other parts of the MTD
functionality of the device are intact. This change allows the driver
to gracefully handle the restriction by allowing the supported
functionality to remain available instead of failing the probe
altogether.

Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mtd/mtdcore.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index c365c97e7232..1cfc8bb5187d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1054,8 +1054,14 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 
 	mtd_set_dev_defaults(mtd);
 
+	/*
+	 * Don't abort MTD init if OTP functionality is unsupported. The
+	 * cleanup of the OTP init is contained within mtd_otp_nvmem_add().
+	 * Omitting goto out here is safe since the cleanup code there
+	 * should be no-ops.
+	 */
 	ret = mtd_otp_nvmem_add(mtd);
-	if (ret)
+	if (ret && ret != -EOPNOTSUPP)
 		goto out;
 
 	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)) {
-- 
2.41.0


