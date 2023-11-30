Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627E17FFFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377310AbjK3Xo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377312AbjK3Xo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:44:26 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12102273E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:30 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso1725885a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387726; x=1701992526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZCaekCz8eMIOK0XDrrl6u8KojrpBKq+vfvAetYMtgo=;
        b=scN+XWlPEiAjkFLsMrdBqXdOpt93D5k6Q2sz+hzNQmWJUZAorHAvjpuFKY22+cfq5R
         ikIXYIT6hRQZYfyh49Xy42ey+NNvubmPXNqiuv86Z7ZKK/Fu3tgApvb7QbAO/3+tq6i2
         ZGFIs6WrUccedCNCcNhRMZoHw2qAychRaMp64WUF0vYzg+n1y2raYMEFOqgNttWSTO1c
         yg0epIMA2yrI+7V4piOrzz3aYAqIaK6OTv1okbttlYmYGPTH1E84IpF3uC65R/qouExM
         L8LBJd1/Il5GIMD1WjXXBmIAH0eWTxGOGVHNMpac5euVXH6swUkxxuSrur/fwtkRLt79
         pZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387726; x=1701992526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZCaekCz8eMIOK0XDrrl6u8KojrpBKq+vfvAetYMtgo=;
        b=V3jKWq5nrQEGWrvb/2V8M8Ve5oWXUm9xqC1YFtiZY+FcCKOujkNB6SZF74eV1ueTfA
         KoxT5LV13NWv/ZQEgj/yW8uf6PTPXz7LRVZeLu/9u/rwXkoZezyBS56RUxib7Mb4HTgq
         y/tHNh+kTiFIXOmmRsNtufNNcr5Ai61KEYjliw2i6TnQ91bNS6i/yNrp/qA82pVO7MN8
         FKO4PQkSOwBm+7f+RilPFqNCtY3KLPzmC3shfbC31/aZBjyPJ9ZMDTQMFrLk38H9Bb1t
         1kuCaAF2FL6zKSrkK2eU/8+zpbGC4Qaa1Z7tv8zz1vr9e2YqmjvE+b7k0mIeVWiAhTVw
         9fIA==
X-Gm-Message-State: AOJu0YwfyHttKSLVRGwe5XO++f3sdxg6hDYf4oq01umxdJjF1nACrxyC
        9Zv+kPE75zZP+gX7zv9BvFik
X-Google-Smtp-Source: AGHT+IEYSE3eOSyakC/Xuef7ERk8ey75vW5N+7kOclB3Y7EbtGkg+iFaebZcVdtBwrrlBCPyIkHWZQ==
X-Received: by 2002:a17:906:814:b0:a19:a19a:eab0 with SMTP id e20-20020a170906081400b00a19a19aeab0mr205379ejd.105.1701387726490;
        Thu, 30 Nov 2023 15:42:06 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:42:06 -0800 (PST)
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
Subject: [PATCH v2 13/15] dyndbg: add support for default trace destination
Date:   Fri,  1 Dec 2023 00:40:46 +0100
Message-ID: <20231130234048.157509-14-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of repeating trace destination name explicitly for each
command (e.g. +T:thunderbolt), this change saves previously used
trace destination provided to [=+-]T as default and consecutive
commands which don't provide trace destination explicitly will
usa the saved trace destination.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 86 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 13 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dbedb1139d4b..ae05b3728520 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -101,6 +101,9 @@ struct ddebug_trace {
 	struct ddebug_trace_inst inst[TRACE_DST_MAX-1];
 	DECLARE_BITMAP(bmap, TRACE_DST_MAX-1);
 	int bmap_size;
+#define DST_NOT_SET (-1)
+#define DST_NOT_SET_STR "not set"
+	int default_dst;
 };
 
 static DEFINE_MUTEX(ddebug_lock);
@@ -110,7 +113,8 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
-static struct ddebug_trace tr = { .bmap_size = TRACE_DST_MAX-1 };
+static struct ddebug_trace tr = { .bmap_size = TRACE_DST_MAX-1,
+				  .default_dst = DST_NOT_SET, };
 
 static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
 {
@@ -132,6 +136,11 @@ static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 	return desc->ctrl.trace_dst;
 }
 
