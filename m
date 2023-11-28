Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400287FB630
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjK1Joy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjK1Joq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:44:46 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB09110E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:44:51 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3AS9iIWO061665;
        Tue, 28 Nov 2023 17:44:18 +0800 (+08)
        (envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SfcpY5H47z2MxJxp;
        Tue, 28 Nov 2023 17:38:45 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 28 Nov 2023 17:44:16 +0800
From:   Yunlong Xing <yunlong.xing@unisoc.com>
To:     <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
        <dm-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <yibin.ding@unisoc.com>, <hongyu.jin@unisoc.com>,
        <dongliang.cui@unisoc.com>, <yunlong.xing@unisoc.com>,
        <xiuhong.wang@unisoc.com>
Subject: [PATCH] dm: increase the io priority of the kworker-kverityd process
Date:   Tue, 28 Nov 2023 17:44:14 +0800
Message-ID: <20231128094414.583666-1-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.5.32.15]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3AS9iIWO061665
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Jin <hongyu.jin@unisoc.com>

When obtaining the hash value of a high IO priority data block
from the disk, the kverity-worker that obtains the hash will
also have a high IO priority to avoid being blocked by other
IO with low IO priority.

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
---
 drivers/md/dm-verity-target.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index e115fcfe723c..ade9c6734154 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/string.h>
 #include <linux/jump_label.h>
+#include <linux/ioprio.h>
 
 #define DM_MSG_PREFIX			"verity"
 
@@ -639,7 +640,9 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
 static void verity_work(struct work_struct *w)
 {
 	struct dm_verity_io *io = container_of(w, struct dm_verity_io, work);
+	struct bio *bio = dm_bio_from_per_bio_data(io, io->v->ti->per_io_data_size);
 
+	set_task_ioprio(current, bio->bi_ioprio);
 	io->in_tasklet = false;
 
 	verity_fec_init_io(io);
-- 
2.25.1

