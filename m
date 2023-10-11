Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362E67C50BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbjJKLCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346600AbjJKLCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:02:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB23C9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022134; x=1728558134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CyglcibgiNb0VhODVxX7aqzQHuGwSaBbHCQgN+Wjg8o=;
  b=QeZInN7qH+x0OHCKGIK1r57f+5M6kbsCWbr+/O5sIdHGW8wo4JYa1xeN
   l2qwX03cGGohpCUi7bcTH3oSrQFYfw46PFQSPyHS3o8CpODog+edhfWsl
   P028Ec+ZX3ZL1V05tdfv23EiekILaHOZ6bY398RjJL591d8EQnMo5hBkc
   EBvkXmDD0imd2jD/53hfMYxmUXpgGvwT/Pp462USyENjm75E/bsY0IkGO
   8hc6voMQ43VXRkBNG0Ws+fD2ihvnUs0jH0LQhTLlT7UOUd+1qcQ/61qwa
   aIpaQquKrzuC+oIKhPV+/8YA3Qwg6X4Sn8FsXQa9mYlaJ5gUdQqK9LQX1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369696908"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369696908"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788960280"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788960280"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:11 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/4] mei: pxp: recover from recv fail under memory pressure
Date:   Wed, 11 Oct 2023 14:01:55 +0300
Message-ID: <20231011110157.247552-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011110157.247552-1-tomas.winkler@intel.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Under memory pressure recv fails due to kmalloc failure,
and if drivers(pxp) retry send/receive, send blocks
indefinitely.
Send without recv leaves the channel in a bad state.

Retry send attempt after small timeout and reset the channel if
the retry failed on kmalloc failure too.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pxp/mei_pxp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index 2dcb9169e404c3bcbbccc7b4..c6cdd6a47308ebcc72f34c38 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -11,6 +11,7 @@
  * negotiation messages to ME FW command payloads and vice versa.
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/mei.h>
@@ -61,16 +62,38 @@ mei_pxp_receive_message(struct device *dev, void *buffer, size_t size)
 {
 	struct mei_cl_device *cldev;
 	ssize_t byte;
+	bool retry = false;
 
 	if (!dev || !buffer)
 		return -EINVAL;
 
 	cldev = to_mei_cl_device(dev);
 
+retry:
 	byte = mei_cldev_recv(cldev, buffer, size);
 	if (byte < 0) {
 		dev_dbg(dev, "mei_cldev_recv failed. %zd\n", byte);
-		return byte;
+		if (byte != -ENOMEM)
+			return byte;
+
+		/* Retry the read when pages are reclaimed */
+		msleep(20);
+		if (!retry) {
+			retry = true;
+			goto retry;
+		} else {
+			dev_warn(dev, "No memory on data receive after retry, trying to reset the channel...\n");
+			byte = mei_cldev_disable(cldev);
+			if (byte < 0)
+				dev_warn(dev, "mei_cldev_disable failed. %zd\n", byte);
+			/*
+			 * Explicitly ignoring disable failure,
+			 * enable may fix the states and succeed
+			 */
+			byte = mei_cldev_enable(cldev);
+			if (byte < 0)
+				dev_err(dev, "mei_cldev_enable failed. %zd\n", byte);
+		}
 	}
 
 	return byte;
-- 
2.41.0

