Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE177FFFA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377297AbjK3Xnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377286AbjK3Xna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:43:30 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0601738
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:29 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9b77be7ceso21241921fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387721; x=1701992521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wt3vKjsUAZMbYy6d5uF1hBmVRmXnFVCm9oe1FHdN7nQ=;
        b=XXQDPDeG7dbBsJ/SYlKOrUWNYzfxkhWSmMXGoqP9LrI4Ie8by33ftmz9o52UNv9fL6
         ECmaSU+WlCHTnIwxcY5yKrdLt4styjuvhfEffo/0mD+OYp2zFO+g/KCmYUg4ac577jZ6
         PaMNbuCtRQl/+EHG6E1frXI8meoNUZL8qjpwUBZ26+1MSZ2zyJekkLsbcZaVWE9gb89c
         /LnrFn774icywHsQuyh7Hq47+8tzi7aSXqILOxQKZic1krRkq+8fxSvIgH6fZWJUp2Cy
         a3D7yfSJAoD1CGZo5NNtYDAZAJWCeu2SSDhHgitvQx2vprINGjD7+YBkEBP/GEWEpZ+m
         EeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387721; x=1701992521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wt3vKjsUAZMbYy6d5uF1hBmVRmXnFVCm9oe1FHdN7nQ=;
        b=g9zZCVt1phuzbRL6xFzXmhvVY8U5U35+9O2P2rqzDM2VET9KqbfNKwG845sPqyF/f7
         DpAw6I+Da3NKtQXpcFnLOG4zOaKkMLTsOJPGcfS2rvFlD1pwI9vCs2B4aW7SCuDrqX26
         uPYPgMAWAOvc+pFjfBuVSnVuK09iqymnTr5OAf4n/4KmcjVJjzp23CwLs1ogM8MMixYj
         oVqnMvQzYyzefuFjNcwk+qM03sAuVgKwZJT6tOnnCRVdtfxwsftEL5qJpUVKoBaRgW8/
         e3uy+m9Sw0rUN494fr83nFJxSuV7RYoMkv/GxU7iJbkLy4Z+S+QRfaPpCzU/3OdbVtW5
         e7Eg==
X-Gm-Message-State: AOJu0YyM8/BnDh3C7okcD00cx1NYTU9wEwNFEv2Pbsopf+2QpZBAUlCN
        /zEDdmommxq1zoBRSCpH33yF
X-Google-Smtp-Source: AGHT+IEBHKpQf2K2rkrIF9TFAKwX9YhDhOAH+FM6dtpPKjKAEh/Ez42l+n/fhHOfHbkG74cSGh06qA==
X-Received: by 2002:a2e:9796:0:b0:2c9:d3ec:69c1 with SMTP id y22-20020a2e9796000000b002c9d3ec69c1mr138113lji.24.1701387721633;
        Thu, 30 Nov 2023 15:42:01 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:42:01 -0800 (PST)
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
Subject: [PATCH v2 12/15] dyndbg: add processing of T(race) flag argument
Date:   Fri,  1 Dec 2023 00:40:45 +0100
Message-ID: <20231130234048.157509-13-lb@semihalf.com>
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

Add processing of argument provided to T(race) flag.
The string argument determines destination of debug logs:

"0"  - debug logs will be written to prdbg and devdbg trace events
name - debug logs will be written to trace instance pointed by name,
       trace instance name has to be previously opened with open
       command

A user can provide trace destination name by following T flag with
":" and trace destination name, for example:

echo "module thunderbolt =pT:tbt" > <debugfs>/dynamic_debug/control
echo "module thunderbolt =lT:tbt,p" > <debugfs>/dynamic_debug/control

