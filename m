Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FCA7BCA72
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbjJGXjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344223AbjJGXjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:39:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A444FBA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 16:39:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso3035384b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696721980; x=1697326780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HYnCwkKRvVAb6FgWG5/x2YsYaba+yTpA1ZzCoN+hJU=;
        b=by9/MYPdwIXoSqv5+sVvGEilYab1HhkWuav1Yzs7fUGfAdSRpsj7qGTZqRpyFd6W7v
         EJV9/RC0GpiHLZuyEToeJkn0CkKDyNoJ5OTN/Qi5YJpfrkpGOCNPD+aG/2ezwJIO810w
         oklVCq8b3wazOpZJP8bts5MD0jTZ43xNqE7qThh2khE9HhHLa7vxWMgaQlmVq/vyOLeN
         MybhT76PbQuJwx4ietZoGuKBA6XFF7b6LBjscI+4/cyX6H8N9J/pHUkMX8jZ2g9dRw7W
         Q7kaVYdmx4t5COY7VN2u8wblUazUPJNZWepLpxp1sGP5DZ6r2jElTEA3IsP1GhG5vH9J
         nZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696721980; x=1697326780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HYnCwkKRvVAb6FgWG5/x2YsYaba+yTpA1ZzCoN+hJU=;
        b=Q9A79XOXigUs0I4eGJUl6/GD4NpFohFf63wfskNHyContr+p9o1kr9kZ2htA8u4qi/
         A1X8dmE5NNpof7vl9LqqjntKgmp6+g/YrckHpjwO23HqEv2lBJn6hAPdEPv89U5RiGpo
         DeVurd7tmAV2IV8+z9o4DThLxpI2sUNzz5unIWNJN8yTqkWnpcKJKyVNFEUb0ZflVoNO
         jpzNweiJOaET2HN/RmqOczH9E3nxhKx+ayaymTxvOAdhJZutGgZ2WlB/s6CzGOKSycFd
         87a0NZjlpJyG9CZhAW6C9ockWxXc5OEsugbRKJFkytcxBcNkCvfQGMaa+P5X2OPy02/c
         pjfw==
X-Gm-Message-State: AOJu0YwnD4prj+MYyWyBIAYHwjrcvKPxWWSwV157aR+t5z5/9x1oQ/ma
        cOmJNTCVNpWmRa5vG/VT2cEI5Udqhc+5eA==
X-Google-Smtp-Source: AGHT+IGYjJ3e42RXN8S54cscz9bM/NUkP3elI6ocvwFNZO/0avnXRSFe8TD61NuiiW0zicVmdLSNMQ==
X-Received: by 2002:a05:6a00:1302:b0:692:b8b9:f728 with SMTP id j2-20020a056a00130200b00692b8b9f728mr13099710pfu.30.1696721979600;
        Sat, 07 Oct 2023 16:39:39 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b005776446f7cbsm5473236pgc.66.2023.10.07.16.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 16:39:39 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Seo <james@equiv.tech>, Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rae Moar <rmoar@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/2] lib/bitmap: move bitmap allocators for device to linux/device.h
Date:   Sat,  7 Oct 2023 16:35:09 -0700
Message-Id: <20231007233510.2097166-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233510.2097166-1-yury.norov@gmail.com>
References: <20231007233510.2097166-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocators are simple wrappers around bitmap_{alloc,free}().
So move them from bitmap to device sources.

Similarly to other device wrappers, turn them to static inlines
and place in header.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h |  8 --------
 include/linux/device.h | 30 ++++++++++++++++++++++++++++++
 lib/bitmap.c           | 33 ---------------------------------
 3 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..ce8fcd8736f1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -11,8 +11,6 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
-struct device;
-
 /*
  * bitmaps provide bit arrays that consume one or more unsigned
  * longs.  The bitmap interface and available operations are listed
@@ -125,12 +123,6 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
 unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
 void bitmap_free(const unsigned long *bitmap);
 
-/* Managed variants of the above. */
-unsigned long *devm_bitmap_alloc(struct device *dev,
-				 unsigned int nbits, gfp_t flags);
-unsigned long *devm_bitmap_zalloc(struct device *dev,
-				  unsigned int nbits, gfp_t flags);
-
 /*
  * lib/bitmap.c provides these functions:
  */
diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b..01b8161b283a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -435,6 +435,36 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
+static inline void devm_bitmap_free(void *data)
+{
+	unsigned long *bitmap = data;
+
+	bitmap_free(bitmap);
+}
+
+static inline unsigned long *devm_bitmap_alloc(struct device *dev,
+				 unsigned int nbits, gfp_t flags)
+{
+	unsigned long *bitmap;
+	int ret;
+
+	bitmap = bitmap_alloc(nbits, flags);
+	if (!bitmap)
+		return NULL;
+
+	ret = devm_add_action_or_reset(dev, devm_bitmap_free, bitmap);
+	if (ret)
+		return NULL;
+
+	return bitmap;
+}
+
+static inline unsigned long *devm_bitmap_zalloc(struct device *dev,
+				  unsigned int nbits, gfp_t flags)
+{
+	return devm_bitmap_alloc(dev, nbits, flags | __GFP_ZERO);
+}
+
 /**
  * enum device_link_state - Device link states.
  * @DL_STATE_NONE: The presence of the drivers is not being tracked.
diff --git a/lib/bitmap.c b/lib/bitmap.c
index ddb31015e38a..41f32fa3a80f 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -8,7 +8,6 @@
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
-#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
@@ -1415,38 +1414,6 @@ void bitmap_free(const unsigned long *bitmap)
 }
 EXPORT_SYMBOL(bitmap_free);
 
-static void devm_bitmap_free(void *data)
-{
-	unsigned long *bitmap = data;
-
-	bitmap_free(bitmap);
-}
-
-unsigned long *devm_bitmap_alloc(struct device *dev,
-				 unsigned int nbits, gfp_t flags)
-{
-	unsigned long *bitmap;
-	int ret;
-
-	bitmap = bitmap_alloc(nbits, flags);
-	if (!bitmap)
-		return NULL;
-
-	ret = devm_add_action_or_reset(dev, devm_bitmap_free, bitmap);
-	if (ret)
-		return NULL;
-
-	return bitmap;
-}
-EXPORT_SYMBOL_GPL(devm_bitmap_alloc);
-
-unsigned long *devm_bitmap_zalloc(struct device *dev,
-				  unsigned int nbits, gfp_t flags)
-{
-	return devm_bitmap_alloc(dev, nbits, flags | __GFP_ZERO);
-}
-EXPORT_SYMBOL_GPL(devm_bitmap_zalloc);
-
 #if BITS_PER_LONG == 64
 /**
  * bitmap_from_arr32 - copy the contents of u32 array of bits to bitmap
-- 
2.39.2

