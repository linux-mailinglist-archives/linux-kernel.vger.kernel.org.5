Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C0756EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGQUyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjGQUyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:54:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79D510C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:53:59 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b730eb017bso3386038fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689627239; x=1692219239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyy/hqOdv+k0nTAkjs+7RYMgFYdulT0nhGoNzbzeMig=;
        b=KJTf9YmZ+opwlSlKQtj4qmVAgcviWKLlE18bPJ9PK2xx2vbd1cglf/B19eHyMCF/iu
         Eo/LO0A/WooxN5UAWv3ScN8m/gCHPScAd1o8ZsTnssQOVautf5+DNwlXfqz2MzgkWZ/e
         bX5C/SPhH1uy1+IfbnoAxp108QlYMtrHQK59JmnuHeuXgWbVGu3YO42QzGuG5u7RkEdr
         oHzNxQ4hcPd/NvOcdLGlAatT1hr1aZ0yu1Letu3MtHfILsfG72e/s4DAm48dG6rMbobc
         NpbivKFS98tExj0Qk/X0qClcS/8nQ5Rz0KBZRGMZH8gxRbYknPYghwWTPxJqFzB+Soz4
         MlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627239; x=1692219239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oyy/hqOdv+k0nTAkjs+7RYMgFYdulT0nhGoNzbzeMig=;
        b=HOq+JEZrSHAeIa1WqpWTHZoDLo7kNe8KRXBeVPMtyZSke24Orqk2Ef0ZiiMmHyoQUQ
         21IRqmkh+GJ27FaMXfHEoeQtmYJoAuORFTwJWMLXxC85Q/qSP4O1KGHUn6VOEG5z7hFT
         48++RZcv+QHDY5uYurJNacAcNyrxcMlQHwzeWPg0yTgXNMbOh5tR81r6r6btgUUFtFfa
         2rQh1c2rNTRTTgDzmww9BqxJvJNXrbF5EMhRkzLEeqtvbZvBv1vS+A5VwhoB4xYlPMAE
         Cr83eyr7I8dG0guVldBFkoKTYyDRCBAOEnSdWYJ4THEio8T+BBW/DBw3qENGI+ZRhB4B
         X6Vg==
X-Gm-Message-State: ABy/qLYj0LoX5BQR3+m5LYa4t66N5AltELc6Wj2FsOSjnLaHXW/PhDvt
        FqS78v/SXdDrp+2SDA3bka58z9q6c2fBwhjjjJX66w==
X-Google-Smtp-Source: APBJJlFdP1Af7JGzTPtkK/vllQtffloe3sX9PaU93xyPQ8qir6P/+bH6Lv7otG/v4/4fcg4rtzqtJg==
X-Received: by 2002:a05:6870:fba0:b0:1b4:4a2e:b698 with SMTP id kv32-20020a056870fba000b001b44a2eb698mr13093826oab.47.1689627239068;
        Mon, 17 Jul 2023 13:53:59 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id z8-20020a63b048000000b0053031f7a367sm206991pgo.85.2023.07.17.13.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:53:58 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] gpio: sifive: Module support
Date:   Mon, 17 Jul 2023 13:53:55 -0700
Message-Id: <20230717205357.2779473-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
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

With of_irq_count() exported, the SiFive GPIO driver can be built as a
module. This helps to minimize the size of a multiplatform kernel, and
is required by some downstream distributions (Android GKI).


Samuel Holland (2):
  of/irq: Export of_irq_count()
  gpio: sifive: Allow building the driver as a module

 drivers/gpio/Kconfig       | 2 +-
 drivers/gpio/gpio-sifive.c | 4 +++-
 drivers/of/irq.c           | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.40.1

