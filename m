Return-Path: <linux-kernel+bounces-60601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553BB85076A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C311C21A66
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF796214E;
	Sat, 10 Feb 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hPubffDm"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ABE61677
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609062; cv=none; b=TCK7+f9K0Dm+LOdtiLZCOsDAhgShbPNsVYhvEUKixMlyRYGGfBBXe4HoyZ1RxlaUls8hk2IvrNeB+itCB1Z1CtR2CaAIy566bzsDc+AjZ2jTuDA9kVE/2QzGi3QkbFpKiSRGo24VzvNpNUI87ulYskd/M23LHdhhGSEJRd0JKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609062; c=relaxed/simple;
	bh=38I58GgEEuvwOX95RJ1mNCPWP76DGHxflbVS5gA9xhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2EgzlBaGIB2x8/rxyCqtiKF+GwLh/vTqg9xABkkzQQUpUMT65eLGHfpmplhXm8SVLEMAQBzldaDcT5HENdqvuMEJqakMwa6J5/HTnmF9Re1VzLS42VsRgHxDSwnBO0t5dOR1XQHOBTbG4gbvkln73qgjeLJil0w7SoqQs6R7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hPubffDm; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-51147d0abd1so2384578e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609059; x=1708213859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2CTMmybaxg0dOtHmB7rXgRA/borZ7XgGMz9viO7lBc=;
        b=hPubffDmJ5Odq8LPxPhhzmcqxd7gcGlAA3EL1sgmsRpLQy8QwmA2WR4RpiPsLNcFWb
         6Ea2XIvEaidlKXXcjkFnCdNYoeoaG2XBiyaBJz0yWGIe3lz5HrMnlbMobLZAWof8g0ay
         qYUKNizCYiPnQin+YVat1IKJEWqfZ5/FU5qU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609059; x=1708213859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2CTMmybaxg0dOtHmB7rXgRA/borZ7XgGMz9viO7lBc=;
        b=dXyZx5xzXgiAgaYOU81QqZlTd2vCu+LGfomY33SqDss8W2wiYqTA8uF5JtAaoKABjq
         uz2Jy//fpOuFOAPGAEI7ojXFMBgXmwe3EzqEE8zfdLCM71zAJRTBulAolk610vsmFVUX
         kMTw2PFH8NRK96/drFKRT/v4wMcRbJn9ITTc/ix7svehBWmsDY8ptp9mHOuMtFJ8B8G0
         p7NlyYgXjSGDU6DHsuDBK2hS/pjK1v9U9jY7V3A+bFoGH09X5I4IgyAj0NAmJ1ddz56u
         HBJVNd0scvCsvR3Olys8QBwG2QPih8DN6zlZv8yXxOU16O36PQzyIddWm9GuTo5PWtVG
         AhSg==
X-Gm-Message-State: AOJu0YyENLuw6IyCZtXToHBsLtka/3ZhCil/CufECHpAKq5SwcSdvsQT
	cEZ9sdB7F4wPQVkTAqDcLTmHdz+qiON0OHdPWS/HlcWFcez7OS6zdSovBVbG
X-Google-Smtp-Source: AGHT+IFTC5AiPZsL2WCtZ9YUmYQzPfPSbIZd7pGWlek1hN3yyM/LQ79PBILscJ8my/ork79CMUHxmQ==
X-Received: by 2002:ac2:46fb:0:b0:511:79ac:2d78 with SMTP id q27-20020ac246fb000000b0051179ac2d78mr1847074lfo.39.1707609059268;
        Sat, 10 Feb 2024 15:50:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwY9QgQWBv3mqmXEOiAqOyF2ZXgQZL51x6zCMlF3rA9kaeIjjxX4WV8W+tU7uU3bK3T5QCGqKacFR6Lm4Y1KMiFafq8X+P692nGbcsnH1T7UbAyvneXsakqxDZqrZ5NRtjIHKz1VzLdyaNeo0nLtRShcG3xVyA4goGGXDYrO/kSwxOtuC6CJkX4Lph08GFRxvjG9KttQPGgGKCO18y1paBNOTam+SHnNkmAW+SROUQdx9yJ7Ab5sGbJgRyFP0bJN9x7OuYvYVK+KYdxBu7SRqSQpRl9n5ys8w9Ya3p7eQit0LQnmwVO+tcmWv+bFZ/6Y3szDethzuM4aD0YsctshLo5S7hen9Z6CzM6uzkrJ0p9tgFAs86c8nt3edwHXYZcRt/S4ZDrzyoaf53s5SleHYz148Ey0FCfhOOtKnrdVaBSY+mihT/Mhq4n+wNAOYQabilSgdrBng8nPwtVGyoMmvuMrEJ6LvbhaeHBqLNfafV0HdoVFArmHPa7sdplz+uGmFmcblJTey4nbGhPtWjiPVg5styQD5oqn6BE2llt8G7bOZVAMGIvxwpcbbn2ozReyWnTXFXZBSp5kl5WiDduOlymbNrxwZltgRe+LRRnvr+Nk7uSQ==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:58 -0800 (PST)
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
Subject: [PATCH v4 18/39] dyndbg: add label keyword handling
Date: Sun, 11 Feb 2024 00:49:48 +0100
Message-ID: <20240210235009.2405808-19-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

Add a new user_label field to struct ddebug_query, label keyword
handling and saving to the struct, and update ddebug_change to test if
a given user_label is found in the list of known trace-instances.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dbae1ed6ab5b..17df4bf6863a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -61,6 +61,7 @@ struct ddebug_query {
 	const char *function;
 	const char *format;
 	const char *class_string;
+	const char *user_label;
 	unsigned int first_lineno, last_lineno;
 };
 
@@ -300,13 +301,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u class=%s\n",
+	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u class=%s label=%s\n",
 		  msg,
 		  query->function ?: "",
 		  query->filename ?: "",
 		  query->module ?: "",
 		  fmtlen, query->format ?: "",
-		  query->first_lineno, query->last_lineno, query->class_string);
+		  query->first_lineno, query->last_lineno,
+		  query->class_string, query->user_label);
 }
 
 static bool is_dd_trace_cmd(const char *str)
@@ -574,6 +576,16 @@ static int ddebug_change(const struct ddebug_query *query,
 			if (dp->class_id != valid_class)
 				continue;
 
+			/* match against a given label */
+			if (query->user_label) {
+				int idx	= find_tr_instance(query->user_label);
+
+				if (idx < 0)
+					continue;
+				if (idx != get_trace_dst(dp))
+					continue;
+			}
+
 			/* match against the source filename */
 			if (query->filename &&
 			    !match_wildcard(query->filename, dp->filename) &&
@@ -770,6 +782,8 @@ static int check_set(const char **dest, char *src, char *name)
  * file <full-pathname>
  * file <base-filename>
  * module <module-name>
+ * class <class_name>
+ * label <user_label>
  * format <escaped-string-to-find-in-format>
  * line <lineno>
  * line <first-lineno>-<last-lineno> // where either may be empty
@@ -825,6 +839,8 @@ static int ddebug_parse_query(char *words[], int nwords,
 				return -EINVAL;
 		} else if (!strcmp(keyword, "class")) {
 			rc = check_set(&query->class_string, arg, "class");
+		} else if (!strcmp(keyword, "label")) {
+			rc = check_set(&query->user_label, arg, "label");
 		} else {
 			pr_err("unknown keyword \"%s\"\n", keyword);
 			return -EINVAL;
-- 
2.43.0.687.g38aa6559b0-goog


