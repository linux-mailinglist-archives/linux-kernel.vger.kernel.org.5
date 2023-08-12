Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B3E77A203
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHLTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLTpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:45:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14781709
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e742a787so1765860f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691869508; x=1692474308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58x1Q5PXg4LmCs7Zt6A8vNervxpOuXS+29gXX7Wk/wE=;
        b=Wu5qAQi8RPEmsxZcqMUV4nhTMFVjI2ANFIFNY9ZKsMA25rom8T6ACLbzKCYt557gDl
         yFpyyOw8QN41RQGiRfcr0ZGxXTaxYSWN4IFuD6q/WD7i99058BtojVl6sbQm7cJDU26P
         J2YMPUnq/MpaFIi1mZ914QSuKApXr9CAnY7xZ7e/6iC98/sWzpzKLKYjWteEEI2Q/AB7
         3nADBO15z5kyojiGtnIdl0s6SAhDmnj+egz5yUukFcOBsFi5JrGH0z7/X1rXHdrUPTVm
         iz4cNTLdBPj3RjsmQsbPkWJ4OkqoxQMnlnctP+2oBy9XV9inmb48vYN3FNKrUBO5DTrW
         B2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691869508; x=1692474308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58x1Q5PXg4LmCs7Zt6A8vNervxpOuXS+29gXX7Wk/wE=;
        b=XdKPsQrRVozWuoUD+f/QSA6TzPKYspT7v2bXERGfeogZ5dH5eg1klCQb46HlqDE+Xp
         qcW2QuQlcFfWtaqeF3YC+WEFqwUKarqK7gJtMcvamsrDIg2bkJvEAK13Tu9ngZMF5vXs
         64XM1nH3UK+K6GxJI2WIzvy9yLlz6OwmGzgWRDJ9X+0EYjIJBd5j9ISWNDJHwg3mIJKs
         nSTNWKceodBdaMPBuRJLos4+X7Nq40QdD1e/oXcV0M3jSfI94nnzOA9MYe8YT7DhHg4L
         VoBxFTEuZLr2L36H3U3On+0yaqdIWhILkvYS6izxj9bXZNr/UZGZQ7zGMGpUgNptTdpK
         NA9Q==
X-Gm-Message-State: AOJu0Yw/+oop7n/3lSmKHMCFIUS5tahlIjIgL+1dItSWlAkxthwR1nD5
        5A1gtUq59OOaRHkI1EBKt2FObAISQBQOpLzF8nJLZg==
X-Google-Smtp-Source: AGHT+IHUAQXcI9KN5/+L0YXVKz7/T2pDgm3XLnLaUTU0zCnfxqZdu8ZJS0oIrBEGGA91rAKefWBN+Q==
X-Received: by 2002:adf:ff8f:0:b0:313:e391:e492 with SMTP id j15-20020adfff8f000000b00313e391e492mr4499429wrr.17.1691869508243;
        Sat, 12 Aug 2023 12:45:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id y7-20020a056000108700b003188358e08esm8813765wrw.42.2023.08.12.12.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:45:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/4] genirq/irq_sim: fix a use-after-free bug + some
Date:   Sat, 12 Aug 2023 21:44:53 +0200
Message-Id: <20230812194457.6432-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The first patch is an issue reported by KASAN. We're accessing freed
memory if we remove the simulator domain with irs still requested. We
must dispose of all existing mappings before we remove the domain.

The following three patches are some improvements to the interrupt
simulator. A simple header cleanup and code shrink using the new
cleanup.h helpers.

Bartosz Golaszewski (4):
  genirq/irq_sim: dispose of remaining mappings before removing the
    domain
  genirq/irq_sim: order includes alphabetically
  bitmap: define a cleanup function for bitmaps
  genirq/irq_sim: shrink code by using cleanup helpers

 include/linux/bitmap.h |  3 +++
 kernel/irq/irq_sim.c   | 38 +++++++++++++++++++++++---------------
 2 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.39.2

