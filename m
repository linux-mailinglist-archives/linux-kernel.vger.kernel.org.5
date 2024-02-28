Return-Path: <linux-kernel+bounces-85626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFBB86B86B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BEA1F279B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CDD15F32E;
	Wed, 28 Feb 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRMvfi4G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D315F316;
	Wed, 28 Feb 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149087; cv=none; b=VxEPMyYCtlrjTDh7J1FHs5n5FOWyYsG8nrWidpnRddC+Zd97v0bS/NV0an8yYiNSQLEnz7YP9Dvigg7zhetvPi5CPMq/O7n15OmLHh6+AzOq6v81ZG/GQczQJxffX3f163OhDoF6Uc9iLb3JDw+gW4imp26l7hVVKiiRBNqz1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149087; c=relaxed/simple;
	bh=Ou+j2G4u1McDiltrMDd5BddvlU0WOmjqjYYJXBtphzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOWelIn7gmNLP4bweq4PTyxPEkTSSs7mVulLwHOPohyYMwUwas8wUVL7w76RfSbk07EWnyaIcDhvUIET0gp4WOSJ94YVQQUx0v3jmZ68v2zUUdV7S2nLnn6DCJcClqcUDlZvUXXZENmZTpOd3Ua+4POOzzcSHDenPncBotSPqKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRMvfi4G; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149085; x=1740685085;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ou+j2G4u1McDiltrMDd5BddvlU0WOmjqjYYJXBtphzc=;
  b=LRMvfi4GFQxH/PI9nSxBdPOgce1vSMSAwcf/PsuBwXtBEs8c7q3FTZi/
   bHxANgsIyveIu/K/YrAtcAFpgssXZZWx8XN1rPRv0zm4kxfPLbGSzzESu
   2uZv4Zu7uFGzcRjB3RH85pclNbPhFf6xJ/ZE3bxetdp7lIHrQfZ3xTFSA
   Lp2uZQY6DhhwRvgaGO0UT6adjgIKoxmLemAjDi/b1PsMH6SYO7dwWBa0k
   Fr8wH5D17V5AV6/I2oa5bmEl11WjjDC97g//q0vHa0K5davE/eV6T1Kw7
   Ht69uKTw1IrS4fxJCFLaP3pKgCQ2KeeiGnABaUjSLpmBHw/tvy/CInsAW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14990894"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14990894"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034608"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034608"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 11:38:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0FAF81C5; Wed, 28 Feb 2024 21:38:01 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: oc-tiny: Remove unused of_gpio.h
Date: Wed, 28 Feb 2024 21:37:31 +0200
Message-ID: <20240228193732.3605768-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-oc-tiny.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 6ea38f5e7d64..7d8c5cd680d1 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -184,8 +184,6 @@ static irqreturn_t tiny_spi_irq(int irq, void *dev)
 }
 
 #ifdef CONFIG_OF
-#include <linux/of_gpio.h>
-
 static int tiny_spi_of_probe(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
-- 
2.43.0.rc1.1.gbec44491f096


