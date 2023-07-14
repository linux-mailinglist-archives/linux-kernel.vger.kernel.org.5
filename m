Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494D7532AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjGNHMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjGNHLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:11:55 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E726BC;
        Fri, 14 Jul 2023 00:11:55 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DLUPrC029957;
        Fri, 14 Jul 2023 00:11:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=eietfSoD+b0bITyQQrSikcmT4WSlhR+3d6lnEZaIHBY=;
 b=Rd7nUPpAJO2cWjA5W9odrf8Hcokdoa/kDIGYLI55n/zauL5fi6JpdPm3OZvt+LcIXnXu
 btrPaV2+ycJ0ieUg4K44fJbxjUBPTlOGrTI2q+9J/INdfI+JabhuxodyByHpKuFvNFjk
 YYFa944KZ0xgAqdDIQLmiEMY2OJNddT3B35s0WDvYgYb5sPfFj4RX1Z3FYDuejD2SNu6
 BzMjPJO8OO4iz7l84vbUMR3KKXmsiqoEHni5+T6v0UP/EZ/PTcpynHFfhAjJGk0MYX7O
 z7qS/bRHzY1K6EEQjBjcAFNE34sp+GuKpU3r/y4OtE9KDk3zmzG9mcZW5wjviMP4rEQN gw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rtptx9sve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 00:11:48 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 14 Jul
 2023 00:11:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 14 Jul 2023 00:11:46 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id A4BFE3F7065;
        Fri, 14 Jul 2023 00:11:43 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 0/3] octeontx2-af: Fix issues with NPC field hash extract
Date:   Fri, 14 Jul 2023 12:41:38 +0530
Message-ID: <20230714071141.2428144-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4rv3Y67UkmmIcKvFN0XlQ8tZiE1O6kZ8
X-Proofpoint-ORIG-GUID: 4rv3Y67UkmmIcKvFN0XlQ8tZiE1O6kZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_04,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the issues with NPC field hash extract. This feature is
supported only for CN10KB variant of CN10K series of silicons. This features
helps to hash reduce 128 bit IPv6 source/destination address to 32 bit(also
configurable) which can save 96 bit and can be used to store other key information
during packet filtering.

Patch #1 Fix hash extraction mbox message

Patch #2 Fix hash extraction enable configuration

Patch #3 Fix hash configuration for both source and destination IPv6

Suman Ghosh (3):
  octeontx2-af: Fix hash extraction mbox message
  octeontx2-af: Fix hash extraction enable configuration
  octeontx2-af: Fix hash configuration for both source and destination
    IPv6

---
v2 changes:
	Fixed review comment from Jakub Kicinski
	1. Updated detailed commit messages
	2. Updated cover letter.

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  16 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  22 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.h         |   4 +
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 160 ++++++++++++------
 .../marvell/octeontx2/af/rvu_npc_hash.h       |  21 ++-
 5 files changed, 150 insertions(+), 73 deletions(-)

-- 
2.25.1

