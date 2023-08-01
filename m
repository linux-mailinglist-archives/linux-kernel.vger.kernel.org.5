Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549C476A677
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjHABlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHABlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:41:20 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F861988;
        Mon, 31 Jul 2023 18:41:19 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VMXrYG010378;
        Mon, 31 Jul 2023 18:41:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=GxkItpsAbwiG+YRD3iuiGsE6HH2Xw12N4R604R5jrfI=;
 b=ATCLGPyopzSwZOp4xB6OTsM9+nje2x1NU1aMNgf7O4IcbvnCeJJOtULAjcT2VeGUzFze
 e7lDBtjzCW5tsLvD78XxfnfP1ohIAzfd12oAa2QA6jUYrnY0gkXDJUAp9ENyLwDMEoAd
 44qtOMWmJH2N0GeHmRsTGJ4CgTai5CwZLda0nUxR0/LQQVqKH2lYeYdLB172QlQVm6mC
 fBCZZdsZ4P8WDm6g/XAU8WYLwQqwqKqXKV6Z6H+XVXgT0txyN7rlxTWqlDues4v5HG3U
 XyiFAda6r4okqtDcTe1kovEDu8FWTgzV+tmW0ppwvetboXIsX7Ziap+mkV7d5aATa01M Mg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k70dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:41:10 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 18:41:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 18:41:08 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 77A8E3F704B;
        Mon, 31 Jul 2023 18:41:03 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v1 net-next 0/4] Packet classify by matching against SPI
Date:   Tue, 1 Aug 2023 07:10:57 +0530
Message-ID: <20230801014101.2955887-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gCp4vK7oN_7kMBgoruapCUum5upuQsUf
X-Proofpoint-ORIG-GUID: gCp4vK7oN_7kMBgoruapCUum5upuQsUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_18,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.  net: flow_dissector: Add IPSEC dissector.
Flow dissector patch reads IPSEC headers (ESP or AH) header
from packet and retrieves the SPI header.

2. tc: flower: support for SPI.
TC control path changes to pass SPI field from userspace to
kernel.

3. tc: flower: Enable offload support IPSEC SPI field.
Next patch enables the HW support for classify offload for ESP/AH.
This patch enables the HW offload control.

4. octeontx2-pf: TC flower offload support for SPI field.
HW offload support for classification in octeontx2 driver.

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  1 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  4 ++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 11 ++++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 27 ++++++++++
 include/net/flow_dissector.h                  |  9 ++++
 include/net/flow_offload.h                    |  6 +++
 include/uapi/linux/pkt_cls.h                  |  3 ++
 net/core/flow_dissector.c                     | 53 ++++++++++++++++++-
 net/core/flow_offload.c                       |  7 +++
 net/sched/cls_flower.c                        | 35 ++++++++++++
 11 files changed, 159 insertions(+), 1 deletion(-)

---
ChangeLog

v0 -> v1: Fix new fields in the middle of UAPI exposed enum.

--
2.25.1

