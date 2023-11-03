Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D107E0362
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377605AbjKCNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377151AbjKCNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0F1BF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507ad511315so2892088e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017019; x=1699621819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xew6Ma5CImKuft65tcqud5KKub8N64RdoRmBOoBM77I=;
        b=Wtx0ohMy4S1IDePk8j5q+iVebvU0mI3nfRARZwrkzPzfB6V9vAiNNZrxfo2uD/8bif
         3esFG6RXoHTjBURgMdemFtzhiAV4wOl0q4r53lozuVvtT4Mvieki5D98XRXXMUb5tBVr
         iWBQr2Rn95oomzTxzZJD5hcS8Mix72dEAkQXEa+gf3u/cahl7a1JLS7P6uCMw7YQ+gAT
         eyggjlgL0h210LxfwLAAEwr13J0ISvDEBCFyoap41cRlnFye67q1qqIlMq9+isMJijrl
         bgm/NiWW0PkxHGr/N+nd/229LfTwjNM8Evhyidi+z1vne7VSX8pqs6n5cu7G0cPIJ4TL
         X8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017019; x=1699621819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xew6Ma5CImKuft65tcqud5KKub8N64RdoRmBOoBM77I=;
        b=J2hXJ7F+UDoxnkvUsgR/J1NVmb8W6VeRFnHdFc5YSAjWkix3kAK+OPD0q1qvGTMDR0
         PbtFScrVrKH03ySmIT5eIkFjlSTDBKuZri6ljfziLMhiSScamqFF/simKs6p0ezH1StK
         exbdEIgaoOuNd1bMvJbR5kvJZtZA/7DjHXqVS3mV1LNHeyJMxaeFnd4hGrnlgHFlg8UM
         uXp84FlwGpuC1XD0ZrUZWg+hVnUueNNAwzlaUpsioNAQbtwGVVUMalA6sZmrRcS8cNWM
         g950wucPbv5Ol3SFEvHKk1M9tUZqa6KgldZdoaP8AQ+R6dt2X8P8HM3fbyHdKSI5spwi
         /sFQ==
X-Gm-Message-State: AOJu0YwSvj8MpN0oXV2eZj/83j2xBDtRSYkVkVk4EERxKSldCN8cE2v7
        H/goBLHFTb3OriJ3xRBwWjL2
X-Google-Smtp-Source: AGHT+IGJSgmwbzgIhCd8uh++SUUn7/yvo/9rEGYloj2mFXAk1EyoITkkg4vZPxQ/SpAuZa9TVAjpdg==
X-Received: by 2002:ac2:4205:0:b0:509:4d7a:ab05 with SMTP id y5-20020ac24205000000b005094d7aab05mr3138624lfh.11.1699017019166;
        Fri, 03 Nov 2023 06:10:19 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:18 -0700 (PDT)
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
Subject: [PATCH v1 04/12] dyndbg: add 2 trace-events: pr_debug, dev_dbg
Date:   Fri,  3 Nov 2023 14:10:03 +0100
Message-Id: <20231103131011.1316396-5-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
In-Reply-To: <20231103131011.1316396-1-lb@semihalf.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
MIME-Version: 1.0
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

These events get the _ddebug descriptor, so they can access the whole
callsite record: file, line, function, flags.  This allows the
addition of a dynamic prefix later.

So ddebug_trace() gets 2 new args: the descriptor and the device.
And its callers: ddebug_printk(), ddebug_dev_printk() upgrade their
flags param to pass the descriptor itself, and thus also the flags.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 MAINTAINERS                   |  1 +
 include/trace/events/dyndbg.h | 74 +++++++++++++++++++++++++++++++++++
 lib/dynamic_debug.c           | 73 +++++++++++++++++-----------------
 3 files changed, 112 insertions(+), 36 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..fd02dc86f1fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7320,6 +7320,7 @@ M:	Jason Baron <jbaron@akamai.com>
 M:	Jim Cromie <jim.cromie@gmail.com>
 S:	Maintained
 F:	include/linux/dynamic_debug.h
+F:	include/trace/events/dyndbg.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
 
diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.h
new file mode 100644
index 000000000000..ccc5bcb070f9
--- /dev/null
+++ b/include/trace/events/dyndbg.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM dyndbg
+
+#if !defined(_TRACE_DYNDBG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DYNDBG_H
+
+#include <linux/tracepoint.h>
+
+/* capture pr_debug() callsite descriptor and message */
+TRACE_EVENT(prdbg,
+	    TP_PROTO(const struct _ddebug *desc, const char *text, size_t len),
+
+	    TP_ARGS(desc, text, len),
+
+	    TP_STRUCT__entry(
+			__field(const struct _ddebug *, desc)
+			__dynamic_array(char, msg, len + 1)
+		    ),
+
+	    TP_fast_assign(
+			__entry->desc = desc;
+			/*
+			 * Each trace entry is printed in a new line.
+			 * If the msg finishes with '\n', cut it off
+			 * to avoid blank lines in the trace.
+			 */
+			if (len > 0 && (text[len - 1] == '\n'))
+				len -= 1;
+
+			memcpy(__get_str(msg), text, len);
+			__get_str(msg)[len] = 0;
+		    ),
+
+	    TP_printk("%s.%s %s", __entry->desc->modname,
+		      __entry->desc->function, __get_str(msg))
+);
+
+/* capture dev_dbg() callsite descriptor, device, and message */
+TRACE_EVENT(devdbg,
+	    TP_PROTO(const struct _ddebug *desc, const struct device *dev,
+		     const char *text, size_t len),
+
+	    TP_ARGS(desc, dev, text, len),
+
+	    TP_STRUCT__entry(
+			__field(const struct _ddebug *, desc)
+			__field(const struct device *, dev)
+			__dynamic_array(char, msg, len + 1)
+		    ),
+
+	    TP_fast_assign(
+			__entry->desc = desc;
+			__entry->dev = (struct device *) dev;
+			/*
+			 * Each trace entry is printed in a new line.
+			 * If the msg finishes with '\n', cut it off
+			 * to avoid blank lines in the trace.
+			 */
+			if (len > 0 && (text[len - 1] == '\n'))
+				len -= 1;
+
+			memcpy(__get_str(msg), text, len);
+			__get_str(msg)[len] = 0;
+		    ),
+
+	    TP_printk("%s.%s %s", __entry->desc->modname,
+		      __entry->desc->function, __get_str(msg))
+);
+
+#endif /* _TRACE_DYNDBG_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 016f33c20251..1ed3c4f16f69 100644
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
+		trace_prdbg(desc, buf->buf, len);
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
2.42.0.869.gea05f2083d-goog

