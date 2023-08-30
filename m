Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536EE78D149
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjH3Aqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjH3AqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:46:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADACD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:46:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TNdYmW016406;
        Wed, 30 Aug 2023 00:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=PhGhyYE8rmDQgefAGYRE87G5qSJoJ4aDuH/NIUFX7f4=;
 b=HF/9BymVSG3hRuoIsfY6qWq8Q1SpEA/ZAuF7LYD3c2/9oIQttJFPIEo9aDGZHIq2pUgy
 YyQHZGzMVLMJqlL2qoe29l6jm3Kv5VzzODf+MybM7LquzhDUtt9vVdeZdhb36KKVsbU6
 EPnOovz081O+CgWqtOpAJFGJwbsgInsSf1ERLvpAOGLQ/kjnwSutX1les9kjCxkivH/n
 ojbjYhhfkXPCaTqqUMq++LKf3mC0qIurqupc3aBZk5+zAt9x54C7g5/tbYp1Sc9dnSLa
 ziBW3Ozry9omgwvtnec+th4GQWKFxrrrUsIWD1KTTZ6TX4q+42o9zoF4Sr2t43ZG8zTw WA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt6aea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 00:45:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TMguDG037459;
        Wed, 30 Aug 2023 00:45:51 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-180-98.vpn.oracle.com [10.65.180.98])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sr6mnvyk1-1;
        Wed, 30 Aug 2023 00:45:51 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, 0x7f454c46@gmail.com, bgeffon@google.com
Subject: [PATCH] mm/mremap: fix unaccount of memory on vma_merge() failure
Date:   Tue, 29 Aug 2023 17:45:49 -0700
Message-Id: <20230830004549.16131-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=860 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300005
X-Proofpoint-ORIG-GUID: -fY7Djomw6iorEFyRNUJoiX52HsYwb2C
X-Proofpoint-GUID: -fY7Djomw6iorEFyRNUJoiX52HsYwb2C
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix mremap so that only accounted memory is unaccounted if the
mapping is expandable but vma_merge() fails.

Fixes: fdbef6149135 ("mm/mremap: don't account pages in vma_to_resize()")
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mremap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 056478c106ee..07cdb04d4ab5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1037,12 +1037,14 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			pgoff_t extension_pgoff = vma->vm_pgoff +
 				((extension_start - vma->vm_start) >> PAGE_SHIFT);
 			VMA_ITERATOR(vmi, mm, extension_start);
+			long charged = 0;
 
 			if (vma->vm_flags & VM_ACCOUNT) {
 				if (security_vm_enough_memory_mm(mm, pages)) {
 					ret = -ENOMEM;
 					goto out;
 				}
+				charged = pages;
 			}
 
 			/*
@@ -1058,7 +1060,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 				vma->vm_file, extension_pgoff, vma_policy(vma),
 				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 			if (!vma) {
-				vm_unacct_memory(pages);
+				vm_unacct_memory(charged);
 				ret = -ENOMEM;
 				goto out;
 			}
-- 
2.39.3

