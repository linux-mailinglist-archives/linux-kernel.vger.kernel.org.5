Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7680178B3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjH1O6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjH1O6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:58:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1CC2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693234710; x=1724770710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EZRTwDYdkxEZFfQhsIIrhvUcEh11tvGc71/6PVw0aqU=;
  b=Uc0EamMFKFC0hJqmUUtW/CpxSQuTcFfqL3SuyqqVeifn3DJk4IVYygjd
   16g+JowBG0at4m2BxKgtuvbeXtwZkxPuxPJLAA8oGp5IwSeJJynZvvOMl
   t55QT5XeS2mzSS3izeVTJvQqr9o9SsJ8jXlehyDFnbNDmdNAcneVQTm92
   gch5llgJGxvMD2J6WhiGOPFcfnBkZeUIwULUgl6+OmqwPB/ryBpzlj6zq
   kViCZWFS4aErfaxD4O0Ci0IQiSGKbuQv38q3agPduCxGkI1gFo6d+Q4c9
   uVkhEhWOn3ynNmPK5w/6gTQVf7Jwo0f/s8cAda2HkU6YJZ2+c+dFw1dR9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="406110278"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="406110278"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 07:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="828424032"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="828424032"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2023 07:58:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 705FC17F; Mon, 28 Aug 2023 17:58:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, hdanton@sina.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com
Subject: [PATCH v1 1/1] driver core: return an error when dev_set_name() hasn't happened
Date:   Mon, 28 Aug 2023 17:58:24 +0300
Message-Id: <20230828145824.3895288-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d21fdd07cea4 ("driver core: Return proper error code when
dev_set_name() fails") rewrote the logic of handling the dev_set_name()
error codes, but missed the point that initially set error value to
-EINVAL might be rewritten and hence the error path can't be triggered
at some circumstances. To fix this, make sure that error variable is
set to -EINVAL when other conditionals are false.

Reported-by: syzbot+bdfb03b1ec8b342c12cb@syzkaller.appspotmail.com
Fixes: d21fdd07cea4 ("driver core: Return proper error code when dev_set_name() fails")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0d246c060f86..67ba592afc77 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3538,6 +3538,8 @@ int device_add(struct device *dev)
 	/* subsystems can specify simple device enumeration */
 	else if (dev->bus && dev->bus->dev_name)
 		error = dev_set_name(dev, "%s%u", dev->bus->dev_name, dev->id);
+	else
+		error = -EINVAL;
 	if (error)
 		goto name_error;
 
-- 
2.40.0.1.gaa8946217a0b

