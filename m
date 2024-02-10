Return-Path: <linux-kernel+bounces-60593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E88850762
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8B41F210C2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97A60BA6;
	Sat, 10 Feb 2024 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1k3Z5rt"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8C6089D
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609049; cv=none; b=lLKlYqS4Q/vRZDY33dtVDi/BlpjhpdmB3G082g5XfPDGyYATlpHn4VjvL5EllsG1pqC+L8+k3vvPRqnnTGz8wV1xUfT7Lr2gIulOwCNjSQppqb0ZAOXPhASsF4A7MoZgVc7MBff3KpaF/lI2EG7YHneAFn7zVD+a+9UYoPSlZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609049; c=relaxed/simple;
	bh=auLLBjaM7NJ4bfEIN23dALRyRz9gbqEMOckQKBJQ810=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQDE39RUDjEKs0NS9lxKa5Hz/RTAE1ZGeoyCN/paPTD/44XufNHYk2hbD8iRpnnNhSeuxE9CWaDbf7RAH6UZAbxUEM3yd1T2uEG3+FjTr/5ZNEjE2ku3hCh2KutcjeLjCAIA8uvVI1SqXl0bYsLI424C+QL828XTBdhlarVuR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j1k3Z5rt; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51142b5b76dso3281284e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609046; x=1708213846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdad3Evs7q/LlRKkCSzkMMat3wm4/GWPiv0LyGMWHAo=;
        b=j1k3Z5rtUWmHRtmR3GJjUOn9dVhcpdRsqrXrRZwQMHMvD6o0uGtO7c/oQgoPm5TxV3
         Nfbi1+l8iCEtj7KEQ6mG5wl72NLeQvmnZg+Uj1i+FUO1QMf6WiqKifMF69grRPTfJDAy
         NGrZC/Gkf9JUt1qcHHS68l4Jnh9mNfjqp/UsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609046; x=1708213846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdad3Evs7q/LlRKkCSzkMMat3wm4/GWPiv0LyGMWHAo=;
        b=moRNomSsGlxa0cMCj3OGGHmeEEf4VKIKmLzN8Mgh1aUNFxiZOee0xfxvZYYD0SQR+W
         ZzGQTL4kTxzxEx2AQ4l7jBDZpZhU4YXPxf/pu4y8xyqgAbugSWUx57Z+1A/vcG5YPV4j
         RxSMIdLIlNOHqqYfwweIylxB+L1dx8JHQd6ZmL1ozIwQWgKinNAQgdqDAiLhWyJGi51y
         uMBo6sJQEnVM7CLw4X/syHfuSINKnWNfGDBBDKb8k1jHfKxBM3f0vQBAAIdA2DP99Bfj
         Pyusr10UaHQbIyVF1E+0kBasDXURbFlqIUqBCQDrUbSIuWo9dAMHaARAugB/jmu71YyQ
         I6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0QkbpL+2Qk+JmM5t3ayLzDbL3gCVfS6T6Vcv44uNMpUsR4pvcf/JhIzV4lVShYHDP/7WaiytUBmhikZNTOAQV8sclXL8Jw2Kv9nuc
X-Gm-Message-State: AOJu0Ywo4P+Cx5COnruXP3YgLkIYSezlwQ+d4xRTKOf2hFOD9o2IbvF6
	lJF9qBrDC4Zh6z8NY5yC/UPSkXoJpyDK3TUBxul3g6vxEZ8rkfZiY6LQz0Vs
X-Google-Smtp-Source: AGHT+IGgphL4YPys733aQd2TzTyZFRMTG6XMpvAEKxpm96maridBg6WMFLXffARfWdF60h4quVSYWg==
X-Received: by 2002:a05:6512:2246:b0:511:30fd:9223 with SMTP id i6-20020a056512224600b0051130fd9223mr2437424lfu.55.1707609046141;
        Sat, 10 Feb 2024 15:50:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeEN/u1Ra7BheU7TL7DwOI0jDwcjxIBHsm8aVcbFuDjCj+dW8hZSBy5ZT1IwGGzhMw5TqcEYZW5wLWCkd75BpMVrWwv0pTLf9lPeFUYkvRpsXNIJYQoM/x9N3DpljZPErHGV+NaskAjRof7bcNxFFVArSMz+1KZ3He9pWp1rvkOUycnbKChd3gzROwFRP02mN3cc9YBhrqWVmgHNoKi/q+q/a27oa5bzQrXllzp4a0sJ43xUUPen/EGCHScoFFkEdsI+Ggw89WzKmE0FHyVD4TyZ4m1nM6JHfhKVkoGk0eWZp1Vy3w6QG5vl1yGIKHzwKVdN9Qx9JtoSydwDa8ZF4H4uOfhwWtxS2BbMO7PODELBbmLTJFqggZ4xlLDnO+1qzDCwmrNpmvyUq+G2h/F9HXOlGd2T67KhOtuEn2M34nuv+nlrfD8ZOHMKztDVkitd8AU3TI8Gl0YtAKhS2NyeXq0bSlU++yKM/XTobzRUzEVUY7f9VhAG1e3GgRvODesSnS2M/MJiuscLwLkoO5HAOiB8zxi/5mpDyTFMYw073n+OZq1QbBzOKvqBmAEVVTT1ayanfbV9xLgVeqjiTskDbm4VZJ3uBxOaSF7FmF/bZej21DGw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:45 -0800 (PST)
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
Subject: [PATCH v4 10/39] dyndbg: add open and close commands for trace
Date: Sun, 11 Feb 2024 00:49:40 +0100
Message-ID: <20240210235009.2405808-11-ukaszb@chromium.org>
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

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/Kconfig.debug   |   2 +
 lib/dynamic_debug.c | 194 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..01caf885d86b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -110,6 +110,7 @@ config DYNAMIC_DEBUG
 	default n
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	depends on TRACING
 	select DYNAMIC_DEBUG_CORE
 	help
 
