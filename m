Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE9764F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjG0JO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbjG0JN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:13:26 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D114B449A;
        Thu, 27 Jul 2023 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690448704; x=1721984704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T+ltj6/n0zItDURuD6zDq9RQiKC3xwEfEl0V4qLQniA=;
  b=ip1Ud8RXkfTLVAGOPqQ7Qi4pVLbS09NzArxcaf0r7ZaN6qOOctFr8+Rh
   RLggmbWIFzWB1Ahly9vth/JcGlOglWf1mfAV9nbTcv1szzM1XuvzOLEjm
   4z9yMsaY4VsmDh1/OVI2x+TUeBW8+aQhpa/Z3qrcRR3motIwUjbW08unb
   zrhyvRPsOxR8frR1D/NXb2FCf1nRBAxa9+Lbw1hsztRaULLv01xgykmG/
   9Mwl0kziqF+g4+nOYPOgkNeKE8ejIkjjJxYQDBNEzhBFr4x818D/PCiOy
   DDSWvdnIayEjvo/6mcrbpOJz2eHWZ7BgbJzcZA5rSw060JoLg8gGK0Vwz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365716691"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="365716691"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 02:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="1057645029"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="1057645029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2023 02:05:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9195724F; Thu, 27 Jul 2023 12:05:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: core: Replace strncmp()+strlen() with plain strcmp()
Date:   Thu, 27 Jul 2023 12:05:07 +0300
Message-Id: <20230727090507.81962-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no sense to call strlen() ahead of strncmp().
The same effect can be achieved by calling strcmp() directly.
Replace strncmp()+strlen() with plain strcmp().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_base_bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 6ff59c89d867..bd056e6dca2f 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -21,9 +21,7 @@ static bool serial_base_initialized;
 
 static int serial_base_match(struct device *dev, struct device_driver *drv)
 {
-	int len = strlen(drv->name);
-
-	return !strncmp(dev_name(dev), drv->name, len);
+	return !strcmp(dev_name(dev), drv->name);
 }
 
 static struct bus_type serial_base_bus_type = {
-- 
2.40.0.1.gaa8946217a0b

