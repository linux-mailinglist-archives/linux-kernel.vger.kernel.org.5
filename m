Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DB75D03D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGURAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGURAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7AC2D53;
        Fri, 21 Jul 2023 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958820; x=1721494820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZ6LKlQ1eKLJzZ117OvZPucOMpZOmzPiCLf/Siw2rWo=;
  b=OlfaOZQqD7SWfDs2krTBGODU2UjugIcq7tBkmsIQTPkSeb4+Urfg7U1a
   Gu9aQWakytlcSaQacR5cFqEJ/gBjHuHBp82lI9UNdXBgshKhNufyBQukq
   gEZXAYDJBuPK8rsHStQmakgW+B1hkNSdQTaQxR4e55TL14AhIsko+KcGI
   wlz6j6iZgzYEEPZbZo7EoZvhCUbe6zfscA0tj89QUa8iwHifpSkT6hipF
   21Mwx3rH9QEvHU9vElG1YSoI1i0o05Qm5s0/n/GAPCYsmBzqV1ykexyIE
   C+khHwaJnbzbYBCEHonvOXpW73n+zU4PGBZ3uwjm8v26xllpFIIcWDTB+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369739454"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="369739454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754540194"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="754540194"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 10:00:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4CD74370; Fri, 21 Jul 2023 20:00:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 3/8] iio: core: Switch to krealloc_array()
Date:   Fri, 21 Jul 2023 20:00:17 +0300
Message-Id: <20230721170022.3461-4-andriy.shevchenko@linux.intel.com>
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

Let the krealloc_array() copy the original data and
check for a multiplication overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4e45740331ee..6e28c2a3d223 100644
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

