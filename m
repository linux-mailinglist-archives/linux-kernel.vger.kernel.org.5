Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A1D7D8602
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbjJZP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjJZP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:29:13 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A99D187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:29:08 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 73AAB240106
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 17:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1698334146; bh=H64qUyJiele93axV3rB3BVXjSk5GIMWyc2Mutlt6LLs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=PpyfEGVH22Gu+tpAxSQXOPSj556OPsPQV3DIadsQDbDG226YkoPexZurUNJIGzgHa
         79vfltvsc6QBRvPLz+OPYpDLmXq4h7cFqFs5YZyrUyLAlHCf1YL513LRsEFApuUsWK
         kXCp/+l4UdqS8/X9xpdwisxQsawxKSlyR7aylWYOxoQSh6jIFVKfKnFPVxxfzNyZjE
         UCyKD2CGfyQIFV3KKjPbwgZcA2HBwsQPFxnh/Se3MnYxqxrBajiBITmhFbNsT8Cm6E
         Uz2EY15Ki77Yqg+Ac0YgdCIURJIcidT+UxZKUHF1GZhjblNwysvkMdOc/rtYnrUVpM
         +ym2OeADlpIPw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4SGV800Z7cz9rxN;
        Thu, 26 Oct 2023 17:29:03 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH] nvme: fine-tune sending of first keep-alive
Date:   Thu, 26 Oct 2023 15:28:57 +0000
Message-Id: <20231026152857.176594-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 21783aa2ee8e..f3ca3e1d4a74 100644
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
@@ -4451,6 +4459,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
+	ctrl->ka_last_check_time = jiffies;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);

base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
-- 
2.39.2

