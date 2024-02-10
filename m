Return-Path: <linux-kernel+bounces-60591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125C850760
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83E31F210CA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9F6089B;
	Sat, 10 Feb 2024 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aylZEiq9"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B807605D0
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609046; cv=none; b=RHJ/V6RdMadeUBE5FfSVbln3iWgdBIYWpY/qHf3dIyi7m5A8DrKL8AZeENhVbuyvubl3MseiOs5hrgC5phHWwRcT0+7y4Co72vVB9CvlUCNNZFUyeNWwejjvwCFd5TfKeQ1Ui5+gIxbsS9NS+IPYazzqa+uXMBWBtfrHFC9OyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609046; c=relaxed/simple;
	bh=N7cA8bn8EjCVuVHuDU0PP9ju1v33Lwp1kuaVQzOCU4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGvPaKraZlkMy7ZYQnhflA8LqaiNerpdIQcA9hA4HupcryqL0DgGgJ7PXIqK0KKsW6LLVSFUIxScb9NUfOmq0q/H219dXMB1Jt48nR6ZkStD3tZGOhdfJGy3K5Vx4KfQjPoP6i6ZjKyXK2wFUHcmdZrPbCWR14MvKfjZmC+ona8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aylZEiq9; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-511570b2f49so2794220e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609042; x=1708213842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSW8rXIgUpmvq2wb08IXdigJ9UWnCc/ryLuvI1HuFRg=;
        b=aylZEiq9E/qFEiR/eiO+ebTW0jVWymk8vKgiAgun+zEQoOIjRMrt75KKN5I6wECC3q
         JiAQPjX6RskCapxzw1YWEhNH0DRXepXvor/XoZkbw01FxmQ9aIo1IO2ecViUCxDe5SWX
         NMEXdnFwKf/zX86RXJbA3uL2COwNzMvWyRrX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609042; x=1708213842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSW8rXIgUpmvq2wb08IXdigJ9UWnCc/ryLuvI1HuFRg=;
        b=Wm3QpOqHInywbNd+IWcRMfpeN/riFut1Ylze8l/I9flthXX2Meq0Zktj+WbUSsbXKZ
         6oquioHdy4xMCK2N0MVkKwxxo7bbFXB5DMyXi5KZWfwyrtOX5f3TyiLwpAm7wzuljsK+
         xJ1hjFKXtZi46BtGIc4nSdUESK3w+b7VG24MgjcqqrKUT8XwfpOFvbIMYH8ZfM0GFmHj
         2mfoJ4htKOkiziP3iUPHJJilYoWQD44G3urGkQXgzao1MCVvf3ltAfftK8Fc13rQjR4S
         Bf4xHUBMZfldVIzOFUvR6jwyPC/J29ngkZDdqQOGgGo/RwJDI6y7cMNJfulJGijE0BjY
         YjEg==
X-Gm-Message-State: AOJu0YxRP+YvtNTVNl0yekGTH5WggwXDYOXnpnmfo2DYgpFlz+H9+6FO
	aWP+T5i28SpyC0eMSyKbZVnwRMnydcdIdh8/FS730007J5B4s7x4fLRdyV6W
X-Google-Smtp-Source: AGHT+IEKs9GSfzJRjw3qonTGvh/0m1R1sF4z+fwNII8EEjOshComreCrNOfWBOkhn9OqXbC7xKa2Zw==
X-Received: by 2002:a05:6512:3e28:b0:511:737d:661a with SMTP id i40-20020a0565123e2800b00511737d661amr1974636lfv.28.1707609042741;
        Sat, 10 Feb 2024 15:50:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEL6IuQVTDfgEq8cmA2Dm+DQ6N5Xl8H019iNbYo2XCU4T/t5EfPLhwRWbW0eIkvQ/fsdmfg52wQAqYjGeg65ItFFZhgyU1UjLS4as++Up2B0G7HcTk7j3xrhSddP0r35tomWTt+fYGG6/Num6QlOzOOF5qusTEhCvux9Yx77gdWSvOyYHzC1TpNVnL6ZUOwDHyDC9kjH3PyGBKcDdf/RTnqXWU9TfQ7zEU4KAplqLorHAbfnozeZcDSQZic6SfHbwcEiY9EpesTToE4jn65n03Q4mhnmNORUMpif8FEGqi3TXjn6uvxYtT2/7v/IblP4iaE8lPKMYZVUp2W9Sret0nyXH1DL0ibb7E5Jd/CL7jhFvvA/IMyd6D9K6l9Ro5oCoL0r7YDSWyH3G1bPQY1R3iCz/pZs78c6vRZFUXFnSs6k5FzuQYXp94gN5brY/WhfwHNcKLn+i/q7lSzbDdvk582EaQMdh0VrEy+y5C/a4qKFiwYzh0vCE83OKSbJJjO8q7iGbH5sTHriqVNZRu6lQZbMnEyjOxnbAq1i6il6+PyMSBLSICfGVhl5i3ZOU/M3UBqjPq7/NnVR7dtOifd04CavmWPDg7XfVqKxV5PvqhdOLNMQ==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:42 -0800 (PST)
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
Subject: [PATCH v4 08/39] dyndbg: move flags field to a new structure
Date: Sun, 11 Feb 2024 00:49:38 +0100
Message-ID: <20240210235009.2405808-9-ukaszb@chromium.org>
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

