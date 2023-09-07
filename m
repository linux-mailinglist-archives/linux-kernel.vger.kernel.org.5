Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E986F79737E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbjIGPYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbjIGPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD019C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:23:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso12303815e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694100226; x=1694705026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzpZWHat+ptY4i8T7d70uw7fEAXlmofiE9gJ/p0X22U=;
        b=bmrv0xMyqbFflvoBmZBsnRl1OfzXANV/mlYS+11jSA34y3SIpvfVQ/8A9odQJ8glrK
         diRPn7hmNKNnjYYyDRTpeejusH8Avd6amb8Kt0Ad7yTpHqf7lHU8EXDGl9vcgrO/2oRt
         exhoWCKA53D6vZfuzHGkT+Z6vw1jOrokLKlqUgdqs6LHOsQaog7g+AGQTANY0ci8NF7c
         3PwTXnc8MUqs3+/qbU5rRpiU9wWTnwiemey69uv5TUgwwF+++g6iwqD5Jxwp1dwx61+P
         3GbYIGLv1ujd+/R6MF3PktzmERb1gQ91M25T8nT24bKM/JSM96vQXK1xhDM8X0kb2ScD
         ReiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100226; x=1694705026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzpZWHat+ptY4i8T7d70uw7fEAXlmofiE9gJ/p0X22U=;
        b=bVvIil/jvjwZLGbMvx9FPl60eiBpf9eodi5tfpzuF9K7RaeRZdPc50v03UNxT46nbT
         PEOzuEXWpF4L6es29G1proe3gAF6iifQxCYqSUjlt5fEdDLkDTBHBxNkUqG4pEQhAtm+
         euvcM7lUKRmwLru+K1B8zy1FwRQzwAP9ah9ICeGSpxPntsEOMCCNA/kfSVqacdwBKFYW
         lEuNMZPKywS4jAFuOKSLJ9f9wahpX1YZY7FGvk1mNpbgchgGOvjtEA/WL5+x8iZes6h/
         LgDYghwDc/KDUwHEk1en4Uk1dVUnd/oPwC5C9Y6oR1s5059NES9NnVyYCASNBt30jB0G
         Fpeg==
X-Gm-Message-State: AOJu0YyhFIcNUpA/aV4nPuhn1N2ym+pastyme2oZ9cDYIRQ598D/4Td3
        +sUeaO8gEcEsTs2lps1Ih3g7vD1C6cn1o50sX3g=
X-Google-Smtp-Source: AGHT+IEMrWqCe5xMabRBv863fM0ihgw8yV+E02Os/rx4rFHyiXrXdvVxp9K8Xsp3/xkyjEuBAAYEFQ==
X-Received: by 2002:a05:600c:2a41:b0:401:be70:53b6 with SMTP id x1-20020a05600c2a4100b00401be7053b6mr4884675wme.15.1694098353959;
        Thu, 07 Sep 2023 07:52:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:56f5:e2d4:1e04:b28e])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003feef82bbefsm2757588wmi.29.2023.09.07.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:52:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/5] gpio: mockup: remove unused field
Date:   Thu,  7 Sep 2023 16:52:27 +0200
Message-Id: <20230907145230.44085-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907145230.44085-1-brgl@bgdev.pl>
References: <20230907145230.44085-1-brgl@bgdev.pl>
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

The desc assigned to debugfs private structure is unused so remove it.

Fixes: 9202ba2397d1 ("gpio: mockup: implement event injecting over debugfs")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mockup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 17d4d48524b7..ff1a263f1b05 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -58,7 +58,6 @@ struct gpio_mockup_chip {
 
 struct gpio_mockup_dbgfs_private {
 	struct gpio_mockup_chip *chip;
-	struct gpio_desc *desc;
 	unsigned int offset;
 };
 
@@ -369,7 +368,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 
 		priv->chip = chip;
 		priv->offset = i;
-		priv->desc = gpiochip_get_desc(gc, i);
 
 		debugfs_create_file(name, 0600, chip->dbg_dir, priv,
 				    &gpio_mockup_debugfs_ops);
-- 
2.39.2

