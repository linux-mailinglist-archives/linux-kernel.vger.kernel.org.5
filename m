Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31B7E4408
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344292AbjKGPtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjKGPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:48:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B721125;
        Tue,  7 Nov 2023 07:48:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059C6C433C8;
        Tue,  7 Nov 2023 15:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372089;
        bh=mUXbLAeh8ra++NLFkfRedPZXdmtQK5sBgrZ4yeiS5HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXnrscLjWsqOXY8azKIbQ3ZQWVkOQLFAmQBSvPikoZ4+3BtUBDy2KmIXyLUWPQJzj
         W3fIwb0jY9PSzrC9vtSlVTHKJc5W1aJy1j1VR/DKY1gHBj5jTHO7Ar+MD8TdvAYNCr
         aGJ3xmucqY8bpprcfVuAj5S2Y4EPMNwW1L1f7rW/CT8e4jp2oPsfenTfTtu9ryAriV
         QxGJRUBjS6hDNBmU/fxu4ahQOS2xceWMJhFu0eus48mmvg2WDNTxx5ephTZmIpswNh
         PCgnppUQVmz3eXaQbaDCulPbuuLI33kVWOhVJFIJ34eguLjTsyvvE0I2b40gpqP93g
         vtEMH2r5yjyQg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Longfang Liu <liulongfang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, qianweili@huawei.com,
        wangzhou1@hisilicon.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/36] crypto: hisilicon/qm - prevent soft lockup in receive loop
Date:   Tue,  7 Nov 2023 10:46:15 -0500
Message-ID: <20231107154654.3765336-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154654.3765336-1-sashal@kernel.org>
References: <20231107154654.3765336-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longfang Liu <liulongfang@huawei.com>

[ Upstream commit 33fc506d2ac514be1072499a263c3bff8c7c95a0 ]

In the scenario where the accelerator business is fully loaded.
When the workqueue receiving messages and performing callback
processing, there are a large number of messages that need to be
received, and there are continuously messages that have been
processed and need to be received.
This will cause the receive loop here to be locked for a long time.
This scenario will cause watchdog timeout problems on OS with kernel
preemption turned off.

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

Therefore, it is necessary to add an actively scheduled operation in the
while loop to prevent this problem.
After adding it, no matter whether the OS turns on or off the kernel
preemption function. Neither will cause watchdog timeout issues.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/qm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index a99fd589445ce..a830a2e0f4400 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -849,6 +849,8 @@ static void qm_poll_req_cb(struct hisi_qp *qp)
 		qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
 		      qp->qp_status.cq_head, 0);
 		atomic_dec(&qp->qp_status.used);
+
+		cond_resched();
 	}
 
 	/* set c_flag */
-- 
2.42.0

