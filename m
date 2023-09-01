Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32D878FE8E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbjIANoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjIANob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:44:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726419AF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575846; x=1725111846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cdkuTO8u3rbVQRk8x8e3eLaDQYXu7b3sptU0SE6tXHc=;
  b=USvRxxk4icTmM9kP/s4lnX06Z8gpBwUb/ANyQ9FWG8+dWEbrYLb1Q955
   I9OCYvkF81X1Gb9uq34264dgG6LZHB7xSrQaf2OWJm2eT13x1t2XDmUac
   j3+8deTEKbLrEo2rwN5shX7fGTahs0U9A/e37WVQfMri+Y7jCUU9pFT+V
   4u210oEOBwfeEwEwMFyQR4429osUSlh+LQMZPhsU3XULjICOJsVOsqKof
   bTFIC6wgMASRGlIkOkaIBIKc2IM53dSoBGXM1PoaEHCfLeEmritrsIGav
   YPrkIv1+Rxd9QvqwGe+pJz285DyiyjHME49SyXZg/TCXB6rOEKwfFtDeH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407213447"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="407213447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="913691337"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="913691337"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 01 Sep 2023 06:43:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F9C776A; Fri,  1 Sep 2023 16:43:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v1 3/3] parport: Drop unneeded NULL or 0 assignments
Date:   Fri,  1 Sep 2023 16:42:50 +0300
Message-Id: <20230901134250.1172990-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
References: <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() gives us a zeroed memory, no need to explicitly assing 0 or
NULL or similar to the members of the data structure that has been
allocated with the above mentioned API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/share.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 38780f6a9119..a9a9cb0477ea 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -449,13 +449,9 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	tmp->irq = irq;
 	tmp->dma = dma;
 	tmp->muxport = tmp->daisy = tmp->muxsel = -1;
-	tmp->modes = 0;
 	INIT_LIST_HEAD(&tmp->list);
-	tmp->devices = tmp->cad = NULL;
-	tmp->flags = 0;
 	tmp->ops = ops;
 	tmp->physport = tmp;
-	memset(tmp->probe_info, 0, 5 * sizeof(struct parport_device_info));
 	rwlock_init(&tmp->cad_lock);
 	spin_lock_init(&tmp->waitlist_lock);
 	spin_lock_init(&tmp->pardevice_lock);
-- 
2.40.0.1.gaa8946217a0b

