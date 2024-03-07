Return-Path: <linux-kernel+bounces-95524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABB874EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD2C1C21D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1AE12AAEA;
	Thu,  7 Mar 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSpelKMc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BCF12A161;
	Thu,  7 Mar 2024 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814158; cv=none; b=lRPaZNxc6KKnA44QSQ2wyIvi2wuJopg+wGzMqVq8qHlY99zZBgfiwDf4X+71mgYH5GVCrgZc5fZs0FAGNfVayO0Zj/tor9RMcjTNbX7w/XRK6euP7sL2yND30ZxED5/pNqn0BWUtftBKYOUA4Vwhyzx3Z3P9u6r5yR8pn+PBkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814158; c=relaxed/simple;
	bh=PlOPMm8xF8n1k7eqiy+eF9IzthxtTxB/hst1SCDDqWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ewj7SbhI7f1ZzO8lxf/2HK8AgGgAaMg4mpFAq/teAmTpYJfPh0ov4qgKMjSACypYAUMJI5KYXn97wb0QS+CCMTCPQ5kr62/K2NzkHxmHifGOPjI7xyDxiHkVYHX0Ymp/AJSAgTcKT0/+YOLMLh88ySeQvd750F8PczjmUCm+tOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSpelKMc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709814157; x=1741350157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PlOPMm8xF8n1k7eqiy+eF9IzthxtTxB/hst1SCDDqWk=;
  b=YSpelKMcLuntjn7zYkBM2ctN2lZoqhZaliUU6gkSxLEU0sAQ0G7xxlJK
   JzLczoWTOnwhST2msfyF4aCHp21JaBeh7/rXLHkXfcjBhCYe5HTaxyFIa
   wah/PQHrCtY8Jnp4qusVjFEtOFsa/nAX8zYetTzh5Y5DiypRilN1+TWqI
   akTrmaWOnu4UeZzG24tQ/gcTprUdYmRcUffclyq0mdwhFWx2NqjJcE2KO
   6gkHiT9/pTr4QKWz8PddfNvvKax79zg5aOhJzV1b6uxTgyWQWWlXqsDdf
   qfiHU4YXfe7Wgm+zgw89lgNPJoCmqKQu7Lw3QPmvfmwd8BRqPiTqla5Lw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4343015"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4343015"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 04:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045982"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045982"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 04:22:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 89718193; Thu,  7 Mar 2024 14:22:32 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net: mdio_bus: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 14:22:31 +0200
Message-ID: <20240307122231.3677241-1-andriy.shevchenko@linux.intel.com>
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
 drivers/net/phy/mdio_bus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index b765466e767f..8b9ead76e40e 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -25,7 +24,6 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/reset.h>
-- 
2.43.0.rc1.1.gbec44491f096


