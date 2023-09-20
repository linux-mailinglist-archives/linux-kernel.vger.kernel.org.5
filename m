Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1E7A74F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjITHz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjITHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:55:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC49D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so10971139e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695196517; x=1695801317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Gea6QOSQ2NLWpWhPeEBkdF1fprl0wRUu4kccc1zIas=;
        b=V9HLwvxRTweU+a50Wkz4o4BFDzPH9CnawZw1yGkVeYUiTwUaDPx+xJNwiyhsxm3uLG
         3Oi0LaSR3wGqky48xBmWngQqsPggHBsGPqFNBYtSoEQ7IyjD1T5iaopm2ge27j/TCAx/
         a6xeMP4eUbtP0uD1H/y+rwSupXuTX6VLHo1g+IUi4nixE4VjIBhOy3TlXjeBu/ojdKlm
         cfcuu015LeXrwXg46D/GjP14KD3jZflrGsXeASC+mCVxBL97K33NSHnLYKJYQH9hWJzE
         bJhclFsR3dI+QsW5OxMRWUaowbU49TZYCXi95/eHRePi9Cfvv/msrGRPgI8K8uOhHW72
         8s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196517; x=1695801317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Gea6QOSQ2NLWpWhPeEBkdF1fprl0wRUu4kccc1zIas=;
        b=Owxe9yvN1gDuD+5XUwU4tpVFqt5du2vnNfznrjUyd1A8fa39KxlqhASBJCoD7FST6r
         SgHBx5yR+8nYtUfjebBD9A09WjLdnrEXAa7+t8XZHJ2nwnEjUr9MMrjS7086VMvr2+Eo
         HABSoHyLRcrOXmbQZkpCs0pe5AQm5fOAlJ3oQAdzy90ywZRQJSlIHJFoOFfMl6WV6Z4H
         Oqsp672HPdzHwLGx7IPK50RAReGSJ+z0bZlg0PuMusitRwXQMcXgTYr9/Cds9nQpRe2C
         hI2LjpWA+pVMEqkbPEcsqnI7d8z//MsickVRnw1aVWRX1hqnx7FrcfZQWxZcIzfhE3UP
         gSuQ==
X-Gm-Message-State: AOJu0YzWNYPg4MfKVHaRxsLhMD2A2DB+LitK3PtQQ2/q6aZezE0I96tE
        du037uqcxRknh9j4tJtsljfemw==
X-Google-Smtp-Source: AGHT+IHiZmCgcxUBzRJqE1edcEyBMRdvUQULlcz1VYoXxEkl+dzg/+rWt8j285FD1XUfGX8LOBzdOg==
X-Received: by 2002:a05:6512:ea1:b0:500:95f7:c416 with SMTP id bi33-20020a0565120ea100b0050095f7c416mr2078432lfb.7.1695196516473;
        Wed, 20 Sep 2023 00:55:16 -0700 (PDT)
Received: from brgl-uxlite.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id d9-20020a05640208c900b0051bed21a635sm8481981edz.74.2023.09.20.00.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:55:15 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/4] bitmap: define a cleanup function for bitmaps
Date:   Wed, 20 Sep 2023 09:54:57 +0200
Message-Id: <20230920075500.96260-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920075500.96260-1-brgl@bgdev.pl>
References: <20230920075500.96260-1-brgl@bgdev.pl>
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

