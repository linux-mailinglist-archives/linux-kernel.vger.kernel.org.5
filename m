Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056737D89AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjJZU2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZU2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:28:30 -0400
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F29191
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:28:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698352105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kXYcCHbJg58Ieumk8Pr2f/O/cn/d7Aaxj+WCDVOiCJ4=;
        b=W2lYs0jBZASwDmrGC7f3bhRJi1VgwgTxiQ3RIZjGLNNdTO8/OPBdW4X4uhHMYI5OiC8QGP
        ciJayvPMPDdB7OySvUkmjqVOmTGfr2FVLWNih5vlqS6+fVpQRGEEEUtyYehvMmDP6rye5y
        TUAua2T66HZ38KRK+FAe2C1E7oaBx5s=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/1] lib/stackdepot: print disabled message only if truly disabled
Date:   Thu, 26 Oct 2023 22:28:16 +0200
Message-Id: <e237a31ef7ca6213c46f87e4609bd7d3eb48fedf.1698351974.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

