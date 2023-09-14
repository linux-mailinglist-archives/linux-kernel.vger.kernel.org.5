Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFA17A051A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbjINNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbjINNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:11:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A1A1FE0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:11:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c49de7a41so120921f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694697073; x=1695301873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJomarRjaTtn3oATFqeS61pqk655aq9C7zKlWCyipu4=;
        b=QwlULImn/vm+b+kBqoqtJVxsCj+HpcKUTCrCTVlbAgwC3nyZfjIhiQhCu/IFkUMo2u
         ori8G1JIyt7SySCOeWp7qfX8wYGLMS6et236HC3gSG6HBGMfdGUCHUwv7EHqxPuX54A+
         QPd0TqPCDaWus2VIM9zLP6v1Ye7j5NSFCqisw54hi2ynDDBToETgiFZL3HaWU3tlQYF8
         pNOGXko5n69IrsGJuOYATy/qw2Kv2UxA3z7h04z2iDdUU27KIi1Plh/G6XaqQfWkhy1u
         ySZknfplgeZ3w+pHUrZkbN0WONjKa/tDpe82f6zE86kJSbQnu+lvHQSv2dZwX7M5rv6y
         8diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697073; x=1695301873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJomarRjaTtn3oATFqeS61pqk655aq9C7zKlWCyipu4=;
        b=seUrthE4AlJcr0m9/fKxzP0dTUZYz7Mx6sBPmUeq1GbZW0GqAjf/DDMsJSASfZ1h+I
         r6L7IpuMVn01P0fSJSoWKteWwdTXE6chxpVKW7T4vrzN5kKh3uBHdMieMgtbHYicnZov
         an12QIgbgxohZ8HtptUFDoKIR1AiXwqTcP9ck9GX8EG24I3EacZdsBGdqCFLZtu24Szh
         lsETqQuTAwQnBZGb4dNRpdCMf5u1IIQrmuo//40Rt5h+97Oc3t4sRfBoum19s8sqemYy
         vKEeqVtb6DOSmjDmPdEEfjY9o465r9zfWh2BRbSKh4JvnegcqUvDaoyqCPCVvv1ccxm1
         3Sng==
X-Gm-Message-State: AOJu0YwxO3rKAhp0ic/5W8i8ALy0KgHqYFecYLn5RYp2D5XsY/5X4A0d
        oJZI8cqSLHqmuHUj5eaJE3oRaA==
X-Google-Smtp-Source: AGHT+IHtdHXK+gKFRE1SD8BCf0eWnyuZ16lDv+k6Xh9LB7lmWJfOWwJtzph6DKcNR09TpfcagYNMkA==
X-Received: by 2002:adf:fd4d:0:b0:317:3a23:4855 with SMTP id h13-20020adffd4d000000b003173a234855mr4676769wrs.2.1694697073094;
        Thu, 14 Sep 2023 06:11:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:398c:d142:b5d1:4f7e])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00317ddccb0d1sm1747284wrs.24.2023.09.14.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:11:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH] tracing/user_events: align uaddr on unsigned long alignment
Date:   Thu, 14 Sep 2023 15:11:02 +0200
Message-Id: <20230914131102.179100-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
this will result in a misaligned access on 64 bits architectures since
set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
On architecture that do not support misaligned access, this will crash
the kernel. Align uaddr on unsigned long size to avoid such behavior.
This bug was found while running kselftests on RISC-V.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 kernel/trace/trace_events_user.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 6f046650e527..580c0fe4b23e 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -479,7 +479,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 				    bool fixup_fault, int *attempt)
 {
 	unsigned long uaddr = enabler->addr;
-	unsigned long *ptr;
+	unsigned long *ptr, bit_offset;
 	struct page *page;
 	void *kaddr;
 	int ret;
@@ -511,13 +511,19 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	}
 
 	kaddr = kmap_local_page(page);
+
+	bit_offset = uaddr & (sizeof(unsigned long) - 1);
+	if (bit_offset) {
+		bit_offset *= 8;
+		uaddr &= ~(sizeof(unsigned long) - 1);
+	}
 	ptr = kaddr + (uaddr & ~PAGE_MASK);
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(ENABLE_BIT(enabler), ptr);
+		set_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
 	else
-		clear_bit(ENABLE_BIT(enabler), ptr);
+		clear_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
-- 
2.40.1

