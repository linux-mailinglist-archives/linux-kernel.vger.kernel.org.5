Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F207FFFA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377376AbjK3XmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377438AbjK3Xl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD3A19B6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a186e5d1056so189226266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387712; x=1701992512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbG5LyFeXhU+t73dZalR5ZvW0pWNtNjpv2RI0v041So=;
        b=MI5jhd1Vfz06GV4aL23OTdh640xToqHdObCXts6urMD8ldzyn74kgOzvuOsDT4LjuQ
         Bpqpn7O1tKXBNhM/AE/Dav8tQ9Ire2j1v0UgiaNxwCASg6FcHDXJtET6qArVKV3DUp4D
         Y+SAwteT5a2O2rqV8+adbZDHvwcCCeKbKvX2ZWz7zmhjB2CfOJDIUaTAmWq8aA7P9JWk
         QMjjL8+8jyGTOpSHiDKIgBRu5BBZtqgW1w1woIr72C/mGj0jii5TtDOVj8350k1V0h0T
         h8zi0szM5zE2ErPSx+i1V/b55llFCIT3U8kLjnRA+mj2TB5ugQf/V1yNpnjh9m4Iuiad
         yL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387712; x=1701992512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbG5LyFeXhU+t73dZalR5ZvW0pWNtNjpv2RI0v041So=;
        b=GXDa0kNhxmyTi8nHssvW1fPamiwaVmQIV/1J2A3IUWb4ggwL96ye8rUpBswTorKBKB
         GdJmwsFdLhLIdi9DFcn9fefuzy9xn1KCKKDX/hSE08Y7/sVmVmXSxqSKHxjHwD3pw8wd
         ZErpRS+d1EL/LFRM2SloTEHtDHhee4YYUSoQ1JqkqZhO7EVuRIxFQHxXnq3ZPMB1r/X2
         p/tlUPOhcf2WryIKUeVtm55Vy3DyLb3MpgwbErrI6aDuoUEbPchNASKTTPSwWD45QKfD
         qn7Apko8kYX3oMGB8lqrd9cmldRtBxuRae3VMH8imLeFKDXMhNIk4Kqqa1z4Sp/h540L
         iKaA==
X-Gm-Message-State: AOJu0Yyj2/Lhmsea/Vs5tz5hucn2AdK1w1tHjAk9DsevvKeVYhMc9eD0
        8jt2iwJBY46d3RYLX8nM8p61
X-Google-Smtp-Source: AGHT+IH/K003PUTn+LuhrnmXz94foquKLOZJ6iKVlGr6KzE4qDpYh3bAqkvgM4AxVSfTdNWux+iaeg==
X-Received: by 2002:a17:906:1347:b0:a17:d57f:a851 with SMTP id x7-20020a170906134700b00a17d57fa851mr211812ejb.61.1701387712674;
        Thu, 30 Nov 2023 15:41:52 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:52 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v2 10/15] dyndbg: add open and close commands for trace
Date:   Fri,  1 Dec 2023 00:40:43 +0100
Message-ID: <20231130234048.157509-11-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add open and close commands for opening and closing trace instances.
The open command has to be mandatory followed by a trace instance name.
If a trace instance already exists in <debugfs>/tracing/instances
directory then the open command will reuse it otherwise a new trace
instance with a name provided to the open will be created. Close
command closes previously opened trace instance. The close will
fail if a user tries to close non-existent trace instances or an
instance which was not previously opened.

For example the following command will open (create or reuse existing)
trace instance located in <debugfs>/tracing/instances/usbcore:

    echo "open usbcore" > <debugfs>/dynamic_debug/control

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/Kconfig.debug   |   1 +
 lib/dynamic_debug.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5bc56c7247a2..f184c3c91ba3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -181,6 +181,7 @@ config DYNAMIC_DEBUG_CORE
 	bool "Enable core function of dynamic debug support"
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	depends on TRACING
 	help
 	  Enable core functional support of dynamic debug. It is useful
 	  when you want to tie dynamic debug to your kernel modules with
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0dc9ec76b867..43e94023a4eb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <linux/trace.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dyndbg.h>
@@ -73,6 +74,25 @@ struct flag_settings {
 	unsigned int mask;
 };
 
