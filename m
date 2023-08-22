Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F26578380F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjHVCi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjHVCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B4193
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C68A64C32
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE025C433CB;
        Tue, 22 Aug 2023 02:38:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qYHI2-001bd9-31;
        Mon, 21 Aug 2023 22:38:42 -0400
Message-ID: <20230822023842.747187890@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Aug 2023 22:38:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>
Subject: [for-linus][PATCH 8/8] samples: ftrace: Replace bti assembly with hint for older compiler
References: <20230822023803.605698724@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

When cross-building the arm64 kernel with allmodconfig using GCC 9.4,
the following error occurs on multiple files under samples/ftrace/:

/tmp/ccPC1ODs.s: Assembler messages:
/tmp/ccPC1ODs.s:8: Error: selected processor does not support `bti c'

Fix this issue by replacing `bti c` with `hint 34`, which is compatible
for the older compiler.

Link: https://lore.kernel.org/linux-trace-kernel/20230820111509.1470826-1-gongruiqi@huaweicloud.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Florent Revest <revest@chromium.org>
Fixes: 8c3526fb86060cb5 ("arm64: ftrace: Add direct call trampoline samples support")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-direct-modify.c       | 4 ++--
 samples/ftrace/ftrace-direct-multi-modify.c | 4 ++--
 samples/ftrace/ftrace-direct-multi.c        | 2 +-
 samples/ftrace/ftrace-direct-too.c          | 2 +-
 samples/ftrace/ftrace-direct.c              | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index e5ed08098ff3..e2a6a69352df 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -105,7 +105,7 @@ asm (
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
-"	bti	c\n"
+"	hint	34\n" // bti	c
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func1\n"
@@ -117,7 +117,7 @@ asm (
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
-"	bti	c\n"
+"	hint	34\n" // bti	c
 "	sub	sp, sp, #16\n"
 "	stp	x9, x30, [sp]\n"
 "	bl	my_direct_func2\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 292cff2b3f5d..2e349834d63c 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -112,7 +112,7 @@ asm (
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
-"	bti	c\n"
+"	hint	34\n" // bti	c
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
@@ -127,7 +127,7 @@ asm (
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
-"	bti	c\n"
+"	hint	34\n" // bti	c
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index b4391e08c913..9243dbfe4d0c 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -75,7 +75,7 @@ asm (
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
-"	bti	c\n"
+"	hint	34\n" // bti	c
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index e9804c5307c0..e39c3563ae4e 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -81,7 +81,7 @@ asm (
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
-"	bti	c\n"
+"	hint	34\n" // bti	c
 "	sub	sp, sp, #48\n"
 "	stp	x9, x30, [sp]\n"
 "	stp	x0, x1, [sp, #16]\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 20f4a7caa810..32c477da1e9a 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -72,7 +72,7 @@ asm (
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
-"	bti	c\n"
+"	hint	34\n" // bti	c
 "	sub	sp, sp, #32\n"
 "	stp	x9, x30, [sp]\n"
 "	str	x0, [sp, #16]\n"
-- 
2.40.1
