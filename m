Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB297FFF98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377377AbjK3XlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377365AbjK3XlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2D10E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso1725266a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387684; x=1701992484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=889GJOHWqz8X7/6SioxMP37jbJbwdcCN/V159RYDKdg=;
        b=bPsAr2QR8oRtCuln/Y4lu4ZpBIkBFbz5lNYHuCc3StxLR0jzuRbUsIorziqNg52pPJ
         lPps9qbEfy+6T81k5XhI2uZLiltUyl+pIBb6hPL8jWo7TDqetWCc3yup8J05cN2UFO/2
         vxu+58beVwnNCB+XZZTA/o03hJJoKFBH4shVT12bT22UbCWkufxInE4mHPaxXucpzzE6
         2+LoNvm8ooY4EC/xlTx2wb1npyIKrup86mvG1JmH6buT0DbF3cNrU26GulY2/JhMp0ZC
         rbXZn//jmfL6W5S04ZhWUXLPZcZf5KHHO+ucvPT/yvnbm6sqDOIot+hYdx1GkfwFffqo
         1sRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387684; x=1701992484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=889GJOHWqz8X7/6SioxMP37jbJbwdcCN/V159RYDKdg=;
        b=YmGx8odoBXW6SgSAB0GuSAM+hQxkfD5INxbBwSzIi7+9n9KSgKSH26kdHgqcIpddSk
         B3qGMPd3VheIv0VuqtMU8uOxbDbOf91a0L9JaUcXMJcWAsnECdcJL3xJVDGzbtdqyMjK
         kkfoFTw4jbj/Dj4uPU4Mo/amDdHz7//UmdCKJh3fh4Tq4rpcSGSh8j9QUGcz3P+7V7K7
         rFkvflBqPcSUs/D4HoWP1fxkkNLqB2XVetoXcMJMIUqEVGdEFNJTRHlrZoh+ZMoZkQng
         /f8Vmhb8ylyW8GoFhuhKXQT+AhTlC4ATQmGjQk2bRou5xLJxZJPtUS/xb9pab+z0xlrW
         RPiQ==
X-Gm-Message-State: AOJu0YzubbKC+b/xvKHUA6n/H4MmOqohdv6r39xJXUCNl/tdek5w4JP3
        HqpV2OrBCeznoMfVHU547K/+
X-Google-Smtp-Source: AGHT+IEfAxdhDpjC3tweNNgjd335fypyPetZ2xzqVFfCjUKgUVgRpDvE1qkSqnQLo740ajDVEZZpJg==
X-Received: by 2002:a17:906:2c44:b0:a19:a19a:eaba with SMTP id f4-20020a1709062c4400b00a19a19aeabamr246090ejh.115.1701387684244;
        Thu, 30 Nov 2023 15:41:24 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:23 -0800 (PST)
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
Subject: [PATCH v2 04/15] dyndbg: add 2 trace-events: prdbg, devdbg
Date:   Fri,  1 Dec 2023 00:40:37 +0100
Message-ID: <20231130234048.157509-5-lb@semihalf.com>
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

From: Jim Cromie <jim.cromie@gmail.com>

ddebug_trace() currently issues a single printk:console event.
Replace that event by adding include/trace/events/dyndbg.h,
which defines 2 new trace-events: dyndbg:prdbg & dyndbg:devdbg.

These events save a debug message and use its length for
processing. They also accept the _ddebug descriptor and dev
structure so they can be used to access the whole callsite
record in the future: file, line, function, flags. This allows
the addition of a dynamic prefix later.

So ddebug_trace() gets 2 new args: the descriptor and the device.
And its callers: ddebug_printk(), ddebug_dev_printk() upgrade their
flags param to pass the descriptor itself, and thus also the flags.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 MAINTAINERS                   |  1 +
 include/trace/events/dyndbg.h | 63 ++++++++++++++++++++++++++++++
 lib/dynamic_debug.c           | 73 ++++++++++++++++++-----------------
 3 files changed, 101 insertions(+), 36 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..be1e8e39375c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7319,6 +7319,7 @@ M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
 F:	include/linux/dynamic_debug.h
