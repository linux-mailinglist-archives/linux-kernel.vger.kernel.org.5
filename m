Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED69E7F00AF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjKRPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKRPwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:43 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A2D58;
        Sat, 18 Nov 2023 07:51:37 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5c9adcaf514so405017b3.2;
        Sat, 18 Nov 2023 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322696; x=1700927496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X35XMuOkQGRdZiwlzwdQZgjDPtyUYCVaMlOgAQr4CJI=;
        b=Zxvk2SQ2TdWAKA7Wv5MzEaJezJmEcN2rcF2SkfgbS5YuiJd6L5S23PmiwXpjZyE0/G
         hikIQFfpvqVVy2YKm3u3dnMMi+p0fKJ0kSHGbTQ3lGkDLzR75nnRcILlrZIgkeO3DSyw
         3cDAB1lNohNnAQTDUXZz9g7G3JfaxW2hXsD5EMOsqc2rYrjxEuzjiv+1n8YOorCzC+EE
         UE2dWl1llANf6D5P5n/VheWWZCzrZwO8thOMAXPjm7By55LjQPf791oSOItviPs9JXfj
         Fl0l5uqtfSC8nNMZRqnjUnUF49mdCcfquaFEHstRQeYJOS8Cq3PWs5Bp31RoGxjjDB5O
         XYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322696; x=1700927496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X35XMuOkQGRdZiwlzwdQZgjDPtyUYCVaMlOgAQr4CJI=;
        b=jH96M27GtpaMUlix3CdFYCsYagsGJng1oNeVdZFmQp2vbjJemDB/4TZ51JgWjcIqLd
         uHfffyxJ0s1JrscxnUezxpoA1e2wrspu8b/d+8gLMf1Ebq8Nq/aWZmHf0P+OxQPW6guW
         zX4kHrpWm7baOoCCI3EmzlWSP8h/kY762mNKQVyjJE9+ukQWLTvR7P9RkDOuX5NFSR+X
         Xu1386e5vH9NkgYSFyXIhTFS1d1x3w0GUrrIjACJc2b+IDWG7RI0r1wiWFeyz8tq+14r
         cepecTd4RGuU9mLokeLOUi7PpZI66EtGjnmXaqUboeCF/8HguNjRuibUEPOcJGPGYdb+
         0nsw==
X-Gm-Message-State: AOJu0Yyeh6OhiQLXzwpLmdCrbCpUYjD2MjMHdzAI0jVca7eyQmlMuqpY
        IJK8kXgKrNQSQNTDq8epBzr+OKL6Bovhu5+j
X-Google-Smtp-Source: AGHT+IHAhvZBoGNxpPDB2BCWYJwaK4V04ZOAMY/osneEuJm+eKrAFTeb+/vBc80W6VqFpHOGlnjhyA==
X-Received: by 2002:a81:a141:0:b0:5a7:b819:648f with SMTP id y62-20020a81a141000000b005a7b819648fmr2715402ywg.4.1700322696135;
        Sat, 18 Nov 2023 07:51:36 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id b65-20020a0dd944000000b005a8c392f498sm1167744ywe.82.2023.11.18.07.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:35 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 18/34] media: radio-shark: use atomic find_bit() API where appropriate
Date:   Sat, 18 Nov 2023 07:50:49 -0800
Message-Id: <20231118155105.25678-19-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
2.39.2

