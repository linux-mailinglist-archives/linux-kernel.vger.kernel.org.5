Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84DC78FE8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbjIANng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349848AbjIANnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2766910E9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575785; x=1725111785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4roMkrTkBxn5M4KrWiiG+UKPCzazaRQ4mwiu9FhhIQM=;
  b=UkhcfETVoDkjmVTMIqIHlBd/wiephosGgvnpKZOoBk/acYqTpu05c6hJ
   2Rmd+F38NmlJB0r7c3EnkgjDf9R8NgkFf3T8t6MEsh0CHKWt7acq18NNQ
   L4f3tgf/dBWpcglXQRk2soLeTaxcWc5CqLvkCOoemdApxBY+btxa6jX1D
   IK+sCzqxzP9tAgs22fbj9ffS7KsygihLnh3eHJaKwFKrrr1G4ChcIpkv5
   EiOAGRX1COwc8ExkOsqzNr1S/DqeWncWwjYPwbm91z7pU0LiDav5LMxjm
   lt7ySbw+NAsu0/9pUUb2klJc/XT3OF/k4+Et406HLnTpHWDUbZBbH5w4D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356532557"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="356532557"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689774910"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="689774910"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2023 06:43:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95B0371E; Fri,  1 Sep 2023 16:43:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v1 2/3] parport: Use list_for_each() helper
Date:   Fri,  1 Sep 2023 16:42:49 +0300
Message-Id: <20230901134250.1172990-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
References: <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
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

Convert hard to read custom code to list_for_each().
No functional changes intended.

Note, we may not use list_for_each_entry() as at the end of the list
the iterator will point to an invalid entry and may not be dereferenced.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/share.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 8037bcd07bcf..38780f6a9119 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -469,9 +469,11 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	/* Search for the lowest free parport number. */
 
 	spin_lock(&full_list_lock);
-	for (l = all_ports.next, num = 0; l != &all_ports; l = l->next, num++) {
+	num = 0;
+	list_for_each(l, &all_ports) {
 		struct parport *p = list_entry(l, struct parport, full_list);
-		if (p->number != num)
+
+		if (p->number != num++)
 			break;
 	}
 	tmp->portnum = tmp->number = num;
-- 
2.40.0.1.gaa8946217a0b

