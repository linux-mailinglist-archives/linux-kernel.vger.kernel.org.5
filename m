Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD16A80E1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbjLLC3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345794AbjLLC2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:45 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A426137;
        Mon, 11 Dec 2023 18:28:33 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d2d0661a8dso51964567b3.2;
        Mon, 11 Dec 2023 18:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348112; x=1702952912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k5eqiGBj5/5DwPtrpE4m/Ucis1bOkRyK/lvgWCjgQY=;
        b=MUXJt/HuzQG0n1pJk75TJsqno0B2RvcwtJqS6p6vIJlgw1ENOKUWFBLtN9sECruBaA
         BT7mTAvsKZpNTqJqeoHviKjchN1kfYKsQ4ubVXQdE/KLdbzJ7cep2jg1k73GwscQIcqk
         gy0oFv+aixeijNbjGhyx6qDshbtGJg6ytqNbfI9Lf6Lv23VsIu4CEU9WU8kXTjsW+Etd
         6BTxKdXV2xKa96TsV9wQTIBLNNQ3oszSQcw+k/V7NrruYlaDdYTwxPaAFySc/dgAanTo
         W/qi3vCWyxQhTRoO1FD8FNdfZ6XQCqv7HcCvZSj1X+4OvRJJ7aetyb+9aPX4gMnA6hCp
         cDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348112; x=1702952912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k5eqiGBj5/5DwPtrpE4m/Ucis1bOkRyK/lvgWCjgQY=;
        b=ntA55nGPN+V0t5PPS9K4HGaTv8qFmHRbK0iflEpdbhW1vyrEtNLzU3b5YWSoSRStrB
         TrCHjjPqCNi4vjPIWwWO5Gy9D5x+9AxdIa9MsxXVIjySOkilODoYVhDUnlTc3P8iXlGl
         kE82tM/kl5+QYZJK17LNV/LLiUCppm/fcUcdqf3nopxM2ZqX86F4X5IdNXKkmAX23dNU
         JjeYMuKEwmmEdq0YD+8+NKDDbdNsWzuJwwoKHwkwBwvLRpiLBg7pg23gN7WAW5UeANs0
         ktImQWH52cCyh7/PSynTxjZAlDBcDIEeKwWINbSpobwCtMcyoG7d0Mv/xFqgH/Le7t3z
         UqAQ==
X-Gm-Message-State: AOJu0YwAeJhOXqdgraCkXo0Hg3mlJtbtt4s39pTb66cMQ0cZRdel/tpr
        2HKobexFJ9HzZa3ehRy30cLb4S6NwSRiMg==
X-Google-Smtp-Source: AGHT+IGv28WoB4lgSsY3KnWz4m20syHxTtIOJodmzHgYhM/BE/Qtyrxdpfg0dGSVdZSH2dpq9w2ttg==
X-Received: by 2002:a81:8245:0:b0:5d7:1940:b399 with SMTP id s66-20020a818245000000b005d71940b399mr4634837ywf.101.1702348112320;
        Mon, 11 Dec 2023 18:28:32 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id v6-20020a81a546000000b005ca4e49bb54sm3359875ywg.142.2023.12.11.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:32 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Karsten Keil <isdn@linux-pingi.de>,
        netdev@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 26/35] mISDN: optimize get_free_devid()
Date:   Mon, 11 Dec 2023 18:27:40 -0800
Message-Id: <20231212022749.625238-27-yury.norov@gmail.com>
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

get_free_devid() traverses each bit in device_ids in an open-coded loop.
Simplify it by using the dedicated find_and_set_bit().

It makes the whole function a nice one-liner, and because MAX_DEVICE_ID
is a small constant-time value (63), on 64-bit platforms find_and_set_bit()
call will be optimized to:

	ffs();
	test_and_set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/isdn/mISDN/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index ab8513a7acd5..c829c4eac0e2 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -197,14 +197,9 @@ get_mdevice_count(void)
 static int
 get_free_devid(void)
 {
-	u_int	i;
+	int i = find_and_set_bit((u_long *)&device_ids, MAX_DEVICE_ID + 1);
 
-	for (i = 0; i <= MAX_DEVICE_ID; i++)
-		if (!test_and_set_bit(i, (u_long *)&device_ids))
-			break;
-	if (i > MAX_DEVICE_ID)
-		return -EBUSY;
-	return i;
+	return i <= MAX_DEVICE_ID ? i : -EBUSY;
 }
 
 int
-- 
2.40.1

