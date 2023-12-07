Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4580863C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378666AbjLGJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGJtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:49:11 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F633DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:49:17 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B79HfRW022693;
        Thu, 7 Dec 2023 09:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Zd9+oPas+LQi3lQLkq3Fh560FUK3g4VIjF94BPvemwM=;
 b=AXGFezkaxR2Wt6e4i40M5hwOWRvpp7X2L7//QObHaU8QTXo881B8Szbem9/t/yOM4t5Z
 JlYVDXB20Cm1Sn5atf943q//UqUk11BKaQ7Cqvrm0d/3yx4lmZjPq6+WzOjnGeGICETd
 zFwVKNUsavRr2jeKm/Ri8k2n3a3APRzoLbNR33y+EhXDCelMQw5vq5BJvqg1RsSkvJyg
 jC0v9JfjsUG9/puBrQ9ND1An6C2hOmCXcFWKbX6+/n5mP5Wtl74xWu3QXkitrt/ks2zI
 iCE8cp0h1/kbjRoDttDOJ83FMut+SpaPLzcdyICui70TrV8yYtqRUuiwZ99EmbTWbHQC nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uuasehk7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 09:49:12 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B79IeWj027410;
        Thu, 7 Dec 2023 09:49:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uuasehk64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 09:49:11 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B77gKTn015423;
        Thu, 7 Dec 2023 09:49:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavkjbf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 09:49:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B79n8SB24969898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 09:49:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D59202004B;
        Thu,  7 Dec 2023 09:49:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C518D20040;
        Thu,  7 Dec 2023 09:49:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Dec 2023 09:49:08 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 8ABF6E0103; Thu,  7 Dec 2023 10:49:08 +0100 (CET)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] mm: do not protect VMA lock object in vma_end_read()
Date:   Thu,  7 Dec 2023 10:48:44 +0100
Message-Id: <20231207094844.706407-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tEhOk5_0mus90xzpZ7ZklNdLJI1Ua4L6
X-Proofpoint-ORIG-GUID: iE71XjwwLV2ubpf2n75cBBHlyRGSuK0c
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_07,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=661 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In early discussion to the implementation of vma_end_read()
Jann Horn pointed out that up_read() could access the VMA
lock object after it has already been acquired by someone
else. As result, up_read() is protected with RCU read lock:

	rcu_read_lock(); /* keeps vma alive */
	up_read(&vma->lock);
	rcu_read_unlock();

Since commit 3f5245538a19 ("locking/rwsem: Disable preemption
in all down_read*() and up_read() code paths") __up_read()
disables preemption internally and thus the need to protect
the VMA lock object does not exist anymore.

Link: https://lore.kernel.org/all/CAG48ez3sCwasFzKD5CsqMFA2W57-2fazd75g7r0NaA_BVNTLow@mail.gmail.com/
Cc: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..7b32bc75a4ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -683,9 +683,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
-	rcu_read_lock(); /* keeps vma alive till the end of up_read */
 	up_read(&vma->vm_lock->lock);
-	rcu_read_unlock();
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-- 
2.40.1

