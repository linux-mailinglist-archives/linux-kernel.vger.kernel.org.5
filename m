Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58D76BE57
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHAUNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjHAUNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:13:31 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9292683;
        Tue,  1 Aug 2023 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690920810; x=1722456810;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=9ogJFFw+u0bGujZNfOGprB9BbrBgtdwyx6Y9vnk3474=;
  b=EvKCyIEioHeAvaozTnqbhDS4/IGAe7c5glQFNnoBcXDoLAzZR6hB5RZn
   jYZCnoJWevYekPksH7ovpcOorr9WZOd9z/NfLaFGexnNGhRYameWGp7fX
   aWk/D2Ex00L5oQn7AouWaYzltNchdeEHgIuT/VPp/nXL0f6flk61AcHlB
   2q+yc1as4IEr/uoHnQv34F7USXRGHCYdi0yPAZGgf6hISNOAne01EnPx3
   d5ynncUWFO0wAP3s9EgPmVIg1Obm6Wvl4twKYZiHFxUeICnyAQGRMTqGu
   o2aAhwzD9wxxNh9Y6qHqkquKXx5TodnBhlgz/mu/+63iF50hAOvzG8HK4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369403670"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="369403670"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794320090"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="794320090"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.100.136])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:13:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 01 Aug 2023 13:13:29 -0700
Subject: [PATCH v2 2/2] cxl/mbox: Add handle to event processing debug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690920808; l=949;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=9ogJFFw+u0bGujZNfOGprB9BbrBgtdwyx6Y9vnk3474=;
 b=8ppxERDqIvSOk6UFMtxM71svRp1lrx+sFqufgdT6tXtEsqFh8YvGgb6pNPjACkRt4z8Aass2o
 19Ilt9royHOAxnENHp4RmlQKM5dvB/53WEpk/eIdycczv+BhfMuEh88
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Knowing which handle is being processed helped in debugging new event
code.  Add a dev_dbg() message with this information.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a1c490f66bbf..f052d5f174ee 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -947,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		if (!nr_rec)
 			break;
 
-		for (i = 0; i < nr_rec; i++)
+		for (i = 0; i < nr_rec; i++) {
+			dev_dbg(dev, "Event log %d: processing handle %u\n",
+				type,
+				le16_to_cpu(payload->records[i].hdr.handle));
 			cxl_event_trace_record(cxlmd, type,
 					       &payload->records[i]);
+		}
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);

-- 
2.41.0

