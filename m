Return-Path: <linux-kernel+bounces-90706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB208703A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AD72849B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3050A45BF0;
	Mon,  4 Mar 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg1G6v0T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA23FB1D;
	Mon,  4 Mar 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561219; cv=none; b=UvGMPfHuiPh2nogQzJnrKChHpg+kTTFOuYQFWXwpto85eq/XkJceK8w7NQOMWMz5Y6TCfkl3E5TkDRhrEuWWwXaab6u6g7FIvVFWxcydMXfcA0WNc2x0c0sEx00woMY/LIGopY8Z/HG2q1nQgXY3MVmzC3+jdb8fsKVo0LBxdyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561219; c=relaxed/simple;
	bh=URTHF9Nl3Pd3iMTnwOfXWfyaLmcvXdfv/9NJcJXxRAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzvoHGkaz1sk6kx//PBFWydwnRkMir+N80xqDJZS8+hSCVhsd+ueCSoS8OJmXH1wQ8OMQ7O+SrXKQ3XfQZJprCE4+Cxm/y1nLGN5ruHYoQ2Z5dU8erb9jI4DoJ1EfywdnnQvu/nKEWuci3LzHiZL/uKhqpsu+tOStrvbuwF6u2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lg1G6v0T; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709561217; x=1741097217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=URTHF9Nl3Pd3iMTnwOfXWfyaLmcvXdfv/9NJcJXxRAY=;
  b=Lg1G6v0Tz+y/h0v2tL3Pn4ONzeuaQVyOzvy72j1HXedqboaNjHfql6gi
   jScng8tOOvYKEFO1MAqa0RF/W4o7oBaS8lsJNyu1CmIqs41G3ycqH3pZq
   y3vrq670ZQeAer5Za0P+1rEz62scZpoPLlRfaMdH34ASGy+l9+oUvT6KB
   NFX2XR3XmkkArDXvHPQqcTIVeLU9TsOn03Jf9F8cMOL53fv+6hl4SF8e8
   sZRrWqmhW4AFonEsZbl/q5JeS2pn7/nukJr2n/NwMDh61Mss0+k3vyP8e
   5msG/35GxII+02e0BIXp0EMExT7C5icsqYgG7kc0sD1YJsUFcf3ZY6tjb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4214187"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4214187"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040571"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040571"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 06:06:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3CED215C; Mon,  4 Mar 2024 16:06:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/2] iio: core: Leave private pointer NULL when no private data supplied
Date: Mon,  4 Mar 2024 16:04:32 +0200
Message-ID: <20240304140650.977784-2-andriy.shevchenko@linux.intel.com>
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

In iio_device_alloc() when size of the private data is 0,
the private pointer is calculated to point behind the valid data.
Leave it NULL when no private data supplied.

Fixes: 6d4ebd565d15 ("iio: core: wrap IIO device into an iio_dev_opaque object")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4302093b92c7..8684ba246969 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1654,8 +1654,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 		return NULL;
 
 	indio_dev = &iio_dev_opaque->indio_dev;
-	indio_dev->priv = (char *)iio_dev_opaque +
-		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
+
+	if (sizeof_priv)
+		indio_dev->priv = (char *)iio_dev_opaque +
+			ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN);
 
 	indio_dev->dev.parent = parent;
 	indio_dev->dev.type = &iio_device_type;
-- 
2.43.0.rc1.1.gbec44491f096


