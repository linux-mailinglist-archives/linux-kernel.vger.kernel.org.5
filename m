Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1713D8055EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442197AbjLENat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442200AbjLENam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:30:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBFE19B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:30:47 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5DMxxL014011;
        Tue, 5 Dec 2023 13:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=IxxfLKX8MzSwgz9dQIi2KYO51vLAAjIBTx7N6eaZqN0=;
 b=gjYZk7dqkmvyTD1Ne1g0A1RtVertEoNUDNbb+OmI69mYV+nRG82vmZTRohZPVAo9uPoz
 TI9FlB4AHnD2CqHjyQC+KucDFD/WNAPhAmOoF3tcQnQIdTlM/K4A3OfxosBNoctMUEzP
 PRzvHeGfE3FDrWyP2WaRjPmjC+HUXfuYo1+Iq+aSocNpKc41TIpTAe3i3IPlm1Ze27Yd
 kRM8efmmzjGJIOFDpLSC5cI1AxZkEHE95Srjd7MpSswT+dLScMpQteKZidgziYV1w9VX
 y6lnYaf6QntVtfqMUQJtsThfjKcW4fdqH4h0hYunIDypKk18GvVhfXRvprVb5h+utYsR nw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut4pq8ayk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5AnuS1028493;
        Tue, 5 Dec 2023 13:30:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8b3knd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5DUOqw59965918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 13:30:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC18E2004B;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD5A920043;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B17A2E08BE; Tue,  5 Dec 2023 14:30:23 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 0/3] entry: inline syscall enter/exit functions
Date:   Tue,  5 Dec 2023 14:30:12 +0100
Message-Id: <20231205133015.752543-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qp2KZ1wCvP--ewQ9wSU_vP71h_4m-_ku
X-Proofpoint-GUID: Qp2KZ1wCvP--ewQ9wSU_vP71h_4m-_ku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_08,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 mlxlogscore=499 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

looking into the performance of syscall entry/exit after s390 switched
to generic entry showed that there's quite some overhead calling some
of the entry/exit work functions even when there's nothing to do.
This patchset moves the entry and exit function to entry-common.h, so
non inlined code gets only called when there is some work pending.

I wrote a small program that just issues invalid syscalls in a loop.
On an s390 machine, this results in the following numbers:

without this series:

# ./syscall 1000000000
runtime: 94.886581s / per-syscall 9.488658e-08s

with this series:

./syscall 1000000000
runtime: 84.732391s / per-syscall 8.473239e-08s

so the time required for one syscall dropped from 94.8ns to
84.7ns, which is a drop of about 11%.

Sven Schnelle (3):
  entry: move exit to usermode functions to header file
  move enter_from_user_mode() to header file
  entry: move syscall_enter_from_user_mode() to header file

 include/linux/entry-common.h | 137 ++++++++++++++++++++++++++++++++-
 kernel/entry/common.c        | 145 ++---------------------------------
 2 files changed, 138 insertions(+), 144 deletions(-)

-- 
2.40.1

