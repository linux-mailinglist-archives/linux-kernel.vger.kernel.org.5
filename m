Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3857B10FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjI1Cxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjI1Cxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:53:34 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C9B13A;
        Wed, 27 Sep 2023 19:53:33 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RK0P9J019297;
        Wed, 27 Sep 2023 19:52:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=+/OkfC5lqv0bLlYWc53KteeUHo0RD5aQCVAd8eijLR0=;
 b=JFGBSq0Kmtxbqsb/tUikNt6XhVRn13ls3awEU0PNvj94OAx+8U0utuT3s6ImS6MZAhQE
 yHqypv4dxcsRxLpawUbA8aXFdx5jrl8JMGZUZ5Y/AZi4OgpurZFDzMffU063aiwLB1iM
 /QtavJLSxz+BncX5VtEeCLL6hljIQo7k4AHeZ6e5Jk3T2cmfmSir0mPAW/PdDwRq/oRT
 v6+9SgG9GRfQNfM7bXbWZcYj4yCWHJu+AGhMM2LmqgBkHL4BtG0/oASUPRji8763NxVU
 CwXKqjXqIJpWarJas/Pk/JmiGVG4J/7Vb2yZWI6iqAXKVczgH4JQ/TAk44PiVVxZrS1h Xw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tcu1qs7mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 19:52:48 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 27 Sep
 2023 19:52:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 27 Sep 2023 19:52:47 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 858C33F703F;
        Wed, 27 Sep 2023 19:52:41 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <rkannoth@marvell.com>, <hawk@kernel.org>,
        <alexander.duyck@gmail.com>, <ilias.apalodimas@linaro.org>,
        <linyunsheng@huawei.com>, <bigeasy@linutronix.de>
Subject: [PATCH net] octeontx2-pf: Fix page pool frag allocation failure.
Date:   Thu, 28 Sep 2023 08:22:36 +0530
Message-ID: <20230928025236.3051774-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ghpz7UGbsI-ltTwm7vY0sg7-qgatM1Bh
X-Proofpoint-ORIG-GUID: Ghpz7UGbsI-ltTwm7vY0sg7-qgatM1Bh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since page pool param's "order" is set to 0, will result
in below crash if interface is configured higher rx buffer
length.

Steps to reproduce the issue.
1. devlink dev param set pci/0002:04:00.0 name receive_buffer_size \
   value 8196 cmode runtime
2. ifconfig eth0 up

[   19.901356] ------------[ cut here ]------------
[   19.901361] WARNING: CPU: 11 PID: 12331 at net/core/page_pool.c:567 page_pool_alloc_frag+0x3c/0x230
[   19.901449] pstate: 82401009 (Nzcv daif +PAN -UAO +TCO -DIT +SSBS BTYPE=--)
[   19.901451] pc : page_pool_alloc_frag+0x3c/0x230
[   19.901453] lr : __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
[   19.901460] sp : ffff80000f66b970
[   19.901461] x29: ffff80000f66b970 x28: 0000000000000000 x27: 0000000000000000
[   19.901464] x26: ffff800000d15b68 x25: ffff000195b5c080 x24: ffff0002a5a32dc0
[   19.901467] x23: ffff0001063c0878 x22: 0000000000000100 x21: 0000000000000000
[   19.901469] x20: 0000000000000000 x19: ffff00016f781000 x18: 0000000000000000
[   19.901472] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   19.901474] x14: 0000000000000000 x13: ffff0005ffdc9c80 x12: 0000000000000000
[   19.901477] x11: ffff800009119a38 x10: 4c6ef2e3ba300519 x9 : ffff800000d13844
[   19.901479] x8 : ffff0002a5a33cc8 x7 : 0000000000000030 x6 : 0000000000000030
[   19.901482] x5 : 0000000000000005 x4 : 0000000000000000 x3 : 0000000000000a20
[   19.901484] x2 : 0000000000001080 x1 : ffff80000f66b9d4 x0 : 0000000000001000
[   19.901487] Call trace:
[   19.901488]  page_pool_alloc_frag+0x3c/0x230
[   19.901490]  __otx2_alloc_rbuf+0x60/0xbc [rvu_nicpf]
[   19.901494]  otx2_rq_aura_pool_init+0x1c4/0x240 [rvu_nicpf]
[   19.901498]  otx2_open+0x228/0xa70 [rvu_nicpf]
[   19.901501]  otx2vf_open+0x20/0xd0 [rvu_nicvf]
[   19.901504]  __dev_open+0x114/0x1d0
[   19.901507]  __dev_change_flags+0x194/0x210
[   19.901510]  dev_change_flags+0x2c/0x70
[   19.901512]  devinet_ioctl+0x3a4/0x6c4
[   19.901515]  inet_ioctl+0x228/0x240
[   19.901518]  sock_ioctl+0x2ac/0x480
[   19.901522]  __arm64_sys_ioctl+0x564/0xe50
[   19.901525]  invoke_syscall.constprop.0+0x58/0xf0
[   19.901529]  do_el0_svc+0x58/0x150
[   19.901531]  el0_svc+0x30/0x140
[   19.901533]  el0t_64_sync_handler+0xe8/0x114
[   19.901535]  el0t_64_sync+0x1a0/0x1a4
[   19.901537] ---[ end trace 678c0bf660ad8116 ]---

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 997fedac3a98..78a4547e7001 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1357,7 +1357,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 	struct page_pool_params pp_params = { 0 };
 	struct npa_aq_enq_req *aq;
 	struct otx2_pool *pool;
-	int err;
+	int err, sz;
 
 	pool = &pfvf->qset.pool[pool_id];
 	/* Alloc memory for stack which is used to store buffer pointers */
@@ -1403,6 +1403,8 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		return 0;
 	}
 
+	sz = ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN), PAGE_SIZE);
+	pp_params.order = (sz / PAGE_SIZE) - 1;
 	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
 	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
 	pp_params.nid = NUMA_NO_NODE;
-- 
2.25.1

