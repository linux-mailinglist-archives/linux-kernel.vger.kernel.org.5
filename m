Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2675B76B8B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjHAPhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjHAPhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:37:22 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B53D127;
        Tue,  1 Aug 2023 08:37:22 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371ALfDB015199;
        Tue, 1 Aug 2023 08:37:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=cqAPruR9AXIy5jeqwqM+BrH/EWlrkCrE0xEETDOKkf0=;
 b=Jj/bku14sxBGLbmX2Zs+AXtHEBJIDrLG/qvBl0+8FzfajrJbWHgq70MNN1g9jgnihnsT
 cnFZno5A061DgwsgBCJFEueNU4Eu5Oczq1/Dz71PYTgzdk4jMuTeM0wLdsqofendVED8
 5F+MUSDkz7lWSEQDQ30neCN2zElj38dx8ROE1LXfB/AgomR6jghhO4edTeOtiubZ+k5t
 uddUhTSCjfovWlSrW3xjQ40c7lGwxsHn6jXz6QrOcua+yZ9+NUCU5x9mdbEtpZeM3Qkx
 7yrjCzj5gGRoCrVULVxHLaa3dZTuZ7/YLSwkDxGhtfg1TSGZW+sYs/0yZ3OZIY77TPAF SQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3s707dh61y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 08:37:06 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 1 Aug
 2023 08:37:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 1 Aug 2023 08:37:05 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 8A9D43F7040;
        Tue,  1 Aug 2023 08:37:00 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <simon.horman@corigine.com>, <jesse.brandeburg@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH V4 0/2] octeontx2-af: TC flower offload changes
Date:   Tue, 1 Aug 2023 21:06:55 +0530
Message-ID: <20230801153657.2875497-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Z2omsYqom08_SMWcJ198KAElOZGJaoOZ
X-Proofpoint-ORIG-GUID: Z2omsYqom08_SMWcJ198KAElOZGJaoOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_12,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes minor code restructuring related to TC
flower offload for outer vlan and adding support for TC inner
vlan offload.

Patch #1 Code restructure to handle TC flower outer vlan offload

Patch #2 Add TC flower offload support for inner vlan

Suman Ghosh (2):
  octeontx2-af: Code restructure to handle TC outer VLAN offload
  octeontx2-af: TC flower offload support for inner VLAN

v4 changes:
	Resolved conflicts with 'main' branch

v3 changes:
	1. Fixed warning in file
	drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
	2. Updated commit description for patch #2

v2 changes:
	1. Fixed checkpatch errors in file
	drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
	2. Updated cover letter subject

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   3 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |   5 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  13 +++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 105 +++++++++++-------
 5 files changed, 89 insertions(+), 38 deletions(-)

-- 
2.25.1