+static inline bool has_tr_default_dst(void)
+{
+	return tr.default_dst != DST_NOT_SET;
+}
+
 static int find_tr_instance(const char *name)
 {
 	int idx;
@@ -146,11 +155,16 @@ static int find_tr_instance(const char *name)
 static const
 char *read_T_args(const char *str, struct flag_settings *modifiers)
 {
-	int len, idx = TRACE_DST_MAX;
-	char *end;
+	bool has_colon = *(str+1) == ':' ? true : false;
+	int len = 0, idx = TRACE_DST_MAX;
+	char *end = NULL;
 
-	if (*(str+1) != ':')
-		return str;
+	if (!has_colon) {
+		if (!has_tr_default_dst())
+			return NULL;
+		idx = tr.default_dst;
+		goto end;
+	}
 
 	str += 2;
 	end = strchr(str, ',');
@@ -168,8 +182,12 @@ char *read_T_args(const char *str, struct flag_settings *modifiers)
 		goto end;
 
 	idx = find_tr_instance(str);
-	if (idx < 0)
-		return NULL;
+	if (idx < 0) {
+		if (!has_tr_default_dst() ||
+		    has_colon)
+			return NULL;
+		idx = tr.default_dst;
+	}
 end:
 	modifiers->trace_dst = idx;
 	return end ? end : str + len;
@@ -387,6 +405,13 @@ static int handle_tr_close_cmd(const char *arg)
 		goto end;
 	}
 
+	/*
+	 * check if default trace instance is being closed,
+	 * if yes then clear default destination
+	 */
+	if (tr.default_dst == idx)
+		tr.default_dst = DST_NOT_SET;
+
 	trace_array_put(inst->arr);
 	/*
 	 * don't destroy trace instance but let user do it manually
@@ -427,6 +452,32 @@ void update_tr_dst(const struct _ddebug *desc, const struct dd_ctrl *nctrl)
 		tr.inst[ndst].use_cnt++;
 }
 
+static const char *get_tr_default_dst_str(void)
+{
+	switch (tr.default_dst) {
+	case DST_NOT_SET:
+		return DST_NOT_SET_STR;
+	case TRACE_DST_MAX:
+		return DD_TR_EVENT;
+	default:
+		return tr.inst[tr.default_dst].name;
+	}
+}
+
+static void update_tr_default_dst(const struct flag_settings *modifiers)
+{
+	if (tr.default_dst == modifiers->trace_dst)
+		return;
+
+	if ((!modifiers->flags && (~modifiers->mask & _DPRINTK_FLAGS_TRACE)) ||
+	    (modifiers->flags & _DPRINTK_FLAGS_TRACE)) {
+
+		tr.default_dst = modifiers->trace_dst;
+		v3pr_info("set default trace dst to idx=%d, name=%s\n",
+			  tr.default_dst, get_tr_default_dst_str());
+	}
+}
+
 static int ddebug_parse_cmd(char *words[], int nwords)
 {
 	int ret;
@@ -566,6 +617,9 @@ static int ddebug_change(const struct ddebug_query *query,
 	if (!nfound && verbose)
 		pr_info("no matches for query\n");
 
+	if (nfound)
+		update_tr_default_dst(modifiers);
+
 	return nfound;
 }
 
@@ -1590,14 +1644,20 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 	seq_puts(m, "\n");
 
-	if (ddebug_iter_is_last(iter) &&
-	    !bitmap_empty(tr.bmap, tr.bmap_size)) {
-		int idx;
+	if (ddebug_iter_is_last(iter)) {
 
 		seq_puts(m, "\n");
-		seq_puts(m, "Opened trace instances:\n");
-		for_each_set_bit(idx, tr.bmap, tr.bmap_size)
-			seq_printf(m, "%s\n", tr.inst[idx].name);
+		seq_printf(m, "Default trace destination: %s\n",
+			   get_tr_default_dst_str());
+
+		if (!bitmap_empty(tr.bmap, tr.bmap_size)) {
+			int idx;
+
+			seq_puts(m, "\n");
+			seq_puts(m, "Opened trace instances:\n");
+			for_each_set_bit(idx, tr.bmap, tr.bmap_size)
+				seq_printf(m, "%s\n", tr.inst[idx].name);
+		}
 	}
 
 	return 0;
-- 
2.43.0.rc2.451.g8631bc7472-goog

