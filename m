Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9F7FE7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbjK3Dn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjK3Dnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:43:55 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157E94;
        Wed, 29 Nov 2023 19:44:01 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATK7bZu029400;
        Wed, 29 Nov 2023 19:43:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=inxqyvdYf3W75pCDOM/qVFjtRdwHhTfPRytUqpumgnQ=;
 b=A/D+DrO0ue7zuZKrDQ4+9NKGyNMoLKHe2cLsdDH28dBfEzStAF3UDj7nWtakfs4eN7UW
 91CoFwwyvAbmL0/LQEhYXPpsvCD5imNsACSo3euCuwN7eC0+i1qzlS7qIT4HdLXKWepx
 UTVmjKGVifOzvQhlY9CQjBxDI1oWHoJDYItCqoi345D919Y149iFb9fJfVYeZMNyHSAz
 mkxGY1YgqICTb+XMOQR7sLbj3zFX++Ua19CCI9cMLRRhfBLLCZMo2kkVMhyBfHB4hgOY
 hKrVfAaLUaoqfc/Scj/+fdGr21rzp6RKkVzIWuiiKy+NLMMFaNZCdTQ8CcJkKNpNo4Hz fQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3upc1v1grv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 19:43:33 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 19:43:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 29 Nov 2023 19:43:31 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 9B0873F7043;
        Wed, 29 Nov 2023 19:43:27 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <horms@kernel.org>,
        <wojciech.drewek@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v5 0/2] octeontx2: Multicast/mirror offload changes
Date:   Thu, 30 Nov 2023 09:13:22 +0530
Message-ID: <20231130034324.3900445-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hmsD4zZkLd4t7Dc5zeKoeTaDO7Sfl13E
X-Proofpoint-ORIG-GUID: hmsD4zZkLd4t7Dc5zeKoeTaDO7Sfl13E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
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

