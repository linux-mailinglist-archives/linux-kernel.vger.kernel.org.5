Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9D7658C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjG0Qcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjG0Qcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:32:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F31830FC;
        Thu, 27 Jul 2023 09:32:15 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R7Ef0G017437;
        Thu, 27 Jul 2023 09:31:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=XrrCBVavAAVBSZibFdCAE6bVf3Y4bPd72+D1hPhtusE=;
 b=Gw2s/KRWm2dbtvNxST4BCqZnGT6VaLZlt2ldRi7GG0ZeBEWyo7qnCw33u0nwHWbErd2y
 b5BbX0JJ0BIAbSjfKovxuMS8mbluDW2T5qWEUC5/0hBmqp1SLBJVmi98VnXq+TxkzpRM
 2rGOVX1RVF4eBn7CxePGGZdvAQaFD3k0/3r/cmsAsnkYTXslh8lsYsrnU8Bzam5Mb89E
 wdZbrFCkim8Q76ByDf9ouK/J92vYY5v2G6LEv+lXMjnSdgEkZsVQWVape5tUNWGfDIdS
 lURBcFmkuX83Di3RoNSdbsO39DbhrvbnP+PO3lms/huXTILzL1pbzsecCo4PLfbfEl2G eg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s3m13sybe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 09:31:11 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 27 Jul
 2023 09:31:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 27 Jul 2023 09:31:10 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id C79CD3F7041;
        Thu, 27 Jul 2023 09:31:05 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <dan.carpenter@linaro.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Initialize 'cntr_val' to fix uninitialized symbol error
Date:   Thu, 27 Jul 2023 22:01:01 +0530
Message-ID: <20230727163101.2793453-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 89wATJtry_RsKwgoJrzhALUchkza6cEV
X-Proofpoint-ORIG-GUID: 89wATJtry_RsKwgoJrzhALUchkza6cEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:860
otx2_tc_update_mcam_table_del_req()
error: uninitialized symbol 'cntr_val'.

Fixes: ec87f05402f5 ("octeontx2-af: Install TC filter rules in hardware based on priority")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 1e6fc23eca4f..0915a0121316 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -841,7 +841,7 @@ static int otx2_tc_update_mcam_table_del_req(struct otx2_nic *nic,
 	struct list_head *pos, *n;
 	struct otx2_tc_flow *tmp;
 	int i = 0, index = 0;
-	u16 cntr_val;
+	u16 cntr_val = 0;
 
 	/* Find and delete the entry from the list and re-install
 	 * all the entries from beginning to the index of the
@@ -880,7 +880,7 @@ static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
 	int mcam_idx = flow_cfg->max_flows - flow_cfg->nr_flows - 1;
 	struct otx2_tc_flow *tmp;
 	int list_idx, i;
-	u16 cntr_val;
+	u16 cntr_val = 0;
 
 	/* Find the index of the entry(list_idx) whose priority
 	 * is greater than the new entry and re-install all
-- 
2.25.1

