Return-Path: <linux-kernel+bounces-95449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A924C874DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E3E1F23424
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5922B12AAD0;
	Thu,  7 Mar 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxUv+7l4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD491292F8;
	Thu,  7 Mar 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811653; cv=none; b=N3MuzYTS84x1TXq+i5Ba8SLFNAZhHjUDGGJoI9JG8Xu11FMy9Sfk30Zth3Y7h2er2XaSf81RbHbi91pQ8U9VjJkApCZn+jAoMZU0WmOMAXAnnh8+mfCbIu2846rig7iRgmN9RiYdBrCZyYDf00mg577a+kqcSVWqSE9h18D6sXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811653; c=relaxed/simple;
	bh=7gx2xErrRMyLqKhWaASTAlsLnscqOiANcTNWHIjsfDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcctZvuJuSGwu5NPbvuzR78Mr3UISVT6xEBW6GWsntovyUeYG7wHZi7b8XJWBZ17e0chbTb0mb12UxHhioJuYbNZ4KJF/gG8gHbLNbRdRDD1cLkVDqVy98KEme0xM9oi6GjT2/TFGitKv0RMnuHDPwoTh3fkq+xaOzvvAlaNLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxUv+7l4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709811652; x=1741347652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7gx2xErrRMyLqKhWaASTAlsLnscqOiANcTNWHIjsfDo=;
  b=AxUv+7l4Z/OkuvWeOqQXhaejKnb7WCSqgTPqeSCBvtLma3WY9Ilw2sZF
   SwVA/QmDC1br4eB+ZfqTAEVTC/8iitq+Q+a7XXOMAeGXd+aFUqrdKCQSg
   2P4RRH+43Q3HFuyldSm6CsKpoidTlowfd9/s/HWhW6aE2pKJIDTlUoz/k
   gyVUbjYhFdisz8XG4ruF77MhagXFBnnjIwGmtT3+wRY4MLQVGnUkzfPaj
   lYp1sdDzXiZR68j1PhrHVyD8yUhhq5233VI/ca8mzVZ3A9QU+xLBhJpi4
   pVEeBQ1OqqPFmunNYF1u4xGPv39VzDbwrVa2W4E7ICTr6gSRxK9IVL8aF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15119499"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15119499"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045878"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045878"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:40:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E8690193; Thu,  7 Mar 2024 13:40:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_omap: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 13:40:48 +0200
Message-ID: <20240307114048.3642642-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 66901d93089a..6e52889b86cf 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -19,7 +19,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
-- 
2.43.0.rc1.1.gbec44491f096


