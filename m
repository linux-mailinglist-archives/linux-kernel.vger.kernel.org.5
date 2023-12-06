Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B64807B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377578AbjLFWYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377254AbjLFWYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:24:05 -0500
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA942D46;
        Wed,  6 Dec 2023 14:24:10 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4SlsQ11z96z9vCD;
        Wed,  6 Dec 2023 23:24:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kE8Ud0EzoCD3; Wed,  6 Dec 2023 23:24:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4SlsQ114zRz9vCC;
        Wed,  6 Dec 2023 23:24:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 212368B774;
        Wed,  6 Dec 2023 23:24:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id e_urxSmvSke5; Wed,  6 Dec 2023 23:24:09 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.67])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D30B78B768;
        Wed,  6 Dec 2023 23:24:08 +0100 (CET)
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Jochen Friedrich <jochen@scram.de>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-i2c@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] i2c: cpm: Remove linux,i2c-index conversion from be32
Date:   Wed,  6 Dec 2023 23:24:03 +0100
Message-ID: <460afa20784a445dff05b552ebb8c6a389d9de85.1701901105.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701901442; l=1142; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=AbB+dbMx4HU5AvTnNlYtCM6jkLY0EwXMarDUyPFbLic=; b=y/PdN+/KvCr7mrD+I6N56Yd6xNUvph00KdvH/w9ujSvwme01OU8fIwptkgvJ/N960OH3yoWyW aw+SgltocrLAHit+cRgeD7bZpD3uAlnrBYNIsCx3hVdfy9SyBTEAw6T
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports an error on some data that gets converted from be32.

That's because that data is typed u32 instead of __be32.

The type is correct, the be32_to_cpu() conversion is not.

Remove the conversion.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312042210.QL4DA8Av-lkp@intel.com/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Use u32 directly, remove be32_to_cpu().
---
 drivers/i2c/busses/i2c-cpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 9a664abf734d..771d60bc8d71 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -658,7 +658,7 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 	/* register new adapter to i2c module... */
 
 	data = of_get_property(ofdev->dev.of_node, "linux,i2c-index", &len);
-	cpm->adap.nr = (data && len == 4) ? be32_to_cpup(data) : -1;
+	cpm->adap.nr = (data && len == 4) ? *data : -1;
 	result = i2c_add_numbered_adapter(&cpm->adap);
 
 	if (result < 0)
-- 
2.41.0

