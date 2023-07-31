Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390E07694F7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGaLeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGaLes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:34:48 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB93C3;
        Mon, 31 Jul 2023 04:34:47 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UNIc2w012062;
        Mon, 31 Jul 2023 04:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=KXU6HeF4XMVGolZFm5r+sG4Lh2+DVjYgvTIpuejrQLY=;
 b=AIkZewaV1xhVaOGtEZHeg38o33ecTt7WDl+3B0vd49cgN25e9Pe/6qsVS1LX/Wi83+hf
 ROdll7+7ZA3mm9VCTpCAlNXtCJAkfa6mpGbu4glX9mjegvXUYaqek4tmUSOKXEFCHiOT
 i7Nq5tQy7yAYKF3uMUYMe5pEhfecVto87YegAHjogq1jwwWonuu3AqD9njwTZDykIMTd
 h0X00/qciMSoNUjRFdhfWijYVViqz3wADIhsQDLnW5FXlljDnQAGcNuFy6WOgIGX4Hy2
 A1ggj4tV4V6tI6Uf8hrUii/f7TfBHvYmtBOedA5OyZxLffP14BPZ20Mpr2VPFLMLljpY TA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k4qgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:34:32 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 04:34:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 04:34:29 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 1EDFB3F70B7;
        Mon, 31 Jul 2023 04:34:24 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next 0/4] Packet classify by matching against SPI
Date:   Mon, 31 Jul 2023 17:04:04 +0530
Message-ID: <20230731113408.2586913-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: V1OO5pOKBsfEyJxPyzWURFHrfq0WO17X
X-Proofpoint-ORIG-GUID: V1OO5pOKBsfEyJxPyzWURFHrfq0WO17X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_05,2023-07-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.  net: flow_dissector: Add IPSEC dissector.
Flow dissector patch reads IPSEC headers (ESP or AH)
from packet and retrieves the SPI header.

2. tc: flower: support for SPI.
TC control path changes to pass SPI field from userspace tools to
kernel.

3. tc: flower: Enable offload support IPSEC SPI field.
This patch enables offload flags for SPI.

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

--
2.25.1

