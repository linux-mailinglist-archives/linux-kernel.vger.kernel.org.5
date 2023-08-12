Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA577A204
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjHLTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjHLTpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:45:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D3E172D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31972944f30so21751f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691869511; x=1692474311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Gea6QOSQ2NLWpWhPeEBkdF1fprl0wRUu4kccc1zIas=;
        b=yF8kJyvjwMlFAO15PBbWRAfxWOOqapN3Y98nUA7FuaZw3ANfcx833AhpNHjvdIDwh1
         zIwkhXzdOj34f4y23KmcIWkYtwxQ0tJVqRdcS74VbdPW32Cil6kI+s3z2zy0CxiD0TUV
         VxNgdXfOecTpl8lKP8gCbmQkRJ7i4k1I8zHwPShznAFf/xguejRJKBfpBXAQaShUDJJE
         bTeF34VaAl9QjDMcGeQ79NIPrJbSN/moHEQLoKZhk2B8OvJiCTBhSgsjCfJNIYsc8+3o
         LEpzb5ubkkCbfwIRUSf48EL7bmS/qROJ4GFePJSrd2Aj0rcVe31WPGiFHjpLlYE8LnqF
         fBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691869511; x=1692474311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Gea6QOSQ2NLWpWhPeEBkdF1fprl0wRUu4kccc1zIas=;
        b=QQxA+wO+IWhNKPn1xfPX49QGUSgufvRrJMmB3Unrkv1XwAM6dm5bUT7W6WX0430TdK
         tgW1h6QrWUXuYnazkeMdnQ1bhFkcRGUFl/qkLNH0O1pPuE5KuHyOQLSavtmvbCLrHJEj
         GctP8Typd8JCI4fnd3QX3jGu3ctfmqKxdMlBoQDE4lFo8+Y6i9dY16NHnw5FDkcTPF+g
         2RvviQdNK1yoBda0l0YK738ccdaqIPe5QfDogYv9w85LMhn4M07N2zzNJbNkePEFDRYM
         0JnswYx/D316MzuJL8hOcHy/e1nm1HihodJDrUJYe+fF9klQStkqi3h0fY0GH8XzLCYi
         cwtg==
X-Gm-Message-State: AOJu0YxoUceMb1KnIpDco6XsLONi8lIqATJ/tua75+W0SEoLgRvWn2GB
        AIdSVdcBYigvL/01HRhnTlSItA==
X-Google-Smtp-Source: AGHT+IFWTTHbuOeaJHIalp3/1swDo5a7o6UAANLDE7pUMSEZv5L1CbQY8HMuSxbRrHigv5UKu1if9w==
X-Received: by 2002:a5d:4985:0:b0:317:eee2:6fba with SMTP id r5-20020a5d4985000000b00317eee26fbamr4240122wrq.40.1691869511067;
        Sat, 12 Aug 2023 12:45:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74c0:22ae:ddb5:1bed])
        by smtp.gmail.com with ESMTPSA id y7-20020a056000108700b003188358e08esm8813765wrw.42.2023.08.12.12.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:45:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/4] bitmap: define a cleanup function for bitmaps
Date:   Sat, 12 Aug 2023 21:44:56 +0200
Message-Id: <20230812194457.6432-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812194457.6432-1-brgl@bgdev.pl>
References: <20230812194457.6432-1-brgl@bgdev.pl>
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

Add support for autopointers for bitmaps allocated with bitmap_alloc()
et al.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/bitmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..6709807ebb59 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -6,6 +6,7 @@
 
 #include <linux/align.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/find.h>
 #include <linux/limits.h>
 #include <linux/string.h>
@@ -125,6 +126,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
 unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
 void bitmap_free(const unsigned long *bitmap);
 
+DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
+
 /* Managed variants of the above. */
 unsigned long *devm_bitmap_alloc(struct device *dev,
 				 unsigned int nbits, gfp_t flags);
-- 
2.39.2

