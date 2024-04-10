Return-Path: <linux-kernel+bounces-139287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5298A00F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE831F2413C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5855181B87;
	Wed, 10 Apr 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKPXCqnq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C548028FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779238; cv=none; b=kz9B6iB+rmGeIfM0X2w+26CO1EUnLNEpt0D+1XtBTqWuV5SvlyZ+/Mi10N9Ua5wWCPpI/utu6RDTy9Px+8i1KNMdYlfAMpRGUSNOhDp8B5YyxxkiV/J8FMYfzeqb7XoOJH05n3NgHYRrU8f5fwu8i+Rq9ZEw+5gdiY76YektNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779238; c=relaxed/simple;
	bh=1IeCVf9+aXNXWCBU1CVo4m9smkhrxS+c1DXyCGE43xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3AomSbkwF7vzjJeWME5+ChUG4b/uRRxSmjIOrCjPAnIc1L79blrqDwf+LDkznuosfjbg4Ja3y5Mj2s2R60nuxmLoKnoTCjVL8Lax2ebSlj+Ifte1vmjHTHbm8hpbSAQ6099wYp6nJc+sVEJ8Cyw1GttEAe5BgItdOYz6Rx7XwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKPXCqnq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712779236; x=1744315236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1IeCVf9+aXNXWCBU1CVo4m9smkhrxS+c1DXyCGE43xk=;
  b=AKPXCqnqAFS5SjmZ2o59xkCea+pQGB7MsaZtquuV9Jz3qfsRRTjhy1nE
   6FvDyl/XK5Y/6+Rg8+bXZmUTdFgy8tPxg+4fY0KGlO2AdNstfe/qscf4l
   FmsfQjXuw0f7n1NjPR8jBtJaPHMN7cGEZ4DJZtxpQUg71jagf1KxUgkZV
   DlNIeeRqtQ6tWVDJThL8upOmBNCR3e9KbiT1c1uL5ZByDHjUULVtf1SLd
   +jUDjew+B0yQWwSIgPAWa8MO62UVoxifH03Y3KBoF2QK0tqe4fpMfyRqs
   IZHSc/CE8kUkbfX4lnIcBFm19bWwMBtcVY0B+sktRH3Kn/gQQsnp9WIao
   Q==;
X-CSE-ConnectionGUID: nz5r+CdSRw+kAocPRJXhCA==
X-CSE-MsgGUID: tjacIP3tQ+KKmYJPtFxV/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11958768"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11958768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095427"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 13:00:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 98A2B2A4; Wed, 10 Apr 2024 23:00:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] regmap: spi: Add missing MODULE_DESCRIPTION()
Date: Wed, 10 Apr 2024 23:00:31 +0300
Message-ID: <20240410200031.1656581-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
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
index 37ab23a9d034..df6087b16e69 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -165,4 +165,5 @@ struct regmap *__devm_regmap_init_spi(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_spi);
 
+MODULE_DESCRIPTION("Regmap SPI Module");
 MODULE_LICENSE("GPL");
-- 
2.43.0.rc1.1336.g36b5255a03ac


