Return-Path: <linux-kernel+bounces-139317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D018A0150
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCD3B27B61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAD181CF8;
	Wed, 10 Apr 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl2sf/qm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D6181BAB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780960; cv=none; b=ge7Wr0UvSTtjjrazavnShIhwtHkuQts5oHrlYNC4pDo9BZLnhG2jSKP+mIkbUBpdNbM0BBMHxkMT1sWuxl80Ir/IkTjdM1OKKnRiFEkDUUMS00rR0X8RYOE1gktYBKsnFstBMJbjWc32DZIgohlPxmE9CIO45xb5LvnXV2I7wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780960; c=relaxed/simple;
	bh=WXMblEkxkN8ClN8vRCjrvpw0eg+cv/scapgPMYFh3LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZt/HR+DxdKyAymUCRltePbrjJLmZQOZL7U76lyHfh1K+D3Gv2iXzlS4yZtLXdb8su3VmErVo3n3qhVyPMop0kGSa/j2G0NboFUGvUuiOXYYrUqKgNTwa7TtPzSeaC3p8KllEEMU6bnnylEp2zaoePoGOUwp4yRVEBVQO7XCKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl2sf/qm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712780959; x=1744316959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WXMblEkxkN8ClN8vRCjrvpw0eg+cv/scapgPMYFh3LA=;
  b=Wl2sf/qmcTYAz4zs3VcIxVjAfO4PRvhRGzViOzpX5TUPNBM/Ld7Ry5P1
   Ia3yBNH4Mb+uk1qJW3vT43Y9V6qWeVntWCcfulJilxT2TaGFINPnfNC9O
   lR5AD1RAUWK/vJ+rebrncfCdc8X4Fo1uwr2M5M22htXFYYpnN1rnFaum2
   1tcEsicAxebzz2nQ5DHKsMCoSOhqluQm8SledpkFhRD5Ko87xgjVLlG3y
   0e+5qMEYQBruwcDjYFwF++sUEDx89IwQlLz9OvuGhgiRFG8+XoQ+6goC6
   Jlfto9B1berX1LmDVjcQfIP3m9zNFZmmt7oR+o+/le7GA/7BOCqnTphKH
   w==;
X-CSE-ConnectionGUID: vXJ8ko58RRqmvvyiAPpcXg==
X-CSE-MsgGUID: R/+nCuoQQ16FzKJSKxDgDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8389550"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8389550"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 13:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095434"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="937095434"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 13:29:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 247512A4; Wed, 10 Apr 2024 23:29:13 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/2] regmap: Amend MODULE_DESCRIPTION() texts
Date: Wed, 10 Apr 2024 23:27:51 +0300
Message-ID: <20240410202912.1659275-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of MODULE_DESCRIPTION() text related changes.

v2:
- added first patch to change spelling (Mark)
- updated second one accordingly (Mark)

Andy Shevchenko (2):
  regmap: Drop capitalisation in MODULE_DESCRIPTION()
  regmap: spi: Add missing MODULE_DESCRIPTION()

 drivers/base/regmap/regmap-i3c.c     | 2 +-
 drivers/base/regmap/regmap-mdio.c    | 2 +-
 drivers/base/regmap/regmap-sdw-mbq.c | 2 +-
 drivers/base/regmap/regmap-sdw.c     | 2 +-
 drivers/base/regmap/regmap-spi.c     | 1 +
 5 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


