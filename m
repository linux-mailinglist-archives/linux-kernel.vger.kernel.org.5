Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71A37B46FC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjJAKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjJAKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:41:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACBAD9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:41:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c136ee106so2134341066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696156866; x=1696761666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av1YVGUYjKuKpOxhCUYf9bVAmtK6lNc0JKDBqDmChEQ=;
        b=XgET2xRhAYWKjiJpGOWCLfXgpro6aiNoftb7Sg8CWyYi8CTIN9sccGA4demrNTykI4
         1WuDHXHevQhMSgqzM8j6K1wSZ7q4F1yewjz4LSx4s9KxIxDdZNss3bhS6hltLAeAMTLE
         g4LO09wTF79iItsrspKUzeGQQM+xU+kRxT2eKmFzmROpB4c17ym3xTK0Nhz6u0ssc0st
         Av4navrf/a8wcIcFK0vTj1hX3iszFKLkr3banX53nNJYhuh05GqY12FZIyEtrI2BgVFY
         FbvKN6Qw9oyJ8qYj58qON+5yutp86GR6emR/fs+ZwQ7uoz2whFy6T2S/+V9sqBJUNPle
         pslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696156866; x=1696761666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Av1YVGUYjKuKpOxhCUYf9bVAmtK6lNc0JKDBqDmChEQ=;
        b=Vf0F2lEjY8BwAp+Endmu9Pu9h45AMmC9EUYZ8+7AyaS/XayM01/xpuJLl88vBX7Fnk
         Gf7cMcJT32oQ8WbyFVf8Ap1G3zNgL9dEyyr+SxB6M1ixhGVI5HqhBosIzV/k81MVM5N+
         e33XqaO4Q49xH4QhlkpZp9+gB3Kp+ah/qYfeyeLP0jf4UItNoIVfkw9CzO2ZoHGzmjDy
         2+b2J69tny7LIo5W1i8antT+LC/h6flQj7w2UVSa4B8EUkAjXu03OUdKGqbejggLMRSc
         NgFUJQ5Yb0gf54W2KTtqGCZDycJcJLWj74Nz8gNq+OVhiCMx+mR5Ve+jAPpEKEO4BW62
         zbTw==
X-Gm-Message-State: AOJu0YzeWDKiIybAwhpX5sne74wN4PgC3Rc+ybw1kFRhepXb4mUOxwu6
        Wy3c9Ek/yKBP+7gjuySKQa9JrJQg9dX1fg==
X-Google-Smtp-Source: AGHT+IEaRBVRFHBq8PsqtS7Xotm/O/WCU7PUdbnpb1YCwTqlB9U799c5jGmIPkQv2u5NF0F2mavHLA==
X-Received: by 2002:a17:906:7695:b0:9ad:e17c:464e with SMTP id o21-20020a170906769500b009ade17c464emr8738266ejm.68.1696156865773;
        Sun, 01 Oct 2023 03:41:05 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b0099caf5bed64sm15333657ejb.57.2023.10.01.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 03:41:05 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 3/3] xen: Use sync_try_cmpxchg instead of sync_cmpxchg
Date:   Sun,  1 Oct 2023 12:39:11 +0200
Message-ID: <20231001104053.9644-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001104053.9644-1-ubizjak@gmail.com>
References: <20231001104053.9644-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sync_try_cmpxchg instead of sync_cmpxchg (*ptr, old, new) == old
in clear_masked_cond(), clear_linked() and
gnttab_end_foreign_access_ref_v1(). x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg
(and related move instruction in front of cmpxchg), improving the
cmpxchg loop in gnttab_end_foreign_access_ref_v1 from:

     174:	eb 0e                	jmp    184 <...>
     176:	89 d0                	mov    %edx,%eax
     178:	f0 66 0f b1 31       	lock cmpxchg %si,(%rcx)
     17d:	66 39 c2             	cmp    %ax,%dx
     180:	74 11                	je     193 <...>
     182:	89 c2                	mov    %eax,%edx
     184:	89 d6                	mov    %edx,%esi
     186:	66 83 e6 18          	and    $0x18,%si
     18a:	74 ea                	je     176 <...>

to:

     614:	89 c1                	mov    %eax,%ecx
     616:	66 83 e1 18          	and    $0x18,%cx
     61a:	75 11                	jne    62d <...>
     61c:	f0 66 0f b1 0a       	lock cmpxchg %cx,(%rdx)
     621:	75 f1                	jne    614 <...>

No functional change intended.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Improve commit description.
---
 drivers/xen/events/events_fifo.c | 26 ++++++++++++--------------
 drivers/xen/grant-table.c        | 10 ++++------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index ad9fe51d3fb3..655775db7caf 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -226,21 +226,20 @@ static bool evtchn_fifo_is_masked(evtchn_port_t port)
  */
 static bool clear_masked_cond(volatile event_word_t *word)
 {
-	event_word_t new, old, w;
+	event_word_t new, old;
 
-	w = *word;
+	old = *word;
 
 	do {
-		if (!(w & (1 << EVTCHN_FIFO_MASKED)))
+		if (!(old & (1 << EVTCHN_FIFO_MASKED)))
 			return true;
 
-		if (w & (1 << EVTCHN_FIFO_PENDING))
+		if (old & (1 << EVTCHN_FIFO_PENDING))
 			return false;
 
-		old = w & ~(1 << EVTCHN_FIFO_BUSY);
+		old = old & ~(1 << EVTCHN_FIFO_BUSY);
 		new = old & ~(1 << EVTCHN_FIFO_MASKED);
-		w = sync_cmpxchg(word, old, new);
-	} while (w != old);
+	} while (!sync_try_cmpxchg(word, &old, new));
 
 	return true;
 }
@@ -259,17 +258,16 @@ static void evtchn_fifo_unmask(evtchn_port_t port)
 
 static uint32_t clear_linked(volatile event_word_t *word)
 {
-	event_word_t new, old, w;
+	event_word_t new, old;
 
-	w = *word;
+	old = *word;
 
 	do {
-		old = w;
-		new = (w & ~((1 << EVTCHN_FIFO_LINKED)
-			     | EVTCHN_FIFO_LINK_MASK));
-	} while ((w = sync_cmpxchg(word, old, new)) != old);
+		new = (old & ~((1 << EVTCHN_FIFO_LINKED)
+			       | EVTCHN_FIFO_LINK_MASK));
+	} while (!sync_try_cmpxchg(word, &old, new));
 
-	return w & EVTCHN_FIFO_LINK_MASK;
+	return old & EVTCHN_FIFO_LINK_MASK;
 }
 
 static void consume_one_event(unsigned cpu, struct evtchn_loop_ctrl *ctrl,
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 35659bf70746..04a6b470b15d 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -427,16 +427,14 @@ EXPORT_SYMBOL_GPL(gnttab_grant_foreign_access);
 
 static int gnttab_end_foreign_access_ref_v1(grant_ref_t ref)
 {
-	u16 flags, nflags;
-	u16 *pflags;
+	u16 *pflags = &gnttab_shared.v1[ref].flags;
+	u16 flags;
 
-	pflags = &gnttab_shared.v1[ref].flags;
-	nflags = *pflags;
+	flags = *pflags;
 	do {
-		flags = nflags;
 		if (flags & (GTF_reading|GTF_writing))
 			return 0;
-	} while ((nflags = sync_cmpxchg(pflags, flags, 0)) != flags);
+	} while (!sync_try_cmpxchg(pflags, &flags, 0));
 
 	return 1;
 }
-- 
2.41.0

