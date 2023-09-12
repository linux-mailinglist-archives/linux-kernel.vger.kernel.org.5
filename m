Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCC79CAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjILI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjILI4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:56:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47EE7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-401ec23be82so59284255e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694508960; x=1695113760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGE8+aaEWV5mHsdN/XyuIXsk7ZbIHUwF0zjQXkbFuiY=;
        b=PPBZqTjs9fBExOCIh0mpM57vyyCAnaBol8M4+06l6SXloJ3jBVthtC723YLf1CqPoM
         ON4zl92Sf4zbkAMC1yY3i7Bvm98q3mkqBC8SO5wHjP84zABOzeWmqwW7WqEkiDn2M9re
         ZmVXj3aYVawQvV1uhFZAXETGqrysz0MkxHq7xQsQrjB26/vLg73YoUXtodNK+J4c9nHF
         XrktqzZNZctJ/M8eb8tXaF6cvlpY/39tNjbhREqRhVL+jC0Q6Ky2vijvQXpkP2JV8CA6
         8w0P3qreIg5YGkQGq5SEmsOrdjaZQvAAxNtFCHpaVeyJohLNJXDVvFkUfVmPV//97k/T
         /CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508960; x=1695113760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGE8+aaEWV5mHsdN/XyuIXsk7ZbIHUwF0zjQXkbFuiY=;
        b=Yu8LHp+B2/BG943g7fMrJ8KFjx0klctLhvzMCo+UWCenZ69f19s4WDfQ2jxlisiFlL
         E3KYBAskK8q5G3qNpdz44BHpX9j0RkKDgob/yI0cjoHnVQQIoVP0zo6o9qdod+LfJ156
         wIzydSLtPAmTcDIYXhX5UbeFTygg+uTFnaPUtRzsbLxHfW7T6fthWMhO5b/keG+racMo
         lNkXsxmZlcII4KNTC7uLMokkBG5r67v9UoU40tYaaRu0Ld/S+V7zf5lNRNnP1rb5cq23
         MZNjbv4OIa8JTKyE7MiaXvkN8MauuvGZgcXJ+X7M/TQm186zM/F0I1kzrfDiLcis7oxG
         qt9Q==
X-Gm-Message-State: AOJu0YwjUFn+QLZvqDuWkYM1+xKkmVr57rG9CEizw21h+BwyyF22jiH0
        AK5tkWJ06bics+fypDJXdHInGQ==
X-Google-Smtp-Source: AGHT+IFs3GaRmd7Pr3hi1nz7WGlupkTzFq1qrOY478irGruifUp0BMXMoUkAifEkHNdiYZwmv4PJUQ==
X-Received: by 2002:adf:e78c:0:b0:314:1b4d:bb27 with SMTP id n12-20020adfe78c000000b003141b4dbb27mr9815432wrm.64.1694508960129;
        Tue, 12 Sep 2023 01:56:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b00317ddccb0d1sm12310028wro.24.2023.09.12.01.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:55:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/4] bitmap: define a cleanup function for bitmaps
Date:   Tue, 12 Sep 2023 10:55:38 +0200
Message-Id: <20230912085541.13682-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912085541.13682-1-brgl@bgdev.pl>
References: <20230912085541.13682-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 03644237e1ef..ba8c0d733842 100644
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
 
+DEFINE_FREE(bitmap, unsigned long *, bitmap_free(_T))
+
 /* Managed variants of the above. */
 unsigned long *devm_bitmap_alloc(struct device *dev,
 				 unsigned int nbits, gfp_t flags);
-- 
2.39.2

