Return-Path: <linux-kernel+bounces-8026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172F81B0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD7F284D47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75BF208B9;
	Thu, 21 Dec 2023 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7SM2IT5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF568405D0;
	Thu, 21 Dec 2023 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703148888; x=1734684888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1JsXbGf0ei8NX9i8T+iRqjYzH4+nfdAl4Vq6Pu5B8C0=;
  b=d7SM2IT5KxNyNvF0TewpWFy/x+/l5VzHs+oE5p7bXyoj9lvXOdsSTOBj
   6VWW4HlrAubmKtQWolHFUUYxpBn8bGgm4ghq5SQsKuKkNbgmqB4b7ecs0
   GNxweNqr/O6+OHed1/H/SsDyAyK6sM7vXxCkYzI6aAbxt0qwH8mcXV63m
   bQvGUBYAhz2GKhKXqRvKGUA5PpkiIA/+HFBOOn+AMlYZB3KjaCynb84qe
   gZmApuM6Y17qcFMe96Z9yyrCIIVg6NG5JiYI+hbEHN/OdPvw+FlaJCvtn
   NXCsndYvWiUZrNG5QRY7B0fj0NEqZK/0LccMmWsrUNz7z6Fm1z8sDTlQD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2793718"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2793718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 00:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842568348"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="842568348"
Received: from ssid-ilbpg3-teeminta.png.intel.com (HELO localhost.localdomain) ([10.88.227.74])
  by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2023 00:54:41 -0800
From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	John Stultz <jstultz@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Gan Yi Fang <yi.fang.gan@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Lai Peter Jun Ann <peter.jun.ann.lai@intel.com>,
	Choong Yong Liang <yong.liang.choong@intel.com>
Subject: [PATCH net v2 2/2] net: phylink: Add module_exit_stub()
Date: Thu, 21 Dec 2023 16:51:09 +0800
Message-Id: <20231221085109.2830794-3-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221085109.2830794-1-yi.fang.gan@intel.com>
References: <20231221085109.2830794-1-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In delete_module(), if mod->init callback is defined but mod->exit
callback is not defined, it will assume the module cannot be removed
and return EBUSY. The module_exit() is missing from current phylink
module drive causing failure while unloading it.
Add module_exit_stub() in phylink for the module to be unloadable.

Fixes: eca68a3c7d05 ("net: phylink: pass supported host PHY interface modes to phylib for SFP's PHYs")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 drivers/net/phy/phylink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 25c19496a336..823c9b43cd92 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3725,6 +3725,7 @@ static int __init phylink_init(void)
 }
 
 module_init(phylink_init);
+module_exit_stub(phylink);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("phylink models the MAC to optional PHY connection");
-- 
2.34.1


