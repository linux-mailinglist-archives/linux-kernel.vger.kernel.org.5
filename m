Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF070755F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGQJdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGQJdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:33:42 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5FBE;
        Mon, 17 Jul 2023 02:33:41 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H5Tp1v020422;
        Mon, 17 Jul 2023 02:33:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=y6hp+s+hQsfK+6/k8ufarcCUrnxJf/cZ5C+kliYfWUk=;
 b=QEXlSB5hB/u7k84bjv0GEIkf3LJ1t5B/wjc8R50EMEuy0lOJHyQ0RUIICQRbJpNSE0No
 90nUGYjiNqeF0S8khT0+DuS4vFtpDXUa9Trowa/Ovew3QB0QZMwdkB36IjLxBbVQ6Csp
 PlGZq/Z8A7+W1x7IFEyi7PC0DBmggJ8ZyLGRY4ZaWzEsdvxMV22uDC4JPZnvNx2T0oDr
 F5zkESGYgr2RS9DO/gVS90glVqFGj+Rm3Kgx5pYiW/EfjfmQxUiCOdZ6im26f3N9RgYj
 737j+Lctt05uGpnpMS3N6EIap8re+bzoh6B4PqK/l+ayG1n3aSyDhyGtP5X5cLl8tVgS 2A== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx0p1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 02:33:28 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 02:33:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 02:33:26 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.134])
        by maili.marvell.com (Postfix) with ESMTP id 745553F70A4;
        Mon, 17 Jul 2023 02:33:20 -0700 (PDT)
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
Subject: [net-next Patch v3 0/4] octeontx2-pf: support Round Robin scheduling
Date:   Mon, 17 Jul 2023 15:03:15 +0530
Message-ID: <20230717093319.26618-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: MULHA1Yrpye_ZfrE7_tJhdx5wjurB7E2
X-Proofpoint-ORIG-GUID: MULHA1Yrpye_ZfrE7_tJhdx5wjurB7E2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_07,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
v3 * update QOS documentation for round robin scheduling
     added out of bound checks for quantum parameter

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
