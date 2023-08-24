Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88945786A08
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjHXI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbjHXI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:28:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E196A1709;
        Thu, 24 Aug 2023 01:28:21 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NJp2KM006892;
        Thu, 24 Aug 2023 01:10:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=kaRq8uKZd7yfUZZ9uSEnc5pa8mwuX9nh/NFBHsK6hLI=;
 b=TRtT5AgUAYNoiybTLOxnUYdtkHdC7C/rvYfC4KiOXJQm2KECZqofzndys80+fiPl8YgV
 jq/i2AH0fkLdNvV9bP/28bw/0VkWx6+YTZ0HUinO9i1aoTkd8YMEw06zz35AesJz+ROi
 9lgqtGXeJNNLHKmEbLZt6b7oiPqyl/Pe/7BFqrYOmHXxBpF+dfzP+mYD0Mow5QAdx+TK
 Dsb8EZy0rONJvFoJqusuR+cbItUiP5TZFOoN8wdbi1//2Az8GrRUm/m9sxvWNpbfzkK2
 qHKM27moPpUcjz4aWu21W5hWysAnzDLK6ZglKv2lfSFC/8g40wV0E4/gVhyeSEPzYN3K TA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3snrmcsv87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 01:10:41 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 24 Aug
 2023 01:10:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 24 Aug 2023 01:10:39 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 0AB223F70A1;
        Thu, 24 Aug 2023 01:10:34 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V4 0/3] Fix PFC related issues
Date:   Thu, 24 Aug 2023 13:40:29 +0530
Message-ID: <20230824081032.436432-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VIQMUYkBWa0_oQ_0664BcH9FYO9oaIYU
X-Proofpoint-ORIG-GUID: VIQMUYkBWa0_oQ_0664BcH9FYO9oaIYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_05,2023-08-22_01,2023-05-22_02
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

Patch #3: octeonxt2-pf: Fix backpressure config for multiple PFC
priorities to work simultaneously

Hariprasad Kelam (1):
  octeontx2-af: CN10KB: fix PFC configuration

Suman Ghosh (2):
  octeontx2-pf: Fix PFC TX scheduler free
  cteonxt2-pf: Fix backpressure config for multiple PFC priorities to
    work simultaneously

---
v4 changes:
	Added detailed commit description for patch #2

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

