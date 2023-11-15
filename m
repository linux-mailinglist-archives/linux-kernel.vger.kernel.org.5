Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFAE7EC909
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjKOQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjKOQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:59:28 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4F8196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:25 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7788f727dd7so427034885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067564; x=1700672364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ckRu1igyABT1yYhLwRfuP0jDinbnZSUDI6tIkabXps=;
        b=lgN4vvevSm92zDEh23zw9wh1xcJ3cnuGK5bL6No+XlSb+CKa6/K1tt0sCqcXf4LJZu
         R73Mc53JHZ7PiCa+85yNbPcb3WXwVF6zrk4fCF03ZVwI0pSFjyalKDZaKTi+oNDd2J9k
         IMIwDKWunvuM4XlGm9dVNUPMyagDvoeCzHEF0ms65GtUTaqQICBcRjwpdpEeOAh3+tlY
         gyuhQjLuiH3vag49W7BdM7vRVMfLEu+tN7fteVsJMmyK+vecwuYDIb8wOcSG1ITgb2Pv
         4s6Wr5XfNE3akfNbszcYyrSHVgJDvUoqqaPGz7I4Rf38KO6A0wdzXAj4S1ykAVgP5w76
         DLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067564; x=1700672364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ckRu1igyABT1yYhLwRfuP0jDinbnZSUDI6tIkabXps=;
        b=JteAimhW6bMfWoQVK/JXIhMSa8C9iq047M0TnYfZ7ZWaOIy9JlwuXFrOMmJDByCs0G
         ZLWsNzD0bXHlTjQJ0mg48sJdDKKJ6LHZ/Zn4GERcrNNIqzHL3FtZ/auP70HfgOxVh8Q5
         OE3EnkTxRhkGawLFxCPa0Sxbiv1pWhajYImqFCKwINa92nfqxAjfPhC77PEgGgXIDTBY
         4Xa/XKUZVVrdkxdD+L5bXZodKqc8bYfpsJjGbtuLWDOigVqSiVLiiqZG157NyIeJ5l30
         40gSH0qqJpzm8m5uxvGj6D2QX6qtuQ2gkEP67f6SVbYXYsD3xEbdz9UDGpQGaUnFnsGV
         AeKg==
X-Gm-Message-State: AOJu0YxAsQF967OfxUY4p6mgM2JRoI5BqBu8SaLbN1QKkzmFS6X8RYyb
        hAI7tgm/IsDfNT6V8LKl/NiDyQ==
X-Google-Smtp-Source: AGHT+IEmGq5Vy/XRNf0UBHdyE0d3RMSIf9CuRBfPijZTmrFk+cyfbq+OTdYIVvRzgZSpnqLNrWQd0g==
X-Received: by 2002:a05:620a:4625:b0:76d:921d:52d2 with SMTP id br37-20020a05620a462500b0076d921d52d2mr7518282qkb.10.1700067564223;
        Wed, 15 Nov 2023 08:59:24 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a449300b0077772296f9dsm3572219qkp.126.2023.11.15.08.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:59:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 1/4] bitmap: define a cleanup function for bitmaps
Date:   Wed, 15 Nov 2023 17:59:12 +0100
Message-Id: <20231115165915.2936349-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115165915.2936349-1-brgl@bgdev.pl>
References: <20231115165915.2936349-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for autopointers for bitmaps allocated with bitmap_alloc()
et al.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..df24c8fb1009 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -6,6 +6,7 @@
 
 #include <linux/align.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/find.h>
 #include <linux/limits.h>
@@ -127,6 +128,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
 unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
 void bitmap_free(const unsigned long *bitmap);
 
+DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
+
 /* Managed variants of the above. */
 unsigned long *devm_bitmap_alloc(struct device *dev,
 				 unsigned int nbits, gfp_t flags);
-- 
2.40.1

