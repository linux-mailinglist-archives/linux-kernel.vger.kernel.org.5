Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0267812D03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443658AbjLNKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443655AbjLNKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:34:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D2E3;
        Thu, 14 Dec 2023 02:34:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-336353782efso2008381f8f.0;
        Thu, 14 Dec 2023 02:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702550051; x=1703154851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9Bav5GT9+DiIlOayf2xo0fOPFAMpMbevtPaUgb/OCo=;
        b=nQaKIJ/P/Ugz4s7qKSZc/YfLwNHCSF9O5XHwLccAEDkVb9f+j9oaNGRpTQ0u68ftgc
         BZFQAs134IMIxTLn247Vk2zKNv+KVz+diTr0yByYzZ2XNZljeZ4aDEHAjhSoyiYJl7K+
         dQ3wyjdi52wnt9R2XwhmUyOz7iT1B62ALqeAi3+bGfRyFtbc1xoum+QGsmpMj1+cF9mr
         aN5bPUT9E0cRfBmtzE+WJZzS1qMy1pUlHfrlJMTnLRubEjxhiNHNmxjWFvrNqxehNVLT
         R4yMXV8puqeXhNAnY8m/KATU0bdJwpKWD0TNuerNxie6T2LMzgWXDLLWhrpekmPWasce
         EKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550051; x=1703154851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9Bav5GT9+DiIlOayf2xo0fOPFAMpMbevtPaUgb/OCo=;
        b=VfB2Y8sYNyqFvqjVronyaMbwlPa08nQg9+0HnqgrgYnreMTCJfq38HbywptWOvnWKw
         mTNcBc2uNx5+umZHOjX3bgfEISW4uf6AGY4geuHZLdu8TLwv+9Y2txY7uhym8/l0G07d
         8S2Hzn3wQPUWXXr7n62R6+eQd068zmeC5G89yJEJbTGebbTWO95sBJ5a9fV2VWbNie0O
         +8wFLWwla1HRtn63q7GgoUPDzwWo9bjO7khpaiQzyWSLyZizCN/+bGJPyfZfEYjHnEjp
         yHYADLKobJd/kNnuztqKfGLe6jyFBH6Ga+6UF6DmJu3KtHKneBmpiIJGAsdyxZo7oD4I
         BeAw==
X-Gm-Message-State: AOJu0Yxlt+X1dehB7q6cNHTLaG8yBzp89Sn1aLzIVmFmOvRS1HthX3k6
        kR2cpAXm8+YibGhBqBWRdaM=
X-Google-Smtp-Source: AGHT+IHU8zAZ+E9+PZta62TwukgImvaSq5gWkMu2b2zX9JqnUFdExGM5t+FRMov8SdJb0wP4JxqGjg==
X-Received: by 2002:adf:ec8e:0:b0:333:2fd2:51d1 with SMTP id z14-20020adfec8e000000b003332fd251d1mr5060094wrn.74.1702550050755;
        Thu, 14 Dec 2023 02:34:10 -0800 (PST)
Received: from localhost.localdomain ([129.0.226.240])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003333ed23356sm15849623wrw.4.2023.12.14.02.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:34:09 -0800 (PST)
From:   Brandon Cheo Fusi <fusibrandon13@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH 0/5] cpufreq support for the D1
Date:   Thu, 14 Dec 2023 11:33:37 +0100
Message-Id: <20231214103342.30775-1-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for cpufreq on the D1 SoC, and a new
Kconfig.riscv file to cater to cpufreq drivers that support RISC-V
SoCs.

The changes have been tested on a Lichee RV module.

Brandon Cheo Fusi (5):
  riscv: dts: allwinner: Update opp table to allow CPU frequency scaling
  cpufreq: sun50i: Add D1 support
  cpufreq: dt-platdev: Blocklist allwinner,sun20i-d1 SoC
  cpufreq: Add support for RISC-V CPU Frequency scaling drivers
  cpufreq: Make sun50i h6 cpufreq Kconfig option generic

 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 18 +++++++++++++++---
 drivers/cpufreq/Kconfig                       |  4 ++++
 drivers/cpufreq/Kconfig.arm                   |  4 ++--
 drivers/cpufreq/Kconfig.riscv                 | 16 ++++++++++++++++
 drivers/cpufreq/Makefile                      |  2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |  1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c        |  1 +
 7 files changed, 40 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/Kconfig.riscv

-- 
2.30.2

