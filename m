Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3ED78EB38
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbjHaLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjHaLAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:00:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB21CF3;
        Thu, 31 Aug 2023 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693479608; x=1725015608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DzmC6rc6oIaljneM3MgAfhj+b0WcoR4Oi851fK2n3HI=;
  b=OO68EcOEAwVdNqTExMlBbHdL+ApM6ICLRtXSVnaxwhLvCZ9fWAFsrH0b
   U43E4O9Z59uqGpc1ecbDpEQ6NVwdbskuESSyihMnvT/n0963HmAiBnQRU
   Pu1oepTULaCq+LS6w3tleGZhNH2+2Kj+BvywADcswxZHD8TJDR2TAYxdj
   mz9/W0XO87xGdRcbOaDpNyijMsMYQDwNxgw9W2p90TuCL31ZSBDDz9HCw
   aMyiyepCHvukLBnhdkdat1MMKAuvozA22xwg3aeXKR321ZfBQnuflYkXL
   9ytIp6P9B1VyPf1bNZwXQCqkG7IHR1IxPR7EHi14e2u6G6WftsU7EthmC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="373301974"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="373301974"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716300039"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="716300039"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2023 04:00:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6233B3B5; Thu, 31 Aug 2023 14:00:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] s390/zcrtpt: Don't leak memory if dev_set_name() fails
Date:   Thu, 31 Aug 2023 13:59:59 +0300
Message-Id: <20230831110000.24279-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dev_set_name() fails, the zcdn_create() doesn't free
the newly allocated resources. Do it.

Fixes: 00fab2350e6b ("s390/zcrypt: multiple zcrypt device nodes support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/s390/crypto/zcrypt_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 4b23c9f7f3e5..6b99f7dd0643 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -413,6 +413,7 @@ static int zcdn_create(const char *name)
 			 ZCRYPT_NAME "_%d", (int)MINOR(devt));
 	nodename[sizeof(nodename) - 1] = '\0';
 	if (dev_set_name(&zcdndev->device, nodename)) {
+		kfree(zcdndev);
 		rc = -EINVAL;
 		goto unlockout;
 	}
-- 
2.40.0.1.gaa8946217a0b

