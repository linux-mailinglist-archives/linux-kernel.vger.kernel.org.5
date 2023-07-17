Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A7756EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGQUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGQUyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:54:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371E10C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:54:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso3061544a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689627241; x=1692219241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPXSCcl7xyJKFXuJ0sfDEh5nIT26utMEmgdVi+YRduc=;
        b=VzNOXhf+impRuQDbYHrHRlqKEi4dq4XPmar0nNzv6mvU84AiDYv9Z8hDwrbcuh/mS0
         AgX5iAz4at+qFL9Qlc9V9bUmdwa+KLbCIrTMUe+/rwDoMrjNS01UNaZCPQPFEYNXMfGq
         XrOpEMqW2ID2b5Kv7fLAl/V9ydXP2MBLtM4tZYZkv79U6vGznTx8gSRmlBPtNuu83jN/
         +CZvicmJK8bHZurlYy33pU0fBP0I6KRiOPK42VmiMb77zsTfwcERc3OiLqnHUiPRx0Od
         41lB6iSmwxSSceokNRnKYx2C1p2NehPKLu8wdS5NoDzDgEpmu7ywu/phkTrFWHNF6ApV
         tLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627241; x=1692219241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPXSCcl7xyJKFXuJ0sfDEh5nIT26utMEmgdVi+YRduc=;
        b=DpXUHIcNAqIUi52SWbM1TMxM8VpAiWFB2H8E8kp8sCtB3ZUxBCVlBuPeAvkMDx7OFy
         ixqZUQkDtZdEZrLeNB75xMFjDF4doQXgMCWl9eXJvGiVDh6EDhjbGmwbiNq7e6TtC1f1
         YNNwGff3ssfx3NgQlFujs/bJpRCAsXOXYKF9gnGoeWIP15RgRsUcoFWunUexRdcpM8Yi
         OU9ZJm3vYfbPTaul28zxFNcM46zDEVf/BaFlIWvGIkdHHcZ708sZjsujurtGh04p0Fed
         VeDOeQ71DJVKq2mDINeZY1Oekm6fj9bvkp6nAIqESLesKH4S0wqB1V2wApZbvz3n4eT6
         tOtA==
X-Gm-Message-State: ABy/qLZpUC/ek1Usct/t65G6wZe64e+efcshFd5bASWlEhZjIlAVcWJ8
        CmwP0EsbHmv4kH8pL6LJV6r9EiTWq0dBLQ9GlGlIQw==
X-Google-Smtp-Source: APBJJlFbe5gZF2ECwUGmiCHxgLHRY+XuBGqvvTomAJ08QQZ91YYr4KT3oREW1N/N6BFQf7ttY64AMw==
X-Received: by 2002:a17:90a:a614:b0:263:f3d0:7ea2 with SMTP id c20-20020a17090aa61400b00263f3d07ea2mr13459056pjq.8.1689627241539;
        Mon, 17 Jul 2023 13:54:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id z8-20020a63b048000000b0053031f7a367sm206991pgo.85.2023.07.17.13.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:54:01 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] gpio: sifive: Allow building the driver as a module
Date:   Mon, 17 Jul 2023 13:53:57 -0700
Message-Id: <20230717205357.2779473-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717205357.2779473-1-samuel.holland@sifive.com>
References: <20230717205357.2779473-1-samuel.holland@sifive.com>
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

 drivers/gpio/Kconfig       | 2 +-
 drivers/gpio/gpio-sifive.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e382dfebad7c..1a8e8a8c85d6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -564,7 +564,7 @@ config GPIO_SAMA5D2_PIOBU
 	  maintain their value during backup/self-refresh.
 
 config GPIO_SIFIVE
-	bool "SiFive GPIO support"
+	tristate "SiFive GPIO support"
 	depends on OF_GPIO
 	select IRQ_DOMAIN_HIERARCHY
 	select GPIO_GENERIC
diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 745e5f67254e..5941a817491c 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -277,4 +277,6 @@ static struct platform_driver sifive_gpio_driver = {
 		.of_match_table = sifive_gpio_match,
 	},
 };
-builtin_platform_driver(sifive_gpio_driver)
+module_platform_driver(sifive_gpio_driver)
+
+MODULE_LICENSE("GPL");
-- 
2.40.1

