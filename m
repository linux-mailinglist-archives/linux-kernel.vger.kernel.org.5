Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5B7E55F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjKHMMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjKHMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:12:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065351BDA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:12:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD7CC433C7;
        Wed,  8 Nov 2023 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699445563;
        bh=+eAilYuOk3JTzvBWmWCHjKEGTbGwH1VoT0du41XzHkM=;
        h=From:To:Cc:Subject:Date:From;
        b=Lg2khy5VnTr4hSSQFTnp+3EWklP0+zB3gDr9gj4Z/o6SJ8jxiIkoJTPtJsFnegZNp
         anTnF8Dwd1+Mi7zOx4cYvm7Cx3jygIRIXrNj6EyYPvffOWhu3Yg2g5yBwOWzr1aSzx
         nYnpUKOSGjWocux6Q9xKVeRq4IPqJoOS4GUkVgS3uytaz9ftdkDY8S1d2pC2GuuVJW
         UWm2A2K1/wxL82pIAh6VuiO23NFwXxZ/7aNOqagpv08GHxOTlklRP7GaH5aJQPzk0f
         jFkViraw267rOfbFY1OecCtZXdfsAseSRzmSD9ZEdY/RNuVYnkZrKS/G9YGxubif9k
         Fi7qz5ArBZzzQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH v2] tracing: fprobe-event: Fix to check tracepoint event and return
Date:   Wed,  8 Nov 2023 21:12:39 +0900
Message-Id: <169944555933.45057.12831706585287704173.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to check the tracepoint event is not valid with $retval.
The commit 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is
a return event by $retval") introduced automatic return probe
conversion with $retval. But since tracepoint event does not
support return probe, $retval is not acceptable.

Without this fix, ftracetest, tprobe_syntax_errors.tc fails;

[22] Tracepoint probe event parser error log check      [FAIL]
 ----
 # tail 22-tprobe_syntax_errors.tc-log.mRKroL
 + ftrace_errlog_check trace_fprobe t kfree ^$retval dynamic_events
 + printf %s t kfree
 + wc -c
 + pos=8
 + printf %s t kfree ^$retval
 + tr -d ^
 + command=t kfree $retval
 + echo Test command: t kfree $retval
 Test command: t kfree $retval
 + echo
 ----

So 't kfree $retval' should fail (tracepoint doesn't support
return probe) but passed it.

Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return event by $retval")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
   - update the patch description to show what test fails.
---
 kernel/trace/trace_fprobe.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 8bfe23af9c73..7d2ddbcfa377 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -927,11 +927,12 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	for (i = 2; i < argc; i++) {
 		tmp = strstr(argv[i], "$retval");
 		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
+			if (is_tracepoint) {
+				trace_probe_log_set_index(i);
+				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
+				return -EINVAL;
+			}
 			*is_return = true;
-			/*
-			 * NOTE: Don't check is_tracepoint here, because it will
-			 * be checked when the argument is parsed.
-			 */
 			break;
 		}
 	}

