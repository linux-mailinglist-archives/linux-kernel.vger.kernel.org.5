Return-Path: <linux-kernel+bounces-60599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29467850768
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF03B283B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7B6166E;
	Sat, 10 Feb 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Maz/Aw+f"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DC60EFF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609059; cv=none; b=C4lw047jrvxR/1qAiBdFo8S8e8mIXLBW691IVrduJiMe31BndE8VB00KrMfExH8adcsR2UgFarwNtTGm9mOpWto2v4AFn3D6Zthp2F2DfdY5u55xRPEkxkx5S1evMDhWqXN7AnY3JYyIKnJhJvV/SA8wMdNoEXR+ap07Krg1DnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609059; c=relaxed/simple;
	bh=l1V9QLXGLN9N14rao8E4GzprXYURIUrk6mdW5/cLkEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyOLM2rqH1TJQw5k+uCirWZNRO9727oghulxwT6GyJWGeTTaBcrp8fTkE13afppxw6x+c2AWMiUIe08n6fUZI9IkyJx1qd3OiCS2RnbUCzo3NAjrJX76omtQH+58veKrF7y+Vx09RxHQ4q8lP4QAhB0r98886cGJFDfDEjnEFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Maz/Aw+f; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51032058f17so2603074e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609056; x=1708213856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+meeM2Vk6l0WdNE3+wNvpjDW7+uOCSnCzAIE4DVZl4I=;
        b=Maz/Aw+f+MtIWMO3kXDK86OaiWrIskcdmUC4785M7ShoVh3YeuZ1I+V0XpDcxDAoc4
         GV7lx6xZV3fwC9i0/CUkpzc567m6INWWTp8gjHgd9BHcWbDxmccrSFnmt0xpPiw+7f7I
         whMbbAaaf0h8Qt8oVwstoROutq9aCnw75wXDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609056; x=1708213856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+meeM2Vk6l0WdNE3+wNvpjDW7+uOCSnCzAIE4DVZl4I=;
        b=Ncg2XPxwVLR7WUFKiXazOHs2XUBcpqM24ia4XzxWNjeRG80Y1fA1AZm4ns4FZ9nsbq
         OIFi3/EfDNmlVy9jC6wvhOMYhXG4HnbZr8jkFyaIXA3+6Pvdhg1A8mCujrmrIfHGfBuH
         04R8yDfJubZANpdr3afSwAF6erbaVZ6NmydxAufW57mVE8c5v5Q7WsrgH+qTwz8cucDc
         0+FERDJ80h2zwc8IZ4NighDG+PsQkBXpUHFgFiu5J5x05HNaoYNY0CrcaAI3pnTWHcVw
         b1E2jqprlQZqCmdNcHrPsinCVl55sxYCtqkwurY6DUGh/rtyR5ANMzwPDpv0fgGTkhlJ
         SsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwOhkOR37sqTL33iKXpBpBYi2yaSX1IdJ2QCANXzmrG11FwJkFM79Hn5RaHWieVnPsSlIm8i2CDwBFj7EmmEL25SyIOYDGjnq8cHql
X-Gm-Message-State: AOJu0YyKp6dHFPl52CssX0WlN/LORfbW3I8TsPlj2mP3Z6EAvRhSgQJY
	1A7i4aflyTZTNAQQl8FaKP8DMec4RY3+18R2sRaooeivYv2xPErscPwasZIX
