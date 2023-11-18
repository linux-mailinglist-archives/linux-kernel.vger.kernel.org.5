Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8C57F01C7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjKRSCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjKRSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:02:14 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA654AA;
        Sat, 18 Nov 2023 10:02:11 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIGuJMH014810;
        Sat, 18 Nov 2023 10:02:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=dKN19wkb46mkD2XSUwkxk9xIf6hug6L7lAARtdyK0ig=;
 b=gTIzLPnUP0xuDqTTLhSXE1LwDVtgY6yMoA2rhdUbvTBHurKTTTcRH2r4RESzGSQcFr8T
 JSFpVo94mca3FvDj7gXLrl7TLLWHuepEMvqkCpDdC7W+C3lkz98HZIiJLwetFQexFh9G
 iB6mQv+hHLmSfAZV26QAXyOwc4KMaNUK50xRtDl7TZpKTMSL04gUT0ixf/XVtYCvkirW
 dAwT4gzjThIZy3SUS2IhGt3s6ZGPV/f6Kg88tdsB31XfSf1YAdKYkDLPQbhUgefi9wtR
 Caxz8umU/eMhaRjiFOwb9tEIY1gtI5HDLulM+R6CyUyPNNtbbRHNNR0Fz62yorn6/rSV Hw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ueugurmp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 10:02:05 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 18 Nov
 2023 10:02:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 18 Nov 2023 10:02:04 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 6A27C3F7057;
        Sat, 18 Nov 2023 10:02:00 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v2 0/2] octeontx2: Multicast/mirror offload changes
Date:   Sat, 18 Nov 2023 23:31:55 +0530
Message-ID: <20231118180157.3593084-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: yCGmT-gOBYzT0Zt-MAchlX6_fC_vnUe6
X-Proofpoint-ORIG-GUID: yCGmT-gOBYzT0Zt-MAchlX6_fC_vnUe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_14,2023-11-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes changes to support TC multicast/mirror offload.

Patch #1: Adds changes to support new mailbox to offload multicast/mirror
offload.

Patch #2: Adds TC related changes which uses the newly added mailboxes to
offload multicast/mirror rules.

Suman Ghosh (2):
  octeontx2-af: Add new mbox to support multicast/mirror offload
  octeontx2-pf: TC flower offload support for mirror

v2 changes:
- Updated small nits based on review comments from Wojciech Drewek
  in file drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  64 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  39 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 686 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  14 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  66 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 113 ++-
 7 files changed, 949 insertions(+), 39 deletions(-)

-- 
2.25.1