+F:	include/trace/events/dyndbg.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
 
diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.h
new file mode 100644
index 000000000000..647c30206a7d
--- /dev/null
+++ b/include/trace/events/dyndbg.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dyndbg
+
+#if !defined(_TRACE_DYNDBG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DYNDBG_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * template for dynamic debug events
+ * captures debug log message and uses its length, it also
+ * accepts _ddebug and dev structures for future extensions
+ */
+DECLARE_EVENT_CLASS(dyndbg_template,
+
+	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
+		 const char *msg, size_t len),
+
+	TP_ARGS(desc, dev, msg, len),
+
+	TP_STRUCT__entry(
+		__dynamic_array(char, s, len+1)
+	    ),
+
+	TP_fast_assign(
+		/*
+		 * Each trace entry is printed in a new line.
+		 * If the msg finishes with '\n', cut it off
+		 * to avoid blank lines in the trace.
+		 */
+		if (len > 0 && (msg[len-1] == '\n'))
+			len -= 1;
+
+		memcpy(__get_str(s), msg, len);
+		__get_str(s)[len] = 0;
+	    ),
+
+	TP_printk("%s", __get_str(s))
+);
+
+/* captures pr_debug() callsites */
+DEFINE_EVENT(dyndbg_template, prdbg,
+
+	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
+		 const char *msg, size_t len),
+
+	TP_ARGS(desc, dev, msg, len)
+);
+
+/* captures dev_dbg() callsites */
+DEFINE_EVENT(dyndbg_template, devdbg,
+
+	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
+		 const char *msg, size_t len),
+
+	TP_ARGS(desc, dev, msg, len)
+);
+
+#endif /* _TRACE_DYNDBG_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 016f33c20251..fcc7c5631b53 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,7 +36,9 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
-#include <trace/events/printk.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/dyndbg.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -878,7 +880,9 @@ struct ddebug_trace_bufs {
 static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
 static DEFINE_PER_CPU(int, ddebug_trace_reserve);
 
-static void ddebug_trace(const char *fmt, va_list args)
+__printf(3, 0)
+static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
+			 const char *fmt, va_list args)
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
@@ -897,7 +901,11 @@ static void ddebug_trace(const char *fmt, va_list args)
 	buf = this_cpu_ptr(ddebug_trace_bufs.bufs) + bufidx;
 
 	len = vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
-	trace_console(buf->buf, len);
+
+	if (!dev)
+		trace_prdbg(desc, NULL, buf->buf, len);
+	else
+		trace_devdbg(desc, dev, buf->buf, len);
 
 out:
 	/* As above. */
@@ -907,9 +915,9 @@ static void ddebug_trace(const char *fmt, va_list args)
 }
 
 __printf(2, 3)
-static void ddebug_printk(unsigned int flags, const char *fmt, ...)
+static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
-	if (flags & _DPRINTK_FLAGS_TRACE) {
+	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -917,11 +925,11 @@ static void ddebug_printk(unsigned int flags, const char *fmt, ...)
 		 * All callers include the KERN_DEBUG prefix to keep the
 		 * vprintk case simple; strip it out for tracing.
 		 */
-		ddebug_trace(fmt + strlen(KERN_DEBUG), args);
+		ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
 		va_end(args);
 	}
 
-	if (flags & _DPRINTK_FLAGS_PRINTK) {
+	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -931,19 +939,19 @@ static void ddebug_printk(unsigned int flags, const char *fmt, ...)
 }
 
 __printf(3, 4)
