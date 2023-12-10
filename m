Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1980BA25
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjLJK14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJK1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:27:54 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 599D7FF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:27:59 -0800 (PST)
Received: from localhost.localdomain (unknown [10.192.120.142])
        by mail-app2 (Coremail) with SMTP id by_KCgCnHNSkknVlObhtAA--.13346S4;
        Sun, 10 Dec 2023 18:27:53 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvdimm-btt: simplify code with the scope based resource management
Date:   Sun, 10 Dec 2023 18:27:47 +0800
Message-Id: <20231210102747.13545-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCnHNSkknVlObhtAA--.13346S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF45ZFWkKw4fCF1DJry8uFg_yoW8Gw4xpF
        s8A34DArZ8JF1xCF1DCa17u343Ga1fA34UKFyjk39avFW3tw1jqrWktFyS9rykurWIvry3
        KrWjywn0kF45AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgsFBmV0OhUYjwABsi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the scope based resource management (defined in
linux/cleanup.h) to automate resource lifetime
control on struct btt_sb *super in discover_arenas().

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/nvdimm/btt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index d5593b0dc700..ff42778b51de 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/nd.h>
 #include <linux/backing-dev.h>
+#include <linux/cleanup.h>
 #include "btt.h"
 #include "nd.h"
 
@@ -847,7 +848,7 @@ static int discover_arenas(struct btt *btt)
 {
 	int ret = 0;
 	struct arena_info *arena;
-	struct btt_sb *super;
+	struct btt_sb *super __free(kfree) = NULL;
 	size_t remaining = btt->rawsize;
 	u64 cur_nlba = 0;
 	size_t cur_off = 0;
@@ -860,10 +861,8 @@ static int discover_arenas(struct btt *btt)
 	while (remaining) {
 		/* Alloc memory for arena */
 		arena = alloc_arena(btt, 0, 0, 0);
-		if (!arena) {
-			ret = -ENOMEM;
-			goto out_super;
-		}
+		if (!arena)
+			return -ENOMEM;
 
 		arena->infooff = cur_off;
 		ret = btt_info_read(arena, super);
@@ -919,14 +918,11 @@ static int discover_arenas(struct btt *btt)
 	btt->nlba = cur_nlba;
 	btt->init_state = INIT_READY;
 
-	kfree(super);
 	return ret;
 
  out:
 	kfree(arena);
 	free_arenas(btt);
- out_super:
-	kfree(super);
 	return ret;
 }
 
-- 
2.17.1

