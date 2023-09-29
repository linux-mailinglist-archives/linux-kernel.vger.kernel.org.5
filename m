Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B3B7B3903
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjI2RcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2RcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:32:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E719F;
        Fri, 29 Sep 2023 10:32:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TDsmLV010439;
        Fri, 29 Sep 2023 17:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=8lU/UQ69xeMFBkB78iGN5mtYJs6+d6NVePKQlH6OXiM=;
 b=VCL3qw6CExphvFBbs6S5W/ULwH9Ws2WL4lu7LP69Wop+0VHytT85qp8kNDEsrL1SJ+tQ
 CU+HsiphMvSe++AdjUgmgo6zRc10gJ0kosTUbLicp22WBQ2e+GvPWeC/G0Y0yU8FDkjE
 qbnHIDv4e56GQJYqDO4sK28UxFFDZ5P+sgGYicyPzO1m4Q9Tcb7yE3KcH6iHeHZnz+kl
 LLfdy+VKdAetMKtOeUVtLTGwFDja8bRgySFeStsMoWoxSTDWBL5GLfYEAjrZWl7hgkRZ
 XsgdXMtSY/Xgtp/HnojJrHNoGbSCXQrsv6fT/0OOeFuXDCftf/OrsU+r3wPbbZPUw/JB 8g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdqmv9usk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 17:31:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38THVihv007930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 17:31:44 GMT
Received: from [10.213.108.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 10:31:39 -0700
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Date:   Fri, 29 Sep 2023 23:01:15 +0530
Subject: [PATCH] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOIJF2UC/x2MQQqAIBAAvyJ7TjArqL4SIWpb7SEVjYjCvycdZ
 2DmhYSRMMHIXoh4USLvCtQVA7trtyGnpTBIIRsxyIHvZNSD0StD56GDWunmxnZ936LRQiOUMkQ
 s+r9Oc84fBRtEgWUAAAA=
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Len Brown" <len.brown@intel.com>
CC:     Brian Geffon <bgeffon@google.com>, <kernel@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T4PP3ooMOzJGZ1-EaZcFGOV1mScNnqgf
X-Proofpoint-ORIG-GUID: T4PP3ooMOzJGZ1-EaZcFGOV1mScNnqgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=814 spamscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following crash is observed 100% of the time during resume from
the hibernation on a x86 QEMU system.

[   12.931887]  ? __die_body+0x1a/0x60
[   12.932324]  ? page_fault_oops+0x156/0x420
[   12.932824]  ? search_exception_tables+0x37/0x50
[   12.933389]  ? fixup_exception+0x21/0x300
[   12.933889]  ? exc_page_fault+0x69/0x150
[   12.934371]  ? asm_exc_page_fault+0x26/0x30
[   12.934869]  ? get_buffer.constprop.0+0xac/0x100
[   12.935428]  snapshot_write_next+0x7c/0x9f0
[   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
[   12.936530]  ? submit_bio_noacct+0x44/0x2c0
[   12.937035]  ? hib_submit_io+0xa5/0x110
[   12.937501]  load_image+0x83/0x1a0
[   12.937919]  swsusp_read+0x17f/0x1d0
[   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
[   12.938967]  load_image_and_restore+0x45/0xc0
[   12.939494]  software_resume+0x13c/0x180
[   12.939994]  resume_store+0xa3/0x1d0

The commit being fixed introduced a bug in copying the zero bitmap
to safe pages. A temporary bitmap is allocated in prepare_image()
to make a copy of zero bitmap after the unsafe pages are marked.
Freeing this temporary bitmap later results in an inconsistent state
of unsafe pages. Since free bit is left as is for this temporary bitmap
after free, these pages are treated as unsafe pages when they are
allocated again. This results in incorrect calculation of the number
of pages pre-allocated for the image.

nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;

The allocate_unsafe_pages is estimated to be higher than the actual
which results in running short of pages in safe_pages_list. Hence the
crash is observed in get_buffer() due to NULL pointer access of
safe_pages_list.

Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 kernel/power/snapshot.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 87e9f7e2bdc0..cb7341a71a21 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2628,7 +2628,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 		struct memory_bitmap *zero_bm)
 {
 	unsigned int nr_pages, nr_highmem;
-	struct memory_bitmap tmp;
+	struct memory_bitmap tmp_zero_bm;
 	struct linked_page *lp;
 	int error;
 
@@ -2636,6 +2636,16 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 	free_image_page(buffer, PG_UNSAFE_CLEAR);
 	buffer = NULL;
 
+	/*
+	 * Allocate a temporary bitmap to create a copy of zero_bm in
+	 * safe pages. This allocation needs to be done before marking
+	 * unsafe pages below so that it can be freed without altering
+	 * the state of unsafe pages.
+	 */
+	error = memory_bm_create(&tmp_zero_bm, GFP_ATOMIC, PG_ANY);
+	if (error)
+		goto Free;
+
 	nr_highmem = count_highmem_image_pages(bm);
 	mark_unsafe_pages(bm);
 
@@ -2646,12 +2656,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 	duplicate_memory_bitmap(new_bm, bm);
 	memory_bm_free(bm, PG_UNSAFE_KEEP);
 
-	/* Make a copy of zero_bm so it can be created in safe pages */
-	error = memory_bm_create(&tmp, GFP_ATOMIC, PG_ANY);
-	if (error)
-		goto Free;
-
-	duplicate_memory_bitmap(&tmp, zero_bm);
+	duplicate_memory_bitmap(&tmp_zero_bm, zero_bm);
 	memory_bm_free(zero_bm, PG_UNSAFE_KEEP);
 
 	/* Recreate zero_bm in safe pages */
@@ -2659,8 +2664,8 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 	if (error)
 		goto Free;
 
-	duplicate_memory_bitmap(zero_bm, &tmp);
-	memory_bm_free(&tmp, PG_UNSAFE_KEEP);
+	duplicate_memory_bitmap(zero_bm, &tmp_zero_bm);
+	memory_bm_free(&tmp_zero_bm, PG_UNSAFE_KEEP);
 	/* At this point zero_bm is in safe pages and it can be used for restoring. */
 
 	if (nr_highmem > 0) {

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-hib_zero_bitmap_fix-bc5884eba0ae

Best regards,
-- 
Pavankumar Kondeti <quic_pkondeti@quicinc.com>

