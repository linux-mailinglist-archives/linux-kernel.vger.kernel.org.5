Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63A7A0AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbjINQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjINQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:34:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9F71FD7;
        Thu, 14 Sep 2023 09:34:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so1340334a12.0;
        Thu, 14 Sep 2023 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694709272; x=1695314072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=of+YvJ0kV8Q4dFYvK0Pmis7yPieSh5jnhBCUjGIn6OA=;
        b=p/9VNrQdZvcKgTnfCbBFMOBylYMoKs7iXwVxleNGertjiqc+6+Hpe/D4g6xy1YAIly
         /LRw609ZzhQBJPIS6eqHkKRrC7pjMaftqf1VFLJKPO/nou6VAcW3jAThD6cqnUFU2Ugd
         GNcU+T0N+bWtXwMxYdnWcpvLJYoKxu0jDO/Saw7f48+zM4Kaba89DB8guNaOpf3+4dVA
         R4sMM8QZn+UgES1dCSpWNenok9ctM5stroNytVrYWRFAb0203HNR8oJERNKjOogOJMVJ
         vtfzc2I97aEoSUZsEXNwMXYvhKqwQvgnDBGQ3Oq7LKzZyIbR77EfLTFv4jW8+EhazFXD
         yUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694709272; x=1695314072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=of+YvJ0kV8Q4dFYvK0Pmis7yPieSh5jnhBCUjGIn6OA=;
        b=oMFdU6YQzu7g6d2YlkOWg/uIrQtEfI75qRA87HtRcHLI7wX7fNnQ9dXEBwesOwoSCU
         VMEnshwHItoubKGP2NuKRnNGp6Nd/MAm6v+8CU0L71/rhuMfXZdCny2boB/BJZVqsJaJ
         VmrnJoEhWZckjS/0xKfYB7ihiT+fcrGm2qmIXGp1RVH2/OCiLdyHSweQ4UDUa1NwzIRI
         uo1/PASEg4a+CJSjMeNBcqtzLIKofL76+pfCAeZidbkn24XPjaO2ACNUc3xTLVeT2F+N
         rmhGdVAxvbrqKoDrNCNaxXI927nPHrEDMDe1A5CRmh39DOoylQOMVB4hBDnfPUeVrn+V
         W/gw==
X-Gm-Message-State: AOJu0YxrXs5pwDp/eMgJQ/h5lmBBaODRPKLH0slAl0Y/D+m7wz/AoH+E
        WocjK+Sqa9hdnMSNTMIiExGfPYcl30o=
X-Google-Smtp-Source: AGHT+IE3GS1SqnKZNLUqaEiGOZCzj2+YwvwEoTevKgXeJIwOO4q1+NisY+g2cGWYWdkv08xg3Q1xHg==
X-Received: by 2002:a05:6402:5163:b0:523:7192:6803 with SMTP id d3-20020a056402516300b0052371926803mr5808648ede.8.1694709271919;
        Thu, 14 Sep 2023 09:34:31 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7d40b000000b005255f5735adsm1136360edq.24.2023.09.14.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:34:31 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] ring_buffer: Use try_cmpxchg instead of cmpxchg in rb_insert_pages
Date:   Thu, 14 Sep 2023 18:34:02 +0200
Message-ID: <20230914163420.12923-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
rb_insert_pages. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a1651edc48d5..3e2a6478425c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2048,7 +2048,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	retries = 10;
 	success = false;
 	while (retries--) {
-		struct list_head *head_page, *prev_page, *r;
+		struct list_head *head_page, *prev_page;
 		struct list_head *last_page, *first_page;
 		struct list_head *head_page_with_bit;
 		struct buffer_page *hpage = rb_set_head_page(cpu_buffer);
@@ -2067,9 +2067,9 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 		last_page->next = head_page_with_bit;
 		first_page->prev = prev_page;
 
-		r = cmpxchg(&prev_page->next, head_page_with_bit, first_page);
-
-		if (r == head_page_with_bit) {
+		/* caution: head_page_with_bit gets updated on cmpxchg failure */
+		if (try_cmpxchg(&prev_page->next,
+				&head_page_with_bit, first_page)) {
 			/*
 			 * yay, we replaced the page pointer to our new list,
 			 * now, we just have to update to head page's prev
-- 
2.41.0

