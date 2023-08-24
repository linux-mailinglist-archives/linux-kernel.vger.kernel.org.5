Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96057865AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbjHXDDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbjHXDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:03:41 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE110DE;
        Wed, 23 Aug 2023 20:03:39 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NJotTH006552;
        Wed, 23 Aug 2023 20:03:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=rdI7+32VFalWfBCSBWgYPHJV3iAwoybCfqDIXqxMYl8=;
 b=PHnFrFs0dULr1/CK5X4FLcp7Qz4qBigaD8PWR7O9uB77Dcl5Ibi8ED8pABVjilZ9I0eN
 uPl2+fhkETPB6FfcZJflGJcNCEDUKVPwWQIgX2wL7M9aDj0LiejcU+/PxnNbnIcKcVpv
 mRpfhbrBE5BRD7gstww0nY2jvL/AyMzHS3I6XlrJccsf20Ga2KLGV1SM1r/nq7azRfJV
 3wj3fcM+9d7PVgWjyBMuMZnVMca6ipiQSpcgD5BK8JdYVbzkgWTr59OidYWppNR73poY
 IkmF8I23q1A1RyVk7Q0Gqzf/SX9Y+Mm+W7+ypInYDvxOfd0Ucp6gpGLnwD5Ab2CZFvyW Yw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3snrmcs3b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 20:03:09 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 23 Aug
 2023 20:03:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 23 Aug 2023 20:03:08 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 535D33F70A7;
        Wed, 23 Aug 2023 20:03:03 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <rkannoth@marvell.com>, <hawk@kernel.org>,
        <alexander.duyck@gmail.com>, <ilias.apalodimas@linaro.org>,
        <linyunsheng@huawei.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v3 net] octeontx2-pf: fix page_pool creation fail for rings > 32k
Date:   Thu, 24 Aug 2023 08:33:01 +0530
Message-ID: <20230824030301.2525375-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IxbCkk7PbFkuzhcY9aYmeoZZxzELmrg5
X-Proofpoint-ORIG-GUID: IxbCkk7PbFkuzhcY9aYmeoZZxzELmrg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_17,2023-08-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

v2->v3: Fix macro aligment and header file changes suggested by
	Alexander Lobakin
v1->v2: Commit message changes and typo fixes
v0->v1: Commit message changes.
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h   | 2 ++
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index b5d689eeff80..9e3bfbe5c480 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -23,6 +23,8 @@
 #define	OTX2_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN)
 #define	OTX2_MIN_MTU		60
 
+#define OTX2_PAGE_POOL_SZ	2048
+
 #define OTX2_MAX_GSO_SEGS	255
 #define OTX2_MAX_FRAGS_IN_SQE	9
 
-- 
2.25.1