@@ -181,6 +182,7 @@ config DYNAMIC_DEBUG_CORE
 	bool "Enable core function of dynamic debug support"
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	depends on TRACING
 	help
 	  Enable core functional support of dynamic debug. It is useful
 	  when you want to tie dynamic debug to your kernel modules with
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0dc9ec76b867..d0d1057911e8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <linux/trace.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dyndbg.h>
@@ -73,6 +74,27 @@ struct flag_settings {
 	unsigned int mask;
 };
 
+#define DD_OPEN_CMD	"open"
+#define DD_CLOSE_CMD	"close"
+#define DD_TR_EVENT	"0"
+
+struct dd_private_tracebuf {
+	const char *name;
+	struct trace_array *arr;
+};
+
+/*
+ * Trace destination value 0 is reserved for writing
+ * debug logs to trace events (prdbg, devdbg), that
+ * is why buf[0] is not used and we traverse bitmap
+ * starting from bit 1 (bit 0 is also not used).
+ */
+struct dd_tracebuf_tbl_info {
+	struct dd_private_tracebuf buf[TRACE_DST_LAST];
+	DECLARE_BITMAP(bmap, TRACE_DST_LAST);
+	int bmap_size;
+};
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -80,6 +102,9 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static struct
+dd_tracebuf_tbl_info trc_tbl = { .bmap_size = TRACE_DST_LAST };
+
 static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
 {
 	return &desc->ctrl;
@@ -171,6 +196,145 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
+static bool is_dd_trace_cmd(const char *str)
+{
+	if (!strcmp(str, DD_OPEN_CMD) || !strcmp(str, DD_CLOSE_CMD))
+		return true;
+
+	return false;
+}
+
+static bool dd_good_trace_name(const char *str)
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
+	int idx = 1;
+
+	for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
+		if (!strcmp(trc_tbl.buf[idx].name, name))
+			return idx;
+
+	return -ENOENT;
+}
+
+static int handle_trace_open_cmd(const char *arg)
+{
+	struct dd_private_tracebuf *buf;
+	int idx, ret = 0;
+
+	mutex_lock(&ddebug_lock);
+
+	/* bit 0 is not used, reserved for trace prdbg and devdbg events */
+	idx = find_next_zero_bit(trc_tbl.bmap, trc_tbl.bmap_size, 1);
+	if (idx == trc_tbl.bmap_size) {
+		ret = -ENOSPC;
+		goto end;
+	}
+
+	if (!dd_good_trace_name(arg)) {
+		pr_err("invalid instance name:%s\n", arg);
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (find_tr_instance(arg) >= 0) {
+		pr_err("instance is already opened name:%s\n", arg);
+		ret = -EEXIST;
+		goto end;
+	}
+
+	buf = &trc_tbl.buf[idx];
+	buf->name = kstrdup(arg, GFP_KERNEL);
+	if (!buf->name) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	buf->arr = trace_array_get_by_name(buf->name, NULL);
+	if (!buf->arr) {
+		pr_err("failed to get trace array name:%s", buf->name);
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = trace_array_init_printk(buf->arr);
+	if (ret) {
+		pr_err("failed to init trace array name:%s", buf->name);
+		trace_array_put(buf->arr);
+		trace_array_destroy(buf->arr);
+		goto end;
+	}
+
+	set_bit(idx, trc_tbl.bmap);
+	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
+end:
+	mutex_unlock(&ddebug_lock);
+	return ret;
+}
+
+static int handle_trace_close_cmd(const char *arg)
+{
+	struct dd_private_tracebuf *buf;
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
+	buf = &trc_tbl.buf[idx];
+
+	trace_array_put(buf->arr);
+	/*
+	 * don't destroy trace instance but let user do it manually
+	 * with rmdir command at a convenient time later, if it is
+	 * destroyed here all debug logs will be lost
+	 *
+	 * trace_array_destroy(inst->arr);
+	 */
+	buf->arr = NULL;
+
+	kfree(buf->name);
+	buf->name = NULL;
+
+	clear_bit(idx, trc_tbl.bmap);
+	v3pr_info("closed trace instance idx=%d, name=%s\n", idx, arg);
+end:
+	mutex_unlock(&ddebug_lock);
+	return ret;
+}
+
+static int ddebug_parse_cmd(char *words[], int nwords)
+{
+	if (nwords != 1)
+		return -EINVAL;
+
+	if (!strcmp(words[0], DD_OPEN_CMD))
+		return handle_trace_open_cmd(words[1]);
+	if (!strcmp(words[0], DD_CLOSE_CMD))
+		return handle_trace_close_cmd(words[1]);
+
+	pr_err("invalid command %s\n", words[0]);
+	return -EINVAL;
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
+	if (is_dd_trace_cmd(words[0]))
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
@@ -1281,6 +1464,17 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 	seq_puts(m, "\n");
 
+	if (ddebug_iter_is_last(iter) &&
+	    !bitmap_empty(trc_tbl.bmap, trc_tbl.bmap_size)) {
+		int idx = 1;
+
+		seq_puts(m, "\n");
+		seq_puts(m, "#: Opened trace instances:");
+		for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
+			seq_printf(m, " %s", trc_tbl.buf[idx].name);
+		seq_puts(m, "\n");
+	}
+
 	return 0;
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


