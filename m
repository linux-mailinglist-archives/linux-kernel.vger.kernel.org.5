Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120077AB8CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjIVSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjIVSFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:05:12 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E7FE6A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c0b8f42409so1466773a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405125; x=1696009925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPeCsCM6RKnj7SP/7NeGfgjvWPniZKOlNUjLQPJjRrk=;
        b=nsPPhAujoYnHbEV9rcA9vzDu5Mmxuzc8U6VYq6OZCF8Gl7xyc7Yv+LuH65H9mK4nxK
         wbuXffyFykkwlAS9ru69GTCfZJOwp8SLOwZ4TenRdULgEjZokHTt0lvMJyW9yCNitAaw
         VjaJZx/yUhwXilPpwB8s00m74tzHLXvEKR9hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405125; x=1696009925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPeCsCM6RKnj7SP/7NeGfgjvWPniZKOlNUjLQPJjRrk=;
        b=xKmfs9dQZuPXs5k+sjiE9T3xXUiOJsoiIQbi0EsPVf2IdLpGm0vM1IMzClbPbj2lEp
         We7CXnjlrxlLWIslYwjMdk+qlfs7iX/ZSIl7Ej2QzpFZ2ESJnpi8bNB5tuikCrMRI6oY
         iqL4t3PBM+lOBS+ZkCF9/+hg05LlSD0ZZmw+zPPHaM0MGGrLWyXoTQ/FCpw6t0gaHHIX
         M6+xq9Vz56FLNjoJfspEVgr/yJskKUpASZP88MastmHw4uHrnG3MgX8QdMT8ZzlmpYKo
         zXhYyP6MDQaCugasaUWy34k6/RBGuC91KpkupKgXy42uim9u/18ctNl8ESKDsBwsxqCQ
         typg==
X-Gm-Message-State: AOJu0YwMI3H505a49NTNv9Qz43APGpmEO7H7yatgCM8QsaR61BfYx+QE
        aS4HUd7aa/IDluuZ6SMk745y8A==
X-Google-Smtp-Source: AGHT+IFEPZY2FWuoLuj/J8x0P9zfOloxPTwOyuvqJHiLkoPALd4nAHq6UVOZicjn7oGHx7saYqsMnA==
X-Received: by 2002:a05:6358:278a:b0:143:3179:1a67 with SMTP id l10-20020a056358278a00b0014331791a67mr301716rwb.29.1695405125439;
        Fri, 22 Sep 2023 10:52:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r9-20020a63a009000000b0057e13ed796esm728612pge.60.2023.09.22.10.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] gpiolib: cdev: Annotate struct linereq with __counted_by
Date:   Fri, 22 Sep 2023 10:52:03 -0700
Message-Id: <20230922175203.work.760-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=keescook@chromium.org;
 h=from:subject:message-id; bh=8zr3EscqNMKGB+p2GQ+eNq4lFJNw863hYtHYoUZ6QT8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRDnHWem4qivuYvpUIrmnI1crVLCjWEs1Bl3
 gzzs3k1FJGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UQwAKCRCJcvTf3G3A
 JseKD/4quBw/IubJ6kx2xMKEYBqn7EU8HCBh9hqvf/DZpDUBw12gRWSQNalISRWuYF67cas5Tkr
 EUj3MbyNdPUEx/IJrlL3WHXZfRNgY4r3M1SR9aDCVsSEylC1PQdUNdRTvU+rPLRjOr6JHlZDQqU
 ayR0dlH/PQnDDG2kVOZM5XHvZXu5mJUy8OvlhRV8vEMwvcodYJXl8SJreBqqCVIZqqwYhjP4B95
 OPINC+bpMgbcQ1hX/+IWYq1mh2HyM0AZw18fRaJevYcMTVvLd27oad+aja6ikDJpZnaiR4StABS
 JmE4ha3T05WdaaYiCf1MqC6qJRd/225OoZemjlFHuaqze/naFKA/dvHT18VPo69ezq0KkjQ2U7/
 3TyK3eGInrlMpG4ABDIsl2HD8hDsc7Vl46x8b9DxIQmBF1Jls2LAm+7S3bLyc8zrT0fPP1I9oUd
 RAFcig+QfsIHBcf2MZIy/kj0y90XDIFLq4yXccv4vlI7+rJQOeoTeby164bXqumt9WVcYSdeyNK
 CRz0HHgMSkH60UvlLF05qx9N3E6PLjJ6k2x6KUC9SJbc92HLO1s63wzDJDfTgiy4SEiObVoyF76
 W9x+284Vs0VzKisQmXg6gBgf8fFLYi/xcW+8j+cNIQ4+uYqzT/L6JUY0SkB69rh+9U21waaUzft
 V7vH5yP GuFFYMXg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct linereq.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpio/gpiolib-cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e39d344feb28..31fc71a612c2 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -572,7 +572,7 @@ struct linereq {
 	DECLARE_KFIFO_PTR(events, struct gpio_v2_line_event);
 	atomic_t seqno;
 	struct mutex config_mutex;
-	struct line lines[];
+	struct line lines[] __counted_by(num_lines);
 };
 
 #define GPIO_V2_LINE_BIAS_FLAGS \
@@ -1656,6 +1656,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	lr = kzalloc(struct_size(lr, lines, ulr.num_lines), GFP_KERNEL);
 	if (!lr)
 		return -ENOMEM;
+	lr->num_lines = ulr.num_lines;
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1684,7 +1685,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 		lr->event_buffer_size = GPIO_V2_LINES_MAX * 16;
 
 	atomic_set(&lr->seqno, 0);
-	lr->num_lines = ulr.num_lines;
 
 	/* Request each GPIO */
 	for (i = 0; i < ulr.num_lines; i++) {
-- 
2.34.1

