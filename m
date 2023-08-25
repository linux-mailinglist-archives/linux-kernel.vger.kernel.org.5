Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3378880B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245026AbjHYNCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbjHYNCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:02:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364B1BF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:02:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c7912416bso777782f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692968519; x=1693573319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DFV/goYyE2YU+Nf+xz4ltEm3HbbKeYmtkxzIRnmY3GM=;
        b=3co9yKuUy8bC0cbjmlIvAVt+czGBYRFbOFVRVLchE49eJaGBNK6c/YakJ4LNwlekue
         AURtvVyLGZzJHvp56WCHYketW33aZaRz4qjPspzC/c4eAyK5+J/bK1srRchVKS+YGHZX
         cJveA8kyTbpukVpV95HnGAG5PvTMAz2KoL2btgyq518JUQ9iMBBmi+jRPWHfZOZCevuo
         wamC+Tb6z61PRsdmmlEOTH6h4US/Ph2ofuMfTA1e43REiZ4anYJPxxN4HghUWpfEmwxY
         5Voc9xSSWj+OoqcBF7g2wgvdOQGj4yrbLKPU5zTImIxAdMsogfw2dRPJq/aMkdrc55FM
         jMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692968519; x=1693573319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFV/goYyE2YU+Nf+xz4ltEm3HbbKeYmtkxzIRnmY3GM=;
        b=YmJDm63H/jqusHqGIXt3yGsDseyxaZ6rUk5GAAfnUduYkAEtDEuAZjW6w8H54SktFJ
         tnp4hYQj+msKQck5jY4wwpIYP4VdfWJwZfR5WJF5GcRSJ6GA3wh1G/+3V7o3P+peI1aN
         lNei96iWcFvbyxrIKAWJBI6A8JbFsTLhc7P0ZdxuIt0Ye7IEkm9UA2YQ83UYnfda+yB8
         VIPtMKa6Yg+SER6Z3qb9njtqNerT7sBqO5vUAzOhA5/5uhfYZ7oO385S47OY/TS3gmQH
         3lMYNahSKr5sTgQwnX/NgqKluLdiejdTDIXxK4+4/DBaLc34oOoXpPAXFbDDD5E1frE6
         WboA==
X-Gm-Message-State: AOJu0Yyh5iWTp/Hya5SiZNhTH89EUVUU/2KET8OKq6wuZvtak6eNWVrE
        s576BGPSPlKArMg52Hks0ImwGg==
X-Google-Smtp-Source: AGHT+IGniOVACE2N3laf0pptx/IciY6qg5umP9YiIhEJP11jMTlXMDD/MCRTFkXOMe+R+eutFs7TGw==
X-Received: by 2002:a5d:4450:0:b0:31a:e972:35fa with SMTP id x16-20020a5d4450000000b0031ae97235famr13601890wrr.61.1692968518783;
        Fri, 25 Aug 2023 06:01:58 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5caa:2f18:428d:7bed])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6411000000b003197c7d08ddsm2150130wru.71.2023.08.25.06.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:01:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.5
Date:   Fri, 25 Aug 2023 15:01:55 +0200
Message-Id: <20230825130155.11639-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull two more fixes for the GPIO simulator for this release cycle.

Thanks,
Bartosz

The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.5

for you to fetch changes up to 6e39c1ac688161b4db3617aabbca589b395242bc:

  gpio: sim: pass the GPIO device's software node to irq domain (2023-08-23 21:05:28 +0200)

----------------------------------------------------------------
gpio fixes for v6.5

- fix an irq mapping leak in gpio-sim
- associate the GPIO device's software node with the irq domain in gpio-sim

----------------------------------------------------------------
Bartosz Golaszewski (2):
      gpio: sim: dispose of irq mappings before destroying the irq_sim domain
      gpio: sim: pass the GPIO device's software node to irq domain

 drivers/gpio/gpio-sim.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)
