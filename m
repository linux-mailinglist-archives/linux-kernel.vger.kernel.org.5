Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258627FFF9A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377372AbjK3XlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377368AbjK3XlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:17 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CD10F3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:22 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54acdd65c88so1814165a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387681; x=1701992481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrPwIwR3VEBYybM6RGTBtB0qlrcLpOcaaHY2TiBjIw0=;
        b=s1l68HCg7c52Zzrm/xjMY4hPvcMKxLo1Bir4T4KIEe9XuVAQvVQvZw36EF9L5VPhQQ
         HK9a+4BDzorCCgHnUIqsiy1FJwpP5HWx0n9abSGL1xGBH/hgeXV0XFAIJwSmN3tIDnq6
         +j1wh6A5kPumIvY4UZ0NHbQFMdNuUU/P4SWE9I8KyWWNpaRkGrckvNn/dldgT0hBODj0
         binyxgZwagQBHlowm6DnbLOlkjU/cGdhXP25NuqBLzXYMVeCcj723zWmyuc/cFdF2p3s
         0A80DQzqH7oNTvJ5hrVN+6091V2YM0+6TNK5dWEkO37QJaJBNvy1t/lwX6Y2JlGgCAkR
         45nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387681; x=1701992481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrPwIwR3VEBYybM6RGTBtB0qlrcLpOcaaHY2TiBjIw0=;
        b=fm72K5diMbaZU5zHkzRRzYHiDn7wcR7PKwge6KhcSoEtd4xfNXtIFxbtPKcWXkOmnI
         kdtyuyckNtmg6fpYEgq1aXzC8TWldgcw1Ob2LgnT7hugtQBG9zsnzmEGPdrk9bUWOkOW
         PuBn4Z8t+VSrVef5UUCO8VbdGDyufyyIa3V7+3tpHqqAq0q29+02ZL7dvX87BXrAU3Ow
         5R24cXto+eed21ZjJjadhJZ+L5KlWbNAVWRUl+aZQkLl4OHIXoyny1CRRXw/3/oMvEPo
         FUxipSR9dOTYWfVtdvQoSUJ8EyHI17pomSNDd/3UtXmmvIc9LMF5gnzPCSrsYCH2EDtK
         1ngw==
X-Gm-Message-State: AOJu0Yyeg9PQTM29C7DdfzM7oog1fipmb6Y9xL0MepLfq6RpjWAbUHZV
        wbkYYig5Tq79tbcRw5tf4OAP
X-Google-Smtp-Source: AGHT+IF1+Hs7K9b+IDW///3FHeDDtwSwAYzyp5j0S049I7yEiloJN063jPjIvBgTcnpOVk+L+cwsZw==
X-Received: by 2002:a17:906:fcba:b0:a16:88e8:2de7 with SMTP id qw26-20020a170906fcba00b00a1688e82de7mr232849ejb.23.1701387680935;
        Thu, 30 Nov 2023 15:41:20 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:20 -0800 (PST)
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
Subject: [PATCH v2 03/15] dyndbg: add write events to tracefs code
Date:   Fri,  1 Dec 2023 00:40:36 +0100
Message-ID: <20231130234048.157509-4-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
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

adds: ddebug_trace()
 uses trace_console() temporarily to issue printk:console event
 uses internal-ish __ftrace_trace_stack code:
      4-context buffer stack, barriers per Steve Rostedt

call it from new funcs:
  ddebug_printk() - print to both syslog/tracefs
  ddebug_dev_printk() - dev-print to both syslog/tracefs

These handle both _DPRINTK_FLAGS_PRINTK and _DPRINTK_FLAGS_TRACE
cases, allowing to vsnprintf the message once and use it for both,
skipping past the KERN_DEBUG character for tracing.

Finally, adjust the callers: __ddebug_{pr_debug,{,net,ib}dev_dbg},
replacing printk and dev_printk with the new funcs above.

The _DPRINTK_FLAGS_TRACE flag character is 'T', so the following finds
all callsites enabled for tracing:

  grep -P =p?T /proc/dynamic_debug/control

