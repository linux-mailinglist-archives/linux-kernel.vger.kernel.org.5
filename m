Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2312478D142
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbjH3Aoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjH3AoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:44:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A319A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:44:09 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TNeQog005072;
        Wed, 30 Aug 2023 00:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=JJx+iBCNiI2MMh8+aO3HVA8Wi5bYTILzpsCDdfw3eNM=;
 b=v54ZhtI1evVq3FAVNushrhnL0Kw3dOcyPaJItg6u5o6ffWqQnk10PW58fVncxwS4aVBQ
 GKORPZ6z8Vq9jAYXmhEAJVaDw4CFn3GoASyX2R3eugyyr59FVNIClctwv95bzZRKdHEv
 FIW82SlcLFI2kGmyMgXb0tkVDP5hH6IuLIe0qyL2hnFMWd1+go8k8z2M7k+uf6B96fOc
 oVcdSsJHjL5OumQkcSnPUz3BXZZZaMN+kYMjwYxe04awaJHWS+K3VKdwKEJ034cwHosj
 jL2xxDxZxtGOUdKpx7asfOOuLpc03K4a4QNJvQx6p93VlhP0sxl26nABInaPwDz1aDju lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4eaxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 00:43:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TMmBZO000607;
        Wed, 30 Aug 2023 00:43:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gbw64y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 00:43:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37U0hpHt005857;
        Wed, 30 Aug 2023 00:43:51 GMT
Received: from localhost.us.oracle.com (dhcp-10-65-180-98.vpn.oracle.com [10.65.180.98])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sr6gbw5wk-1;
        Wed, 30 Aug 2023 00:43:51 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Liam.Howlett@Oracle.com,
        willy@infradead.org
Subject: [PATCH] mm: fix unaccount of memory on vma_link() failure
Date:   Tue, 29 Aug 2023 17:43:24 -0700
Message-Id: <20230830004324.16101-1-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300005
X-Proofpoint-GUID: uqvqKtp2XM9GWbbfUHyH-pA6raDy475s
X-Proofpoint-ORIG-GUID: uqvqKtp2XM9GWbbfUHyH-pA6raDy475s
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix insert_vm_struct() so that only accounted memory is unaccounted
if vma_link() fails.

Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 514ced13c65c..f8c084017757 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3278,7 +3278,8 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	}
 
 	if (vma_link(mm, vma)) {
-		vm_unacct_memory(charged);
+		if (vma->vm_flags & VM_ACCOUNT)
+			vm_unacct_memory(charged);
 		return -ENOMEM;
 	}
 
-- 
2.39.3

