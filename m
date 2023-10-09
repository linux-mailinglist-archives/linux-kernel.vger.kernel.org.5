Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C487BE7A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377533AbjJIRT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377847AbjJIRTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:19:24 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 10:19:21 PDT
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B611FB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696871391;
        bh=/flIFIwciLy2Bu9ATOTpOBYMP6hRv1FXcaUEyr/7i7o=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=YHW8u3nPg1K6BKPWAlGOWVelUUmmJVk91iRgIUeK56NhRqvX0aMKKyXE6l/nV4Zig
         Ao8N7TgWU+urg+/wLyUwcDmNjemcI2IMRtCXsDqvff1+Cfo33VOhxwRDnpXoDMJzNu
         pZ6mFwUjFNpy9JUso4+g6KCRSvs3rlQKQ5oqfMNS7i1PjtOkS1GCf9qst+TUhyyVhv
         9/NE2VI9qq8kLh6ZOmFuYxKPqw2MIIb5ITfB34Qta4Bt6sPi3ULyahR5i1jZ6hnHDF
         fyoysD/7Wf+s+t8kIv8DqmnTvCErLb5UuFITJX7ovbQt48z7FrBh3QrLQmkS/nONGl
         hNDz8ftkhD4Mg==
Received: from fedora.fritz.box (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id 2C0DB6E02CC;
        Mon,  9 Oct 2023 17:09:49 +0000 (UTC)
Date:   Mon, 9 Oct 2023 19:09:46 +0200
From:   Lucy Mielke <lucymielke@icloud.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: fix -Wformat-truncation in create_worker
Message-ID: <ZSQz2if1dYelUdzE@fedora.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cmFOseHoVVJdRZ0fz9eeIgtwxqcTSgVf
X-Proofpoint-ORIG-GUID: cmFOseHoVVJdRZ0fz9eeIgtwxqcTSgVf
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2020-02-14=5F02,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=778 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2310090139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with W=1 emitted the following warning
(Compiler: gcc (x86-64, ver. 13.2.1, .config: result of make allyesconfig,
"Treat warnings as errors" turned off):

kernel/workqueue.c:2188:54: warning: ‘%d’ directive output may be
	truncated writing between 1 and 10 bytes into a region of size
	between 5 and 14 [-Wformat-truncation=]
kernel/workqueue.c:2188:50: note: directive argument in the range
	[0, 2147483647]
kernel/workqueue.c:2188:17: note: ‘snprintf’ output between 4 and 23 bytes
	into a destination of size 16

setting "id_buf" to size 23 will silence the warning, since GCC
determines snprintf's output to be max. 23 bytes in line 2188.

Please let me know if there are any mistakes in my patch!

Signed-off-by: Lucy Mielke <lucymielke@icloud.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ebe24a5e1435..d14fddd76f49 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2166,7 +2166,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 {
 	struct worker *worker;
 	int id;
-	char id_buf[16];
+	char id_buf[23];
 
 	/* ID is needed to determine kthread name */
 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
-- 
2.41.0

