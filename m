Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF875E3C1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGWQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGWQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:24:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B461707;
        Sun, 23 Jul 2023 09:24:21 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55b66ca1c80so1870721a12.0;
        Sun, 23 Jul 2023 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129456; x=1690734256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc6dwH/HvZi0vPM1tFTS6dfKlRz8fg7TW4Ttiul7pXo=;
        b=XfrIQYeOXg8UEZ4jO37YBLFnyAes+NpBWG72OQ4GCw0uta+4pUDiVT4xVDPw6yiu5U
         mVva2dy+Tev/KQBEJ8DB6mNyulxASK8JUoYxMmPHEldPF/G98IWFT0WL5dlMYcSaZs2v
         z58DIGbEddod5XxS29RKnzrOJyFiTURq20CB4K4gohQo3ZWlVkb7Tt3z/mxbgA34VSIg
         AFW2mUu6dqs2MF9wme9sJOZWMgDLecAGEbnldYczxP8iRCwa1swHM3hmrS4V0kxoJ7yc
         eEXQC9XqYqhJV8jeCaM9LPoLNdHLMszYAjwWczfK/PhrGw0zWoaK395kMedHmSqPYLxf
         Jb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129456; x=1690734256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc6dwH/HvZi0vPM1tFTS6dfKlRz8fg7TW4Ttiul7pXo=;
        b=H0r9yX2aTnXTWxdq2t+GPsVtSjXu/aTI7NAVZg7XAEDgH/6eSv/ArGL+HYjX8+kd9s
         nP6M9E/d5lVpqyVgXEH4588hQ9ArQDSD5Z4rf1JYzmgUi5vbHmPwt9YhaIImiJVPdza8
         tz24O4Hs4crtzkWJxT1MUyIaZgUnTWeSurFfSptfkWZeLmCLpVmBoludXylHLKkVPZf0
         P+2LVDXrmZRHJocUONcXI6L8rOfyOD5s6F/ifCAsuON5NgoL5V/9o6lLWIJomcSg5f+G
         P+qw/4QHcb94FdkcTXk7Pinma95ytZv6NkD6OtDX0fFOsJ4/mrvq0H2b26YuZxg5cn52
         lzmQ==
X-Gm-Message-State: ABy/qLaSn9VfTCxJXYMfX3hoNV1Tynqo8Wd/C4jMpDcUMsFq8ftEslOt
        A3UjH22dSrH3iI2cdnb6Yq+hHoE0rgGb2Hth
X-Google-Smtp-Source: APBJJlE2LIEhv4TwrLv89WhImgtN33aINTKjugCYRMuka5B+iz826n/Yj1AYZ6ua1HiO/5qDvmWQnA==
X-Received: by 2002:a17:90a:fd02:b0:268:1b60:5031 with SMTP id cv2-20020a17090afd0200b002681b605031mr559501pjb.12.1690129455746;
        Sun, 23 Jul 2023 09:24:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090aae8300b00265a7145fe5sm6883787pjq.41.2023.07.23.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:24:15 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/13] clk: hisilicon: Remove hisi_crg_funcs
Date:   Mon, 24 Jul 2023 00:22:29 +0800
Message-Id: <20230723162245.35033-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230723162245.35033-1-mmyangfl@gmail.com>
References: <20230723162245.35033-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After refactor, no one use hisi_crg_funcs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index bd8e76b1f6d7..db2324309d41 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -11,15 +11,9 @@
 struct hisi_clock_data;
 struct hisi_reset_controller;
 
-struct hisi_crg_funcs {
-	struct hisi_clock_data*	(*register_clks)(struct platform_device *pdev);
-	void (*unregister_clks)(struct platform_device *pdev);
-};
-
 struct hisi_crg_dev {
 	struct hisi_clock_data *clk_data;
 	struct hisi_reset_controller *rstc;
-	const struct hisi_crg_funcs *funcs;
 };
 
 /* helper functions for platform driver */
-- 
2.40.1

