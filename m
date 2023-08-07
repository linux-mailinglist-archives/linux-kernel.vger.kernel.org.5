Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FA7727CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjHGOaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjHGOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:30:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C7410DD;
        Mon,  7 Aug 2023 07:30:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377DoQtY000876;
        Mon, 7 Aug 2023 14:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=WoSxx6ZruXxGBfMVehlHMK4su0XVr2Ci5fp6ctuEGh4=;
 b=aSxwSCFhzXeMczhqF1S5pjhRMFyrwwDNgwPxy3Mch/22y3MDWJ3pSDfSQ5/JmXyoa84n
 IuETwrfPgebgrt5V4sAL7ggYql6yxS2Zs/LB26adcA/aDSqT/jsVLBs0d2n9TqAdhc7p
 5IcrM9blILi+V5RWmluh4sE0Bh3ZW85QFmGffwCOo85NamTwdwlx3tSXnNoGdV1xpmml
 Q73gACPjGxKbCltPmy9+GDjp+fugAH9ZWLdWwOf2W42iApBVCCuAtoruWuu9AHAFVRLL
 PtWPfXhBCckBcqkKwN61j+EjpVAgjBsfMbCicCxfZKj/dtJ8zzy9J1KTum79xJroeZ9G mw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9endkm0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 14:29:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377ETtX1008128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 14:29:55 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 7 Aug 2023 07:29:55 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <corbet@lwn.net>
CC:     <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_okukatla@quicinc.com>, <quic_viveka@quicinc.com>,
        <peterz@infradead.org>, <quic_pkondeti@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: [PATCH v3 0/3] Add interconnect debugfs client
Date:   Mon, 7 Aug 2023 07:29:11 -0700
Message-ID: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JzplI7XndwFknZJOOyveOWmb3Frp8xWt
X-Proofpoint-ORIG-GUID: JzplI7XndwFknZJOOyveOWmb3Frp8xWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=792 adultscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v3:
- Use GFP_ATOMIC when allocating with the rcu lock held.

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

