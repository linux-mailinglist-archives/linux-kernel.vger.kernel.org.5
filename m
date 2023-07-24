Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D375F426
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjGXLCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjGXLCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:02:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBE21A2;
        Mon, 24 Jul 2023 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196528; x=1721732528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=knWfonp+Irc22tGc7fH1YtzHMLxiJcg4IV2GgKYEb+M=;
  b=GP9Ylxq/NvmyQE2GuXW+1tGgB0qaiCmdh8TLE763E2QvgvksijVXdwhy
   3u6KA9TiiJuO9VkZWhMfUcz6463n6QlwaefFvFV41hfi57X49SizOJ3Or
   pEtK0x0sLPNsJ4hdj7d7Cf8lAM7uE3kOGGJ8cp441nmgvBrDr4fdPQFvo
   XKk4ZzBf/WogasZODq4Ei3rkUXNHyKJ7VBMrwAjHJt3LXjHdLYgllbyeO
   5uiJnphbTxYmqV9uV98MazY5ji9sT8cl7jzGM4IjsVAKhZniSPc1CNrsG
   2riy9MPhsEgK0RizjHBY9lmGagN0R4jT2A5npYZPR2XWhnCvgugE/D3hf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347012828"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347012828"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775355"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775355"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:01:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2CF31FC; Mon, 24 Jul 2023 14:02:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kees Cook <keescook@chromium.org>, Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 2/4] iio: core: Add opaque_struct_size() helper and use it
Date:   Mon, 24 Jul 2023 14:02:02 +0300
Message-Id: <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce opaque_struct_size() helper, which may be moved
to overflow.h in the future, and use it in the IIO core.

Potential users could be (among possible others):

	__spi_alloc_controller() in drivers/spi/spi.c
	alloc_netdev_mqs in net/core/dev.c

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b153adc5bc84..118ca6b59504 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1607,6 +1607,24 @@ const struct device_type iio_device_type = {
 	.release = iio_dev_release,
 };
 
+/**
+ * opaque_struct_size() - Calculate size of opaque structure with trailing aligned data.
+ * @p: Pointer to the opaque structure.
+ * @a: Alignment in bytes before trailing data.
+ * @s: Data size in bytes (preferred not to be 0).
+ *
+ * Calculates size of memory needed for structure of @p followed by
+ * the aligned data of size @s.
+ *
+ * Note, when @s is 0, the alignment @a is added to the sizeof(*(@p))
+ * and the result, depending on the @a, may be way off the initial size.
+ *
+ * Returns: Number of bytes needed or SIZE_MAX on overflow.
+ */
+#define opaque_struct_size(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s))
+
+#define opaque_struct_data(p, a)	PTR_ALIGN((void *)((p) + 1), (a))
+
 /**
  * iio_device_alloc() - allocate an iio_dev from a driver
  * @parent:		Parent device.
@@ -1618,19 +1636,13 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
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

