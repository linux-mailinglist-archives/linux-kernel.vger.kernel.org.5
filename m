Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCD80D30F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjLKQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjLKQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:59:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF18E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:59:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FE0C433C7;
        Mon, 11 Dec 2023 16:59:09 +0000 (UTC)
Date:   Mon, 11 Dec 2023 11:59:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Never use absolute timestamp for start event
Message-ID: <20231211115949.4692e429@gandalf.local.home>
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

On 32bit machines, the 64 bit timestamps are broken up into 32 bit words
to keep from using local64_cmpxchg(), as that is very expensive on 32 bit
architectures.

On 32 bit architectures, reading these timestamps can happen in a middle
of an update. In this case, the read returns "false", telling the caller
that the timestamp is in the middle of an update, and it needs to assume
it is corrupted. The code then accommodates this.

When first reserving space on the ring buffer, a "before_stamp" and
"write_stamp" are read. If they do not match, or if either is in the
process of being updated (false was returned from the read), an absolute
timestamp is added and the delta is not used, as that requires reading
theses timestamps without being corrupted.

The one case that this does not matter is if the event is the first event
on the sub-buffer, in which case, the event uses the sub-buffer's
timestamp and doesn't need the other stamps for calculating them.

After some work to consolidate the code, if the before or write stamps are
in the process of updating, an absolute timestamp will be added regardless
if the event is the first event on the sub-buffer. This is wrong as it
should not care about the success of these reads if it is the first event
on the sub-buffer.

Fix up the parenthesis so that even if the timestamps are corrupted, if
the event is the first event on the sub-buffer (w == 0) it still does not
force an absolute timestamp.

Cc: stable@vger.kernel.org
Fixes: 58fbc3c63275c ("ring-buffer: Consolidate add_timestamp to remove some branches")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 02bc9986fe0d..bc70cb9bbdb7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3584,7 +3584,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 		 * absolute timestamp.
 		 * Don't bother if this is the start of a new page (w == 0).
 		 */
-		if (unlikely(!a_ok || !b_ok || (info->before != info->after && w))) {
+		if (unlikely((!a_ok || !b_ok || info->before != info->after) && w)) {
 			info->add_timestamp |= RB_ADD_STAMP_FORCE | RB_ADD_STAMP_EXTEND;
 			info->length += RB_LEN_TIME_EXTEND;
 		} else {
-- 
2.42.0

