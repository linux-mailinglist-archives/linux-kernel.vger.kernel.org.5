Return-Path: <linux-kernel+bounces-10176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2783381D10D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E11C22532
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA41C6B0;
	Sat, 23 Dec 2023 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="eYIHZuK9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AA914F6F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so4165410a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296337; x=1703901137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVR31l7ssYBc2uqfncVW1jfnriW+pqUwixAY72YDu48=;
        b=eYIHZuK93oRaumjAVjIPWlgGSgMCVkmxLW7mBNcwneImcuN230ZPegGYi9eTEFS6NT
         tjUXKn8UnRow/NR9BT1xSjAG8lftWhA3YIstrIBnpM9+WJJWNAo4H/kEzIAfQ1yPlK1S
         OwTrcLRnUWQTZwVBXXleEcqXXq0Lpz2ZT1zqED/nitymDb2UgdYcUB7lXZMcM0ZjLfQT
         G0ld9JqW6y5GIgst/L2379z9HqjvdaKE3oHvuFvn1XNlQdUnd/QOEmNlLP7Ri0P4ZFVy
         isDu5x0/tW6sEl9Q0ydQQNN2Yfs0SnUely5JeRZqweZNzDTMZriAPAIJyMifPzc8tzGX
         l9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296337; x=1703901137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVR31l7ssYBc2uqfncVW1jfnriW+pqUwixAY72YDu48=;
        b=djhKcjq3j3fSmOMuHlE4gVoKIMmu3YOL8Jx07XcJ1o0LHxBAuT5zacdckpv7qFdK/I
         Eqn6IkD7ptWDfTfCFWbMgp7ColAV5M5N6yIXufz2OPWz9ME+OZxNB/XpdoHHZMvf3NdP
         bh+yFIQrCEzeWUBW35h3joGQtPer0P/Mn7siBXW9QVxH8nSw9uWK4uVmofHudK9biMNr
         DHQVQTFgVW3BknK0P7RLoSUT3ZWu7cuh4oSIoIjH6cevy22QzxLPZu/4F7zOsBKJiQxn
         JQT1v/M0M9kqQR+1gwBeFXViS5SioyrCKk49sWVLyqPYn32xlwygcMLyepb+3YY3nyJp
         7jkg==
X-Gm-Message-State: AOJu0Yywdt0NsqubYaBlpIdJ/XnZi9pTRoXlZ7OTtq79N8Dui6OYDwnD
	CT5LthQnu4qC34HRQrFuvpWRjEhiPxTM
X-Google-Smtp-Source: AGHT+IGKQ8NjMm0KKd/qWNRze/qoSNsJBR0VLgXS0eLuqlpgb7oNSxgOjC5MsMHMuHIzjNtn5uSXxA==
X-Received: by 2002:a50:9313:0:b0:554:4bb2:9a6e with SMTP id m19-20020a509313000000b005544bb29a6emr2531314eda.11.1703296337057;
        Fri, 22 Dec 2023 17:52:17 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:16 -0800 (PST)
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
Subject: [PATCH v3 16/22] dyndbg: disambiguate quoting in a debug msg
Date: Sat, 23 Dec 2023 02:51:25 +0100
Message-ID: <20231223015131.2836090-17-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231223015131.2836090-1-lb@semihalf.com>
References: <20231223015131.2836090-1-lb@semihalf.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

When debugging a query parsing error, the debug message wraps the
query in escaped-double-quotes.  This is confusing when mixed with any
quoted args where quotes are stripped by the shell.

So this replaces the \"%s\" with <%s> in the format string, allowing a
user to see how the shell strips quotes:

lx]# echo  module "foo" format ,_ -f > /proc/dynamic_debug/control
[  716.037430] dyndbg: read 26 bytes from userspace
[  716.037966] dyndbg: query 0: <module foo format ,_ -f> on module: <*>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 65dafdec7b76..8ce485fc84ff 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -955,7 +955,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (!query || !*query || *query == '#')
 			continue;
 
-		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
+		vpr_info("query %d: <%s> on module: <%s>\n", i, query, modname ?: "*");
 
 		rc = ddebug_exec_query(query, modname);
 		if (rc < 0) {
-- 
2.43.0.472.g3155946c3a-goog