This patch,~1,~2 are basically copies of: https://lore.kernel.org/lkml/
20200825153338.17061-1-vincent.whitchurch@axis.com

with a few differences:

- s/dynamic_/ddebug_/ on Vincent's additions
- __printf attrs on the _printk funcs
- reuses trace_console() event, not adding a new "printk:dyndbg" event.
  next patch replaces this with 2 new events

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |   5 +-
 lib/dynamic_debug.c                           | 156 +++++++++++++++---
 2 files changed, 133 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0b3d39c610d9..8a126e10a6c5 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -209,8 +209,9 @@ of the characters::
 
 The flags are::
 
-  p    enables the pr_debug() callsite.
-  _    enables no flags.
+  p    callsite prints to syslog
+  T    callsite issues a dyndbg:* trace-event
+  _    enables no flags
 
   Decorator flags add to the message-prefix, in order:
   t    Include thread ID, or <intr>
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ee0cb37153ef..016f33c20251 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <trace/events/printk.h>
 
 #include <rdma/ib_verbs.h>
 
@@ -90,6 +91,7 @@ static inline const char *trim_prefix(const char *path)
 
 static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINTK, 'p' },
+	{ _DPRINTK_FLAGS_TRACE, 'T' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -858,6 +860,98 @@ static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 	return buf;
 }
 
+/*
+ * This code is heavily based on __ftrace_trace_stack().
+ *
+ * Allow 4 levels of nesting: normal, softirq, irq, NMI.
+ */
+#define DYNAMIC_TRACE_NESTING	4
+
+struct ddebug_trace_buf {
+	char buf[256];
+};
+
+struct ddebug_trace_bufs {
+	struct ddebug_trace_buf bufs[DYNAMIC_TRACE_NESTING];
+};
+
+static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
+static DEFINE_PER_CPU(int, ddebug_trace_reserve);
+
+static void ddebug_trace(const char *fmt, va_list args)
+{
+	struct ddebug_trace_buf *buf;
+	int bufidx;
+	int len;
+
+	preempt_disable_notrace();
+
+	bufidx = __this_cpu_inc_return(ddebug_trace_reserve) - 1;
+
+	if (WARN_ON_ONCE(bufidx > DYNAMIC_TRACE_NESTING))
+		goto out;
+
+	/* For the same reasons as in __ftrace_trace_stack(). */
+	barrier();
+
+	buf = this_cpu_ptr(ddebug_trace_bufs.bufs) + bufidx;
+
+	len = vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
+	trace_console(buf->buf, len);
+
+out:
+	/* As above. */
+	barrier();
+	__this_cpu_dec(ddebug_trace_reserve);
+	preempt_enable_notrace();
+}
+
+__printf(2, 3)
+static void ddebug_printk(unsigned int flags, const char *fmt, ...)
+{
+	if (flags & _DPRINTK_FLAGS_TRACE) {
+		va_list args;
+
+		va_start(args, fmt);
+		/*
+		 * All callers include the KERN_DEBUG prefix to keep the
+		 * vprintk case simple; strip it out for tracing.
+		 */
+		ddebug_trace(fmt + strlen(KERN_DEBUG), args);
+		va_end(args);
+	}
+
+	if (flags & _DPRINTK_FLAGS_PRINTK) {
+		va_list args;
+
+		va_start(args, fmt);
+		vprintk(fmt, args);
+		va_end(args);
+	}
+}
+
+__printf(3, 4)
+static void ddebug_dev_printk(unsigned int flags, const struct device *dev,
+			      const char *fmt, ...)
+{
+
+	if (flags & _DPRINTK_FLAGS_TRACE) {
+		va_list args;
+
+		va_start(args, fmt);
+		ddebug_trace(fmt, args);
+		va_end(args);
+	}
+
+	if (flags & _DPRINTK_FLAGS_PRINTK) {
+		va_list args;
+
+		va_start(args, fmt);
+		dev_vprintk_emit(LOGLEVEL_DEBUG, dev, fmt, args);
+		va_end(args);
+	}
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
@@ -872,16 +966,18 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
+	ddebug_printk(descriptor->flags, KERN_DEBUG "%s%pV",
+		      dynamic_emit_prefix(descriptor, buf), &vaf);
 
 	va_end(args);
 }
 EXPORT_SYMBOL(__dynamic_pr_debug);
 
 void __dynamic_dev_dbg(struct _ddebug *descriptor,
-		      const struct device *dev, const char *fmt, ...)
+		       const struct device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
+	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -891,16 +987,18 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
+	flags = descriptor->flags;
 
 	if (!dev) {
-		printk(KERN_DEBUG "(NULL device *): %pV", &vaf);
+		ddebug_printk(flags, KERN_DEBUG "(NULL device *): %pV",
+			      &vaf);
 	} else {
 		char buf[PREFIX_SIZE] = "";
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
-				dev_driver_string(dev), dev_name(dev),
-				&vaf);
+		ddebug_dev_printk(flags, dev, "%s%s %s: %pV",
+				  dynamic_emit_prefix(descriptor, buf),
+				  dev_driver_string(dev), dev_name(dev),
+				  &vaf);
 	}
 
 	va_end(args);
