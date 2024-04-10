Return-Path: <linux-kernel+bounces-139318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4388A0151
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD41C231BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B4181D0B;
	Wed, 10 Apr 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+mchgAC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3E181BB5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780961; cv=none; b=X1Rauf8mJCtNKTtyiQhJ17T7v41hHYnuYOjf9ca7eW66NrokqLdDTsGc4LOcG1I/YJ9axaGzFCWiENO840QxdWP3iUuhRLL/CJaR826ty3YzSK3fTr+2D89Sq5t0QVBZi8LBCjx6/E2uRcqG0UdLdleDvz1RgQ1UxwmtwQSq6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780961; c=relaxed/simple;
	bh=rmNQEGrYxvljEmzByVIeuR3/m5YWaxHae8vMwyr5ak8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6h5s8YH9IDHB8sMRVyqpKSltN9VahvWSa4hyMLeO/SogRBHQg1TE9/Lh+n7d2czQ1UpNCy1J0rJAuO/GVa4JsgSM+vaoczuijINxSzSWLh4HuljMpjfLr+cJIn0oHFH1hD+w5qQlfEUd84z7g42y5aWcixXTEBbaOL0+mkPeNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+mchgAC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712780960; x=1744316960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmNQEGrYxvljEmzByVIeuR3/m5YWaxHae8vMwyr5ak8=;
  b=b+mchgACS1M+/fv47KaCcxuwHpMUUXbZXsq1XWIQdNex9toOHV6zzCQ5
   pNZyxRf7w6y8pFo/u4KQNJ5NQpkX5kK8m6MYJQ4RaFy5igIhieLB4C8SL
   35GzDfyVcJr4W8WI9qiT1WXtkrUrgEfhAzlS2Yx/Tked77F5PlEj5zHhg
   wKa2R4Y8ansBrsNxHmIn0z/21pehKfDJjf/Ee5O4nvddYQgyD0kqWMwr7
   m0ntlb8ZlCoZ9yPUG9rNc9/TauPI6g2p538u4KWHXxBQTv6xKpUF36EsY
   y1mNt6qdWSiPFaDPYhjklToW717Ao0snZAD5yfo1ts7K8LvAKhqhT6ftC
   Q==;
X-CSE-ConnectionGUID: LgNn0P++R06frVSBUMUgYw==
X-CSE-MsgGUID: rmP3UF0tQVKJdTAxxCkPyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8389546"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8389546"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095433"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095433"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 13:29:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 442C2317; Wed, 10 Apr 2024 23:29:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 2/2] regmap: spi: Add missing MODULE_DESCRIPTION()
Date: Wed, 10 Apr 2024 23:27:53 +0300
Message-ID: <20240410202912.1659275-3-andriy.shevchenko@linux.intel.com>
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

The modpost script is not happy

  WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spi.o

because there is a missing module description.

Add it to the module.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 37ab23a9d034..094cf2a2ca3c 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -165,4 +165,5 @@ struct regmap *__devm_regmap_init_spi(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_spi);
 
+MODULE_DESCRIPTION("regmap SPI Module");
 MODULE_LICENSE("GPL");
-- 
2.43.0.rc1.1336.g36b5255a03ac


