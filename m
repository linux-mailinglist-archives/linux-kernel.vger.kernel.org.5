Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEABD79BAB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbjIKVPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbjIKN0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:26:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF85193;
        Mon, 11 Sep 2023 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694438768; x=1725974768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w2O4DOForLOBD972plg8SkHtF5rbvO1/RVyOeTLB/28=;
  b=k84mOjbaUsu2MkY23gCCUaECSC4zw34UdoREcCpNS4w3EFUw/Auwn6Zr
   CkuNeQchQTSZHeFJf2x0nhQbq+pIRmPAVb/Wk0ARUtUstUh2cLGca9Fo6
   Fdq7GqdtEFkgH+P8nnN9bAO1mQiKzfxp+gLR7ODSD74F+tKDwet5miVcA
   sh2WsGS9aj3S36vV9li+BmQsLVHeKpT064jPKDgtnWSwQqHNQDhkQagpR
   gEzGS/h0WemmG6q1I4jIBbYuJP006WqHJ3g04QvmYJ05MiAnbXb9GNbpy
   uCvm7Ra4EU2FEWBwJKt24oZFnStnL1pvjcddkIp2voWvm/pyQ2fXj93Kx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="376993288"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="376993288"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990092689"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990092689"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2023 06:16:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 328189E2; Mon, 11 Sep 2023 16:16:19 +0300 (EEST)
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
Subject: [PATCH v2 1/1] wwan: core: Use the bitmap API to allocate bitmaps
Date:   Mon, 11 Sep 2023 16:16:18 +0300
Message-Id: <20230911131618.4159437-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
It is less verbose and it improves the type checking and semantic.

While at it, add missing header inclusion (should be bitops.h,
but with the above change it becomes bitmap.h).

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tags (Loic, Sergey), resent after v6.6-rc1 is out (Jakub)
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

