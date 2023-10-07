Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DFA7BC776
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbjJGM2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343980AbjJGM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:28:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2BBAB
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:28:37 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397CRbkk000832;
        Sat, 7 Oct 2023 12:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8YiXbO0FZTma50ZlGW9j8kFnXUKsvbHsdA6m3UAwiMA=;
 b=ln1n9cuxtVVYh7jjWID2yKQV2bS7S+xRtVrO0lkQ75kJEXEN97aAtapElO8ep2kJI04S
 3sxIwS0EoDTB6SqHO4tthXVm+P0NWuKizXlWUwKamJmbunwtiRyykXOLcKWXeP+mibn+
 xGO+jPiyun8m1r5MjFlguwAHaG8WytR2Um22buIpt5S0dyIBK+zU0ftkh4B630gdeG8j
 E072apkh0Oob7t8534ukyFJA/jOxRWikH0MPAzekZ+jvqiGiLjOuxAckDg3IcSNWV9OH
 YR4OMwe63Q3TPVqGKsyMI900VJcDF81BnSe4NU2pYwVbAnqWDLmBV02iyzV37RKd8SK2 Gw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjvpts05w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 12:28:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397CSS43009416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 12:28:28 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 7 Oct 2023 05:28:25 -0700
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     <gregkh@google.com>, <gregkh@linuxfoundation.org>,
        <cmllamas@google.com>, <surenb@google.com>, <arve@android.com>,
        <joel@joelfernandes.org>, <brauner@kernel.org>
CC:     <tkjos@android.com>, <maco@android.com>,
        <quic_yingangl@quicinc.com>, <linux-kernel@vger.kernel.org>,
        Sherry Yang <sherryy@android.com>
Subject: [PATCH v3] binder: add mutex_lock for mmap and NULL when free
Date:   Sat, 7 Oct 2023 20:28:13 +0800
Message-ID: <20231007122813.84282-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1mALU7Au0ojohU-jN0HQ5Tayy7YiNHop
X-Proofpoint-GUID: 1mALU7Au0ojohU-jN0HQ5Tayy7YiNHop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=961 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310070111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Enforce alloc->mutex in binder_alloc_mmap_handler when add the entry to
  list.

- Assign the freed pages/page_ptr to NULL to catch possible use after free
  with NULL pointer access.

Fixes: 19c987241ca1 ("binder: separate out binder_alloc functions")
Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
CC: Todd Kjos <tkjos@android.com>
CC: Sherry Yang <sherryy@android.com>
Link: https://lore.kernel.org/all/20231007034046.2352124-1-quic_yingangl@quicinc.com/
Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
V1 -> V2: Add Fixes info.
V2 -> V3: Add this history.
---
 drivers/android/binder_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e3db8297095a..c7d126e04343 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -775,6 +775,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	}
 
 	buffer->user_data = alloc->buffer;
+	mutex_lock(&alloc->mutex);
 	list_add(&buffer->entry, &alloc->buffers);
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
@@ -782,7 +783,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 
 	/* Signal binder_alloc is fully initialized */
 	binder_alloc_set_vma(alloc, vma);
-
+	mutex_unlock(&alloc->mutex);
 	return 0;
 
 err_alloc_buf_struct_failed:
@@ -856,9 +857,11 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 				     __func__, alloc->pid, i, page_addr,
 				     on_lru ? "on lru" : "active");
 			__free_page(alloc->pages[i].page_ptr);
+			alloc->pages[i].page_ptr = NULL;
 			page_count++;
 		}
 		kfree(alloc->pages);
+		alloc->pages = NULL;
 	}
 	mutex_unlock(&alloc->mutex);
 	if (alloc->mm)
-- 
2.25.1

