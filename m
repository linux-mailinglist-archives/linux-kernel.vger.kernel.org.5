Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9245760422
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGYAkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYAkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:40:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5AA10F8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:40:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5577004e21bso2018727a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690245646; x=1690850446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJKuxFWSCWcxrpIbwE2dsS6yrYr3DSEy+K+qzjCR4Lk=;
        b=l7xvwTPERLpVvpQQOA4WRpuVk0EuJsgNwRQcR3ONJJsnjusafrjTwvgqUddBw4Wuh3
         BmRedeIM1hSUMspYRBmjkGxjYLDJEqbay+FwFo1Q9dvcHHfVhl9pehB9LoXpozEKnhRX
         lQo8f+NtlifbPya6IiRrMFhKKRReXp4TsJ7kYVqpdAH8wCgrV0fmTz90qmfNEd4eibVY
         5PgnFKtiNUMPPs0s8no4sflNGsXYaEl0X0FahJOt2IAnSPrA5DJLa01vafOTj6HvFOoi
         FLL7+CGmvCIDcRvhEjSwGlO82XHwYPeKazIdmMz1mT4a/fghYeAJ5+VPdHtr8KA4vzJr
         n/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690245646; x=1690850446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJKuxFWSCWcxrpIbwE2dsS6yrYr3DSEy+K+qzjCR4Lk=;
        b=iwwI9Niw1j9aze0ggxvzNBBh3CFu5sKYGsACuU6EbNLZVIB2zVscvTHTQMbBsOgtpo
         z7dJGJZLuDPo57uFtKCJLgeOYkmkdeWeXlAnWn26PzREAcnzrVrLPVDYAIaUktuFmwwD
         HAOyD4OU+KSj7/t+bmYpRuWuq5Yf7e2+ZB69auSLf5iXXTsRXr4KHFli3Mg6zpCqLBBT
         7v5RVOkFto1O8oWm59/4TTcu5FhBDRAl94T36gEJaBAc1hDtifyozmFyFbyphU94elh+
         mHnNyhOg5sYb4eyrXSnSnz9FOuzdh6azKVaBLUzvFGL5yPtvG8TwGfa4qUxU3bMw4MtT
         YkNw==
X-Gm-Message-State: ABy/qLaeloegLI5HuAyYgNM06edFsK11ITo9nNEdS2yHO7WGGmeeO7sG
        Dl5ISR7X9Lw2+zSKNErHpt1PrA==
X-Google-Smtp-Source: APBJJlFPb8LJJqI+24wS8Kl8vPzsOO78+Laoq3nKP3BBOg08DmgXv0tHgVQiYwYl8RCqUvPRzBE8VQ==
X-Received: by 2002:a05:6a20:1053:b0:137:23f1:4281 with SMTP id gt19-20020a056a20105300b0013723f14281mr11113757pzc.12.1690245646421;
        Mon, 24 Jul 2023 17:40:46 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id be11-20020a170902aa0b00b001b8a3e2c241sm9528297plb.14.2023.07.24.17.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:40:46 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/4] gpio: sifive: Module support
Date:   Mon, 24 Jul 2023 17:40:38 -0700
Message-Id: <20230725004043.381573-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the call to of_irq_count() removed, the SiFive GPIO driver can be
built as a module. This helps to minimize the size of a multiplatform
kernel, and is required by some downstream distributions (Android GKI).

This series removes the rest of the of_* API usage in the process.

Changes in v3:
 - Use dev_fwnode() instead of member access
 - Mention the SIFIVE_GPIO_MAX check in the commit message
 - Keep the variable for the parent IRQ domain
 - Add a comment explaining why the IRQ data lookup will succeed

Changes in v2:
 - Add 3 new patches removing of_* API usage
 - Add MODULE_AUTHOR and MODULE_DESCRIPTION

Samuel Holland (4):
  gpio: sifive: Directly use the device's fwnode
  gpio: sifive: Look up IRQs only once during probe
  gpio: sifive: Get the parent IRQ's domain from its irq_data
  gpio: sifive: Allow building the driver as a module

 drivers/gpio/Kconfig       |  2 +-
 drivers/gpio/gpio-sifive.c | 47 ++++++++++++++++----------------------
 2 files changed, 21 insertions(+), 28 deletions(-)

-- 
2.40.1

