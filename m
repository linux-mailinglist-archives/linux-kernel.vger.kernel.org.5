Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9AC76A23C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGaUwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGaUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:52:31 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75CA1996;
        Mon, 31 Jul 2023 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690836750; x=1722372750;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=MMLrINQqlo5ERuabFfXtd8/9Tw71gDUXuerUekiwWns=;
  b=L6cKbiUPJa5/5Gc9ZasMJTyzLARIBIvQcNYpRtZ8GKkrC2HOnmgn47U5
   rgF0WV1eISsGGAhi9/V4EmzWyEYug+O7ka+UDLvcFvz7cAhrgBwn6POcx
   ko7Uyi2a8ZDG8d0RduaieN2PMk74NRadQJ5WmeaUOkO3BCY7MeboLHkS4
   6jYseJrGJUDulgr2iAEmPyDAqLAfN0PaDYBgHve2aVhbR9/Q4WraW8uPt
   SqnvHV1QVw9xX4WlHm3y0dj+VocrrAlXbNlxZoFl2tdA2OHE9Ls1I0+H+
   blFRsCN5ypaN4WKKoTQLJJN7kwClNU85Ay7XleAwIHrWlFTKUTvIgGN5L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="359161162"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="359161162"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="842441541"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="842441541"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.100.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:52:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 31 Jul 2023 13:52:27 -0700
Subject: [PATCH] cxl/mbox: Fix debug message print
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
X-B4-Tracking: v=1; b=H4sIAAofyGQC/x2N0QqDMBAEf0XuuQdRsdL+SunDJdnqgU3lYkUQ/
 72xbzsszOyUYYpM92onw6pZP6lAfakojJIGsMbC1LimdX1bc9gmfunGYYIYY0VaOMJ/B55Ny25
 910dxuHXXQMXiJYO9SQrj6XlLXmDnMRuK559+PI/jB5s+O2yKAAAA
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690836749; l=2332;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=MMLrINQqlo5ERuabFfXtd8/9Tw71gDUXuerUekiwWns=;
 b=NDJ8AYz1EeCWvAUu2l2ox6sAWAIJUwJeMOPRrqpv92zI33XtqFnHAuM5FC2jHGCMk3cctKFt/
 zitomy7UZ0HAZnC2ofeB7jGrXZL4V+4R6mAim0aDVQaaerdii0kWuH0
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handle value used to report an event being cleared by dev_dbg() is
incorrect due to a post increment of the payload handle index.

Delay the increment of the index until after the print.  Also add the
debugging for event processing which was useful in finding this bug.

To: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
NOTE: This does fix a bug in the patch referenced below.  However, I
don't think that warrants back porting because this is only a debug
print.

Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
---
 drivers/cxl/core/mbox.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..f052d5f174ee 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -882,9 +882,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	 */
 	i = 0;
 	for (cnt = 0; cnt < total; cnt++) {
-		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
+		payload->handles[i] = get_pl->records[cnt].hdr.handle;
 		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
 			le16_to_cpu(payload->handles[i]));
+		i++;
 
 		if (i == max_handles) {
 			payload->nr_recs = i;
@@ -946,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
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

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230731-cxl-fix-clear-event-debug-print-3b57da0e956c

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

