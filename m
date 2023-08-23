Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC4784EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjHWCyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjHWCyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:54:07 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1201A5;
        Tue, 22 Aug 2023 19:54:05 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MI5m7M027509;
        Tue, 22 Aug 2023 19:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=SYit5M8LMLasjmEi/Xn9GaH/ScQROSPBnBHY1wbIy4E=;
 b=SYAfWTDL0LOosPUnfMq4g2CWa65VccV/VflxG28AndaVh0UMLnopYz25pEARZeK9QROi
 HHSHzHTVlLJcv2jImTadItfVHPfV9E6MMHPAGDIEkzxQajRSx5/86m1cTQserxCVPI7c
 ftsMDwhsNXaiz0NJeSd77iaqME02lEIhhz/3jVFNaQmqT/ZLfU2awiwXDTcW5p2RMfc/
 PLtmqp6lS/OuIoHsn9ZDa6W+1Xusa1ixc1afSQCxRLCl/kVq9JmTYqoTOwUgZVtVbkzS
 rG5xrOcZvDm/Rx4jyVbw6XwA3goChRIE3Qz04tcG58kXLlmoVWHWi9F3ZEJ+omad3bw4 wA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sn20b1ccr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 19:53:35 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 22 Aug
 2023 19:53:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 22 Aug 2023 19:53:33 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 70A183F7087;
        Tue, 22 Aug 2023 19:53:28 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <rkannoth@marvell.com>, <hawk@kernel.org>,
        <alexander.duyck@gmail.com>, <ilias.apalodimas@linaro.org>,
        <linyunsheng@huawei.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v2 net] octeontx2-pf: fix page_pool creation fail for rings > 32k
Date:   Wed, 23 Aug 2023 08:23:25 +0530
Message-ID: <20230823025325.2499289-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jpdeneK5LLVMBytHKUFOulOm0RDZfxu6
X-Proofpoint-GUID: jpdeneK5LLVMBytHKUFOulOm0RDZfxu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_22,2023-08-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

octeontx2 driver calls page_pool_create() during driver probe()
and fails if queue size > 32k. Page pool infra uses these buffers
as shock absorbers for burst traffic. These pages are pinned down
over time as working sets varies, due to the recycling nature
of page pool, given page pool (currently) don't have a shrinker
mechanism, the pages remain pinned down in ptr_ring.
Instead of clamping page_pool size to 32k at
most, limit it even more to 2k to avoid wasting memory.

This have been tested on octeontx2 CN10KA hardware.
TCP and UDP tests using iperf shows no performance regressions.

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---

ChangeLogs:

v1->v2: Commit message changes and typo fixes
v0->v1: Commit message changes.
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 77c8f650f7ac..3e1c70c74622 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1432,7 +1432,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 	}
 
 	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
-	pp_params.pool_size = numptrs;
+	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
 	pp_params.nid = NUMA_NO_NODE;
 	pp_params.dev = pfvf->dev;
 	pp_params.dma_dir = DMA_FROM_DEVICE;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index ba8091131ec0..f6fea43617ff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -30,6 +30,8 @@
 #include <rvu_trace.h>
 #include "qos.h"
 
+#define OTX2_PAGE_POOL_SZ 2048
+
 /* IPv4 flag more fragment bit */
 #define IPV4_FLAG_MORE				0x20
 
-- 
2.25.1

