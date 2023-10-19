Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154B67CEE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJSDFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJSDE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:04:58 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48528121;
        Wed, 18 Oct 2023 20:04:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VuSTilE_1697684685;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VuSTilE_1697684685)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 11:04:53 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] block: ublk_drv: Remove unused function
Date:   Thu, 19 Oct 2023 11:04:44 +0800
Message-Id: <20231019030444.53680-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function are defined in the ublk_drv.c file, but not called
elsewhere, so delete the unused function.

drivers/block/ublk_drv.c:1211:20: warning: unused function 'ublk_abort_io_cmds'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6938
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/ublk_drv.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c34474451908..83600b45e12a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1208,15 +1208,6 @@ static inline void ublk_forward_io_cmds(struct ublk_queue *ubq,
 		__ublk_rq_task_work(blk_mq_rq_from_pdu(data), issue_flags);
 }
 
-static inline void ublk_abort_io_cmds(struct ublk_queue *ubq)
-{
-	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
-	struct ublk_rq_data *data, *tmp;
-
-	llist_for_each_entry_safe(data, tmp, io_cmds, node)
-		__ublk_abort_rq(ubq, blk_mq_rq_from_pdu(data));
-}
-
 static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-- 
2.20.1.7.g153144c

