Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A5A752EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjGNBxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjGNBxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:53:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725142D6D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 18:53:01 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E1koq7010660;
        Fri, 14 Jul 2023 01:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3uRrKMFzdvM8kM3g6AHgMDAj4xX/QFx3fgZft/ow26A=;
 b=fDcvv39Moiud3c+k7hprkvPke+qlhaEhF1e9KJa3crSMuL+PKgYMm92KLz0lMBHp+d5h
 lf2oGP8D1NjZYp/caJqFe4VMVbFtVdmQU08jJNnYmCYizCv+JwkVcv4kGEzyd22yXIyk
 U9z2NqiobzO1YgbTiYQ3AlyhI0BgpGXjAew+BQ05JSOU82uVgZ8VTCh+dxmfItgk2MRc
 LHfD/JnujTlKMl+/MQMaxsfn+V63Q7btY4LDUzoCHkm5B4Hlri8dTg4D+BhnZYpL4l8w
 ahPvOywhDRB2yXp5hQWINJ4e845HsqwAUG+D2cjjyHo2rTAIyXIFlIO9ETrGm44wQsVu yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtvjfgj6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 01:52:59 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36E1jrNi007396;
        Fri, 14 Jul 2023 01:52:59 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtvjfgj60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 01:52:59 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E1q8Lw001421;
        Fri, 14 Jul 2023 01:52:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rtqk182yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 01:52:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36E1qtCa35979766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 01:52:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB7402004B;
        Fri, 14 Jul 2023 01:52:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75CD82004D;
        Fri, 14 Jul 2023 01:52:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 01:52:54 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 84772600D5;
        Fri, 14 Jul 2023 11:52:50 +1000 (AEST)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     akpm@linux-foundation.org, glider@google.com,
        xkernel.wang@foxmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/test_meminit: Allocate pages up to order MAX_ORDER
Date:   Fri, 14 Jul 2023 11:52:38 +1000
Message-ID: <20230714015238.47931-1-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h-ZBDNFIgYFqTFZSM4iTjfB9fGdfCIfG
X-Proofpoint-GUID: Zdnf7OHehbpapRcPgDpfKuOPvlPykWU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140012
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_pages() tests the page allocator by calling alloc_pages() with
different orders up to order 10.

However, different architectures and platforms support different maximum
contiguous allocation sizes. The default maximum allocation order
(MAX_ORDER) is 10, but architectures can use CONFIG_ARCH_FORCE_MAX_ORDER
to override this. On platforms where this is less than 10, test_meminit()
will blow up with a WARN(). This is expected, so let's not do that.

Replace the hardcoded "10" with the MAX_ORDER macro so that we test
allocations up to the expected platform limit.

Fixes: 5015a300a522 ("lib: introduce test_meminit module")
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 lib/test_meminit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 60e1984c060f..0ae35223d773 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -93,7 +93,7 @@ static int __init test_pages(int *total_failures)
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i <= MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();
-- 
2.41.0

