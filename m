Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEB774A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjHHU3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjHHU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:29:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490B31D474;
        Tue,  8 Aug 2023 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515046; x=1723051046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zJqEmuXZRFYwNy3i9MPLkKcjIG6qYzI1X7jD3nxkn2c=;
  b=G3GYYpSZUsVd6h4r0Aa7Asfu6mVcK89Tqc2FXqJ7h5EgT9dBVskoX49s
   n1cu3u65KdbhhpoTF97Mo6WLoW3fNdKHKIv8WUkiAwg16zHaRTCxYTGbH
   1IXmCHgwopAMczejc2Y7+Hz9mRe9wf8Xf3UitBsOKaf1DBRrJ4BKxx6Fi
   GDXMerUH8GFse1DYFkshg1tqmyxmzhKZ71a2nEeS4mEak3bBFnGhQ9rKY
   3UTojXyvAvlZPn3aHr8/osCvGXGChkOMNnSb9d8Kyk77txXhrJryOu83f
   VTbo2qqnsi9/AAI/nYh93vd4bF7QI6PrA4+3zBfJZzJLmrWBAC5VTtX/F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360970374"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="360970374"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:24:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845525001"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="845525001"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 09:24:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35C26133; Tue,  8 Aug 2023 19:28:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/6] device property: Use fwnode_property_string_array_count()
Date:   Tue,  8 Aug 2023 19:27:55 +0300
Message-Id: <20230808162800.61651-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use fwnode_property_string_array_count() instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..3bb9505f1631 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -473,7 +473,7 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 	const char **values;
 	int nval, ret;
 
-	nval = fwnode_property_read_string_array(fwnode, propname, NULL, 0);
+	nval = fwnode_property_string_array_count(fwnode, propname);
 	if (nval < 0)
 		return nval;
 
-- 
2.40.0.1.gaa8946217a0b

