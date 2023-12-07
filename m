Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4C3808605
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjLGJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjLGJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:57:33 -0500
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1D96133;
        Thu,  7 Dec 2023 01:57:35 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [115.200.230.188])
        by mail-app4 (Coremail) with SMTP id cS_KCgDXltSZlXFl8NNbAA--.3170S2;
        Thu, 07 Dec 2023 17:51:21 +0800 (CST)
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
Subject: [PATCH] octeontx2-af: fix a use-after-free in rvu_nix_register_reporters
Date:   Thu,  7 Dec 2023 17:49:16 +0800
Message-Id: <20231207094917.3338582-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgDXltSZlXFl8NNbAA--.3170S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW3GFWUWr1DGF1xJF17Awb_yoW8tFWxpF
        WrAry3GryxtryUtF9rXa1jyay7Kan3KrWUGr1SkwnagayrJFnayrsaqFnavFsxArWkGFWj
        vr4Yq3yDArWDtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUbgyCJUUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rvu_dl will be freed in rvu_nix_health_reporters_destroy(rvu_dl)
after the create_workqueue fails, and after that free, the rvu_dl will
be translate back through the following call chain:

rvu_nix_health_reporters_destroy
  |-> rvu_nix_health_reporters_create
       |-> rvu_health_reporters_create
             |-> rvu_register_dl (label err_dl_health)

Finally. in the err_dl_health label, rvu_dl being freed again in
rvu_health_reporters_destroy(rvu) by rvu_nix_health_reporters_destroy.
In the second calls of rvu_nix_health_reporters_destroy, however,
it uses rvu_dl->rvu_nix_health_reporter, which is already freed at
the end of rvu_nix_health_reporters_destroy in the first call.

So this patch prevents the first destroy by instantly returning -ENONMEN
when create_workqueue fails. In addition, since the failure of
create_workqueue is the only entrence of label err, it has been
integrated into the error-handling path of create_workqueue.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index c70932625d0d..f0308d7716e1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -538,7 +538,7 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
 	if (!rvu_dl->devlink_wq)
-		goto err;
+		return -ENOMEM;
 
 	INIT_WORK(&rvu_reporters->intr_work, rvu_nix_intr_work);
 	INIT_WORK(&rvu_reporters->gen_work, rvu_nix_gen_work);
@@ -546,9 +546,6 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	INIT_WORK(&rvu_reporters->ras_work, rvu_nix_ras_work);
 
 	return 0;
-err:
-	rvu_nix_health_reporters_destroy(rvu_dl);
-	return -ENOMEM;
 }
 
 static int rvu_nix_health_reporters_create(struct rvu_devlink *rvu_dl)
-- 
2.34.1

