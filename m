Return-Path: <linux-kernel+bounces-95441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD40874DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E14281762
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC2F12AACD;
	Thu,  7 Mar 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmiMTaw1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C412880A;
	Thu,  7 Mar 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811582; cv=none; b=DfIc9ZkAvqHH00bg1JjD/7itnEvF84Q0hAxzU0n3UNtDN0SMJRLd4l9fCPIS4bsT5pXGpOdtFHFQsKCij8OMYwbFIUwUsqNbFNGLsjq7Jqrem3iebfYH2eVtQg6V/TUbk1Kn9IGUGvNdJOuJ0zbvMRWbo4KQ6Oqs+o/p3155ZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811582; c=relaxed/simple;
	bh=iqZV3mRl4X6woeXPEVm5WsIKnmDS1fVKh9IZ/j83Cvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqKKCi5a7o0ybw2EMJ2YUd0fGPBT5JvMv7H85kI6oj2LE5qgtpM5sLTqhd4kXNzNy1+kNuAqrwb9ZdTM6WmYt/Z8/lU9S5oEZn6/L4UqOlmuZQkeTFuHOeEbz8B1nbxOm8Fx6XuJhMqxzgHr0XIJM8DBgb0o8Uga6vI8i/gmAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmiMTaw1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709811581; x=1741347581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iqZV3mRl4X6woeXPEVm5WsIKnmDS1fVKh9IZ/j83Cvs=;
  b=kmiMTaw1cH/re/xSqBDGCcX6d6CBWoDBOWXenfXI696CzQ0zLdruv0YA
   36uBXcXqYySo3IHY0hu8Rvsa1xFZcWzhCSCyT0oUzpsV3RrtVmRl20EP0
   kzglAvqx+yLQxyLefIYceYq4O+A2X/Ml60Sv6MjsIUGR6rvydw0v7A4f8
   tnJySPkgYO5Ff/obxYEndpLx36P4YrNAJm7634OFtJQs4x/vuDX8CVNRG
   Hhymf7kA6pbzjo0nR2Ek8OEsmeNQeYZmILrYKOJzEU/3PHu6iLxAGukfX
   +qv1lj9EB2+yGuN6s9aGLrGjFbGDTl2WxMpTH4OHzoz9BvDoaOgrB9ctP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15119379"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15119379"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045877"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045877"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:39:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C3BB4193; Thu,  7 Mar 2024 13:39:36 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] USB: gadget: pxa27x_udc: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 13:39:36 +0200
Message-ID: <20240307113936.3642469-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 61424cfd2e1c..1a6317e4b2a3 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -24,7 +24,6 @@
 #include <linux/byteorder/generic.h>
 #include <linux/platform_data/pxa2xx_udc.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 #include <linux/usb.h>
 #include <linux/usb/ch9.h>
-- 
2.43.0.rc1.1.gbec44491f096


