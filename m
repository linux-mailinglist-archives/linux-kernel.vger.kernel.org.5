Return-Path: <linux-kernel+bounces-60603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEA85076C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C7B1F25628
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EE627E5;
	Sat, 10 Feb 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgtEEfJY"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CE62177
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609066; cv=none; b=KIKPHb9xZyDsrqE4UUaSHUKEN9bWq50ysdurwA6nHQrXKwXhHwzPRO0kiK3ru7cx8uBkLoypIDR4vdEdHePpDjwJ6uCyTKm6Qg6iVAgCyq80j6GZsK0itJhexKK1QpnMHpxog5LbL6avpR53yDAyPovyIq18X2lHmyn04Ge+P/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609066; c=relaxed/simple;
	bh=KhSOeCx7N/HjioQXr6VqOtlhnK8h3fsvUF59nf4Ak+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzvXtESRefTS31Vxl2Og/WVD+dL38kHtOPpcCiWjhRpvHUwmNKOuF5iThLWxDnojAiF2iI5TNPQrt0HIA4hOLe2sXrWEY3JR4LD0fDu1B55qZDtPAA0Nqin3yZCfXJg3Fx8q412y1YGiQf8pvVxACRxc14KxCw9gcfxAprHaGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JgtEEfJY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0e2adfeefso14518731fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609063; x=1708213863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2saDJqjVn0V5IZnXz4myO9Pbq5U3qhHJ6QVZDbJVX0=;
        b=JgtEEfJYtRFkoEjycFdphx86txP+uvU4CJ0Ksb/8JyVirt6rS03cSfN6nSA4zwWpsP
         bzmE+z0ZY18ZjohBQKqNscGIq/6FJ3KjDewQE/snzxKmp5P6SmLsPx9lrQvUlrcZJLVt
         LwuA9QQNFwM+IX5WG7YAcW1lecomXgKGnn+7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609063; x=1708213863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2saDJqjVn0V5IZnXz4myO9Pbq5U3qhHJ6QVZDbJVX0=;
        b=Cp1osaH3zuVqjKuFvIXio9qp8gMqRvw9ohzi5NUipy2g5oaY0j8ROe9TF0C4GltXLP
         QA/U0qZHakRIV4U7JROOvEeynFZBBNMAGr74QBQCKsifoe98DannqcvN9zdUOUwSgHC3
         COhM9187t1JYK2cWVEDvBUQ2LCa7U6AKdL9dAsyzNIvHbo7LqjXSQg5F/tQvK6EJGYQo
         lwJ0McPGGmABiCZn/O/I/KRgkSKfAMGZXz8fybbh8VYr8p2iaKGuMUQGhTk+6y3LDAE6
         9G+LNwG86E8W5PaO1JHDjGbQvY9c5HxxxXGbQ6icKbtRfMO1f4gtU2UZRdRTDTkAwJym
         uxEA==
X-Gm-Message-State: AOJu0YzYPaCoUgN+2mGpKBW+PxRVp8ukc3fpyis7t/b0hLDZIF7iN5qn
	TFfq/swUafWjxffWHBisuos/RnTxB7619gsdNzxmyA/FiuO/H/fntIWBA76X
X-Google-Smtp-Source: AGHT+IEQNRYkkCNExLXB0eu/24eo6TVeOdEpedwiNYrfjcjHuMPRst89/1X1Qv7vMt7SYdlMDvzE0Q==
X-Received: by 2002:ac2:482e:0:b0:511:5411:1144 with SMTP id 14-20020ac2482e000000b0051154111144mr1786082lft.14.1707609063219;
        Sat, 10 Feb 2024 15:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX++7P2W3N6FZzJcKeOJnOS15wNbWMLQrLZgBmpkFjbPCzYsjHvgareXCm8sqvzowGcAFjyy+PlVoI1IzTzX9tqQYvEEz+mt6aK/5sbhKvp19Z2eezssNY/tXOkhYLE5xOPkH3WOJ7Hkp+79WWx7w0mQvQlDvmjBV7ENmwLLccICJVGIhqICd4FjPTUEOa4nDhYT8RR7aP7nVI7LjDtmBAphSaKvwTH16m58s6zl11Q6Qg59dJExOK2Myw/oHfP1XgesQ4E8CCDrMjhEI/CLIbzSwdHdx6swy6WdXtqS7QVhPpzHKlTbPJrKI1LYWyfKPcNTi4n9DckbcLxEbD5Npv0Gxpwz2RVHHNHcKTy+BPPreF0bJrnz3gJPQ3di53KeflmYqWQZdtRUmGGeh9zSPNXPtyd0wN8AQ7DxCRQlo7HEU/wP2bvSyKMnWLmx4t4BanahyIxt+fWB1AOQZj6q4FAUixGk9Wdb6AkuiCWhum6clLK5l8XpGPQbqpR6dfnVLaeoj+OMoH3IoukDiPl4VKag3T+aB0lM/sdacWdqNM7Z0s2ki4qoZ6tVbVaQ+INTOZvy+95HplmJ3Vw6OgSTfEWnfwymnvpByR7QumgVkhinaFODw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:02 -0800 (PST)
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
Subject: [PATCH v4 20/39] dyndbg: treat comma as a token separator
Date: Sun, 11 Feb 2024 00:49:50 +0100
Message-ID: <20240210235009.2405808-21-ukaszb@chromium.org>
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

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

 drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the myriad ways a boot-line can be assembled and then passed
in/down/around shell based tools, if the >control parser treats commas
like spacees, this would allow side-stepping all sorts of quoting
hassles thru those layers.

This change apart from existing query format:

 modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

introduces new format:

 modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 20bfb6de2404..78b06a617918 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -650,6 +650,14 @@ static int ddebug_change(const struct ddebug_query *query,
 	return nfound;
 }
 
+static char *skip_spaces_and_comma(const char *str)
+{
+	str = skip_spaces(str);
+	if (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -663,12 +671,16 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_comma(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
 			break;	/* token starts comment, skip rest of line */
+		if (*buf == ',') {
+			buf++;
+			continue;
+		}
 
 		/* find `end' of word, whitespace separated or quoted */
 		if (*buf == '"' || *buf == '\'') {
@@ -680,7 +692,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -993,7 +1005,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_comma(query);
 		if (!query || !*query || *query == '#')
 			continue;
 
-- 
2.43.0.687.g38aa6559b0-goog