-static void ddebug_dev_printk(unsigned int flags, const struct device *dev,
+static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 			      const char *fmt, ...)
 {
 
-	if (flags & _DPRINTK_FLAGS_TRACE) {
+	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
-		ddebug_trace(fmt, args);
+		ddebug_trace(desc, dev, fmt, args);
 		va_end(args);
 	}
 
-	if (flags & _DPRINTK_FLAGS_PRINTK) {
+	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -966,7 +974,7 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	ddebug_printk(descriptor->flags, KERN_DEBUG "%s%pV",
+	ddebug_printk(descriptor, KERN_DEBUG "%s%pV",
 		      dynamic_emit_prefix(descriptor, buf), &vaf);
 
 	va_end(args);
@@ -977,7 +985,6 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 		       const struct device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
-	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -987,15 +994,14 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	flags = descriptor->flags;
 
 	if (!dev) {
-		ddebug_printk(flags, KERN_DEBUG "(NULL device *): %pV",
-			      &vaf);
+		ddebug_printk(descriptor, KERN_DEBUG "(NULL device *): %pV",
+			       &vaf);
 	} else {
 		char buf[PREFIX_SIZE] = "";
 
-		ddebug_dev_printk(flags, dev, "%s%s %s: %pV",
+		ddebug_dev_printk(descriptor, dev, "%s%s %s: %pV",
 				  dynamic_emit_prefix(descriptor, buf),
 				  dev_driver_string(dev), dev_name(dev),
 				  &vaf);
@@ -1011,7 +1017,6 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
-	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -1021,24 +1026,22 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	flags = descriptor->flags;
 
 	if (dev && dev->dev.parent) {
 		char buf[PREFIX_SIZE] = "";
 
-		ddebug_dev_printk(flags, dev->dev.parent,
-				   "%s%s %s %s%s: %pV",
-				   dynamic_emit_prefix(descriptor, buf),
-				   dev_driver_string(dev->dev.parent),
-				   dev_name(dev->dev.parent),
-				   netdev_name(dev), netdev_reg_state(dev),
-				   &vaf);
+		ddebug_dev_printk(descriptor, dev->dev.parent,
+				  "%s%s %s %s%s: %pV",
+				  dynamic_emit_prefix(descriptor, buf),
+				  dev_driver_string(dev->dev.parent),
+				  dev_name(dev->dev.parent),
+				  netdev_name(dev), netdev_reg_state(dev),
+				  &vaf);
 	} else if (dev) {
-		ddebug_printk(flags, KERN_DEBUG "%s%s: %pV",
-			       netdev_name(dev), netdev_reg_state(dev), &vaf);
+		ddebug_dev_printk(descriptor, &dev->dev, KERN_DEBUG "%s%s: %pV",
+				  netdev_name(dev), netdev_reg_state(dev), &vaf);
 	} else {
-		ddebug_printk(flags, KERN_DEBUG "(NULL net_device): %pV",
-			       &vaf);
+		ddebug_printk(descriptor, KERN_DEBUG "(NULL net_device): %pV", &vaf);
 	}
 
 	va_end(args);
@@ -1054,18 +1057,16 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 {
 	struct va_format vaf;
 	va_list args;
-	unsigned int flags;
 
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	flags = descriptor->flags;
 
 	if (ibdev && ibdev->dev.parent) {
 		char buf[PREFIX_SIZE] = "";
 
-		ddebug_dev_printk(flags, ibdev->dev.parent,
+		ddebug_dev_printk(descriptor, ibdev->dev.parent,
 				  "%s%s %s %s: %pV",
 				  dynamic_emit_prefix(descriptor, buf),
 				  dev_driver_string(ibdev->dev.parent),
@@ -1073,10 +1074,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				  dev_name(&ibdev->dev),
 				  &vaf);
 	} else if (ibdev) {
-		ddebug_printk(flags, KERN_DEBUG "%s: %pV",
-			      dev_name(&ibdev->dev), &vaf);
+		ddebug_dev_printk(descriptor, &ibdev->dev, KERN_DEBUG "%s: %pV",
+				  dev_name(&ibdev->dev), &vaf);
 	} else {
-		ddebug_printk(flags, KERN_DEBUG "(NULL ip_device): %pV", &vaf);
+		ddebug_printk(descriptor, KERN_DEBUG "(NULL ip_device): %pV", &vaf);
 	}
 
 	va_end(args);
-- 
2.43.0.rc2.451.g8631bc7472-goog

