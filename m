Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6175B8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGTUxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjGTUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:53:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B362727;
        Thu, 20 Jul 2023 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689886404; x=1721422404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X7jl6NvFoo34AY/ks0sUG4wFGR4ZluKuJMLZIOkzWEQ=;
  b=Q6LOFcALRo2GzbOkyGa0U/2/TvFmUoEe8zfrVkzoNDBu7HMf8ndATBLh
   VLpUueWSiP+S/QGVbbnUOsG80OzX588SYGPNg6e5WFaot7lZXAr/RNips
   xNnibfesQZV7hCO9+tmDkl8CKCsTVeTjMwnTRf/rU4hPi8axVXNdX9S8R
   wck9m2gVKgw1a9PEH6SAcNhU27rdbMuv85Ar1eRPdfhwvOZRJYSzNCGVA
   NGeszOIZQxTbxTsuZkezGNmTgXPHo959vQkk3NNccTKZNb2aAVNV/cGb+
   gcgXi57B58olKdu3B9vKPrjGlm9ATnExMZsCy8TQuKcOmGrrzM8+C0AO4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356846041"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="356846041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838273932"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="838273932"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 13:53:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47669516; Thu, 20 Jul 2023 23:53:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 3/8] iio: core: Switch to krealloc_array()
Date:   Thu, 20 Jul 2023 23:53:19 +0300
Message-Id: <20230720205324.58702-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the krealloc_array() copy the original data and
check for a multiplication overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 90e59223b178..be154879983e 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1465,7 +1465,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
 	const struct attribute_group **new, **old = iio_dev_opaque->groups;
 	unsigned int cnt = iio_dev_opaque->groupcounter;
 
-	new = krealloc(old, sizeof(*new) * (cnt + 2), GFP_KERNEL);
+	new = krealloc_array(old, cnt + 2, sizeof(*new), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
@@ -1483,13 +1483,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
+	struct attribute **attrs, **attr, *clk = NULL;
 	struct iio_dev_attr *p;
-	struct attribute **attr, *clk = NULL;
 
 	/* First count elements in any existing group */
-	if (indio_dev->info->attrs) {
-		attr = indio_dev->info->attrs->attrs;
-		while (*attr++ != NULL)
+	attrs = indio_dev->info->attrs ? indio_dev->info->attrs->attrs : NULL;
+	if (attrs) {
+		for (attr = attrs; *attr; attr++)
 			attrcount_orig++;
 	}
 	attrcount = attrcount_orig;
@@ -1521,20 +1521,14 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	if (clk)
 		attrcount++;
 
+	/* Copy across original attributes, and point to original binary attributes */
 	iio_dev_opaque->chan_attr_group.attrs =
-		kcalloc(attrcount + 1,
-			sizeof(iio_dev_opaque->chan_attr_group.attrs[0]),
-			GFP_KERNEL);
+		krealloc_array(attrs, attrcount + 1, sizeof(*attrs), GFP_KERNEL);
 	if (iio_dev_opaque->chan_attr_group.attrs == NULL) {
 		ret = -ENOMEM;
 		goto error_clear_attrs;
 	}
-	/* Copy across original attributes, and point to original binary attributes */
 	if (indio_dev->info->attrs) {
-		memcpy(iio_dev_opaque->chan_attr_group.attrs,
-		       indio_dev->info->attrs->attrs,
-		       sizeof(iio_dev_opaque->chan_attr_group.attrs[0])
-		       *attrcount_orig);
 		iio_dev_opaque->chan_attr_group.is_visible =
 			indio_dev->info->attrs->is_visible;
 		iio_dev_opaque->chan_attr_group.bin_attrs =
-- 
2.40.0.1.gaa8946217a0b

