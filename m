Return-Path: <linux-kernel+bounces-91045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA98708DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AD11C2302C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDA6167A;
	Mon,  4 Mar 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dL6t1YZ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5960253;
	Mon,  4 Mar 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575050; cv=none; b=CU99IfD+lrS+TUcq0EtHOH7O9Yhw47bf8Ltj1P0bIVeCB69doDnKUyDqKtSE0BPNnY5qC8noRwpC3LooKj0zZEx4+s+9E7PQ9K0H5ThbmPHJze2pt4WHK3Yr71Yh4H2GBC0CTmDVM7twNgw0z9zJxmylGn0UWAUHdEBECSf1i1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575050; c=relaxed/simple;
	bh=xcbZ8aiTEFcbFkZ7e5ZCEBXrCQumyVXyJRQDCZfqNog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOQVPDBDVcyh4uqGonmEcGCH4J8R8ogZ6EFl7pIfsQ1XHApCd+81aqgYfrSj4ACNianzb5oYjj6+GJkXN1QcoFO/OIdTk3na/jAePvpSkwVgDE7g2Riq0fAOWlllFr6QBxZkOiX/Mp4TNmj/0yJeYhti6G8eO7H1JJCgrk/CyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dL6t1YZ2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575048; x=1741111048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xcbZ8aiTEFcbFkZ7e5ZCEBXrCQumyVXyJRQDCZfqNog=;
  b=dL6t1YZ29/XVATADRR02514mkQOCg1ENcRA8qN5M0KOY7uMbN7rot+Vo
   OQhLMxJmpPPhUgmeGBnLamqXCJvjL2RcF/a4BdsbNjBjTTrcSKlJdihqG
   VGBc9pxn3XtBMkbn25PvVkB1iDCQXPYvCc3+LMZbh6CQFSdiAvLeNnAwO
   C8xmWfQOJUi/pNA0juI7uS5y08fR+c5Ceotab15S9xasdiWgc/L66DVEV
   bR/30GrsNmNk+g8WLLpDz1NevjG3g9Xo3oe/P3qQwErhMAcRjwtFQlFxH
   b3utVilVpJeH7W8zlfIAGRkqjEcy0d8L7EkVY9bWi+EGSqt6nglb3esYL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4210529"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4210529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040911"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040911"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:57:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9714515C; Mon,  4 Mar 2024 19:57:24 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fpga: ice40-spi: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 19:57:23 +0200
Message-ID: <20240304175723.1200249-1-andriy.shevchenko@linux.intel.com>
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
 drivers/fpga/ice40-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index c0028ae4c5b7..46927945f1b9 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -11,7 +11,6 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/stringify.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


