Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B37F00BD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjKRPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjKRPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:32 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500D1FEB;
        Sat, 18 Nov 2023 07:51:52 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5c9adcaf514so407127b3.2;
        Sat, 18 Nov 2023 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322710; x=1700927510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/FFRxNdIVmBtGkGik+eY+kvUwCYYAdIhZdGmVH5ny0=;
        b=XHFM6tKQUtr+ERDMSFScqY8TpsnBRXCGYuutGO0nb1jrhv7VWiCmz8vSZpRl3H4EXu
         NFFvC0GFb4qTtkyiEroiLv8JYpXsun4dWahd/cWc+aTR+916BWvMI7BLQCQuSJ6Fjx6s
         090ZZr+pw0FC4Bq1GekOw4/eCTAka5QBvtAP78FJ61Ps42T/bDARzMy98D/iZfaF6UQy
         a6d+X6NSxvFmKGCYr7Krt+yLnooXahSheZ5psFFQElE+6wVU/Qg4ImNxK3eZUs/xp/2G
         6wYVpt4CIuhipxn2oo1Jcp08zqJr6C9XjNOupeVlIjjqab8ENkNrALLPhWq33QZFI0FB
         GFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322710; x=1700927510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/FFRxNdIVmBtGkGik+eY+kvUwCYYAdIhZdGmVH5ny0=;
        b=Ct4nzdt4mx15hxHbv9hsQAhX2ZtgICGYJzYRlqHiHPRHJa6oEGKJrH7qdylsNj3fTL
         sJJSB0rcQCe5oR1diK6OgnhPWyDBnYIadr+BiR5o2D0ivbOPEBAC8lGnx02/6l+7ltgI
         2IwAy4Gh1TEPeN9Cw9SejC0a5jb3BGCsPobEwVGuUyYcGKXzHeaBA7s0MBDEp5K3E0NK
         y6OrDPCOWXEZkU63RC3GSf4EGndtCdoy3sI7N4OS/W3G9blvqoRYkHUwXD9+zoZ52iuQ
         er4glkaX9oODEHOnf+qZmfVM2+uaDndlXBRNDZHMqxxZAOiaSvAhK/7aG0WEPc3kY2Vm
         3dqw==
X-Gm-Message-State: AOJu0YzJqz7WaDwT8PabL6YOTwuYEF3To1B16tJSGFBNFCnd9T2Ywmhw
        wISDFCj8etrArWmi3LoI2uXtgy5vyjUKZmyU
X-Google-Smtp-Source: AGHT+IGMZW2BXhTq6urOTFJBRfGUnn7sVaNNC8L1hFUdeATS2oy7Q8NxWcEEhUoAcnJ9H9mWRS92oA==
X-Received: by 2002:a0d:d951:0:b0:5a7:d412:af32 with SMTP id b78-20020a0dd951000000b005a7d412af32mr2476093ywe.10.1700322710270;
        Sat, 18 Nov 2023 07:51:50 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id i205-20020a8154d6000000b0059bcadded9dsm1176063ywb.116.2023.11.18.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:49 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Karsten Keil <isdn@linux-pingi.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Yury Norov <yury.norov@gmail.com>, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 28/34] bluetooth: optimize cmtp_alloc_block_id()
Date:   Sat, 18 Nov 2023 07:50:59 -0800
Message-Id: <20231118155105.25678-29-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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

Instead of polling every bit in blockids, switch it to using a
dedicated find_and_set_bit(), and make the function a simple one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 net/bluetooth/cmtp/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 90d130588a3e..b1330acbbff3 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -88,15 +88,9 @@ static void __cmtp_copy_session(struct cmtp_session *session, struct cmtp_connin
 
 static inline int cmtp_alloc_block_id(struct cmtp_session *session)
 {
-	int i, id = -1;
+	int id = find_and_set_bit(&session->blockids, 16);
 
-	for (i = 0; i < 16; i++)
-		if (!test_and_set_bit(i, &session->blockids)) {
-			id = i;
-			break;
-		}
-
-	return id;
+	return id < 16 ? id : -1;
 }
 
 static inline void cmtp_free_block_id(struct cmtp_session *session, int id)
-- 
2.39.2

