Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5C7E1466
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKEQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjKEQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:10:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E17184
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:10:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D602C433C8;
        Sun,  5 Nov 2023 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699200604;
        bh=6QXlcdrE6Vd0uevCRAQA5jRWA9Z4WkVDk80uAUwbJ/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/CoB3R0PwHpStxpBdcBy486i6VbtYtAR1YYmvlMJgWlkvwAslfAM1MBCOHQznEuS
         EKB3GpxYg2osZ0mbNEFlBtDFS7IVzI8nLjnyHdFfeaBzk/uPzEYKy3lm1Bh7rSay0R
         qkBO9K4WnNjpxWMohFj5Bz6IizDWDIk+eYYnnzFX5DId19isCVydBj6Z1yGqVq2lxc
         vsiYZsNeJERJi8N1ScBOr5UoHyCG75QN3HFIMfGa2X5DeJe5Y5ak8aag8MhZQpGBcn
         kpy8+KCP3F7miOXW/IulJ9Y5Nh6snHUESFyYCkL2wO64KgRqRsaKfBZSyp+XcguuOu
         wfUKgBO98l/PA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH 17/32] function_graph: Fix to update curr_ret_stack with ARRAY entry size
Date:   Mon,  6 Nov 2023 01:09:57 +0900
Message-Id: <169920059747.482486.11622923727523240888.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169920038849.482486.15796387219966662967.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

__ftrace_return_to_handler() missed to update the curr_ret_stack when it
gets a FGRAPH_TYPE_ARRAY. Since that type entry will follows some data
words, it must update curr_ret_stack by entry size value (__get_index(val))
instead of 1.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0f8e9f22e9e0..597250bd30dc 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -740,7 +740,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 		case FGRAPH_TYPE_ARRAY:
 			idx = __get_array(val);
 			fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
-			fallthrough;
+			curr_ret_stack -= __get_index(val);
+			break;
 		case FGRAPH_TYPE_RESERVED:
 			curr_ret_stack--;
 			break;

