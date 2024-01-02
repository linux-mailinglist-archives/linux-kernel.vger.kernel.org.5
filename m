Return-Path: <linux-kernel+bounces-14064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C40BD821781
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7100D1F21B17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C067137D;
	Tue,  2 Jan 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j50C7MBi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE746A3;
	Tue,  2 Jan 2024 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704174634; x=1735710634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=owUZLX8e6N1Ea2mYuF28sZta4Qhv4DG6XcdueodQEsA=;
  b=j50C7MBiVGPlQ4uzpUjFz7Ffsv+6MWvUORROG8oYBkJiecaDmCkOaL1F
   68QhW0wdYA85OeRXNjm8VW3h6fB5wtENMZnF34Vfu+pzWzXPc8UG9Qru2
   bmhmYoKDCgXX35MnTYxjSzuFW8BO0KsQhwyADlHnh42UFu6XCnu2XuD9b
   GS89Q9qtvMEYNBUrem33E/pxyTO+XPdEXrxNMq/OVdLKjD2cvl9IAtai9
   EytfIqdPqeZSFtQo9TlKARL8+cDZPqLn+xbAEOYW70cEranhBVxOdlHvs
   E9Ies9IvceBXB7Kt8EvyWiVH8gB/pmJsLkGyQ6kW8yBbErC/7UqnCwxNs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="395727015"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="395727015"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 21:50:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="755825659"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="755825659"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orsmga006.jf.intel.com with ESMTP; 01 Jan 2024 21:50:31 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id CAC4814323;
	Tue,  2 Jan 2024 11:20:30 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id C6E261600100; Tue,  2 Jan 2024 11:20:30 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] serial: 8250_lpss: copy dma_param using devm_kmemdup()
Date: Tue,  2 Jan 2024 11:20:06 +0530
Message-Id: <20240102055006.27256-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_kmemdup() helper to copy dma_param instead of doing it manually.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 0e43bdfb7459..776ec1ef29d6 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -287,17 +287,14 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 		return 0;
 	}
 
-	rx_param = devm_kzalloc(dev, sizeof(*rx_param), GFP_KERNEL);
+	rx_param = devm_kmemdup(dev, &lpss->dma_param, sizeof(*rx_param), GFP_KERNEL);
 	if (!rx_param)
 		return -ENOMEM;
 
-	tx_param = devm_kzalloc(dev, sizeof(*tx_param), GFP_KERNEL);
+	tx_param = devm_kmemdup(dev, &lpss->dma_param, sizeof(*tx_param), GFP_KERNEL);
 	if (!tx_param)
 		return -ENOMEM;
 
-	*rx_param = lpss->dma_param;
-	*tx_param = lpss->dma_param;
-
 	dma->fn = lpss8250_dma_filter;
 	dma->rx_param = rx_param;
 	dma->tx_param = tx_param;
-- 
2.35.3


