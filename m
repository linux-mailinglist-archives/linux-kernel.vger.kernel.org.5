Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0A7E146E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjKEQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjKEQKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:10:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31031BC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 08:10:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEA8C433C8;
        Sun,  5 Nov 2023 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699200650;
        bh=FCiUbQ7cF3hWz3W5mYkLUGazPgX9XWR3NoQQHaWsf5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ElgaphgmZOlJVXyX6c/8ZRvVfsILDJK73lDr2cM6FuDWVRFQVi1Xl/jFjbpWMRuKl
         qiUTseyiLMuAGQB4ygAmSB7CeXSWOh/6CzLH7qYgVRX9Jy+jGPrVg9GVtf+h173CQ9
         RV4Zke/9/N12hKsdXTVkAXIZIkd8YoxEa8A+3icYfbcDv8A5agz9eYlOWWKvZ+II4v
         TlFevh2JOy+CP6/Fv6AcPJ0UFGDoypzm2T99ComFygwZqQrU9IZnD8gBeWnOKNOLaG
         yzscPjTfm/KgcNUMQEjH92QhLUI4kznMLszTu7TS/vyRKNFwBcaWY7y36iecvK3YxB
         pTes6Uyn61cGg==
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
Subject: [RFC PATCH 21/32] function_graph: Expand the max reserved data size
Date:   Mon,  6 Nov 2023 01:10:45 +0900
Message-Id: <169920064470.482486.9772883857059976420.stgit@devnote2>
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

Expand the maximum reserved data size to 32 from 4. On 64bit system,
this will allow reserving 256 bytes on the ret_stack in maximum but
that may not happen.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fgraph.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0b8a1daef733..e7188c67356e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -95,7 +95,7 @@ enum {
 #define FGRAPH_ARRAY_MASK	((1 << FGRAPH_ARRAY_SIZE) - 1)
 #define FGRAPH_ARRAY_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
-#define FGRAPH_DATA_SIZE	2
+#define FGRAPH_DATA_SIZE	5
 #define FGRAPH_DATA_MASK	((1 << FGRAPH_DATA_SIZE) - 1)
 #define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
 
@@ -113,7 +113,7 @@ enum {
 
 #define RET_STACK(t, index) ((struct ftrace_ret_stack *)(&(t)->ret_stack[index]))
 
-#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * 4)
+#define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_SIZE))
 
 /*
  * Each fgraph_ops has a reservered unsigned long at the end (top) of the

