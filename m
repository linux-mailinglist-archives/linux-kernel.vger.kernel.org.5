Return-Path: <linux-kernel+bounces-60589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A9C85075E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA0D2838E3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC44A605C5;
	Sat, 10 Feb 2024 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bsh7dshm"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A2604CF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609043; cv=none; b=GdjCXyRoaRb1vGoIiPqtvVihtX7rjgelrwmCCU9d0+cvQFmA7ytUDy/nN4ShY43L0jcrR2h/NmHtIvQSpiwf2ipKGOIDmGQWLnghiVm7MbnOimZaQ6g5GxD4zjjFMA9eHW734tVdqkxhVWa8Xu4erb16NWF0d4rS+wYYV736IeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609043; c=relaxed/simple;
	bh=bAccrTv3hmSTu7zPzthT8nvQoJH35PHedf4O6GRUW3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSMDGoadZs8delhvMPz/avxJa38vUERmdewpEqiKDMdBahB158CZ4wPh9i1/kUSI0fKdRmIWki0SRb/Nh0XWhjewaR2tiebNyI2MBviDRjh3p8BHke6a7dVadhty6m/hJiHPCQYnaDZ0vu4jOMufF6YNm6h29sZ7k+otC1bzSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bsh7dshm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so2506813e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609039; x=1708213839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x00D6P9yOyMiqD2q0GliLWT+bL7NY08ZLZWAqgBxEXY=;
        b=bsh7dshm4K0Nbe5N2eBL91tg68F66TZi0f/LIzUQjQN5r8FOXqtqnm2hz4MzO3u7V8
         PQncXmd2Po1xZkTYiMqsq4/4HoNtz64ufAV91DQdC7xJN2+m3e3ijcpYcDirjEK67Jw4
         AfMBofNWutpT103dFQ+LJ0dHpKpPWn0RiBgW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609039; x=1708213839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x00D6P9yOyMiqD2q0GliLWT+bL7NY08ZLZWAqgBxEXY=;
        b=rU2hhRjo24R8wjI4pguTQpq4g+RaGpzLOlwKKzI1ZqsJH7t/31qiyt0dQlYoDP5ZdH
         BEfjEeQXug+VyLf6p2OxTPjEB5aq20U2hBCuTeBvM0Tcg9doHQYQz3ElycJwb9jV1ELV
         4aJjbGwZ1RmEBbBElIm9nxiFj1FkGKTGjEoLQVUF0+COGaRSg/wIPMnps8dUxt7NRdj4
         ShH+RBT5DHRvwkVrV1aUM4LVoprrbZX+yOc2xlT+2uWsUMnviFUGURd5MInSCmorcXcH
         8446eKJ22jw5v0iY39Mz8KTsWEl+aap6osHBM/PMQbXASX8bIQ/lNi4ZlkEHIQtFljcn
         wNQw==
X-Forwarded-Encrypted: i=1; AJvYcCWdTQW3atXGBD6j0BFfO7FVR0Zp+jru1DODSEJ7QqSDQww0wQhwWiGezjVicOb7pXLI69gxurJ2aZatIQt/rhuO0TTWdQ70Hl9Aio13
X-Gm-Message-State: AOJu0Yw9aBUEnvE6+cWZwEe8BmLLD3BQ5JHIzxW47G+Ysw32aTz5uDQp
	vvCpu6DCSyiUcRkMbsAhJ9jJnCkQphEe+xIX9QcfziXcXK7Z+rOribIgvR56
X-Google-Smtp-Source: AGHT+IEEmXCDAjJbk/WivEbLO+m1UD2apM3Sq8YB0Oy4T8mG/wcSYTZz9sVE3xQqv4zU00HzYNaMYw==
X-Received: by 2002:a05:6512:31d4:b0:510:ee2c:e9c4 with SMTP id j20-20020a05651231d400b00510ee2ce9c4mr2815993lfe.17.1707609039442;
        Sat, 10 Feb 2024 15:50:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7ySymF3+AZV/6j1K9+VJqK5qT7OPdyNN28fJe2JQqW3xVM2SBYur4wQol+rUwrbeum1oQKxJE2gW7XvXM4MagBlhPedO9CFSwpcSYyFs7LPcPLIxgCe0KpYo234EU1Is2CVFVPkWWkUMYMj/A2MR+etJNsp9MBoXIT7cIs1xYIwJY/Ovxgb/0YVWn9QmJG1iUGqNecxny1WI9D4kxIgNfpIEZ9aeT8SSWYUrj5NrD2yAh6m9U1kIVuhEnZ1IVk/hR5my+nmOe3sVestZnkkup5wU/gZvWFEylKK/FALNsvUtjdiqJc4m+rGadQZ3kivXiDFiXPf1mJWaoNR1AaYWtzMvCOYOYsVDr3JeKFIjzfUSeNURPieCatlRwgbAJQuG6ampB4tYgnwwf1pYtW5s+GyGiC//jfNPXE3RFc4md5VUSuG0VEauzE5/+pCIafiAnhaTKJF1QQtzyKgTHSQPHy00nWD4mKdj055Mq5GWL7sHRLvMRJfRQkf3z6yRoCBAGGdHomteoQ/yY2gcaHqugcMgnTB2Dx+LxDfdZRDTzzxXXxq1rmbADKpATKYjOfHga1gUxQx2qEeZEG32hYsrp91dKbOkW2peqBd/Z3T7buu4Sbg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:39 -0800 (PST)
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
Subject: [PATCH v4 06/39] dyndbg: use __get_str_strip_nl in prdbg and devdbg
Date: Sun, 11 Feb 2024 00:49:36 +0100
Message-ID: <20240210235009.2405808-7-ukaszb@chromium.org>
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
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
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
2.43.0.687.g38aa6559b0-goog