+#define DD_OPEN_CMD	"open"
+#define DD_CLOSE_CMD	"close"
+#define DD_TR_EVENT	"0"
+
+struct ddebug_trace_inst {
+	const char *name;
+	struct trace_array *arr;
+};
+
+/*
+ * TRACE_DST_MAX value is reserved for writing
+ * debug logs to trace events (prdbg, devdbg)
+ */
+struct ddebug_trace {
+	struct ddebug_trace_inst inst[TRACE_DST_MAX-1];
+	DECLARE_BITMAP(bmap, TRACE_DST_MAX-1);
+	int bmap_size;
+};
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -80,6 +100,8 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static struct ddebug_trace tr = { .bmap_size = TRACE_DST_MAX-1 };
+
 static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
 {
 	return &desc->ctrl;
@@ -171,6 +193,148 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+static bool is_ddebug_cmd(const char *str)
+{
+	if (!strcmp(str, DD_OPEN_CMD) ||
+	    !strcmp(str, DD_CLOSE_CMD))
+		return true;
+
+	return false;
+}
+
+static bool validate_tr_name(const char *str)
+{
+	/* "0" is reserved for writing debug logs to trace events (prdbg, devdbg) */
+	if (!strcmp(str, DD_TR_EVENT))
+		return false;
+
+	/* we allow trace instance names to include ^\w+ and underscore */
+	while (*str != '\0') {
+		if (!isalnum(*str) && *str != '_')
+			return false;
+		str++;
+	}
+
+	return true;
+}
+
+static int find_tr_instance(const char *name)
+{
+	int idx;
+
+	for_each_set_bit(idx, tr.bmap, tr.bmap_size)
+		if (!strcmp(tr.inst[idx].name, name))
+			return idx;
+
+	return -ENOENT;
+}
+
+static int handle_tr_opend_cmd(const char *arg)
+{
+	struct ddebug_trace_inst *inst;
+	int idx, ret = 0;
+
+	mutex_lock(&ddebug_lock);
+
+	idx = find_first_zero_bit(tr.bmap, tr.bmap_size);
+	if (idx == tr.bmap_size) {
+		ret = -ENOSPC;
+		goto end;
+	}
+
+	if (!validate_tr_name(arg)) {
+		pr_err("invalid instance name:%s\n", arg);
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (find_tr_instance(arg) >= 0) {
+		pr_err("instance is already opened name:%s\n ", arg);
+		ret = -EEXIST;
+		goto end;
+	}
+
+	inst = &tr.inst[idx];
+	inst->name = kstrdup(arg, GFP_KERNEL);
+	if (!inst->name) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	inst->arr = trace_array_get_by_name(inst->name);
+	if (!inst->arr) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = trace_array_init_printk(inst->arr);
+	if (ret) {
+		trace_array_put(inst->arr);
+		trace_array_destroy(inst->arr);
+		goto end;
+	}
+
+	set_bit(idx, tr.bmap);
+	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
+end:
+	mutex_unlock(&ddebug_lock);
+	return ret;
+}
+
+static int handle_tr_close_cmd(const char *arg)
+{
+	struct ddebug_trace_inst *inst;
+	int idx, ret = 0;
+
+	mutex_lock(&ddebug_lock);
+
+	idx = find_tr_instance(arg);
+	if (idx < 0) {
+		ret = idx;
+		goto end;
+	}
+
+	inst = &tr.inst[idx];
+
+	trace_array_put(inst->arr);
+	/*
+	 * don't destroy trace instance but let user do it manually
+	 * with rmdir command at a convenient time later, if it is
+	 * destroyed here all debug logs will be lost
+	 *
+	 * trace_array_destroy(inst->arr);
+	 */
+	inst->arr = NULL;
+
+	kfree(inst->name);
+	inst->name = NULL;
+
+	clear_bit(idx, tr.bmap);
+	v3pr_info("closed trace instance idx=%d, name=%s\n", idx, arg);
+end:
+	mutex_unlock(&ddebug_lock);
+	return ret;
+}
+
+static int ddebug_parse_cmd(char *words[], int nwords)
+{
+	int ret;
+
+	if (nwords != 1)
+		return -EINVAL;
+
+	if (!strcmp(words[0], DD_OPEN_CMD))
+		ret = handle_tr_opend_cmd(words[1]);
+	else if (!strcmp(words[0], DD_CLOSE_CMD))
+		ret = handle_tr_close_cmd(words[1]);
+	else {
+		pr_err("invalid command %s\n", words[0]);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							  const char *class_string, int *class_id)
 {
@@ -567,6 +731,11 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		pr_err("tokenize failed\n");
 		return -EINVAL;
 	}
+
+	/* check for open, close commands */
+	if (is_ddebug_cmd(words[0]))
+		return ddebug_parse_cmd(words, nwords-1);
+
 	/* check flags 1st (last arg) so query is pairs of spec,val */
 	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
 		pr_err("flags parse failed\n");
@@ -1191,6 +1360,20 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
 	return &iter->table->ddebugs[iter->idx];
 }
 
+/*
+ * Check if the iterator points to the last _ddebug object
+ * to traverse.
+ */
+static bool ddebug_iter_is_last(struct ddebug_iter *iter)
+{
+	if (iter->table == NULL)
+		return false;
+	if (iter->idx-1 < 0 &&
+	    list_is_last(&iter->table->link, &ddebug_tables))
+		return true;
+	return false;
+}
+
 /*
  * Seq_ops start method.  Called at the start of every
  * read() call from userspace.  Takes the ddebug_lock and
@@ -1281,6 +1464,16 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 	seq_puts(m, "\n");
 
+	if (ddebug_iter_is_last(iter) &&
+	    !bitmap_empty(tr.bmap, tr.bmap_size)) {
+		int idx;
+
+		seq_puts(m, "\n");
+		seq_puts(m, "Opened trace instances:\n");
+		for_each_set_bit(idx, tr.bmap, tr.bmap_size)
+			seq_printf(m, "%s\n", tr.inst[idx].name);
+	}
+
 	return 0;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

