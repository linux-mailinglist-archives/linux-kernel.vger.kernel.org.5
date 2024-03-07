Return-Path: <linux-kernel+bounces-95485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD82874E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7983C2811A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F0C12B152;
	Thu,  7 Mar 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1ACLfxR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69C12A17C;
	Thu,  7 Mar 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811966; cv=none; b=MUVE8aTyW7+35bDhl5dL5AbFZSsYgpkgFRyDM2iSfkxGkXUo2i+MMmMq+z81SO8aHvYNUouFUq+b8Q29lcCCUwdAzl6fRjek5n3zaNHp003sarDeXVBm8Od4xbMzd9SkuFO3J9yMZYBdiCbrFIsUauZzJnZKVm7z2BSm/V8Ha0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811966; c=relaxed/simple;
	bh=k0dfvN+tJI0XvVJH0dc1wQ6kuOATkinoihSnqNDjaq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYh3mAoFx0eeC4XCOJxNTR/Bcp2tAkGTqLg/xzhhxjTe9nb8oOOSM/Kv+xo7jflt5pLQlEQVmn3ja7qtW7D8aeWyXuGG8TQ10xnjbxEUUz1OZ9lZ1GTKNNoJ6yZdgontuPZg9merMEpjAyxkpKXU9RFGyhte2+7w/vQj8VxXzSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1ACLfxR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709811965; x=1741347965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k0dfvN+tJI0XvVJH0dc1wQ6kuOATkinoihSnqNDjaq4=;
  b=O1ACLfxRcBOZUd+n3Ssm6ds1k436dSiyN7fUkpb6mAtDGDwab5KXURh6
   83io97IFAvKKI2p0Z8HK2K8zxHayEOuxaSZbRXfJMOjQPOGjj5yCROZPw
   ybFQI0AwTsAoLD78RaAPFuiW+a+96USGLKT4Z1VZ2CZEn9JCZYOF1Llua
   TBO8pjh5EYKDA2PYZBROg/gdAeu1p43O1IvDPs9XHa0HLqg9H2NqK7zsg
   idCxY7AdAWe7Qq8+20xKrRMenYEXU4+8jLSJEfm2xk16FRaNJEBjO2eDx
   e52mbBeDJfsB1Zuo8asbUrkF6jMzajcP/IXlfmENzFqqFdfwpsE5s8Udy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15120154"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15120154"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045884"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045884"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:46:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B11BD193; Thu,  7 Mar 2024 13:46:01 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mmc: core: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 13:46:00 +0200
Message-ID: <20240307114600.3643948-1-andriy.shevchenko@linux.intel.com>
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
 drivers/mmc/core/host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8f8781d6c25e..48bda70145ee 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/idr.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pagemap.h>
 #include <linux/pm_wakeup.h>
 #include <linux/export.h>
-- 
2.43.0.rc1.1.gbec44491f096


