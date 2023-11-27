Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4432E7F9D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjK0KSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjK0KSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:18:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C90EA;
        Mon, 27 Nov 2023 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701080307; x=1732616307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EHjb8a4oKENRdIROHVOuLNb1REGASuIrFu/8GnwvA6M=;
  b=I1kG75vgCflcYYI6RvFpQfTH38L7BxKPxmXkrwQmnaquDw59v+IykMSE
   YuNHABUUXb0JE3owaK0uKNeyR9k9B7SE2CpG5WJsw2/RFulit+Ai8C2Tz
   /68udVlruIfa91OvW7iCCGuaueMHA6wsKY0KanqQMhFcrGjaYFjl7rXJT
   nvSwbluj0e2QsLhMKBycrEXtVzaTB1/9oP8DZXwzsi3ewl3IfUeCgfVB9
   ZJYRlon795lF1/VpcR9Z9i4TcBPFhlkWth860YKOf/uyVHBAxskxK/PwU
   K5Ab72XTX5b2quK/nV5CYILT842dhp7FCkBGlW7a9W8GKCaceU++Hs1bu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="11372970"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="11372970"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 02:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="891690067"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="891690067"
Received: from ssid-ilbpg3-teeminta.png.intel.com (HELO localhost.localdomain) ([10.88.227.74])
  by orsmga004.jf.intel.com with ESMTP; 27 Nov 2023 02:18:21 -0800
From:   Gan Yi Fang <yi.fang.gan@intel.com>
To:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Gan Yi Fang <yi.fang.gan@intel.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net 1/1] net: phylink: Add module_exit()
Date:   Mon, 27 Nov 2023 18:16:03 +0800
Message-Id: <20231127101603.807593-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gan, Yi Fang" <yi.fang.gan@intel.com>

In free_module(), if mod->init callback is defined but mod->exit callback
is not defined, it will assume the module cannot be removed and return
EBUSY. The module_exit() is missing from current phylink module drive
causing failure while unloading it.

This patch introduces phylink_exit() for phylink module removal.

Fixes: eca68a3c7d05 ("net: phylink: pass supported host PHY interface modes to phylib for SFP's PHYs")
Cc: <stable@vger.kernel.org> # 6.1+
Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 25c19496a336..7121503c9259 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3724,7 +3724,10 @@ static int __init phylink_init(void)
 	return 0;
 }
 
+static void __exit phylink_exit(void){}
+
 module_init(phylink_init);
+module_exit(phylink_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("phylink models the MAC to optional PHY connection");
-- 
2.34.1

