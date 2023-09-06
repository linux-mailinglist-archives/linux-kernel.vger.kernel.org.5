Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292679439E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbjIFTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbjIFTM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:12:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA291BE3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:12:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so129269a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694027539; x=1694632339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WiKrU+R9EICF7MYvUusdx4SN2ZECMRM5ZZ8PiUG5tjk=;
        b=l7pNNKgpmPVZUdVmtIhengLKbH9ZQtm1Qs6tnm9E7rrkD0NFXQZLrjKVhgz9G159LB
         ZH1s96I6hbgIW8FGr45w/zYS79hIk+72eYk1e9zLKvedYPngX79L3uai6YTQA4Df71d6
         3O78i1MToPE5/vyoaz8MpbCRDpLXXwpSaZbCgRr7LUgZssh2mdTQT5k0DggPs6SIRvWb
         xND2PFflDnT0Q1XSYJ3pDdrNkb9fERQdt0FVKx3UAwod6mlX0w5W2H5c0Hf+WNDnV81y
         kqlCLP4oIySi8xClUtbEIihheRd3qrM5YruA2z+Wr+QBvPB+/9yx0+ND25Brq8E/DfV+
         JHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027539; x=1694632339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiKrU+R9EICF7MYvUusdx4SN2ZECMRM5ZZ8PiUG5tjk=;
        b=feIRT8Qw7Ys89kiAVar6XqPrX1g6F6vJQ8dquDnM9Barj5nQhbveORSJOh6/4e4Tro
         8JXqRP1iqJmPiKJJukWYDSnkNSe8fJJOFfpsaaAcy4eWKsMHM+olv6Zu1ZGhEKZtHmKn
         hHpW0DuPcfPWariQ/uSH3orjO9neR3itmig8TEJAynqoahLUO4js37sD/Osry6GX25tu
         L05F7FRVEoUWUFoesMZIdKutqTRqRD7p3sEsX9tnWDddR7rh3zhprEymbes65sttF0r1
         +2KnyE5qq5lDgBBn60KVosZy6Fmv7aoSZoACtmlFdioSh8JNDz9S3EmF/Q8IWTx7E3C+
         Lvqw==
X-Gm-Message-State: AOJu0YwJ4v9obFsazfSAvYitByUgIkCzfbd1L5taKciQVLjJxuektYcA
        c68HoUNauzooby1Li44x8AJWLiszF51Ibg==
X-Google-Smtp-Source: AGHT+IHfMPZIKL1fJMKu+bMhHwolOE3sJbGBizXoFz0cd7PTaLG9sMm8Afr9mdaWy4/dyqgAKT1XkA==
X-Received: by 2002:a05:6402:1844:b0:522:2711:863 with SMTP id v4-20020a056402184400b0052227110863mr3021914edy.1.1694027538814;
        Wed, 06 Sep 2023 12:12:18 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a056402150200b0052a3b212157sm8693932edw.63.2023.09.06.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:12:18 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] panic: Use atomic_try_cmpxchg in panic() and nmi_panic()
Date:   Wed,  6 Sep 2023 21:11:28 +0200
Message-ID: <20230906191200.68707-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
in panic() and nmi_panic().  x86 CMPXCHG instruction returns success in
ZF flag, so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, rename cpu variable to this_cpu in nmi_panic() and try to unify
logic flow between panic() and nmi_panic().

No functional change intended.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Replace semicolon with empty function body including comment.
---
 kernel/panic.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 07239d4ad81e..9721492cf8a5 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -192,14 +192,15 @@ atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
  */
 void nmi_panic(struct pt_regs *regs, const char *msg)
 {
-	int old_cpu, cpu;
+	int old_cpu, this_cpu;
 
-	cpu = raw_smp_processor_id();
-	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
+	old_cpu = PANIC_CPU_INVALID;
+	this_cpu = raw_smp_processor_id();
 
-	if (old_cpu == PANIC_CPU_INVALID)
+	/* atomic_try_cmpxchg updates old_cpu on failure */
+	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
 		panic("%s", msg);
-	else if (old_cpu != cpu)
+	else if (old_cpu != this_cpu)
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
@@ -311,15 +312,18 @@ void panic(const char *fmt, ...)
 	 * stop themself or will wait until they are stopped by the 1st CPU
 	 * with smp_send_stop().
 	 *
-	 * `old_cpu == PANIC_CPU_INVALID' means this is the 1st CPU which
-	 * comes here, so go ahead.
+	 * cmpxchg success means this is the 1st CPU which comes here,
+	 * so go ahead.
 	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
 	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
 	 */
+	old_cpu = PANIC_CPU_INVALID;
 	this_cpu = raw_smp_processor_id();
-	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
 
-	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
+	/* atomic_try_cmpxchg updates old_cpu on failure */
+	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+		/* go ahead */
+	} else if (old_cpu != this_cpu)
 		panic_smp_self_stop();
 
 	console_verbose();
-- 
2.41.0