@@ -913,6 +1011,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 			  const struct net_device *dev, const char *fmt, ...)
 {
 	struct va_format vaf;
+	unsigned int flags;
 	va_list args;
 
 	BUG_ON(!descriptor);
@@ -922,22 +1021,24 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
+	flags = descriptor->flags;
 
 	if (dev && dev->dev.parent) {
 		char buf[PREFIX_SIZE] = "";
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
-				"%s%s %s %s%s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
-				dev_driver_string(dev->dev.parent),
-				dev_name(dev->dev.parent),
-				netdev_name(dev), netdev_reg_state(dev),
-				&vaf);
+		ddebug_dev_printk(flags, dev->dev.parent,
+				   "%s%s %s %s%s: %pV",
+				   dynamic_emit_prefix(descriptor, buf),
+				   dev_driver_string(dev->dev.parent),
+				   dev_name(dev->dev.parent),
+				   netdev_name(dev), netdev_reg_state(dev),
+				   &vaf);
 	} else if (dev) {
-		printk(KERN_DEBUG "%s%s: %pV", netdev_name(dev),
-		       netdev_reg_state(dev), &vaf);
+		ddebug_printk(flags, KERN_DEBUG "%s%s: %pV",
+			       netdev_name(dev), netdev_reg_state(dev), &vaf);
 	} else {
-		printk(KERN_DEBUG "(NULL net_device): %pV", &vaf);
+		ddebug_printk(flags, KERN_DEBUG "(NULL net_device): %pV",
+			       &vaf);
 	}
 
 	va_end(args);
@@ -953,26 +1054,29 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 {
 	struct va_format vaf;
 	va_list args;
+	unsigned int flags;
 
 	va_start(args, fmt);
 
 	vaf.fmt = fmt;
 	vaf.va = &args;
+	flags = descriptor->flags;
 
 	if (ibdev && ibdev->dev.parent) {
 		char buf[PREFIX_SIZE] = "";
 
-		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
-				"%s%s %s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
-				dev_driver_string(ibdev->dev.parent),
-				dev_name(ibdev->dev.parent),
-				dev_name(&ibdev->dev),
-				&vaf);
+		ddebug_dev_printk(flags, ibdev->dev.parent,
+				  "%s%s %s %s: %pV",
+				  dynamic_emit_prefix(descriptor, buf),
+				  dev_driver_string(ibdev->dev.parent),
+				  dev_name(ibdev->dev.parent),
+				  dev_name(&ibdev->dev),
+				  &vaf);
 	} else if (ibdev) {
-		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
+		ddebug_printk(flags, KERN_DEBUG "%s: %pV",
+			      dev_name(&ibdev->dev), &vaf);
 	} else {
-		printk(KERN_DEBUG "(NULL ib_device): %pV", &vaf);
+		ddebug_printk(flags, KERN_DEBUG "(NULL ip_device): %pV", &vaf);
 	}
 
 	va_end(args);
-- 
2.43.0.rc2.451.g8631bc7472-goog

