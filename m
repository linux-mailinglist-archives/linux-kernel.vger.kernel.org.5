Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB437F8554
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345989AbjKXU5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKXU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:57:15 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869F12B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:57:20 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 41AA4240027
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 21:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1700859438; bh=VUY/r48iuYNklA3pOPBW8jilcpXCwFMRejWJXce3tks=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=ATwDadX1/5k2Zv9OtETrV/kpzy03/jc89TOifHaP7JU/FWHtiGOkoCiSZz3d/NBL6
         mZEL4wBs20g4K2+C97PEQWM14oeMm434q52x2ViKkqQK4v68S1eCP2l3MJOmLZuK3h
         KIa1tM+yrCSr3D4fbhYvvr6diYqIvy8t9uBjv+TNlbkumjBs6gD1tFrMzrSssYRIBD
         F140F3BWnZmfMn3/Va5bXLT9EdsuCxAkDqKo8zRL6ril3YWIPY/nuHAqcg0NsqTLO8
         QFHfxB7vHGX6e/ZgIzhvI2uxH4PmzwY663VFposVvBs12atc7dwSoXAio+60zGbgRM
         iBMDy0+85lQoQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ScS3H31gWz9rxR;
        Fri, 24 Nov 2023 21:57:15 +0100 (CET)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH RESEND] nvme: fine-tune sending of first keep-alive
Date:   Fri, 24 Nov 2023 20:56:59 +0000
Message-Id: <20231124205659.523248-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep-alive commands are sent half-way through the kato period.
This normally works well but fails when the keep-alive system is
started when we are more than half way through the kato.
This can happen on larger setups or due to host delays.
With this change we now time the initial keep-alive command from
the controller initialisation time, rather than the keep-alive
mechanism activation time.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46a4c9c5ea96..8bf24c1cd8bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1192,8 +1192,16 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work,
-			   nvme_keep_alive_work_period(ctrl));
+	unsigned long now = jiffies;
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+	unsigned long ka_next_check_tm = ctrl->ka_last_check_time + delay;
+
+	if (time_after(now, ka_next_check_tm))
+		delay = 0;
+	else
+		delay = ka_next_check_tm - now;
+
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
@@ -4471,6 +4479,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
+	ctrl->ka_last_check_time = jiffies;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);

base-commit: 5b7ad877e4d81f8904ce83982b1ba5c6e83deccb
-- 
2.39.2

