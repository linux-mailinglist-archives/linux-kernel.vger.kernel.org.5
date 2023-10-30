Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C217DBE76
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjJ3REB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3RD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:03:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C319AA9;
        Mon, 30 Oct 2023 10:03:57 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UGq89N019398;
        Mon, 30 Oct 2023 17:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Cm9U6ewvIbSmyrPQ6MkMdG6wOV1IpT1AIYznLj3yZn8=;
 b=Di1/7H9sqSyIFz/XKEZH53h8F2ykKQScxe537uJYp8VB4EpPFE/DDL3LFKbPdLlzz9Pe
 ccfCoP4N10RGbSMNEbsuGScZz0uWwDPlDzWe+jeJphYthtF6EADKJGUEd639Z/B6Do1r
 Z8bNf4RonPDnn73gqaSiSHGCacIa9Mohk37xzHmWkw3mQGbs6mc89+Np5hbRBUqYQNJo
 n7QJGsoODQBPxz59ZZARKWZ9lTgE3xUJFRqm+oTsxfCOpQrThxt0RZaxXhaXIwAZ62vJ
 WFncMn0ZkK7/3vayuA0p0LK4pCOAiwD8b5xnNY6C4VsurSP1YgNAwesOSscRh3L+Wc7j RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2gcwrhqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 17:03:52 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UGrTui025086;
        Mon, 30 Oct 2023 17:03:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2gcwrhp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 17:03:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UGu92E007674;
        Mon, 30 Oct 2023 17:03:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmnajf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 17:03:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UH3lCH16646846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 17:03:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4657D2004E;
        Mon, 30 Oct 2023 17:03:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 133B62004D;
        Mon, 30 Oct 2023 17:03:47 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.152.212.201])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Oct 2023 17:03:47 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: fix documentation of buffer sizes
Date:   Mon, 30 Oct 2023 18:03:43 +0100
Message-ID: <20231030170343.748097-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NsAuDKbOsS7Ajzf0W97UmDimOj5RZXnf
X-Proofpoint-ORIG-GUID: DSVj9tsp4qFY-9SlvpI3O1NhZbQAgTvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 833bac7ec392 ("net/smc: Fix setsockopt and sysctl to
specify same buffer size again") the SMC protocol uses its own
default values for the smc.rmem and smc.wmem sysctl variables
which are no longer derived from the TCP IPv4 buffer sizes.

Fixup the kernel documentation to reflect this change, too.

Fixes: 833bac7ec392 ("net/smc: Fix setsockopt and sysctl to specify same buffer size again")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---
 Documentation/networking/smc-sysctl.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 6d8acdbe9be1..769149d98773 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -44,18 +44,16 @@ smcr_testlink_time - INTEGER
 
 wmem - INTEGER
 	Initial size of send buffer used by SMC sockets.
-	The default value inherits from net.ipv4.tcp_wmem[1].
 
 	The minimum value is 16KiB and there is no hard limit for max value, but
 	only allowed 512KiB for SMC-R and 1MiB for SMC-D.
 
-	Default: 16K
+	Default: 64KiB
 
 rmem - INTEGER
 	Initial size of receive buffer (RMB) used by SMC sockets.
-	The default value inherits from net.ipv4.tcp_rmem[1].
 
 	The minimum value is 16KiB and there is no hard limit for max value, but
 	only allowed 512KiB for SMC-R and 1MiB for SMC-D.
 
-	Default: 128K
+	Default: 64KiB
-- 
2.41.0

