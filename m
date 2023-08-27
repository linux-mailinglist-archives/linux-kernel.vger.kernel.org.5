Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4574789B09
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjH0Cjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjH0Cjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:39:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC491198;
        Sat, 26 Aug 2023 19:39:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31aeef88a55so1704146f8f.2;
        Sat, 26 Aug 2023 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693103975; x=1693708775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yH/o2ZWBRtoe26D6XGpWVYuP9btOQOzyXUSdyvEgf4=;
        b=KxMixF7fAz+2HM1zt8DJekvJFtI5xTlkM1RtpGWqXnWiUbPWICwFsQoSx6pSFZkV1m
         II3uy3tNcN27PqYiga94p5QfIxqxfB6NKOx7Tysq4CKZIcX6ULSTOJrKT0jsBWvjYJ6t
         5smeF9BVTK8yjGfSdsw+q/Xlr50yUXgj2x4O/NGPUNG/NGd1QSNcSJGt955NpDgH20x3
         cfov9IkCG1yHk/ipIF+z49xEKmRHhRsPYalmKY16gdHc98hjIqcOLv+gmBhqT8OEfMzn
         k7SY5M+Q6ARmgF8pabFw3Xo3pia4gKu6ya/ObNl7xeRFra/8+AqhgqJWXt2k8JlIsi0h
         jd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693103975; x=1693708775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yH/o2ZWBRtoe26D6XGpWVYuP9btOQOzyXUSdyvEgf4=;
        b=XW1uDplIVZv2TNbI+o+m1C+Xsj4qmWs2EfoOqPer/dfu3Esr+sf+dvHet3ERpltwvs
         S2sk48SVAO5UKt7AhEOPsRSDE9067stPDTZEvMznWeDXwoWP21lSY6K2SlWHzL29aWkL
         je13OhtmdARKQYnVxhCTB8AD5BwFxR/e6s5SoDURd7N9Tt8C53jpbjzunsDHSj2SD3+x
         ejf7Ei8QaC9wYCT8Eo42Su9SwkzGxcZrEM09xj0OKyGCWhqOfgfH8waopmhKgELGlqEt
         iPosnFn8PQnpSbP7oJQdBDUqXmzaGZfS5rDfRVrFsL/3fR+cBFdPsaPXHGC3yjtcW5g4
         n/Xg==
X-Gm-Message-State: AOJu0Yx+wQ6NwYcnvOAfTrIOppq6Q8tCx9pBN0MRdOrOKmPWPuR7IJgJ
        CTmA9250a7O1Gm+j1xhg9BLwDGXY97A=
X-Google-Smtp-Source: AGHT+IGMIXkgpm8D4jua/sUFVs6Tw8lJJjU2zm69WqKFh27o1N3r6lrBnu6lxDtbvqSAwGlP7n+Drg==
X-Received: by 2002:a05:6000:889:b0:319:8333:a2cb with SMTP id cs9-20020a056000088900b003198333a2cbmr17028019wrb.13.1693103974785;
        Sat, 26 Aug 2023 19:39:34 -0700 (PDT)
Received: from localhost.localdomain (211.red-88-11-180.dynamicip.rima-tde.net. [88.11.180.211])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b00317b5c8a4f1sm6313482wrv.60.2023.08.26.19.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:39:34 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, arnd@kernel.org, yangshiji66@outlook.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] clk: ralink: mtmips: quiet unused variable warning
Date:   Sun, 27 Aug 2023 04:39:32 +0200
Message-Id: <20230827023932.501102-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF is disabled then the matching table is not referenced and
the following warning appears:

drivers/clk/ralink/clk-mtmips.c:821:34: warning: unused variable 'mtmips_of_match' [-Wunused-const-variable]
821 |   static const struct of_device_id mtmips_of_match[] = {
    |                          ^

There are two match tables in the driver: one for the clock driver and the
other for the reset driver. The only difference between them is that the
clock driver uses 'data' and does not have 'ralink,rt2880-reset' compatible.
Both just can be merged into a single one just by adding the compatible
'ralink,rt2880-reset' entry to 'mtmips_of_match[]', which will allow it to
be used for 'mtmips_clk_driver' (which doesn't use the data) as well as for
'mtmips_clk_init()' (which doesn't need get called for 'ralink,rt2880-reset').

Doing in this way ensures that 'CONFIG_OF' is not disabled anymore so the
above warning disapears.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307242310.CdOnd2py-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
Changes in v2:
- Merge two match tables into one to properly avoid this warning.

PATCH in v1: https://lore.kernel.org/lkml/20230802092647.3000666-1-sergio.paracuellos@gmail.com/T/

 drivers/clk/ralink/clk-mtmips.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 1e7991439527..50a443bf79ec 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -821,6 +821,10 @@ static const struct mtmips_clk_data mt76x8_clk_data = {
 };
 
 static const struct of_device_id mtmips_of_match[] = {
+	{
+		.compatible = "ralink,rt2880-reset",
+		.data = NULL,
+	},
 	{
 		.compatible = "ralink,rt2880-sysc",
 		.data = &rt2880_clk_data,
@@ -1088,25 +1092,11 @@ static int mtmips_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mtmips_clk_of_match[] = {
-	{ .compatible = "ralink,rt2880-reset" },
-	{ .compatible = "ralink,rt2880-sysc" },
-	{ .compatible = "ralink,rt3050-sysc" },
-	{ .compatible = "ralink,rt3052-sysc" },
-	{ .compatible = "ralink,rt3352-sysc" },
-	{ .compatible = "ralink,rt3883-sysc" },
-	{ .compatible = "ralink,rt5350-sysc" },
-	{ .compatible = "ralink,mt7620-sysc" },
-	{ .compatible = "ralink,mt7628-sysc" },
-	{ .compatible = "ralink,mt7688-sysc" },
-	{}
-};
-
 static struct platform_driver mtmips_clk_driver = {
 	.probe = mtmips_clk_probe,
 	.driver = {
 		.name = "mtmips-clk",
-		.of_match_table = mtmips_clk_of_match,
+		.of_match_table = mtmips_of_match,
 	},
 };
 
-- 
2.25.1

