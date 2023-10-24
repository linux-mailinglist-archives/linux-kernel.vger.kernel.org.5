Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0162B7D5042
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjJXMuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjJXMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:50:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E410D5;
        Tue, 24 Oct 2023 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151817; x=1729687817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KaitaaTgM9cu8b9iRzHkj5trQ0LrGSk+xNOF3Ya/2bQ=;
  b=HhVzcX/jwDB6uNwqWJX/qTrVtYxgVVUaFSL9U0bCPaVoii8CL/y4rhun
   UEp5U3l7XpWxxigmvhvTItCAcff+wQmc70Ldk/e/YLSt3/Xi9GtvpfwWt
   ZFMQIqmsRWaDs6NjTymt96yioZFv2wx3IBXJD+0XS52D6mVBKR/DniU1Y
   PMiOFR4yEGBpHRP+B2DEpq+oKQwHEDZ6FVAiU12S17f7azmgTeNpAnPeT
   5iGkQsr4DRzf9jzFFL+ZcJwWxeuPfhsJLYJG5JznYMlyWs3UssNEsaMRq
   vZdcI8DWtIh1h15goqQfBf2neZ0oB4nf+gzNa01jkmAG7EveGSaOKISft
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418172698"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="418172698"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="875061013"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="875061013"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2023 05:50:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 725ADBD4; Tue, 24 Oct 2023 15:41:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v1 3/3] serdev: Replace custom code with device_match_acpi_handle()
Date:   Tue, 24 Oct 2023 15:41:15 +0300
Message-Id: <20231024124115.3598090-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231024124115.3598090-1-andriy.shevchenko@linux.intel.com>
References: <20231024124115.3598090-1-andriy.shevchenko@linux.intel.com>
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

Since driver core provides a generic device_match_acpi_handle()
we may replace the custom code with it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 6a1e75f98f16..a5fdaf5e148e 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -665,7 +665,7 @@ static int acpi_serdev_check_resources(struct serdev_controller *ctrl,
 		acpi_get_parent(adev->handle, &lookup.controller_handle);
 
 	/* Make sure controller and ResourceSource handle match */
-	if (ACPI_HANDLE(ctrl->dev.parent) != lookup.controller_handle)
+	if (!device_match_acpi_handle(ctrl->dev.parent, lookup.controller_handle))
 		return -ENODEV;
 
 	return 0;
-- 
2.40.0.1.gaa8946217a0b

