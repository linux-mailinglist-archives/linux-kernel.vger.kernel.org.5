Return-Path: <linux-kernel+bounces-60595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B0850764
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507611C2190E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45E960EC4;
	Sat, 10 Feb 2024 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEc68OHh"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0060BB8
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609053; cv=none; b=abckQW7o9xHfBjbo4iaQY3qgfUdzKCDGA20k5Gs6/os5c84i45L5DFv9MlKlgyYgUxcd7hD2oL6L3NEiVYxsceozyQbDPv9ROX9YyC1UzwAkSrsJSzDgXpR2mNAAVsZOV/v3N9wCgW88MDydzSfYrCwiXXKfewW1iaxEMBQf1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609053; c=relaxed/simple;
	bh=YbEEGz+x4DGalh89sTCHjKKTuGvWKdWzObsdPhFL1wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtQiTygtl2sUtW1hf2Ua1D0ErCMZYjYgp4I2sC0Xq4OT/CHawbEAkhBeXa4ICxTp+wcw2yQRKmhJ77Ar43JpJKvEPqoFyMMT3piWa8bFbaeNZPY7w45uYCa1El4nJiLjksTtad3BrCyfujyP/TLCfb4J2mPeSotZKgXfU4dYHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NEc68OHh; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511531f03f6so2471383e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609049; x=1708213849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfKj9NP/58mMOcfaMc+gvbzTB/hMk+FrCsCCziFkNU8=;
        b=NEc68OHhXtTFO9xYinVIt81NO9lLr6U0JS87MQ1dGhZUiVuJmoX3p81Jy7Q2nZApXS
         NR0FnMH29PvJN0IE9PyPYu+1k7VVfcIOCoYXyS1v88XafT98mFaupl5spRmLtK/TCvJP
         eEbt/R4YdKUUueytTUHchHue6CMDOtAZ5hY78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609049; x=1708213849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfKj9NP/58mMOcfaMc+gvbzTB/hMk+FrCsCCziFkNU8=;
        b=AO5obeQEHMZuBqIswlHoZ8DufvI5nO0CYLOWGLPoCV5CDFluqXCLjmUwuFBzSp6Ep2
         d4jJDE8U6DFHliFdpatqBmZwoWcZCowULxVxV70KxKOt5qzc9vGe0gTXAQ3tl4oCvsya
         2sSeQUcORo2J8poYHmw07fenYX6wmGNVddR9Zq22y8f8LDp6pQUK6rFciETxJr2Cg2Y8
         dzg2MmytJtV6+2/9RFGKRGUsPAu+uSresnusTIHa1E8w1aYSSEzeokkZlw7vfm6dx7Yz
         LKxVxB12aQqLp9imcPokCmI33UxUrNDZjIDMCNfp8NZlIThtSdi3jfxzEU3ZY0gdAX26
         ELdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv5VOnK1IitUVv0Ky+pTzOWnPA048Y0eUb3BvXeQlgHirEf4MFLxBsBn9w3qYwSj3MNqa4YiDvxg9Md07EDDRi2wWstPlo0++Ynlrt
X-Gm-Message-State: AOJu0YyR/GNSZvyUfSgqy5qrvZPA2WtCAQeadg9xKda+yuy4Fs4IVqtQ
	bQ8+o2nt2u6EgXm4qqLKFlDonEx9M3kJUmezmo729gWeYPM4t2WuaK9/pvse
X-Google-Smtp-Source: AGHT+IEMeYfZnOf0yaY+29yzBa+kP9IAL7RSPWIsbe26MGx1+KFL1LNJu7LVSCR4N5UhimZdw7e8gg==
X-Received: by 2002:a05:6512:3494:b0:511:29ee:83b8 with SMTP id v20-20020a056512349400b0051129ee83b8mr1734783lfr.62.1707609049402;
        Sat, 10 Feb 2024 15:50:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUnsHsChtMY0XIdk/Tmra55cNHHohds/OiiSOJLv0iBqWdC10K+YsgbEEMMOPsB3XJbsSI9NoifHRtdkIOnt8nhTBwoEUIWQFELx7VPy3kr5rvDa+HIrOhzWFGXASHJahCFj0felYnPLIDmbBHjsuw4R+X8Nu4c46DhDTT2LUs3rfA/DSm8yihWmkKno1ZXluMLqdlRVrDe6bZpV1oSI7QTYxoc0MazdDiSEldCMtbJV/DvNht6h8Xp1dF6wX9yMWqM62Pu6mk4LpSR1gsGOilSy5C+01lrHoW3a91i/dKJKjiUp+dZaPrF9tBlkm2D8fUGqo2EwsvunTwLZy5Hsmt8M1HhHmmuZr1mjoMoWl/vatS3+R2Cfysoq2629ZIKOEim1xDUh5UXf595ug8JUu/FafXFRmCUHKu06nCNct70PsSKiG9t9KeFGnpsLqhIG8Qrye0gEat0A853slueNJ2Tkv/xYPB/a99MpnFX+lIumz1pJNF3KcwDCJsOSns0/yTgleI8cowwpjn5w079sIIdynDazFUZ8Pnz5uGxq+L1uA/SGRiXhNIATE1qNVl6yvmkqEiOWROuoi9ScBWc1VxBYjPt8vnCtUPojnMyIK8p+RKKig==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:49 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 12/39] dyndbg: handle [+T]:buf_name.flags grammar
