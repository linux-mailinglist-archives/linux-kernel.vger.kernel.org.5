Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E37F0078
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjKRPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjKRPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:51:19 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8125BD4F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:15 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5b499b18b28so32746667b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322674; x=1700927474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtNrEcrTZb5UAh7OysIMcPcS6uJH+lnrl/PJXmZoqog=;
        b=B9B1gHATqxOBJm5GMiuRjNdbleYah1hTnn3RXmaUPbClGNSYiFYnqMDnKqX2SEUnGM
         fG/ex97/I4glD9U/I4HpSEskzafoxp1I/mtxPyi6ZDc/k6Bx8pUnGOJ1u4ZiqwF4tpHZ
         FQJ/wRZ9/0M6MQGff3O5PwctwvohIpT5Erf6A2Sfvp9pgrYjeR1effvHGzpMjU23bdt2
         JRDKOVhm9wdR754GLNGleg64faL0lJn1klKh4x+AeLGu5yD5K3LDHQDr88Hehv6b53lW
         FTjWgXwbfXOHB+ero3KhS7aDJaQhj8DcAcS36y4LYVAEvrZORdHfpmhBh9FuvSETdRdP
         dTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322674; x=1700927474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtNrEcrTZb5UAh7OysIMcPcS6uJH+lnrl/PJXmZoqog=;
        b=mEAhLhD5KKGBZkCECj0W15wGu5DkF5GOyCFcpMhfSv7ck7r+/tvdA+ct/VPdls5BIc
         Vt6jx1bkEmL/qGB4Oj1Fk7Eoy6eMk4+bMysMwkM78tpRyFyvi5iA4zKeQANW+RE8U1Vp
         Zhn7sMgG38sluPRvw33X1bDSr3Ha+w6b2d2Vge/fS+NgTRgqtooHR2lzNIMSY6g+l9Zp
         qeEKz8WcEU0/EGJAmdSLd/fVmv/N3m7OUQmc5CtRLUQuxet5CaH64Te3aZsobBommLCk
         GLo5jKDZQMhBlwi1XDHtIeZbrrRUpP/CDkXAMCC/92wRO7jblPbjm4C1zWKE/AVrMBpp
         Nc4w==
X-Gm-Message-State: AOJu0YxBLuVGq3+0BUG+WesuY7ssS95G3WpVDC3//ODM5x/J4XDhZpxN
        t0wsLiCx8rpR7HqCBMh00QQ8a+23FyR5zyL0
X-Google-Smtp-Source: AGHT+IGHmtShLawg4b6FAef5MPRhw9Ntmlqy+tZf2/vVvKTJQT2ZBfSV6qgfvbZAC4YpRmYfk4CQbw==
X-Received: by 2002:a81:470a:0:b0:5a8:e6f4:4b6c with SMTP id u10-20020a81470a000000b005a8e6f44b6cmr2719557ywa.25.1700322673713;
        Sat, 18 Nov 2023 07:51:13 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id q126-20020a815c84000000b005a7c829dda2sm1170194ywb.84.2023.11.18.07.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:12 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 03/34] watch_queue: use atomic find_bit() in post_one_notification()
Date:   Sat, 18 Nov 2023 07:50:34 -0800
Message-Id: <20231118155105.25678-4-yury.norov@gmail.com>
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

post_one_notification() searches for a set bit in wqueue->notes_bitmap,
and after some housekeeping work clears it, firing a BUG() if someone
else cleared the bit in-between.

We can allocate a bit atomically with the atomic find_and_clear_bit(),
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
2.39.2

