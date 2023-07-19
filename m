Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D27593C5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGSLFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGSLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:05:42 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29679E42;
        Wed, 19 Jul 2023 04:05:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J9jrtn013032;
        Wed, 19 Jul 2023 04:05:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=JC+SlG2J1cwHPNYKwRoVuKapytz+jNTHeq1scJHPdeg=;
 b=Ix3MCGYUm998VvdjXYeUNa3FsQVhI0bC4a6Es5AB+hcIXPcvzcjwaELEuKvy5En/8ANn
 DDK42qPxz2KArvU+vVF+LeJ1OKG/95COP013imq1zwU6wjs0UVrJudrLnQU1+5DGFFzL
 +quWuKuT86s1KkJ2VuMN5YRZk1g1mX8sqIVRUpVwbT+m3f5wewxrSmBvqE8NiAaPJuxm
 8/G0/PXqan6Wd+gi4WBMJnkDrO9hwVOf7Mxh9ezm4X6CKsFGq3BJ+6xyqzSg8xLziBLK
 e51oQuc5mXKbmW2m0KUsPt54PRCZvbwbmxsx7h5WwySjvpqNz62nc6PuK7GFlGZ+Ymea dQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rwyc6je0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 04:05:18 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 04:04:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 19 Jul 2023 04:04:50 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 197623F704F;
        Wed, 19 Jul 2023 04:04:44 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>,
        <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <maxtram95@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [net-next PatchV4 0/4] octeontx2-pf: support Round Robin scheduling
Date:   Wed, 19 Jul 2023 16:34:39 +0530
Message-ID: <20230719110443.15310-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: gv3LVWq6OLvDfRF9DNmHhmgmuMhz9Eo4
X-Proofpoint-ORIG-GUID: gv3LVWq6OLvDfRF9DNmHhmgmuMhz9Eo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

octeontx2 and CN10K silicons support Round Robin scheduling. When multiple
traffic flows reach transmit level with the same priority, with Round Robin
scheduling traffic flow with the highest quantum value is picked. With this
support, the user can add multiple classes with the same priority and
different quantum in htb offload.

This series of patches adds support for the same.

Patch1: implement transmit schedular allocation algorithm as preparation
        for support round robin scheduling.

Patch2: Allow quantum parameter in HTB offload mode.

Patch3: extends octeontx2 htb offload support for Round Robin scheduling

Patch4: extend QOS documentation for Round Robin scheduling

Hariprasad Kelam (1):
  docs: octeontx2: extend documentation for Round Robin scheduling

Naveen Mamindlapalli (3):
  octeontx2-pf: implement transmit schedular allocation algorithm
  sch_htb: Allow HTB quantum parameter in offload mode
  octeontx2-pf: htb offload support for Round Robin scheduling
---
v4 * update classid values in documentation.

v3 * 1. update QOS documentation for round robin scheduling
     2. added out of bound checks for quantum parameter

v2 * change data type of otx2_index_used to reduce size of structure
     otx2_qos_cfg

 .../ethernet/marvell/octeontx2.rst            |   8 +
 .../marvell/octeontx2/nic/otx2_common.c       |   1 +
 .../marvell/octeontx2/nic/otx2_common.h       |   1 +
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 398 ++++++++++++++++--
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |   4 +-
 include/net/pkt_cls.h                         |   1 +
 net/sched/sch_htb.c                           |   7 +-
 8 files changed, 388 insertions(+), 43 deletions(-)

--
2.17.1
