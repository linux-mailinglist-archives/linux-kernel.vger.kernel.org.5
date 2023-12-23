Return-Path: <linux-kernel+bounces-10166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE02D81D102
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E115E1C2192B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D49AD56;
	Sat, 23 Dec 2023 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="qtbaEdGp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAB6FAF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so4189693a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296319; x=1703901119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+qDtAuuE/Ai6yWJXrInbQAWXp9jwgctR3BIRp6oMQI=;
        b=qtbaEdGpD6elFnc8Y48FY7EjI+NZ1cDUmmUwg9YZs9URT2HlVHBM1V1YR/NGgIlhpl
         CKNROZEJkyqXqLrFVaipWJZE2WhJEp+jLdNcU31vSib5nKYUy2iIDn42SmpEfTPPojvL
         shGRE3U5lPUyof9Dob5nyuqp9qrRgeRtKG5bfsZxmMG+LSZE/ltj+tDjpyg3kMrCg2Qa
         9XVZ8d8bywIrOKbATtfNy7h9amgLJZu1jkF3zo3EBouJKP5YEKRL0Gv4vG+y8UkoKSmb
         7uYoxjltha6/TQpjxkVQ9pCHW3bBoCzMxA6A05RleTITyStHkKrcutcKgdlUVMDjjaJB
         hwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296319; x=1703901119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+qDtAuuE/Ai6yWJXrInbQAWXp9jwgctR3BIRp6oMQI=;
        b=NAABxvQryIDyRZuyKLmXRY86xxUJIXrZhRJTgKeaq/1EK+xnucXg+1TRBxv1yjLLhf
         +fSuNjtGjnBgtBNaH3uLtAnavib7A8ujTfjErDijlT8AsipYJ9e/CSvMZbqeWdO9U64V
         8HbNYh4nl86bKLDAZNYj28bIgvrds5abgYxR5PoHOzoUFghfXqywzfAemeTCQQIkaIyy
         qDQb9FHZ+SWtOt24NUfp1l0aFN0F5Bf4k5hu+9RaE3HMLSKnb97oezuzQefBQg2z/Inw
         ngazNxdPVy3fjeBrIdjjo1StIS9MUUxOIPu0e8txcPD9jsRc8N5JTpOIkmft/i0pwcli
         eabg==
X-Gm-Message-State: AOJu0YyN4cW6v0QxJEHNhzCOX/Ib1ua+7OyjH1evnBA2/+xKmu02/VmD
	vrAv6W5fchbB03iWLQQo7mZNBSmu+za+
X-Google-Smtp-Source: AGHT+IE8MxD/3G8xipyOK61By3+qkgYrIaFla4GWRo33W+Upth8c1iox1UyiLQ/UF8K3QN6CJtjN/g==
X-Received: by 2002:a50:9e0e:0:b0:554:32ec:eada with SMTP id z14-20020a509e0e000000b0055432eceadamr2007852ede.18.1703296319025;
        Fri, 22 Dec 2023 17:51:59 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:51:58 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
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
Subject: [PATCH v3 06/22] dyndbg: use __get_str_strip_nl in prdbg and devdbg
Date: Sat, 23 Dec 2023 02:51:15 +0100
Message-ID: <20231223015131.2836090-7-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231223015131.2836090-1-lb@semihalf.com>
References: <20231223015131.2836090-1-lb@semihalf.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

Recently added dyndbg events: prdbg, devdbg have code to strip the
trailing newline, if it's there.  Instead of removing the newline
in TP_fast_assign use __get_str_strip_nl macro in TP_printk. Advantage
of such an approach is that the removal is done on the read side (slow
path). The change removes also passing of debug message length to prdbg
and devdbg events.

This use is slightly premature/overkill, since some pr_debugs do not
have the expected trailing newline.  While those lacks are arguably
bugs, this doesn't fix them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/trace/events/dyndbg.h | 27 +++++++++------------------
 lib/dynamic_debug.c           |  7 +++----
 2 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/trace/events/dyndbg.h b/include/trace/events/dyndbg.h
index 647c30206a7d..ffd21480cd9d 100644
--- a/include/trace/events/dyndbg.h
+++ b/include/trace/events/dyndbg.h
@@ -15,46 +15,37 @@
 DECLARE_EVENT_CLASS(dyndbg_template,
 
 	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
-		 const char *msg, size_t len),
+		 const char *msg),
 
-	TP_ARGS(desc, dev, msg, len),
+	TP_ARGS(desc, dev, msg),
 
 	TP_STRUCT__entry(
-		__dynamic_array(char, s, len+1)
+		__string(s, msg)
 	    ),
 
 	TP_fast_assign(
-		/*
-		 * Each trace entry is printed in a new line.
-		 * If the msg finishes with '\n', cut it off
-		 * to avoid blank lines in the trace.
-		 */
-		if (len > 0 && (msg[len-1] == '\n'))
-			len -= 1;
-
-		memcpy(__get_str(s), msg, len);
-		__get_str(s)[len] = 0;
+		__assign_str(s, msg);
 	    ),
 
-	TP_printk("%s", __get_str(s))
+	TP_printk("%s", __get_str_strip_nl(s))
 );
 
 /* captures pr_debug() callsites */
 DEFINE_EVENT(dyndbg_template, prdbg,
 
 	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
-		 const char *msg, size_t len),
+		 const char *msg),
 
-	TP_ARGS(desc, dev, msg, len)
+	TP_ARGS(desc, dev, msg)
 );
 
 /* captures dev_dbg() callsites */
 DEFINE_EVENT(dyndbg_template, devdbg,
 
 	TP_PROTO(const struct _ddebug *desc, const struct device *dev,
-		 const char *msg, size_t len),
+		 const char *msg),
 
-	TP_ARGS(desc, dev, msg, len)
+	TP_ARGS(desc, dev, msg)
 );
 
 #endif /* _TRACE_DYNDBG_H */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fcc7c5631b53..9682277f3909 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -886,7 +886,6 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
-	int len;
 
 	preempt_disable_notrace();
 
@@ -900,12 +899,12 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 
 	buf = this_cpu_ptr(ddebug_trace_bufs.bufs) + bufidx;
 
-	len = vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
+	vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
 
 	if (!dev)
-		trace_prdbg(desc, NULL, buf->buf, len);
+		trace_prdbg(desc, NULL, buf->buf);
 	else
-		trace_devdbg(desc, dev, buf->buf, len);
+		trace_devdbg(desc, dev, buf->buf);
 
 out:
 	/* As above. */
-- 
2.43.0.472.g3155946c3a-goog