Date: Sun, 11 Feb 2024 00:49:42 +0100
Message-ID: <20240210235009.2405808-13-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add processing to handle the new [+T]:trace_name.flags grammar.

The name provided sets selected callsites' trace-destinations:

"0"  - pr_debug()s are written to prdbg and devdbg trace events.
name - pr_debug()s are written to named trace instance,
       if its already been open'd, else err.

A user can provide trace destination name by following T flag with
":" and trace destination name, for example:

echo "module thunderbolt =pT:tbt" > <debugfs>/dynamic_debug/control
echo "module thunderbolt =lT:tbt.p" > <debugfs>/dynamic_debug/control

Or user can provide only ":" and trace destination name, for example:

echo "module thunderbolt =p:tbt" > <debugfs>/dynamic_debug/control
echo "module thunderbolt =l:tbt.p" > <debugfs>/dynamic_debug/control

In the former examples trace destination is set (":tbt") and write of
pr_debug()s is enabled ("T"). In the latter examples only trace
destination is set (":tbt") for later use.

When T flag with argument is followed by other flag then the next
flag has to be preceded with ".".

When both T flag and ":" are provided together then ":" has
to follow T flag in the form of "T:".

Use of "." as a separator between flags allows a later patch to treat
',' as a space, which mostly eliminates the need to quote query/rules.
And this in turn avoids quoting hassles:

  modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

It is particularly good for passing boot-args into test-scripts.

  vng -p 4 -v \
  -a test_dynamic_debug.dyndbg=class,D2_CORE,+p

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Co-developed-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 201 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 162 insertions(+), 39 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6668f265f2c3..8a81356c52b3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -72,6 +72,7 @@ struct ddebug_iter {
 struct flag_settings {
 	unsigned int flags;
 	unsigned int mask;
+	unsigned int trace_dst;
 };
 
 #define DD_OPEN_CMD	"open"
@@ -84,11 +85,17 @@ struct dd_private_tracebuf {
 	int use_cnt;
 };
 
+#define DST_NOT_SET    (-1)
+
 /*
- * Trace destination value 0 is reserved for writing
- * debug logs to trace events (prdbg, devdbg), that
- * is why buf[0] is not used and we traverse bitmap
- * starting from bit 1 (bit 0 is also not used).
+ * When trace is enabled (T flag is set) and trace destination field
+ * value is in range [1..63] then debug logs will be written to trace
+ * instance whose name is stored in buf[trace destination].name, e.g.
+ * when trace destination value is 2 and buf[2].name is set to tbt then
+ * debug logs will be written to <debugfs>/tracing/instances/tbt.
+ * On the other hand trace destination value 0 is reserved for writing
+ * debug logs to trace events (prdbg, devdbg), that is why buf[0] is not
+ * used and we traverse bitmap starting from bit 1 (bit 0 is also not used).
  */
 struct dd_tracebuf_tbl_info {
 	struct dd_private_tracebuf buf[TRACE_DST_LAST];
@@ -126,6 +133,81 @@ static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 	return desc->ctrl.trace_dst;
 }
 
+static int find_tr_instance(const char *name)
+{
+	int idx = 1;
+
+	for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
+		if (!strcmp(trc_tbl.buf[idx].name, name))
+			return idx;
+
+	return -ENOENT;
+}
+
+static const
+char *read_colon_args(const char *str, struct flag_settings *modifiers)
+{
+	int len, idx = 0;
+	char *end;
+
+	/* Check if trace destination was already set */
+	if (modifiers->trace_dst != DST_NOT_SET)
+		return NULL;
+	/*
+	 * When both T flag and ':' are provided then the T flag
+	 * has to be followed by ':' in the form of 'T:'.
+	 */
+	if (modifiers->flags & _DPRINTK_FLAGS_TRACE &&
+	    *(str-1) != 'T')
+		return NULL;
+
+	if (strchr(str, 'T'))
+		return NULL;
+
+	str++;
+	end = strchr(str, '.');
+	if (end) {
+		len = end - str;
+		*end = '\0';
+	} else
+		len = strlen(str);
+	len -= 1;
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
+#define FLAG_COLON_ARG_LEN 24
+
+static char *show_colon_args(struct dd_ctrl *ctrl, char *p)
+{
+	int n, len = FLAG_COLON_ARG_LEN;
+	const char *str;
+
+	str = !ctrl->trace_dst ? DD_TR_EVENT :
+	      trc_tbl.buf[ctrl->trace_dst].name;
+
+	n = snprintf(p, len, "%s", str);
+	if (n >= len) {
+		strscpy(&p[len-4], "...", 4);
+		n = len - 1;
+	}
+
+	return n < 0 ? p : p + n;
+}
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -137,9 +219,28 @@ static inline const char *trim_prefix(const char *path)
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
+	bool always_show;
+	read_flag_args_f read_args;
+	show_flag_args_f show_args;
+} opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINTK, 'p' },
 	{ _DPRINTK_FLAGS_TRACE, 'T' },
