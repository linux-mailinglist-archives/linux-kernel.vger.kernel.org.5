Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01F8129F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443402AbjLNIGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjLNIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:05:58 -0500
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 547A7CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:06:03 -0800 (PST)
Received: from localhost.localdomain (unknown [10.190.71.46])
        by mail-app3 (Coremail) with SMTP id cC_KCgDHP9_8rnpl7+PcAA--.38858S4;
        Thu, 14 Dec 2023 15:30:10 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: diskonchip: fix a potential double free in doc_probe
Date:   Thu, 14 Dec 2023 15:29:43 +0800
Message-Id: <20231214072946.10285-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgDHP9_8rnpl7+PcAA--.38858S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5Kr1Dtw1UCF48CrW8Crg_yoW8JFW7pF
        WUua42kayUJ3y09a4qvF48GFy5Jw4kGrW7GrZ3Zay7u34rurn3Gr1rCry7ZF4qqa4IqayY
        q395ta48JF1UtrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgIIBmV4LpY5mAAGsM
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nand_scan() fails, it has cleaned up related resources
in its error paths. Therefore, the following nand_cleanup()
may lead to a double-free. One possible trace is:

doc_probe
  |-> nand_scan
  |     |-> nand_scan_with_ids
  |           |-> nand_scan_tail
  |                 |-> kfree(chip->data_buf) [First free]
  |
  |-> nand_cleanup
        |-> kfree(chip->data_buf) [Double free here]

Fix this by removing nand_cleanup() on failure of
nand_scan().

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/mtd/nand/raw/diskonchip.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 5d2ddb037a9a..5243fab9face 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1491,10 +1491,12 @@ static int __init doc_probe(unsigned long physadr)
 	else
 		numchips = doc2001_init(mtd);
 
-	if ((ret = nand_scan(nand, numchips)) || (ret = doc->late_init(mtd))) {
-		/* DBB note: i believe nand_cleanup is necessary here, as
-		   buffers may have been allocated in nand_base.  Check with
-		   Thomas. FIX ME! */
+	ret = nand_scan(nand, numchips);
+	if (ret)
+		goto fail;
+
+	ret = doc->late_init(mtd);
+	if (ret) {
 		nand_cleanup(nand);
 		goto fail;
 	}
-- 
2.17.1

