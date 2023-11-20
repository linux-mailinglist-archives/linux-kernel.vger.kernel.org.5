Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457AE7F1CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjKTSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjKTSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:38:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA11FDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:37:35 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIHJUs020976;
        Mon, 20 Nov 2023 18:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=E/vsR2CcymYSm985vL9ENNfIO2zw1NKuUZb7kmUZ170=;
 b=Vkd6eJ/18pLUhz2fwtivxOjtkCWkqw/Ww14fOiWnTKfT59KIXNc3qR4OsUXLcKuc6c7q
 sb/KnZOLz7roYcedLbKuCE4OcYOJMA+U6Zxi3zMh3lOKueo+y1NHySumGpLpuZbtxm4J
 3waMnWWi8ktbk0w6P1/ZRrMCThbLTR1B6w5QIoNU/sDmFPwvjVLuGAttg+5HINHmGybM
 zVkFYKNYM3WrUwIR6UzS/XvSPUqSEyOwb8Ay29uNkPHnNCbwhV7SxKRpxJwcUY4UeHHC
 RmdTLIUWZXSar/7pAJU9H0OI303/19jydlisvs7huOkQVQfugploTfLETNxazV0axcaL Eg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugckm8h8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIJ3Ui004451;
        Mon, 20 Nov 2023 18:37:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kk6nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKIbJYr24511162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:37:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCFFE20040;
        Mon, 20 Nov 2023 18:37:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2B262004B;
        Mon, 20 Nov 2023 18:37:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 18:37:19 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vaneet Narang <v.narang@samsung.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] checkstack: fix printed address
Date:   Mon, 20 Nov 2023 19:37:17 +0100
Message-Id: <20231120183719.2188479-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120183719.2188479-1-hca@linux.ibm.com>
References: <20231120183719.2188479-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wl8vcNd4LKOuvg-on9YCrW2Dwi4CLeR4
X-Proofpoint-GUID: wl8vcNd4LKOuvg-on9YCrW2Dwi4CLeR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=979
 mlxscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
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

All addresses printed by checkstack have an extra incorrect 0 appended at
the end.

This was introduced with commit 677f1410e058 ("scripts/checkstack.pl: don't
display $dre as different entity"): since then the address is taken from
the line which contains the function name, instead of the line which
contains stack consumption. E.g. on s390:

0000000000100a30 <do_one_initcall>:
...
  100a44:       e3 f0 ff 70 ff 71       lay     %r15,-144(%r15)

So the used regex which matches spaces and hexadecimal numbers to extract
an address now matches a different substring. Subsequently replacing spaces
with 0 appends a zero at the and, instead of replacing leading spaces.

Fix this by using the proper regex, and simplify the code a bit.

Fixes: 677f1410e058 ("scripts/checkstack.pl: don't display $dre as different entity")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 scripts/checkstack.pl | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index d83ba5d8f3f4..f27d552aec43 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -138,15 +138,11 @@ $total_size = 0;
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
 		$func = $1;
-		next if $line !~ m/^($xs*)/;
+		next if $line !~ m/^($x*)/;
 		if ($total_size > $min_stack) {
 			push @stack, "$intro$total_size\n";
 		}
-
-		$addr = $1;
-		$addr =~ s/ /0/g;
-		$addr = "0x$addr";
-
+		$addr = "0x$1";
 		$intro = "$addr $func [$file]:";
 		my $padlen = 56 - length($intro);
 		while ($padlen > 0) {
-- 
2.39.2

