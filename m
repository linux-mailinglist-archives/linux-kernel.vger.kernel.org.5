Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1B803641
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjLDOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjLDOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:20:08 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7083;
        Mon,  4 Dec 2023 06:20:13 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4CxqrN022063;
        Mon, 4 Dec 2023 06:20:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=5gwLQo8YB8K198lIdN110Kpr4qLxBNopymD5p73eots=;
 b=JjOmfs1JCf82Gxedjqx7OSjVZmpD5NOJXX624N4pJ+qHEXYTJ5k7nmru6KDsTH16Jl2P
 JrYDZxhql93F+NI49HrMvVaE3g75uxuGRLdgdKz0rEMGxKQaJ/2LHMf8nlxSfn36aMWP
 u0m00l8lHUxn4EpXGrgIzVTZ5ecGnL7Na33+Wx+gTh49uMZSeCdAtJsP53NBNxh9UMaQ
 P85XoxK4a42v6CqhOvUAYeoc6RrsXNZ9WY5tGGY8lw4OhRsI6bnjDC9r1sevcdmyjGFo
 cM+Y28w1D4r4Fl+hUEUumcOwMmrLbnkn2L1h1lKSAKXVCu9K7WkYW5DMKJaM798VY/5/ Dw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ur2tvde98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 06:20:05 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Dec
 2023 06:20:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Dec 2023 06:20:04 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 9F5353F7099;
        Mon,  4 Dec 2023 06:19:59 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <horms@kernel.org>,
        <wojciech.drewek@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v6 0/2] octeontx2: Multicast/mirror offload changes
Date:   Mon, 4 Dec 2023 19:49:54 +0530
Message-ID: <20231204141956.3956942-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aY_OdZD_WKs-U2tf7-v6kjnSCdzcQhFE
X-Proofpoint-GUID: aY_OdZD_WKs-U2tf7-v6kjnSCdzcQhFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v6 changes:
- Rebased on TOT.

v5 changes:
- Updated patch#1.
  Using hlist_for_each_entry_safe() in function nix_add_mce_list_entry()
  for node deletion.
 
v4 changes:
- Updated pacth#1 based on comments from Paolo. The major change is to
  simplify mutex_lock/unlock logic in function
  rvu_mbox_handler_nix_mcast_grp_update(),
  rvu_mbox_handler_nix_mcast_grp_destroy() and
  rvu_nix_mcast_flr_free_entries().
  Added one extra variable in the mailbox to indicate if the
  update/delete request is from AF or not. If AF is requesting for
  update/delete then the caller is taking the lock.

v3 changes:
- Updated patch#1 based on comments from Wojciech and Simon.
  The comments were mostly based on some missed mutex_unlock and
  code reorganization.

v2 changes:
- Updated small nits based on review comments from Wojciech Drewek
  in file drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  72 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  39 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 702 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  14 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  73 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 113 ++-
 7 files changed, 978 insertions(+), 41 deletions(-)

-- 
2.25.1

