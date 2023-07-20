Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43175B8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjGTUxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGTUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:53:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C542729;
        Thu, 20 Jul 2023 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689886404; x=1721422404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6VUHMs9iyR3q+BsHrGuAVtYriv4fqBbd4lQJA33WHq0=;
  b=JfpbwqlF96G/QF7k+Xc/7qpht4pg17L6DWsUq2NBOHcCTk5OLWyYEcUk
   vWuIadtNpGrdtcGUXSO4eq2u9GOjL4xgtvOmN2/C8qzqExTPROV3tnnBJ
   ydTDYL16qW73nzBArdacP7/SJIWLB/iqj9fmouv/D+vmb0wIhT0kxWuMY
   vRTWt6mPgeyGPDC1q/I9UD7mC15dtfonLDPcJdMBVZ2gjxEpMOXZ93GR+
   aU2FUyfQztymLUmS9Uxh9GQfqSZun0RxqLqhzT+12Qmrl9OODMp+yeQHc
   J8DpLv0MHjnK0uUMhReLE1gW4/Ww7yzVUjmSLYg5XxWABXgXAozH2fGjL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356846044"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="356846044"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838273931"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="838273931"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 13:53:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2DEEC370; Thu, 20 Jul 2023 23:53:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 1/8] iio: core: Add opaque_struct_size() helper and use it
Date:   Thu, 20 Jul 2023 23:53:17 +0300
Message-Id: <20230720205324.58702-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Introduce opaque_struct_size() helper, which may be moved
to overflow.h in the future, and use it in the IIO core.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c117f50d0cf3..6cca86fd0ef9 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1617,6 +1617,28 @@ const struct device_type iio_device_type = {
 	.release = iio_dev_release,
 };
 
+/**
+ * opaque_struct_size() - Calculate size of opaque structure with trailing aligned data.
+ * @p: Pointer to the opaque structure.
+ * @a: Alignment in bytes before trailing data.
+ * @s: Data size in bytes (can be 0).
+ *
+ * Calculates size of memory needed for structure of @p followed by the aligned data
+ * of size @s. When @s is 0, the alignment @a is not taken into account and the result
+ * is an equivalent to sizeof(*(@p)).
+ *
+ * Returns: Number of bytes needed or SIZE_MAX on overflow.
+ */
+#define opaque_struct_size(p, a, s)	({		\
+	size_t _psize = sizeof(*(p));			\
+	size_t _asize = ALIGN(_psize, (a));		\
+	size_t _ssize = s;				\
+	_ssize ? size_add(_asize, _ssize) : _psize;	\
+})
+
+#define opaque_struct_data(p, a)			\
+	((void *)(p) + ALIGN(sizeof(*(p)), (a)))
+
 /**
  * iio_device_alloc() - allocate an iio_dev from a driver
  * @parent:		Parent device.
@@ -1628,19 +1650,13 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	struct iio_dev *indio_dev;
 	size_t alloc_size;
 
-	alloc_size = sizeof(struct iio_dev_opaque);
-	if (sizeof_priv) {
-		alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN);
-		alloc_size += sizeof_priv;
-	}
-
+	alloc_size = opaque_struct_size(iio_dev_opaque, IIO_DMA_MINALIGN, sizeof_priv);
 	iio_dev_opaque = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iio_dev_opaque)
 		return NULL;
 
 	indio_dev = &iio_dev_opaque->indio_dev;
-	indio_dev->priv = (char *)iio_dev_opaque +
-		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
+	indio_dev->priv = opaque_struct_data(iio_dev_opaque, IIO_DMA_MINALIGN);
 
 	indio_dev->dev.parent = parent;
 	indio_dev->dev.type = &iio_device_type;
-- 
2.40.0.1.gaa8946217a0b

