Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED69756EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGQVED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGQVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:04:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D54121
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:03:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6686a05bc66so3613712b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689627839; x=1692219839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIZEzHVxC1Fx70Cdkz+V0OVQ6Dog78uDmiwE1vZt2q4=;
        b=BPsBDwWrNKB91DqaWrNhpO/v4ykSqWSBCirIAnuxFvOs77l0rqsU8+TqkOv28d6dXr
         WmYVAVFOM9vjv+UHSWcME4r1ezRlHwg5UqohAqTvLNhkEnaX5Hcz/xICNS3d7dBZx2Iv
         GvTFOn4TF4Fw47/Bm6YeEH648hSZrlKW22TNiQ9ZRZR+GIbPaytAhRE0ZhEGwAnWSUOu
         yZ2+3zkaTUHT/MggTaWj1HOAknAkIdJCOfkXNZXkxX6lAcMXp3eJYHfdKdUaRY4p8sqg
         3GBwAf99mw6qFjNqVtSdyTeC8uhdwG9Wb9KnEINmXUoKYaNFsm+NslcdAJtzegeo08S9
         tp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627839; x=1692219839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIZEzHVxC1Fx70Cdkz+V0OVQ6Dog78uDmiwE1vZt2q4=;
        b=cqwy+enLSqsG3G7HbOgWZvhSFh9rPE2Jv0tl8DIribxdMxOEAX+6+EVD+qvem9R//L
         MlMVAEEPpa5MZ+WHRA2gN0ATs6hhtSY4bmOVHhID6VX5RSdaWtGNIY23E+CYXO3p/BYk
         XBMm/rfxo2hdBhPrVlO9Qu5a7YoThk1x6awl2/qpwsKV0ojTExVhtPrZEG/ULOZo/wOA
         dIuNf8TdMkOc39Y0lvovPmQKjAv5JPiXie9aP7UlQ6pPdqvC8BL1noYmiwZNwoer9Oa6
         AGvUFW4Ltum1zAGN1i4HLeMR1OI1/r/4cGqTglHsmLoQm6Ow4GPJmiOkxqLXBx/DO/Ds
         MMYw==
X-Gm-Message-State: ABy/qLbFxV5x1r8APOuDjKOYRAQQRihZxU4l2yLToXa1yFU6iXW/IDAR
        BOC8QmKLSFVAJJRylO1rkuXQ+g==
X-Google-Smtp-Source: APBJJlGh2y7l4Mcb4h+KipYMEFcoZHbETqHgVjohsP4Fa5WcrLA/yfUSBTw5rEOHn+qg1Eica/L75Q==
X-Received: by 2002:a05:6a00:ad1:b0:67d:22a6:2f54 with SMTP id c17-20020a056a000ad100b0067d22a62f54mr790132pfl.31.1689627839264;
        Mon, 17 Jul 2023 14:03:59 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id j24-20020aa78d18000000b006732786b5f1sm191915pfe.213.2023.07.17.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:03:58 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] clk: sifive: Allow building the driver as a module
Date:   Mon, 17 Jul 2023 14:03:56 -0700
Message-Id: <20230717210356.2794736-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717210356.2794736-1-samuel.holland@sifive.com>
References: <20230717210356.2794736-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can reduce the kernel image size in multiplatform configurations.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/clk/sifive/Kconfig       | 2 +-
 drivers/clk/sifive/sifive-prci.c | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index 2322f634a910..49597d95602e 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -10,7 +10,7 @@ menuconfig CLK_SIFIVE
 if CLK_SIFIVE
 
 config CLK_SIFIVE_PRCI
-	bool "PRCI driver for SiFive SoCs"
+	tristate "PRCI driver for SiFive SoCs"
 	default ARCH_SIFIVE
 	select RESET_CONTROLLER
 	select RESET_SIMPLE
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index e317f3454e93..8c67d1a7c8df 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -7,6 +7,7 @@
 #include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include "sifive-prci.h"
 #include "fu540-prci.h"
@@ -618,9 +619,6 @@ static struct platform_driver sifive_prci_driver = {
 	},
 	.probe = sifive_prci_probe,
 };
+module_platform_driver(sifive_prci_driver);
 
-static int __init sifive_prci_init(void)
-{
-	return platform_driver_register(&sifive_prci_driver);
-}
-core_initcall(sifive_prci_init);
+MODULE_LICENSE("GPL");
-- 
2.40.1

