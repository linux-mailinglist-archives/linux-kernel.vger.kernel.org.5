Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972568026F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjLCTfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjLCTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:29 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884919F;
        Sun,  3 Dec 2023 11:33:56 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso1923328276.1;
        Sun, 03 Dec 2023 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632034; x=1702236834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umylsjeSPs0cDBz7+FTUGH2Vn0LO0b26GddccWPu0Jc=;
        b=INmutiGknFZp4otivmEjEN6U5i9K+DYuNAAwT4RR6E6MHxetNGsWEjpz4PFZZ3NewE
         XoKmhzornVPQikoYdYEKbY0/ENZMcQNcbTSwLpRGFI+8ruV0Xm9BKJ64Jqxn27jK5u4v
         F4MphdmtdPwA6l/hAJcLIgbq15egqT9GYh6fAJ9uteezJ3DFwfqJ2TKc3d0XCR5IFTQH
         eSp8g1BkM4R+thZ3DYoDIsO+5JEY8faCXPyWKqK+yjzdenQdE5P+JPtH/bJAcOib480v
         1CKY9k6RMfd/HfancmSlu0slSrXlX7zyKSu+vuigYABNaVGhOPLTw21ZcPCy0tiBj7WD
         LUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632034; x=1702236834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umylsjeSPs0cDBz7+FTUGH2Vn0LO0b26GddccWPu0Jc=;
        b=UTFgThxl5cLW5H480WHyvTltiuI1rEDZJj+XSsd5lmaSlVM/5wwZ6iFOuH5SYqVzp0
         SH43b3k9NVnziXWgEuWqh/QzAsklti0sV+HUFxOjE4Z5pi2jzTyafEfxyjQejwOUvSe7
         iPjBJICEq+W+nduJmCV2wIPMaunAr0QFEOkpwLjbOa66eWJOq1o51+43Bsh65vYnMjqb
         l6Ap2nZuWxvh8QlzMwj0WXrFuzTYdcPsRYPcnUQvNjJ591NJ27CnILxpCE7hqV/J4g4A
         i7148fVLvS8fij6tm/Cj9JxvruXv56FnOsJOIFT6SO3JWbTOLBCngqQ2tcX170rVmJ7z
         pIdA==
X-Gm-Message-State: AOJu0YzgsN/84LRH1P435owWM29qOW8iSSsXH4+rY11skcq8wOtoerdg
        lykASl1wZX1Sqs0mTG5NB/p1Z6qbL9OCkA==
X-Google-Smtp-Source: AGHT+IEMrAskXkIWksgXiWbXkBl3jPfPd1x1T+uOqGjr26YyA+tnyIwo24cYyzJVLZxKOZWy5dfEjA==
X-Received: by 2002:a5b:28c:0:b0:d9b:87f3:54f9 with SMTP id x12-20020a5b028c000000b00d9b87f354f9mr2129725ybl.28.1701632034561;
        Sun, 03 Dec 2023 11:33:54 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id o145-20020a257397000000b00d9caecd5c86sm1810336ybc.62.2023.12.03.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:53 -0800 (PST)
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
Subject: [PATCH v2 26/35] mISDN: optimize get_free_devid()
Date:   Sun,  3 Dec 2023 11:32:58 -0800
Message-Id: <20231203193307.542794-25-yury.norov@gmail.com>
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

get_free_devid() traverses each bit in device_ids in an open-coded loop.
We can do it faster by using dedicated find_and_set_bit().

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
index ab8513a7acd5..3f97db006cf3 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -197,14 +197,9 @@ get_mdevice_count(void)
 static int
 get_free_devid(void)
 {
-	u_int	i;
+	u_int i = find_and_set_bit((u_long *)&device_ids, MAX_DEVICE_ID + 1);
 
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

