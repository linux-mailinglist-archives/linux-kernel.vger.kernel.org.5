Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236AC754DC8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGPILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGPILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:11:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBBE5D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689495076; x=1721031076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNR7BiCUiBNFCpVAnRrj9NN3OLtXFmOubpJwXXeuHjE=;
  b=OrMlu8M+K9i79ibi2ivzb161KbQLisYbhX86lr1/B8j9omph/z2Abpkh
   U+6CPVbpASNOQx2mIzaUCMWYshyirovpZeyzce+ECTNMm5+sv9vkdvDjp
   qflC/DixJFUuI4t1mUlNXa3BsEVFdYybwp38lM5+uDkvMX8RucjD11ou7
   XCh1GoliIASLS0TxGhtiNCEszyozzHuT+zSdvjVj7xpxEkn5LpVcy0DOh
   ni/KipHc6ZS2QThRYdTQAdtbgTV1YQNM0WC5+eTMkjmrxFalL32JtW0tH
   947WUMhYawzQ/FRsR8pleIb38VoG4RVagJCob+B0pbltV8Y9jKQoN3JeC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="368381701"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="368381701"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="716823131"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="716823131"
Received: from twinkler-lnx.jer.intel.com ([10.12.230.239])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:13 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/4] mei: bus: enable asynchronous suspend.
Date:   Sun, 16 Jul 2023 11:10:41 +0300
Message-ID: <20230716081043.3092690-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716081043.3092690-1-tomas.winkler@intel.com>
References: <20230716081043.3092690-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Enable asynchronous suspend for devices on MEI bus,
required for gsc.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 33ec6424dfee25aacd862fd0..2e65ce6bdec7d9c561ccd2c8 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1329,6 +1329,7 @@ static struct mei_cl_device *mei_cl_bus_dev_alloc(struct mei_device *bus,
 	mei_cl_bus_set_name(cldev);
 	cldev->is_added   = 0;
 	INIT_LIST_HEAD(&cldev->bus_list);
+	device_enable_async_suspend(&cldev->dev);
 
 	return cldev;
 }
-- 
2.41.0

