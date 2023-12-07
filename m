Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9B808794
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjLGMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379418AbjLGMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:20:47 -0500
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE4C81708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:20:34 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [125.120.145.92])
        by mail-app2 (Coremail) with SMTP id by_KCgCnrEyJuHFlGHdYAA--.47665S2;
        Thu, 07 Dec 2023 20:20:26 +0800 (CST)
From:   Zhipeng Lu <alexious@zju.edu.cn>
To:     alexious@zju.edu.cn
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: realview: fix two memleaks in realview_soc_probe
Date:   Thu,  7 Dec 2023 20:19:31 +0800
Message-Id: <20231207121932.3353687-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgCnrEyJuHFlGHdYAA--.47665S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWDWF4UWFWUZFyftr4kCrg_yoW8GFyDpr
        WkGFyrAryUKFn5Z345Ca1DGFy5ta4Iya4j9r18Kanru3W5XryaqFyxXFyjyFyDJFZ5Cr45
        Jw4DA3y8JFW3XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryU
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8sqJUUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When of_property_read_string fails, it should free soc_dev_attr
allocated by kzalloc before. So as the failure of regmap_read, the
soc_dev needs to be unregistered and soc_dev_attr needs to be freed.

Fixes: a2974c9c1f83 ("soc: add driver for the ARM RealView")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/soc/versatile/soc-realview.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index c6876d232d8f..19c4a9599c9f 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -99,8 +99,10 @@ static int realview_soc_probe(struct platform_device *pdev)
 
 	ret = of_property_read_string(np, "compatible",
 				      &soc_dev_attr->soc_id);
-	if (ret)
+	if (ret) {
+		kfree(soc_dev_attr);
 		return -EINVAL;
+	}
 
 	soc_dev_attr->machine = "RealView";
 	soc_dev_attr->family = "Versatile";
@@ -112,9 +114,11 @@ static int realview_soc_probe(struct platform_device *pdev)
 	}
 	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET,
 			  &realview_coreid);
-	if (ret)
+	if (ret) {
+		soc_device_unregister(soc_dev);
+		kfree(soc_dev_attr);
 		return -ENODEV;
-
+	}
 	dev_info(&pdev->dev, "RealView Syscon Core ID: 0x%08x, HBI-%03x\n",
 		 realview_coreid,
 		 ((realview_coreid >> 16) & 0xfff));
-- 
2.34.1

