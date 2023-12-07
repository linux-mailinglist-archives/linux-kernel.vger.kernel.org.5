Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86080955A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjLGWae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjLGWac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:30:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D70BA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:30:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24756C433C8;
        Thu,  7 Dec 2023 22:30:38 +0000 (UTC)
Date:   Thu, 7 Dec 2023 17:31:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] ring-buffer: Add offset of events in dump on mismatch
Message-ID: <20231207173108.484b912c@gandalf.local.home>
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

On bugs that have the ring buffer timestamp get out of sync, the config
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS, that checks for it and if it is
detected it causes a dump of the bad sub buffer.

It shows each event and their timestamp as well as the delta in the event.
But it's also good to see the offset into the subbuffer for that event to
know if how close to the end it is.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20231207171613.0592087d@gandalf.local.home

- Add "0x" before the "%x" to make the print less confusing (Mathieu Desnoyers)

 kernel/trace/ring_buffer.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8d2a4f00eca9..09d4b1aa8820 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3424,23 +3424,27 @@ static void dump_buffer_page(struct buffer_data_page *bpage,
 		case RINGBUF_TYPE_TIME_EXTEND:
 			delta = rb_event_time_stamp(event);
 			ts += delta;
-			pr_warn("  [%lld] delta:%lld TIME EXTEND\n", ts, delta);
+			pr_warn(" 0x%x: [%lld] delta:%lld TIME EXTEND\n",
+				e, ts, delta);
 			break;
 
 		case RINGBUF_TYPE_TIME_STAMP:
 			delta = rb_event_time_stamp(event);
 			ts = rb_fix_abs_ts(delta, ts);
-			pr_warn("  [%lld] absolute:%lld TIME STAMP\n", ts, delta);
+			pr_warn(" 0x%x:  [%lld] absolute:%lld TIME STAMP\n",
+				e, ts, delta);
 			break;
 
 		case RINGBUF_TYPE_PADDING:
 			ts += event->time_delta;
-			pr_warn("  [%lld] delta:%d PADDING\n", ts, event->time_delta);
+			pr_warn(" 0x%x:  [%lld] delta:%d PADDING\n",
+				e, ts, event->time_delta);
 			break;
 
 		case RINGBUF_TYPE_DATA:
 			ts += event->time_delta;
-			pr_warn("  [%lld] delta:%d\n", ts, event->time_delta);
+			pr_warn(" 0x%x:  [%lld] delta:%d\n",
+				e, ts, event->time_delta);
 			break;
 
 		default:
-- 
2.42.0

