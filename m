Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1FA77E295
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbjHPNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245553AbjHPN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:29:57 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8669FE52;
        Wed, 16 Aug 2023 06:29:56 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GDNPqj002133;
        Wed, 16 Aug 2023 13:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=OigVN8noRxBDELAL7Iv04TJVBEEGzmfN/blTpSjhA8o=;
 b=Iv9U9il5VKP7F1ZAm3vnBYr5HjbhqaO5+TB4HGXQaAWwQgzV4LOcb3/BcWfOqS2VpEAJ
 2Jlt/j2xfBp7wS1jVqOaFNQuJUG0Xo40vcW4vhe1X6sMXYVqtvdsDji+Vo/X3tx+Z4FW
 SDHBSVYesQHNVkZuiyVuqhV2+outrqdJuexte1HqGBi2+KE8JQ5CP5BkTuyX9AVXIJbX
 SLtg8PeYchsNCyaJKXvSazfXyqpymQkylr0ARYp+/970DAwGxrNZVfn1sBoTqKp3kVyg
 V95B4/mWZtVvXztxyaK+kVYRXqVqShQgEvRTv712fkIkTfWulpdTq+NIXhIpyu/c7ucb Dw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgy9sg48t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:29:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GAwnDC013323;
        Wed, 16 Aug 2023 13:29:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjv0ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 13:29:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GDTgkt61866324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 13:29:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6ECF2004E;
        Wed, 16 Aug 2023 13:29:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FBBC2004D;
        Wed, 16 Aug 2023 13:29:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 13:29:42 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 60E46E012C; Wed, 16 Aug 2023 15:29:42 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2] s390/ipl: fix virtual vs physical address confusion
Date:   Wed, 16 Aug 2023 15:29:42 +0200
Message-Id: <20230816132942.2540411-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b7QQLr02N6qWdOM5aMQnrJ-5Epm3pFGp
X-Proofpoint-ORIG-GUID: b7QQLr02N6qWdOM5aMQnrJ-5Epm3pFGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_12,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of ipl_cert_list_addr boot variable contains
a physical address, which is used directly. That works
because virtual and physical address spaces are currently
the same, but otherwise it is wrong.

While at it, fix also a comment for the platform keyring.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/kernel/machine_kexec_file.c             | 4 ++--
 arch/s390/kernel/setup.c                          | 2 +-
 security/integrity/platform_certs/load_ipl_s390.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 2df94d32140c..8d207b82d9fe 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -188,7 +188,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 	data->memsz = ALIGN(data->memsz, PAGE_SIZE);
 	buf.mem = data->memsz;
 
-	ptr = (void *)ipl_cert_list_addr;
+	ptr = __va(ipl_cert_list_addr);
 	end = ptr + ipl_cert_list_size;
 	ncerts = 0;
 	while (ptr < end) {
@@ -200,7 +200,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 
 	addr = data->memsz + data->report->size;
 	addr += ncerts * sizeof(struct ipl_rb_certificate_entry);
-	ptr = (void *)ipl_cert_list_addr;
+	ptr = __va(ipl_cert_list_addr);
 	while (ptr < end) {
 		len = *(unsigned int *)ptr;
 		ptr += sizeof(len);
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 393dd8385506..c744104e4a9c 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -875,7 +875,7 @@ static void __init log_component_list(void)
 		pr_info("Linux is running with Secure-IPL enabled\n");
 	else
 		pr_info("Linux is running with Secure-IPL disabled\n");
-	ptr = (void *) early_ipl_comp_list_addr;
+	ptr = __va(early_ipl_comp_list_addr);
 	end = (void *) ptr + early_ipl_comp_list_size;
 	pr_info("The IPL report contains the following components:\n");
 	while (ptr < end) {
diff --git a/security/integrity/platform_certs/load_ipl_s390.c b/security/integrity/platform_certs/load_ipl_s390.c
index e769dcb7ea94..c7c381a9ddaa 100644
--- a/security/integrity/platform_certs/load_ipl_s390.c
+++ b/security/integrity/platform_certs/load_ipl_s390.c
@@ -22,8 +22,8 @@ static int __init load_ipl_certs(void)
 
 	if (!ipl_cert_list_addr)
 		return 0;
-	/* Copy the certificates to the system keyring */
-	ptr = (void *) ipl_cert_list_addr;
+	/* Copy the certificates to the platform keyring */
+	ptr = __va(ipl_cert_list_addr);
 	end = ptr + ipl_cert_list_size;
 	while ((void *) ptr < end) {
 		len = *(unsigned int *) ptr;
-- 
2.39.2

