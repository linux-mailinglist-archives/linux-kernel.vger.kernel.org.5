Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB10B780B22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376662AbjHRL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376672AbjHRL3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:29:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81079100;
        Fri, 18 Aug 2023 04:29:19 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IBMQBV022601;
        Fri, 18 Aug 2023 11:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=fc2M/r+7xUmCuSN/G/vCZDqaS8VCMeOP55q/YgkshYY=;
 b=tbeDllnJwws5aDdFRXX39L1rvAH8paA4tOm8vQhheNLU65VPTDsxfV+sSUVmqu05XaON
 iynu3o7lA/qpqRIop+zEi5mRD1gMWh4bJEBrEDRJi3ntZ70DDiIO8gIZYZ+rMNkrcziH
 WDvOj8ZSMkJSDHldbyCmzAriZNTi7j3i2O23EdwMAsmtpFMinUquUhdHZgWGutNaOkHd
 QK7pVFLgnT1zTvbQBsfki+yUtDFBZgs2Vylpree3uq8h+t6FS+yl+vqi44BHnfca+ZGT
 9lxF4CMp7wbb0571td8n+PNwpblr9p7jpQ2/ISCBAf71H79rCeZQnaj6pvbvWRox8R2y MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj7qb05cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 11:29:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IBN4kh024617;
        Fri, 18 Aug 2023 11:29:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj7qb05c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 11:29:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37IAjscM002408;
        Fri, 18 Aug 2023 11:29:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendnxjnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 11:29:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IBTAB522217394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 11:29:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1BEA2004B;
        Fri, 18 Aug 2023 11:29:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F092220043;
        Fri, 18 Aug 2023 11:29:08 +0000 (GMT)
Received: from [9.113.206.79] (unknown [9.113.206.79])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 18 Aug 2023 11:29:08 +0000 (GMT)
Subject: [PATCH v9 1/2] powerpc/rtas: export rtas_error_rc() for reuse.
From:   Mahesh Salgaonkar <mahesh@linux.ibm.com>
To:     linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 18 Aug 2023 16:59:07 +0530
Message-ID: <169235811556.193557.1023625262204809514.stgit@jupiter>
User-Agent: StGit/1.5
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4tK_0qneUppuI-d9HJ4FigQillqSpnQD
X-Proofpoint-ORIG-GUID: qjYkAtMXet7hxwNQZK0LRWEu9iRNWaG-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_13,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=903 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, #define descriptive names for common rtas return codes and use it
instead of numeric values.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
---
Change in v9:
- Keep the existing function name rtas_error_rc().
- Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
  https://lore.kernel.org/all/877cpxdksx.fsf@mail.lhotse/

Change in V7:
- Until v6 there was only one patch with subject "PCI hotplug: rpaphp:
  Error out on busy status from get-sensor-state". Starting from v7, adding
  this new patch to introduce rtas_generic_errno() to handle generic rtas
  error codes.
  https://lore.kernel.org/all/20220429162545.GA79541@bhelgaas/
---
 arch/powerpc/include/asm/rtas.h |    3 +++
 arch/powerpc/kernel/rtas.c      |   41 ++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 3abe15ac79db1..c697c3c746946 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -202,7 +202,9 @@ typedef struct {
 #define RTAS_USER_REGION_SIZE (64 * 1024)
 
 /* RTAS return status codes */
+#define RTAS_HARDWARE_ERROR	-1    /* Hardware Error */
 #define RTAS_BUSY		-2    /* RTAS Busy */
+#define RTAS_INVALID_PARAMETER	-3    /* Invalid indicator/domain/sensor etc. */
 #define RTAS_EXTENDED_DELAY_MIN	9900
 #define RTAS_EXTENDED_DELAY_MAX	9905
 
@@ -425,6 +427,7 @@ extern int rtas_set_indicator(int indicator, int index, int new_value);
 extern int rtas_set_indicator_fast(int indicator, int index, int new_value);
 extern void rtas_progress(char *s, unsigned short hex);
 int rtas_ibm_suspend_me(int *fw_status);
+int rtas_error_rc(int rtas_rc);
 
 struct rtc_time;
 extern time64_t rtas_get_boot_time(void);
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index c087eeee320ff..8cef3ccb41d16 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1330,33 +1330,34 @@ bool __ref rtas_busy_delay(int status)
 }
 EXPORT_SYMBOL_GPL(rtas_busy_delay);
 
-static int rtas_error_rc(int rtas_rc)
+int rtas_error_rc(int rtas_rc)
 {
 	int rc;
 
 	switch (rtas_rc) {
-		case -1: 		/* Hardware Error */
-			rc = -EIO;
-			break;
-		case -3:		/* Bad indicator/domain/etc */
-			rc = -EINVAL;
-			break;
-		case -9000:		/* Isolation error */
-			rc = -EFAULT;
-			break;
-		case -9001:		/* Outstanding TCE/PTE */
-			rc = -EEXIST;
-			break;
-		case -9002:		/* No usable slot */
-			rc = -ENODEV;
-			break;
-		default:
-			pr_err("%s: unexpected error %d\n", __func__, rtas_rc);
-			rc = -ERANGE;
-			break;
+	case RTAS_HARDWARE_ERROR:	/* Hardware Error */
+		rc = -EIO;
+		break;
+	case RTAS_INVALID_PARAMETER:	/* Bad indicator/domain/etc */
+		rc = -EINVAL;
+		break;
+	case -9000:			/* Isolation error */
+		rc = -EFAULT;
+		break;
+	case -9001:			/* Outstanding TCE/PTE */
+		rc = -EEXIST;
+		break;
+	case -9002:			/* No usable slot */
+		rc = -ENODEV;
+		break;
+	default:
+		pr_err("%s: unexpected error %d\n", __func__, rtas_rc);
+		rc = -ERANGE;
+		break;
 	}
 	return rc;
 }
+EXPORT_SYMBOL_GPL(rtas_error_rc);
 
 int rtas_get_power_level(int powerdomain, int *level)
 {


