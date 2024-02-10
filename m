Return-Path: <linux-kernel+bounces-60609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08185850772
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7122C1F2698D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202546313D;
	Sat, 10 Feb 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtyjvORI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A079C63101
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609076; cv=none; b=FXi7MAehCdyZ24ds2CWicRH5GSXe8WWWSDkHBALdoffbJzUHU2oDKAe2HCUGbCGx/N0Ini323cPd/CbPXKSqqAFZobOTJdJmOJzvdK+0YYDZXEubhAqsqa/9jEcrvbyLYndZGvCsrip6LnXLDp85Z1T2RB5yBreew40WOBMngMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609076; c=relaxed/simple;
	bh=Q9a02DWXVcGFESvWK0VJZsN0BHwc8jj3rMZ5PtMrKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD5qSLEMfvVUDv4RWmhjZLFymAtTrV3x6YlRwfuz0TuZB3neiltDzfVlEz8YBisdXd/uBnF3m8Ir8YCx3iRsDsAj/nqh1kafJBo27TWKkjJ14wg9+9bmI9Rgd1KwuddRAEf2vKpNLckSih5HVsJGi5dJAUDzBklC8pYpr3FR3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MtyjvORI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so1840857e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609073; x=1708213873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmuP22pE2p+4QTMWxcu2yqFJ4oYEpoJdJHaC6boMHYo=;
        b=MtyjvORIqM841/h/dJwlHtto/2wJkB/UbXh+voayItWdH2zaDzjRlBaE5Ia1EMYmUf
         oLLVewGMVOpw2ZI1N5IHl9zCAk7PJnpLetVJfco6t+nQVzXKQrLcZNPe+4cXtckcfagv
         Mzd7BTfl1qTUEaacv0E1ryjV9Bbcylc+ohlTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609073; x=1708213873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmuP22pE2p+4QTMWxcu2yqFJ4oYEpoJdJHaC6boMHYo=;
        b=t/LwbYRKTz7R9+3zxeOR7WEcQBvzN/YAcMoWVwEDf18btlBGbG09IFAhbXTBgU7P/w
         uGHlDQ8kKhd8uJCdedqnJjBGOykVJJODu+E7NgZsVk6Ux8Sax/ohtHVQvpVEq6+zOufU
         kP+Pe4gUnS1RWqgI4RLEyMxe15Njj9W7qvNnXXrnC5udv4wL/KjWw0v6Yh1KKGx7wK3n
         I7SrXteZD+HTPiICkil4zdTVRYOTHWnbrCHMzaAsCRS35eI2IL2tONGkOGzDv62jlVGs
         EvAGTxvYqqoLRMLUjZ4BfhKuYZGZ0fyUaO2JMUCfhqArHjGEq1ywdwEpcU/5jIT/8HXh
         70Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWT37yv7Xgn4LE1Cgcx9K/LCxwUDIdzaYULZLR7dm9hI+PHg39G8Nx51IkHGVVcNBjPy8w6AS5j5Fciq+tKb1vXF8bt/21G7eUf8OVM
X-Gm-Message-State: AOJu0YxKgo8o5CmNMuxd4FBkm14+jN8fGhjY3dGO3Srx4vxgXmmAMcrb
	XHueah2UdlKZYN6FADWNkQFCbv1EKDlYHBM1/sL9Rw5P1E/hiEc6PWcBBGdf
X-Google-Smtp-Source: AGHT+IEKmYOtY5vVlW28e/0N48Z/ssNsaeGAzFn3UKtGDCW365SqNgxuHBcFDh1N3+n3xzfO/wvl7w==
X-Received: by 2002:a19:ee0d:0:b0:511:6158:498c with SMTP id g13-20020a19ee0d000000b005116158498cmr1743792lfb.64.1707609072918;
        Sat, 10 Feb 2024 15:51:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdcCf9GIrQOCWCgWqiXFAhcblouycJxj7aTC07HVzNWnvPjVO6yFPsJdSQtUxtjl++i798B5luFdzW6wqNB2ajAOmv8v4ltPx+Nm1y4jLq5preWH49bk+Kw5I1klfo0l7DXmyT2FnncIFwxOdPWrcWNYM25xKsxg1pbYWqJ8KkLEn/EhSkiwxnJwimHdjQymqPeUqpH3hPWyRlBa3JSBAfdg75P9pdhL3E/kvuE8h3QCf4QjmlJJg6gmxof357Rs2H7THPGH5OoWDq6HnZcLPwMOfa6wCRUSfDpVgvSzlDHVP/8/816fP848mLPNoodIQcFeisvHsbG6B9gi7wJwopBIAlmRvu1+i3XHQIzse4YlnuioUxCIque7IvXxorIyIgd0jc+rV3Q1ZQJS5nhwE+R12XhNgC87f/rml7yB2rDdSc2hX8Z/aqMa/shegt6tGRJi54A3NZGq++ScvZZq+qrT2ngGajMmLuD+1x6YrHlYwN7EnM0a/q1zsomTLJv3mBWNqGyVf3qZj1AbFQ3fssjIdpD7n2wAsQhou64AS8JkTWx4CXK2dz1lk2+VLEM3IPIL7Q55MOzhxv7/5YB8FA7u4Yed7CFZt0ap6RQD9Gtua0Bw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:12 -0800 (PST)
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
Subject: [PATCH v4 26/39] dyndbg: warn if no flags are given
Date: Sun, 11 Feb 2024 00:49:56 +0100
Message-ID: <20240210235009.2405808-27-ukaszb@chromium.org>
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

Since [1,2], ``cat control`` has displayed callsites without flags as
``=_``, to positively assert that no flags are set.

It also took that as input, and the docs also tried to encourage its
use, allowing users to expressly assert that all flags are unset by
this operation:

  alias ddcmd='echo $* > /proc/dynamic_debug/control'

  ddcmd =_	# assert no-flags
  ddcmd =	# allowed, grandfathered

Now, warn on the latter.  This allows to disambiguate the meaning of
the :<label> extension:

  ddcmd =	# if this is dis-allowed,
  ddcmd =_	# then this is required to unset all

This positive assertion *allows* the grammar to specify both/either
flags and a :<label> independently and unambiguously:

  ddcmd =_:foo	# unset all flags, set the foo label
  ddcmd =:foo	# (only) set the foo label, since no flags are given.

The semantics of setting a label: callsite.dest=map[N], differ
slightly from setting the boolean flags; both ``+=`` op-flags set a
label.

And then the meaning of ``-:foo`` can be decided; either dest=0, or
dest=map[N] (just like ``+=``).  I prefer latter, since former can be
seen as turning off only foo, which is the label keyword's job.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d8cd40faeb4d..3a9dd73357c8 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -884,6 +884,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 {
 	read_flag_args_f read_args;
 	int op, i;
+	char *fst;
 
 	switch (*str) {
 	case '+':
@@ -896,7 +897,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		return -EINVAL;
 	}
 
-	for (; *str ; ++str) {
+	for (fst = (char *)str; *str ; ++str, fst++) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
 			if (*str == opt_array[i].opt_char) {
 				modifiers->flags |= opt_array[i].flag;
@@ -917,6 +918,9 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
+	/* warn if no flags/labels are given */
+	if (!(str - fst))
+		pr_err("no flags or label is specified, please use _ to assert no-flags\n");
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
-- 
2.43.0.687.g38aa6559b0-goog


