Return-Path: <linux-kernel+bounces-10181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5A81D112
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FB01F25731
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC428DDF;
	Sat, 23 Dec 2023 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="EfVLT8Nn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCBA28373
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367903b4dcso2241473f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296344; x=1703901144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haas6K2PixyGojAx+SMW1ogMp52EfdW6LDnozcXO/gU=;
        b=EfVLT8NnQA7fDMyLNkGmHsagtx0rp9+y4W7sBYPsUV4lzpc/kBP+308CWNafSnJ1hA
         Bpz4/vv8bUeZvcsszNa4fwdTcc9mX0tvMLxzoQx1+6Gaz2ip0Kf7BtOanpehcdb/kJ4X
         fzwbdvGtYQHEoWEh0UR9DDY6k5tPKhdJWoKWKNKQiiVMpoGHhMdV+gmB8PYIz/xwU7I4
         LGyR1dJorxdCgFH3wtZD34i5+8IBXCK5/S9v09QhmwuQnFC7ZnlqhXDyj2VXRuvpZOa8
         eu9bUgPkJpmCy7wxPuxj57z/HSCGZqlxNZfQRet9au3SgSsthzY1o6BW7hdTuc9DyYgU
         RAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296344; x=1703901144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haas6K2PixyGojAx+SMW1ogMp52EfdW6LDnozcXO/gU=;
        b=bDnXhNCLxaDObw2vZHVnq/dFALmB7i+aY+N4DeCFcJNFIMC28xdZGP/e3LEuVgx3d+
         VN2PfPwrkid+HNnr7nYJAGnuJimUSD0FbIr1BWC8oZeshY4Sheh1+jhvT1X2bWM9wf02
         UYtw3TtYeEVTgTDoJW5RxXAPwdSBcrun1nfUfMKKcxYNHiZ2XyCQUrGIlXNbqSIOUPwH
         GafVbhkBnF3CD/mP+BUNost+AAsP6qnAsQtohmrKFOtN2PfydYwrwpOrmY9v055glddD
         hBM/5q0IsqBGhQvPL9pUaIJLhM34r3CDN/HgXz8RBw8PkBHZ8ethwZ3N8BR7GyhFYynv
         nAGA==
X-Gm-Message-State: AOJu0YyL14p860DRM0NjFIvopQwCtqfonukSP83dqKmKsxUlJ82B96BJ
	bv856fznazgske9V2V0Y2KcfEYACZxyt
X-Google-Smtp-Source: AGHT+IEBQjK7TsN/s/MUMixJ1GlVKv5pQcUpT7JeuZgG2xSKTke5vGv5SoOZLBOkkOFw8VAxrarVbA==
X-Received: by 2002:a5d:58e7:0:b0:336:6d04:58b2 with SMTP id f7-20020a5d58e7000000b003366d0458b2mr1215273wrd.89.1703296344701;
        Fri, 22 Dec 2023 17:52:24 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:24 -0800 (PST)
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
Subject: [PATCH v3 21/22] dyndbg: reduce verbose/debug clutter
Date: Sat, 23 Dec 2023 02:51:30 +0100
Message-ID: <20231223015131.2836090-22-lb@semihalf.com>
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

currently, for verbose=3, these are logged for each query

 dyndbg: query 0: <class DRM_UT_CORE +p> mod: <*>
 dyndbg: split into words: "class" "DRM_UT_CORE" "+p"
 dyndbg: op='+'
 dyndbg: flags=0x1
 dyndbg: *flagsp=0x1 *maskp=0xffffffff
 dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: no matches for query
 dyndbg: no-match: func="" file="" module="" format="" lineno=0-0 class=...
 dyndbg: processed 1 queries, with 0 matches, 0 errs

That is excessive, so this patch shrinks it to 4 lines:

 dyndbg: query 0: <class D2_CORE +T:foo > on module: <*>
 dyndbg: split into words: "class" "D2_CORE" "+T:foo"
 dyndbg: op='+' flags=0x40 maskp=0xffffffff trace_dest=0x0
 dyndbg: applied: func="" file="" module="" format="" lineno=0-0 class=...

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 453eab7092dc..4718e8faa719 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -835,7 +835,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		 */
 		query->module = modname;
 
-	vpr_info_dq(query, "parsed");
 	return 0;
 }
 
@@ -860,7 +859,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -880,7 +878,6 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x, trace_dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -896,7 +893,8 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("op='%c' flags=0x%x maskp=0x%x trace_dest=0x%x\n",
+		  op, modifiers->flags, modifiers->mask, modifiers->trace_dst);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


