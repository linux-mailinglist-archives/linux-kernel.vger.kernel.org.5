Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7680B8C0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjLJEEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:04:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02A211C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:04:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E44FC433D9;
        Sun, 10 Dec 2023 04:04:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rCB3j-000000021QH-1SGg;
        Sat, 09 Dec 2023 23:04:51 -0500
Message-ID: <20231210040451.136611306@goodmis.org>
User-Agent: quilt/0.67
Date:   Sat, 09 Dec 2023 22:54:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 10/14] tracing: Stop the tracing while changing the ring buffer subbuf size
References: <20231210035404.053677508@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Because the main buffer and the snapshot buffer need to be the same for
some tracers, otherwise it will fail and disable all tracing, the tracers
need to be stopped while updating the sub buffer sizes so that the tracers
see the main and snapshot buffers with the same sub buffer size.

Fixes: TBD ("ring-buffer: Add interface for configuring trace sub buffer size")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7faaaf29b504..9e5f2392d521 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9397,13 +9397,16 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 	if (val < 0 || val > 7)
 		return -EINVAL;
 
+	/* Do not allow tracing while changing the order of the ring buffer */
+	tracing_stop_tr(tr);
+
 	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
 	if (old_order == val)
-		return 0;
+		goto out;
 
 	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
 	if (ret)
-		return 0;
+		goto out;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 
@@ -9430,11 +9433,15 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 			 */
 			tracing_disabled = 1;
 		}
-		return ret;
+		goto out;
 	}
  out_max:
 #endif
 	(*ppos)++;
+ out:
+	if (ret)
+		cnt = ret;
+	tracing_start_tr(tr);
 	return cnt;
 }
 
-- 
2.42.0


