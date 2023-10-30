Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2177DB969
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjJ3MCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:02:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E6C5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:02:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U3eeh2012096;
        Mon, 30 Oct 2023 12:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=g/NS7/XKKN6DW3ghUpgOmpjRApT8FNo2QIx8wOo4TpE=;
 b=TJ0TFdy9JHgON2UglDTlmKXB1RksOC6NeTrmopNxAqZkSZxhXELO0gxybSw+TrFf2QJb
 RzD56lG6c9kr99WQYpmG77OlMSbbInl99SXmVcSyIlRgwbbJ5UubeJFa9fVNBC3Jtfh+
 VZq4qaIL7dQApdxXHQ0IDux5MgvOd6fGsy+8hHs04VNA5OcIb2jsjnU/NQTmH0TEU45I
 nlmkj4WUYAvZJBXiY54I98MJ2ELjfHg/IKZCUeO38xaAlFrFKMCTRzzN1LjhCuc6v+AE
 tNI3iTKdePwIdg7tSxy7nm+7ltfWZBkmvDKeqoK0KOrivttzf4WkJvZcFp2VHXVfPtyV yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33tmd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 12:01:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UB0pLJ024786;
        Mon, 30 Oct 2023 12:01:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x41hk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 12:01:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UC1ZdU036764;
        Mon, 30 Oct 2023 12:01:35 GMT
Received: from sridara-source.osdevelopmeniad.oraclevcn.com (sridara-source.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.239])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3u14x41hhw-1;
        Mon, 30 Oct 2023 12:01:35 +0000
From:   Srivathsa Dara <srivathsa.d.dara@oracle.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     srivathsa.d.dara@oracle.com, rajesh.sivaramasubramaniom@oracle.com,
        junxiao.bi@oracle.com, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: call ocfs2_abort when journal abort
Date:   Mon, 30 Oct 2023 12:00:57 +0000
Message-Id: <20231030120057.928280-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300091
X-Proofpoint-GUID: BYdCrLIurlT5tN5rTgZRxugX71dBo0t-
X-Proofpoint-ORIG-GUID: BYdCrLIurlT5tN5rTgZRxugX71dBo0t-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Ding <ryan.ding@oracle.com>


journal can not recover from abort state, so we should take following 
action to prevent file system from corruption:

1. change to readonly filesystem when local mount. We can not afford 
   further write, so change to RO state is reasonable.

2. panic when cluster mount. Because we can not release lock resource in
   this state, other node will hung when it require a lock owned by this
   node. So panic and remaster is a reasonable choise.

ocfs2_abort() will do all the above work.

Signed-off-by: Ryan Ding <ryan.ding@oracle.com>
Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 fs/ocfs2/journal.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index ce215565d061..6dace475f019 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -14,7 +14,6 @@
 #include <linux/kthread.h>
 #include <linux/time.h>
 #include <linux/random.h>
-#include <linux/delay.h>
 #include <linux/writeback.h>
 
 #include <cluster/masklog.h>
@@ -2326,7 +2325,7 @@ static int __ocfs2_wait_on_mount(struct ocfs2_super *osb, int quota)
 
 static int ocfs2_commit_thread(void *arg)
 {
-	int status;
+	int status = 0;
 	struct ocfs2_super *osb = arg;
 	struct ocfs2_journal *journal = osb->journal;
 
@@ -2340,21 +2339,25 @@ static int ocfs2_commit_thread(void *arg)
 		wait_event_interruptible(osb->checkpoint_event,
 					 atomic_read(&journal->j_num_trans)
 					 || kthread_should_stop());
+		if (status < 0) {
+			/* As we can not terminate by ourself, just enter an
+			 * empty loop to wait for stop.
+			 */
+			continue;
+		}
 
 		status = ocfs2_commit_cache(osb);
 		if (status < 0) {
-			static unsigned long abort_warn_time;
-
-			/* Warn about this once per minute */
-			if (printk_timed_ratelimit(&abort_warn_time, 60*HZ))
-				mlog(ML_ERROR, "status = %d, journal is "
-						"already aborted.\n", status);
 			/*
-			 * After ocfs2_commit_cache() fails, j_num_trans has a
-			 * non-zero value.  Sleep here to avoid a busy-wait
-			 * loop.
+			 * journal can not recover from abort state, there is
+			 * no need to keep commit cache. So we should either
+			 * change to readonly(local mount) or just panic
+			 * (cluster mount).
+			 * We should also clear j_num_trans to prevent further
+			 * commit.
 			 */
-			msleep_interruptible(1000);
+			atomic_set(&journal->j_num_trans, 0);
+			ocfs2_abort(osb->sb, "Detected aborted journal");
 		}
 
 		if (kthread_should_stop() && atomic_read(&journal->j_num_trans)){
-- 
2.39.3

