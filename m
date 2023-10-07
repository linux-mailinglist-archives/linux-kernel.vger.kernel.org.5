Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E287BC743
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJGLqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbjJGLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:46:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E388B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:46:02 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397BjiM7016354;
        Sat, 7 Oct 2023 11:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=JCn2opEvuT9G8SlYbGqXdlMzE82KbTpqWWMutH5Zq5E=;
 b=TJbie9yWdNm/KNcXf+jhgAsPPVcS/lNmJU5s60BKHy2nPcNGmYq6/kisBqmrfdMLVVfj
 hgKTzCnEwaUSc42fw/imuIqYm7zhG4HUk5+2y2CD7dq/9g6usuOp0j+o7gjG3MdulRcQ
 1s8ONGKvEC8r2dvBqB/Vfw8vCV+Nr86AIkeIWTJrOtUmIyG01F/wDqh4vK+QeRCJVl/H
 mhV+aLFiJBU6xtZslaUaZGUxhoZRswTtn81vdq9VV7aGLfqIBbn/qVa8ZFxYuTvlQnqI
 TBskq0g3N15uTZ6396JvTqMCtyThTEHOa+EYb9GZomb11ta5bu+cboRolbnrZM6GLTQw PQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjw1m8uw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 11:45:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 397Bjhms029099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 11:45:43 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 7 Oct 2023 04:45:40 -0700
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     <gregkh@google.com>, <gregkh@linuxfoundation.org>,
        <cmllamas@google.com>, <surenb@google.com>, <arve@android.com>,
        <joel@joelfernandes.org>, <brauner@kernel.org>
CC:     <tkjos@android.com>, <maco@android.com>,
        <quic_yingangl@quicinc.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] binder: add mutex_lock for mmap and NULL when free
Date:   Sat, 7 Oct 2023 19:45:24 +0800
Message-ID: <20231007114524.76969-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dHg7lwuIrVT_EYJsvDkx0wV2_yJhTPFl
X-Proofpoint-ORIG-GUID: dHg7lwuIrVT_EYJsvDkx0wV2_yJhTPFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=857 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070105
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
Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
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

