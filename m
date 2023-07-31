Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88454769602
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGaMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGaMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:20:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9481999;
        Mon, 31 Jul 2023 05:20:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6873a30d02eso571628b3a.3;
        Mon, 31 Jul 2023 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806001; x=1691410801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc6dwH/HvZi0vPM1tFTS6dfKlRz8fg7TW4Ttiul7pXo=;
        b=c9rM4N3XAMIYk/GDJ0fShaYJkUjFCtpEaWMRncbNs2Z5tM7drLfNkRiZX5xBwyGgIj
         sAuIUeLx03+psHN+7Hh8iqVfRbWy/biG4hZyicnGK57LhW4zsaTkhF/Y7XVyqLn6MQyE
         IvyP6xgt6Dj76Yhtl7hYhBWdDivKYkJRvaPo7fUMEH+zWr+NZj0ETNtXi6fPHXmFC15A
         67w/2z1kY/pQEKaxOG43iagRBTfzDr+DXScv0WgRl+ODNkj/DlZkn2d2eiXrhK7eCOzR
         SufDRIqs3T+potr3JP3mN1Q/JKMwZpdwRLZnPVbBZVeMS9nVsT+Sti1m6pY/c0YBu6Yc
         SJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806001; x=1691410801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc6dwH/HvZi0vPM1tFTS6dfKlRz8fg7TW4Ttiul7pXo=;
        b=OKxqkhkxeQByjeF2z+jiNboXvbooHf88E76L77wjPokTPOzWy/OfgSTxBr9qOuSESj
         u/iwDRRHP8WjikOM38zMft3eOBz43Yf8bZ9QBvbZvPgOtYfATguV2dV9Sx0mZb37Ardx
         CrpJl5OEMomLqv2uzLEOY/Uog319e65b0Bt7IBzTRP0xIBezWwXCcxZmEAFZjmxZHdzC
         Mw5+kni6kuR4T4EFie3Ge1f95L+PhT0toCW5VCuI+smmr1QbGL21p39tjKutheOC6F4R
         SLxROLqdinYDFESIeb8lN4c63xO8Z2wbMmmCqbE5bnnFQP3tBRz+3xYCpJwN5LTEXaZD
         KMIA==
X-Gm-Message-State: ABy/qLagIGLWX9uDXBCpFZhdmR4/BqQUbGAd5Aq9Mst3GEovFnUCWCXr
        ZZekEJSOfQZxIDB9gmqGifoLY8ev7jEaKkmR
X-Google-Smtp-Source: APBJJlE/j3zHpInzQCGWkQQe0zAwy2uqJ53xJUV1YeAlKdZp+HQ9K8cZJ1NhL3Fl2q5l0BuOtxhuWA==
X-Received: by 2002:a05:6a00:ac8:b0:666:a25b:3788 with SMTP id c8-20020a056a000ac800b00666a25b3788mr10518653pfl.34.1690806001300;
        Mon, 31 Jul 2023 05:20:01 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b00687227dd8f1sm3529559pfn.122.2023.07.31.05.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:20:01 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/13] clk: hisilicon: Remove hisi_crg_funcs
Date:   Mon, 31 Jul 2023 20:18:04 +0800
Message-Id: <20230731121821.22242-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731121821.22242-1-mmyangfl@gmail.com>
References: <20230731121821.22242-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

