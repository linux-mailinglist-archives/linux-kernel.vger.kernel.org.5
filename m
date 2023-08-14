Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1727277B9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjHNNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjHNNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:24:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C610DE;
        Mon, 14 Aug 2023 06:24:30 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E7jtWM011717;
        Mon, 14 Aug 2023 06:24:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=YZW+dvZ1Lhf7BRrKdO8vKEChqy7wy8tf6yOMDi5xdL8=;
 b=N8HEHeXM9OcX7BCXQiiRqxOwYmN/nYOwbraL4bR4UDvOnp91hQ/G096cF7PjQ5MlWwu4
 J/alo9EB7xlYRfUs9yZqS5H3ueNJR4Mtk3f1dnQgXmKIPMKSeapQbc7I9/LDCwtAahxu
 AfdypSejObePVTGXQPI7c9C1WMgYXip92O59ku5TxcWQdOrCNZkev+4g3tb1XAm/pxAL
 bC5w0XE+G2b+xI+VcHTTLfm0FoFk/HXWasxek09MCUEIpZnaz7968PCOFN1zJD18IrFK
 rKRI1mJHk2wI6faql40NX0nLEM/JXIYgXtqREIAWo80M09Sihmsx0dVDSWgAF5QiLgpC XQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sfg1prynh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 06:24:21 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 06:24:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 14 Aug 2023 06:24:19 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id EE3803F707F;
        Mon, 14 Aug 2023 06:24:13 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <pabeni@redhat.cm>, <edumazet@google.com>,
        <aleksander.lobakin@intel.com>, <hawk@kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        "Ratheesh Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v1 net] octeontx2-pf: fix page_pool creation fail for rings > 32k
Date:   Mon, 14 Aug 2023 18:54:11 +0530
Message-ID: <20230814132411.2475687-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JyXuWbqhkBHA8g1RjUrzuYtfawwHtqSA
X-Proofpoint-GUID: JyXuWbqhkBHA8g1RjUrzuYtfawwHtqSA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_09,2023-08-10_01,2023-05-22_02
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
as shock absorbers for burst traffic. These pages are pinned
down as soon as page pool is created. As page pool does direct
recycling way more aggressivelyi, often times ptr_ring is left
unused at all. Instead of clamping page_pool size to 32k at
most, limit it even more to 2k to avoid wasting memory on much
less used ptr_ring.

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

ChangeLogs:

v0->v1: Commit message changes.
---
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 77c8f650f7ac..fc8a1220eb39 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1432,7 +1432,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 	}
 
 	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
-	pp_params.pool_size = numptrs;
+	pp_params.pool_size = OTX2_PAGE_POOL_SZ;
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

