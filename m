Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2104E76A446
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGaWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGaWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:43:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D719A8;
        Mon, 31 Jul 2023 15:43:13 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VMDULj011514;
        Mon, 31 Jul 2023 22:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=mX0l+/kfcc46QeRLAxUTpA05imjKAVhsdjPgFznUjeU=;
 b=SHyeTmeKcuyoGo3lD2Kq3nAzn1YVsaA87Nlul8DT4XFNZuHH5rHPfc6TCLhoC2Pn+bAi
 lb2lt4IgEmdWKako+LDQujupU33D153dJMdB8n09OP0Ux/4dJjjYY6vYzq1E4qR0zk54
 0EwUTAXvxvUdxF8PxcjV9g3h0gyhBKl1NS1kzfQnwTku9loBOnBSXK6lQl/Q55rvJHY1
 IUj2Ank7yk5P02xFpm/J+1aMm0J3/WQi1I8hQYId2YqFGyuk4rFADV/n6jYNG/ScpeJX
 ED424f2Q+JUKiujjXG1Oy7UmPkOd4j43bUHNWmeaCygOT4hP3EEj31nS8+nb6YjsRUgQ pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6a2va4w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:43:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VMh0Be025416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:43:01 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 15:43:00 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <corbet@lwn.net>
CC:     <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_okukatla@quicinc.com>,
        <quic_viveka@quicinc.com>, <peterz@infradead.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH v2 0/3] Add interconnect debugfs client
Date:   Mon, 31 Jul 2023 15:42:44 -0700
Message-ID: <20230731224247.10846-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xugIdbzTsZjm7jagzTPU86rJ_ubENZsJ
X-Proofpoint-GUID: xugIdbzTsZjm7jagzTPU86rJ_ubENZsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=769 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces interconnect debugfs files that support voting
for any path the framework supports.

We've historically relied on an out-of-tree module for this, which used
the old icc_get() that was recently removed in [0]. The old icc_get()
took integer endpoint IDs, which made identifying paths in our old
implementation non-intuitive. The logical node names typically don't
change much chip-to-chip, but the raw integer IDs do. Take this
opportunity to introduce an icc_get() that uses string names instead,
which allows for a more intuitive and generic debugfs interface.

We rely on this support for debug, test, and verification. Hopefully
it'll be useful for other vendors as well.

[0] commit 7dcdad6f32c9 ("interconnect: drop unused icc_get() interface")

Changes in v2:
- Make icc_get() an internal interface.
- RCU-protect src_node and dst_node.
- Replace PLATFORM_DEVID_AUTO with PLATFORM_DEVID_NONE.
- Remove unnecessary #include.
- Add debugfs client documentation.

Mike Tipton (3):
  debugfs: Add write support to debugfs_create_str()
  interconnect: Reintroduce icc_get()
  interconnect: Add debugfs test client

 Documentation/driver-api/interconnect.rst |  25 ++++
 drivers/interconnect/Makefile             |   2 +-
 drivers/interconnect/core.c               |  66 +++++++++
 drivers/interconnect/debugfs-client.c     | 168 ++++++++++++++++++++++
 drivers/interconnect/internal.h           |   3 +
 fs/debugfs/file.c                         |  48 ++++++-
 6 files changed, 309 insertions(+), 3 deletions(-)
 create mode 100644 drivers/interconnect/debugfs-client.c

-- 
2.17.1

