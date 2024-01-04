Return-Path: <linux-kernel+bounces-16496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC08823F56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AAB286F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BAF20B27;
	Thu,  4 Jan 2024 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOstGvTA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95520B15;
	Thu,  4 Jan 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704363372; x=1735899372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCrXfWmSxLvasPVqx5bvaAF0h2FNR5wLkTJHVmOM0RI=;
  b=VOstGvTAOg1F3IHa4NSWlzhz4NelAc0PB8oU0LXSVB+rnYyms0oiX8w0
   YGGOjw0zawEx963H1ZkAwTfGDhvDEkRL1/jAGcioQW1QSV9ZihlCSyO1M
   Vi3L14XNZilImGD0V49DKbhcGHZr/OqQVV3P4Ci0CRcnOQs7wEs9+dYBa
   urn/1dPCE3KzKI9BUTz0pShu5NZmuv0yBE9uWoY78IVYfKeizhOTlMo0q
   zqsx+4zcENDHpB8nEHFBBXhyRJ7Kl7V8CPQuN4LubSOuKIinmCacjGcvm
   2dsQ8S1dtrDwaTx5llb88HmHnBGxnN1lJgF1eA3VNMBSlThp1/jeBRWXG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="15831368"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="15831368"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 02:16:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="903761717"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="903761717"
Received: from ssid-ilbpg3-teeminta.png.intel.com (HELO localhost.localdomain) ([10.88.227.74])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2024 02:16:06 -0800
From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
To: Russell King <linux@armlinux.org.uk>,
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
	Choong Yong Liang <yong.liang.choong@intel.com>,
	Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net v3 1/1] net: phylink: Add module_exit()
Date: Thu,  4 Jan 2024 18:12:55 +0800
Message-Id: <20240104101255.3056090-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In delete_module(), if mod->init callback is defined but mod->exit callback
is not defined, it will assume the module cannot be removed and return
EBUSY. The module_exit() is missing from current phylink module drive
causing failure while unloading it.

This patch introduces phylink_exit() for phylink module removal.

Fixes: eca68a3c7d05 ("net: phylink: pass supported host PHY interface modes to phylib for SFP's PHYs")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
v1 -> v2:
Introduce a macro function to reduce the boilerplate

v2 -> v3:
Remove the macro function as it is rejected and fix the
format issue suggested from v1

 drivers/net/phy/phylink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 25c19496a336..4a05cda74d42 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3726,5 +3726,11 @@ static int __init phylink_init(void)
 
 module_init(phylink_init);
 
+static void __exit phylink_exit(void)
+{
+}
+
+module_exit(phylink_exit);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("phylink models the MAC to optional PHY connection");
-- 
2.34.1


