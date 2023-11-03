Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC97E0365
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377650AbjKCNKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjKCNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA62D4E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2508219e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017025; x=1699621825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOUDhCvR7O/HItpGyWqotIRwbNv9xPIlLL6yVbWMeYY=;
        b=OoXi3RDYNRkK0YjSeLNAigmYbP17lRyy3F6hWfKfdA09H4WuPQFeAeiYoneRQ2giyz
         JpUnSHHyTScQIYYOlR05vJnnwd+b7Y3BrdUdOxlYtxFUG1hI3tAZsdhkPHWYnWZhIGhh
         LHvUF0VUUju7HaHVi/fyG+FAA/A7zi2LiiWTOtFc7FlTFSTeM6hokoltMOb3paiL1rgZ
         JvzclF3ULiBdNLTF86HTwznOr96PMp5IeX4F1dgSsjlyef8QXxX43UZMx33/QC1Ni8ot
         4iCw2JaVdwZ4hBDcY2ybQqc03kMYeDyfGgbAy3dBPH0oyVkDKobwdPtx6kD8qlbnBOgx
         JitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017025; x=1699621825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOUDhCvR7O/HItpGyWqotIRwbNv9xPIlLL6yVbWMeYY=;
        b=Z7dcxbaWMWuGNKOfrZ3IAKGvCo0KtbOQqVvuFab12bM1Sl3oP7HZe0WeQg2CZxPJWQ
         NYXjNI7aaflijk6CDpniqE8OhQWeU8XDij5NlicfFbI2tuRyrtWpu1Rv1b9Kmz44mcen
         fDhFmn62Bi11245EHGDasF7VIrxBLuulcvTigVHCsjqiyk5IIcEuQAu6DXGWw4FHdKZD
         bMqg6sO1+iFtQ79nSw4VOXQ46RDN9wk13wYhtDnlTf9j7MiGYIBBmOJ3wTYTyocapjUh
         HIcrRE2GSmAZlQ121IGAoDXefjCIS65AGRv7zCwm1poUhivmHLEoMbC4mUMxazlEYewF
         E/kA==
X-Gm-Message-State: AOJu0Yyia8rfmJskU5J950rL8N9WzKYQwMoN3ecO/njZjcOU580s30jd
        MhHz/eXvzZsGwkXyr9CpctNh
X-Google-Smtp-Source: AGHT+IHF5aYNXQAYCxmcX3r+x3IpwrCfoPEIek1akbRf2gESDru4XOg7w2GOPvQH7+yVAXjPBMOORg==
X-Received: by 2002:ac2:4e08:0:b0:509:2b57:32e with SMTP id e8-20020ac24e08000000b005092b57032emr12843892lfr.8.1699017025546;
        Fri, 03 Nov 2023 06:10:25 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:25 -0700 (PDT)
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
Subject: [PATCH v1 10/12] dyndbg: add processing of T(race) flag argument
Date:   Fri,  3 Nov 2023 14:10:09 +0100
Message-Id: <20231103131011.1316396-11-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
In-Reply-To: <20231103131011.1316396-1-lb@semihalf.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
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
The argument value determines destination of debug logs:

0 - debug logs will be written to prdbg and devdbg trace events
[1..255] - debug logs will be written to trace instance

A user can provide trace destination by folowing T flag with
":" and trace destination value in range [0..255], for example:

echo "module thunderbolt =pT:7" > /sys/kernel/debug/dynamic_debug/control
echo "module thunderbolt =lT:7,p" > /sys/kernel/debug/dynamic_debug/control

When T flag with argument is followed by other flags then the next flag has
to be preceded with ",".

When no value is provided trace destination defaults to 0, for example:

echo "module thunderbolt =T" > /sys/kernel/debug/dynamic_debug/control
echo "module thunderbolt =lTp" > /sys/kernel/debug/dynamic_debug/control

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 105 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3218ab078a76..c5cd28e74a02 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -71,6 +71,7 @@ struct ddebug_iter {
 struct flag_settings {
 	unsigned int flags;
 	unsigned int mask;
+	unsigned int trace_dst;
 };
 
 static DEFINE_MUTEX(ddebug_lock);
@@ -111,9 +112,67 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
+typedef const char* (*read_flag_args_f)(const char *, struct flag_settings *);
+typedef char* (*show_flag_args_f)(struct dd_ctrl *, char *);
+
+/*
+ * Maximum number of characters representing value
+ * of flag T argument in human readable form - ":255,"
+ */
+#define FLAG_T_ARGS_LEN 5
+
+static const
+char *read_T_args(const char *str, struct flag_settings *modifiers)
+{
+	char *end, args[FLAG_T_ARGS_LEN];
+	int len;
+
+	if (*(str+1) != ':')
+		return str;
+
+	str += 2;
+	end = strchr(str, ',');
+	if (end && *(end + 1) == '\0')
+		return NULL;
+
+	if (end)
+		len = end - str;
+	else
+		len = strlen(str);
+
+	if (len > FLAG_T_ARGS_LEN - 1)
+		return NULL;
+
+	memcpy(args, str, len);
+	args[len] = '\0';
+	if (kstrtouint(args, 10, &modifiers->trace_dst) < 0)
+		return NULL;
+
+	if (modifiers->trace_dst > TRACE_DST_MAX)
+		return NULL;
+
+	return end ? end : str + len;
+}
+
+char *show_T_args(struct dd_ctrl *ctrl, char *p)
+{
+	int n;
+
+	n = snprintf(p, FLAG_T_ARGS_LEN, ":%u", ctrl->trace_dst);
+	WARN_ONCE(n < 0, "printing T flag args value failed\n");
+
+	return n < 0 ? p : p + n;
+}
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
@@ -122,22 +181,30 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
-struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
+struct ctrlbuf { char buf[ARRAY_SIZE(opt_array)+FLAG_T_ARGS_LEN+1]; };
 
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
@@ -202,7 +269,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	struct ddebug_table *dt;
 	unsigned int nfound = 0;
 	struct dd_ctrl nctrl = {0};
-	struct flagsbuf fbuf, nbuf;
+	struct ctrlbuf cbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
 	int __outvar valid_class;
 
@@ -268,7 +335,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			nfound++;
 
 			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct dd_ctrl)))
+			nctrl.trace_dst = modifiers->trace_dst;
+			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
@@ -281,8 +349,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
-				  ddebug_describe_flags(get_flags(dp), &fbuf),
-				  ddebug_describe_flags(nctrl.flags, &nbuf));
+				  ddebug_describe_ctrl(&dp->ctrl, &cbuf),
+				  ddebug_describe_ctrl(&nctrl, &nbuf));
 			set_ctrl(dp, &nctrl);
 		}
 	}
@@ -507,6 +575,7 @@ static int ddebug_parse_query(char *words[], int nwords,
  */
 static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
+	read_flag_args_f read_args;
 	int op, i;
 
 	switch (*str) {
@@ -525,6 +594,12 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
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
@@ -533,7 +608,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x\n", modifiers->flags);
+	v3pr_info("flags=0x%x, trace dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -1257,7 +1332,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 {
 	struct ddebug_iter *iter = m->private;
 	struct _ddebug *dp = p;
-	struct flagsbuf flags;
+	struct ctrlbuf cbuf;
 	char const *class;
 
 	if (p == SEQ_START_TOKEN) {
@@ -1269,7 +1344,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(get_flags(dp), &flags));
+		   ddebug_describe_ctrl(&dp->ctrl, &cbuf));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
 
-- 
2.42.0.869.gea05f2083d-goog

