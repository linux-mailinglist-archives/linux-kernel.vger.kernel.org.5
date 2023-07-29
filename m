Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81306767F52
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjG2M4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjG2Mzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:55:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D513430EF;
        Sat, 29 Jul 2023 05:55:29 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RCktn4rnjzLnsw;
        Sat, 29 Jul 2023 20:52:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 20:55:27 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 5/7] crypto: hisilicon/qm - prevent soft lockup in qm_poll_req_cb()'s loop
Date:   Sat, 29 Jul 2023 20:52:37 +0800
Message-ID: <20230729125239.25337-6-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230729125239.25337-1-qianweili@huawei.com>
References: <20230729125239.25337-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function qm_poll_req_cb() may take a while due to complex req_cb,
so soft lockup may occur in kernel with preemption disabled.

The error logs:
watchdog: BUG: soft lockup - CPU#23 stuck for 23s! [kworker/u262:1:1407]
[ 1461.978428][   C23] Call trace:
[ 1461.981890][   C23]  complete+0x8c/0xf0
[ 1461.986031][   C23]  kcryptd_async_done+0x154/0x1f4 [dm_crypt]
[ 1461.992154][   C23]  sec_skcipher_callback+0x7c/0xf4 [hisi_sec2]
[ 1461.998446][   C23]  sec_req_cb+0x104/0x1f4 [hisi_sec2]
[ 1462.003950][   C23]  qm_poll_req_cb+0xcc/0x150 [hisi_qm]
[ 1462.009531][   C23]  qm_work_process+0x60/0xc0 [hisi_qm]
[ 1462.015101][   C23]  process_one_work+0x1c4/0x470
[ 1462.020052][   C23]  worker_thread+0x150/0x3c4
[ 1462.024735][   C23]  kthread+0x108/0x13c
[ 1462.028889][   C23]  ret_from_fork+0x10/0x18

Add a cond_resched() to prevent that.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 2d0080b546e8..cc2caa08966d 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -954,6 +954,8 @@ static void qm_poll_req_cb(struct hisi_qp *qp)
 		qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
 		      qp->qp_status.cq_head, 0);
 		atomic_dec(&qp->qp_status.used);
+
+		cond_resched();
 	}
 
 	/* set c_flag */
-- 
2.33.0

