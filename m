Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5447F1CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjKTSjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjKTSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:38:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B191FDF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:37:35 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIFiCt021361;
        Mon, 20 Nov 2023 18:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lO8b6ZXr7zrGhq7ykp8qfuxFOUwTl24MyRC5J5RxAco=;
 b=gB6mQUppGlsfKGPQaOH5aYAsVMikkH4cWu7BH/B7YWrmAs+H7mk3zJoydnU4yItpNeqE
 9z7xK3R2phtDUjtH+jqzSylrFkW8gCzrLLmSY2RMdi5G+GPSz76yy2o3PT7jG7dH9rbB
 U+aSPuQ0PO7arHH53coqx34PVYVmuVvwhiGuFRQ3BVpc9B4Nlq5ctwemk1y7Zmk80DwI
 FnpoLRkfM93QYdYit22p5GWCFlDuh71b2JvGJQ7b1zBjbawi3/WtsCo2Ak1cUq0pW2RH
 OSEGU4gmqe1SI9MxbRBwj7DUMjS4HrvMi2GtANsReVgRpLLsPnR8alLTG8i40WGgx1/w Hw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugcck8s7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIJ1Sf004988;
        Mon, 20 Nov 2023 18:37:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yybgvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKIbKtC38142362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:37:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EAF120040;
        Mon, 20 Nov 2023 18:37:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04D4F2004B;
        Mon, 20 Nov 2023 18:37:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 18:37:19 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vaneet Narang <v.narang@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] checkstack: allow to pass MINSTACKSIZE parameter
Date:   Mon, 20 Nov 2023 19:37:19 +0100
Message-Id: <20231120183719.2188479-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120183719.2188479-1-hca@linux.ibm.com>
References: <20231120183719.2188479-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QXUHMnfiDbPQtDbzUEehVZCRwAIcngRZ
X-Proofpoint-ORIG-GUID: QXUHMnfiDbPQtDbzUEehVZCRwAIcngRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=947 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checkstack script omits all functions with a stack usage of less than
100 bytes. However the script already has support for a parameter which
allows to override the default, but it cannot be set with

$ make checkstack

Add a MINSTACKSIZE parameter which allows to change the default. This might
be useful in order to print the stack usage of all functions, or only those
with large stack usage:

$ make checkstack MINSTACKSIZE=0
$ make checkstack MINSTACKSIZE=800

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 724c79bebe72..b90413e7e590 100644
--- a/Makefile
+++ b/Makefile
@@ -1576,7 +1576,8 @@ help:
 	 echo  '                    (default: $(INSTALL_HDR_PATH))'; \
 	 echo  ''
 	@echo  'Static analysers:'
-	@echo  '  checkstack      - Generate a list of stack hogs'
+	@echo  '  checkstack      - Generate a list of stack hogs and consider all functions'
+	@echo  '                    with a stack size larger than MINSTACKSIZE (default: 100)'
 	@echo  '  versioncheck    - Sanity check on version.h usage'
 	@echo  '  includecheck    - Check for duplicate included header files'
 	@echo  '  export_report   - List the usages of all exported symbols'
@@ -2016,9 +2017,10 @@ CHECKSTACK_ARCH := $(SUBARCH)
 else
 CHECKSTACK_ARCH := $(ARCH)
 endif
+MINSTACKSIZE	?= 100
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-	$(PERL) $(srctree)/scripts/checkstack.pl $(CHECKSTACK_ARCH)
+	$(PERL) $(srctree)/scripts/checkstack.pl $(CHECKSTACK_ARCH) $(MINSTACKSIZE)
 
 kernelrelease:
 	@$(filechk_kernel.release)
-- 
2.39.2