Add a new structure ctrl and place it in 4 padding bytes
of _ddebug struct. Move flags field to the ctrl struct
and create setter and getter for the flags field. Add unused
fields to explicitly emphasise size of each bitfield.
This step prepares for addition of a trace_dst field.

Layout of _ddebug struct after addition of ctrl is:

struct _ddebug {
        union {
                struct static_key_true dd_key_true;      /*     0    16 */
                struct static_key_false dd_key_false;    /*     0    16 */
        } key;                                           /*     0    16 */

        const char  *              modname;              /*    16     8 */
        const char  *              function;             /*    24     8 */
        const char  *              filename;             /*    32     8 */
        const char  *              format;               /*    40     8 */
        unsigned int               lineno:18;            /*    48: 0  4 */
        unsigned int               class_id:6;           /*    48:18  4 */
        unsigned int               unused:8;             /*    48:24  4 */
        struct dd_ctrl             ctrl;                 /*    52     4 */

        /* size: 56, cachelines: 1, members: 9 */
        /* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 include/linux/dynamic_debug.h | 13 +++++++----
 lib/dynamic_debug.c           | 44 ++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b9237e4ecd1b..a551b2967cb8 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,8 @@ struct _ddebug {
 #define CLS_BITS 6
 	unsigned int class_id:CLS_BITS;
 #define _DPRINTK_CLASS_DFLT		((1 << CLS_BITS) - 1)
+	unsigned int unused:8;
+
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -58,7 +60,10 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	unsigned int flags:8;
+	struct {
+		unsigned int flags:8;
+		unsigned unused:24;
+	} ctrl;
 } __attribute__((aligned(8)));
 
 enum class_map_type {
@@ -171,7 +176,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.filename = __FILE__,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
-		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		.ctrl = { .flags = _DPRINTK_FLAGS_DEFAULT },	\
 		.class_id = cls,				\
 		_DPRINTK_KEY_INIT				\
 	};							\
@@ -202,10 +207,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
+	likely(descriptor.ctrl.flags & _DPRINTK_FLAGS_ENABLED)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
+	unlikely(descriptor.ctrl.flags & _DPRINTK_FLAGS_ENABLED)
 #endif
 
 #endif /* CONFIG_JUMP_LABEL */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9682277f3909..f47cb76e0e3d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -80,6 +80,16 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static inline unsigned int get_flags(const struct _ddebug *desc)
+{
+	return desc->ctrl.flags;
+}
+
+static inline void set_flags(struct _ddebug *desc, unsigned int val)
+{
+	desc->ctrl.flags = val;
+}
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -247,11 +257,11 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
-			if (newflags == dp->flags)
+			newflags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
+			if (newflags == get_flags(dp))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
+			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
 				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
 			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
@@ -261,9 +271,9 @@ static int ddebug_change(const struct ddebug_query *query,
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
-				  ddebug_describe_flags(dp->flags, &fbuf),
+				  ddebug_describe_flags(get_flags(dp), &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
-			dp->flags = newflags;
+			set_flags(dp, newflags);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -824,10 +834,11 @@ static int remaining(int wrote)
 
 static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 {
+	unsigned int flags = get_flags(desc);
 	int pos_after_tid;
 	int pos = 0;
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -835,16 +846,16 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
+	if (flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				trim_prefix(desc->filename));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
 	if (pos - pos_after_tid)
@@ -857,7 +868,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 
 static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
-	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
+	if (unlikely(get_flags(desc) & _DPRINTK_FLAGS_INCL_ANY))
 		return __dynamic_emit_prefix(desc, buf);
 	return buf;
 }
@@ -916,7 +927,8 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 __printf(2, 3)
 static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
-	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
+
+	if (get_flags(desc) & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -928,7 +940,7 @@ static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 		va_end(args);
 	}
 
-	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -942,7 +954,7 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 			      const char *fmt, ...)
 {
 
-	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -950,7 +962,7 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 		va_end(args);
 	}
 
-	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -1246,7 +1258,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp->flags, &flags));
+		   ddebug_describe_flags(get_flags(dp), &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
 
-- 
2.43.0.687.g38aa6559b0-goog


