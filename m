Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CA07E00AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbjKCIsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjKCIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:48:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC920D49;
        Fri,  3 Nov 2023 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699001296; x=1730537296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CPuhmUzZJc2Fl7jj6hRHKrHunHiCOvwemWTDCOmv/zs=;
  b=S2OVV7QbJBG4ROH5g7x7WP85fN7u/NMpnfj5NsBWMC223/6pCHHcVzCa
   hEp61SZNH9r3Abv/blWconm2ynk2benzTUh8tkKX1n2LOxvfXjz5Uu7QG
   d54u+0WBCUCAtRFthwyVWxTOm2U9qkRZSQW8PSDbAYd3nXq1P7WXF63ze
   3k0+1IrEzZaTlRYK6UWbugLxW4ILMk6YbvPKFaljfV4PIfLn0bRE8GdB2
   6uh74a4YFQjpclnV9Iyt/AyX2Yel8cYeg3mkPpeTb3tBfGTHTbYo7Pq/a
   FYSvPO/NhgY2PNvg3CM9Ag2zDYot1pFVrKjvHpmWt/826gdWwbLDLouuU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391774495"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391774495"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796556454"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796556454"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:10 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] mmc: block: Do not lose cache flush during CQE error recovery
Date:   Fri,  3 Nov 2023 10:47:15 +0200
Message-Id: <20231103084720.6886-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103084720.6886-1-adrian.hunter@intel.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During CQE error recovery, error-free data commands get requeued if there
is any data left to transfer, but non-data commands are completed even
though they have not been processed.  Requeue them instead.

Note the only non-data command is cache flush, which would have resulted in
a cache flush being lost if it was queued at the time of CQE recovery.

Fixes: 1e8e55b67030 ("mmc: block: Add CQE support")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 3a8f27c3e310..4a32b756b7d8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1482,6 +1482,8 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 			blk_mq_requeue_request(req, true);
 		else
 			__blk_mq_end_request(req, BLK_STS_OK);
+	} else if (mq->in_recovery) {
+		blk_mq_requeue_request(req, true);
 	} else {
 		blk_mq_end_request(req, BLK_STS_OK);
 	}
-- 
2.34.1

