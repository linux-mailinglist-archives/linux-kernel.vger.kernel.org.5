Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE3E79D1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbjILNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjILNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:13:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F7C10DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694524404; x=1726060404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1p71K//XQ9zZQYmDOllPeza8+3H0XOHh0PahGZw2m84=;
  b=BY3XwLjQs6DwX5TUiY03pymfAO6Si7ni2OnztySAP0I0GPiFwEEOllQq
   769Xx8csTD4hBkNF3bpqg1d/pS4QgSs7nDz/Lymo6jOGkaCjvAkpe3M++
   dI5zVqSAlPAp9IbvqkmMyo+CsjJMpn0b9lvX1eS2X5YhZIzAdBIROO77Y
   qHLu/c8/x1UnqNzmfFZPJ4s6XV48f+OqEhXZt7R7+sRJhgCh/XVRr0eDK
   u86di/6BLpkNolmH1Xc7UdiyUjeQZmS/wz10zBsa47E4Y/xXMvXRY/Jk8
   cAhcJq9VkXmyeD1/JHjHK2TvPGxGoD4qzlx4jSbueJer64ojGItmZHNed
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464740149"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464740149"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737116359"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737116359"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:21 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mei: gsc: add support for auxiliary device created by Xe driver
Date:   Tue, 12 Sep 2023 16:08:35 +0300
Message-Id: <20230912130835.2488728-5-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912130835.2488728-1-alexander.usyskin@intel.com>
References: <20230912130835.2488728-1-alexander.usyskin@intel.com>
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

