Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C507F1CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjKTSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjKTSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:38:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9BF1FD6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:37:34 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIWHKg011799;
        Mon, 20 Nov 2023 18:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WnzPVvLAMntpaYxm4Pu6jywEC25pglrK8t3Z1BZT8CI=;
 b=ihQvN+SgmsqlfdIevpQyxwy/foFREXQNHd6sUEAuu4iR1EtXBP+WudqVqGBSizeCaDqm
 vIXcw4HhJZBNzOEncvzHHThJAjcVmHFasKkPA110ElKYUX4WX3RFBOX2kl2WW2CIHCd8
 JUP5l3IOY3pidFjTRRxO+Jkna9ZpnHqf0+KpgLPvmsqPhatSRK01YQjmf9Od62E5q87a
 EmTkZAiyiOrrGgsdNPZQj1aC1Fxt5RAaDir7t93xHMptydkqdElGGav+xxqDF7zdEjWB
 WUvoS0kGHsVMfp9qsnrGFbRDEG+yQxOHV7Ti+dfAadANhIviWQn+eF8KMPQK8cFp/+Ci Fg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugctk04c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKIJ4dk005013;
        Mon, 20 Nov 2023 18:37:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yybgvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 18:37:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKIbJCn24511160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 18:37:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE73920043;
        Mon, 20 Nov 2023 18:37:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A2EC20040;
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
Subject: [PATCH 0/3] checkstack: bug fix and minor improvements
Date:   Mon, 20 Nov 2023 19:37:16 +0100
Message-Id: <20231120183719.2188479-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Tjkliqil1Xnxs-VK591LfUr2WE4Wiv0
X-Proofpoint-GUID: 4Tjkliqil1Xnxs-VK591LfUr2WE4Wiv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxlogscore=745
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to use the checkstack script to print the stack usage of all
functions, I noticed that this is not possible without changing it. In
addition the current output contains a bug, and the output can be improved.

Therefore fix the bug and improve the script a bit.

Heiko Carstens (3):
  checkstack: fix printed address
  checkstack: sort output by size and function name
  checkstack: allow to pass MINSTACKSIZE parameter

 Makefile              |  6 ++++--
 scripts/checkstack.pl | 27 +++++++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.39.2

