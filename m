Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76F078BCE8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjH2Cj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjH2CjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:24 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04427CA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:22 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-573449a364fso2194737eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276761; x=1693881561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1pj4nyvVMsclOEC8h60mitlr/KrWrVEeGq6ZdoiJKc=;
        b=hbahPkAmYFMKqqd17DEFmNfkL4xDKqyp66AtrlhWPspg84r9hza3Wj8gj8m3fMV60+
         3OR0mlgcXkNRQOVDAgAF/VPpD3LJbV/xN8iR4zr8nyeK1rcGQ9lmrwau867uSPQjNyW8
         diexw3nXP7pe0i5WQgBYtnPwLG6BFSTgmpQh3kiQO+rglx4MYpKFvPOvRqDbDbDgGZ18
         9gX0iwXF7WKbhLGCq35R8NqLTlxnhMFm9HRXUByCP6Z6+y21LtFhx/TScSLtftuSfNEN
         D33u0JwD+YfK0ybBUbeDcn5NA7XdZt0JaGe7zOddHEX/bNZCHTa1nhogBR6NknybrKLU
         6gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276761; x=1693881561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1pj4nyvVMsclOEC8h60mitlr/KrWrVEeGq6ZdoiJKc=;
        b=AreG3eW2bfze+RGc2sfnSGu96tHFcbGsr4hb9gxVCkKD6ithL6ugKt4jbczae1BgLA
         OsC0Ftvg3Qrvg/TMoo8uxpUho85IMmC2cr4sjiuthvih5zsRPkFwV9CbWIjTs+yanoh/
         oOeNiD9QCRiZJDH1bOAyINj2uG8CjN6J1z+YSeVs8EUtRyfRBoc8H9O84Oxk/ELvEPMU
         JD0Bd7wxulsDtQSbA1HeK2x6rI7Zv4+6+j1f0bcs+B6JdHX8ZbxrAJQJkppASgjUPx4T
         UlzFcTUhgWIxFPy7PP1S+KkI+fhVtuEjTbQccdUkbvqNyFsxRhlFLuWjobJSN/98nnnN
         SWHw==
X-Gm-Message-State: AOJu0Yy52Xf5c9plXkagNDupCw2r2r4AwEKWlYjDVp53uOgpj382vWWF
        5I0RNUoFtC6owBwnkj5iIZY3eezguIY=
X-Google-Smtp-Source: AGHT+IEAAYCSnfjjlfF1GVf7bPT+V8pDv9iNBsJFEC657DN2xpOpJJcVXZpu/c/F6BT2gLGZhWkVVA==
X-Received: by 2002:a4a:281a:0:b0:573:3711:51c4 with SMTP id h26-20020a4a281a000000b00573371151c4mr11265302ooa.8.1693276760876;
        Mon, 28 Aug 2023 19:39:20 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id l9-20020a4ab0c9000000b0055975f57993sm4271118oon.42.2023.08.28.19.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:20 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 4/8] bitmap: replace _reg_op(REG_OP_ALLOC) with bitmap_set()
Date:   Mon, 28 Aug 2023 19:39:07 -0700
Message-Id: <20230829023911.64335-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829023911.64335-1-yury.norov@gmail.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
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

_reg_op(REG_OP_ALLOC) duplicates bitmap_set().

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 3c069944dd83..0fabcb0e4628 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1350,9 +1350,12 @@ EXPORT_SYMBOL(bitmap_release_region);
  */
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
 {
+	unsigned int len = BIT(order);
+
 	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 		return -EBUSY;
-	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
+	bitmap_set(bitmap, pos, len);
+	return 0;
 }
 EXPORT_SYMBOL(bitmap_allocate_region);
 
-- 
2.39.2

