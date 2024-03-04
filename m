Return-Path: <linux-kernel+bounces-90705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A587039F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C51F283BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E745975;
	Mon,  4 Mar 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Of4woBOf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F343F9E9;
	Mon,  4 Mar 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561219; cv=none; b=qqIRebjPM4M3dqwrPNrV7y2iLZIcSIT/XKHgzWzCMmc42+7ZfZ38clXA+2KNHOX63KB9es4QHU0/7HhNruXQQIKfqKHm8r7EVOarn6hzl2GBUd6nqyC66MRZgWTwsXWDe3iiBcYk3r3b1JaSOU8w8I8W3+lFdH9z5CwCjcoYGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561219; c=relaxed/simple;
	bh=40hCdHKWv2XHazCffDZwn3ICc74hcXXERftpqKcn6VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCZhITKpjjzGLYYBwGK+h9fKFE0stuZywVWgO7BG/sNRd2WS8XeuzI9y2EFukFccAet+j0OnjNW7b0B4HAxuRmZ/2Dw5Xbzj9wZBFsawgarsTSPVTgmdV3V21UxEmClX/eNEYd1PPuw/VWFa10pq2I652SCud//y5l6iM8OTeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Of4woBOf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709561217; x=1741097217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=40hCdHKWv2XHazCffDZwn3ICc74hcXXERftpqKcn6VI=;
  b=Of4woBOf89oUB4qUGe/nyD25L1iwUiOrDJDNzGPMX73ofUuhOYWRWZVF
   BSYOi8QnKNrlJGcwYSlopUTcUP8/b0fULpMLiiTvV0WJWWyisdw5U2q6a
   nTOxC57UcJosx8QBOQrEzlxb97oBe6xUSrUjQLjLN37NFrKmD1AapBq0P
   xEikf6CJu34TM6WSKhTzSvo7dw/mgkHELlLmMY2jKb/o+4GoL4SPoUsxK
   hdtY/Qb6YgT82CgMbyfLa474+DD1XPUypLLJOMfvpDhBTjBUImgrOsQpw
   iFsIA19bYbcImiDqQR6GIXVPc6Cuw1F7pKhqQxY/Lx1XtWUyZzDHoCMRT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4214183"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4214183"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040570"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040570"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 06:06:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 468883C0; Mon,  4 Mar 2024 16:06:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/2] iio: core: Calculate alloc_size only once in iio_device_alloc()
Date: Mon,  4 Mar 2024 16:04:33 +0200
Message-ID: <20240304140650.977784-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
References: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to rewrite the value, instead use 'else' branch.
This will also help further refactoring the code later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8684ba246969..c7ad88932015 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1643,11 +1643,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	struct iio_dev *indio_dev;
 	size_t alloc_size;
 
-	alloc_size = sizeof(struct iio_dev_opaque);
-	if (sizeof_priv) {
-		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN);
-		alloc_size += sizeof_priv;
-	}
+	if (sizeof_priv)
+		alloc_size = ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN) + sizeof_priv;
+	else
+		alloc_size = sizeof(*iio_dev_opaque);
 
 	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iio_dev_opaque)
-- 
2.43.0.rc1.1.gbec44491f096


