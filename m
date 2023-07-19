Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4C759AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGSQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGSQet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:34:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1864F1BB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8b318c5cfso56207235ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689784488; x=1690389288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHD3s3Vv6K0BaM5EQ+IYYZEfsrjIJcH2yFqvTWy9ha0=;
        b=ZCsF62F6DzCb43m0ibFaEfnlJcU8sX/vUpG+pV5DIPQVyidywfnCi1lnyoPTKPPPmK
         LF0oBwTcENyStWLvAiUL/rJ0Hm0SO8je9WfYui6+niPD4ndOFHyDgdvMsPENOlBcOKwQ
         j5zsB5LP7VTXIJLD2g5bKyU7kFZObPep8lrqFsEM1KAOBirKzOiRu7jXTZUnIK6KAGDX
         5QVJxWN8s99oI3eGBVpT+w9+9LGD3wnUqFC7RzeEo2pXyvW2QKW6Qip4/MZuzf4zrqIz
         CiZe3uCkCpN1Y1r8ShIge3v+scaAdCHSugF/ACFDa36MxfsuClkBIIB2r3ZOX9Cvk5UP
         4DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784488; x=1690389288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHD3s3Vv6K0BaM5EQ+IYYZEfsrjIJcH2yFqvTWy9ha0=;
        b=a+hohzn70NjM+bP6u7JIQB3/BP7F+UDt+vCgvBIGH3tt2iaZST3/PS5itGY37g4/Zp
         90EniCxw4ihVNe4pdEjfqUH3xCdcAOmtSWbXFitm2hJ8Gt28ZMAgJUbUi1qGwvqnVJyR
         KyK4vZvnQT2cjwkgHO3D1a8GMIc2WYWZBqYBHYe1AXa2SKpWYGIkWXBH9nPLWnIw9FZU
         Eswr2RtA+j9dscwq61YHBw67qoBD8gp1tVp9EPzCV22N+WL37Bpni0SBEidCQEEt3RnP
         LKOfaehIUHcE8baUa++J814CFZM1fcOeeulzo2u0qkwLBPB6AaduMV/Eqzur+8G/+ifC
         9GWw==
X-Gm-Message-State: ABy/qLaZsCcBEkYf8iK8ExfrSLU2kBBbyJKDbINxONRmFtELYlE65w2+
        twpzaK0Fk+/0v9UMAXHE8Ogw4w==
X-Google-Smtp-Source: APBJJlFy35TVoZNTEgWdHT4WsoV1Tt6FWOxXOKMX8NuNrnEj2LUqFscu2j0yVJUDskROheemv4v2kA==
X-Received: by 2002:a17:902:e88d:b0:1b0:f8:9b2d with SMTP id w13-20020a170902e88d00b001b000f89b2dmr21365359plg.29.1689784488451;
        Wed, 19 Jul 2023 09:34:48 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709027c0600b001b0358848b0sm4199276pll.161.2023.07.19.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:34:48 -0700 (PDT)
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
Subject: [PATCH v2 0/4] gpio: sifive: Module support
Date:   Wed, 19 Jul 2023 09:34:41 -0700
Message-Id: <20230719163446.1398961-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the call to of_irq_count() removed, the SiFive GPIO driver can be
built as a module. This helps to minimize the size of a multiplatform
kernel, and is required by some downstream distributions (Android GKI).

This series removes the rest of the of_* API usage in the process.

Changes in v2:
 - Add 3 new patches removing of_* API usage
 - Add MODULE_AUTHOR and MODULE_DESCRIPTION

Samuel Holland (4):
  gpio: sifive: Directly use the device's fwnode
  gpio: sifive: Look up IRQs only once during probe
  gpio: sifive: Get the parent IRQ's domain from its irq_data
  gpio: sifive: Allow building the driver as a module

 drivers/gpio/Kconfig       |  2 +-
 drivers/gpio/gpio-sifive.c | 45 +++++++++++++-------------------------
 2 files changed, 16 insertions(+), 31 deletions(-)

-- 
2.40.1

