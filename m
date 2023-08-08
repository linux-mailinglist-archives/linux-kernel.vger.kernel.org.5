Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F95E774706
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjHHTIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjHHTIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:12 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308FD5499;
        Tue,  8 Aug 2023 09:30:14 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378A7xBg025591;
        Tue, 8 Aug 2023 04:27:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=yUuQs+1cimYfaSecOSS1NNBW9GTRLCPRzuAJhuYqaI4=;
 b=FHdzMLir97d1Y5F5tXmoEB0u54UWipRYKeW4m8r6UE8BIF7AYM/n5Y62DmFtZF1WQW0L
 On92kM5oLgpeAf76iH3O/Wpoede4R5pMEjYuT0cgegE5W/TKvZBID8JqdwmuupLq7M3/
 EIHL7/6zcsmq/2Mm+otX73t6ahkhvEXNiq0vU7EyvInsexoqTIdBUY7EdjU5KKtgWBsQ
 bTmkbNrKxhVd+6pFkJNo7ZyZkjbQ+E05mn+xZc8RFQkweED9kZ0JiRdycPmei9M3jJbY
 dQcsq7sX6Z0DUl2IqTGpHTnbki+IqlABr4+fpI4QrOZq9R+IpSWQEMcgtwSnvKtNZdm0 wg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntg7kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 04:27:17 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 8 Aug
 2023 04:27:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 8 Aug 2023 04:27:15 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 2363F3F703F;
        Tue,  8 Aug 2023 04:27:10 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH 0/3] Fix PFC related issues
Date:   Tue, 8 Aug 2023 16:57:05 +0530
Message-ID: <20230808112708.3179218-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: E9kyjF0bgSJ7rbYkqhIWk7x7Czl2Xcnh
X-Proofpoint-ORIG-GUID: E9kyjF0bgSJ7rbYkqhIWk7x7Czl2Xcnh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes multiple PFC related issues related to Octeon.

Patch #1: octeontx2-pf: Update PFC configuration

Patch #2: octeontx2-pf: Fix PFC TX scheduler free

Patch #3: octeontx2-af: CN10KB: fix PFC configuration

Hariprasad Kelam (1):
  octeontx2-af: CN10KB: fix PFC configuration

Suman Ghosh (2):
  octeontx2-pf: Update PFC configuration
  octeontx2-pf: Fix PFC TX scheduler free

 .../net/ethernet/marvell/octeontx2/af/rpm.c   | 17 ++++++------
 .../ethernet/marvell/octeontx2/af/rvu_reg.c   |  4 +--
 .../marvell/octeontx2/nic/otx2_dcbnl.c        | 27 ++++++-------------
 3 files changed, 19 insertions(+), 29 deletions(-)

-- 
2.25.1

