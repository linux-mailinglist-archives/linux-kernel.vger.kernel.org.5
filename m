Return-Path: <linux-kernel+bounces-60587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03085075C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638681C2150D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F6A604CD;
	Sat, 10 Feb 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TPcv2/vp"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE946026D
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609040; cv=none; b=cGrQpH+a+qfOJpHoP3pPhxVa/4c6P2i7sny8FOfSYEK3hgpLXJuevhjhlUghMYiY5B4VJPSLQ4EVuM2dPoa9At076HTOcfPCTsacreErp8VlJjqYiQCcrU+w8phivuUnmdYOT86FwEEEgMisnHAsFOY8ZEWhqcTtidEHmGfDoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609040; c=relaxed/simple;
	bh=0WPu5jLceer/15RgqkDnTN8EtF6NRfk3cwJFKokZXw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdYhPp2uW3fPmIcuX1UiywOyZ6TvhcpUOwyHinkMlvKhNaYzm7GLxwdpwVokpu054EegT5LWG6FlGYC3cUyNXabxPUwgucgIl7MOnAf307zOuUYVe3CyiteGn0xeWIGK1BvCnjeAvbPGgIizYXFKLy/6TUnKjCPCNqyQzXc03ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TPcv2/vp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5114c05806eso3460895e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609036; x=1708213836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLc3gWSl0LchmKR99ALue7JLN9oC+x+LGj79tJSMKXk=;
        b=TPcv2/vpk1PbjwueE4X9Bh3G/6pn4azZHMUYmEvuaP0giC+E+RFZ/SN2g7LJZxisnw
         OTw92MSpjpiTgZF0iqOKY5N2+b9b2t1fOyK9lSh1O8pNeZHPGMm1pqv82uyIlQwXxVjg
         Mc3b7km+SRGFCukjGPFwI/LafJojzHSNvcJQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609036; x=1708213836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLc3gWSl0LchmKR99ALue7JLN9oC+x+LGj79tJSMKXk=;
        b=LjpL7Ac3jOwpUFyakHgbtw5rvEz7v4zA6FO6FDE24s+uzZnhbFM5gLDyhCsrMGUrRM
         UP8C2d+RmVPIoifb6hGog3+CGQSBNJ+IlncWNgMsBjfFyIdYAgukp/q+FGTL/tDUXF6I
         nZRHrallIfKEnnM+YBO9ZPVZh3LW25bTSLIQOtepiTuV8ABymNi+5Z8oi0ErhrfYn3/f
         iV26gfEXmXohhk+V+PDd/Z1Xs7Dc+0Cwn7RquYqqgXYYgy22uE/qiew2twtDEyVSMTxo
         uAoq096aPJlzetVZgFgXEIrkRk/4s/CEMDXum2p8stokxYGWOBHIsFVAmnn/fbrflnIM
         DQKQ==
X-Gm-Message-State: AOJu0YxaXs89vQnM5qaNL2JZwwciRDmhcfnfpiFNApkNhJfAGf+yJK/g
	9saAbA7eZZdoIn8qUpXeFWnBEITDrZUXYb5KaBeZ4KaEO4WZqsdxn8G6qHaG
X-Google-Smtp-Source: AGHT+IEfXDUkwHpuZymjvVIoMA+f4e01+PqsjC9Xr8hGVh0+x96mINZYFrxIU53RXdMe5y103XC7Tw==
X-Received: by 2002:a05:6512:3a8b:b0:511:6e10:b80e with SMTP id q11-20020a0565123a8b00b005116e10b80emr2312748lfu.33.1707609035990;
        Sat, 10 Feb 2024 15:50:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaQDyedBIoalcHoj2hK83zkBhs6ItS+Rswe3MiPpk7uCpr83LdsqrqFU4cVDjrNGQit7ssv0A1f5ixj7MOEVkvhop0dgy/K0hE4FQ07Ml8TdyQ4CS2PGbJ+/72sLx/j3vTrtiSoXmfeJpjGhIwmly1aTk55s9h62u87KsfFCBoPAqeJKqy+9Jm1eRf9ufq9sXIWBDq1b4MmkOosKnXSmtoxvQhZ+Yb61fMKuv9YmkhjIr1bevnedaYW3UT9yKQIliPuOHSvgPxx2XacEDP6v/b+pEwN+xBXsjZoJ/P1mOG375ajp2/Ci7uoJFC8LgASS8ffxHoW+2wPMbemvH44WVCnIbBMJ7IWcEQ+t2ncPBKaO5dldNsvR/o9NyN5AikHZrqa83+A/tYHqrZyvQ1NbpJCgCSORJUtYU0w1GYrvgtl5zP7/nEi6SHNte2tYBt/7v9rOyk55TMDYQbG5KiYXiZSz4h11XshKfi6ufZNDpix2yAseFB6S5ZpUWE20TAvev3Wkk6CVv6VAw98iDs19CcZq1tIoKKGcIGOZBEDe22lekxTe50/UYRwsdfjcYcHZdsMFTMA2WB/JslnyQXakLXSE82jvajLNm0A5Tj7IsUZdhavg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:35 -0800 (PST)
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
Subject: [PATCH v4 04/39] dyndbg: add 2 trace-events: prdbg, devdbg
Date: Sun, 11 Feb 2024 00:49:34 +0100
Message-ID: <20240210235009.2405808-5-ukaszb@chromium.org>
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
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 MAINTAINERS                   |  1 +
 include/trace/events/dyndbg.h | 63 ++++++++++++++++++++++++++++++
 lib/dynamic_debug.c           | 73 ++++++++++++++++++-----------------
 3 files changed, 101 insertions(+), 36 deletions(-)
 create mode 100644 include/trace/events/dyndbg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..b584a8468fb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7456,6 +7456,7 @@ M:	Jason Baron <jbaron@akamai.com>
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
2.43.0.687.g38aa6559b0-goog


