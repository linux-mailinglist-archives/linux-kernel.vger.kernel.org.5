Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B598A791A88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349963AbjIDPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjIDPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:23:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF7219A9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:22:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bed101b70so243993466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693840962; x=1694445762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=323vdBuxHbzfbTouYgBjNEzO4rAlD1GsQQDDZWD9Blg=;
        b=DORy+/3sn5yDP8O6ZIjlm3te2ZZmZr8lyDKMhTPo4hQqu/P8EdQ6qZId5ZkG0PcNNq
         fw/Ua391DXbMsaRM5Vh9rcPt2JA4nYGm7X3fSA9ee0wgPCOwbS21RIRlFMwDrlOlpr7x
         R6eE769XcHyjiikGqnDwKhRdWBarGAi/q5+MSYue1U06PiLe8NIfBfLAhIGqf9bR0mlL
         bKybCyT9MJxCbrjKxS/Fu3nDMjQFZcA9XHl3QMYUnW1PnTL2RJOz63mDvtpeQpyhRt1z
         ySvv0v6TynTohTbYIFSqJ27BrcbDMuxON8tLQN17KhfGqxQlrjU9Ts5wX5wuEdny49i9
         AhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693840962; x=1694445762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=323vdBuxHbzfbTouYgBjNEzO4rAlD1GsQQDDZWD9Blg=;
        b=BvurgxREbLAIAHBOiD42E5lhcz9GvmD+kB5nfWfWrZu0oX+vbqHYxMyDQdmwe0vjk3
         tKGS7uIMiVQkmZxJV54mvmCJu6t9szBpXsf0pXQgwGcc6Foo4j/ChR4L3A69SI9aEdAs
         54EyX6RVsk2XYG87gjqgkhEny9Uhv9YHbLFb0g5qE7nsZVzkPewNxbeaQINFI3wWyffV
         FNtc9oDCFhZPtpVmvd82nQybPmsLxR6+z4ke2WD94BpSj0pJbGK1+zo4DOJ22M528g4a
         9jQIQEEIHanU6VQziKZdY94fzY+PssdOCF0jIv8duGb0c6/1iJxAut2N9/4gpG0K2tPr
         hOPg==
X-Gm-Message-State: AOJu0Yyu2vOy7BF/DlxKYJYrdNhwYQ5J3Okf87FRJoUE3baAeyLJw+hR
        oznTrlN1yMSfBKAIbZAk5u1wJqndNPmivQ==
X-Google-Smtp-Source: AGHT+IFK4sQFrf6N6lVjyi74AfhL/FMSOqHrsM6TOirMhggEKlkMH99BGqkFUFW/IAvZOLVrETZdvQ==
X-Received: by 2002:a17:907:78c2:b0:9a1:b05a:c07c with SMTP id kv2-20020a17090778c200b009a1b05ac07cmr9000209ejc.55.1693840962250;
        Mon, 04 Sep 2023 08:22:42 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906078d00b009a5f1d15642sm6246182ejc.158.2023.09.04.08.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:22:42 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] panic: Use atomic_try_cmpxchg in panic() and nmi_panic()
Date:   Mon,  4 Sep 2023 17:21:01 +0200
Message-ID: <20230904152230.9227-1-ubizjak@gmail.com>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/panic.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 07239d4ad81e..8740ac65cb2c 100644
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
+	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
+		;
+	else if (old_cpu != this_cpu)
 		panic_smp_self_stop();
 
 	console_verbose();
-- 
2.41.0