X-Google-Smtp-Source: AGHT+IEVsQfE3/Ku8GY9wEARJtHvcLpqA0MyX9lVuCivqKATZYpTxbqjcywYxg7HE9xUPgdJOSqYxQ==
X-Received: by 2002:a19:2d47:0:b0:511:49f8:b42f with SMTP id t7-20020a192d47000000b0051149f8b42fmr2044506lft.8.1707609055904;
        Sat, 10 Feb 2024 15:50:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWzrYynI29zRZZDkdrYySf/qdUsSiTQf0Ck0ApIde4uN+FCjcPut2uLF3xYRFs+ELUnxwYHdYIGi416Vdua3k0Ang9Rm43hnz+3INTmLm8vt6zzQEbYliq4yyxib6UA/MhQrC+JdRDVVSI0x8KY53x0inOi4frTEz0gusZuefCd1zk2bSxsWDJH1xWbd5Fu/hs/p31kzf5Er82S7O4HNPcFGqUbXrpbeR12TxEvmiS6v7vSkYuYj1xOJX1rbWg/Mn+vzv9Z1fQfPIujUjkFdsUS1HpJ3tG1whBCAsPO9p6AsO4nW6bC/alYxI+Sy860j61y9czCyCL07H2etcmaZcDX0ZoLmjiW/0WR8pjJds8hIm/lAD+vMbAUmzvKdYzO7+Pj9A//WhNbz33cWHxpwXk5Mqs/uhGObCYxQsaw/SqtKEovYJl6wd7/eAu3FGznt5Hi5eLkM27/g7ITHwAGDdsgu1fw21CG9VfQ27ul2u7ajQoS/5j/oWghvBMszYJGLZEj0PEu7/d06hCOuIscCdzcBDgeTrdKmFHzL6BfuJ2fAXTnE3a0w/OfHmcTE6uKM5HLT91dqxcVaTBMjDuZaw82o1kUUDKd2OsMkjZxeAW1gNxTg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:55 -0800 (PST)
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
Subject: [PATCH v4 16/39] dyndbg: write debug logs to trace instance
Date: Sun, 11 Feb 2024 00:49:46 +0100
Message-ID: <20240210235009.2405808-17-ukaszb@chromium.org>
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

When trace is enabled (T flag is set) and trace destination
field value is in range [1..63] (value 0 is reserved for
writing debug logs to trace prdbg and devdbg events) then
debug logs will be written to trace instance whose name is
stored in buf[trace destination].name, e.g. when trace
destination value is 2 and buf[2].name is set to tbt then
debug logs will be written to <debugfs>/tracing/instances/tbt.

Before using trace instance as a destination for writing debug
logs it has to be explicitly opened with open command.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 172497954e00..d379e05837be 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1278,8 +1278,8 @@ static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
 static DEFINE_PER_CPU(int, ddebug_trace_reserve);
 
 __printf(3, 0)
-static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
-			 const char *fmt, va_list args)
+static void ddebug_trace_event(struct _ddebug *desc, const struct device *dev,
+			       const char *fmt, va_list args)
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
@@ -1310,6 +1310,18 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 	preempt_enable_notrace();
 }
 
+__printf(2, 0)
+static void ddebug_trace_instance(struct _ddebug *desc, const char *fmt,
+				  va_list * args)
+{
+	struct va_format vaf = { .fmt = fmt, .va = args};
+	struct trace_array *arr = trc_tbl.buf[get_trace_dst(desc)].arr;
+
+	WARN_ON_ONCE(!arr);
+
+	trace_array_printk(arr, 0, "%pV", &vaf);
+}
+
 __printf(2, 3)
 static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
@@ -1322,7 +1334,12 @@ static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 		 * All callers include the KERN_DEBUG prefix to keep the
 		 * vprintk case simple; strip it out for tracing.
 		 */
-		ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
+		if (!get_trace_dst(desc))
+			ddebug_trace_event(desc, NULL,
+					   fmt + strlen(KERN_DEBUG), args);
+		else
+			ddebug_trace_instance(desc, fmt + strlen(KERN_DEBUG),
+					      &args);
 		va_end(args);
 	}
 
@@ -1344,7 +1361,10 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 		va_list args;
 
 		va_start(args, fmt);
-		ddebug_trace(desc, dev, fmt, args);
+		if (!get_trace_dst(desc))
+			ddebug_trace_event(desc, dev, fmt, args);
+		else
+			ddebug_trace_instance(desc, fmt, &args);
 		va_end(args);
 	}
 
-- 
2.43.0.687.g38aa6559b0-goog


