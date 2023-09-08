Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A756579860C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbjIHKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIHKp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:45:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79481BC6;
        Fri,  8 Sep 2023 03:45:23 -0700 (PDT)
X-QQ-mid: bizesmtp80t1694169918tbzdih2r
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 08 Sep 2023 18:45:17 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: +ynUkgUhZJlvTaar5ynbaN+YgYzMmbUdQ02O1U3/wK5rnjfdU3lCgnxHq1KSh
        2uYb4IfLddN/iLAHzZs2HA7vVrF2kjUV7smG4FvrvT68BHAshGCf9uHqml1ZeUsHAtrZUhH
        hfKMeCyLgJgslljOcpIPfFtqGPqaTcqZDlTXLdLrpIPnDECWGjYkjW2rNbwzhkkB/wDA5Du
        XO2GFfrYdVvZuGKuxLi/CXhD2mQeuyjmNHq1Z3qIkGhrN38AiHTf5g60lfY7SVzAFt+qDu4
        krD8GX0cCe616kffi2HA8Q+u4qmHRc2H7Bn9wR3sgnT+V0NEx3wPD/nmY2EmDYpl0dKN1oM
        Q4AGcBR9n7UrgteQl3l474MikW7SPZ8Ta+YgeGD
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4282646312144880661
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH] of/kexec: Omit kaslr-seed when kexecing with nokaslr
Date:   Fri,  8 Sep 2023 18:44:58 +0800
Message-Id: <20230908104458.775740-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chosen node always adds the kaslr-seed property which is needless
for the kernels kexeced with the cmdline contained "nokaslr".

So omit the kaslr-seed when kexecing with nokaslr.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 drivers/of/kexec.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f26d2ba8a371..c0d53b10cb70 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -19,6 +19,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/string.h>
 
 #define RNG_SEED_SIZE		128
 
@@ -263,6 +264,14 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
 }
 #endif /* CONFIG_IMA_KEXEC */
 
+static bool is_nokaslr_cmdline(const char *cmdline)
+{
+	char *str;
+
+	str = strstr(cmdline, "nokaslr");
+	return str == cmdline || (str > cmdline && *(str - 1) == ' ');
+}
+
 /*
  * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
  *
@@ -429,15 +438,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 	else if (ret)
 		goto out;
 
-	if (rng_is_initialized()) {
+	if (!is_nokaslr_cmdline(cmdline) && rng_is_initialized()) {
 		u64 seed = get_random_u64();
 
 		ret = fdt_setprop_u64(fdt, chosen_node, "kaslr-seed", seed);
 		if (ret)
 			goto out;
 	} else {
-		pr_notice("RNG is not initialised: omitting \"%s\" property\n",
-			  "kaslr-seed");
+		pr_notice("RNG is not initialised or Kexec with nokaslr:"
+			  " omitting \"%s\" property\n", "kaslr-seed");
 	}
 
 	/* add rng-seed */
-- 
2.20.1

