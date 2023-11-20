Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CAA7F1CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjKTSjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjKTSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:38:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9B1BF9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:37:35 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIHKYZ021021;
        Mon, 20 Nov 2023 18:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+F/cUixVAYjDgd9Egr5Yd3zkGzwMoesXvpOYHsfswJE=;
 b=Uv48w3LgxsFvQ3PmUUGvFxuEgsHl2OxjfQn9tziRgiTPsmLs8YY6g1f4N6izpW8gn8fo
 Hb+PmXDJ7s9DgIK4OrZCE+2gegg0py30ezzyDs2lKcufzFf1q3f3h+wx+IeFfyNyBQsP
 MenFpBnG2OvJLpWUqG0Xs5KYD/kg+88B2+jgUtNzjEbHpgZ2ISke3GFVUgwS9qZDKXLn
 Fb62EPhaxSw6dBKWVqFvvmYWqjDxZp2vNNeWj3wWjFxr5jMGkbjiSe3PkYsVeZeFpJti
 FIwZfO9CEgymUV0WOC+E50quy/8PTdRmdm2zxq2bLG58xTYZ44UbO6nO9lYOFxsnSZXM KA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugckm8h8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIJ1Dv004986;
        Mon, 20 Nov 2023 18:37:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yybgvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKIbKvi45482474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:37:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 006B620043;
        Mon, 20 Nov 2023 18:37:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D139D2004D;
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
Subject: [PATCH 2/3] checkstack: sort output by size and function name
Date:   Mon, 20 Nov 2023 19:37:18 +0100
Message-Id: <20231120183719.2188479-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120183719.2188479-1-hca@linux.ibm.com>
References: <20231120183719.2188479-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qpMncvlknwdtNkNNmJ1yQGE3iq5VIuMw
X-Proofpoint-GUID: qpMncvlknwdtNkNNmJ1yQGE3iq5VIuMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=684
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

Sort output by size and in addition by function name. This increases
readability for cases where there are many functions with the same stack
usage.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 scripts/checkstack.pl | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index f27d552aec43..13408714ba0f 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -189,5 +189,20 @@ if ($total_size > $min_stack) {
 	push @stack, "$intro$total_size\n";
 }
 
-# Sort output by size (last field)
-print sort { ($b =~ /:\t*(\d+)$/)[0] <=> ($a =~ /:\t*(\d+)$/)[0] } @stack;
+# Sort output by size (last field) and function name if size is the same
+sub sort_lines {
+	my ($a, $b) = @_;
+
+	my $num_a = $1 if $a =~ /:\t*(\d+)$/;
+	my $num_b = $1 if $b =~ /:\t*(\d+)$/;
+	my $func_a = $1 if $a =~ / (.*):/;
+	my $func_b = $1 if $b =~ / (.*):/;
+
+	if ($num_a != $num_b) {
+		return $num_b <=> $num_a;
+	} else {
+		return $func_a cmp $func_b;
+	}
+}
+
+print sort { sort_lines($a, $b) } @stack;
-- 
2.39.2

