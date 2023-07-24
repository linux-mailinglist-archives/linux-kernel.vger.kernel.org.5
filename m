Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6143D75F424
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjGXLCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjGXLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:02:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C3E19B;
        Mon, 24 Jul 2023 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196528; x=1721732528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G3EfKhulqiVD/k8ML7lvWomq7mPN98qxK02WVuePlyA=;
  b=ncRQdXmnjjJzc0LXweNOENf03qXfGfZL2rSYESTOY1pPDgB33wAVCv30
   pbaxEntp2iTQfqZkiDhzNRa8hHZhoJVnpB8sdnATGy7tjaqLHTK1XuyVo
   pBV7E+11MDLOIlWXMmAfpIR3LkbRCoKFIteDNxDcMSYwR1GkULw3jnckt
   nl82Em75LOEGCz+MduzDWWgnGZBafNAGp34YGyWUT96CR5AS82g7/Vd7R
   Y3wkWt4jiiqFAf/WXfsatA3nyAX53WtoUcgmPpw1jLMPC2oTYbr9ZR6Ww
   vRUdUWclG0bKQS/EfklZFUoWWCEHpkiBZcYjwjZIdE349zDc4FGNkMter
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347012825"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347012825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775356"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775356"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:01:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1E6F2E9; Mon, 24 Jul 2023 14:02:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v3 3/4] iio: core: Switch to krealloc_array()
Date:   Mon, 24 Jul 2023 14:02:03 +0300
Message-Id: <20230724110204.46285-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
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

Let the krealloc_array() copy the original data and
check for a multiplication overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 118ca6b59504..13d6b6ac5ccf 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1474,7 +1474,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
 	const struct attribute_group **new, **old = iio_dev_opaque->groups;
 	unsigned int cnt = iio_dev_opaque->groupcounter;
 
-	new = krealloc(old, sizeof(*new) * (cnt + 2), GFP_KERNEL);
+	new = krealloc_array(old, cnt + 2, sizeof(*new), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
-- 
2.40.0.1.gaa8946217a0b

