Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE47756A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjHIJs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHIJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:48:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C53C1FD8;
        Wed,  9 Aug 2023 02:48:57 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3799dD4O030706;
        Wed, 9 Aug 2023 09:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qb4nHKrxyC/H/r7t0RxFzDn0koTqV/7wXf1V15k7Hew=;
 b=TcxvQ/e9g6WSBD6Oor/Cn7PYvFVVJ5dJ6Vieu7DY1Stx/aNJqfYISYBG1fDL27yv+4v7
 sc6TuYSezj+IlpR8ulldhBL5NeNST7UXi4TlXDxSGoSCUpKS7oE/ozRstDl9a95eVpJa
 CMeM6yGgoR+IuLRvq7m1V6mzfwaNH4CSlFbL8ld5K4G6sauyJ1AWZPWftr9B/u4Xqbck
 ZJehxCgULy3x/OJ7UfrtYT53xZyZIXq+STMEezCgWD6cwnyH/gT/pE8EhkbMfNRH7D0E
 DwQmSnkrcM5Su9WxjdLXvVzs6vtsMW2FmQfRCK71oDs8atlEzgIkdnAzmQins+lc26tr BA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sc7rxs840-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 09:48:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3798FeNw006666;
        Wed, 9 Aug 2023 09:48:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rt7dt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 09:48:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3799mpag9699906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 09:48:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6D920043;
        Wed,  9 Aug 2023 09:48:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 073A020040;
        Wed,  9 Aug 2023 09:48:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Aug 2023 09:48:50 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 9C731E0331; Wed,  9 Aug 2023 11:48:50 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH] s390/ipl: fix virtual vs physical address confusion
Date:   Wed,  9 Aug 2023 11:48:50 +0200
Message-Id: <20230809094850.3918281-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0ke9H2pObXFBjrAJT0zxT-N1B6DvKbz_
X-Proofpoint-ORIG-GUID: 0ke9H2pObXFBjrAJT0zxT-N1B6DvKbz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_08,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix virtual vs physical address confusion (which currently are the same).

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/kernel/machine_kexec_file.c             | 4 ++--
 arch/s390/kernel/setup.c                          | 2 +-
 security/integrity/platform_certs/load_ipl_s390.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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
index e769dcb7ea94..6723ba9f9ca4 100644
--- a/security/integrity/platform_certs/load_ipl_s390.c
+++ b/security/integrity/platform_certs/load_ipl_s390.c
@@ -23,7 +23,7 @@ static int __init load_ipl_certs(void)
 	if (!ipl_cert_list_addr)
 		return 0;
 	/* Copy the certificates to the system keyring */
-	ptr = (void *) ipl_cert_list_addr;
+	ptr = __va(ipl_cert_list_addr);
 	end = ptr + ipl_cert_list_size;
 	while ((void *) ptr < end) {
 		len = *(unsigned int *) ptr;
-- 
2.39.2

