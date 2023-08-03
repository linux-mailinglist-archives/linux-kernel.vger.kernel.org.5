Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A8076ED0C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjHCOq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjHCOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:46:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C701BFD;
        Thu,  3 Aug 2023 07:46:15 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373Eg9WA011702;
        Thu, 3 Aug 2023 14:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=KSzO+DJi2m7hGqUcW+/j+Cty0iuxk0Q1Nr6NiQLzLnw=;
 b=qBbM49Ti7g+h72vkxtknlVZKC24LUljc33M/vpQiVvpILYXWid0HLriE8LwBtMiS+v7P
 AWK4ddoyz7VyNjXKDbcm6r5YUUwirBKMGPFgVD8r/jHzEZUOMGRmoNcU5ouq+7JLf7uW
 4Kq+AJ1oRV9wicVHI0+2rNxZXxBNUdLWHcIIbzELMNZK0sp9pl9hlmv+Q4suPCUu7xtm
 klHDVnpIVEV+FKpsSK8lmvRdug0Ga8sie4wGQ1eIhIwVBDiYkHRowkuC0C/VQNfL8Et/
 YCCOLOs/z6WqWjZJK0EE7K921hgoiOjcJ5/yuxXn6I/I7ip9DGYmRr/EkTr2yPaLCn6A 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8e7wr4wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 14:46:12 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373Egc24014493;
        Thu, 3 Aug 2023 14:46:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8e7wr4vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 14:46:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373EaOKb017041;
        Thu, 3 Aug 2023 14:46:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5dfypgg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 14:46:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373Ek71r23724654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 14:46:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF69C20043;
        Thu,  3 Aug 2023 14:46:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8410920040;
        Thu,  3 Aug 2023 14:46:06 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 14:46:06 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net/smc: Fix effective buffer size
Date:   Thu,  3 Aug 2023 16:46:03 +0200
Message-ID: <20230803144605.477903-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xkye_Trlwdbr_5uRwckIT_sjtBRWogOM
X-Proofpoint-ORIG-GUID: h-yGqPYQVqSNj0_F7Qm1Ow16vgQDtoik
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=695 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
and make them tunable") started to derive the effective buffer size for
SMC connections inconsistently in case a TCP fallback was used and
memory consumption of SMC with the default settings was doubled when
a connection negotiated SMC. That was not what we want.

This series consolidates the resulting effective buffer size that is
used with SMC sockets, which is based on Jan Karcher's effort (see 
[1]). For all TCP exchanges (in particular in case of a fall back when
no SMC connection was possible) the values from net.ipv4.tcp_[rw]mem
are used. If SMC succeeds in establishing a SMC connection, the newly
introduced values from net.smc.[rw]mem are used.

net.smc.[rw]mem is initialized to 64kB, respectively. Internal test 
have show this to be a good compromise between throughput/latency 
and memory consumption. Also net.smc.[rw]mem is now decoupled completely
from any tuning through net.ipv4.tcp_[rw]mem.

If a user chose to tune a socket's receive or send buffer size with
setsockopt, this tuning is now consistently applied to either fall-back
TCP or proper SMC connections over the socket.

Thanks,
Gerd 

v1 - v2:
 - In second patch, use sock_net() helper as suggested by Tony and demanded
   by kernel test robot.

[1] https://lore.kernel.org/netdev/20221123104907.14624-1-jaka@linux.ibm.com


Gerd Bayer (2):
  net/smc: Fix setsockopt and sysctl to specify same buffer size again
  net/smc: Use correct buffer sizes when switching between TCP and SMC

 net/smc/af_smc.c     | 77 ++++++++++++++++++++++++++++++--------------
 net/smc/smc.h        |  2 +-
 net/smc/smc_clc.c    |  4 +--
 net/smc/smc_core.c   | 25 +++++++-------
 net/smc/smc_sysctl.c | 10 ++++--
 5 files changed, 76 insertions(+), 42 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.41.0

