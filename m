Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71691755104
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGPTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGPTb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:31:28 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC221BDA;
        Sun, 16 Jul 2023 12:31:03 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36GJ8sn0029396;
        Sun, 16 Jul 2023 12:30:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=sXrdHEP2Edpi4r2g2FtegCGau1iQ9Rt5hxbcPaUQ4d4=;
 b=ZPqHm7qdKbw5TEEaOMYUCFNdNkqvr+D6DSG/7/DJmdC0XSwFD8s6eALwL/nM82JNvYQ7
 Llf8/z6HPQGho+Y0Am5cGkWujtgsOda0nzG3hJI2SGxUCZWbogygB1HwAXeD+kWB9Hhq
 BgAmg8jG9fYFSKZ0BkH1fgB/mIysnb53Yncn1BP2S9chTYurLLJUbQdSOtt5U9veJn2H
 17SW226cAp27ehlHgvcGwzvvQLKJiB6WFPAriYs2fwdAOe5N8eYL/rHpc3Ss3z8QoJWf
 AANEaNmNnMpCPPxwSL2gtWl3cyxW5nG/xXMqAz/sITqnMRVJf3k8ZNvu2NisAlpMqr9u tA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rus6dawq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 12:30:56 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 16 Jul
 2023 12:30:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 16 Jul 2023 12:30:55 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 4FF055E6869;
        Sun, 16 Jul 2023 12:30:52 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V3 0/2] octeontx2-af: Fix issues with NPC field hash
Date:   Mon, 17 Jul 2023 01:00:47 +0530
Message-ID: <20230716193049.2499410-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XF_ypHtaIZMY5krMOirG8Por7e0S73Cl
X-Proofpoint-ORIG-GUID: XF_ypHtaIZMY5krMOirG8Por7e0S73Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-16_06,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the issues with NPC field hash extract. This feature is
supported only for CN10KB variant of CN10K series of silicons. This features
helps to hash reduce 128 bit IPv6 source/destination address to 32 bit(also)
configurable) which can save 96 bit and can be used to store other key
information during packet filtering.

Patch #1 Fix hash extraction mbox message

Patch #2 Fix hash extraction enable configuration

Suman Ghosh (2):
  octeontx2-af: Fix hash extraction mbox message
  octeontx2-af: Fix hash extraction enable configuration

---
v3 changes:
	1. Rebased the patchset on top of 'main' branch
	2. Removed patch #3 as it is already merged in the 'main' branch

v2 changes:
	Fixed review comment from Jakub Kicinski
	1. Updated detailed commit messages
	2. Updated cover letter.

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  6 +-
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 70 +++++++++++++++----
 .../marvell/octeontx2/af/rvu_npc_hash.h       | 17 +++--
 3 files changed, 69 insertions(+), 24 deletions(-)

-- 
2.25.1

