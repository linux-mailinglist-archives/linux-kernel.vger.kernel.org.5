Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC3782321
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjHUFZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHUFZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:25:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98ABA3;
        Sun, 20 Aug 2023 22:25:43 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KLmv1t002614;
        Sun, 20 Aug 2023 22:25:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=lqQinl0zasEpGN80WFsNbE2rMOp3JQR78UH6v0Fh6xo=;
 b=Vy5TJkZYwhnGdlus0eICzVC7O+QptEQR2mTuuv35cxdO7gw/a17o3gMqLHae5yE+tB7B
 H8XD29uLCiB9cHcu2tdKdOkwoln6WwGwVlkVrKOqOypWotmzPdxGAf6QcPXfwCaFBegT
 VchQoY+9DuUb0Bnyp4dkVPUiFcKs+KaUPQPghV3CjXS5iFq3tCNZyHAj+jdq9hgm3CPC
 tXJIixP1bKysZ/o6G63Pgh0+k6Ns/VFFUXtkLnlmmtdV2nJpbtT2Y6I4q5RXi4fFIMiZ
 txunqTjOujqZkpvs2cUzlii6N/AGvmCUS/eSL7E8AHe1HgcG1NUv/CWpopZwBCphRlGv EA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sju3qksa7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 20 Aug 2023 22:25:31 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 20 Aug
 2023 22:25:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 20 Aug 2023 22:25:23 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 02B4E3F7081;
        Sun, 20 Aug 2023 22:25:18 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V3 0/3] Fix PFC related issues
Date:   Mon, 21 Aug 2023 10:55:13 +0530
Message-ID: <20230821052516.398572-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GLWv27Ny2guya2igx5IPumq442831Q2p
X-Proofpoint-ORIG-GUID: GLWv27Ny2guya2igx5IPumq442831Q2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-20_15,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes multiple PFC related issues related to Octeon.

Patch #1: octeontx2-pf: Fix PFC TX scheduler free

Patch #2: octeontx2-af: CN10KB: fix PFC configuration

Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC priorities to
work simultaneously

Hariprasad Kelam (1):
  octeontx2-af: CN10KB: fix PFC configuration

Suman Ghosh (2):
  octeontx2-pf: Fix PFC TX scheduler free
  cteonxt2-pf: Fix backpressure config for multiple PFC priorities to
    work simultaneously

---
v3 changes:
	Removed patch #1 from v2 patchset due to review comment from Jakub.
	I will find a more accurate fix for that and will push a separate
	patch.

v2 changes:
	1. Fixed compilation error in patch #2
	ERROR: modpost: "otx2_txschq_free_one"
	[drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicvf.ko] undefined!
	2. Added new patch #4 to the patch set. This patch fixes another PFC
	related issue.

 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 17 +++++++++--------
 .../marvell/octeontx2/nic/otx2_common.c       |  1 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        | 19 ++++++-------------
 3 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.25.1

