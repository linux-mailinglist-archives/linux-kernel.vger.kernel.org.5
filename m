Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2F87CE08D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345135AbjJRO7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjJRO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:59:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CFAB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697641145; x=1729177145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m++cbFcttJ557TMwzXL1cyFX9XiN4d5ABpIPjs4nz/c=;
  b=ezKJwSRixTsWGh//+yflTBVO+ZAPDV+YGdqciB+XkY4oL6JcKNPgTcDK
   q+0Jqtib0JhVH3JMuefn/+sT6o30tXV1lqv3A1K6aruvG4N2WJHD80v42
   4Ix+MhSxb/K0Cu99eqAtdxfCadBOjR8ZXA93TOVEoblUfDjDfI0Cly+8h
   ap4siBqNzN/rza+Nzqh624ZeFx75KF9VxDXmz57Ma2aUqvMB9wCie2LRG
   oN1CtL07pYHcv+jHSOzrxbspKsGYK9xRpC1LqEfN4aMOFhDLM9JwHEyz1
   2yRXxGjBSk75hMjw7C2Pmgq5GNIjAfFcxkYdj3YQVQONlImrBU7DYdgS2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452500003"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="452500003"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:59:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750117095"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="750117095"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2023 07:59:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 476C4192; Wed, 18 Oct 2023 17:59:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v1 2/2] parport: Drop even more unneeded NULL or 0 assignments
Date:   Wed, 18 Oct 2023 17:58:56 +0300
Message-Id: <20231018145856.1367607-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231018145856.1367607-1-andriy.shevchenko@linux.intel.com>
References: <20231018145856.1367607-1-andriy.shevchenko@linux.intel.com>
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

