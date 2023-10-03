Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF287B6B45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbjJCOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbjJCOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:21:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619893
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696342888; x=1727878888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UNPVCanQ8fEVNqQ/JvnKXDotriqSfW9QDv37icj0u2Q=;
  b=Uerom15XuPN3UwXKMnFqSECqld6QXjSvXGMVG71z0u03VePf/NB08g2w
   7lH6fg7DT6Qrm550cXAI/NRGvny+j4N6NMB1k77W6s2TDo+VP/aeCckIm
   FZSEmTZb1bJHWa4FSy8kjuu4rKgzoUsd2MfLL5GoqF18bYzfcGQ7HTryV
   p6BIZK6g5+X9KEsVyESowLwWbM3dZCAYvJLK4ocvYlf8lSl5UlF1MeS3e
   qGJ9CQiMASxWs4QOiQ5A/pXDN9MEvhold2/2TQ4g6UZoqgrM1H2AKqidS
   /f4bID+c3qcYSaKWx4dzogPZLDQFCaXT3/VGnV72XS0PrB7cLg8epLNJd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380162456"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="380162456"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 07:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841374161"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841374161"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Oct 2023 07:21:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B3C618AE; Tue,  3 Oct 2023 17:21:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] driver core: platform: Drop redundant check in platform_device_add()
Date:   Tue,  3 Oct 2023 17:21:19 +0300
Message-Id: <20231003142122.3072824-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from the commit 37c12e7497b6 ("[DRIVER MODEL] Improved
dynamically allocated platform_device interface") the pdev expects
to be allocated beforehand or guaranteed to be non-NULL.

Hence the leftover check is now redundant (as we have no combined
calls like platform_device_add(platform_device_alloc(...)) in the
entire kernel source code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/platform.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..d81f05c4fccd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -658,9 +658,6 @@ int platform_device_add(struct platform_device *pdev)
 	u32 i;
 	int ret;
 
-	if (!pdev)
-		return -EINVAL;
-
 	if (!pdev->dev.parent)
 		pdev->dev.parent = &platform_bus;
 
-- 
2.40.0.1.gaa8946217a0b

