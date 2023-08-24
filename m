Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F3786CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjHXKiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbjHXKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:37:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57F1C1991;
        Thu, 24 Aug 2023 03:37:54 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id BBE012127C7F;
        Thu, 24 Aug 2023 03:37:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BBE012127C7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692873473;
        bh=I8WXTCrWpAb1t+kSXXGFKAGPFsAXK2qy1KAPyMr4kV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fF31yQFTcxJwUJrcZWiePXkgekuB43aQk6+YnD98KB7PVvPtmWW4UKENsVll8oYt2
         uYiiomx3GQ4xgx2IvUAT9s8vaw2ItweLh5Hy6ZWF7PldqDH6wqdkCN86+xNFRgXAr9
         oVq1nVtimqfqoK9AQMjzuzwB7iVrdju5w5IxOcQA=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH v2 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date:   Thu, 24 Aug 2023 12:37:34 +0200
Message-Id: <20230824103734.53453-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824103734.53453-1-flaniel@linux.microsoft.com>
References: <20230824103734.53453-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously to this commit, if func matches several symbols, a kprobe, being
either sysfs or PMU, would only be installed for the first matching address.
This could lead to some misunderstanding when some BPF code was never called
because it was attached to a function which was indeed not call, because the
effectively called one has no kprobes.

So, this commit returns EADDRNOTAVAIL when func matches several symbols.
This way, user needs to use addr to remove the ambiguity.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
---
 kernel/trace/trace_kprobe.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23dba01831f7..0c8dd6ba650b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -705,6 +705,25 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.priority = 1	/* Invoked after kprobe module callback */
 };
 
+static int count_symbols(void *data, unsigned long unused)
+{
+	unsigned int *count = data;
+
+	(*count)++;
+
+	return 0;
+}
+
+static unsigned int func_name_several_symbols(char *func_name)
+{
+	unsigned int count;
+
+	count = 0;
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+
+	return count > 1;
+}
+
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -836,6 +855,18 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 	}
 
+	/*
+	 * If user specifies KSYM, we check it does not correspond to several
+	 * symbols.
+	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
+	 * he/she should use ADDR rather than KSYM to remove the ambiguity.
+	 */
+	if (symbol && func_name_several_symbols(symbol)) {
+		ret = -EADDRNOTAVAIL;
+
+		goto error;
+	}
+
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1699,6 +1730,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 }
 
 #ifdef CONFIG_PERF_EVENTS
+
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
@@ -1709,6 +1741,16 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;
 
+	/*
+	 * If user specifies func, we check that function name does not
+	 * correspond to several symbols.
+	 * If this is the case, we return EADDRNOTAVAIL to indicate the user
+	 * he/she should use addr and offs rather than func to remove the
+	 * ambiguity.
+	 */
+	if (func && func_name_several_symbols(func))
+		return ERR_PTR(-EADDRNOTAVAIL);
+
 	/*
 	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
-- 
2.34.1

