Return-Path: <linux-kernel+bounces-139316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66CF8A014F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808BF283A79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B1181BB4;
	Wed, 10 Apr 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcAsEi+b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376E181B91
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780959; cv=none; b=qvxtSfqJtc6pFbLspIMdiZe992Hr1P/qIGElnTHYZifuSS68044uHHe5IDNCa22c1T35Wct7ijmd89zMVh5I/dL0uRirWqg+KmFYWXk/+Ql9vHKE8VeBqfgSSHDzPn+HZw+n2cMjejgxCIWwKh3bV3wBEQH84YsNQhXt0sgpGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780959; c=relaxed/simple;
	bh=dNsFXP/xUEJGhapXea9V+sPQ1u8DaQG2ocVdCHYx9z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsU4CNqVsXq1yAmRVfXlAs+jkzO4/BoxInA4JXPqsHDrM0vErZRIxcauL/UTLrT7Vq7S0jh4PBMmKxin4mfuh0Kz5YD55z6//e9yF/06qbWrPwij92fcsScYWzl7eo6pqNrE/YvTjTJLUqweiL28ailr3097rY5LFSSeW6TOEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcAsEi+b; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712780957; x=1744316957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dNsFXP/xUEJGhapXea9V+sPQ1u8DaQG2ocVdCHYx9z4=;
  b=dcAsEi+bTmQoMeQQxNN5dvBJM/MbxRljhdc+vOuonIBT3hXNQ7J2d1zE
   YnofizeivqIV/hAQ9fhTQXDoACUt4j0vis8vrxcEpa97JMVdcpBuD04yz
   AG11GXrPMO0GWcbJ7eFcKDOgSVsP1XE0D8yJfMFLesXZ2QUdxxH3v6yag
   UdT8tSpoZimnM/u0Qwfre3jqKxajvrFnZI5+B7oQkFVYYFTVYrprCE3xK
   Y6HMuGR1U8KN2KoxV9iqr5WKe5ch5bEgGxb7GJTG/8FKRi2d/dxD/BmWk
   Ikzgr1TXJepJl3bPXcXCnAbFFHnXU4qqVgp0HQSU7GJoVGyxv1JUfkbTP
   g==;
X-CSE-ConnectionGUID: GV7oFbPMRxqXOFNrbUk/CA==
X-CSE-MsgGUID: oFX7LsZiTzKLGbl924PhpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8389542"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8389542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095432"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095432"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 13:29:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 357E71A6; Wed, 10 Apr 2024 23:29:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 1/2] regmap: Drop capitalisation in MODULE_DESCRIPTION()
Date: Wed, 10 Apr 2024 23:27:52 +0300
Message-ID: <20240410202912.1659275-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240410202912.1659275-1-andriy.shevchenko@linux.intel.com>
References: <20240410202912.1659275-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'Regmap' should be spelled as 'regmap'. Update that.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-i3c.c     | 2 +-
 drivers/base/regmap/regmap-mdio.c    | 2 +-
 drivers/base/regmap/regmap-sdw-mbq.c | 2 +-
 drivers/base/regmap/regmap-sdw.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-i3c.c b/drivers/base/regmap/regmap-i3c.c
index 0328b0b34284..b5300b7c477e 100644
--- a/drivers/base/regmap/regmap-i3c.c
+++ b/drivers/base/regmap/regmap-i3c.c
@@ -56,5 +56,5 @@ struct regmap *__devm_regmap_init_i3c(struct i3c_device *i3c,
 EXPORT_SYMBOL_GPL(__devm_regmap_init_i3c);
 
 MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
-MODULE_DESCRIPTION("Regmap I3C Module");
+MODULE_DESCRIPTION("regmap I3C Module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index 6aa6a2409478..9573bf3b52f4 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -117,5 +117,5 @@ struct regmap *__devm_regmap_init_mdio(struct mdio_device *mdio_dev,
 EXPORT_SYMBOL_GPL(__devm_regmap_init_mdio);
 
 MODULE_AUTHOR("Sander Vanheule <sander@svanheule.net>");
-MODULE_DESCRIPTION("Regmap MDIO Module");
+MODULE_DESCRIPTION("regmap MDIO Module");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 388c3a087bd9..c99eada83780 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -97,5 +97,5 @@ struct regmap *__devm_regmap_init_sdw_mbq(struct sdw_slave *sdw,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw_mbq);
 
-MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
+MODULE_DESCRIPTION("regmap SoundWire MBQ Module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 159c0b740b00..ea631ac7c7ec 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -98,5 +98,5 @@ struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw);
 
-MODULE_DESCRIPTION("Regmap SoundWire Module");
+MODULE_DESCRIPTION("regmap SoundWire Module");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0.rc1.1336.g36b5255a03ac


