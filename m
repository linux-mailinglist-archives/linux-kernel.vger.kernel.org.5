Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C375B8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGTUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:53:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192919A6;
        Thu, 20 Jul 2023 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689886403; x=1721422403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cZRvDtegPkJ6Dc6pagLE3ye5wvpxC8MUK6vl7B8hndU=;
  b=PguHkZZDI9IaFJ/+X1uYuGy9uMVv57tEIOLp1jFO87taNlwzDPUFA/cU
   ozE4ipYkGBVoSzAgQCSJSRdTcssXfMshO+GZjfs6hhdZ0r8HN5a4Xiikc
   qIdyJVbi9DpoF5cfBLXWO219PEvJn6PRYlPZRhPOGbJHUgpLoY+/sQ4Zb
   TF1a8eRSxj8MRm+PQyOsRbFGb8xvGH2yy1MjqBooGI8YpFGP6drsSttVK
   iOBWkFZiWpIMjwgP1Tnq7k/FVOsVdsO9FA8Xdn3dzLF59OhjbPG0VCCDJ
   JyKnLh9HyijMKDlciwmHi9OnERbJdmG00wG6cGLDUeL8+5/UCbXoy/HuO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356846038"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="356846038"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838273934"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="838273934"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 13:53:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 536B15FC; Thu, 20 Jul 2023 23:53:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 4/8] iio: core: Use min() instead of min_t() to make code more robust
Date:   Thu, 20 Jul 2023 23:53:20 +0300
Message-Id: <20230720205324.58702-5-andriy.shevchenko@linux.intel.com>
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

min() has strict type checking and preferred over min_t() for
unsigned types to avoid overflow. Here it's unclear why min_t()
was chosen since both variables are of the same type. In any
case update to use min().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index be154879983e..9753f6552db4 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -389,7 +389,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
 	char buf[80];
 	int ret;
 
-	count = min_t(size_t, count, (sizeof(buf)-1));
+	count = min(count, sizeof(buf) - 1);
 	if (copy_from_user(buf, userbuf, count))
 		return -EFAULT;
 
-- 
2.40.0.1.gaa8946217a0b

