Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896977D6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbjHOXhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbjHOXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08813E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so4004661b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142602; x=1692747402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHD7wUMcR/IeqBhQ/f6jYRlMrAkqr7++FIIFzS8UJGc=;
        b=jDsPUuqhIcHgswnWxC6LBLdtjE7d0YrR76YpcxHP/GZ/oWUJbXmLTknCSiH1DFdeWt
         EvegoLMxlIQBMuK5PfOiHkt8draLwUGwpNn/940sGppmusDwmZIU70QBDXXYS3Ai+T3A
         sX4NUlaRkuqRkV6plQmDBgL/kgQTZrG5YKW+31vO0RA/YTWhLTklVyWkluZOhQMDUkfq
         lLbnWD2Ta827S8a0fDRZhI/35xIW7W8UDGF4vbTU5Z+SCzLg3jIUQLMmwDa6EPBHebWm
         IRnau8c/JFvqyUf4lPKIZ5lcsbNqxDxDUMYOTY8054i+Z9Wm3J7vCoj7gYg18TYRRneY
         kx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142602; x=1692747402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHD7wUMcR/IeqBhQ/f6jYRlMrAkqr7++FIIFzS8UJGc=;
        b=WpkMewCs13GyR5VcP1y5t18grSqpIM8CB73S45bg5qeSnmzOe1v0OPSdrJ+mYwSIdQ
         40sSY9T+dONI5XR3ly9F02VYEfx5vQXqR1r96Md7iyyfTzJ5Teue057gEy9sVI9MHJkS
         lkcTC7m2yJgPDrZcnsovXwyBILgfHgP14FoNPVAP3I13suNZOuDphSSxNQuqEdiapDaX
         dA36MSJ1OxietYmHHqRtVnWPrPN4l8tpNjr3XVu4rsd36oBLxuvGxR7XYVxprY7QHBWZ
         obUyq7F1wUvD14WyLTuF9EFLXVsG9WGAMJv7f1YxZOeLmszF8wYlRrypcPHtTX2r30k2
         3WBg==
X-Gm-Message-State: AOJu0Yy72ote36CwTqSQK1Bv5v78OKVRcvHYBSZk1B072sgAJYSxhGJ2
        PJ6qNwzwBMQ0Kdm9X1O4JR5S/4vjUh4=
X-Google-Smtp-Source: AGHT+IE8ZrYkAgXGGlouo0bXXtQI7xXQfhsmnYeQ5d7aYjtQZXNfb+Xxn7fZDSNFnBIB/b9UkLX/xQ==
X-Received: by 2002:a05:6a20:3952:b0:143:c453:814c with SMTP id r18-20020a056a20395200b00143c453814cmr478669pzg.18.1692142602255;
        Tue, 15 Aug 2023 16:36:42 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id ff10-20020a056a002f4a00b00682a8e600f0sm9884943pfb.35.2023.08.15.16.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:41 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 3/8] bitmap: fix opencoded bitmap_allocate_region()
Date:   Tue, 15 Aug 2023 16:36:23 -0700
Message-Id: <20230815233628.45016-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815233628.45016-1-yury.norov@gmail.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
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

bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 76bf79261107..4c9f119240cc 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1319,10 +1319,8 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
 	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
-		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
-			continue;
-		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
-		return pos;
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
 	}
 	return -ENOMEM;
 }
-- 
2.39.2

