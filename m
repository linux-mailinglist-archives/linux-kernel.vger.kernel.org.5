Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED124812745
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443193AbjLNF4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjLNF4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:56:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED7F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:56:40 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE5a1Q0017827;
        Thu, 14 Dec 2023 05:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Juc4Y9f1da+QG61OsnOsRxYD8gnzRS0DoClXjZT+6Ac=;
 b=kbdN2RUv9L1Mstd/H+mMvfTK3IcZ8z25nw4jvp8GmbJk4xQcLWJKeAxXvu0gMtBGh0Cf
 Ko17UIMizebpHPG9qXnX5se7R4qyTmDbj6HsAng7my6T6NFAQHhl+9kmIpLddiMBLCSV
 aalWBqqWnSr9ezgzddi5ruehPeY0e6C2VDUJG7K3RKLuGLaR31VSmY0ZyR4MWUGZMKrU
 bIzj4UAKUYXBmJ+w6g0wH+uUyBFJ7V2mUwZjxOZegzFa9jprz15xIFjnydsmN9dOuebs
 Sr/wpCcm+n8g/DAGGz93H0svng1Q8FZF5p4J9fz2i0O1u5z8ic45bE4jn44UICiEFhNm lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uypke6etp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:25 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE5oqdo021978;
        Thu, 14 Dec 2023 05:56:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uypke6et5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE59ikW005066;
        Thu, 14 Dec 2023 05:56:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skp2pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE5uMki23593568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 05:56:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ABCA20040;
        Thu, 14 Dec 2023 05:56:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3E6A20043;
        Thu, 14 Dec 2023 05:56:21 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 05:56:21 +0000 (GMT)
Received: from nicholasmvm.. (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 614A160512;
        Thu, 14 Dec 2023 16:56:19 +1100 (AEDT)
From:   Nicholas Miehlbradt <nicholas@linux.ibm.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH 02/13] hvc: Fix use of uninitialized array in udbg_hvc_putc
Date:   Thu, 14 Dec 2023 05:55:28 +0000
Message-Id: <20231214055539.9420-3-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214055539.9420-1-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5s9tPtGFdVEMzglhXmmo7wVAP7ART-bK
X-Proofpoint-ORIG-GUID: Ud8w0bTXb7aQg9hzmWAmWuScZ2QEkFZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_02,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=858
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312140035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All elements of bounce_buffer are eventually read and passed to the
hypervisor so it should probably be fully initialized.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 drivers/tty/hvc/hvc_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 736b230f5ec0..1e88bfcdde20 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -227,7 +227,7 @@ static const struct hv_ops hvterm_hvsi_ops = {
 static void udbg_hvc_putc(char c)
 {
 	int count = -1;
-	unsigned char bounce_buffer[16];
+	unsigned char bounce_buffer[16] = { 0 };
 
 	if (!hvterm_privs[0])
 		return;
-- 
2.40.1

