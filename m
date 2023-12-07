Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C5807EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443103AbjLGCiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443058AbjLGChp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:37:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8572AD51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 18:37:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACC2C433C9;
        Thu,  7 Dec 2023 02:37:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rB4HN-00000001aQB-03PE;
        Wed, 06 Dec 2023 21:38:21 -0500
Message-ID: <20231207023820.797727180@goodmis.org>
User-Agent: quilt/0.67
Date:   Wed, 06 Dec 2023 21:38:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [for-linus][PATCH 8/8] ring-buffer: Test last update in 32bit version of __rb_time_read()
References: <20231207023752.712829638@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Link: https://lore.kernel.org/linux-trace-kernel/20231206100050.3100b7bb@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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


