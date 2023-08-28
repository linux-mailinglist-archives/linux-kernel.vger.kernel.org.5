Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B978B1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjH1NXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjH1NWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:22:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8112D;
        Mon, 28 Aug 2023 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693228964; x=1724764964;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D5MgsKcpX/FPTPvHOLU70qPy9lFMe+MChaL85o2pA8g=;
  b=kM8qNFu/zJnL7dvWh1k17IR5zzLXFgxed14B/jNXd0D31OeVXEgLuYj2
   hls6U4hdEtd14juSWciKZsmGnmbWVLLhIeaIDZ0+EwsRr/p0Si7vpXq3h
   JRBmiSnHPYbTqYr7F6cy5R+vAx+w6u7+nzpy44SxYay0iD+uOQuZ1orDd
   aPX28GAbEkRTHaG+uYgbkMD4ytda73C3YXgQwQhWkYLdxAvdABAwTnB0J
   cUMwxy69FAMHfQEFgo+v52pJTdLqNiWGLKfvP3gYaeKFa+x5PjpR0Ej9v
   RJet8bLfABAmWbFQq9DSV9Gy3rXloExI2xejf1YX+IFQolyHEjrLQTkQF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="365302859"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="365302859"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 06:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="861837363"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="861837363"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Aug 2023 06:20:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE776241; Mon, 28 Aug 2023 16:20:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     haozhe chang <haozhe.chang@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to allocate bitmaps
Date:   Mon, 28 Aug 2023 16:19:53 +0300
Message-Id: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
It is less verbose and it improves the type checking and semantic.

While at it, add missing header inclusion (should be bitops.h,
but with the above change it becomes bitmap.h).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/wwan/wwan_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 284ab1f56391..87df60916960 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
 
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/debugfs.h>
@@ -395,7 +396,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 	char buf[0x20];
 	int id;
 
-	idmap = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+	idmap = bitmap_zalloc(max_ports, GFP_KERNEL);
 	if (!idmap)
 		return -ENOMEM;
 
@@ -414,7 +415,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 
 	/* Allocate unique id */
 	id = find_first_zero_bit(idmap, max_ports);
-	free_page((unsigned long)idmap);
+	bitmap_free(idmap);
 
 	snprintf(buf, sizeof(buf), fmt, id);	/* Name generation */
 
-- 
2.40.0.1.gaa8946217a0b

