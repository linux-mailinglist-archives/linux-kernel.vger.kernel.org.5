Return-Path: <linux-kernel+bounces-60608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7C850771
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6836B288520
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB66311C;
	Sat, 10 Feb 2024 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQ8n6kz2"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAF629FE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609074; cv=none; b=lKYeTybRPl8uPV3tkgKJagWo2q9Bh7PcNqRa/GQLlnVXXPfmU7lS2ZkreULrYk6y0SQz2ZczGVEdDn/+Dws+2RaZXRyv+lA0HqS01VmZJAa2WkqDOLUCSVGJbYyrvpLmYg2QausLHhXKmHLB2NPDPw+vncx8Wj5X4uXKZwCiO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609074; c=relaxed/simple;
	bh=32mpD1IVHOqTValUWgcEdGTVskgsJqtMGFjqMVc4u/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otLgBgS/7AM0XZS/sQeeRFtwKnhzhuyljk6s/JwCEZXXP48sx9VVsJPmD25IROTTGJhz5OOlPk+WxiJpn21YblvZFLZMKq+iXs8nzuzuskkrFo3x1hjlpfE7seyC01dh6y2AzfuwratnO8JOV570ZfX2qUZcgFWVPXSWzhDCUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oQ8n6kz2; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116b017503so2861773e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609071; x=1708213871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmhUVgCdk+qI3t9KK3oQMBouh6tU/rMtsVjdtdgFFTw=;
        b=oQ8n6kz2hTq9NAxDYpVXRBqEkqp4V4B4wkx7uxBqJOpyG7sgp+0+iDmCeejgUKwPQT
         OpRtM0D1V5qZlUGQDE+gZHrNazE8EpILKn7m+Idg39GJVGm/Atz7VGdduVGnaIgpPQyp
         QTlEw3jS1R+hcC9pf+Kn594lGqwio/amWW1pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609071; x=1708213871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmhUVgCdk+qI3t9KK3oQMBouh6tU/rMtsVjdtdgFFTw=;
        b=ZGwvbPPrb69FiNc4xgoqfpAzfrpqxFmG6yTeXLSpMM7Emam4dJZogUM1TiiBNN23D5
         1EfqLfLsWaTVa/OFccNfzJXiqjwO4vj5Tf3OkzZFXGAGMoCHCcbSH4ErxnFxb67pwfjS
         FTYXKOhESWnIV/svBbMDBqzb87eem9t1quV0HPqfh5uO3XtbzqbLQywtwByHBK9UQEss
         Gbth3I+Rs7ZZBcO+5pu3koqLIu3D/Z5UA69BV5zINwZVe2NTVcNTklXUfHattrXxVmEe
         e0xUNwa8uA7nOT0oT/Y34KjMCIzlyoHX43Bkw1dUFI4GVnaFSN3fnWYA/SiN+PHzrFAa
         a+wA==
X-Gm-Message-State: AOJu0YxoIrPCQ0a9fSinVIind8mTJy+/CiYOAJwmeleiAB6VOS7yU2mY
	m/9KVlq4J2XVJ8mVB0qLgAEeaC1WvWAlRXmycz4DoFBnYfEMcq3Mm3ZnHSY2
X-Google-Smtp-Source: AGHT+IFfGsK469pNloItUpLlNufIHL3CU7AZi3WunjJCeX7uNh0/b57qgGAG3Xb36wnXuRyAYbMoEA==
X-Received: by 2002:a19:e002:0:b0:511:5a9c:c9c9 with SMTP id x2-20020a19e002000000b005115a9cc9c9mr1917171lfg.16.1707609071329;
        Sat, 10 Feb 2024 15:51:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFk5okXDi1WEVQdBUJMHlW02yUykfeDQpGNrpbCjqT8LDj1fDrB3RNq76mvm7/DbhbCY1KYUPMD6sXwodtifxb4LEHnndRSiV9Mn1iEZKPuc+RWiOBA6ioX9zBjQJgdrAZ73EuzuEiw4G1Wps9nSIiLmTdrExBGNxaPGPyhF/+slIe4VHb6kgnGIH863+82tiPGvi9ZNuV8b90kv4aMdrIMlQ6joe86hzIJr+Y9bXI2KC564pm7+kXOS906CsDcp/j8b8mIl6Dd9Fvjv1xhp2gpDOg7C1wIDnnyg6c03RRwjAMm3U9zHMvt3rudq3FuSSboWDe/hEme0Z5IXKDawdEFQvvaN1j/rRQKpfCqdWtCOW/Cumzk0uWXLJAUY3xutTfmLod+GIqDd8HSfFb94+vUIretMnLXDLSyS7G9i7bGuhliBRCdi1qFvLa/bn5cMjtLiqDCDnjRjB6zHvuzliqsKEHOxm8V07uUExQO29F2UUVkQOccrSzdDL3xWXpnd1qVsCCk1yt9O31HQmUixw0LLB+W8daokmECaMc3sUsyZsJo6eA0ss5Pfh81/4Ax0ZMwpJueD1RazBtaVPBDMugkJOvIVEVpnzbCrPOb4Ub85Iucw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:11 -0800 (PST)
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
Subject: [PATCH v4 25/39] dyndbg: don't process queries when trace cmd fails
Date: Sun, 11 Feb 2024 00:49:55 +0100
Message-ID: <20240210235009.2405808-26-ukaszb@chromium.org>
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

When trace open or close command fails then stop processing next
queries in multiquery string. The rationale behing this behavior
is to stop processing queries which might be dependent on success
of open/close trace commands.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3d0c6b5faa31..d8cd40faeb4d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -939,7 +939,8 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 	return 0;
 }
 
-static int ddebug_exec_query(char *query_string, const char *modname)
+static int ddebug_exec_query(char *query_string, const char *modname,
+			     bool *is_trace_cmd)
 {
 	struct flag_settings modifiers = { .trace_dst = DST_NOT_SET };
 	struct ddebug_query query = {};
@@ -954,7 +955,8 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	}
 
 	/* check for open, close commands */
-	if (is_dd_trace_cmd(words[0]))
+	*is_trace_cmd = is_dd_trace_cmd(words[0]);
+	if (*is_trace_cmd)
 		return ddebug_parse_cmd(words, nwords-1);
 
 	if (ddebug_parse_query(words, nwords-1, &query, modname)) {
@@ -991,16 +993,19 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 	return -EINVAL;
 }
 
-/* handle multiple queries in query string, continue on error, return
-   last error or number of matching callsites.  Module name is either
-   in param (for boot arg) or perhaps in query string.
-*/
+/* handle multiple queries in query string, continue on error with
+ * exception of open and close commands, return last error or number
+ * of matching callsites.  Module name is either in param (for boot arg)
+ * or perhaps in query string.
+ */
 static int ddebug_exec_queries(char *query, const char *modname)
 {
 	char *split;
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
+		bool is_trace_cmd = false;
+
 		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
@@ -1011,10 +1016,16 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 		vpr_info("query %d: \"%s\" mod:%s\n", i, query, modname ?: "*");
 
-		rc = ddebug_exec_query(query, modname);
+		rc = ddebug_exec_query(query, modname, &is_trace_cmd);
 		if (rc < 0) {
 			errs++;
 			exitcode = rc;
+			/*
+			 * if open or close command failed then
+			 * do not continue with next queries
+			 */
+			if (is_trace_cmd)
+				break;
 		} else {
 			nfound += rc;
 		}
-- 
2.43.0.687.g38aa6559b0-goog


