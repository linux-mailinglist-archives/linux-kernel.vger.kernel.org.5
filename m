Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBA7E062F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbjKCQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbjKCQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:05:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4E10CB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 09:05:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F97C433C8;
        Fri,  3 Nov 2023 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699027537;
        bh=42XsnqbyTprpNrPutNcSPJ0ocVxY+O1eGVuizrcPzPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=V+svcMXQEE59e8NPP7hQaymVRI7+VVp25l2JUTUbXDECOKKN861W2FmBlBxlKec0N
         oIhfNvDvozXf9p6d6mDUeEypsztSH8kiFpUle4boNbuaNWbBoQUNVvyhjCCZqDY+Dl
         l7fYuhH4UTA34U3ZD3eA25HO78vEYVcI27runOsQQOab01ZaVPXLcK4qnhqsDy2gKw
         RiuUw80Us8P/qQeLekoske5zOezrthQeuacT9iwaG71tKjB/GN6VmfHODhAxoP0CK7
         benfgQGdCkfGW2Qtv+DZJpVBe9qf3FpxhiVQfxTREbUSei0reVuAqnN5j2E+v7pJ3P
         HkQAe2Z8p4tcg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH] tracing: fprobe-event: Fix to check tracepoint event and return
Date:   Sat,  4 Nov 2023 01:05:34 +0900
Message-Id: <169902753361.313086.6662802092416198593.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to check the tracepoint event is not valid with $retval.
The commit 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is
a return event by $retval") introduced automatic return probe
conversion with $retval. But since tracepoint event does not
support return probe, $retval is not acceptable.

Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return event by $retval")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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

