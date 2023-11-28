Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D687FC878
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376494AbjK1VQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376637AbjK1VOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:14:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5F270A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:08:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF00C433BC;
        Tue, 28 Nov 2023 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205694;
        bh=npHZoGgH6aI7PnmoU/VcachZyj1FZKaZi5flPg2IOaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5yCveo/afxZXn9CNaBaPMH/TqR3wIr6zoVFQHILnwMTPL4WLUCuoU3C45alJ2myY
         ichLtZPYiR+VyJ/PPvDDgERtCDv/JmlksR/64x+QYXqYrkNd0CC7ItcS0HRsSZqIAe
         vTO9rXh5tuLB+MW8QSOrNMg34tfmz2cBu3y0VQC5PQz16f+nvk3AC6de0tH6GXclkr
         y3e4rKU7d7pFOcPuS47TEXwvlstoFILqf4m9LAJ5BFlXVGRCadi0b9gScuJJAd9HtN
         mTkEu66F9jmenJFI11kGqE8Fs+y3tuBBIQwxNDNDuSa7yvd3beQZJXR1IpCenUZvv9
         uFfDMQreumxBA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 13/25] nvme: catch errors from nvme_configure_metadata()
Date:   Tue, 28 Nov 2023 16:07:29 -0500
Message-ID: <20231128210750.875945-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit cd9aed606088d36a7ffff3e808db4e76b1854285 ]

nvme_configure_metadata() is issuing I/O, so we might incur an I/O
error which will cause the connection to be reset.
But in that case any further probing will race with reset and
cause UAF errors.
So return a status from nvme_configure_metadata() and abort
probing if there was an I/O error.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25ddfabc58f73..73cec036567d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1845,16 +1845,18 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return ret;
 }
 
-static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	int ret;
 
-	if (nvme_init_ms(ns, id))
-		return;
+	ret = nvme_init_ms(ns, id);
+	if (ret)
+		return ret;
 
 	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		return;
+		return 0;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
@@ -1863,7 +1865,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * remap the separate metadata buffer from the block layer.
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
-			return;
+			return 0;
 
 		ns->features |= NVME_NS_EXT_LBAS;
 
@@ -1890,6 +1892,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		else
 			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	}
+	return 0;
 }
 
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
@@ -2063,7 +2066,11 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	nvme_configure_metadata(ns, id);
+	ret = nvme_configure_metadata(ns, id);
+	if (ret < 0) {
+		blk_mq_unfreeze_queue(ns->disk->queue);
+		goto out;
+	}
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->disk, ns, id);
 
-- 
2.42.0

