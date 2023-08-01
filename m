Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1E76BE56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjHAUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjHAUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:13:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B6E71;
        Tue,  1 Aug 2023 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690920810; x=1722456810;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=w62E1ZLf8Yu+1153NVpeVsjcxpI68+1rLGXh6gbkRsE=;
  b=HueUsx1UuJON2+28U0JYTg7jwWIYKNHwdJAYAcz/0VY8LhSd1cGqwWrv
   hMDUOuvTEYfqYeZMwqzc2TCI2EG3MAqIelOeqlCHynkI/4NjmPU+yLLNO
   OMkKzblmko7jGMdwProQfnWslTjD1CgNdaGOtRgnfykjCPVFHv9rAluLT
   PdodU4ipCZvc/c1SZW7ogSxKNwqzs0gOszpNDcSBUIRCxbgHA6hPmvh+N
   SWvMW+elDJOheHH6X+6t6wcCDMOAK7VGzvAUHxMZy56j/nM7CMLkZbxSx
   GvS4ZHScqJ5CeWeE/jDaYstRna80K7Z01a1emacq6/qpRU19B7lktJj3t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369403666"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="369403666"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794320086"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="794320086"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.100.136])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 13:13:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 01 Aug 2023 13:13:28 -0700
Subject: [PATCH v2 1/2] cxl/mbox: Use correct handle in events debug
 message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-cxl-fix-clear-event-debug-print-v2-1-9bdd08d386e9@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690920808; l=1224;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=w62E1ZLf8Yu+1153NVpeVsjcxpI68+1rLGXh6gbkRsE=;
 b=LgCCY3xLB4TQ/N0UwBxq1bLzZyunrC1vJz8EcuE8NVOLHkyTUBDtBroGIxieIN2Xo7zydhWWh
 ZLzq9TTaHBID5RTkTo0MseM7KA/Wnvu+UbLzTESefrEy/AfH3jcJ+M4
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

The handle value used to report an event being cleared by dev_dbg() is
incorrect due to a post increment of the payload handle index.

Delay the increment of the index until after the print.

Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2
[Dan] Go ahead and mark this for backporting
[Dan] Remove 'To/Cc' cruft from individual patches
[Dan/Alison] Split out the additional debugging
[Alison] New oneliner
---
 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..a1c490f66bbf 100644
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

-- 
2.41.0

