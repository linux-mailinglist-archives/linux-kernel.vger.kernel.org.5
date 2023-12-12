Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2B80E408
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjLLFnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjLLFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:43:31 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E9D5;
        Mon, 11 Dec 2023 21:43:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d053c45897so46308535ad.2;
        Mon, 11 Dec 2023 21:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702359816; x=1702964616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOksdqNs08pbi9TocVeWukoOqtj/lhUt0q7v2+r1tcg=;
        b=nMmNaRT3rJ3FcPOSOicblhf2zId+qmtIivHsyrXo2VMPMOvul+y3yFiWxPPY6N6FU7
         vZGVdzUWasvWx/sb/R0pC91TBh6zCKRiYTxA9sevEMxXjwjDQQT4b3tnuBdEQFSNUeKi
         9FMVLGRH4sSg3FNKWWHK7SxMrgtm7KRwJXhk6WE4zMvMND2AVPhpXD3Qots1/AKwGk3G
         RQ7LATgK4nYbGnVWKH84lxm4i6dCuVCOn1l+s6UA/tL56dJCrPAn0HK2awxv7nWEE0Zr
         RYEdDGjKoHHjB8dkTqb9gvFRVvU18qaIDAN9kGC8l9u/1nBQ7v1deF0OvceES/iXKwyD
         OqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702359816; x=1702964616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOksdqNs08pbi9TocVeWukoOqtj/lhUt0q7v2+r1tcg=;
        b=O0qhOv4yR2fQPr+5xA5waSj+CLb8hsGUNhPk0LFwuPSgaR8Tpj9KD7valfd/GEPr1y
         AKOxQ32wu8Xx4HdD6m7L5vpIIAy5ylD+eNB4paaY/MYwk06/+6XrxgmZsN2rbcNAo5jl
         KVgLaS8P9psBOr5TAkyds+ZHM0JlRfNKDGGHUYwsPdDZjanbxePVAH03WPKjXcMV2rHf
         Fq4NvEd6SnQWzXyVEJ53KTWQgyC9ZfWgIJ7wv42MJ1MAdDXx3Oil44CG8WCN8gR8r5D1
         2UKCUVjfqSE9KnBmuydJWH/DpdSE8B4quqpDujk2C90keSuw+6/V/hEHnM/p85EgULk5
         FXPw==
X-Gm-Message-State: AOJu0Yxn4nekhIafS8vOGTafmG0y43Qm7I9Aykm1xW8qdl3NaCsdNZ/9
        TMmExUr/LEvni+T2OTHEQWBWF17HjaU=
X-Google-Smtp-Source: AGHT+IGYVp5xlrRhizm/dAy5hnpVuyr3S0nb3dDPqGuYOGfgN74hQEWu7afakEfX15uPLAoGVhKxRQ==
X-Received: by 2002:a17:902:7ed0:b0:1d1:cc09:50ac with SMTP id p16-20020a1709027ed000b001d1cc0950acmr4107955plb.108.1702359815718;
        Mon, 11 Dec 2023 21:43:35 -0800 (PST)
Received: from rigel.home.arpa (194-223-186-106.tpgi.com.au. [194.223.186.106])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001d0be32b0basm7591836plf.217.2023.12.11.21.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:43:35 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, andy@kernel.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/4] gpiolib: remove debounce_period_us from struct gpio_desc
Date:   Tue, 12 Dec 2023 13:42:51 +0800
Message-Id: <20231212054253.50094-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212054253.50094-1-warthog618@gmail.com>
References: <20231212054253.50094-1-warthog618@gmail.com>
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

cdev is the only user of the debounce_period_us field in
struct gpio_desc, and it no longer uses it, so remove it.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib.c | 3 ---
 drivers/gpio/gpiolib.h | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 95d2a7b2ea3e..b1e81a561141 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2330,9 +2330,6 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 #ifdef CONFIG_OF_DYNAMIC
 		desc->hog = NULL;
-#endif
-#ifdef CONFIG_GPIO_CDEV
-		WRITE_ONCE(desc->debounce_period_us, 0);
 #endif
 		ret = true;
 	}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 3ccacf3c1288..a4a2520b5f31 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -147,7 +147,6 @@ void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
  * @label:		Name of the consumer
  * @name:		Line name
  * @hog:		Pointer to the device node that hogs this line (if any)
- * @debounce_period_us:	Debounce period in microseconds
  *
  * These are obtained using gpiod_get() and are preferable to the old
  * integer-based handles.
@@ -185,10 +184,6 @@ struct gpio_desc {
 #ifdef CONFIG_OF_DYNAMIC
 	struct device_node	*hog;
 #endif
-#ifdef CONFIG_GPIO_CDEV
-	/* debounce period in microseconds */
-	unsigned int		debounce_period_us;
-#endif
 };
 
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
-- 
2.39.2

