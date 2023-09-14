Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9666079FED3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjINIrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbjINIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:06:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CDD1BF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694678774; x=1726214774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1p71K//XQ9zZQYmDOllPeza8+3H0XOHh0PahGZw2m84=;
  b=ZSX7IcqGGOQ9cmy6onOrZsMf5+P4Db6/cuny9Mi1qzEHbCTzCYD6TmSr
   tulC7N71SAEfO4rjoU0URWjUFxSGs6H6wewlj+POWlzJ7iBY91UGhaULG
   x10lhofkLFCaXNhAX9QHMOjgAdDZ+8WduifzkiQhO3M/ezWnPZgR784cD
   SUC+dI6EZnSoggyQt5EMLfMTH1mK6jUoYiEYoIF7FhwerclzPyu4331nF
   sL9F2g+T+pbQtVpR3QB4uSKxOnoaps6ZNNb3bLwBy0ZIzULYHhz1joyLo
   Knn6TIO0pRJcN8BDmLsezk2Ox/mujCimjQnw1VZiHSO68HcenmNx6CxGB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="442917396"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="442917396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="887691688"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="887691688"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:05:40 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mei: gsc: add support for auxiliary device created by Xe driver
Date:   Thu, 14 Sep 2023 11:01:38 +0300
Message-Id: <20230914080138.4178295-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914080138.4178295-1-alexander.usyskin@intel.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Add support for gsc mei auxiliary device created by Xe driver

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/gsc-me.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index e63cabd0818d..63525778a4e0 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -292,6 +292,10 @@ static const struct auxiliary_device_id mei_gsc_id_table[] = {
 		.name = "i915.mei-gscfi",
 		.driver_data = MEI_ME_GSCFI_CFG,
 	},
+	{
+		.name = "xe.mei-gscfi",
+		.driver_data = MEI_ME_GSCFI_CFG,
+	},
 	{
 		/* sentinel */
 	}
@@ -312,4 +316,5 @@ module_auxiliary_driver(mei_gsc_driver);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_ALIAS("auxiliary:i915.mei-gsc");
 MODULE_ALIAS("auxiliary:i915.mei-gscfi");
+MODULE_ALIAS("auxiliary:xe.mei-gscfi");
 MODULE_LICENSE("GPL");
-- 
2.34.1