When T flag with argument is followed by other flag then the next
flag has to be preceded with ",".

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 169 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 132 insertions(+), 37 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 73b6818e5fab..dbedb1139d4b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -72,6 +72,7 @@ struct ddebug_iter {
 struct flag_settings {
 	unsigned int flags;
 	unsigned int mask;
+	unsigned int trace_dst;
 };
 
 #define DD_OPEN_CMD	"open"
@@ -85,8 +86,16 @@ struct ddebug_trace_inst {
 };
 
 /*
- * TRACE_DST_MAX value is reserved for writing
- * debug logs to trace events (prdbg, devdbg)
+ * When trace is enabled (T flag is set) and trace destination field
+ * value is not a TRACE_DST_MAX (it is reserved for trace events)
+ * then debug logs will be written to trace instance whose name is
+ * stored in inst[trace destination].name, e.g. when trace destination
+ * value is 2 and inst[2].name is set to tbt then debug logs will be
+ * written to <debugfs>/tracing/instances/tbt
+ *
+ * Size of inst and bmap is TRACE_DST_MAX-1 because TRACE_DST_MAX value
+ * is reserved as a special value of trace destination which when set
+ * writes debug logs to trace events (prdbg, devdbg)
  */
 struct ddebug_trace {
 	struct ddebug_trace_inst inst[TRACE_DST_MAX-1];
@@ -123,6 +132,72 @@ static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 	return desc->ctrl.trace_dst;
 }
 
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
+static const
+char *read_T_args(const char *str, struct flag_settings *modifiers)
+{
+	int len, idx = TRACE_DST_MAX;
+	char *end;
+
+	if (*(str+1) != ':')
+		return str;
+
+	str += 2;
+	end = strchr(str, ',');
+	if (end && *(end + 1) == '\0')
+		return NULL;
+
+	if (end) {
+		len = end - str;
+		*end = '\0';
+	} else
+		len = strlen(str);
+
+	/* destination trace events */
+	if (!strcmp(str, DD_TR_EVENT))
+		goto end;
+
+	idx = find_tr_instance(str);
+	if (idx < 0)
+		return NULL;
+end:
+	modifiers->trace_dst = idx;
+	return end ? end : str + len;
+}
+
+/*
+ * Maximum number of characters which are being displayed when
+ * printing trace instance name, longer names are truncated
+ */
+#define FLAG_T_ARG_LEN 24
+
+char *show_T_args(struct dd_ctrl *ctrl, char *p)
+{
+	const char *str;
+	int n;
+
+	str = ctrl->trace_dst == TRACE_DST_MAX ?
+	      DD_TR_EVENT : tr.inst[ctrl->trace_dst].name;
+
+	n = snprintf(p, FLAG_T_ARG_LEN, ":%s", str);
+	if (n >= FLAG_T_ARG_LEN) {
+		strscpy(&p[FLAG_T_ARG_LEN-4], "...", 4);
+		n = FLAG_T_ARG_LEN - 1;
+	}
+
+	return n < 0 ? p : p + n;
+}
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -134,9 +209,18 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
+typedef const char* (*read_flag_args_f)(const char *, struct flag_settings *);
+typedef char* (*show_flag_args_f)(struct dd_ctrl *, char *);
+
+static const struct
+{
+	unsigned flag:8;
+	char opt_char;
+	read_flag_args_f read_args;
+	show_flag_args_f show_args;
+} opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINTK, 'p' },
-	{ _DPRINTK_FLAGS_TRACE, 'T' },
+	{ _DPRINTK_FLAGS_TRACE, 'T', read_T_args, show_T_args},
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -145,22 +229,30 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
-struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
+struct ctrlbuf { char buf[ARRAY_SIZE(opt_array)+FLAG_T_ARG_LEN+1]; };
 
 /* format a string into buf[] which describes the _ddebug's flags */
-static char *ddebug_describe_flags(unsigned int flags, struct flagsbuf *fb)
+static char *ddebug_describe_ctrl(struct dd_ctrl *ctrl, struct ctrlbuf *cb)
 {
-	char *p = fb->buf;
+	show_flag_args_f show_args = NULL;
+	char *p = cb->buf;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
-		if (flags & opt_array[i].flag)
+		if (ctrl->flags & opt_array[i].flag) {
+			if (show_args)
+				*p++ = ',';
 			*p++ = opt_array[i].opt_char;
-	if (p == fb->buf)
+			show_args = opt_array[i].show_args;
+			if (show_args)
+				p = show_args(ctrl, p);
+		}
+
+	if (p == cb->buf)
 		*p++ = '_';
 	*p = '\0';
 
-	return fb->buf;
+	return cb->buf;
 }
 
 #define vnpr_info(lvl, fmt, ...)				\
