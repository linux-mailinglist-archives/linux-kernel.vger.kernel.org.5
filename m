Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205AD7874EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbjHXQJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242408AbjHXQJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:09:24 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D451F1BD4;
        Thu, 24 Aug 2023 09:09:19 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-34-233.rev.numericable.fr [85.170.34.233])
        by linux.microsoft.com (Postfix) with ESMTPSA id 407962127C69;
        Thu, 24 Aug 2023 09:09:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 407962127C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692893359;
        bh=eq+1QxijG6n2nEwgAu1vbu8Kxc+A8r+ei/HYQRVC7JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sA4CRG1qxSe7mL2Zb9xLOZvjip5GsbhbqdsQpAkogOj2s0B+8WGnhK8fGsEENEh7I
         GvTJEyn0EmTBaZJrl2J33QHmgwFY1dtSDvnqfs7SLroeojYSCQ+NbbDNSJuDTCRMgW
         QhfhC6m0lxPRTsdKwoo9RHpaxhiLw0kxTuTTl9dM=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 1/1] tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols
Date:   Thu, 24 Aug 2023 18:08:59 +0200
Message-Id: <20230824160859.66113-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824160859.66113-1-flaniel@linux.microsoft.com>
References: <20230824160859.66113-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_LOW,
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
because it was attached to a function which was indeed not called, because
the effectively called one has no kprobes attached.

So, this commit returns EADDRNOTAVAIL when func matches several symbols.
This way, user needs to use address to remove the ambiguity.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
---
 kernel/trace/trace_kprobe.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 23dba01831f7..2f393739e8cf 100644
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
+static unsigned int number_of_same_symbols(char *func_name)
+{
+	unsigned int count;
+
+	count = 0;
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+
+	return count;
+}
+
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
@@ -836,6 +855,29 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 	}
 
+	if (symbol) {
+		unsigned int count;
+
+		count = number_of_same_symbols(symbol);
+		if (count > 1) {
+			/*
+			 * Users should use ADDR to remove the ambiguity of
+			 * using KSYM only.
+			 */
+			ret = -EADDRNOTAVAIL;
+
+			goto error;
+		} else if (count == 0) {
+			/*
+			 * We can return ENOENT earlier than when register the
+			 * kprobe.
+			 */
+			ret = -ENOENT;
+
+			goto error;
+		}
+	}
+
 	trace_probe_log_set_index(0);
 	if (event) {
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
@@ -1699,6 +1741,7 @@ static int unregister_kprobe_event(struct trace_kprobe *tk)
 }
 
 #ifdef CONFIG_PERF_EVENTS
+
 /* create a trace_kprobe, but don't add it to global lists */
 struct trace_event_call *
 create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
@@ -1709,6 +1752,24 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 	int ret;
 	char *event;
 
+	if (func) {
+		unsigned int count;
+
+		count = number_of_same_symbols(func);
+		if (count > 1)
+			/*
+			 * Users should use addr to remove the ambiguity of
+			 * using func only.
+			 */
+			return ERR_PTR(-EADDRNOTAVAIL);
+		else if (count == 0)
+			/*
+			 * We can return ENOENT earlier than when register the
+			 * kprobe.
+			 */
+			return ERR_PTR(-ENOENT);
+	}
+
 	/*
 	 * local trace_kprobes are not added to dyn_event, so they are never
 	 * searched in find_trace_kprobe(). Therefore, there is no concern of
-- 
2.34.1

