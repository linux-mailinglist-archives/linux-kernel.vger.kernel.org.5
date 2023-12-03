Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B568802710
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjLCThU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjLCTgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:36:52 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341ED2107;
        Sun,  3 Dec 2023 11:34:04 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d77a1163faso7155697b3.0;
        Sun, 03 Dec 2023 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632042; x=1702236842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLIpPFsand/i1xzhRvuWZWdTEGryuaeNcdCEZ2uAMCg=;
        b=ikQOY9twYk8DY0FzEdHM4506y+8fZlMZyC1Ldaqqq+OsuSQAmVYtUEoNxWmX2UXLHo
         iipYoEzTvjMmaeHKonchgcfqdvdDcODXjou//SrvCiqS4Vmk6xjPXycUOmPX60H9laJH
         yRGs/qcycmPdHvHmVSeUPFyW8Dtrl5jHuOXa28xcNR5S9NtDx070z75wX4nqcNA6kVLP
         X1WzRUFvB8OKkO6UvFM13L11I/6cFHMadx6XnCVEL1je1PzEs2+UxT7qYEP42Ii+HLTD
         f7MP6YLlLM5y6d0GfqqmB49uEV/54aX02fXlUM4rvc2q4Q0PchPWF1xzXNJeu3O1L5K7
         ooLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632042; x=1702236842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLIpPFsand/i1xzhRvuWZWdTEGryuaeNcdCEZ2uAMCg=;
        b=Ei5Huy7+YVSf5u8ZuegITtmd7xSctsmYSKCUftgR0WS9jZRFzRsopnLjBEo1hPTNli
         zheWjAJx6j6S10C8bp0W6+zI3YSyJEMSo8IYYV66hdH45lg0abRZszt3U9k/B8IrbSUs
         ZsLY6yDU1xoeV7C53jd0lBYYpuZXFWp873Ae1LCmUgnE0FGh5AQ4GpKDFsHrLxjXvud4
         +rm2WyNAtgTIDZa21mavUih9p2fGJWgJXhR/wwPIrNtVoPGIxQFBOxbqNlEOd0GNv72A
         9fgGNtKpYFyyD9n/UpA/+L15x7XvOLNBVQyARq2/GPiVyHX7bpmr7Ga6Az1sGNKw0imP
         NWyQ==
X-Gm-Message-State: AOJu0YwP8kzIy48FyeBQumiNDqe3jM6gEFSjQfXaU5m7wsL50BpWDRvJ
        S0ON3FxW3Dr+/1RMpQY7NTmVNU2opZiZdQ==
X-Google-Smtp-Source: AGHT+IF7TlbMvqX4zBK0qN69lty4JT5J+hOZOMnrAIhG2aaSguNl8zsIA2Kc3TBbQ2Xbvw2rXB+lGQ==
X-Received: by 2002:a81:4320:0:b0:5d6:d420:cb29 with SMTP id q32-20020a814320000000b005d6d420cb29mr1604031ywa.14.1701632042389;
        Sun, 03 Dec 2023 11:34:02 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id c68-20020a0dc147000000b005d6f34893dfsm1612853ywd.135.2023.12.03.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:02 -0800 (PST)
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
Subject: [PATCH v2 30/35] bluetooth: optimize cmtp_alloc_block_id()
Date:   Sun,  3 Dec 2023 11:33:02 -0800
Message-Id: <20231203193307.542794-29-yury.norov@gmail.com>
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
2.40.1

