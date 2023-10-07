Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D044B7BC470
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 05:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbjJGDmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 23:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjJGDl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 23:41:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C06BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 20:41:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3973ckNd031558;
        Sat, 7 Oct 2023 03:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=AO32nXH08dML1T+/b42a6LXZnMlL1YQ3mKO0J4C7mZw=;
 b=c0Np81fY7qgzdx3tGRlO2CkT+HSFWeg1SyLf+LNJjNSjXc037kNoiYgp4rZSNgf4TFwr
 SOYpiKzv+gHVLMZnsSEMLJBnomL9mh8SSKGHInL2RujZ/nFoJd9g2jHtMVLn9XLde8gi
 3dU/IeiuIayXR3hQvV2hsiahgM+U91MDD6ce0DvJyW5Ym9h5dkCcHmHCaHZkfS4jOr59
 eMFzCFe5+9hv5HZFjCdU3s2isiGC7YbX+KDyOS+pFxj8D5n9WxDsV61p5/z1gCrCzjRh
 f0ulhni3zvfb4/NTcM5yDIeJkuLdBxK+Lsxug1VpEVCAUNOVOw61F5VJfqxNVyzncU3q iQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjye0g0jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 Oct 2023 03:41:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3973fkKp028746
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Oct 2023 03:41:46 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 6 Oct 2023 20:41:43 -0700
From:   Kassey Li <quic_yingangl@quicinc.com>
To:     <gregkh@google.com>, <gregkh@linuxfoundation.org>,
        <cmllamas@google.com>, <surenb@google.com>, <arve@android.com>,
        <joel@joelfernandes.org>, <brauner@kernel.org>
CC:     <tkjos@android.com>, <maco@android.com>,
        <quic_yingangl@quicinc.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] binder: add mutex_lock for mmap and NULL when free
Date:   Sat, 7 Oct 2023 11:40:46 +0800
Message-ID: <20231007034046.2352124-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3bZaDyX8RnILZJcVdY4luaHmsa38cQDG
X-Proofpoint-ORIG-GUID: 3bZaDyX8RnILZJcVdY4luaHmsa38cQDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 mlxlogscore=911 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enforce alloc->mutex in binder_alloc_mmap_handler when add
the entry to list.

Assign the freed pages/page_ptr to NULL to catch possible
use after free with NULL pointer access.

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

