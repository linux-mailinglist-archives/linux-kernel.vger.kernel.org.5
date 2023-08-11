Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09C0778F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjHKMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjHKMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:25:08 -0400
X-Greylist: delayed 1334 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 05:25:07 PDT
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7393BE5F;
        Fri, 11 Aug 2023 05:25:07 -0700 (PDT)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B6wmxu025115;
        Fri, 11 Aug 2023 08:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=p6jahmSM5j9URq+MhJY2E9TDTS+pJyj4/GHeF5aXaek=;
 b=RB4fK6xKe2YHyF2C0WCLV8rjYq+xHIH7BIitew4MdsJ3/9Ja0GfgG3iCg2k6FlvRrtOW
 H68tPSdFQeeishV4vlvvP2rp/LSMRBk8ceRffaKE/0zmE5/pdrh0xYr0uJq/RGR92Vd4
 JJDRiOkly1tZzlUL9QnrdoblRQwzbHew9w15UDjA3gSJ0SrQMXaSnzQaBS4gTcYkZ0CM
 43pW7heb/eUuqmyaI6cEbyxYtaHEdLJrvg6j3pxwRQbsJrs2H42YJUK/xp0iNjrRTm/F
 UW9EyYm4k2ckL4ihSeyp71ixwNg3irneNybu2Kjr6Xp+xVwUUTY5+Kab24u2stY4zx/I oA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3sd97rjm34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 08:02:52 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BBMg5s038544;
        Fri, 11 Aug 2023 08:02:51 -0400
Received: from esaploutpc104.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
        by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3sd9durnve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 08:02:50 -0400
X-LoopCount0: from 10.95.135.182
X-PREM-Routing: D-Outbound
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="192727359"
Received: from unknown (HELO marshall-virtual-machine.localdomain) ([10.95.135.182])
  by esaploutpc104.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:02:44 -0500
From:   marshall.shao@dell.com
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Lin Ma <linma@zju.edu.cn>, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marshall Shao <Marshall.Shao@dell.com>
Subject: [PATCH] Fix kernel panic issue after removing igb driver
Date:   Fri, 11 Aug 2023 20:02:25 +0800
Message-Id: <20230811120225.4133-1-marshall.shao@dell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110110
X-Proofpoint-GUID: xqGwpcQLF5tzQcuKVkEEZC-RroAGpiWE
X-Proofpoint-ORIG-GUID: xqGwpcQLF5tzQcuKVkEEZC-RroAGpiWE
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marshall Shao <Marshall.Shao@dell.com>

This patch fixes a kernel panic issue after removing the igb driver 
from the usermode.

A delayed work will be schedule in igb_ptp_init(),

	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
		INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
				  igb_ptp_overflow_check);

If CONFIG_PTP_1588_CLOCK is not enabled, the delayed work cannot be
cancelled when igb_ptp_suspend is called.

Signed-off-by: Marshall Shao <Marshall.Shao@dell.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 405886ee5261..b21822ea1c7d 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1435,12 +1435,12 @@ void igb_ptp_sdp_init(struct igb_adapter *adapter)
  */
 void igb_ptp_suspend(struct igb_adapter *adapter)
 {
-	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
-		return;
-
 	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
 		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
 
+	if (!(adapter->ptp_flags & IGB_PTP_ENABLED))
+		return;
+
 	cancel_work_sync(&adapter->ptp_tx_work);
 	if (adapter->ptp_tx_skb) {
 		dev_kfree_skb_any(adapter->ptp_tx_skb);
-- 
2.34.1