@@ -219,17 +311,6 @@ static bool validate_tr_name(const char *str)
 	return true;
 }
 
-static int find_tr_instance(const char *name)
-{
-	int idx;
-
-	for_each_set_bit(idx, tr.bmap, tr.bmap_size)
-		if (!strcmp(tr.inst[idx].name, name))
-			return idx;
-
-	return -ENOENT;
-}
-
 static int handle_tr_opend_cmd(const char *arg)
 {
 	struct ddebug_trace_inst *inst;
@@ -387,7 +468,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
  * callsites, normally the same as number of changes.  If verbose,
- * logs the changes.  Takes ddebug_lock.
+ * logs the changes.
  */
 static int ddebug_change(const struct ddebug_query *query,
 			 struct flag_settings *modifiers)
@@ -395,13 +476,12 @@ static int ddebug_change(const struct ddebug_query *query,
 	int i;
 	struct ddebug_table *dt;
 	unsigned int nfound = 0;
+	struct ctrlbuf cbuf, nbuf;
 	struct dd_ctrl nctrl = {0};
-	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
 	int __outvar valid_class;
 
 	/* search for matching ddebugs */
-	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
 
 		/* match against the module name */
@@ -462,7 +542,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			nfound++;
 
 			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct dd_ctrl)))
+			nctrl.trace_dst = modifiers->trace_dst;
+			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
@@ -475,13 +556,12 @@ static int ddebug_change(const struct ddebug_query *query,
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
-				  ddebug_describe_flags(get_flags(dp), &fbuf),
-				  ddebug_describe_flags(nctrl.flags, &nbuf));
+				  ddebug_describe_ctrl(&dp->ctrl, &cbuf),
+				  ddebug_describe_ctrl(&nctrl, &nbuf));
 			update_tr_dst(dp, &nctrl);
 			set_ctrl(dp, &nctrl);
 		}
 	}
-	mutex_unlock(&ddebug_lock);
 
 	if (!nfound && verbose)
 		pr_info("no matches for query\n");
@@ -702,6 +782,7 @@ static int ddebug_parse_query(char *words[], int nwords,
  */
 static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
+	read_flag_args_f read_args;
 	int op, i;
 
 	switch (*str) {
@@ -720,6 +801,12 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
 				modifiers->flags |= opt_array[i].flag;
+				read_args = opt_array[i].read_args;
+				if (read_args) {
+					str = read_args(str, modifiers);
+					if (!str)
+						return -EINVAL;
+				}
 				break;
 			}
 		}
@@ -728,7 +815,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
+	v3pr_info("flags=0x%x, trace dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -767,20 +854,28 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	if (is_ddebug_cmd(words[0]))
 		return ddebug_parse_cmd(words, nwords-1);
 
-	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
-		pr_err("flags parse failed\n");
-		return -EINVAL;
-	}
 	if (ddebug_parse_query(words, nwords-1, &query, modname)) {
 		pr_err("query parse failed\n");
 		return -EINVAL;
 	}
+
+	mutex_lock(&ddebug_lock);
+
+	/* check flags 1st (last arg) so query is pairs of spec,val */
+	if (ddebug_parse_flags(words[nwords-1], &modifiers)) {
+		pr_err("flags parse failed\n");
+		goto err;
+	}
+
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
-	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
+	mutex_unlock(&ddebug_lock);
+	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 	return nfound;
+err:
+	mutex_unlock(&ddebug_lock);
+	return -EINVAL;
 }
 
 /* handle multiple queries in query string, continue on error, return
@@ -1470,7 +1565,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	struct flagsbuf flags;
+	struct ctrlbuf cbuf;
 	char const *class;
 
 	if (p == SEQ_START_TOKEN) {
@@ -1482,7 +1577,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(get_flags(dp), &flags));
+		   ddebug_describe_ctrl(&dp->ctrl, &cbuf));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

