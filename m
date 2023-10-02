Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E227B5471
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbjJBNzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjJBNzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:55:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BADC;
        Mon,  2 Oct 2023 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254904; x=1727790904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7CvkNllIdMRaFkXGmuu4g9r5sHV6wrnsOajfayAqkbY=;
  b=dgpMPu3MAP3uQgS683ZLarOg4ngCglE+pUg1e6JHNk6AHywKYOFnEcbc
   bx9wkSMxzkDDG1PhfVkoyhcYEQySScyxcQde524W2pV0HKVIDGfu06Sw/
   KI3OFx4nyQQdgKdVtjjU+9rhsRhbVm/Y4MYSdNuJ5dxYUwTOoVuugwdGN
   aWQSyAZIlLcT/gbrlj36XaWNZ0KDHTzHkg3dLcSNyglhNy98E7HcG9hZa
   ZRK+bm1wJIOOL46Ca79MMHp0NTj061YWEM64GPSbDtvfNOrZeylqdCxfc
   3hn8sd/gG/etl+/P8zv5siY8uf2cwTdEI7O1v/t54N3VZ1iqwVLfwlr4w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362911942"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362911942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="785782513"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="785782513"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Oct 2023 06:55:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9CE6A14AF; Mon,  2 Oct 2023 16:54:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: NFIT: Switch to use acpi_evaluate_dsm_typed()
Date:   Mon,  2 Oct 2023 16:54:58 +0300
Message-Id: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
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

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/nfit/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f96bf32cd368..280da408c02c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1737,9 +1737,8 @@ __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 	if ((nfit_mem->dsm_mask & (1 << func)) == 0)
 		return;
 
-	out_obj = acpi_evaluate_dsm(handle, guid, revid, func, &in_obj);
-	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER
-			|| out_obj->buffer.length < sizeof(smart)) {
+	out_obj = acpi_evaluate_dsm_typed(handle, guid, revid, func, &in_obj, ACPI_TYPE_BUFFER);
+	if (!out_obj || out_obj->buffer.length < sizeof(smart)) {
 		dev_dbg(dev->parent, "%s: failed to retrieve initial health\n",
 				dev_name(dev));
 		ACPI_FREE(out_obj);
-- 
2.40.0.1.gaa8946217a0b

