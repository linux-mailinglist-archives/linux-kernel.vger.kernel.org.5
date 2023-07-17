Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64F756EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGQVEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGQVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:03:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A989121
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:03:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666edfc50deso3020272b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689627838; x=1692219838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1J3PrW+KELul59iWMsbn0NuwlLctvPQuEIvtb6UgWY=;
        b=Ku8I0funEqrw0TX6rYaGXYYIHrttNyMTFVvrgZZGUya0wgLsLsxRwq4M1BtrN7gi6j
         PCbSF9+xrLXT26UHSIGTbFUp2b1xnr4ITMhmHMJVPsQOblGAQLmEmKV2mdsWTorMTljb
         JmsVEGyxnFlw4/sOEAReNkqylFfUlMcYHnHgi/7e4ELG/3iJrZ2+KTCIVkNy6+f56CkI
         xx603jKovuSBX1guw5etp3sUmolhDDjr/apHn5nHypc+NOj+g2iuKidRWC+hxQdjdG5P
         0EzE2Qih3mmpiiLY3oho1QgNIPLTv4n6B5DKMqNi3hLG/W9LFX2K835TLTMHoTXkMWLk
         oJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627838; x=1692219838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1J3PrW+KELul59iWMsbn0NuwlLctvPQuEIvtb6UgWY=;
        b=WxntL5agXbDGARJQh5cxQIfMOCo6v+haqrI921bzqIZEpzkgIPtdfA5AQRxo1PiO2Y
         w5aBBMxIwxs8Otl/K8QMYkHH386Cp/OultG3W94g/AuZm2w+pC0dj4MYPDzm1ne+DRWG
         aXB5zthjb/eEt2d8wbiu9P6agjVt0ozG0TJVJ20ohcolbrQa7iPBFAgdiVu5D/NkwVh/
         HqTBUKL7fNa7eJxyketcOhGKKUopdYGYqxtRVNIGsBbox5L8Mqs+5EkRPLU3v1X6W/Md
         qcQTFWjX++WqsoG3nN/IGlPKCPp+k3aPageEjNRl7n7KcPomU0rzqWYDi+A+oxw6y5/p
         dFow==
X-Gm-Message-State: ABy/qLbc2m8BWQYCUlJJyCFRNITWtPTk+RDztnW1hQNSAMBbU3beh4Xe
        UffKK0BF0d3mmQc4GMcq3gaBsA==
X-Google-Smtp-Source: APBJJlGOS37CqLaBewrjCl5Z0maH1pn80HSmDOUF0nWeAle4VJHXL5qIG15IsIleFsgn4g9p6Ja4Vg==
X-Received: by 2002:a05:6a20:8425:b0:12b:40d3:aeb1 with SMTP id c37-20020a056a20842500b0012b40d3aeb1mr16273429pzd.25.1689627837974;
        Mon, 17 Jul 2023 14:03:57 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id j24-20020aa78d18000000b006732786b5f1sm191915pfe.213.2023.07.17.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:03:57 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: analogbits: Allow building the library as a module
Date:   Mon, 17 Jul 2023 14:03:55 -0700
Message-Id: <20230717210356.2794736-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This library is only used by the SiFive PRCI driver. When that driver is
built as a module, it makes sense to build this library as a module too.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/clk/analogbits/Kconfig          | 2 +-
 drivers/clk/analogbits/wrpll-cln28hpc.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/analogbits/Kconfig b/drivers/clk/analogbits/Kconfig
index 1e291b185438..7d73db0fcd49 100644
--- a/drivers/clk/analogbits/Kconfig
+++ b/drivers/clk/analogbits/Kconfig
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config CLK_ANALOGBITS_WRPLL_CLN28HPC
-	bool
+	tristate
diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 09ca82356399..760b51031795 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -28,6 +28,7 @@
 #include <linux/math64.h>
 #include <linux/math.h>
 #include <linux/minmax.h>
+#include <linux/module.h>
 
 #include <linux/clk/analogbits-wrpll-cln28hpc.h>
 
@@ -312,6 +313,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(wrpll_configure_for_rate);
 
 /**
  * wrpll_calc_output_rate() - calculate the PLL's target output rate
@@ -349,6 +351,7 @@ unsigned long wrpll_calc_output_rate(const struct wrpll_cfg *c,
 
 	return n;
 }
+EXPORT_SYMBOL_GPL(wrpll_calc_output_rate);
 
 /**
  * wrpll_calc_max_lock_us() - return the time for the PLL to lock
@@ -366,3 +369,6 @@ unsigned int wrpll_calc_max_lock_us(const struct wrpll_cfg *c)
 {
 	return MAX_LOCK_US;
 }
+EXPORT_SYMBOL_GPL(wrpll_calc_max_lock_us);
+
+MODULE_LICENSE("GPL");
-- 
2.40.1

