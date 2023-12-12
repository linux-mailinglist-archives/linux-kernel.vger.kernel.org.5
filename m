Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38EF80E17F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjLLC2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjLLC15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:27:57 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B21D6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:02 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cbcfdeaff3so52269927b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348080; x=1702952880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbntnK4HNa/CvcX2c9tw9yKQZtz2j41lTpG1pzcXcKI=;
        b=nl+nuKzExYNXseyTves7Xp5mnTvjWfv3Lv0vFI9pzpyDfHJlD9SOkItEvulJrISpI9
         FkDCgIkQOR1iwNcGKMVFftVOABCvlQzXg9Nr7Fvhvs0qCLbFHQnaJPSZ8BmgOlSf64ZU
         K0CtuQ9rFPTeD2xi9XPGVQnmvSHm35RQ770x1F8Ux0DUHDuNjiSXsarRSwXippCaARIp
         /QBz3Q5DgLjeUA58ZQBxBrThHjlwjjgrvnTl3EOakdfDY6ymtHCll9CbvBt9kpCs9KHB
         3kBzRytQ/0K6wtWZYQ3W/DhZUFyRI3jQkYNbrP4gSFivh0AjKoFP+/btFk9lOzYx4AGe
         zZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348080; x=1702952880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbntnK4HNa/CvcX2c9tw9yKQZtz2j41lTpG1pzcXcKI=;
        b=PCJp4bWrbNajdrPVafOgqpB9wBcBT6lA8L47XLuiYD22+r7LeGUc+9iI8sgju6Rt4f
         3PnniXt98TZ7w2XxCuczQMiIp4RbCvJJpb7BRmLKSSJC5IcIGrVuNeWgwJ+w46LUYkMB
         Lij7welcnBGi1EpPTyun8927mJVSZYtEZ2qQQFhSo3ZjaUJqdoq8cLbK/PQ9MtsaVLuQ
         kIZySNryV97o08a1/GdN7WM1CdfOxuzqfaUJv0TyFvf7cdjySsSFe7HF195EPAlxW9f2
         LBHDA7WzHC4nMQNRuMnzCCdwU/qVolHzfC5C2lZHDU5kJfGACmbC0yP9a9wgRSBwQULN
         9v7Q==
X-Gm-Message-State: AOJu0Yy7py+KN5S40YfV11Epx+CqnRvuK5a7KHMtS3ykm/oAlOVaEWQR
        ntN6lStF4i2uWr10gM/hTafpz/k6nKIkwA==
X-Google-Smtp-Source: AGHT+IGpj3yUfAKU2ZR8/Q6odSy7v61/Vu+5bnngA9VJC9jEx+CsGDkRdjxSllnhyTKJMTGXcBmQ+g==
X-Received: by 2002:a81:4e4c:0:b0:5d7:9f0c:d36c with SMTP id c73-20020a814e4c000000b005d79f0cd36cmr4224321ywb.28.1702348079901;
        Mon, 11 Dec 2023 18:27:59 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id p194-20020a0de6cb000000b005956b451fb8sm3402804ywe.100.2023.12.11.18.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:27:58 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Siddh Raman Pant <code@siddh.me>,
        Yury Norov <yury.norov@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        David Disseldorp <ddiss@suse.de>,
        Philipp Stanner <pstanner@redhat.com>,
        Nick Alcock <nick.alcock@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 04/35] watch_queue: optimize post_one_notification() by using find_and_clear_bit()
Date:   Mon, 11 Dec 2023 18:27:18 -0800
Message-Id: <20231212022749.625238-5-yury.norov@gmail.com>
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

post_one_notification() searches for a set bit in wqueue->notes_bitmap,
and after some housekeeping work clears it, firing a BUG() if someone
else cleared the bit in-between.

We can allocate the bit atomically with an atomic find_and_clear_bit(),
and remove the BUG() possibility entirely.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/watch_queue.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 778b4056700f..07edd4a2b463 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -112,7 +112,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	if (pipe_full(head, tail, pipe->ring_size))
 		goto lost;
 
-	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
+	note = find_and_clear_bit(wqueue->notes_bitmap, wqueue->nr_notes);
 	if (note >= wqueue->nr_notes)
 		goto lost;
 
@@ -133,10 +133,6 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	buf->flags = PIPE_BUF_FLAG_WHOLE;
 	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
 
-	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
-		spin_unlock_irq(&pipe->rd_wait.lock);
-		BUG();
-	}
 	wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	done = true;
 
-- 
2.40.1

