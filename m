Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B246E7A74F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjITHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjITHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:55:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E3AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so1344639a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695196515; x=1695801315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGDCfnqXibL8P7HWdYQ5TW7hswKggfJCYqa66wlaJhg=;
        b=Mb7rOeFeBZSHs3XX3qqDrNfP13N9Gt+dCxYF9fyXBNYCDSBATVuBzCjYAUVsPvFOLh
         c4qDRfGqTYa1V2Tez9G3jqa/Re5e3hojv8wnC990Okps2pQg5cxusE4fsBEJYeolgCRw
         sdYA+oCCqtLp29mbqBZOY8JlWcqjqGMtXO54GATGWNw2enHkGwpedBKch/28Gk1oAkc+
         vbW+xA6jcvG9fo3XjIi07kr1WJTMFSF4aYktx1Tx+0Ht0EIwjiqgqdZq38koCSXbVEZ4
         XsMu2cztzopqjAAGvZhPiP3sNvcIABOKSgD6JcLUNfKktqo5E8bZQyvOMhL5JG9dborE
         OPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196515; x=1695801315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGDCfnqXibL8P7HWdYQ5TW7hswKggfJCYqa66wlaJhg=;
        b=g+Q8cSJQkE0s8S7Tplpo/9+ZeyohainSUu8/43xBTdqUen/TJ1JDjoz81v+JGaaB2H
         0WIXmcO6kVt2W2J00bauXiePjnEbANe0Nj99EX8A8aWNP4UgymLhaPO+cscZRKCgot5a
         eaPVfuDoYZ0GumfAn5Fo0PX3V9Me2u+t1J1STIDqsW2w06UUQ0uaiO4mdM0rS20T/Lcb
         tVlTjPp6XYjy7SPM+JZI9W6S+eemQkd030e3LE81i4h7cocEfAH/qqSssuD7CDBnCNV9
         J341edeKEGUapT+u6LEXQktqEfmqYF9FjB+fooHfAa0sgzVgQtKxaBmpk7dS5DUYykgu
         S7uQ==
X-Gm-Message-State: AOJu0YzbcBlnO3CwpZPyZa94IySLxwn2ZqwAiP+0aJTUE450z/sAi6RZ
        tFNpsUQYAo/qMbNNJtPCnrF41w==
X-Google-Smtp-Source: AGHT+IGi5J7F6JsYv3Pv9nwyZN8aqN7q6M2AsOi6Btb3hjM0M5kM2nPkjKi01dZCW16mj5qpF7Ytaw==
X-Received: by 2002:a05:6402:3222:b0:532:ebf2:6231 with SMTP id g34-20020a056402322200b00532ebf26231mr2018704eda.21.1695196515534;
        Wed, 20 Sep 2023 00:55:15 -0700 (PDT)
Received: from brgl-uxlite.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id d9-20020a05640208c900b0051bed21a635sm8481981edz.74.2023.09.20.00.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:55:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/4] genirq/irq_sim: misc updates
Date:   Wed, 20 Sep 2023 09:54:56 +0200
Message-Id: <20230920075500.96260-1-brgl@bgdev.pl>
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

Here are a couple of updates to the interrupt simulator. Two are minor:
remove an unused field and reorder includes for readability. The third
one simplifies the error paths by using new cleanup macros. To that end
we also add a cleanup definition for dynamic bitmaps.

v1 -> v2:
- add a NULL-pointer check to the bitmap cleanup macro as advised by
  Peter Zijlstra
- initialize managed pointers when declaring them to create a clear pairing
  between the type and the cleanup action

Bartosz Golaszewski (4):
  bitmap: define a cleanup function for bitmaps
  genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
  genirq/irq_sim: order headers alphabetically
  genirq/irq_sim: shrink code by using cleanup helpers

 include/linux/bitmap.h |  3 +++
 kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.39.2

