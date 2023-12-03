Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253568026F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjLCTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjLCTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:16 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB57D1BF0;
        Sun,  3 Dec 2023 11:33:47 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d3687a6574so35789577b3.2;
        Sun, 03 Dec 2023 11:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632024; x=1702236824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZVt4888D5YtxgnmIOyxEXsc4h2k4JcfkNfpNmqkQB8=;
        b=CiQNHXq0mA6FFsyBoZM8r4rai4ZzNaC1PpR/3LHehVyS11vlH2VsWVqGuzXnGyuvqJ
         j6WbCcu9j0vMVHp/A5UY5Pvy+pbAzJb0v2Zl0fApq3st2od0eBHXJkz2SC3bZTEToqQa
         +PCG54iMKB4ksQMXFV56QtcydgT9W6YNH7smUzPQG3jnnyhXXzZbuFqsUzM7mRhfc9q1
         5xoW6wwZ9ztlKe5bmIM7YGsOwKi/O1zFFgqbity0k/XGDo5Wxv7euojmm8SHuQvxrLNf
         Swrvs6EA3jdzxxAHpa8XluSF4vpuHIEUAFuy1UXSD28qSKHdpfAI6rZ1cfdIWNQ/yrU7
         Gyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632024; x=1702236824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZVt4888D5YtxgnmIOyxEXsc4h2k4JcfkNfpNmqkQB8=;
        b=HbLzJBkBVCmEJm/NAD7r8WgagpEnYzuoG6lFfhvXunpnBzhZ12lD9v12hrDApoh0gU
         97MiRS4WCflHezPEEJdQTcw91k7darfxJHS02EARwxkf0aNOJlUdlJ9N4g3xQGgymKrb
         8ErLqab6aMQY3z/VpTCBJ79RF62fEBdUdxvA+BEOXWLg8mF581kATj2dQT86fXLKhZjx
         rLt+8YIJL6SWbsGmhug5cJxjXSVY1Bsb46lLZX5Q1DaYIZn2JGAc8U7JiCATkhTn0tXR
         UG8t9BkBY2WzPSJ3inGiI+Nt7aB9gw3U5zVP+OnQKVuuF0Btw3eit/QAtQa3ppFIWjrJ
         Q3EQ==
X-Gm-Message-State: AOJu0Yy/ud2UGCU1lEOLgE+ONqX7ykkKuQmiNoMp1caEtGmVodm1yyeR
        t18vD1/YvOr/miN696GZ78xIvS9wb4NGYQ==
X-Google-Smtp-Source: AGHT+IEb+k1kYSVaCL2UNALituelfObeFug72VuU2KzQkAKLaBngX61rvmvoIVzHoVCttcR+xc46zA==
X-Received: by 2002:a0d:fcc2:0:b0:59f:b0d9:5df2 with SMTP id m185-20020a0dfcc2000000b0059fb0d95df2mr2034748ywf.0.1701632024635;
        Sun, 03 Dec 2023 11:33:44 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id u128-20020a816086000000b005d774946228sm1127180ywb.68.2023.12.03.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:43 -0800 (PST)
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
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 20/35] media: radio-shark: use atomic find_bit() API where appropriate
Date:   Sun,  3 Dec 2023 11:32:52 -0800
Message-Id: <20231203193307.542794-19-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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

