Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C257F2926
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjKUJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjKUJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:44:53 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9D5CB;
        Tue, 21 Nov 2023 01:44:49 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL9KGnO020553;
        Tue, 21 Nov 2023 01:43:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=kPqN676sq1fUBtMEaUsPP99wmvRcdfb2cTT+8LV3Sgs=;
 b=BDDwaxj2B0YQYYBcm904Cnsw5LHqEv7twuDM3ZIMAIRD3Si9ZBWAV3cOcc3HW7zSwSTp
 taZXrbYBkuqFzs5B6hIw8sk8ytpH3ai9YxfRrAqCmvxkX2ULob4GILS6W0EqwdtjaYd2
 tX8ogj9kVr19WHdp43m769XyTUUWhj1VebG0tapF2wiw4noCQkwkpGUyCThgI6IksD8o
 r8uXnzB2/wDpYyLoPlUZyvpzVEwQ4F76ZH/5/P/QiBhdGtlgCCXnoYns3GueX8ZBwPbo
 SrnIbhTs773fDQDLiPDa9m60YR6AgG6fQ73tnAcqwHsIvfoozkN+VB3zLxw17NbYkbu8 Eg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uewnw09wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 01:43:56 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 21 Nov
 2023 01:43:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 21 Nov 2023 01:43:53 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 8A91C3F7045;
        Tue, 21 Nov 2023 01:43:49 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <horms@kernel.org>,
        <wojciech.drewek@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v3 0/2] octeontx2: Multicast/mirror offload changes
Date:   Tue, 21 Nov 2023 15:13:44 +0530
Message-ID: <20231121094346.3621236-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QcAMpnshlzMMfXRp1Fdvo-Yz3TPXLPWc
X-Proofpoint-ORIG-GUID: QcAMpnshlzMMfXRp1Fdvo-Yz3TPXLPWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
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

v3 changes:
- Updated patch#1 based on comments from Wojciech and Simon. The comments were
  mostly based on some missed mutex_unlock and code reorganization.

v2 changes:
- Updated small nits based on review comments from Wojciech Drewek
  in file drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  64 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  39 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 699 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  14 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  73 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 113 ++-
 7 files changed, 967 insertions(+), 41 deletions(-)

-- 
2.25.1

