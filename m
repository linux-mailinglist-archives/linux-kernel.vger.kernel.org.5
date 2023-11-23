Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684127F57EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjKWF7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKWF7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:59:47 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC19A;
        Wed, 22 Nov 2023 21:59:53 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN4eG69026183;
        Wed, 22 Nov 2023 21:59:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=aMFl7YXQASQiBYYUfVFQ3EO4pzKa83K0Ci5mYa9/26o=;
 b=jCknOz1FaaSpHB7htgQQTOWo3kN1oJZc9icrS/FLEzPAOA8O1om1ek0WD+uHgqTCnewe
 +A8RGxuxx6+3an6V36rgWweHRuwF1V6ZG1rwv3poDcNoZ7myJM+kowqWQZQ5eAnwEpYw
 LhOVr9Phm88C94jt4Wdq4H1TAMyrlKs1wEPmo6b5HV60KkYT2y2lMcTbd1HDhSGXUFu2
 ckrLkpII3gKbgIr4M9vMciVn6ECYrQ9OjKjw7S9OYTnZh3VYGJ1bjYg2Xfkua/oiG+1O
 NbnUzZSesw8mokpb0S2fDbJrkuRksxTgHLYBFk4uENHDCC65iY9TfCiHW0p8zP25/PqD pw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uh1jbetbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 21:59:47 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 21:59:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 21:59:45 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 116C43F7067;
        Wed, 22 Nov 2023 21:59:42 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH 0/5] octeontx2-af: miscellaneous fixes
Date:   Thu, 23 Nov 2023 11:29:36 +0530
Message-ID: <20231123055941.19430-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rkhi8wm_fyhY_67aFokK3OOqL9WkQjQ1
X-Proofpoint-GUID: Rkhi8wm_fyhY_67aFokK3OOqL9WkQjQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series of patches fixes various issues related to mcs
and NIX link registers.

Geetha sowjanya (4):
  octeontx2-af: Fix mcs sa cam entries size
  octeontx2-af: Fix mcs stats register address
  octeontx2-af: Add missing mcs flr handler call
  octeontx2-af: Update Tx link register range

Nithin Dabilpuram (1):
  octeontx2-af: Adjust Tx credits when MCS external bypass is disabled

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 +-
 .../net/ethernet/marvell/octeontx2/af/mcs.c   | 16 ++++++++--
 .../net/ethernet/marvell/octeontx2/af/mcs.h   |  2 ++
 .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  3 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  8 +++++
 .../ethernet/marvell/octeontx2/af/rvu_reg.c   |  4 +--
 8 files changed, 58 insertions(+), 9 deletions(-)

-- 
2.25.1

