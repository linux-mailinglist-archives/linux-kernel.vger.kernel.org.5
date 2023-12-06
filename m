Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACD180733C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442105AbjLFPAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378993AbjLFPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:00:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B83B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCF0C433C7;
        Wed,  6 Dec 2023 15:00:23 +0000 (UTC)
Date:   Wed, 6 Dec 2023 10:00:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Test last update in 32bit version of
 __rb_time_read()
Message-ID: <20231206100050.3100b7bb@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Since 64 bit cmpxchg() is very expensive on 32bit architectures, the
timestamp used by the ring buffer does some interesting tricks to be able
to still have an atomic 64 bit number. It originally just used 60 bits and
broke it up into two 32 bit words where the extra 2 bits were used for
synchronization. But this was not enough for all use cases, and all 64
bits were required.

The 32bit version of the ring buffer timestamp was then broken up into 3
32bit words using the same counter trick. But one update was not done. The
check to see if the read operation was done without interruption only
checked the first two words and not last one (like it had before this
update). Fix it by making sure all three updates happen without
interruption by comparing the initial counter with the last updated
counter.

Cc: stable@vger.kernel.org
Fixes: f03f2abce4f39 ("ring-buffer: Have 32 bit time stamps use all 64 bits")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a6da2d765c78..8d2a4f00eca9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -644,8 +644,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and bottom counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(bottom))
+	/* If top and msb counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(msb))
 		return false;
 
 	/* The shift to msb will lose its cnt bits */
-- 
2.42.0

