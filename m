Return-Path: <linux-kernel+bounces-60610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FF850773
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D18288CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C163401;
	Sat, 10 Feb 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eqhNZer5"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7796312D
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609078; cv=none; b=LgEyEA20mt2ISI6tcR/Gth5IEChdt8OE4vJOkvT4xVqdbEi28Y5VtLcgU9KOWBW0Wk/fdjXx4aFWu5JctbdXguz4SmxFIfBEMmymCUomIVwTC6CZxeJ5/I6u/jZjRTNcU48Aw3O4JO1RLA7gqAP5bHiEpErzLEcTidQyug7o4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609078; c=relaxed/simple;
	bh=ZB+FsAPYmP8H5O8a3zI66BfrcjceVaBRS/yttZ0LCLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZaURm2D4wuBABiftpW/SZum6qsp0/eVQJT2AU7dir4NVOoFHxgDEfGOholElsdDBv4E+30a+7tUz/Z19YH0I0fgV7MyiJUQ7SfKNAvTx4CbiQTmDsd4kQoWYInpVWT+nfKCcER7Li2YxxnC7yEtjcuctApQBVPe4XDkEewWuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eqhNZer5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso27598001fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609074; x=1708213874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/QPsfiKl+NIFvJq0tRUFCbliV/AFcpTw5F1qSkWT6c=;
        b=eqhNZer5jeyj1otK2A1a2XMiwEkiUD2Mb+OCt43siHEXKZzqbhxgdY7SOsoPrNQy3u
         U1kdVq05ji2Stx4i5p4lsjmSJ9/40X3bBo6GqikQlEhnvfAoR9NqCfY0CD0WH0xQwnzS
         UKZa2pfe43fx4syVBucPQ66Lt/7GS333fLp3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609074; x=1708213874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/QPsfiKl+NIFvJq0tRUFCbliV/AFcpTw5F1qSkWT6c=;
        b=AQyu2OLeKcnoUSgVxQSgv5+8HlkIVdCS54Db/CL59HuqEm9kXb+mELLqUGh5RSczzf
         73hntq+yuQuFGQLTEgkMgcoskRNwRlKPpuubTTo5+iCimCWyPHMD6QfrM92AUUNHVQy0
         ZLtVQXJZWAHBz2ZAZj9pyavpTf9ZPeUoJqOgLQUYJscOvnVZ3Dap2QnK2VFULmQ8l46O
         RW6TAjQafFBZyQYfrVtpfhmA4Sywl2+78BGqqvhf8aQgP/ihwnU7hfsdOvN/EvkWHEMO
         u1COXUrZgsKxmEbilcaTSbsLhbpNF7nYwlCUhDHMH+nJekiwPkosOGbXI5OGUbgluIMH
         OQbA==
X-Gm-Message-State: AOJu0YwCbgRoFW3kjsrp9Ek3FB6ZkH3JqQimy1sWWh2lqiCBFxselVmd
	zMnIYatpe3nqC74h3wMqMseqTFzOBFOtM6O5ROaMnJ48jTRhTDFEbEHivhmN
X-Google-Smtp-Source: AGHT+IHCo+XWA8dYnhXpfSAHc2B5Kkh2Cl2nTmawG5ifUV9Ki6TJxmhgqXYo43gNQr6z+ue4dGPLug==
X-Received: by 2002:a05:6512:12c2:b0:511:758f:4d5c with SMTP id p2-20020a05651212c200b00511758f4d5cmr2050429lfg.21.1707609074530;
        Sat, 10 Feb 2024 15:51:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBBkU5VUFSX+1UUCuTQVAwUYSvNu1OjmCz5AwOiEnYzzh5PjojIVR9UwUccyNYsjwu7BiBQc7bU7I7rzqf9fsWFgTxwXtuaq+tP70mDNwMXOU/phM7y+vlhJNn8Y09Igo3GuKP/npWrPkcJreShGbX8ecwYNiHyHhaTL2S6Ad7NZHmtfTMA+ELF37D0doq5Ew/0qewLhlKPzgcVUTWYWemgf2gJhODLQM1Mo5js2wpv0ikBCC1EMjpkxWen6Ngq3CUCNA3ODxH3+JCdvHL/S1iCXbdrLdIG3XdRQceToRfUgeKBosESbYjamj9MjA/zRWSSV1R9M9/DAiD9t8sjzQWciS0nEtxIo0bWwdE7dy7KINjcVyYfzX2w4sJfccLfP5bJmmAV4PYenYEcHE/1HIZ+2yMqweXimS5dBhTJrbGDKoO8lEH8hHC/et84mzOGhvSVcqKPos7bLtvtQBRaHOikylGJMYJ5X7TLlsfYMAKAA7iQvKtEa+gfqM2QDmwStLDlkNqMfJwAz2aTlaQOIMNyO9HMKaggzdFvJZHo41Mh8SM2QFJ6W54GQ0JX9Q1+oOq9h3qclegWFzZIiB7Zoi5/bEgLoTL7DqMHeiJ2q/Uo/jseg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:14 -0800 (PST)
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
Subject: [PATCH v4 27/39] dyndbg: update "ddcmd =:foo" behavior
Date: Sun, 11 Feb 2024 00:49:57 +0100
Message-ID: <20240210235009.2405808-28-ukaszb@chromium.org>
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

Previously the following commands were equivalent

      ddcmd =_:foo
      ddcmd =:foo

and both unset all flags and set foo label.

This patch modifies the behavior of the command

      ddcmd =:foo

to set (only) the foo label and preserve the flags.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3a9dd73357c8..7723bb7dfc46 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -882,6 +882,7 @@ static int ddebug_parse_query(char *words[], int nwords,
  */
 static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
+	bool explicit_no_flags = !strchr(str, '_') ? false : true;
 	read_flag_args_f read_args;
 	int op, i;
 	char *fst;
@@ -927,6 +928,14 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 	case '=':
 		/* modifiers->flags already set */
 		modifiers->mask = 0;
+
+		/*
+		 * cover the case where "ddcmd =:foo" sets (only)
+		 * the foo label, since no flags are given
+		 */
+		if (!explicit_no_flags && !modifiers->flags &&
+		    modifiers->trace_dst != DST_NOT_SET)
+			modifiers->mask = ~0U;
 		break;
 	case '+':
 		modifiers->mask = ~0U;
-- 
2.43.0.687.g38aa6559b0-goog


