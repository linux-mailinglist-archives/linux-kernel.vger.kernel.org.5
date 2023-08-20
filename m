Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D3C781D88
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjHTLNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 07:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjHTLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 07:13:05 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B300448A;
        Sun, 20 Aug 2023 04:10:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RTCZM3Nn4z4f3lK0;
        Sun, 20 Aug 2023 19:10:19 +0800 (CST)
Received: from ubuntu20.huawei.com (unknown [10.67.174.33])
        by APP2 (Coremail) with SMTP id Syh0CgA3omaW9OFkMkKZBA--.3932S2;
        Sun, 20 Aug 2023 19:10:22 +0800 (CST)
From:   "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        gongruiqi1@huawei.com
Subject: [PATCH] samples: ftrace: replace bti assembly with hint for older compiler
Date:   Sun, 20 Aug 2023 19:15:09 +0800
Message-Id: <20230820111509.1470826-1-gongruiqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA3omaW9OFkMkKZBA--.3932S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw17KF48Gry7Cr47KFy8Krg_yoW5uF4Upa
        9rC3srWF1rAF4DKas7u3WfAFy7t34UXrWDCan5Z34FqasIkrykWrW7trn7Xw4xJr1fCFWx
        XF1DAryUtF43ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: pjrqw2pxltxq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
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
2.25.1

