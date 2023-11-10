Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FA17E82EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbjKJTfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKJTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:34:55 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69C11414
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:11:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so2446560b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699643466; x=1700248266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbEbYA9xamOrAMfvycHRway68YHS/nLJtvjFfgGL1Mc=;
        b=cgmicyGaaPyKcFPqRkTaKw9yMP1zODLEqEhDZNKIglQuvhGkFXUv6pu+PxmM32DWBP
         vyeGubcu6SCWCHDKxMklAKamj/+1KXy8I4EBkNSyHl6rFudm6NdjI4GZ9JbwUY3LcCQV
         2Ny/ZMaUJG+oYzrA6AgcKrS7tXntsV9foydbaNjDEy7LE8bI8dsn57Q6oKRIuHoYDzrf
         BdCqAatA3rV2VvzSnhLgvUR0IrYEiRACD/9gSUzSrX1LTxf01yFfH4MKaLM4rxJXqzvb
         Q9hn/b1mntSRRBLSg1ukLdZsAmt3RMAovc6IHFvu2lX69UgGjaEPByS2LtyoL7YbZ4W8
         +dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699643466; x=1700248266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbEbYA9xamOrAMfvycHRway68YHS/nLJtvjFfgGL1Mc=;
        b=H6rsD63Aug9VLcrGTxxkHc38VZVGaKY59BgOUirC9oS8/49mZgSK8GnCF2Cuh919OT
         sW/qerizZmPrSarl4X5wOadrSrENkXKtRQW7u2nelyQVUxAQ707XRHZevCY1QdxOW4/s
         K1emK9FfJ1M/NvIQJFWvDSxkYMVtbyBwVCs0l6D1Nv5zC9MlCR1lSQNig1DKnKH+B389
         7pZkzj8Bkn5WLEZE/jRNl7DJ3+IhjZBC02ZD8PDvmjKDouYpyLJOsEIccNR7VTQTPL8w
         PXB2PLE3Wq0FgTyoYewuFAZA+M1PTrqfjNJcknkd2z51Wb7T3MoH7SeDcqBBbsFsBzBa
         zDvg==
X-Gm-Message-State: AOJu0YzkrauOAK6PuNyR532SW1LGVt48V3nL7DTngqPl5CwK3nAE7lQ7
        OmL+LwNj10piAzosMzEA9vM=
X-Google-Smtp-Source: AGHT+IE43TNuGQWohhIGg54xObrNbXPCGBQ46cNESuWQKjQAy9BT56Sn9aSe/EHJMF5gcuvLcJsumA==
X-Received: by 2002:a05:6a20:6a9c:b0:185:ebfc:974 with SMTP id bi28-20020a056a206a9c00b00185ebfc0974mr35305pzb.7.1699643466251;
        Fri, 10 Nov 2023 11:11:06 -0800 (PST)
Received: from omkarwagle.hsd1.ca.comcast.net (c-73-92-27-236.hsd1.ca.comcast.net. [73.92.27.236])
        by smtp.gmail.com with ESMTPSA id u16-20020a056a00125000b0068c90e1ec84sm36974pfi.167.2023.11.10.11.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 11:11:05 -0800 (PST)
From:   Omkar Wagle <ov.wagle@gmail.com>
To:     catalin.marinas@arm.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omkar Wagle <ov.wagle@gmail.com>
Subject: [PATCH] mm: kmemleak: Remove security and coding style warning
Date:   Fri, 10 Nov 2023 11:11:02 -0800
Message-Id: <20231110191102.2029-1-ov.wagle@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Remove the security warning arised due to the use of strncpy
Resolve coding style warning

Signed-off-by: Omkar Wagle<ov.wagle@gmail.com>
---
 mm/kmemleak.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eacca03bedd..93b77288754a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * mm/kmemleak.c
  *
  * Copyright (C) 2008 ARM Limited
  * Written by Catalin Marinas <catalin.marinas@arm.com>
@@ -97,7 +96,7 @@
 #include <linux/crc32.h>
 
 #include <asm/sections.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
@@ -368,6 +367,7 @@ static void print_unreferenced(struct seq_file *seq,
 
 	for (i = 0; i < nr_entries; i++) {
 		void *ptr = (void *)entries[i];
+
 		warn_or_seq_printf(seq, "    [<%pK>] %pS\n", ptr, ptr);
 	}
 }
@@ -406,10 +406,11 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
 	while (rb) {
-		struct kmemleak_object *object;
+		struct kmemleak_object *object = NULL;
 		unsigned long untagged_objp;
 
 		object = rb_entry(rb, struct kmemleak_object, rb_node);
+
 		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
 
 		if (untagged_ptr < untagged_objp)
@@ -674,10 +675,10 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 	/* task information */
 	if (in_hardirq()) {
 		object->pid = 0;
-		strncpy(object->comm, "hardirq", sizeof(object->comm));
+		strscpy(object->comm, "hardirq", sizeof(object->comm));
 	} else if (in_serving_softirq()) {
 		object->pid = 0;
-		strncpy(object->comm, "softirq", sizeof(object->comm));
+		strscpy(object->comm, "softirq", sizeof(object->comm));
 	} else {
 		object->pid = current->pid;
 		/*
@@ -686,7 +687,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 		 * dependency issues with current->alloc_lock. In the worst
 		 * case, the command line is not correct.
 		 */
-		strncpy(object->comm, current->comm, sizeof(object->comm));
+		strscpy(object->comm, current->comm, sizeof(object->comm));
 	}
 
 	/* kernel backtrace */
@@ -1662,6 +1663,7 @@ static void kmemleak_scan(void)
 		rcu_read_lock();
 		for_each_process_thread(g, p) {
 			void *stack = try_get_task_stack(p);
+
 			if (stack) {
 				scan_block(stack, stack + THREAD_SIZE, NULL);
 				put_task_stack(p);
@@ -1768,6 +1770,7 @@ static int kmemleak_scan_thread(void *arg)
 	 */
 	if (first_run) {
 		signed long timeout = msecs_to_jiffies(SECS_FIRST_SCAN * 1000);
+
 		first_run = 0;
 		while (timeout && !kthread_should_stop())
 			timeout = schedule_timeout_interruptible(timeout);
@@ -2013,7 +2016,7 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 	else if (strncmp(buf, "scan=off", 8) == 0)
 		stop_scan_thread();
 	else if (strncmp(buf, "scan=", 5) == 0) {
-		unsigned secs;
+		unsigned int secs;
 		unsigned long msecs;
 
 		ret = kstrtouint(buf + 5, 0, &secs);
@@ -2130,8 +2133,7 @@ static int __init kmemleak_boot_config(char *str)
 	else if (strcmp(str, "on") == 0) {
 		kmemleak_skip_disable = 1;
 		stack_depot_request_early_init();
-	}
-	else
+	} else
 		return -EINVAL;
 	return 0;
 }
-- 
2.34.1

