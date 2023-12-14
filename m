Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8F812758
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjLNF6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbjLNF5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:57:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638741730
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:57:07 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE4Whb3031214;
        Thu, 14 Dec 2023 05:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=S5PvZzwihJCEtsOMzLDq/hhL3tFxZ+GRI8sP7cCU/cE=;
 b=pVMS5U4msmHXiFD9YiJYHALzYOZ1nTA9EEhPrWsxn9x4KpgoIHRTR+bsnthmbFSO17X6
 nsBaDVxqot4Ejq0uKbEV/yHlwL2gWOmVmmQMfqqSNJU9aI+mPIebes1DinnXWUyBxvv6
 MOO2pwLkzfduveOrmbccVhouEgaimeKDxSVd5vUmKdlpD2JUqZUUNB4p9+ropC6M4aaA
 WqgHeVgEtn1QvVZTCVFBeYVDMfaig2ts5deA0ej3r5wdIKxiScvllfh7YNFK57zs+tiH
 9Ej/sAqOzUMCNcmY//1y6iyJ1A4oxFVYtHjupzZiQDpVnSEouEYg8W/sHDDXxD238lAz rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyts2hk9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:54 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE5SBmS029575;
        Thu, 14 Dec 2023 05:56:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyts2hk39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE3JYZ1028220;
        Thu, 14 Dec 2023 05:56:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xyxhmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE5uOjJ22151732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 05:56:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04D7B2004D;
        Thu, 14 Dec 2023 05:56:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 864E920040;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from nicholasmvm.. (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 77E0D605F3;
        Thu, 14 Dec 2023 16:56:19 +1100 (AEDT)
From:   Nicholas Miehlbradt <nicholas@linux.ibm.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH 05/13] powerpc: Unpoison buffers populated by hcalls
Date:   Thu, 14 Dec 2023 05:55:31 +0000
Message-Id: <20231214055539.9420-6-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214055539.9420-1-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oohPGHWoNwWW22yXQxLqPk3YupwgWY9n
X-Proofpoint-GUID: v3dSSLQcrbP9Wpukc5CGgwUiAQvQLOIY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_02,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=695 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

plpar_hcall provides to the hypervisor a buffer where return data should be
placed. The hypervisor initializes the buffers which is not visible to
KMSAN so unpoison them manually.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hvconsole.c | 2 ++
 arch/powerpc/sysdev/xive/spapr.c           | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hvconsole.c b/arch/powerpc/platforms/pseries/hvconsole.c
index 1ac52963e08b..7ad66acd5db8 100644
--- a/arch/powerpc/platforms/pseries/hvconsole.c
+++ b/arch/powerpc/platforms/pseries/hvconsole.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/errno.h>
+#include <linux/kmsan-checks.h>
 #include <asm/hvcall.h>
 #include <asm/hvconsole.h>
 #include <asm/plpar_wrappers.h>
@@ -32,6 +33,7 @@ int hvc_get_chars(uint32_t vtermno, char *buf, int count)
 	unsigned long *lbuf = (unsigned long *)buf;
 
 	ret = plpar_hcall(H_GET_TERM_CHAR, retbuf, vtermno);
+	kmsan_unpoison_memory(retbuf, sizeof(retbuf));
 	lbuf[0] = be64_to_cpu(retbuf[1]);
 	lbuf[1] = be64_to_cpu(retbuf[2]);
 
diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index e45419264391..a9f48a336e4d 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
+#include <linux/kmsan-checks.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -191,6 +192,8 @@ static long plpar_int_get_source_info(unsigned long flags,
 		return rc;
 	}
 
+	kmsan_unpoison_memory(retbuf, sizeof(retbuf));
+
 	*src_flags = retbuf[0];
 	*eoi_page  = retbuf[1];
 	*trig_page = retbuf[2];
-- 
2.40.1

