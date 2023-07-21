Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E675D040
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGURAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGURAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475D2D50;
        Fri, 21 Jul 2023 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958822; x=1721494822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=325fM0IBOgfY/NJbM2dkuOlixnwd7vBQ+WpRaNaNsK8=;
  b=gxxPMgVVf1JbTpB/O0sLo1UMWeWa/WioPDv+UN2tKOBoHQ/tIM6yS4yB
   zdG6SvnynUs935J51NsCXczSQqheCWIkdzNruU1etRintTPYQB7RFjD2Q
   9/VINPXhpFc3WluXAutFQXJmpKRwBm6S7SA61+9oFyyHhcI9CKWwkb++e
   wxdeWr17cvHLLt7FO5s7AELfe6d90WEaZMMJl3S2NxCkFywJkgUXhBuO8
   IDOJb8uICqxOcHcNLbl27FAoarj71jaBMRKX5OkQ8GkLwKfS/IHWjvhHn
   atwRpvXk0itS1JCw8igUnWM8shNiVFBgzzEoHlyP/QRgpeXndZNWUsDZO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369739478"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="369739478"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754540212"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="754540212"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 10:00:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E87E604; Fri, 21 Jul 2023 20:00:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 5/8] iio: core: Get rid of redundant 'else'
Date:   Fri, 21 Jul 2023 20:00:19 +0300
Message-Id: <20230721170022.3461-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 78cc67efa490..66cea23df7e0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -524,7 +524,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
 	i = e->get(indio_dev, chan);
 	if (i < 0)
 		return i;
-	else if (i >= e->num_items || !e->items[i])
+	if (i >= e->num_items || !e->items[i])
 		return -EINVAL;
 
 	return sysfs_emit(buf, "%s\n", e->items[i]);
@@ -1217,7 +1217,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 					     &iio_dev_opaque->channel_attr_list);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
 			continue;
-		else if (ret < 0)
+		if (ret < 0)
 			return ret;
 		attrcount++;
 	}
@@ -1255,7 +1255,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 		kfree(avail_postfix);
 		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
 			continue;
-		else if (ret < 0)
+		if (ret < 0)
 			return ret;
 		attrcount++;
 	}
-- 
2.40.0.1.gaa8946217a0b

