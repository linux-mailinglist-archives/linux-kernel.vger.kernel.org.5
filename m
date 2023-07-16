Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB3754DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGPILQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGPILO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:11:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5980EE5D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689495073; x=1721031073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zB+V9Qi0v+Rh+PFDGF+7G57P4cQuD6F5Zlc7SHI8J2k=;
  b=aJV6ES8OVzM78CNzoJJ0vlyCX29qawayNNYVSGBZ/fNJktdc6wT8XkJl
   J5mVVZxEa6dbtIaRB/1jxHBETgfZWSdbKb8d35znLPwPk5toX8nbTkJw1
   CuDG+ux/9G79B5utKIeeGGT/smYZ5S60fmTSpsS5Ym+/2FZwBORGZ+ZH8
   p0qqEAuzO0HNCsufXkColgDs9aV8l8GUHfm9V8Qdyo3OR5qG2EZSWiGU4
   CuBRzMaVZ2a9CGH6InWCTwJ8DsAEeUGpOVYgeVWtl68mML2z9yiL7zz0K
   73+O+rr8WkFQ+cp26QqCIad6Be/4wgub33swhQtavN6hoKoq6xwSV4adn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="368381691"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="368381691"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="716823111"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="716823111"
Received: from twinkler-lnx.jer.intel.com ([10.12.230.239])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:05 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/4] mei: log firmware status on hw_start failure.
Date:   Sun, 16 Jul 2023 11:10:40 +0300
Message-ID: <20230716081043.3092690-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
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

In order to extend debug information log firmware status details
when waiting for firmware ready status fails.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index bac8852aad510b9fb6459001..5cc75a3314a6482e64a1c809 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -157,7 +157,10 @@ int mei_reset(struct mei_device *dev)
 
 	ret = mei_hw_start(dev);
 	if (ret) {
-		dev_err(dev->dev, "hw_start failed ret = %d\n", ret);
+		char fw_sts_str[MEI_FW_STATUS_STR_SZ];
+
+		mei_fw_status_str(dev, fw_sts_str, MEI_FW_STATUS_STR_SZ);
+		dev_err(dev->dev, "hw_start failed ret = %d fw status = %s\n", ret, fw_sts_str);
 		return ret;
 	}
 
-- 
2.41.0

