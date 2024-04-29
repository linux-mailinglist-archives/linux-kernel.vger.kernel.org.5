Return-Path: <linux-kernel+bounces-162934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3A8B6260
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6301F249D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797B14D2BC;
	Mon, 29 Apr 2024 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIyrL+9E"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4C146D70;
	Mon, 29 Apr 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419161; cv=none; b=fweaK7+6GzESCZHSSeeoYDGM1hsNMBpm72iFXslWhJLK9WXIl1v82I8kx1p2Vc3cEExFKUc6bJdYnAdr8ivYsya4a8/HXEZfXjLM3lPxxWM8zaO8evINarVcA0t3Znp5WvXX8yKb+UaRSG+jr2r9zZRlhobjji6CPG6d5uwmf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419161; c=relaxed/simple;
	bh=BajpZ5nliXd+HrVvKA2TL+65LWIHmhnw26BZ8As/d0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3N/J1nHuys4YUsi+7cnS2Ejr1nHTrCJkJVZRg3kreFibn2CrXL0qS/LSEO6InUF5eeKz7A6L70GnWAMlY3yBbfYyG+79Nj2VUUBDyb+glV6gpJcVLE+BHbLF9D+fKuvSZbofy0VbyjbbUgHG+DH7mp33ktf4iRmiYN6SzJuXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIyrL+9E; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7decd9851dfso75317439f.3;
        Mon, 29 Apr 2024 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419159; x=1715023959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OThLtlQLHmt6Xu/dLjE7jt3V84uDU3HgUSM9F2dF2XI=;
        b=YIyrL+9EV+3vTtGJD3wmR0Pi1PGCHlNeQD91B3v8K+3lRayqoZKojZ7CZR04LBNKAW
         VF2pebbP7vmj/poSrreBQ6ahi7RWEqNvv6WgYZPADU+LJ1KBafKTkvsHcwN0OA082+Ux
         RNHGdqrZ/l8tD63gPWOiBwJZj7E01nLKr7BecMEsas84sWMWv87mQCJV9n4u4UCHAQ16
         lZa1ftKxZa+u79ds2WzpYLQ9IirSh2A+E+rKocZgM0kHglRkWwdtB9IFNeg/gs0R2IVC
         pbn5p38Pelm2c8TO4FI0iDn9QUX2DR5hXIHYRTB4JRV7pZp463mTFcfypDJdUIItiQRw
         iLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419159; x=1715023959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OThLtlQLHmt6Xu/dLjE7jt3V84uDU3HgUSM9F2dF2XI=;
        b=umy+Tg5Qxzzcsca1LV319TU5aF2Ey+O608Jjfz1QwSvUN4FLuH3ddb6hdKZoc0eSuU
         /j7a+TGOigtdfay4x7UM/M4JsvDx68rVgQSMIDusMtoVJSHFF2QhqXfy46wxq+QDCQzl
         TOJWWfXWoY7UWlf1jgt0qdTvVhQOaUH+xV4Z96nP4zYQbSbPSGvr3nalcGwXd8rVcSf8
         ojwNgEhfa1pQtmLExIucS31E5J1BKD4GU53kUtYxk8Il43DXz4ifewGyUTuwkcFfprQe
         jsi+c6e6nDjfrXODsJt/3pxGaklo/CPSuo9ZyIOibW7C671w3hW6YMoSI2EmO6lFK5zf
         eq8w==
X-Forwarded-Encrypted: i=1; AJvYcCX0jjlbEtML90lr8yIsxU18OJ3l/sweTh2dFbReTJGSIDYiOzMFdUndi09t5dFX90mNKxujs6VrOS4DiSiO743JzehFT6bNy5l3eOwM4HY4uWJhdQsUkVrHR8Npm8oe91Ao+IKUPVnX
X-Gm-Message-State: AOJu0YxwC3qYk4kXf7DozpC7eW190KB4Cud++qka1rk+13HMgw1gs6JW
	TsOfmw05y81ctk5pYtHcLx6vS8VnlYKm/Zc8TxTR2BU/w4hYlFCr
X-Google-Smtp-Source: AGHT+IHgblQU2XTGAf0Eayg4FlLzB3xPXagAcjM9qSnZz48ZH/Uw5+5PWqitVmSs5xwWAIoFf2KeRA==
X-Received: by 2002:a6b:510c:0:b0:7de:d078:16a4 with SMTP id f12-20020a6b510c000000b007ded07816a4mr3684490iob.0.1714419159322;
        Mon, 29 Apr 2024 12:32:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 21/35] dyndbg: treat comma as a token separator
Date: Mon, 29 Apr 2024 13:31:31 -0600
Message-ID: <20240429193145.66543-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Treat comma as a token terminator, just like a space.  This allows a
user to avoid quoting hassles when spaces are otherwise needed:

 :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

or as a boot arg:

 drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here

Given the many ways a boot-line +args can be assembled and then passed
in/down/around shell based tools, this may allow side-stepping all
sorts of quoting hassles thru those layers.

existing query format:

 modprobe test_dynamic_debug dyndbg="class D2_CORE +p"

new format:

 modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 31fd67597928..c1bc728cb050 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -290,6 +290,14 @@ static int ddebug_change(const struct ddebug_query *query,
 	return nfound;
 }
 
+static char *skip_spaces_and_commas(const char *str)
+{
+	str = skip_spaces(str);
+	while (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -303,8 +311,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 	while (*buf) {
 		char *end;
 
-		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		/* Skip leading whitespace and comma */
+		buf = skip_spaces_and_commas(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -320,7 +328,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 				return -EINVAL;	/* unclosed quote */
 			}
 		} else {
-			for (end = buf; *end && !isspace(*end); end++)
+			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
 				;
 			if (end == buf) {
 				pr_err("parse err after word:%d=%s\n", nwords,
@@ -592,7 +600,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = skip_spaces_and_commas(query);
+
 		if (!query || !*query || *query == '#')
 			continue;
 
-- 
2.44.0