+	/*
+	 * We don't reserve a flag for ':'. The ':' is used to provide
+	 * trace destination name and when provided together with T flag
+	 * it enables output to the trace destination. When ':' is provided
+	 * without T flag then it sets trace destination for a callsite for
+	 * future use. When both T flag and ':'are provided together then
+	 * ':' has to follow T flag in the form of 'T:'.
+	 */
+	{ _DPRINTK_FLAGS_NONE, ':', true, read_colon_args, show_colon_args },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -148,22 +249,31 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
-struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
+struct ctrlbuf { char buf[ARRAY_SIZE(opt_array)+FLAG_COLON_ARG_LEN+1]; };
 
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
+		if (ctrl->flags & opt_array[i].flag ||
+		    opt_array[i].always_show) {
+			if (show_args)
+				*p++ = '.';
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
@@ -221,17 +331,6 @@ static bool dd_good_trace_name(const char *str)
 	return true;
 }
 
-static int find_tr_instance(const char *name)
-{
-	int idx = 1;
-
-	for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
-		if (!strcmp(trc_tbl.buf[idx].name, name))
-			return idx;
-
-	return -ENOENT;
-}
-
 static int handle_trace_open_cmd(const char *arg)
 {
 	struct dd_private_tracebuf *buf;
@@ -383,7 +482,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
  * callsites, normally the same as number of changes.  If verbose,
- * logs the changes.  Takes ddebug_lock.
+ * logs the changes.
  */
 static int ddebug_change(const struct ddebug_query *query,
 			 struct flag_settings *modifiers)
@@ -391,13 +490,12 @@ static int ddebug_change(const struct ddebug_query *query,
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
@@ -458,7 +556,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			nfound++;
 
 			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct dd_ctrl)))
+			nctrl.trace_dst = modifiers->trace_dst;
+			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
@@ -471,13 +570,12 @@ static int ddebug_change(const struct ddebug_query *query,
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
@@ -698,6 +796,7 @@ static int ddebug_parse_query(char *words[], int nwords,
  */
 static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
+	read_flag_args_f read_args;
 	int op, i;
 
 	switch (*str) {
@@ -716,6 +815,12 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
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
@@ -724,7 +829,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
+	v3pr_info("flags=0x%x, trace_dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -747,7 +852,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
-	struct flag_settings modifiers = {};
+	struct flag_settings modifiers = { .trace_dst = DST_NOT_SET };
 	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -763,20 +868,38 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	if (is_dd_trace_cmd(words[0]))
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
+	/*
+	 * Both ddebug_parse_flags and ddebug_change have to be run
+	 * with locking because ddebug_parse_flags->read_T_args verifies
+	 * if a requested trace instance is opened. Next ddebug_change
+	 * sets the requested trace instance as output for debug logs of
+	 * callsite(s) which matched a query. Because ddebug_proc_write
+	 * function can be called concurrently then without locking we
+	 * could for example run into a scenario where ddebug_change uses
+	 * a trace instance which is already closed.
+	 */
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
@@ -1466,7 +1589,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	struct flagsbuf flags;
+	struct ctrlbuf cbuf;
 	char const *class;
 
 	if (p == SEQ_START_TOKEN) {
@@ -1478,7 +1601,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(get_flags(dp), &flags));
+		   ddebug_describe_ctrl(&dp->ctrl, &cbuf));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
 
-- 
2.43.0.687.g38aa6559b0-goog


