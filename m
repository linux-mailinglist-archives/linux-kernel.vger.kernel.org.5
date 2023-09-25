Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9347ACE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjIYCic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjIYCi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:29 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B286BD3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:23 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59f630612a4so25581757b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609502; x=1696214302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Lu/kA1c3+diLAugHwidaQ6Q88eGZI3aXMjfNbZFH6g=;
        b=SibPS/DMFvDGC8QAPi9Lm4fZxJB9KR81gZL0dXke2sgf42ZaYjXekq6K7CLq/UfQmV
         txskI3d2zf5+Mk4DmreOHds8QcI34Xzsdvy9t/5zc17SoDLVYnmIGexMhqGmCgCuiArV
         mNLBXWPmUFlVxYOeM2fz7ShMyU72QKXOrRASyL5DsG7n3iP0rjoudOx+qqy2KxxjFifC
         AxrxGLZiLPp5PQz3k1XzYmO1CwDRTLrauLQxzaFpG0d5W5VWjbW3oTiZa0EzLwh52b8U
         TQiVJv+WhQviv4/vMrcr65FGtUESahUJ2qx5Wts3a6OY20pKzzdECeCANsP/dq8QRkSh
         qgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609502; x=1696214302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Lu/kA1c3+diLAugHwidaQ6Q88eGZI3aXMjfNbZFH6g=;
        b=ndpTC5IFNjThXlf4yKLYtrsv00McNsgsPxB12Lo9uAHdqcnLEeYnwvyGSqCM5wCF72
         lg9ECvNpo31uabZlgnrs9JHP16lAeEC/Rgr4Ik5TTFHL6MMXIS8Xs5U4uSc7jpGfFdtq
         rPVStZWRo1Xwc4CKNjJ/PhqfOQbpEqnXJSvKU2tp2K9bwx+/360Ay02Ro4j+2wSatkir
         fPAhmlhZ+sAjC61qPUbj9wuGsVkyERX3Bl9txKlIiNd1k8q4EsT1EpTH/Yqz6yr08yxD
         2FpRy4BO2qm7mij4WJJeVgLXv09EGza3k/HrhVRPbZU9DoHZSEKv7RDE6oChwdT4KPNO
         hrDg==
X-Gm-Message-State: AOJu0YwQVeJuIyO+EhqBAoENAgqSdAaQPqBJpHlhaJXLilpiL2UL1Eta
        lumXFCf9rrFUevS8d9WTuXxZt2Jr06Y=
X-Google-Smtp-Source: AGHT+IHQd/WrqfIdFLXGrAqAPy6y5QVPvNmjXAkSfK5dgcJZr7kOsZiL67oHtVMav2M1V4MykbfzSQ==
X-Received: by 2002:a81:91c1:0:b0:595:8499:c5f5 with SMTP id i184-20020a8191c1000000b005958499c5f5mr3283627ywg.26.1695609502416;
        Sun, 24 Sep 2023 19:38:22 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id w62-20020a0ded41000000b005837633d9cbsm2147869ywe.64.2023.09.24.19.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:22 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 1/8] bitmap: align __reg_op() wrappers with modern coding style
Date:   Sun, 24 Sep 2023 19:38:10 -0700
Message-Id: <20230925023817.782509-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925023817.782509-1-yury.norov@gmail.com>
References: <20230925023817.782509-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comments so that scripts/kernel-doc doesn't warn, and fix for-loop
stype in bitmap_find_free_region().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ddb31015e38a..421f2fc384f4 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1234,8 +1234,8 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
  * some size '1 << order' (a power of two), aligned to that same
  * '1 << order' power of two.
  *
- * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- * Returns 0 in all other cases and reg_ops.
+ * Return: 1 if REG_OP_ISFREE succeeds (region is all zero bits).
+ *	   0 in all other cases and reg_ops.
  */
 
 enum {
@@ -1307,14 +1307,14 @@ static int __reg_op(unsigned long *bitmap, unsigned int pos, int order, int reg_
  * a power (@order) of two, aligned to that power of two, which
  * makes the search algorithm much faster.
  *
- * Return the bit offset in bitmap of the allocated region,
+ * Return: the bit offset in bitmap of the allocated region,
  * or -errno on failure.
  */
 int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 {
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
-	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
+	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
 		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 			continue;
 		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
@@ -1332,8 +1332,6 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  *
  * This is the complement to __bitmap_find_free_region() and releases
  * the found region (by clearing it in the bitmap).
- *
- * No return value.
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
@@ -1349,7 +1347,7 @@ EXPORT_SYMBOL(bitmap_release_region);
  *
  * Allocate (set bits in) a specified region of a bitmap.
  *
- * Return 0 on success, or %-EBUSY if specified region wasn't
+ * Return: 0 on success, or %-EBUSY if specified region wasn't
  * free (not all bits were zero).
  */
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
-- 
2.39.2

