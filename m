Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B177D6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbjHOXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240620AbjHOXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EDF13E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdfb11ea2aso7747105ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142596; x=1692747396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNrK9GyOkfgy8vFobQz0dvafv7zThWTFwPQDrVe2f4I=;
        b=p9FgoXqhPY+caeRBg5x1v9jj3nZEGLTU48KrS2KlEmkRDKV0RT/UJsjXo9nM99dSv3
         6NUp2tv0eFUdFnczbZEGXkHf3xTX8B1/VhySK44OJUWb5N+euJdLicAoN8WOlCkWl9l7
         U7BtG5ntxwNeHUhejA8qHhKAcOoV8srAtYpu+YhTJxefzypUwSDzxos80uXduqrdH+5y
         evi4f2+DricjcX5wzquzepILzt30KZkxbgEy9ASHwtXPiq7oQ5uJsCdLhgf0HfjR+3tF
         LqAh+nWgQxn59VOMj2IIxex69BK6Gl113KR6GUnYeYNKaEIhGNdB9gGLH9m0zlY8oPZP
         4hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142596; x=1692747396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNrK9GyOkfgy8vFobQz0dvafv7zThWTFwPQDrVe2f4I=;
        b=YSL73nozXBs7TDseVQnTR9DjiBEa4uHO05p+oyDG5XzHh5RGjdbnl6wKX9s0BX5Kkr
         7B6o8n/iCCVevZBSC/FjanaqVty3FKW9ioYmyyNxpce3gUnkgw4zJut/isFogEZIW1UR
         oahblr9cK8MkRK0LvOgwMRIdRmchT5g6RiXyUWkMKFzpquWJ6Bfp188dhZlNw80Pwx24
         RmafIPzVd2AlKPQnGaYWu0QdlsUVRfnqIu4AYg5ss7kAQtZaeHbjQ++PqDismIsKg1Dq
         X/0g0IIo39XQrvJr5/kYV/zNI4FCg04eZFypPTz+CK+dyNHPLn7Qqxpx87c2MKmKwyaU
         A7tA==
X-Gm-Message-State: AOJu0YzjEkzjKL7ZdMan5FZhx+28q2yz12AxOcmDA7ZYFSrAS8xWpjjQ
        fgH6p7PEMWbTil2LbhGjebx5e5DE+5M=
X-Google-Smtp-Source: AGHT+IE7TAvabQnBsSvv+XtbuxOtnk9uAp4T3mP0sq699ScC33mKn76Zwz//MslUFnbsTz8oBlwdjQ==
X-Received: by 2002:a17:902:8215:b0:1ac:63ac:10a7 with SMTP id x21-20020a170902821500b001ac63ac10a7mr252835pln.68.1692142595931;
        Tue, 15 Aug 2023 16:36:35 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id ju11-20020a170903428b00b001bdc3768ca5sm8178907plb.254.2023.08.15.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:35 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 1/8] bitmap: align __reg_op() wrappers with modern coding style
Date:   Tue, 15 Aug 2023 16:36:21 -0700
Message-Id: <20230815233628.45016-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815233628.45016-1-yury.norov@gmail.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
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
style in bitmap_find_free_region().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index bf6b0eea1af8..76bf79261107 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1238,8 +1238,8 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
  * some size '1 << order' (a power of two), aligned to that same
  * '1 << order' power of two.
  *
- * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- * Returns 0 in all other cases and reg_ops.
+ * Return: 1 if REG_OP_ISFREE succeeds (region is all zero bits).
+ *	   0 in all other cases and reg_ops.
  */
 
 enum {
@@ -1311,14 +1311,14 @@ static int __reg_op(unsigned long *bitmap, unsigned int pos, int order, int reg_
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
@@ -1336,8 +1336,6 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  *
  * This is the complement to __bitmap_find_free_region() and releases
  * the found region (by clearing it in the bitmap).
- *
- * No return value.
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
@@ -1353,7 +1351,7 @@ EXPORT_SYMBOL(bitmap_release_region);
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

