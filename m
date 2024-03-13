Return-Path: <linux-kernel+bounces-101578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A32B87A8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05ECC286580
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED9D45021;
	Wed, 13 Mar 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fp/SyNwZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173043AC8;
	Wed, 13 Mar 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338469; cv=none; b=OdYkvNSjaxwgzueaKOqQFXv/PqQnC1xgyAukIoWZ0c9sHSOG7bLX5KB8TabCJa26WxvZi3yO8NjJWfpvAzgJmYNvISIcDu2p27sYaJYhmR5t+y5cui0sIsgVfSRWWofT7xr07Z0UNrhCeQWxUCF93EMcaAWmZMgRlRSUFGAgHKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338469; c=relaxed/simple;
	bh=Z2ZljK5Kj5Bt/65uyORbNA11jaYxXEraoiN2nsNmfZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EiXmVaMVCXmx4w5f3HHxdkCU4OLfruOin9wcpku2AT/TLWnDOxqlcUJqi8w0Mkowe1xp77jy00rrSNvx81XVln5Gh7lQU89JQPLCLHUhZp7w9HzkDYzON9Ev386M8AHFdbTccb4SOt0WolyV7YCmP/Hc+sTeYgdaf/Navz8pu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fp/SyNwZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710338468; x=1741874468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z2ZljK5Kj5Bt/65uyORbNA11jaYxXEraoiN2nsNmfZs=;
  b=Fp/SyNwZpFpb0tFRQbkZk9LweFg4uUlsDDVN5Llu3TQj4FLzN08OsiGN
   fdZZig7j4srF+HS340rutbTsMSsmFZkSYouyZY79PD1T/o8CG2iVBzUeg
   lqUPUqjr1fFpgXp/XuESihoGiM/7+CF3WUVEnDXSKDF04Z+8JH2/DRman
   2tGL0KNZiaFPKGbVxXMlxqbA/PkvecSwriQiiUXCuUhd5W9K3RrF8Ydrc
   aDnACGMEERCI18bFo+gX4ZcxpFupIg8jmtLj3LQGSlCHRr+XgW2qSkaCE
   xfqC/K4y8L5Ft/yy9U+KC5kuCQZhOqvuqVRzboTVnxoIOh+oiUlH7UPPb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5226034"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="5226034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="937054173"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="937054173"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2024 07:00:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 06F584EB; Wed, 13 Mar 2024 16:00:57 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] net: stmmac: dwmac-rk: Remove unused of_gpio.h
Date: Wed, 13 Mar 2024 16:00:57 +0200
Message-ID: <20240313140057.2088667-1-andriy.shevchenko@linux.intel.com>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 382e8de1255d..7ae04d8d291c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -12,10 +12,8 @@
 #include <linux/clk.h>
 #include <linux/phy.h>
 #include <linux/of_net.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/delay.h>
-- 
2.43.0.rc1.1.gbec44491f096


