Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5580E1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjLLC31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbjLLC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:48 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F797E5;
        Mon, 11 Dec 2023 18:28:39 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5c08c47c055so50953537b3.1;
        Mon, 11 Dec 2023 18:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348118; x=1702952918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wHqKQ4J5MWfkES8HBul/HTYQa0latLedvfZPgLN9zs=;
        b=CA+8/nLn7qwjjhRUs0p+i20R/fxU3WAFskgA0B5Hed7Fo+S0+u3Q2oZcjCgBoiU+wC
         gXBgADrZSr8NVvmzx6qXpUu8QRLiE0Fno2qg0dgykS6elyJBnmDmHX1/y3Aj/TMyLjEc
         wpdAhNSr0r7+VveEGAAf8Nn4+BKfvk9h3f/tN/9vkDprCVkkOP7F4tVVjPmxAv9mXiaT
         6AJx+2Cl5hxwtfh6d92OATvzQWurimfbp7JmIMD5y4oCzA0huJEfaGkwZ+ockFJBkJdV
         mACRRAgG0tLN4Qg3Gt7pEIs2tD/g8yrnFm3PtO2hopoWuyaBYX5RJGzZLeND77q6gMIL
         oyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348118; x=1702952918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wHqKQ4J5MWfkES8HBul/HTYQa0latLedvfZPgLN9zs=;
        b=HVUJaCQHf8U8eZIXUNS14i8rWKLCDph/5ChEuRTTFazHwdfV8cUkXe1RIAyNst4mEZ
         XjdbBwIB6wOFXx2olQ71e3ZY0gREE9yHx4xMBlvvh3IlakX4KSeB4kvHnST6pv6ldQwL
         LKB7zKu/ihzai4X/tA7aCMgxeT2k+kzdvFc6Bjh2p8UkgFL9wZXHj1MPDMTgsnE8X2rq
         9AofpjHFuyXQZhJEmI+BnfdaXMQHqUh23iAfM5Rwvj+7DYhw4qZw2NgV/cXn2EoHubiQ
         44ysm3f0OoAP86JCZK1QfMFDp4KG2wxVOt2hdFwmmOSDVfpPGAQXT0+kNMjmWFPnpsUc
         n9/g==
X-Gm-Message-State: AOJu0YyXpigCPMJofzOcCetI4/bBbYoNEjQA2RZpQytHg7NwonimZe82
        hrM3fws5N/WbehnGM02lEt4+kbKRAghogg==
X-Google-Smtp-Source: AGHT+IFDkzjQxovvwSCVNmXa4FTMKe00DpcwyrrEysKmRBTHueuZeEqxsuWThC/dBoTprqgokMUJUw==
X-Received: by 2002:a05:690c:4605:b0:5e1:7129:7cc3 with SMTP id gw5-20020a05690c460500b005e171297cc3mr1173065ywb.26.1702348118353;
        Mon, 11 Dec 2023 18:28:38 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id b138-20020a0dd990000000b005e1ed51ea27sm89835ywe.98.2023.12.11.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:37 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 30/35] bluetooth: optimize cmtp_alloc_block_id()
Date:   Mon, 11 Dec 2023 18:27:44 -0800
Message-Id: <20231212022749.625238-31-yury.norov@gmail.com>
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

Instead of polling every bit in blockids, use a dedicated
find_and_set_bit(), and make the function a simple one-liner.

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
2.40.1

