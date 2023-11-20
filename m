Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F5B7F1B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjKTRrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjKTRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:47:32 -0500
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [IPv6:2001:41d0:203:375::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB29BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:47:29 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mwqfN/pqk9HRQ931HoPPP333OlumxbY++YPCTeY76U=;
        b=bR/I30d5ng/lYBtNQqgdoGfH5paO2CtcP21wojJGbtHFG33q9OSF6VODY4kRaiORiokLQo
        iZpd9D4Xa29yBgsAA1WjhOAcCg0lSOCGSH3njrApHXcLDY08VxXeaX0yqJ6yzjAbR1DXy7
        0Hwm3iz+UTEkMpPA3RFCPkvRL0wjaJM=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 01/22] lib/stackdepot: print disabled message only if truly disabled
Date:   Mon, 20 Nov 2023 18:46:59 +0100
Message-Id: <73a25c5fff29f3357cd7a9330e85e09bc8da2cbe.1700502145.git.andreyknvl@google.com>
In-Reply-To: <cover.1700502145.git.andreyknvl@google.com>
References: <cover.1700502145.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Currently, if stack_depot_disable=off is passed to the kernel
command-line after stack_depot_disable=on, stack depot prints a message
that it is disabled, while it is actually enabled.

Fix this by moving printing the disabled message to
stack_depot_early_init. Place it before the
__stack_depot_early_init_requested check, so that the message is printed
even if early stack depot init has not been requested.

Also drop the stack_table = NULL assignment from disable_stack_depot,
as stack_table is NULL by default.

Fixes: e1fdc403349c ("lib: stackdepot: add support to disable stack depot")
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2f5aa851834e..0eeaef4f2523 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -101,14 +101,7 @@ static int next_pool_required = 1;
 
 static int __init disable_stack_depot(char *str)
 {
-	int ret;
-
-	ret = kstrtobool(str, &stack_depot_disabled);
-	if (!ret && stack_depot_disabled) {
-		pr_info("disabled\n");
-		stack_table = NULL;
-	}
-	return 0;
+	return kstrtobool(str, &stack_depot_disabled);
 }
 early_param("stack_depot_disable", disable_stack_depot);
 
@@ -130,6 +123,15 @@ int __init stack_depot_early_init(void)
 		return 0;
 	__stack_depot_early_init_passed = true;
 
+	/*
+	 * Print disabled message even if early init has not been requested:
+	 * stack_depot_init() will not print one.
+	 */
+	if (stack_depot_disabled) {
+		pr_info("disabled\n");
+		return 0;
+	}
+
 	/*
 	 * If KASAN is enabled, use the maximum order: KASAN is frequently used
 	 * in fuzzing scenarios, which leads to a large number of different
@@ -138,7 +140,11 @@ int __init stack_depot_early_init(void)
 	if (kasan_enabled() && !stack_bucket_number_order)
 		stack_bucket_number_order = STACK_BUCKET_NUMBER_ORDER_MAX;
 
-	if (!__stack_depot_early_init_requested || stack_depot_disabled)
+	/*
+	 * Check if early init has been requested after setting
+	 * stack_bucket_number_order: stack_depot_init() uses its value.
+	 */
+	if (!__stack_depot_early_init_requested)
 		return 0;
 
 	/*
-- 
2.25.1

