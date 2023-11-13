Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1B7E9CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjKMNR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjKMNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:17:57 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD4FD6D;
        Mon, 13 Nov 2023 05:17:52 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2ea7cca04so2722162b6e.2;
        Mon, 13 Nov 2023 05:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699881472; x=1700486272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMYVHHaJeCjmpAavU23RMpRyLk0TWskkcBNgC6viZA4=;
        b=g6tm2kPdHEfk79n/oIuAzWgzZcAfeG2dUseu0MiZKS0OB0G6AGYqX4bL+Nf+SGhEqn
         GoNFNjqeLfewtQIA5gc2nv/85wqRhW29DG+mfY/5KSYSX7Bdil4gjabIpISwbcDc9gvH
         rpbT5b3OAQSKvKL/s3sQ2d31wCqs3gditoTu6KtELLWTjzpoSfHSWe5Zc7ANF3nOMUFz
         gE0opy5GD24g1j//raiCy8qtuoS/rD7R0wOhrh+T4YdYdNQzmqaqotfs8p5V7qMs3uVR
         sIa8AefuIb22YnMydb/KJLGUupc9zMXzgqXh4LXaURZL4nS48e9WfF4JWvcGVLod+1/Z
         r7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881472; x=1700486272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMYVHHaJeCjmpAavU23RMpRyLk0TWskkcBNgC6viZA4=;
        b=rf9EnKDbjPVZUgMze3FKsQXqZrMCo15FOq8jzQ6IQrdVVoN6VFAGBq8sZwDLt54U7u
         r4NZ6iAPsp7P2GClUtw1U+Dx8D5zwc46+0++2t7IyN+ctsmc9Nb5LnsQY03asVGM6G6m
         iatgOTNvz4PmJ069fscytk9jmrLuXXkjFP1z0IYDwYN6hwS9AMvvJBL79wYAloBqHW/C
         4wuhXmWJ2kdHhIJ7ROYF4fecGm5NZOiWcCUYZgV9V8QiA35Ne3baPYSdpErKW7LpWhPB
         E08zZZHBu0jdxDPr0P0m3nEcKwtju6ySrUWsYm/icLZuOLZcQNcSiqO01vAsBT0nprPf
         HM+A==
X-Gm-Message-State: AOJu0YweEhmZdsuaoSAz0gS/cjTNm4kE6gQOlsc/G6/E9YuVHx2g8uxm
        kVr43jAB3BYaWqAvdaeIYEY=
X-Google-Smtp-Source: AGHT+IH2iVeNtxuhSNYqil+kIbOodUzZxXB+mr47hLTS7HskUTvpMjqRwlUgtDQCXwNRY57D0S0omA==
X-Received: by 2002:a05:6808:b13:b0:3a8:6b4d:6b78 with SMTP id s19-20020a0568080b1300b003a86b4d6b78mr7628082oij.35.1699881471814;
        Mon, 13 Nov 2023 05:17:51 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id g34-20020a0568080de200b003b2df32d9a9sm773426oic.19.2023.11.13.05.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 05:17:51 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 0/5] riscv: sophgo: add clock support for sg2042
Date:   Mon, 13 Nov 2023 21:16:36 +0800
Message-Id: <cover.1699879741.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
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

From: Chen Wang <unicorn_wang@outlook.com>

This series adds clock controller support for sophgo sg2042.

Chen Wang (5):
  dt-bindings: clock: sophgo: Add SG2042 clock definitions
  dt-bindings: soc: sophgo: Add Sophgo syscon module
  dt-bindings: clock: sophgo: Add SG2042 bindings
  clk: sophgo: Add SG2042 clock generator driver
  riscv: dts: add clock generator for Sophgo SG2042 SoC

 .../clock/sophgo/sophgo,sg2042-clkgen.yaml    |   48 +
 .../soc/sophgo/sophgo,sg2042-syscon.yaml      |   38 +
 MAINTAINERS                                   |    8 +
 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi  |   76 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   10 +
 drivers/clk/Kconfig                           |    1 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/sophgo/Kconfig                    |    8 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sophgo-sg2042.c        | 1259 +++++++++++++++++
 drivers/clk/sophgo/clk-sophgo-sg2042.h        |  226 +++
 include/dt-bindings/clock/sophgo-sg2042-clk.h |  169 +++
 12 files changed, 1846 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-clock.dtsi
 create mode 100644 drivers/clk/sophgo/Kconfig
 create mode 100644 drivers/clk/sophgo/Makefile
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.c
 create mode 100644 drivers/clk/sophgo/clk-sophgo-sg2042.h
 create mode 100644 include/dt-bindings/clock/sophgo-sg2042-clk.h


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.25.1

