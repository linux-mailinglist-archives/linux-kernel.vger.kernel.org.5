Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792827A96A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjIURDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjIURDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:03:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CAEAC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81c02bf2beso1539782276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315659; x=1695920459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SlG0tdesvk2hZuyJ1dUVmziVM4LZO9/3+eAIoN/aiGs=;
        b=4ralu2YB1+f92Mmm9HrkEuESYlFCw9oHy2zSuSw1XCwrlz8dCuYYo5rE3YIqTbWuec
         OqVnqYFKz/2tozqNpWJEgiaL64SeMwpEM3Dd31cJqvgNmOi6sC5T+i6/fs93kB7/uIqw
         k7zn1fC9KpDY11eTW76WmTy6pqfj9OHsM9agiR9YzBUg4HmAgoQ2XQAhzeqNWhcK6RTS
         pU7/F4my98LVp1GrkGWx8VPoh1hbQdWFbTsalu6hdEEXvSS2tH737rSOCm83emjXTw3g
         7bUSXx9c8XcKOPEHmjHVdFwWZ4k7CKCP+IplbKOqwJYdpePpjk0ATD2YpY5Pq/BbkWah
         oc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315659; x=1695920459;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlG0tdesvk2hZuyJ1dUVmziVM4LZO9/3+eAIoN/aiGs=;
        b=qZWJh9uaxtUA30mVLNn4andJ0jzd8UasZQgmDNZi3seyvAlucj3xUIVuJmBIQHzW+q
         V+NeWUT/gmDPjUmCHabf8vgx6EDog108gIpAB6eekwsMr/8MHhK2ifGERyZK+qCysFOP
         AEArFaL9lqjNGKP1qyC+HWQP5LPiMSmYVU9haAN3IH2xNcaw4Un0h2IzrU7zwl1nnZWd
         MKcRDy72QTLaGg/YrOfEuFWd4QNAAPNTiTuU104CvHbLKSRm9hJVaQpmAm3BP+0EoQWb
         Oh8rhJUXveLY4JM/D3fKBvr94PljyTgdUSUVrcfx4Wireiv66llXFS6ri43hBi9C6+ih
         hEyQ==
X-Gm-Message-State: AOJu0Yy4tmpFGjD5PwtR1cvciSoRxg9QVSXVQFNziBqieRuk3V1v9Wjb
        Tm221NnBT0FyKPDTx8RLc2wZD0TG4Z8q
X-Google-Smtp-Source: AGHT+IF937OVQEJlcVjD46qKkz1op8XyFpYCUz4xdIQ1LnJeaeax/FP9gNNX1vIULn/T6b6tqd8ICJWGor0n
X-Received: from bjg.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:415])
 (user=bgeffon job=sendgmr) by 2002:a25:adc9:0:b0:d7e:dff4:b0fe with SMTP id
 d9-20020a25adc9000000b00d7edff4b0femr79575ybe.7.1695315659038; Thu, 21 Sep
 2023 10:00:59 -0700 (PDT)
Date:   Thu, 21 Sep 2023 13:00:45 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921170045.4189251-1-bgeffon@google.com>
Subject: [PATCH] PM: hibernate: use __get_safe_page() rather than touching the list.
From:   Brian Geffon <bgeffon@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>, stable@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found at least one situation where the safe pages list was empty and
get_buffer() would gladly try to use a NULL pointer.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Fixes: 8357376 ("swsusp: Improve handling of highmem")
Cc: stable@vger.kernel.org

Change-Id: Ibb43a9b4ac5ff2d7e3021fdacc08e116650231e9
---
 kernel/power/snapshot.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 362e6bae5891..2dcb33248518 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2544,8 +2544,9 @@ static void *get_highmem_page_buffer(struct page *page,
 		pbe->copy_page = pfn_to_page(pfn);
 	} else {
 		/* Copy of the page will be stored in normal memory */
-		kaddr = safe_pages_list;
-		safe_pages_list = safe_pages_list->next;
+		kaddr = __get_safe_page(ca->gfp_mask);
+		if (!kaddr)
+			return ERR_PTR(-ENOMEM);
 		pbe->copy_page = virt_to_page(kaddr);
 	}
 	pbe->next = highmem_pblist;
@@ -2747,8 +2748,9 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 		return ERR_PTR(-ENOMEM);
 	}
 	pbe->orig_address = page_address(page);
-	pbe->address = safe_pages_list;
-	safe_pages_list = safe_pages_list->next;
+	pbe->address = __get_safe_page(ca->gfp_mask);
+	if (!pbe->address)
+		return ERR_PTR(-ENOMEM);
 	pbe->next = restore_pblist;
 	restore_pblist = pbe;
 	return pbe->address;
-- 
2.42.0.459.ge4e396fd5e-goog

