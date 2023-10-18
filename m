Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52E57CE1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344708AbjJRPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjJRPyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:54:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D580116
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697644459; x=1729180459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m++cbFcttJ557TMwzXL1cyFX9XiN4d5ABpIPjs4nz/c=;
  b=Hr9zWDcpNs1a5PgXvq8G93X45uq8w4XSc1wVp277Wh5Bnikv0rz9gDjR
   0kUT9pje2Rigs/6CqTbVJq9wJ72pZ7rzW1c5VwI3cd7Gpm2VckH9hyqRL
   HF4r9kza2hZ9EUK6Gmt1AwtJ4yHW4W0vsj1uQJqlm9GrAqSNsMZFBcUwE
   PVkPCd3o+oqLNRp3l3iR0crqnn/y+sZB73KGiFeA8aWIul8XV+WD9YKya
   ihSIUvLZ56ZI604urDW7m3e24AeC75ERrHbCkCpVKFUC71/D06ctmP0Bf
   YbgMZ/FfY6XqgkBpQmGDtUG8ikCAFZGU3NVm4PZL8XddC1Z3DR+sFYXt3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389918969"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="389918969"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750135634"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="750135634"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2023 08:54:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 17831192; Wed, 18 Oct 2023 17:59:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [resend, PATCH v1 2/2] parport: Drop even more unneeded NULL or 0 assignments
Date:   Wed, 18 Oct 2023 17:59:48 +0300
Message-Id: <20231018145948.1367648-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231018145948.1367648-1-andriy.shevchenko@linux.intel.com>
References: <20231018145948.1367648-1-andriy.shevchenko@linux.intel.com>
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

kzalloc() gives us a zeroed memory, no need to explicitly assing 0 or
NULL or similar to the members of the data structure that has been
allocated with the above mentioned API.

Note, the initializstion of full_list member is not needed anymore
as list_add_tail will rewrite the contents of the prev and next
pointers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/share.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 048a459ce4b0..e21831d93305 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -459,7 +459,6 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	sema_init(&tmp->ieee1284.irq, 0);
 	tmp->spintime = parport_default_spintime;
 	atomic_set(&tmp->ref_count, 1);
-	INIT_LIST_HEAD(&tmp->full_list);
 
 	/* Search for the lowest free parport number. */
 
@@ -489,8 +488,6 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 		/* assume the worst */
 		tmp->probe_info[device].class = PARPORT_CLASS_LEGACY;
 
-	tmp->waithead = tmp->waittail = NULL;
-
 	ret = device_register(&tmp->bus_dev);
 	if (ret) {
 		put_device(&tmp->bus_dev);
-- 
2.40.0.1.gaa8946217a0b

