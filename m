Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83980E1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345862AbjLLC27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbjLLC2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:32 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C5710D;
        Mon, 11 Dec 2023 18:28:24 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5e190c4ce5cso7278907b3.0;
        Mon, 11 Dec 2023 18:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348103; x=1702952903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va2vHLw3Ty5+9zMdFDg2qigI4FO7sF4QYmqp/MMfS60=;
        b=RE32qoJKos+jUKofbWoUByihuaOXfd8fS/GWiJmLeAilLLxvicnfmMP95bKgkpv0OE
         njergsGPHQQ1bJDG6NjZCtP8sbMZaeSv21rKqTUdhVtVfsQJVMempODuu3lr9p2NUebg
         awgllwTB7eMfCC5RCt6HRcCmmgjWxCjeNrI8pQl61eH5JDRNmDX0kQxQfNabh8L7r044
         1NNfS7TIFqhNt946jEidL1gC+HCP6rd2SgA4nc8gG7ixMauz3GX+UnNQ5Qy2KTA9r80j
         1B3JH+NsejlWPu9cpxQXhrApvCL9ZNwlBvMNoYTkt5MTsm7Jlx6+4aDLjXNhcMU+vkYk
         6b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348103; x=1702952903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va2vHLw3Ty5+9zMdFDg2qigI4FO7sF4QYmqp/MMfS60=;
        b=ih+wKtDEX8GyvLC/CKWz7AH6EImF9MSVa+2eqPqbL+CZ8tRDyHHi8Slh7+miXSHL6Y
         XAVX5GBndRLKKpeuUZXKSVtbDoPLhpeXl5woDdUQJm4GFArXV2PHHiJFZCsGAqV0GlgL
         F3dqLN3FON/Kk9YS4pnyTBRx7OVXfPn5VovMRRd99Yflvv21/wkNBO+PKd9gQGOuSx5D
         Lm+vMGEmgmtvO/1RqwvDh7QECVUGlZjD/4zx1vnggU8yAtglUcgi0QZw7/LnuCpw5Vjo
         plFQnhhnpHW/F8IgdO/szKH3kYpfXi66EwNXhEme0Q2z5ub63Rg63ATzcJvBp4YikZul
         O/6g==
X-Gm-Message-State: AOJu0YwG1CppKweHwbXfCkS5BlYsTfiXqkgPI7mWppn3854+KpJDuyCT
        mRYUrbh7gjk83fB4X8W5FHLIgOSJUwnLrg==
X-Google-Smtp-Source: AGHT+IHngUkzlUE6ykpfOt2noOpZx7E2f44wkktyKrcENOqj5Bj/OgMDPvA3unZcpysQrzoP1HwKsw==
X-Received: by 2002:a81:a190:0:b0:5e1:7f1f:c629 with SMTP id y138-20020a81a190000000b005e17f1fc629mr882344ywg.0.1702348103377;
        Mon, 11 Dec 2023 18:28:23 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id ee12-20020a05690c288c00b005e16c1c0bf9sm592682ywb.95.2023.12.11.18.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:22 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v3 20/35] media: radio-shark: optimize the driver by using atomic find_bit() API
Date:   Mon, 11 Dec 2023 18:27:34 -0800
Message-Id: <20231212022749.625238-21-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite that it's only 2- or 3-bit maps, convert for-loop followed by
test_bit() to for_each_test_and_clear_bit() as it makes the code cleaner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/radio/radio-shark.c  | 5 +----
 drivers/media/radio/radio-shark2.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/radio/radio-shark.c b/drivers/media/radio/radio-shark.c
index 127a3be0e0f0..0c50b3a9623e 100644
--- a/drivers/media/radio/radio-shark.c
+++ b/drivers/media/radio/radio-shark.c
@@ -158,10 +158,7 @@ static void shark_led_work(struct work_struct *work)
 		container_of(work, struct shark_device, led_work);
 	int i, res, brightness, actual_len;
 
-	for (i = 0; i < 3; i++) {
-		if (!test_and_clear_bit(i, &shark->brightness_new))
-			continue;
-
+	for_each_test_and_clear_bit(i, &shark->brightness_new, 3) {
 		brightness = atomic_read(&shark->brightness[i]);
 		memset(shark->transfer_buffer, 0, TB_LEN);
 		if (i != RED_LED) {
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index f1c5c0a6a335..d9ef241e1778 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -145,10 +145,7 @@ static void shark_led_work(struct work_struct *work)
 		container_of(work, struct shark_device, led_work);
 	int i, res, brightness, actual_len;
 
-	for (i = 0; i < 2; i++) {
-		if (!test_and_clear_bit(i, &shark->brightness_new))
-			continue;
-
+	for_each_test_and_clear_bit(i, &shark->brightness_new, 2) {
 		brightness = atomic_read(&shark->brightness[i]);
 		memset(shark->transfer_buffer, 0, TB_LEN);
 		shark->transfer_buffer[0] = 0x83 + i;
-- 
2.40.1

