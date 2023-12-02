Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F888801C07
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjLBKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLBKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:01:32 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D349CC;
        Sat,  2 Dec 2023 02:01:36 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [60.177.97.75])
        by mail-app2 (Coremail) with SMTP id by_KCgCnrEz3_2plN6c7AA--.29237S2;
        Sat, 02 Dec 2023 17:59:19 +0800 (CST)
From:   Zhipeng Lu <alexious@zju.edu.cn>
To:     alexious@zju.edu.cn
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        George Cherian <george.cherian@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] octeontx2-af: fix a use-after-free in rvu_npa_register_reporters
Date:   Sat,  2 Dec 2023 17:59:02 +0800
Message-Id: <20231202095902.3264863-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgCnrEz3_2plN6c7AA--.29237S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyxWFyftFy3Cr1xXFW7twb_yoW8tr18pF
        WrAry5Gr97t34jqF9rXa1Utay2k3Wktr4UWr1xKwnIg3WrJrsayrsaqF9YgFsxArWkGFWj
        qr4Yq3yUZrZrJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjMmh5UUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rvu_dl will be freed in rvu_npa_health_reporters_destroy(rvu_dl)
after the create_workqueue fails, and after that free, the rvu_dl will
be translate back through rvu_npa_health_reporters_create,
rvu_health_reporters_create, and rvu_register_dl. Finally it goes to the
err_dl_health label, being freed again in
rvu_health_reporters_destroy(rvu) by rvu_npa_health_reporters_destroy.
In the second calls of rvu_npa_health_reporters_destroy, however,
it uses rvu_dl->rvu_npa_health_reporter, which is already freed at
the end of rvu_npa_health_reporters_destroy in the first call.

So this patch prevents the first destroy by instantly returning -ENONMEN
when create_workqueue fails. In addition, since the failure of
create_workqueue is the only entrence of label err, it has been
integrated into the error-handling path of create_workqueue.

Fixes: f1168d1e207c ("octeontx2-af: Add devlink health reporters for NPA")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 41df5ac23f92..058f75dc4c8a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1285,7 +1285,7 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
 	if (!rvu_dl->devlink_wq)
-		goto err;
+		return -ENOMEM;
 
 	INIT_WORK(&rvu_reporters->intr_work, rvu_npa_intr_work);
 	INIT_WORK(&rvu_reporters->err_work, rvu_npa_err_work);
@@ -1293,9 +1293,6 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	INIT_WORK(&rvu_reporters->ras_work, rvu_npa_ras_work);
 
 	return 0;
-err:
-	rvu_npa_health_reporters_destroy(rvu_dl);
-	return -ENOMEM;
 }
 
 static int rvu_npa_health_reporters_create(struct rvu_devlink *rvu_dl)
-- 
2.34.1

