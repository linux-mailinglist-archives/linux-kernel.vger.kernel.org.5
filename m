Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC6A7567C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjGQPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjGQPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345C410DA;
        Mon, 17 Jul 2023 08:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC236112A;
        Mon, 17 Jul 2023 15:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EF8C433C7;
        Mon, 17 Jul 2023 15:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689607411;
        bh=cvdO36sarOiv5ZpCKU2EQAmrbByydT2MCd5DqCQtaFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CiXJ4YoiIgypHxscNLzvVUm/eIK/XxIR43zivwBPTByv4h1w2LYd6zyEgyEiBIBrS
         UPpJHHiZe+fNd/ZojAuxR4+P5/pPkM9yBbGjByYAoLLiWrZKWf/BHq78hdMY4XJBz2
         tgDychYcg15CMuYi3XkTGuGtcnQTIlc3fyLdrXli3bbCl84QOJWRyM74DcLoldDoRn
         +9nWFfvceH7Ssv+9kw3oj7pABfrbMb4xnYq4MprQx80XHQ32WW8fMLG6JLf6Ne8Ldi
         CS7YfmLgmDcUeOjnvHW9FuZRgAXPkoWZvbzHEw0H0eoYYkyfesnanBBH6+YJ19s+Kp
         6CcB0qvYJ8kBg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 1/9] tracing/probes: Fix to add NULL check for BTF APIs
Date:   Tue, 18 Jul 2023 00:23:27 +0900
Message-Id: <168960740754.34107.12202350138610653557.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168960739768.34107.15145201749042174448.stgit@devnote2>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since find_btf_func_param() abd btf_type_by_id() can return NULL,
the caller must check the return value correctly.

Fixes: b576e09701c7 ("tracing/probes: Support function parameters if BTF is available")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index b2b726bea1f9..c68a72707852 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -386,12 +386,12 @@ static const struct btf_type *find_btf_func_proto(const char *funcname)
 
 	/* Get BTF_KIND_FUNC type */
 	t = btf_type_by_id(btf, id);
-	if (!btf_type_is_func(t))
+	if (!t || !btf_type_is_func(t))
 		return ERR_PTR(-ENOENT);
 
 	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
 	t = btf_type_by_id(btf, t->type);
-	if (!btf_type_is_func_proto(t))
+	if (!t || !btf_type_is_func_proto(t))
 		return ERR_PTR(-ENOENT);
 
 	return t;
@@ -443,7 +443,7 @@ static int parse_btf_arg(const char *varname, struct fetch_insn *code,
 	if (!ctx->params) {
 		params = find_btf_func_param(ctx->funcname, &ctx->nr_params,
 					     ctx->flags & TPARG_FL_TPOINT);
-		if (IS_ERR(params)) {
+		if (IS_ERR_OR_NULL(params)) {
 			trace_probe_log_err(ctx->offset, NO_BTF_ENTRY);
 			return PTR_ERR(params);
 		}
@@ -1273,7 +1273,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 
 	params = find_btf_func_param(ctx->funcname, &nr_params,
 				     ctx->flags & TPARG_FL_TPOINT);
-	if (IS_ERR(params)) {
+	if (IS_ERR_OR_NULL(params)) {
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);

