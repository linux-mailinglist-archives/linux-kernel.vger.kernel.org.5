Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B824D75B8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGTUxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGTUxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:53:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C5271E;
        Thu, 20 Jul 2023 13:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689886403; x=1721422403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pfv2zMNVzALrxCi0SprgcczDN6aPO4CmhcU5QiAudNo=;
  b=BAfh+zvtnUMMowZ9gsaM0pbhzSjzIhexmQV6ZxavpwGrv60ViaKP4vsu
   Nej9d3RSSYXRMVqyTXA9PNWlNB/0phXMFnTldsR187ESTOAeLAUpO0VlV
   ohnrqeo45MQQyn4ZUALs3DSTAh1OFB6Zd1MeQ9ckKApl/3M3wafXBmtsB
   NCxMj0Buv3j5AIwVrNPn2hnERW8v1VT6LmXSXLwnxuPoqPKaXArssdaPE
   OoafJVqWDAlkBNGH6bSFvuK3gNQQalaM03MmwFG0o2y3UQYYjhvLA88Fn
   hzechwd6IwrLdHa1/mMpfdjYRRbUv+bLJs/5Kd4CzVBmdqma9GDn52vpD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370459744"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="370459744"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971169133"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="971169133"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2023 13:53:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5ABE7604; Thu, 20 Jul 2023 23:53:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 5/8] iio: core: Get rid of redundant 'else'
Date:   Thu, 20 Jul 2023 23:53:21 +0300
Message-Id: <20230720205324.58702-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/iio/industrialio-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9753f6552db4..ab9c6db69625 100644
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

