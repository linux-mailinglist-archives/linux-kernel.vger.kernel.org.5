Return-Path: <linux-kernel+bounces-131915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35586898D88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663391C21252
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5012F5AA;
	Thu,  4 Apr 2024 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIV3m8++"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5F127B7D;
	Thu,  4 Apr 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253365; cv=none; b=aG/rKaXl9sOUYizUcEQsRgeAQ+TP8bkP5LnELHMVt/enu4H6EoOpoUhOv7DOXlMnWH2AvPPabhq4xL1NWnxEiXwAMayJ8cgVRonlI5rqSB/WWTVBw1uFvzFFbs94js4KhQUqkY2ZJ3Z+UvQZA5W5/RHf0rHQq2C/vrdPSy+I+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253365; c=relaxed/simple;
	bh=jrrBn8WsgmiRVg7JSf1dTg4FPbZgIaRf3d5/pes6beA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDQ3zKP8Wsr3poImOoGXwZdWRzY5ySoBdOzbSsYn4xTPwVSub8a2w6E6H3n5eg4xuroWQ1NLnkcxAUr47n50Vh2/l5DN2TKcFiqE0NSUKgwzL6EHwaoVH+AdreWxSmwc+L+4LawHlF0PO4RYkCgT2siVEqOkXzUjPW1qQjY7H7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIV3m8++; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712253364; x=1743789364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jrrBn8WsgmiRVg7JSf1dTg4FPbZgIaRf3d5/pes6beA=;
  b=mIV3m8++kspIwqLS4r2sviAru4/bMN2L+QRnQN31oOJSXSiqHaPVgUKX
   JsSrV3QT+iyoyBnIOHScJoZhe+pGFb6abel0lWisCe0pm+L9B5wEyVkQD
   eDKSggX0spksl5xP72wruxar0tGnKX66cR0t7ZwLTknti6Rj0y7XMyhCD
   m2vLRetVkMj/PgWJ6GLOVIKMYVyIIx52Gw+zSqzPfOek6kSB3l1EDT2x5
   b0A6AgfjKf3z4pTsN09OXtl2n4xjClBqdjzepjVyUNEcvuURfkjjuCXIo
   J0nDtEI9TxD5BQNBiAyQmqhp/KuvndcxpAm8Ts5wZQnjz1xzUDpKqwBJP
   A==;
X-CSE-ConnectionGUID: BsLDQvQAQ6aqcwS+9GqBlQ==
X-CSE-MsgGUID: wTI/hcFGTWex90dKNbv8ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="30025601"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="30025601"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086937"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086937"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 10:56:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4EB0B812; Thu,  4 Apr 2024 20:55:59 +0300 (EEST)
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
Subject: [PATCH net-next v1 1/1] net: mdio-gpio: Use device_is_compatible()
Date: Thu,  4 Apr 2024 20:55:57 +0300
Message-ID: <20240404175557.2470008-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded variant of device_is_compatible().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/mdio/mdio-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 778db310a28d..82088741debd 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -132,8 +132,7 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 		new_bus->phy_ignore_ta_mask = pdata->phy_ignore_ta_mask;
 	}
 
-	if (dev->of_node &&
-	    of_device_is_compatible(dev->of_node, "microchip,mdio-smi0")) {
+	if (device_is_compatible(dev, "microchip,mdio-smi0")) {
 		bitbang->ctrl.op_c22_read = 0;
 		bitbang->ctrl.op_c22_write = 0;
 		bitbang->ctrl.override_op_c22 = 1;
-- 
2.43.0.rc1.1.gbec44491f096


