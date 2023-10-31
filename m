Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E195F7DCF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344495AbjJaOeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbjJaOeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:34:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73790DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698762849; x=1730298849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QbV3DUBys1UmgK8sfourJ8nZWaO+xnRgwCCHjxRv6fQ=;
  b=LhuuN3inYVzU/L3jiRKySRLgUkt3yQPaFSIFhFOAT5guSor+Rf7+yIb8
   cpe+12jnbXlx6rNeOAMJMxMblnKzfqDI6pyKcSbkza4+6vqB2ElY4PISa
   48j+UbcoKXsr0tqAYd6gfHUZ70deiMpb978NnrVuBRt6IR4rRYly+/2hm
   m75wCEixotl5Ys9bzov2hDJVJBUkt0hTiOsJccuoz6ddcV0yjX/BG3efj
   6bEU6EIkjKXjT9RoahRiYsXuhvJ68RZkq+kx5xHJFzYZU0zgj6gbKAmK3
   THGsm60CWH1hdJtdrwqtw1f0/gqAKd/wBal3NwRGgOXsnusbrX/nHPha5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="474538640"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="474538640"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 07:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1092027480"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1092027480"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 07:33:20 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: pxp: fix mei_pxp_send_message return value
Date:   Tue, 31 Oct 2023 16:33:07 +0200
Message-ID: <20231031143307.165612-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

mei_pxp_send_message() should return zero on success and
cannot propagate number of bytes as returned by internally
called mei_cldev_send().

Fixes: ee5cb39348e6 ("mei: pxp: recover from recv fail under memory pressure")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pxp/mei_pxp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index f77d78fa50549e69f0a0873b..787c6a27a4be60f9322c6aad 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -84,9 +84,10 @@ mei_pxp_send_message(struct device *dev, const void *message, size_t size, unsig
 				byte = ret;
 			break;
 		}
+		return byte;
 	}
 
-	return byte;
+	return 0;
 }
 
 /**
-- 
2.41.0

